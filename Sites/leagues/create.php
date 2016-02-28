<?php

$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connetion failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

header("Content-Type: application/json");

// check and make sure all required parameters are present
if (!array_key_exists("name", $_GET) || !strlen($_GET["name"]) || !array_key_exists("drafting", $_GET)) {
	die("'name' and 'drafting' parameters required");
}

// check to make sure the name is not already taken
$query  = "SELECT * FROM leagues WHERE name='{$_GET["name"]}'";
$result = mysqli_query($db, $query);

if ($result) {
	if (mysqli_fetch_assoc($result)) {
		echo json_encode(
			array(
				"error" => True,
				"error_msg" => "INVALID_LEAGUE_NAME"
			)
		);

		exit();
	}
} else {
	die("Database query failed with errer: " . mysqli_error($db));
}

$time = time();
$query  = "INSERT INTO leagues (";
$query .= "name, drafting, creation_date";
$query .= ") VALUES (";
$query .= "'{$_GET["name"]}', '{$_GET["drafting"]}', '{$time}'";
$query .= ")";

$result = mysqli_query($db, $query);

if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

echo json_encode(
	array(
		"error" => False
	)
);

// close the connection with the database
mysqli_close($db);

?>
