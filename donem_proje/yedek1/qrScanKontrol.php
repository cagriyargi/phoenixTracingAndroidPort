<?php

include 'conn.php';

if($_POST){

$job_id = $_POST['job_id'];
$step_line = $_POST['step_line'];
$step_code= $_POST['step_code'];

$consult = $connect -> query("SELECT * from `periodic_steps` WHERE step_code='".$step_code."' AND step_line='".$step_line."' AND job_id='".$job_id."'");

$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);

}else{
echo json_encode("HATA");
echo "hiçbir veri post edilmedi";
}

?>