<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
//$connect->set_charset("utf8mb4");

$request_id = $_POST['request_id'];
$userid = $_POST['userid'];

$consult = $connect -> query("SELECT * FROM `operation_jobs` WHERE request_id = '".$request_id."' and technician_id ='".$userid."'");

//$consult = $connect -> query("SELECT * FROM users");

$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);



?>