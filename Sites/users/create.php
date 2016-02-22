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

// This call requires an account_name parameter for the created user
// eventually this should include a password, but this is omitted for now
if (sizeof($_GET) == 0) {
	echo json_encode(
		array(
			"error" => True,
			"required_params" => array(
				"account_name"
			)
		)
	);

	exit();
}

// if an account_name was given, add that account name to the database
if (array_key_exists("account_name", $_GET) && strlen($_GET["account_name"])) {
	$query  = "INSERT INTO users (";
	$query .= "user_name, reg_date";
	$query .= ") VALUES (";
	$query .= "'{$_GET["account_name"]}','00/00/00'";
	$query .= ")";
}

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
