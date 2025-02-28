<?php
session_start();
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

class Login
{
    function login($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);
        $sqlAdmin = "SELECT * FROM `admin` WHERE username = :username AND password = :password";
        $stmtAdmin = $conn->prepare($sqlAdmin);
        $stmtAdmin->bindParam(':username', $json['username']);
        $stmtAdmin->bindParam(':password', $json['password']);
        $stmtAdmin->execute();
        $adminResult = $stmtAdmin->fetch(PDO::FETCH_ASSOC);
        if ($adminResult) {
            $adminResult['role'] = 'admin';
            unset($conn);
            unset($stmtAdmin);
            return json_encode($adminResult);
        }
        $sqlSA = "SELECT * FROM `student_assistant` WHERE username = :username AND password = :password";
        $stmtSA = $conn->prepare($sqlSA);
        $stmtSA->bindParam(':username', $json['username']);
        $stmtSA->bindParam(':password', $json['password']);
        $stmtSA->execute();
        $saResult = $stmtSA->fetch(PDO::FETCH_ASSOC);
        if ($saResult) {
            $saResult['role'] = 'student-assistant';
            unset($conn);
            unset($stmtSA);
            return json_encode($saResult);
        }
        unset($conn);
        return json_encode([
            "status" => "error",
            "message" => "Invalid username or password"
        ]);
    }

    // function login($json)
    // {
    //     include 'connection.php';
    //     $json = json_decode($json, true);
    //     $sqlAdmin = "SELECT * FROM `admin` WHERE username = :username AND password = :password";
    //     $stmtAdmin = $conn->prepare($sqlAdmin);
    //     $stmtAdmin->bindParam(':username', $json['username']);
    //     $stmtAdmin->bindParam(':password', $json['password']);
    //     $stmtAdmin->execute();
    //     $adminResult = $stmtAdmin->fetch(PDO::FETCH_ASSOC);
    //     if ($adminResult) {
    //         session_regenerate_id(true);
    //         $_SESSION['user_id'] = $adminResult['admin_id'];
    //         $_SESSION['role'] = 'admin';

    //         unset($conn);
    //         unset($stmtAdmin);
    //         return json_encode(["status" => "success", "role" => "admin"]);
    //     }
    //     $sqlSA = "SELECT * FROM `student_assistant` WHERE username = :username AND password = :password";
    //     $stmtSA = $conn->prepare($sqlSA);
    //     $stmtSA->bindParam(':username', $json['username']);
    //     $stmtSA->bindParam(':password', $json['password']);
    //     $stmtSA->execute();
    //     $saResult = $stmtSA->fetch(PDO::FETCH_ASSOC);
    //     if ($saResult) {
    //         session_regenerate_id(true);
    //         $_SESSION['user_id'] = $saResult['sa_id'];
    //         $_SESSION['role'] = 'student-assistant';

    //         unset($conn);
    //         unset($stmtSA);
    //         return json_encode(["status" => "success", "role" => "student-assistant"]);
    //     }
    //     unset($conn);
    //     return json_encode([
    //         "status" => "error",
    //         "message" => "Invalid username or password"
    //     ]);
    // }

    function logout()
    {
        session_unset();
        session_destroy();
        return json_encode(["status" => "success", "message" => "Logged out successfully"]);
    }

    function checkSession()
    {
        if (isset($_SESSION['user_id']) && isset($_SESSION['role'])) {
            return json_encode([
                "status" => "success",
                "user_id" => session_id(),
                "role" => $_SESSION['role']
            ]);
        } else {
            return json_encode(["status" => "error", "message" => "No active session"]);
        }
    }
}


if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $operation = $_GET['operation'];
    $json = $_GET['json'];
} else if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $operation = $_POST['operation'];
    $json = $_POST['json'];
}

$login = new Login();
switch ($operation) {
    case "login":
        echo $login->login($json);
        break;
    case "logout":
        echo $login->logout();
        break;
    case "checkSession":
        echo $login->checkSession();
        break;
    default:
        echo json_encode(["status" => "error", "message" => "Invalid operation"]);
        break;
}
