<?php

header("Content-Type: application/json");

class User {
	public $id = -1; // unique account id for use in API calls
	public $name = ""; // unique account name

	// create a new user
	public function __construct($name) {
		$this->name = $name;
		$this->id = 0;
	}

	public function __toString() {
		return json_encode(
			array(
				"id" => $this->id,
				"name" => $this->name
			)
		);
	}
}

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

// Create the user and add the user to our database
$user = new User($_GET["account_name"]);

// Return the newly created user to the caller
echo $user;

?>
