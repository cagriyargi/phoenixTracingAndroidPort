<?php

include 'conn.php';

$job_id = $_POST['job_id'];
$step_line = $_POST['step_line'];

$consult = $connect -> query("UPDATE `operation_steps` SET done=1 
WHERE job_id='$job_id' AND step_line='$step_line'");


?>