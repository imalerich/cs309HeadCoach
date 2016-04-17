<?php

header("Content-Type: application/json");

$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connetion failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

// we need the user to update the profile picture for
// as well as a url for the new profile picture
if (!array_key_exists("user", $_GET) || !array_key_exists("img", $_GET)) {
	die("'user' and 'img' parameters required");
}

$query = "UPDATE users SET img=\"{$_GET["img"]}\" WHERE id={$_GET["user"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}


echo json_encode(
	array(
		"error" => False
	)
);

?>
