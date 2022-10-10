<?php

include 'conn.php';

$job_id = $_POST['job_id'];

$consult = $connect -> query("SELECT * FROM `periodic_job_breaks` where job_id = '".$job_id."' and break_end='0000-00-00 00:00:00'");

$result = array();

while ($extractdata = $consult -> fetch_assoc()){
   $result[] = $extractdata;
}

echo json_encode($result);

?>
