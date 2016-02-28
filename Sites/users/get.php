<?php

header("Content-Type: application/json");

// connect to the CS309 database
$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connection failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

// query the database for all users
$query  = "SELECT * ";
$query .= "FROM users ";

// can only search for a single parameter at a given time
if (array_key_exists("name", $_GET)) {
	$query .= "WHERE user_name=";
	$query .= "'{$_GET["name"]}' ";
} else {
	die("'name' arugment required");
}

// add all users to an array
$user = array();
$result = mysqli_query($db, $query);

if ($result) {
	$user = mysqli_fetch_assoc($result);
} else {
	die("Database query failed with errer: " . mysqli_error($db));
}

// then output that as json data
echo json_encode($user);

// close the connection with the database
mysqli_free_result($result);
mysqli_close($db);

?>
