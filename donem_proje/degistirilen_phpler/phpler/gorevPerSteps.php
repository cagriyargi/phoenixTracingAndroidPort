<?php

include 'conn.php';

$requestid = $_POST['request_id'];


$consult = $connect -> query("SELECT * FROM `periodic_steps` WHERE job_id='".$requestid."'");

$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);



?>