<?php

include 'conn.php';

$job_id = $_POST['job_id'];

$connect -> query("INSERT INTO `periodic_job_breaks` (`break_id`, `job_id`, `break_start`, `break_end`, `total_break_time`) VALUES (NULL, '$job_id', CURRENT_TIMESTAMP(), '', '')");


?>