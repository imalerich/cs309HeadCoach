<?php

header("Content-Type: application/json");

// the caller may optionally filter the results by a given league
$league_id = -1;
if (array_key_exists("league_id", $_GET)) {
	$league_id = $_GET["league_id"];
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
	echo json_encode($league_users[$league_id]);
}

?>
