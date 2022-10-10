<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
//$connect->set_charset("utf8mb4");

$requestid = $_POST['request_id'];
//$requestid=2;

$consult = $connect -> query("SELECT * FROM `periodic_steps` WHERE job_id='".$requestid."'");

//$consult = $connect -> query("SELECT * FROM users");

$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);



?>