<?php

$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connetion failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

header("Content-Type: application/json");

// check for the user id we are grabbing leagues for
if (!array_key_exists("id", $_GET)) {
	die("user 'id' required for this call");
}

// all leagues where ANY member is the input 'id'
$query  = "SELECT * FROM leagues WHERE ";
for ($i = 0; $i < 5; $i++) {
	$query .= "member" . $i . "=" . $_GET["id"];
	$query .= ($i < 4 ? " OR " : "");
}

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// parse all returned data into a single array
$leagues = array();
while ($league = mysqli_fetch_assoc($result)) {
	array_push($leagues, $league);
}

echo json_encode($leagues);

mysqli_free_result($result);
mysqli_close($db);

?>
