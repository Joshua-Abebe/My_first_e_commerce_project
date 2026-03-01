<?php 

//include database connection
include ('config/db_connect.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $phone_number = mysqli_real_escape_string($conn, $_POST['phone_number']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    //check if customer exists
    $check_sql = "SELECT id_customer FROM customer WHERE contact_email = $email  LIMIT 1";
    $check_result = mysqli_query($conn, $check_result);
    if (mysqli_num_rows($check_result) > 0) {
        echo "Email already registered";
    } else {
        //insert new customer
        $insert_sql = "INSERT INTO customer (name, contact_phone_number, contact_email, password)
                            VALUE ('$name', '$phone_number', '$email', '$password')";

        if (mysqli_query($conn, $insert_sql)){

            $new_customer_id = mysqli_insert_id($conn);

            //create intial 'CART' order
            $cart_sql = "INSERT INTO `order`(id_customer, total_price, status)
                                VALUE ({'$new_customer_id', 0, 'CART')";
            mysqli_query($conn, $cart_sql);

            $new_order_id = mysqli_insert_id($conn);

            //set session
            $_SESSION['name'] = $name;
            $_SESSION['id_customer'] = $new_customer_id;
            $_SESSION['active_order_id'] = $new_order_id;

            //automatic page redirection to products page
            header ("Location: products.php");
            exit;
        } else {
            echo "Registration f*****";
        }

        

    }

}

?>

<hr>Register</hr>

<form method="POST">
    Name: <input type="text" name="name" required><br>
    Phone number: <input type="text" name="phone_number" required><br>
    Email: <input type="email" name="email" required><br>
    Password: <input type="password" name="password" required><br>
    <input type="submit" value="Register">
</form>

