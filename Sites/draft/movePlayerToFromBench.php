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

// make sure we have all of the required arguments
if (!array_key_exists("league", $_GET) || !array_key_exists("player", $_GET)
	|| !array_key_exists("state", $_GET)) {
	die("'league' argument is required");
}

// find the name of the league the user wants, this
// will then be used to determine the name of the draft table 
// for that league
$query  = "SELECT name FROM leagues WHERE id={$_GET["league"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
$draft_table = $league["name"] . "_draft";

// update the draft table for this league to the now state
$query = "UPDATE {$draft_table} SET on_bench={$_GET["state"]} WHERE id={$_GET["player"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// finished without error
echo json_encode(
	array(
		"error" => False
	)
);

mysqli_close($db);

?>
