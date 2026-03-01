<?php

//include database connection
include ('config/db_connect.php');

echo '<nav>';
if (isset($_SESSION['id_customer'])) {
    echo "<a href=\"produts.php\">Products</a> | ";
    echo "<a href=\"cart.php\">Cart</a> | ";
    echo "<a href=\"logout.php\">Logout</a>";
} else {
    echo "<a href=\"login.php\">Login</a> | ";
    echo "<a href=\"register.php\">Register</a>";
}
echo "</nav><hr>";

?>
