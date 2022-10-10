<?php
$connect = new mysqli("localhost","root","","login");
if($_POST){

$username = $_POST['username'];
$password = $_POST['password'];

$consult = $connect -> query("SELECT * FROM user WHERE username = '".$username."' and password ='".$password."'");

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