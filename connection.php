<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "sa-monitoring";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    // Return a JSON response for the frontend
    echo json_encode(["error" => "Database connection failed. Please check your connection."]);
    exit(); // Stop further execution
}
