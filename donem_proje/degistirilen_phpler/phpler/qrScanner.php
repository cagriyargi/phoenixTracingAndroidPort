<?php

include 'conn.php';

$job_id = $_POST['request_id'];
$step_line = $_POST['step_line'];
$step_code= $_POST['step_code'];

$consult = $connect -> query("UPDATE `periodic_steps` SET done=1 
WHERE step_code='".$step_code."' AND step_line='".$step_line."' AND request_id='".$job_id."'");

?>