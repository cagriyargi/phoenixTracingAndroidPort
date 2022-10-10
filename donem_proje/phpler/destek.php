<?php
//$connect = new mysqli("94.73.149.62","CagriYargi","cagri1234","login");
//$connect->set_charset("utf8");
$host = "94.73.149.62";
$dbname = "phoenixtracing";
$username = "SamedZZZZ";
$password = "samed1234";
$connect = new mysqli($host, $username, $password, $dbname);


if(!$connect){
    echo "Veritabanına bağlanamadı";
}
$consult = $connect -> query("SELECT * FROM user_types");
$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);

?>