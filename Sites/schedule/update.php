<?php

// this call will take in the current date (in a production environment this
// would not be needed) and updates all the scores in each league
// since that league was last updated

require_once 'HTTP/Request2.php';

// connect to the CS309 database
$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connection failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

// this call updates ALL leagues
// so we only need the current week
// which we will update all leagues to
if (!array_key_exists("week", $_GET)) {
	die("'week' parameter is required");
}

function getScoreForUser($user, $league, $week) {
	$addr  = "http://localhost/schedule/getScoreForWeek.php?";
	$addr .= "user={$user}&league={$league["id"]}&week={$week}";
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

		return $json["points"];
	
	} catch (HttpException $e) {
		return 0;
	}
	
	return 0;
}

function updateLeagueForWeek($league, $week, $db) {
	// get each match for this week
	$query = "SELECT * FROM {$league["name"]}_schedule WHERE week={$week}";

	$result = mysqli_query($db, $query);
	if (!$result) {
		die("Database query failed with errer: " . mysqli_error($db));
	}

	while ($match = mysqli_fetch_assoc($result)) {
		$user0 = $match["user_id_0"];
		$user1 = $match["user_id_1"];

		$score0 = getScoreForUser($user0, $league, $week);
		$score1 = getScoreForUser($user1, $league, $week);

		// tell the databse to update the scores
		$query  = "UPDATE {$league["name"]}_schedule";
		$query .= " SET score_0={$score0}, score_1={$score1}, completed=1";
		$query .= " WHERE id={$match["id"]}";

		$tmp = mysqli_query($db, $query);
		if (!$tmp) {
			die("Database query failed with errer: " . mysqli_error($db));
		}
	}
}

function resetLeagueForWeek($league, $week, $db) {
	$query = "SELECT * FROM {$league["name"]}_schedule WHERE week={$week}";

	$result = mysqli_query($db, $query);
	if (!$result) {
		die("Database query failed with errer: " . mysqli_error($db));
	}

	while ($match = mysql_fetch_assoc($result)) {
		$query  = "UPDATE {$league["name"]}_schedule";
		$query .= " SET score_0=0, score_1=0, completed=0";
		$query .= " WHERE id={$match["id"]}";

		$tmp = mysqli_query($db, $query);
		if (!$tmp) {
			die("Database query failed with errer: " . mysqli_error($db));
		}
	}
}

// grab all the leagues that we will loop over
$query = "SELECT * FROM leagues";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$new_week = $_GET["week"];

// update each league
while ($league = mysqli_fetch_assoc($result)) {
	$old_week = date($league["week"]);

	// update each week we missed (ideally this would only ever be 1)
	for ($i = $old_week + 1; $i <= $new_week; $i++) {
		updateLeagueForWeek($league, $i, $db);
	}

	for ($i = $new_week+1; $i<=17; $i++) {
		resetLeagueForWeek($league, $i, $db);
	}
}

// update the week column in each column of the 'leagues' table
$query = "UPDATE leagues SET week=" . $new_week;

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// this call has no return value
// the client is expected to be responsible for
// updating the server (ideally they wouldn't be, but
// I'm just gonna use it for now) but are not expected
// to 'respond' to the update

mysqli_close($db);

?>
