<?php

include 'conn.php';

$job_id = $_POST['job_id'];
$req_id = $_POST['request_id'];

$consult = $connect -> query("UPDATE `operation_requests` SET status_id=4 WHERE request_id='".$req_id."'");

$consult2 = $connect -> query("UPDATE `operation_jobs` SET end_date=CURRENT_TIMESTAMP(), 
total_work_time=TIMESTAMPDIFF(SECOND,start_date,end_date),status_id=4 WHERE job_id='".$job_id."'");

?>