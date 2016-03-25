<html>

<head>
	<title>NFL Players</title>
</head>

<body>

	<?php
	require_once 'HTTP/Request2.php';
	
	$request = new HTTP_Request2("https://api.fantasydata.net/nfl/v2/JSON/Players");
	$url = $request->getUrl();
	
	$headers = array("Ocp-Apim-Subscription-Key" => "fa953b83a78d44a1b054b0afbbdff57e");
	$request->setHeader($headers);
	$request->setMethod(HTTP_Request2::METHOD_GET);
	$request->setBody("{body}");
	
	try {
		$response = $request->send();

		$json = json_decode($response->getBody(), True);
		for ($i = 0; $i < sizeof($json); $i++) {
			$first = $json[$i]["FirstName"];
			$last  = $json[$i]["LastName"];
			echo "<h1>$first $last</h1>";

			$img = $json[$i]["PhotoUrl"];
			echo "<img src=$img alt=$last/>";
		}
	
	} catch (HttpException $e) {
		echo "Request failed with error - $e";
	}
	
	?>

</body>
</html>
