<?php

include 'conn.php';

$job_id = $_POST['job_id'];

$consult = $connect -> query("UPDATE `periodic_job_breaks` SET break_end=CURRENT_TIMESTAMP(), 
total_break_time=TIMESTAMPDIFF(SECOND,break_start,break_end) WHERE job_id='".$job_id."' and break_end='0000-00-00 00:00:00'");

?>