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

// this call requires a league and a user
if (!array_key_exists("league", $_GET) || !array_key_exists("user", $_GET)) {
	die("'league' and 'user' argument is required");
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

// create an array of statistics for each user
// the key will be the users id, and the value
// will be an associated dictionary describing
// the users number of wins, loses, draws,
// and their total score
$user_stats = array();
for ($i = 0; $i < 5; $i++) {
	$key = "member" . $i;
	if ($league[$key] > 0) {
		$user_stats[$league[$key]] = array(
			"score" => 0,
			"wins" => 0,
			"loses" => 0,
			"draws" => 0
		);
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
	// if this game is not yet completed, skip it
	if ($game["completed"] != 1) {
		continue;
	}

	$user0 = $game["user_id_0"];
	$user1 = $game["user_id_1"];

	$score0 = $game["score_0"];
	$score1 = $game["score_1"];

	$user_stats[$user0]["score"] += $score0;
	$user_stats[$user1]["score"] += $score1;

	if ($score1 < $score0) {
		$user_stats[$user0]["wins"]++;
		$user_stats[$user1]["loses"]++;
	} else if ($score1 > $score0) {
		$user_stats[$user0]["loses"]++;
		$user_stats[$user1]["wins"]++;
	} else {
		$user_stats[$user0]["draws"]++;
		$user_stats[$user1]["draws"]++;
	}
}


$rank = 1;
$user = $_GET["user"];
$user_score = $user_stats[$user]["score"];
foreach ($user_stats as $userid => $stats) {
	if ($user_score < $stats["score"]) {
		$rank++;
	}
}

echo json_encode(
	array(
		"user" => intval($user),
		"rank" => $rank,
		"score" => $user_stats[$user]["score"],
		"wins" => $user_stats[$user]["wins"],
		"loses" => $user_stats[$user]["loses"],
		"draws" => $user_stats[$user]["draws"]
	)
);

?>
