<?php

session_start();

//connection parameters
$host = 'localhost';
$username = 'abc';
$password = 'Hydrogen7777';
$database = 'mydb';

//create connection
$conn = mysqli_connect($host, $username, $password, $database);

//check connection
if (!$conn) {
    die ("Connection error: " . mysqli_connect_error());
}

//set character set
mysqli_set_charset($conn, "utf8");

?>
