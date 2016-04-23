<?php

// Pull a users draft and calculate how many points
// should be awarded to this user for the input week.

header("Content-Type: application/json");

require_once 'HTTP/Request2.php';

// connect to the CS309 database
$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connection failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

if (!array_key_exists("week", $_GET) || !array_key_exists("user", $_GET) 
		|| !array_key_exists("league", $_GET)) {
	die("'week', 'user', and 'league' parameters required");
}

$week = $_GET["week"];
$points = 0;

// we need a list of all the players in the users draft,
// but only those who are valid.
$query = "SELECT name FROM leagues WHERE id={$_GET["league"]}";
$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
$draft_table = $league["name"] . "_draft";

// next, grab all the players from the draft table who are
// 	A) Drafted to the user.
// 	B) Not currently on the bench.
$query = "SELECT * FROM {$draft_table} WHERE user_id={$_GET["user"]} AND on_bench=0";
$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// This defines the actual point calculation system
// used by our service. This will be called for each
// player in a users active draft those totals will
// then be summed to get the users score for this week.
// NOTE: For HeadCoach we are using the following algorithm
// http://www.nfl.com/fantasyfootball/help/nfl-scoringsettings
// from the NFL Fantasy football league, with a few
// minor adjustments.
function get_score_from_stats($stats) {
	if (is_null($stats)) {
		return 0;
	}

	$score = 0;

	// OFFENSE

	if (array_key_exists("PassingYards", $stats)) {
		$score += floor($stats["PassingYards"] / 25);
	}

	if (array_key_exists("PassingTouchdowns", $stats)) {
		$score += floor($stats["PassingTouchdowns"] * 4);
	}

	if (array_key_exists("PassingInterceptions", $stats)) {
		$score += floor($stats["PassingInterceptions"] * -2);
	}

	if (array_key_exists("RushingYards", $stats)) {
		$score += floor($stats["RushingYards"] / 10);
	}

	if (array_key_exists("RushingTouchdowns", $stats)) {
		$score += floor($stats["RushingTouchdowns"] * 6);
	}

	if (array_key_exists("RushingTouchdowns", $stats)) {
		$score += floor($stats["RushingTouchdowns"] * 6);
	}

	if (array_key_exists("FumbleReturnTouchdowns", $stats)) {
		$score += floor($stats["FumbleReturnTouchdowns"] * 6);
	}

	if (array_key_exists("TwoPointConversionPasses", $stats)) {
		$score += floor($stats["TwoPointConversionPasses"] * 2);
	}

	if (array_key_exists("FumblesLost", $stats)) {
		$score += floor($stats["FumblesLost"] * -2);
	}

	// KICKING

	if (array_key_exists("FieldGoalsMade", $stats)) {
		$score += floor($stats["FieldGoalsMade"] * 3);
	}
	
	// DEFENCE

	if (array_key_exists("Sacks", $stats)) {
		$score += floor($stats["Sacks"] * 1);
	}

	if (array_key_exists("Interceptions", $stats)) {
		$score += floor($stats["Interceptions"] * 2);
	}

	if (array_key_exists("FumblesRecovered", $stats)) {
		$score += floor($stats["FumblesRecovered"] * 2);
	}

	if (array_key_exists("Safeties", $stats)) {
		$score += floor($stats["Safeties"] * 2);
	}

	if (array_key_exists("DefensiveTouchdowns", $stats)) {
		$score += floor($stats["DefensiveTouchdowns"] * 6);
	}

	if (array_key_exists("KickReturnTouchdowns", $stats)) {
		$score += floor($stats["KickReturnTouchdowns"] * 2);
	}

	return $score;
}

// For each player, pull the stat's for that player for the
// input week.
while ($player = mysqli_fetch_assoc($result)) {
	$fd_id = $player["fd_id"];

	// pull this players game data for this week
	$req_addr = "https://api.fantasydata.net/nfl/v2/JSON/PlayerGameStatsByPlayerID/2015/{$week}/{$fd_id}";
	$request = new HTTP_Request2($req_addr);
	$url = $request->getUrl();
	
	$headers = array("Ocp-Apim-Subscription-Key" => "fa953b83a78d44a1b054b0afbbdff57e");
	$request->setHeader($headers);
	$request->setMethod(HTTP_Request2::METHOD_GET);
	$request->setBody("{body}");
	
	// RHEL will not behave without this
	// Mac OS X will not behave with this
	// if either is not working it is probably
	// this lines fault
	// $request->setAdapter('curl');
	
	try {
		$response = $request->send();
		$json = json_decode($response->getBody(), True);
		$score = get_score_from_stats($json);

		$points += $score;
	
	} catch (HttpException $e) {
		die("Request failed with error $e");
	}
}

echo json_encode(
	array(
		"error" => False,
		"points" => $points
	)
);

?>
