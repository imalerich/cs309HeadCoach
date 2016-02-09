<html>
	<head>
	<title>Photostream Sample</title>
	</head>

	<body>
	<?php
		
	$url = "http://photostream.iastate.edu/api/photo/?key=c88ba8aca62dd5ccb60d";
	$data = file_get_contents($url);
	$json = json_decode($data, True);

	for ($i = 0; $i < sizeof($json); $i++) {
		$title = $json[$i]["title"];
		echo "<h1>$title</h1>";
		$img = $json[$i]["image_medium"];
		echo "<img src=$img alt=$title/>";
	}

	?>
	</body>
</html>
