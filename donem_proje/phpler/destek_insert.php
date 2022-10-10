<?php
$connect = new mysqli("94.73.149.62","SamedZZZZ","samed1234","phoenixtracing");
if($_POST){
    
    $user_id = $_POST['user_id'];
    $destination_user_id = $_POST['destination_user_id'];
    $name = $_POST['name'];
    $detail = $_POST['detail'];

    $consult = $connect -> query("INSERT INTO `help_requests` (`request_id`, `user_id`, `destination_users`, `name`, `detail`, `status_id`, `active`) VALUES (NULL, '$user_id', '.$destination_user_id.', '$name', '$detail', '1', '1'); ");
    }
?>