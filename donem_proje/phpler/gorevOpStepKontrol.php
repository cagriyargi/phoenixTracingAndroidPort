<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
//$connect->set_charset("utf8mb4");
//select * from `operation_job_breaks` where jobid=$jobid and break_end=NULL;

$job_id = $_POST['job_id'];
//job_id = '".$job_id."' -- $_POST['job_id']

$consult = $connect -> query("SELECT * FROM `operation_steps` where job_id = '".$job_id."' and done='0'");

$result = array();

while ($extractdata = $consult -> fetch_assoc()){
   $result[] = $extractdata;
}

echo json_encode($result);


?>
