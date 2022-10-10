<?php
$servername = "94.73.149.62";
$username = "SamedZZZZ";
$password = "samed1234";
$dbname = "phoenixtracing";

$userid=$_POST['user_id'];
$active=1;


$conn = new mysqli($servername, $username, $password, $dbname);

if($conn -> connect_error){
    die("baglanti yok".$conn->connect_error);
}
$sql = "SELECT * FROM `help_requests` WHERE user_id='".$userid."' and active='".$active."'";
$result = $conn -> query($sql);
$response = array();
    if($result->num_rows>0){
        while($row = $result->fetch_assoc()){
            array_push($response,$row);
        }
    }
$conn->close();
//header('Content-Type: application/json');
echo json_encode($response);


?>