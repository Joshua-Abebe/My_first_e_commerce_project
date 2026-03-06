<?php

session_start();

require_once "config/db_connect.php";

include "includes/header.php";

$sql = "SELECT 
            product.id_product,
            product.name,
            product.made_in,
            product.price,
            SUM(inventory.quantity) AS stock
        FROM product
        JOIN inventory 
        ON product.id_product = inventory.id_product
        GROUP BY product.id_product";

$result = mysqli_query($conn, $sql);

?>

<h2>Products</h2>

<table border="1">

<tr>
    <th>Name</th>
    <th>Made In</th>
    <th>Price</th>
    <th>Stock</th>
    <th>Action</th>
</tr>

<?php

while ($row = mysqli_fetch_assoc($result)) {

?>

<tr>

<td><?php echo $row['name']; ?></td>

<td><?php echo $row['made_in']; ?></td>

<td><?php echo $row['price']; ?></td>

<td><?php echo $row['stock']; ?></td>

<td>

<form method="POST" action="add_to_cart.php">

<input type="hidden" name="id_product" value="<?php echo $row['id_product']; ?>">

<input type="number" name="quantity" value="1" min="1">

<input type="submit" value="Add to Cart">

</form>

</td>

</tr>

<?php

}

?>

</table>

<?php

include "includes/footer.php";

?>