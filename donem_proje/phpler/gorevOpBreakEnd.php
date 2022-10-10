<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
//$connect->set_charset("utf8mb4");

$job_id = $_POST['job_id'];

$consult = $connect -> query("UPDATE `operation_job_breaks` SET break_end=CURRENT_TIMESTAMP(), 
total_break_time=TIMESTAMPDIFF(SECOND,break_start,break_end) WHERE job_id='".$job_id."' and break_end='0000-00-00 00:00:00'");

//$consult = $connect -> query("SELECT * FROM users");

//$result = array();

//while ($extractdata = $consult -> fetch_assoc()){
    //$result[] = $extractdata;
//}

//echo json_encode($result);



?>