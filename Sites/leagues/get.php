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

// make sure we have the 'name' parameter to search with
if (!array_key_exists("name", $_GET)) {
	die("'name' argument is required");
}

$query  = "SELECT * FROM leagues ";
$query .= "WHERE name='{$_GET["name"]}' ";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
echo json_encode($league);

// don't forget to close the database connection
mysqli_close($db);

?>
