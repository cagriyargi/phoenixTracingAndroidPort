<?php
include 'conn.php';

$userid=$_POST['user_id'];

if($connect -> connect_error){
    die("baglanti yok".$connect->connect_error);
}
$sql = "SELECT * FROM `help_requests` WHERE user_id='".$userid."'";
$result = $connect -> query($sql);
$response = array();
    if($result->num_rows>0){
        while($row = $result->fetch_assoc()){
            array_push($response,$row);
        }
    }
$connect->close();
echo json_encode($response);


?>