<?php
//op_request -> status_id=4(bitti),active=0(aktif değil artık)
//op_jobs ->end_date=CURRENT_TIMESTAMP(), total_work_time=TIMESTAMPDIFF(SECOND,start_date,end_date), status_id=4,active=0
//bs,be timestamp--tbtvarchar--enddate 0000-00-00 00:00:00 -- toworktme 00:00:00
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
//$connect->set_charset("utf8mb4");

$job_id = $_POST['request_id'];
$step_line = $_POST['step_line'];
$step_code= $_POST['step_code'];

//$_POST['job_id'] $job_id = $_POST['request_id'];$_POST['step_line'];'".$job_id."''".$step_line."'"

$consult = $connect -> query("UPDATE `periodic_steps` SET done=1 
WHERE step_code='".$step_code."' AND step_line='".$step_line."' AND request_id='".$job_id."'");

//$consult2 = $connect -> query("UPDATE `operation_jobs` SET end_date=CURRENT_TIMESTAMP(), 
//total_work_time=TIMESTAMPDIFF(SECOND,start_date,end_date),status_id=4,active=0 WHERE request_id='".$job_id."'");

//$consult = $connect -> query("SELECT * FROM users");

//$result = array();

//while ($extractdata = $consult -> fetch_assoc()){
    //$result[] = $extractdata;
//}

//echo json_encode($result);



?>