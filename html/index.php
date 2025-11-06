<?php
echo "<h1>WEB 2 (VM3 - Docker) is Running!</h1>";

$host = "192.168.10.98"; // VM4 Master DB IP
$user = "root"; 
$pass = "centos";
$db = "soldesk_db";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("<p style='color:red;'>Connection failed: " . $conn->connect_error . "</p>");
} 

echo "<p style='color:green;'>Successfully connected to MariaDB Master (VM4)!</p>";

$result = $conn->query("SELECT id, name FROM test_table WHERE id=1");

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "ID: " . $row["id"]. " - Name: " . $row["name"]. "<br>";
    }
} else {
    echo "0 results in test_table";
}

$conn->close();
phpinfo();
?>
