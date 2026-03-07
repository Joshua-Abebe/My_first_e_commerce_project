<?php

session_start();

require_once("config/db_connect.php");
include("includes/auth_check.php");

if (!isset($_POST['id_product'])) {
    header("Location: cart.php");
    exit;
}

$id_order  = $_SESSION['id_order'];
$id_product = intval($_POST['id_product']);  // FIX: sanitize input
$quantity   = intval($_POST['quantity']);     // FIX: sanitize input

// Check if product is available in inventory
$sql_check = "SELECT id_product, id_warehouse, quantity  -- FIX: missing comma after id_warehouse
              FROM inventory
              WHERE id_product = $id_product";

$check_result = mysqli_query($conn, $sql_check);  // FIX: missing $conn parameter

$stock_found = false;

while ($row = mysqli_fetch_assoc($check_result)) {
    $inventory_quantity = $row['quantity'];
    $id_warehouse       = $row['id_warehouse'];

    if ($inventory_quantity > 1) {
        // Update order item quantity
        $sql_update_order = "UPDATE order_item         -- FIX: 'UPDATE TABLE' is invalid SQL
                             SET quantity = quantity + 1
                             WHERE id_order = $id_order AND id_product = $id_product";

        // Decrease inventory
        $sql_update_inventory = "UPDATE inventory      -- FIX: 'UPDATE TABLE' is invalid SQL
                                 SET quantity = quantity - 1
                                 WHERE id_product = $id_product AND id_warehouse = $id_warehouse";

        mysqli_query($conn, $sql_update_order);        // FIX: missing $conn
        mysqli_query($conn, $sql_update_inventory);    // FIX: missing $conn

        $stock_found = true;
        break;

    } elseif ($inventory_quantity == 1) {   // FIX: was '= 1' (assignment) instead of '== 1' (comparison)

        // Update order item quantity
        $sql_update_order = "UPDATE order_item         -- FIX: 'UPDATE TABLE' is invalid SQL
                             SET quantity = quantity + 1
                             WHERE id_order = $id_order AND id_product = $id_product";

        // Remove depleted inventory row
        $sql_delete_inventory = "DELETE FROM inventory -- FIX: 'ALTER TABLE DELETE' is invalid SQL
                                 WHERE id_product = $id_product AND id_warehouse = $id_warehouse";
                                 // FIX: also had an unclosed quote on id_warehouse string

        mysqli_query($conn, $sql_update_order);        // FIX: missing $conn
        mysqli_query($conn, $sql_delete_inventory);    // FIX: missing $conn

        $stock_found = true;
        break;

    } else {
        // inventory_quantity = 0, try next warehouse
        continue;
    }
}

if (!$stock_found) {
    // FIX: echo before header, and moved outside loop so it only triggers after all rows checked
    $_SESSION['error'] = "No available stock in the inventory";
}

header("Location: cart.php");
exit;
?>