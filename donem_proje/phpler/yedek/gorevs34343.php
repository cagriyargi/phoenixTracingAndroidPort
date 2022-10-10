<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "login";

$userid=$_POST['userid'];

$conn = new mysqli($servername, $username, $password, $dbname);

if($conn -> connect_error){
    die("baglanti yok".$conn->connect_error);
}
$sql = "SELECT * from gorevler WHERE gorev_calisan=".$userid." AND gorev_yap=0";
$result = $conn -> query($sql);
$response = array();
    if($result->num_rows>0){
        while($row = $result->fetch_assoc()){
            array_push($response,$row);
        }
    }
$conn->close();
header('Content-Type: application/json');
echo json_encode($response);


?>