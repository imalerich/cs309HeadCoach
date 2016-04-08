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
// will then be used to determine the name of the schedule table 
// for that league
$query  = "SELECT name FROM leagues WHERE id={$_GET["league"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
$schedule_table = $league["name"] . "_schedule";

// now that we have the table name, output all the data as json
$query = "SELECT * FROM {$schedule_table}";

// the query may be limited to a single users schedule
if (array_key_exists("user", $_GET)) {
	$user = $_GET["user"];
	$query .= " WHERE user_id_0={$user}";
	$query .= " OR user_id_1={$user}";
}

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with error: " . mysqli_error($db));
}

// fetch all the results inta an array
$schedule = array();
while ($game = mysqli_fetch_assoc($result)) {
	array_push($schedule, $game);
}

echo json_encode($schedule);

// and we are done
mysqli_close($db);

?>
