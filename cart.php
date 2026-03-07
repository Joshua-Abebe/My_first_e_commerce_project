<?php

session_start();

require_once "config/db_connect.php";

include "includes/auth_check.php";
include "includes/header.php";

$id_order = $_SESSION['id_order'];

$sql = "SELECT
            order_item.id_product,
            product.name,
            order_item.quantity,
            order_item.unit_price_at_purchase,
            (order_item.quantity * order_item.unit_price_at_purchase) AS subtotal
        FROM order_item
        JOIN product
        ON order_item.id_product = product.id_product
        WHERE order_item.id_order = ?";

$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_bind_param($stmt, "i", $id_order);
mysqli_stmt_execute($stmt);

$result = mysqli_stmt_get_result($stmt);

$total = 0;

?>

<h2>Your Cart</h2>

<table border="1">

<tr>
<th>Product</th>
<th>Price</th>
<th>Quantity</th>
<th>Subtotal</th>
<th>Action</th>
</tr>

<?php

while ($row = mysqli_fetch_assoc($result)) {

$total += $row['subtotal'];

?>

<tr>

<td><?php echo $row['name']; ?></td>

<td><?php echo $row['unit_price_at_purchase']; ?></td>

<td>

<form action="update_quantity.php" method="POST">

<input type="hidden" name="id_product" value="<?php echo $row['id_product']; ?>">

<input type="number" name="quantity"
value="<?php echo $row['quantity']; ?>"
min="1">

<input type="submit" value="Update">

</form>

</td>

<td><?php echo $row['subtotal']; ?></td>

<td>

<form action="remove_from_cart.php" method="POST">

<input type="hidden" name="id_product"
value="<?php echo $row['id_product']; ?>">

<input type="submit" value="Remove">

</form>

</td>

</tr>

<?php

}

?>

</table>

<h3>Total: <?php echo $total; ?></h3>

<a href="checkout.php">Proceed to Checkout</a>

<?php include "includes/footer.php"; ?>