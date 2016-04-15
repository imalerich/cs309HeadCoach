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

// this call requirs that a 'to' and 'from' id are present,
// these represent the user id's of the users that are involved
// in this chat
if (!array_key_exists("to", $_GET) || !array_key_exists("from", $_GET) ||
		!array_key_exists("msg", $_GET)) {
	die("'to', 'from', & 'msg' parameters are required");
}

if ($_GET["to"] == $_GET["from"]) {
	echo json_encode(
		array(
			"error" => True
		)
	);
}

$time_stamp = time();

$query  = "INSERT INTO messages (";
$query .= "to_id, from_id, time_stamp, msg";
$query .= ") VALUES (";
$query .= "{$_GET["to"]}, {$_GET["from"]}, {$time_stamp}, \"{$_GET["msg"]}\"";
$query .= ")";

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
