<?php
include 'conn.php';

if(!$connect){
    echo "Veritabanına bağlanamadı";
}
$consult = $connect -> query("SELECT * FROM user_types");
$result = array();

while ($extractdata = $consult -> fetch_assoc()){
    $result[] = $extractdata;
}

echo json_encode($result);

?>