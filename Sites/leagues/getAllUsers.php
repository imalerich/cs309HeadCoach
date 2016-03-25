<?php

$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connetion failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

header("Content-Type: application/json");

// this API call requires the league ID to search for users
if (!array_key_exists("id", $_GET)) {
	die("league 'id' required for this call");
}

// query the database for this league
$query  = "SELECT * ";
$query .= "FROM leagues ";
$query .= "WHERE id='{$_GET["id"]}'";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
mysqli_free_result($result);

// now that we have the league, we need to build an array of 
// all the users, which will serve as the output to this API call

$users = array();

// loop through each possible member of the league
for ($i = 0; $i < 5; $i++) {
	$key = "member" . $i;
	$user_id = $league[$key];

	// ignore empty user slots
	if ($user_id == 0) {
		continue;
	}

	// build the query to grab the additional information
	$query  = "SELECT * ";
	$query .= "FROM users ";
	$query .= "WHERE id=" . $user_id;

	// add the user to the output array
	$result = mysqli_query($db, $query);
	if ($result) {
		array_push($users, mysqli_fetch_assoc($result));
	}

	// else ignore the invalid user
}

echo json_encode($users);

mysqli_close($db);

?>
