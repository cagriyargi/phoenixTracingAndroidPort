<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "login";


$conn = new mysqli($servername, $username, $password, $dbname);

if($_POST['userid']){
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
}
elseif($_POST['useryap'] AND $_POST['gorevid']){
    if($conn -> connect_error){
        die("baglanti yok".$conn->connect_error);
    }
    $sql = "UPDATE gorevler SET gorev_yap=1 WHERE gorev_calisan=".$userid." AND gorev_id=".$gorevid."";
    $conn -> query($sql);
    $sql2 ="SELECT * from gorevler WHERE gorev_calisan=".$userid." AND gorev_yap=0";
    $result = $conn -> query($sql2);
    $response = array();
        if($result->num_rows>0){
            while($row = $result->fetch_assoc()){
                array_push($response,$row);
            }
        }
}

$conn->close();
header('Content-Type: application/json');
echo json_encode($response);


?>