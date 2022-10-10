<?php
include 'conn.php';
if($_POST){

$username = $_POST['username'];
$password = $_POST['password'];
$userrid = $_POST['userid'];

$consult = $connect -> query("UPDATE user SET username = '$username', password ='$password' WHERE id=".$userrid."");

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