<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link =  mysqli_connect('localhost', 'root', '', "bengtravelapp");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$Name = $_GET['Name'];
		$User = $_GET['User'];
		$Password = $_GET['Password'];
		$Type = $_GET['Type'];
		$UrlPicture = $_GET['UrlPicture'];
		
							
		$sql = "INSERT INTO `userTABLE`(`id`, `Name`, `Type`, `User`, `Password`,`UrlPicture`) VALUES (Null, '$Name','$Type' ,'$User','$Password','$UrlPicture)";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Thinnakorn";
   
}
	mysqli_close($link);
?>