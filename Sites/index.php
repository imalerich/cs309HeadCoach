<?php

header('Content-Type: application/json');

class SampleAPI {
	// main method for the sample api
	function sample($input) {
		$arr = array($input, $input, $input);
		echo json_encode($arr, 0, sizeof($arr));
	}
}

echo "[";

// create an instance of SampleAPI and call sample
if (sizeof($_GET) > 0) {
	echo ",";
	$api = new SampleAPI;
	$api->sample($_GET["param"]);
}

// calculate some prime numbers and output them
$count = 100;
$prime = array();

for ($i = 3; $i < $count; $i++) {
	$isPrime = True;

	for ($j = 2; $j <= sqrt($i); $j++) {
		if ($i % $j == 0) {
			$isPrime = False;
		}
	}

	if ($isPrime) {
		$prime[sizeof($prime)] = $i;
	}
}

echo json_encode($prime, 0, sizeof($prime));

echo "]";

?>
