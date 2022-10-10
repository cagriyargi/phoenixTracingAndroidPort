<?php

include 'conn.php';

$job_id = $_POST['job_id'];

$consult = $connect -> query("UPDATE `operation_requests` SET status_id=4, 
active=0 WHERE request_id='".$job_id."'");

$consult2 = $connect -> query("UPDATE `operation_jobs` SET end_date=CURRENT_TIMESTAMP(), 
total_work_time=TIMESTAMPDIFF(SECOND,start_date,end_date),status_id=4,active=0 WHERE request_id='".$job_id."'");

?>