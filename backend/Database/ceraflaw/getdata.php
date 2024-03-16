<?php
// Allow requests from all origins
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Database configuration
$servername = "localhost"; // Change this to your MySQL server hostname
$username = "root"; // Change this to your MySQL username
$password = ""; // Change this to your MySQL password
$database = "CeramicTile"; // Change this to your MySQL database name

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to fetch data from the table
$sql = "SELECT * FROM Table1"; // Change this to your table name
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Fetch data from the result set
    $data = array();
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    // Encode the data as JSON and output
    echo json_encode($data);
} else {
    echo "0 results";
}
$conn->close();
?>
