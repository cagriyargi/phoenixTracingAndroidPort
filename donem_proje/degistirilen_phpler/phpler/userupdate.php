<?php

include 'conn.php';

if($_POST){

$user_id = $_POST['user_id'];
$name = $_POST['name'];
$surname = $_POST['surname'];
$mail = $_POST['mail'];
$password = $_POST['password'];
$phone = $_POST['phone'];

$consult = $connect -> query("UPDATE users SET mail='$mail',name='$name',surname='$surname',password='$password',phone='$phone' WHERE user_id=$user_id");

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