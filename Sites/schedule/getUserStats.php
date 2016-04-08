<?php

require_once 'HTTP/Request2.php';

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

// now that we have the table name, output all the data as json
$query = "SELECT * FROM {$schedule_table}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with error: " . mysqli_error($db));
}

$game_stats = array(
	"wins" => 0,
	"loses" => 0,
	"draws" => 0
);

// fetch all the results inta an array
while ($game = mysqli_fetch_assoc($result)) {
	$inGame = False;
	$usersScore = 0;
	$otherScore = 0;

	// was the user in this game?
	if ($game["user_id_0"] == $_GET["user"]) {
		$inGame = True;
		$usersScore = $game["score_0"];
		$otherScore = $game["score_1"];
	} else if ($game["user_id_1"] == $_GET["user"]) {
		$inGame = True;
		$usersScore = $game["score_1"];
		$otherScore = $game["score_0"];
	}

	// count the wins and loses
	if ($inGame) {
		if ($usersScore < $otherScore) {
			$game_stats["loses"]++;
		} else if ($usersScore > $otherScore) {
			$game_stats["wins"]++;
		} else {
			$game_stats["draws"]++;
		}
	}
}

// pull the ranking and total score information from our
// 'getScoresForLeague' call
$addr = "http://localhost/schedule/getScoresForLeague.php?league={$_GET["league"]}";

$request = new HTTP_Request2($addr);
$url = $request->getUrl();

$request->setMethod(HTTP_Request2::METHOD_GET);
$request->setBody("{body}");

// RHEL will not behave without this
// Mac OS X will not behave with this
// if either is not working it's probably
// this lines fault
// $request->setAdapter('curl');

try {
	// add all the players to the database
	$response = $request->send();
	$json = json_decode($response->getBody(), True);

	$rank = 1;
	foreach ($json as $user => $score) {
		// found the user, output their rank and their score
		if ($user == $_GET["user"]) {
			echo json_encode(
				array(
					"user" => $user,
					"rank" => $rank,
					"score" => $score,
					"wins" => $game_stats["wins"],
					"loses" => $game_stats["loses"],
					"draws" => $game_stats["draws"]
				)
			);

			exit();
		}

		// increment the rank after each user
		$rank++;
	}

} catch (HttpException $e) {
	die("Request failed with error $e");
}

?>
