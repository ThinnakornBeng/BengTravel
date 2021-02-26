<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "bengtravelapp");

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
				
		$idName = $_GET['idName'];		
		$PathImage = $_GET['PathImage'];
		$Detail = $_GET['Detail'];
        $NameTravel = $_GET['NameTravel'];
		
							
		$sql = "INSERT INTO `travelTable`(`id`, `idName`, `NameTravel`, `Detail`, `PathImage`) VALUES (Null,'$idName', '$NameTravel', '$Detail','$PathImage')";

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