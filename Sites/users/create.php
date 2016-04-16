<?php

// connect to the CS309 database
$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connection failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

header("Content-Type: application/json");

// if an account_name was given, add that account name to the database
if (!array_key_exists("name", $_GET) || !strlen($_GET["name"])) {
	die("Missing 'name' parameter");
}

// check to make sure the name is not already taken
$query  = "SELECT * FROM users WHERE user_name='{$_GET["name"]}'";
$result = mysqli_query($db, $query);

if ($result) {
	if (mysqli_fetch_assoc($result)) {
		echo json_encode(
			array(
				"error" => True,
				"error_msg" => "INVALID_USER_NAME"
			)
		);

		exit();
	}
} else {
	die("Database query failed with errer: " . mysqli_error($db));
}

$time = time();
$query  = "INSERT INTO users (";
$query .= "user_name, reg_date";
$query .= ") VALUES (";
$query .= "'{$_GET["name"]}', {$time}";
$query .= ")";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with error:" . mysqli_error($db));
}

echo json_encode(
	array(
		"error" => False
	)
);

mysqli_close($db);

?>
