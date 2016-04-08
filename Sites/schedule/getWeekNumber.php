<?php

// I do not think I am going to need this code anymore
// but will keep it here just in case
function getWeekNumber($date) {
	$week_num = 1;
	$week = new DateTime( date('Y-m-d', strtotime("september 2015 first monday")));
	$week->modify("+7 days"); // get the first sunday for football

	// check if the season has not yet started
	if ($week->getTimeStamp() > $date) {
		return 0;
	}

	// otherwise find the current week for the season
	for ($tmp = $week->getTimeStamp(); $tmp < $date; $week->modify("+1 week"), $tmp = $week->getTimeStamp()) {
		$week_num++;
	}

	return max(min($week_num, 17), 1);
}

?>
