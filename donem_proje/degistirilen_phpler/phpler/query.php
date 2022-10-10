<?php

include 'conn.php';

if($_POST){

$userid = $_POST['id'];

$consult = $connect -> query("SELECT * FROM gorevler WHERE gorev_calisan ='".$userid."'");

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