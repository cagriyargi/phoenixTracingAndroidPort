<?php
include 'conn.php';

if($_POST){
    
    $user_id = $_POST['user_id'];
    $destination_user_id = $_POST['destination_user_id'];
    $name = $_POST['name'];
    $detail = $_POST['detail'];

    $consult = $connect -> query("INSERT INTO `help_requests` (`request_id`, `user_id`, `destination_users`, `name`, `detail`, `status_id`, `active`) VALUES (NULL, '$user_id', '.$destination_user_id.', '$name', '$detail', '1', '0'); ");
    }
?>