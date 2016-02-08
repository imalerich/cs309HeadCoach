<html>
	<head>
		<title>PHP Test</title>
	</head>

	<body>
		<?php 
		switch(2) {
		case 0:
			echo '0';
			break;
		case 1:
		case 2:
		case 3:
			echo '1, 2, or 3';
			break;
		case 4:
			echo '4';
			break;
		default:
			break;
		}
		?>
	</body>
</html>
