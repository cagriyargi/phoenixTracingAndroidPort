<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
//$connect->set_charset("utf8mb4");
if($_POST){
//$_POST

$mail = $_POST['mail'];
$password = $_POST['password'];

$consult = $connect -> query("SELECT * FROM users WHERE mail = '".$mail."' and password ='".$password."'");

//$consult = $connect -> query("SELECT * FROM users");

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