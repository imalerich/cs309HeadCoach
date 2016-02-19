<?php

header("Content-Type: application/json");

// the caller may optionally filter the results by a given league
$league_id = -1;
if (array_key_exists("league_id", $_GET)) {
	$league_id = $_GET["league_id"];
}

// the caller may also filter to a specific user
// this is only valid if a specific league is provided
$user_id = -1;
if (array_key_exists("user_id", $_GET)) {
	$user_id = $_GET["user_id"];
}

$league_users = 
	array (
		array(
			"user0",
			"user1",
			"user2"
		),
		array(
			"user0",
			"user1",
			"user2",
			"user3"
		)
	);

// return some dummy data for now
if ($league_id == -1) {
	echo json_encode($league_users);
} else {
	if ($user_id == -1) {
		echo json_encode($league_users[$league_id]);
	} else {
		echo json_encode($league_users[$league_id][$user_id]);
	}
}

?>
