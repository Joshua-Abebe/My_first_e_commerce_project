<?php 

//include database connection
include ('config/db_connect.php');

//verify if user is logged in
if (!isset($_SESSION['id_customer'])) {
    header ("Location: login.php");
    exit;
}

//validate input
if(!isset($_POST['id_product'])) {
    header ("Location: products.php");
    exit;
}

$id_product = intval($_POST['id_product']);
$id_order = $_SESSION['active_order_id'];

/*get current product price
$sql_price = "SELECT price  FROM product  WHERE id_product = $id_product  LIMIT 1";
$result_price = mysqli_query($conn, $sql_price);

if (mysqli_num_rows($result_price) != 1) {
    header ("Location: products.php");
    exit;
}

$row_price = mysqli_fetch_assoc($result_price);
$current_price = $row_price['price'];*/

//check if product already exist in the cart
$sql_check = "SELECT quantity  
              FROM order_item  
              WHERE id_product = $id_product AND id_order = $id_order  
              LIMIT 1";
$result_check = mysqli_query($conn, $sql_check);

if (mysqli_num_rows($result_check) == 1) {
    //increase quantity
    $sql_update = "UPDATE TABLE order_item
                   SET quantity = quantity + 1
                   WHERE id_product = $id_product AND id_order = $id_order";
    mysqli_query($conn, $sql_update);

} else {
    //insert new row
    $sql_insert = "INSERT INTO order_item (id_product, id_order, quantity, unit_price_at_purchase)
                          VALUE ($id_product, $id_order, 1)";
    mysqli_query($conn, $sql_insert);
}

header ("Location: cart.php");
exit;

?>