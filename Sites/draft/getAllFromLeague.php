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

// make sure the 'league' id is set
if (!array_key_exists("league", $_GET)) {
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

// now that we have the table name, output all the data as json
$query = "SELECT * FROM {$draft_table}";

// the query may be limited to a single users draft
if (array_key_exists("user", $_GET)) {
	$query .= " WHERE user_id={$_GET["user"]}";
}

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// fetch all the results inta an array
$draft = array();
while ($player = mysqli_fetch_assoc($result)) {
	array_push($draft, $player);
}

echo json_encode($draft);

// and we are done
mysqli_close($db);

?>
