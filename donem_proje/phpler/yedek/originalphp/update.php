<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "login";

$gorevid=$_POST['gorevid'];
$userid=$_POST['userid'];

$conn = new mysqli($servername, $username, $password, $dbname);

if($conn -> connect_error){
    die("baglanti yok".$conn->connect_error);
}
$sql = "UPDATE gorevler SET gorev_yap=1, gorev_bit=CURRENT_TIMESTAMP(), sure_saat=TIMESTAMPDIFF(HOUR,gorev_tarih,gorev_bit), sure_gunu=TIMESTAMPDIFF(DAY,gorev_tarih,gorev_bit) WHERE gorev_calisan=".$userid." AND gorev_id=".$gorevid."";
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