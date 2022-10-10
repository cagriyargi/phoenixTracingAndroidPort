<?php
include 'conn.php';
if($_POST){

$username = $_POST['username'];
$destektip = $_POST['destektip'];
$mesaj = $_POST['mesaj'];

$consult = $connect -> query("INSERT INTO `destek` (`username`, `destektip`, `mesaj`) VALUES ('$username', '$destektip', '$mesaj');");

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