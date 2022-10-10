<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");

$job_id = $_POST['job_id'];


$consult = $connect -> query("SELECT * FROM `operation_steps` WHERE job_id='".$job_id."'");


$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);



?>