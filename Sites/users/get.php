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

// if a name parameter is given, search 
// for that user, else we will return 
// the entire list of users
if (array_key_exists("name", $_GET)) {
	$query .= "WHERE user_name=";
	$query .= "'{$_GET["name"]}' ";
}

$result = mysqli_query($db, $query);

if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// add all users to an array
$users = array();
while ($user = mysqli_fetch_assoc($result)) {
	array_push($users, $user);
}

// then output that as json data
echo json_encode($users);

// close the connection with the database
mysqli_free_result($result);
mysqli_close($db);

?>
