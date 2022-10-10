<?php
include 'conn.php';

$job_id = $_POST['job_id'];


$consult = $connect -> query("SELECT * FROM `operation_steps` WHERE job_id='".$job_id."'");


$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);



?>