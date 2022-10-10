<?php

include 'conn.php';

$job_id = $_POST['job_id'];
$userid = $_POST['userid'];

$consult = $connect -> query("SELECT * FROM `operation_jobs` WHERE job_id = '".$job_id."' and technician_id ='".$userid."'");

$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);

?>