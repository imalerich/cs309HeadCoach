<?php

// this call will grab the draft for a given user
// in a given league, with this draft, it will
// then pull the information for all games for the
// given week and calculate how many points the user made
// in total with their draft across that league

//header("Content-Type: application/json");
require_once 'HTTP/Request2.php';

// connect to the CS309 database
$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connection failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

if (!array_key_exists("week", $_GET) || !array_key_exists("user", $_GET) 
		|| !array_key_exists("league", $_GET)) {
	die("'week', 'user', and 'league' parameters required");
}

$week = $_GET["week"];
$user = $_GET["user"];
$league = $_GET["league"];
$points = 10;

// pull the game data for the input week

$request = new HTTP_Request2("https://api.fantasydata.net/nfl/v2/JSON/GameStatsByWeek/2015/" . $week);
$url = $request->getUrl();

$headers = array("Ocp-Apim-Subscription-Key" => "fa953b83a78d44a1b054b0afbbdff57e");
$request->setHeader($headers);
$request->setMethod(HTTP_Request2::METHOD_GET);
$request->setBody("{body}");

// RHEL will not behave without this
// Mac OS X will not behave with this
// if either is not working it is probably
// this lines fault
// $request->setAdapter('curl');

try {
	//$response = $request->send();
	//$json = json_decode($response->getBody(), True);

} catch (HttpException $e) {
	die("Request failed with error $e");
}

echo json_encode(
	array(
		"error" => False,
		"points" => $points
	)
);

?>
