<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
//$connect->set_charset("utf8mb4");

$job_id = $_POST['job_id'];

//INSERT INTO `operation_job_breaks` (break_id, job_id, break_start, break_end, total_break_time) VALUES (1, 1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), NULL)

$connect -> query("INSERT INTO `operation_job_breaks` (`break_id`, `job_id`, `break_start`, `break_end`, `total_break_time`) VALUES (NULL, '$job_id', CURRENT_TIMESTAMP(), '', '')");


?>