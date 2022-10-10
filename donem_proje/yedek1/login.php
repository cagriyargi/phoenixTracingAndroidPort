<?php

include 'conn.php';

if($_POST){

$mail = $_POST['mail'];
$password = $_POST['password'];

$consult = $connect -> query("SELECT * FROM users WHERE mail = '".$mail."' and password ='".$password."'");

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