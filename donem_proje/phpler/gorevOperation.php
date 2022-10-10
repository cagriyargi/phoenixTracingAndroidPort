<?php
//$connect = new mysqli("94.73.149.62","CagriYargi","cagri1234","login");


$host = "94.73.149.62";
$dbname = "phoenixtracing";
$username = "SamedZZZZ";
$password = "samed1234";
$connect = new mysqli($host, $username, $password, $dbname);
//$connect->set_charset("utf8");

$user_id = $_POST['user_id'];
//WHERE technician_id='".$user_id."' -- where technician_id=3

if(!$connect){
    echo "Veritabanına bağlanamadı";
}
$consult = $connect -> query("SELECT * FROM `operation_jobs` WHERE technician_id='".$user_id."'");
$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);

?>