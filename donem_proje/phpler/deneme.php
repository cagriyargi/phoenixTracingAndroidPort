<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
//$connect->set_charset("utf8mb4");

$consult = $connect -> query("SELECT * FROM `periodic_steps`");

//$consult = $connect -> query("SELECT * FROM users");

$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);



?>