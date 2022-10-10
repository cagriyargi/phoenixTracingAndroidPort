<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "login";

$conn = new mysqli($servername, $username, $password, $dbname);
if($conn -> connect_error){
    die("baglanti yok".$conn->connect_error);
}
$sql = "SELECT * from gorevler";
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