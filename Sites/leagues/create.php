<?php

$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connetion failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

header("Content-Type: application/json");
require_once 'HTTP/Request2.php';

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

// now that we have created the league, we will need 
// to create the drafting table for this league

$draft_table = $_GET["name"] . "_draft";

// drop the table if it exists, the original league must have been deleted
$query = "DROP TABLE IF EXISTS {$draft_table}";
if (!($result = mysqli_query($db, $query))) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$query = "CREATE TABLE " 
	. $draft_table
	. "("
	. "id INT(11) NOT NULL AUTO_INCREMENT, "
	. "name VARCHAR(100) NOT NULL, "
	. "user_id INT(11) NOT NULL, "
	. "pos VARCHAR(11) NOT NULL,"
	. "pos_cat VARCHAR(11) NOT NULL,"
	. "on_bench INT(1) NOT NULL DEFAULT 0,"
	. "fd_id INT(11) NOT NULL, "
	. "PRIMARY KEY (id), "
	. "INDEX (user_id) "
	. ")";

$result = mysqli_query($db, $query);

if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// now fill that table with the roster of players
// from fantasy data

$request = new HTTP_Request2("https://api.fantasydata.net/nfl/v2/JSON/Players");
$url = $request->getUrl();

$headers = array("Ocp-Apim-Subscription-Key" => "fa953b83a78d44a1b054b0afbbdff57e");
$request->setHeader($headers);
$request->setMethod(HTTP_Request2::METHOD_GET);
$request->setBody("{body}");

// RHEL will not behave without this
// Mac OS X will not behave with this
// if either is not working it's probably
// this lines fault
// $request->setAdapter('curl');

// send and process the request
try {
	// add all the players to the database
	$response = $request->send();
	$json = json_decode($response->getBody(), True);

	// loop through each player, and add them as an entry in the new table
	for ($i = 0; $i < sizeof($json); $i++) {
		$first = $json[$i]["FirstName"];
		$last = $json[$i]["LastName"];
		$name = $first . " " . $last;
		$pos = $json[$i]["FantasyPosition"];
		$pos_cat = $json[$i]["PositionCategory"];
		$id = $json[$i]["PlayerID"];

		// we will only use one defensive position for this league
		if (strcmp($pos, "LB") == 0 || strcmp($pos, "DB") == 0) {
			$pos = "DL";
		}

		$query  = "INSERT INTO " . $draft_table .  " (";
		$query .= "name, user_id, pos, pos_cat, fd_id";
		$query .= ") VALUES (";
		$query .= "\"{$name}\", 0, \"{$pos}\", \"{$pos_cat}\", $id";
		$query .= ")";

		$result = mysqli_query($db, $query);

		if (!$result) {
			die("Database query failed with errer: " . mysqli_error($db));
		}
	}

} catch (HttpException $e) {
	die("Request failed with error $e");
}

// now that we have created the draft table for this league
// we need to create a schedule table for this league
// this table will maintain the schedule of games for the
// current season

// we will schedule games once per week each Sunday
// starting September 6th and continuing for 17 weeks

$schedule_table = $_GET["name"] . "_schedule";

// drop the table if it exists, the original league must have been deleted
$query = "DROP TABLE IF EXISTS {$schedule_table}";
if (!($result = mysqli_query($db, $query))) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$query = "CREATE TABLE " 
	. $schedule_table
	. "("
	. "id INT(11) NOT NULL AUTO_INCREMENT, "
	. "user_id_0 INT(11) NOT NULL, "
	. "user_id_1 INT(11) NOT NULL, "
	. "week INT(11) NOT NULL, "
	. "score_0 INT(11) NOT NULL DEFAULT 0, "
	. "score_1 INT(11) NOT NULL DEFAULT 0, "
	. "completed INT(1) NOT NULL DEFAULT 0, "
	. "PRIMARY KEY (id), "
	. "INDEX (user_id_0), "
	. "INDEX (user_id_1) "
	. ")";

$result = mysqli_query($db, $query);

if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// finished without error
echo json_encode(
	array(
		"error" => False
	)
);

// close the connection with the database
mysqli_close($db);

?>
