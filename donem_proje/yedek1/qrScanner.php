<?php

include 'conn.php';

$job_id = $_POST['job_id'];
$step_line = $_POST['step_line'];
$step_code= $_POST['step_code'];

$consult = $connect -> query("UPDATE `periodic_steps` SET done=1, done_time=CURRENT_TIMESTAMP() 
WHERE step_code='".$step_code."' AND step_line='".$step_line."' AND job_id='".$job_id."'");

?>