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
if (!array_key_exists("user", $_GET)) {
	die("'to' parameter is required");
}

// query the database for the desired messages
$query  = "SELECT * FROM messages";
$query .= " WHERE to_id={$_GET["user"]}";
$query .= " OR from_id={$_GEt["user"]}";

$result = mysqli_query($db, $query);

// create the return array of messages
// this will be a dictionary where the keys are 
// other user that the input user is interacting with
$messages = array();

while ($msg = mysqli_fetch_assoc($result)) {
	$to = $msg["to_id"];
	$from = $msg["from_id"];
	$other = $to == $_GET["user"] ? $from : $to;

	$messages[$other] = $msg;
}

// we have all of our messages, output the data
// note it is possible for this to be an empty array
echo json_encode($messages);

// We are done, close the connection to the database.
mysqli_close($db);

?>
