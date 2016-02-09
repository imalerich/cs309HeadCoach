<?php

// use json data
header('Content-Type: application/json');

$url = "http://photostream.iastate.edu/api/photo/?key=c88ba8aca62dd5ccb60d";
$data = file_get_contents($url);
echo $data;

?>
