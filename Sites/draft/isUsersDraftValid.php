<?php

// A valid draft requires the following:
//	1 Quarter Back		- QB
//	2 Running Backs		- RB
//	3 Wide Receivers	- WR
//	1 Tight End			- TE
//	1 Kicker			- K
//	5 Defensive	Players	- DL
//	
// and up to 6 benched players.

header("Content-Type: application/json");

// connect to the CS309 database
$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connection failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

// we need the league to check for and the user whos team we wish to validate
if (!array_key_exists("league", $_GET) || !array_key_exists("user", $_GET)) {
	die("'league' and 'user' parameters required");
}

// get the name of the draft table
$query  = "SELECT name FROM leagues WHERE id={$_GET["league"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
$draft_table = $league["name"] . "_draft";

// grab all the users players from the draft table
$query = "SELECT * FROM {$draft_table}";
$query .= " WHERE user_id={$_GET["user"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with error: " . mysqli_error($db));
}

// build an array of the current draft for this user
$draft = array();
while ($player = mysqli_fetch_assoc($result)) {
	array_push($draft, $player);
}

// next we must validate the user meets the requirements for a draft
$required = array(
	"QB" => 1,
	"RB" => 2,
	"WR" => 3,
	"TE" => 1,
	"K" => 1,
	"DL" => 5,
	"BENCH" => 6
);

$remaining = $required;
foreach ($draft as $player) {
	$isOnBench = $player["on_bench"];

	if ($isOnBench == 0) {
		// player is active, decrement their associated index
		$key = $player["pos"];
		$remaining[$key]--;
	} else {
		// player is not currently active, decrement the bench counter
		$remaining["BENCH"]--;
	}
}

// the sum of each array key should be exactly 6
// this exculdes the players bench, as they may
// have as many players on their bench as they want
$sum = 0;
foreach ($remaining as $key => $val) {
	// exclude the bench
	if (strcmp($key, "BENCH") != 0) {
		$sum += $val;
	}
}

echo json_encode(
	array(
		// only valid when every available slot is filled
		"error" => False,
		"valid" => ($sum == 0),
		"remaining" => $remaining,
		"required" => $required
	)
);

mysqli_close($db);

?>
