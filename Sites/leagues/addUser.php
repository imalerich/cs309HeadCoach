<?php

$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connetion failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

header("Content-Type: application/json");

// we need the leage to add the user to
if (!array_key_exists("league", $_GET)) {
	die("'league' id required");
}

// we also need the user id to add to the league
if (!array_key_exists("user", $_GET)) {
	die("'user' id required");
}

// removes all schedule times that are greater than the
// current week, we will regenerate the schedule
// to include the current user
function resetFutureSchedules($league, $db) {
	$query  = "DELETE FROM {$league["name"]}_schedule ";
	$query .= "WHERE week>{$league["week"]}";

	$result = mysqli_query($db, $query);

	if (!$result) {
		die("Database query failed with errer: " . mysqli_error($db));
	}
}

// adds a week of matches to the input leagues
// schedule table
function generateScheduleForWeek($league, $week, $db) {
	// construct the active members array
	$members = array();
	for ($i=0; $i<5; $i++) {
		if ($league["member" . $i] > 0) {
			array_push($members, $league["member" . $i]);
		}
	}

	// using a simple random assignment for this weeks matches
	shuffle($members);

	// their will be a game for each set of two players
	for ($i = 0; $i < floor(count($members)/2); $i++) {
		$user0 = $members[$i * 2];
		$user1 = $members[$i * 2 + 1];

		// update the schedule database with the new data
		$query  = "INSERT INTO {$league["name"]}_schedule";
		$query .= " (user_id_0, user_id_1, score_0, score_1, week, completed)";
		$query .= " VALUES ";
		$query .= " ({$user0}, {$user1}, 0, 0, {$week}, 0) ";

		$result = mysqli_query($db, $query);

		if (!$result) {
			die("Database query failed with errer: " . mysqli_error($db));
		}
	}
}

// removes the old schedule (starting from the current week)
// then generates a new schedule for each remaining week
// left in the season
function updateSchedule($league, $db) {
	resetFutureSchedules($league, $db);

	for ($i = $league["week"] + 1; $i <= 17; $i++) {
		generateScheduleForWeek($league, $i, $db);
	}
}

// first make sure that the user exists
// we will not allow non existent users to join a league
$query  = "SELECT * FROM users WHERE id='{$_GET["user"]}'";
$result = mysqli_query($db, $query);

if ($result) {
	if (!mysqli_fetch_assoc($result)) {
		echo json_encode(
			array(
				"error" => True,
				"error_msg" => "USER_DOES_NOT_EXIST"
			)
		);

		exit();
	}
} else {
	die("Database query failed with errer: " . mysqli_error($db));
}

// we should also check whether or not the or not the league exists
$query  = "SELECT * FROM leagues WHERE id='{$_GET["league"]}'";
$result = mysqli_query($db, $query);

if ($result) {
	if (!mysqli_fetch_assoc($result)) {
		echo json_encode(
			array(
				"error" => True,
				"error_msg" => "LEAGUE_DOES_NOT_EXIST"
			)
		);

		exit();
	}
} else {
	die("Database query failed with errer: " . mysqli_error($db));
}

// we need to find the league, and look for the first open
// position for this user, if there are no open positions,
// an error will be returned to the caller

$query = "SELECT * FROM leagues WHERE id='{$_GET["league"]}'";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
mysqli_free_result($result);

// loop through each member and find the first one that is empty
// we will also check if this user is already a member of the league

$first_empty = -1;
for ($i = 0; $i < 5; $i++) {
	$key = "member" . $i;
	$user = $league[$key];

	if ($user == 0 && $first_empty == -1) {
		// we found a spot for the user!!!
		$first_empty = $i;
	}

	if ($user == $_GET["user"]) {
		// user already exists in the league
		echo json_encode(
			array(
				"error" => True,
				"error_msg" => "USER_ALREADY_IN_LEAGUE"
			)
		);

		exit();
	}
}

// if there are no empty spots, return as an error
if ($first_empty < 0) {
	echo json_encode(
		array(
			"error" => True,
			"error_msg" => "NO_SPACE_IN_LEAGUE"
		)
	);

	exit();
}

// now ready to perform the update to the leagues table
$query = "UPDATE leagues SET member" . $first_empty . "=" . $_GET["user"] 
	. " WHERE id=" . $_GET["league"];

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// we need to refetch the league so that it includes the latest user
$query = "SELECT * FROM leagues WHERE id='{$_GET["league"]}'";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
mysqli_free_result($result);

// and now we are ready to update the schedule
updateSchedule($league, $db);

echo json_encode(
	array(
		"error" => False,
	)
);

// All done! :)
mysqli_close($db);

?>
