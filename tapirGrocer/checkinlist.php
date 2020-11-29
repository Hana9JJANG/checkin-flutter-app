<?php
include 'conn.php';

$ownerID = $_POST['ownerID'];
$queryResult=$connect->query("SELECT * FROM tb_checkin WHERE ownerID = '".$ownerID."'") or die($connect->error);
$result=array();

while($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);
?>

