<?php

include 'conn.php';

$user_id = $_POST['user_id'];

if(!$connect){
    echo "Veritabanına bağlanamadı";
}
$consult = $connect -> query("SELECT * FROM `periodic_jobs` WHERE technician_id='".$user_id."' and status_id != 4");
$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);

?>