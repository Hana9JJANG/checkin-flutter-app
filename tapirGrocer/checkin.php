<?php
include 'conn.php';
   
$ownerID = $_POST['ownerID'];
$fname = $_POST['fname'];
$nric = $_POST['nric'];
$bodytemp = $_POST['bodytemp'];
$date = date('Y-m-d H:i:s');
$connect->query ("INSERT INTO tb_checkin (fname, nric, bodytemp, date, ownerID) VALUES ('".$fname."','".$nric."','".$bodytemp."', '".$date."','".$ownerID."' )")

?>

