<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

class Admin
{

    function activityLog($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "INSERT INTO admin_activity_log (admin_id, action) VALUES (:adminId, :action)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':adminId', $json['adminId']);
        $stmt->bindParam(':action', $json['action']);
        $stmt->execute();
        $returnValue = $stmt->rowCount() > 0 ? 1 : 0;
        unset($conn);
        unset($stmt);
        return json_encode($returnValue);
    }

    //for creating/adding new student assistant
    function createSaAccount($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);

        try {
            $username = $json['studentId']; // Student ID as username
            $password = strtolower($json['lastname']); // Lowercase lastname as password

            // Check if the username already exists
            $checkSql = "SELECT COUNT(*) FROM student_assistant WHERE username = :username";
            $checkStmt = $conn->prepare($checkSql);
            $checkStmt->bindParam(':username', $username);
            $checkStmt->execute();
            $existingUserCount = $checkStmt->fetchColumn();

            if ($existingUserCount > 0) {
                return json_encode(2); // Username already exists
            }

            // Insert new record
            $sql = "INSERT INTO `student_assistant`(`firstname`, `lastname`, `student_id`, `username`, `password`)";
            $sql .= " VALUES (:firstname, :lastname, :studentId, :username, :password)";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':firstname', $json['firstname']);
            $stmt->bindParam(':lastname', $json['lastname']);
            $stmt->bindParam(':studentId', $json['studentId']);
            $stmt->bindParam(':username', $username);
            $stmt->bindParam(':password', $password);
            $stmt->execute();
            $returnValue = $stmt->rowCount() > 0 ? 1 : 0;

            if ($returnValue === 1) {
                $logData = [
                    'adminId' => $json['adminId'],
                    'action' => 'Added new student assistant: ' . $json['firstname'] . ' ' . $json['lastname']
                ];
                $this->activityLog(json_encode($logData));
            }
        } catch (PDOException $e) {
            error_log("Database Error: " . $e->getMessage());
            $returnValue = 0;
        }
        $stmt = null;
        $checkStmt = null;

        return json_encode($returnValue);
    }

    //for displaying all student assistant and can filter by id
    function displayAllSa($json)
    {
        include 'connection.php';
        if (!isset($conn)) {
            return json_encode(["error" => "Database connection failed"]);
        }
        $json = json_decode($json, true);
        $sql = "SELECT
        student_assistant.sa_id,
        student_assistant.student_id,
        CONCAT(student_assistant.lastname, ', ', student_assistant.firstname) AS sa_fullname,
        IFNULL(GROUP_CONCAT(days.day_name ORDER BY days.day_id SEPARATOR ', '), 'No schedule') AS day_names,
        IFNULL(CONCAT(TIME_FORMAT(sa_duty_schedule.start_time, '%h:%i %p'), ' - ', TIME_FORMAT(sa_duty_schedule.end_time, '%h:%i %p')), 'No time schedule') AS time_schedule,
        IFNULL(CONCAT(duty_hours.required_duty_hours, ' hours'), 'No duty hours') AS required_duty_hours
        FROM student_assistant
        LEFT JOIN sa_duty_schedule ON student_assistant.sa_id = sa_duty_schedule.sa_id
        LEFT JOIN days ON sa_duty_schedule.day_id = days.day_id
        LEFT JOIN duty_hours ON sa_duty_schedule.duty_hours_id = duty_hours.duty_hours_id";
        if (!empty($json['saId'])) {
            $sql .= " WHERE student_assistant.sa_id = :saId";
        }
        $sql .= " GROUP BY student_assistant.sa_id, sa_duty_schedule.start_time, 
                  sa_duty_schedule.end_time, duty_hours.required_duty_hours
                  ORDER BY sa_fullname, sa_duty_schedule.start_time, sa_duty_schedule.end_time";
        try {
            $stmt = $conn->prepare($sql);
            if (!empty($json['saId'])) {
                $stmt->bindParam(':saId', $json['saId']);
            }
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            return json_encode($result);
        } catch (PDOException $e) {
            return json_encode(["error" => "Query execution failed"]);
        }
    }

    //for displaying days
    function displayDays($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);

        try {
            $sql = "SELECT * FROM days ORDER BY day_id";
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            return json_encode(["error" => "Database error: " . $e->getMessage()]);
        } finally {
            unset($conn);
            unset($stmt);
        }

        return json_encode($result);
    }

    //for adding a duty hours
    function addDutyHours($json)
    {
        //{"requiedDutyHours":90}
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "INSERT INTO `duty_hours`(`required_duty_hours`) VALUES (:requiedDutyHours)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':requiedDutyHours', $json['requiedDutyHours']);
        $stmt->execute();
        $returnValue = $stmt->rowCount() > 0 ? 1 : 0;
        if ($returnValue === 1) {
            $logData = [
                'adminId' => $json['adminId'],
                'action' => 'Added new duty hours: ' . $json['requiedDutyHours'] . ' hours'
            ];
            $logResult = $this->activityLog(json_encode($logData));
        }
        unset($conn);
        unset($stmt);
        return json_encode($returnValue);
    }

    //for displaying duty hours
    function displayDutyHours($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "SELECT * FROM `duty_hours`";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        unset($conn);
        unset($stmt);
        return json_encode($result);
    }

    //for assigning student assistant duty schedule
    function assignSaDutySchedule($json)
    {
        // {"saId":5, "dayIds":[1,2,3], "startTime":"08:00:00", "endTime":"17:00:00", "dutyHours":1, "adminId":1}
        include 'connection.php';
        $json = json_decode($json, true);
        // Fetch the full name of the student assistant
        $getSaNameSql = "SELECT firstname, lastname FROM student_assistant WHERE sa_id = :saId";
        $getSaNameStmt = $conn->prepare($getSaNameSql);
        $getSaNameStmt->bindParam(':saId', $json['saId']);
        $getSaNameStmt->execute();
        $saData = $getSaNameStmt->fetch(PDO::FETCH_ASSOC);
        $fullName = $saData['firstname'] . ' ' . $saData['lastname'];
        // Fetch the required duty hours from the duty_hours table
        $getDutyHoursSql = "SELECT required_duty_hours FROM duty_hours WHERE duty_hours_id = :dutyHours";
        $getDutyHoursStmt = $conn->prepare($getDutyHoursSql);
        $getDutyHoursStmt->bindParam(':dutyHours', $json['dutyHours']);
        $getDutyHoursStmt->execute();
        $dutyHoursData = $getDutyHoursStmt->fetch(PDO::FETCH_ASSOC);
        $requiredDutyHours = $dutyHoursData ? $dutyHoursData['required_duty_hours'] : 'Unknown';
        // Prepare the insert statement
        $sql = "INSERT INTO `sa_duty_schedule`(`sa_id`, `day_id`, `start_time`, `end_time`, `duty_hours_id`) 
            VALUES (:saId, :dayId, :startTime, :endTime, :dutyHours)";
        $stmt = $conn->prepare($sql);
        // Loop through the days and insert the duty schedule
        foreach ($json['dayIds'] as $dayId) {
            $stmt->bindParam(':saId', $json['saId']);
            $stmt->bindParam(':dayId', $dayId);
            $stmt->bindParam(':startTime', $json['startTime']);
            $stmt->bindParam(':endTime', $json['endTime']);
            $stmt->bindParam(':dutyHours', $json['dutyHours']);
            $stmt->execute();
        }
        // If the duty schedule is assigned successfully
        $returnValue = $stmt->rowCount() > 0 ? 1 : 0;
        if ($returnValue === 1) {
            // Get the day names for the log
            $getDayNamesSql = "SELECT day_name FROM days WHERE day_id ORDER by day_id IN (" . implode(',', $json['dayIds']) . ")";
            $getDayNamesStmt = $conn->prepare($getDayNamesSql);
            $getDayNamesStmt->execute();
            $dayNames = $getDayNamesStmt->fetchAll(PDO::FETCH_COLUMN);
            // Prepare the log message
            $dayList = implode(", ", $dayNames);
            $logData = [
                'adminId' => $json['adminId'],
                'action' => 'Assigned duty schedule to ' . $fullName . ' on ' . $dayList .
                    ' from ' . date("h:i A", strtotime($json['startTime'])) .
                    ' to ' . date("h:i A", strtotime($json['endTime'])) .
                    ' for ' . $requiredDutyHours . ' hours'
            ];
            $logResult = $this->activityLog(json_encode($logData));
        }
        unset($conn);
        unset($stmt);
        return json_encode($returnValue);
    }

    //for displaying student assistant's time in
    function displaySaTimeIn($json)
    {
        //{"timeInId":15}
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "SELECT 
        tt.track_id,
        sa.sa_id,
        CONCAT(sa.firstname, ' ', sa.lastname) AS sa_fullname,
        CONCAT(TIME_FORMAT(sds.start_time, '%h:%i %p'), ' - ', TIME_FORMAT(sds.end_time, '%h:%i %p')) AS time_schedule,
        TIME_FORMAT(sds.start_time, '%h:%i %p') AS time_start,
        DATE_FORMAT(tt.date, '%M %d, %Y') AS formatted_date,
        d.day_name,
        TIME_FORMAT(tt.time_in, '%h:%i %p') AS time_in,     
        TIME_FORMAT(tt.time_out, '%h:%i %p') AS time_out,  
        tt.approved_status,
        tt.status,
        CONCAT(admin.firstname, ' ', admin.lastname) AS admin_fullname
        FROM time_track tt
        LEFT JOIN student_assistant sa ON tt.sa_id = sa.sa_id
        LEFT JOIN sa_duty_schedule sds ON tt.duty_schedule_id = sds.duty_schedule_id
        LEFT JOIN days d ON sds.day_id = d.day_id
        LEFT JOIN admin ON tt.approved_by = admin.admin_id";
        if (!empty($json['timeInId'])) {
            $sql .= " WHERE tt.track_id = :timeInId";
        }
        $stmt = $conn->prepare($sql);
        if (!empty($json['timeInId'])) {
            $stmt->bindParam(':timeInId', $json['timeInId']);
        }
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        unset($conn);
        unset($stmt);
        return json_encode($result);
    }

    //for time in approval
    function TimeInApprove($json)
    {
        //{"approvedStatus":"Approved", "status":"Present", "adminId":"1", "time_in_id":"1"}
        include 'connection.php';
        $json = json_decode($json, true);
        // Fetch the student assistant details (fullname) for logging
        $getSaNameSql = "SELECT sa_id, CONCAT(firstname, ' ', lastname) AS sa_fullname FROM student_assistant WHERE sa_id IN (SELECT sa_id FROM time_track WHERE track_id = :time_in_id)";
        $getSaNameStmt = $conn->prepare($getSaNameSql);
        $getSaNameStmt->bindParam(':time_in_id', $json['time_in_id']);
        $getSaNameStmt->execute();
        $saData = $getSaNameStmt->fetch(PDO::FETCH_ASSOC);
        // Update the time track record
        $sql = "UPDATE time_track SET approved_status = :approvedStatus, status = :status, approved_by = :adminId WHERE track_id = :time_in_id";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':approvedStatus', $json['approvedStatus']);
        $stmt->bindParam(':status', $json['status']);
        $stmt->bindParam(':adminId', $json['adminId']);
        $stmt->bindParam(':time_in_id', $json['time_in_id']);
        $stmt->execute();
        // Check if the update was successful
        $returnValue = $stmt->rowCount() > 0 ? 1 : 0;
        // If the update is successful, log the action
        if ($returnValue === 1) {
            // Format the log message based on the approved_status
            if ($json['approvedStatus'] === 'Approved') {
                $logData = [
                    'adminId' => $json['adminId'],
                    'action' => 'Time-in for Student Assistant ' . $saData['sa_fullname'] . ' has been Approved. Current Status: ' . $json['status']
                ];
            } elseif ($json['approvedStatus'] === 'Rejected') {
                $logData = [
                    'adminId' => $json['adminId'],
                    'action' => 'Time-in for Student Assistant ' . $saData['sa_fullname'] . ' has been Rejected. Current Status: ' . $json['status']
                ];
            }
            // Log the action
            $logResult = $this->activityLog(json_encode($logData));
        }
        unset($conn);
        unset($stmt);
        return json_encode($returnValue);
    }

    //for displaying student assistant's leave request
    function displaySaLeaveRequest($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "SELECT
        sa_leave_request.leave_id,
        CONCAT(student_assistant.firstname, ' ', student_assistant.lastname) AS sa_fullname,
        sa_leave_request.leave_type,
        sa_leave_request.reason,
        DATE_FORMAT(sa_leave_request.date, '%M %d, %Y') AS formatted_date,
        sa_leave_request.approved_status,
        CONCAT(admin.firstname, ' ', admin.lastname) AS admin_fullname
        FROM sa_leave_request
        LEFT JOIN student_assistant ON sa_leave_request.sa_id = student_assistant.sa_id
        LEFT JOIN admin ON sa_leave_request.approved_by = admin.admin_id";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        unset($conn);
        unset($stmt);
        return json_encode($result);
    }

    //for displaying student assistant's leave request by id
    function displaySaLeaveRequestById($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "SELECT
        sa_leave_request.leave_id,
        CONCAT(student_assistant.firstname, ' ', student_assistant.lastname) AS sa_fullname,
        sa_leave_request.leave_type,
        sa_leave_request.reason,
        DATE_FORMAT(sa_leave_request.date, '%M %d, %Y') AS formatted_date,
        sa_leave_request.approved_status,
        CONCAT(admin.firstname, ' ', admin.lastname) AS admin_fullname
        FROM sa_leave_request
        LEFT JOIN student_assistant ON sa_leave_request.sa_id = student_assistant.sa_id
        LEFT JOIN admin ON sa_leave_request.approved_by = admin.admin_id
        WHERE sa_leave_request.leave_id = :leaveId";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':leaveId', $json['leaveId']);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        unset($conn);
        unset($stmt);
        return json_encode($result);
    }

    //for approving the student assistant's leave request
    function ApprovedLeaveRequest($json)
    {
        //{"approvedStatus":"Approved", "adminId":"1", "leaveId":"1"}
        include 'connection.php';
        $json = json_decode($json, true);

        // Fetch the student assistant details (fullname) for logging
        $getSaNameSql = "SELECT sa_id, CONCAT(firstname, ' ', lastname) AS sa_fullname FROM student_assistant WHERE sa_id IN (SELECT sa_id FROM sa_leave_request WHERE leave_id = :leaveId)";
        $getSaNameStmt = $conn->prepare($getSaNameSql);
        $getSaNameStmt->bindParam(':leaveId', $json['leaveId']);
        $getSaNameStmt->execute();
        $saData = $getSaNameStmt->fetch(PDO::FETCH_ASSOC);

        // Update the leave request record
        $sql = "UPDATE sa_leave_request SET approved_status = :approvedStatus, approved_by = :adminId WHERE leave_id = :leaveId";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':approvedStatus', $json['approvedStatus']);
        $stmt->bindParam(':adminId', $json['adminId']);
        $stmt->bindParam(':leaveId', $json['leaveId']);
        $stmt->execute();

        // Check if the update was successful
        $returnValue = $stmt->rowCount() > 0 ? 1 : 0;

        // If the update is successful, log the action
        if ($returnValue === 1) {
            // Format the log message based on the approved_status
            if ($json['approvedStatus'] === 'Approved') {
                $logData = [
                    'adminId' => $json['adminId'],
                    'action' => 'Leave Request for Student Assistant ' . $saData['sa_fullname'] . ' has been Approved.'
                ];
            } elseif ($json['approvedStatus'] === 'Rejected') {
                $logData = [
                    'adminId' => $json['adminId'],
                    'action' => 'Leave Request for Student Assistant ' . $saData['sa_fullname'] . ' has been Rejected.'
                ];
            }

            // Log the action
            $logResult = $this->activityLog(json_encode($logData));
        }

        unset($conn);
        unset($stmt);
        return json_encode($returnValue);
    }

    function displayActivityLog($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "SELECT 
        admin_activity_log.log_id, 
        admin_activity_log.action, 
        DATE_FORMAT(admin_activity_log.timestamp, '%M %d, %Y %h:%i%p') AS formatted_timestamp, 
        CONCAT(admin.firstname, ' ', admin.lastname) AS admin_name 
        FROM admin_activity_log 
        JOIN admin ON admin_activity_log.admin_id = admin.admin_id
        ORDER BY admin_activity_log.timestamp DESC";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        unset($conn);
        unset($stmt);
        return json_encode($result);
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $operation = $_GET['operation'];
    $json = $_GET['json'];
} else if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $operation = $_POST['operation'];
    $json = $_POST['json'];
}

$admin = new Admin();
switch ($operation) {
    case "createSaAccount":
        echo $admin->createSaAccount($json);
        break;
    case "displayAllSa":
        echo $admin->displayAllSa($json);
        break;
    case "displayDays":
        echo $admin->displayDays($json);
        break;
    case "addDutyHours":
        echo $admin->addDutyHours($json);
        break;
    case "displayDutyHours":
        echo $admin->displayDutyHours($json);
        break;
    case "assignSaDutySchedule":
        echo $admin->assignSaDutySchedule($json);
        break;
    case "displaySaTimeIn":
        echo $admin->displaySaTimeIn($json);
        break;
    case "TimeInApprove":
        echo $admin->TimeInApprove($json);
        break;
    case "displaySaLeaveRequest":
        echo $admin->displaySaLeaveRequest($json);
        break;
    case "displaySaLeaveRequestById":
        echo $admin->displaySaLeaveRequestById($json);
        break;
    case "ApprovedLeaveRequest":
        echo $admin->ApprovedLeaveRequest($json);
        break;
    case "displayActivityLog":
        echo $admin->displayActivityLog($json);
        break;
}
