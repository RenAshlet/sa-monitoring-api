<?php
session_start();
header('Content-Type: application/json');
$allowed_origin = "http://localhost:3000";
header("Access-Control-Allow-Origin: $allowed_origin");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Handle preflight (CORS OPTIONS request)
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

class Login
{

    function login($json)
    {
        include 'connection.php';
        $json = json_decode($json, true);

        // Validate CAPTCHA
        if (!isset($json['captcha_answer']) || !isset($json['num1']) || !isset($json['num2'])) {
            return json_encode(["status" => "error", "message" => "CAPTCHA validation failed"]);
        }

        $correctCaptcha = $json['num1'] + $json['num2'];
        if ((int)$json['captcha_answer'] !== $correctCaptcha) {
            return json_encode(["status" => "error", "message" => "Incorrect CAPTCHA"]);
        }

        $sqlAdmin = "SELECT * FROM `admin` WHERE BINARY username = :username";
        $stmtAdmin = $conn->prepare($sqlAdmin);
        $stmtAdmin->bindParam(':username', $json['username']);
        $stmtAdmin->execute();
        $adminResult = $stmtAdmin->fetch(PDO::FETCH_ASSOC);
        if ($adminResult) {
            if ($adminResult['password'] === $json['password']) {
                $_SESSION['user_id'] = $adminResult['admin_id'];
                $_SESSION['firstname'] = $adminResult['firstname'];
                $_SESSION['lastname'] = $adminResult['lastname'];
                $_SESSION['role'] = 'admin';
                unset($conn);
                unset($stmtAdmin);
                return json_encode(["status" => "success", "role" => "admin"]);
            } else {
                return json_encode(["status" => "error", "message" => "Password is incorrect"]);
            }
        }

        $sqlSA = "SELECT * FROM `student_assistant` WHERE BINARY username = :username";
        $stmtSA = $conn->prepare($sqlSA);
        $stmtSA->bindParam(':username', $json['username']);
        $stmtSA->execute();
        $saResult = $stmtSA->fetch(PDO::FETCH_ASSOC);
        if ($saResult) {
            if ($saResult['password'] === $json['password']) {
                $_SESSION['user_id'] = $saResult['sa_id'];
                $_SESSION['firstname'] = $saResult['firstname'];
                $_SESSION['lastname'] = $saResult['lastname'];
                $_SESSION['role'] = 'student-assistant';

                unset($conn);
                unset($stmtSA);
                return json_encode(["status" => "success", "role" => "student-assistant"]);
            } else {
                return json_encode(["status" => "error", "message" => "Password is incorrect"]);
            }
        }

        unset($conn);
        return json_encode(["status" => "error", "message" => "Username is incorrect"]);
    }

    function checkSession($json)
    {

        $json = json_decode($json, true);
        if (isset($_SESSION['user_id'])  && isset($_SESSION['firstname']) && isset($_SESSION['lastname']) && isset($_SESSION['role'])) {
            $userData = [
                "user_id" => $_SESSION['user_id'],
                "firstname" => $_SESSION['firstname'],
                "lastname" => $_SESSION['lastname'],
                "role" => $_SESSION['role'],
            ];
            return json_encode(["status" => "success", "user" => $userData]);
        } else {
            return json_encode(["status" => "error", "message" => "User not logged in"]);
        }
    }

    function logout()
    {
        session_unset();
        session_destroy();
        return json_encode(["status" => "success", "message" => "Logged out successfully"]);
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
    case "checkSession":
        echo $login->checkSession($json);
        break;
    case "logout":
        echo $login->logout();
        break;
    default:
        echo json_encode(["status" => "error", "message" => "Invalid operation"]);
        break;
}
