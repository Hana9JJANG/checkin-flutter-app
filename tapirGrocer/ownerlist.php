<?php
include 'conn.php';


$queryResult=$connect->query("SELECT * FROM tb_owner") or die($connect->error);
$result=array();

while($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);
?>

