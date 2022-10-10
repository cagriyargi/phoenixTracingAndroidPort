<?php
	header('Content-type: text/html; charset=utf-8');
	echo "benim adım çağrı --- ÖÇŞĞÜİöçşğüi";
	echo "\ndeneme";
	mysql_set_charset('utf8', $conn);
	$conn = new mysqli("localhost","SamedZZZZ","samed1234","phoenixtracing");
	$consult = $conn -> query("SELECT * FROM turkish_test");
	$result = array();
	echo json_encode($result);
    
?> 
  

