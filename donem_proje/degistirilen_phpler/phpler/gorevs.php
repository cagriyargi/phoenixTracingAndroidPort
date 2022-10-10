<?php

include 'conn.php';

$userid=$_POST['userid'];


if($connect -> connect_error){
    die("baglanti yok".$connect->connect_error);
}
$sql = "SELECT * from gorevler WHERE gorev_calisan=".$userid." AND gorev_yap=0";
$result = $connect -> query($sql);
$response = array();
    if($result->num_rows>0){
        while($row = $result->fetch_assoc()){
            array_push($response,$row);
        }
    }
$connect->close();
header('Content-Type: application/json');
echo json_encode($response);


?>