<?php

header('Content-Type: application/json');

require_once 'HTTP/Request2.php';

$request = new HTTP_Request2("https://api.fantasydata.net/nfl/v2/JSON/BoxScores/2015/1");
$url = $request->getUrl();

$headers = array("Ocp-Apim-Subscription-Key" => "fa953b83a78d44a1b054b0afbbdff57e");
$request->setHeader($headers);
$request->setMethod(HTTP_Request2::METHOD_GET);
$request->setBody("{body}");

try {
	$response = $request->send();
	echo $response->getBody();
} catch (HttpException $e) {
	echo "Request failed with error - $e";
}

?>
