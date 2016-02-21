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

// the caller may optionally filter the results by a given league
$league_id = -1;
if (array_key_exists("league_id", $_GET)) {
	$league_id = $_GET["league_id"];
}

// the caller may also filter to a specific user
// this is only valid if a specific league is provided
$user_id = -1;
if (array_key_exists("user_id", $_GET)) {
	$user_id = $_GET["user_id"];
}

// query the database for all users
$query  = "SELECT user_name, reg_date ";
$query .= "FROM users";

// add all users to an array
$users = array();
$result = mysqli_query($db, $query);
if ($result) {
	while ($user = mysqli_fetch_assoc($result)) {
		array_push($users, $user);
	}

} else {
	die("Database query failed.");
}

// then output that as json data
echo json_encode($users);

// close the connection with the database
mysqli_free_result($result);
mysqli_close($db);

?>
