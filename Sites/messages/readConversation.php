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

// this call only required the user we wish to retrieve messages for
if (!array_key_exists("user0", $_GET) || !array_key_exists("user1", $_GET)) {
	die("'to' parameter is required");
}

// update all entries in the input conversation and set them as read
$query  = "UPDATE messages SET has_read=1";
$query .= " WHERE to_id={$_GET["user0"]}";
$query .= " OR from_id={$_GET["user0"]}";
$query .= " OR to_id={$_GET["user1"]}";
$query .= " OR from_id={$_GET["user1"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with error:" . mysqli_error($db));
}

echo json_encode(
	array(
		"error" => False
	)
);

mysqli_close($db);

?>
