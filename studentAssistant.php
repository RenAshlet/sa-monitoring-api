<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

class StudentAssistant
{

    //for displaying days
    function displayDays($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "SELECT * FROM days ORDER BY day_id";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        unset($conn);
        unset($stmt);
        return json_encode($result);
    }

    //for displaying student assistant's duty schedule
    function displaySaDutySchedule($json)
    {
        //{"saId":1}
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "SELECT 
        sds.duty_schedule_id,
        d.day_id,
        sa.sa_id,
        CONCAT(sa.lastname, ', ', sa.firstname) AS sa_fullname,    
        IFNULL(GROUP_CONCAT(d.day_name ORDER BY d.day_id SEPARATOR ', '), 'No schedule') AS day_names,    
        IFNULL(CONCAT(TIME_FORMAT(sds.start_time, '%h:%i %p'), ' - ', TIME_FORMAT(sds.end_time, '%h:%i %p')), 'No time schedule') AS time_schedule,
        IFNULL(CONCAT(FLOOR(SUM(sds.total_duty_hours)), ' hours, ', ROUND((SUM(sds.total_duty_hours) * 60) % 60), ' minutes'), 'No duty hours') AS total_duty_hours_formatted,
        IFNULL(CONCAT(ROUND(SUM(sds.total_duty_hours), 2), '/', dh.required_duty_hours, ' hours'), '0/No duty hours') AS rendered_vs_required,
        IFNULL(CONCAT(dh.required_duty_hours, ' hours'), 'No duty hours') AS required_duty_hours
        FROM student_assistant sa
        LEFT JOIN sa_duty_schedule sds ON sa.sa_id = sds.sa_id
        LEFT JOIN days d ON sds.day_id = d.day_id
        LEFT JOIN duty_hours dh ON sds.duty_hours_id = dh.duty_hours_id
        WHERE sa.sa_id = :saId
        GROUP BY sa.sa_id, sa.lastname, sa.firstname, sds.duty_schedule_id, dh.required_duty_hours
        ORDER BY sa_fullname, sds.start_time, sds.end_time";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':saId', $json['saId']);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        unset($conn);
        unset($stmt);
        return json_encode($result);
    }

    //for student assistant's time-in
    function SaTimeIn($json)
    {
        // {"saId":"1", "scheduleId":"1"}
        include 'connection.php';
        $json = json_decode($json, true);

        try {
            $checkSql = "SELECT COUNT(*) as count FROM time_track 
                     WHERE sa_id = :saId AND duty_schedule_id = :dutyScheduleId AND date = CURDATE()";
            $checkStmt = $conn->prepare($checkSql);
            $checkStmt->bindParam(':saId', $json['saId']);
            $checkStmt->bindParam(':dutyScheduleId', $json['dutyScheduleId']);
            $checkStmt->execute();
            $result = $checkStmt->fetch(PDO::FETCH_ASSOC);
            if ($result['count'] > 0) {
                unset($conn);
                unset($checkStmt);
                return json_encode(['success' => false, 'message' => 'You have already timed in today.']);
            }

            // If no record exists, allow time-in
            $sql = "INSERT INTO `time_track`(`sa_id`, `duty_schedule_id`, `date`, `time_in`)";
            $sql .= " VALUES (:saId, :dutyScheduleId, CURDATE(), CURTIME())";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':saId', $json['saId']);
            $stmt->bindParam(':dutyScheduleId', $json['dutyScheduleId']);
            $stmt->execute();
            $returnValue = $stmt->rowCount() > 0
                ? ['success' => true, 'message' => 'Time-in successful.']
                : ['success' => false, 'message' => 'Time-in failed, Please try again.'];
            unset($conn);
            unset($stmt);
            return json_encode($returnValue);
        } catch (PDOException $e) {
            unset($conn);
            return json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
        }
    }

    //for displaying student assistant's time-in
    function displaySaTimeInTrack($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "SELECT 
        tt.track_id,
        sa.sa_id,
        CONCAT(sa.firstname, ' ', sa.lastname) AS sa_fullname,
        CONCAT(TIME_FORMAT(sds.start_time, '%h:%i %p'), ' - ', TIME_FORMAT(sds.end_time, '%h:%i %p')) AS time_schedule,
        DATE_FORMAT(tt.date, '%M %d, %Y') AS formatted_date,
        d.day_name,
        TIME_FORMAT(tt.time_in, '%h:%i %p') AS time_in,   
        TIME_FORMAT(tt.time_out, '%h:%i %p') AS time_out,      
        tt.approved_status,
        tt.status,
         COALESCE(CONCAT(admin.firstname, ' ', admin.lastname), 'waiting to be approved') AS admin_fullname
        FROM student_assistant sa
        LEFT JOIN time_track tt ON sa.sa_id = tt.sa_id
        LEFT JOIN sa_duty_schedule sds ON tt.duty_schedule_id = sds.duty_schedule_id
        LEFT JOIN days d ON sds.day_id = d.day_id
        LEFT JOIN admin ON tt.approved_by = admin.admin_id
        WHERE sa.sa_id = :saId";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':saId', $json['saId']);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        unset($conn);
        unset($stmt);
        return json_encode($result);
    }

    //for student assistant's time-out
    function SaTimeOut($json)
    {
        // {"trackId":1}
        include 'connection.php';
        $json = json_decode($json, true);

        try {
            // Check if the user has already timed out for today
            $checkSql = "SELECT COUNT(*) as count FROM time_track 
                         WHERE track_id = :trackId AND time_out IS NOT NULL AND date = CURDATE()";
            $checkStmt = $conn->prepare($checkSql);
            $checkStmt->bindParam(':trackId', $json['trackId']);
            $checkStmt->execute();
            $result = $checkStmt->fetch(PDO::FETCH_ASSOC);

            if ($result['count'] > 0) {
                unset($conn);
                unset($checkStmt);
                return json_encode(['success' => false, 'message' => 'You have already timed out today.']);
            }

            // If no record exists, allow time-out
            $sql = "UPDATE time_track SET time_out = CURTIME() WHERE track_id = :trackId";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':trackId', $json['trackId']);
            $stmt->execute();

            $returnValue = $stmt->rowCount() > 0
                ? ['success' => true, 'message' => 'Time-out successful.']
                : ['success' => false, 'message' => 'Time-out failed, Please try again.'];

            unset($conn);
            unset($stmt);
            return json_encode($returnValue);
        } catch (PDOException $e) {
            unset($conn);
            return json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
        }
    }

    //for student assistant's apply leave
    function SaLeaveRequest($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sql = "INSERT INTO `sa_leave_request`(`sa_id`, `leave_type`, `reason`, `date`)";
        $sql .= " VALUES (:saId, :leaveType, :reason, :date)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':saId', $json['saId']);
        $stmt->bindParam(':leaveType', $json['leaveType']);
        $stmt->bindParam(':reason', $json['reason']);
        $stmt->bindParam(':date', $json['date']);
        $stmt->execute();
        $returnValue = $stmt->rowCount() > 0 ? 1 : 0;
        unset($conn);
        unset($stmt);
        return json_encode($returnValue);
    }

    //for displaying student assistant's leave request
    function displayLeaveRequest($json)
    {
        //{"saId":1, "date":"2025-01-24"}
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
        WHERE student_assistant.sa_id = :saId
        AND sa_leave_request.date = :date";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':saId', $json['saId']);
        $stmt->bindParam(':date', $json['date']);
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

$sassistant = new StudentAssistant();
switch ($operation) {
    case "displayDays":
        echo $sassistant->displayDays($json);
        break;
    case "displaySaDutySchedule":
        echo $sassistant->displaySaDutySchedule($json);
        break;
    case "SaTimeIn":
        echo $sassistant->SaTimeIn($json);
        break;
    case "displaySaTimeInTrack":
        echo $sassistant->displaySaTimeInTrack($json);
        break;
    case "SaTimeOut":
        echo $sassistant->SaTimeOut($json);
        break;
    case "SaLeaveRequest":
        echo $sassistant->SaLeaveRequest($json);
        break;
    case "displayLeaveRequest":
        echo $sassistant->displayLeaveRequest($json);
        break;
}
