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
$query  = "SELECT * FROM leagues WHERE id={$_GET["league"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
$schedule_table = $league["name"] . "_schedule";

// create an array of scores
// the keys will be the users id's
// the values with be the users score
$scores = array();

for ($i = 0; $i < 5; $i++) {
	$member = $league["member" . $i];
	if ($member > 0) {
		$scores[$member] = 0;
	}
}

// now that we have the table name, output all the data as json
$query = "SELECT * FROM {$schedule_table}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with error: " . mysqli_error($db));
}

// fetch all the results inta an array
while ($game = mysqli_fetch_assoc($result)) {
	// each user must be a member of the given league
	// there we can use them as keys to our scores array
	$scores[$game["user_id_0"]] += $game["score_0"];
	$scores[$game["user_id_1"]] += $game["score_1"];
}

// sorts total scores from high to low
// while maintaining key, value association
arsort($scores);

// output the scores, the ordering will be the
// current league ranking, the keys will be each
// user id, and the score will be the total score
// for the user

echo json_encode($scores);

// and we are done
mysqli_close($db);

?>
