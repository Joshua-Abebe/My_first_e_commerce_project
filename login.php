<?php

// include database connection 
include ('config/db_connect.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    $sql = "SELECT id_customer, name  FROM customer  WHERE contact_email =  $email AND password = $password  LIMIT 1";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) == 1) {
        $rows = mysqli_fetch_assoc($result);
        $_SESSION['id_customer'] = $rows['id_customer'];
        $_SESSION['name'] = $rows['name'];
        
        //check for active cart
        $sql_cart = "SELECT *  FROM order  WHERE status = CART AND id_customer = {$rows['id_customer']}  LIMIT 1" ;
        $cart_result = mysqli_query($conn, $sql_cart);
// CODE NEEDS ATTENTION, LINE 26, BECAUSE THE SESSION PART IN WRITTEN IN THE PARETHESIS
        if(mysqli_num_rows($cart_result) == 1) {
            $cart = mysqli_fetch_assoc($cart_result);
            $_SESSION['active_order_id'] = $cart['id_order'];
        } else {
            //create new cart order
            $sql_new_cart = "INSERT INTO  order(id_customer, total_price, status)
                           VALUE ({$row['id_customer']}, 0, 'CART')"; 
            mysqli_query($conn, $sql_new_cart);
            $_SESSION['active_order_id'] = mysqli_insert_id($conn);
        }

        header("Location: products.php");
        exit;
    }
} else {
    echo "Invalid login!";
}

?>


<form method="POST">
    Email: <input type="email" name="email" required><br>
    Password: <input type="password" name="password" required><br>
    <input type="submit" value="Login">
</form>