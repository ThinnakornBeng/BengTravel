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
		$UrlImage = $_GET['UrlImage'];
		$Detail = $_GET['Detail'];
        $NameTravel = $_GET['NameTravel'];
		$Lat = $_GET["Lat"];
		$Lng = $_GET["Lng"];
		
							
		$sql = "INSERT INTO `travelTable`(`id`, `idName`, `NameTravel`, `Detail`, `UrlImage`, `Lat`, `Lng`) VALUES (Null,'$idName', '$NameTravel', '$Detail','$UrlImage','$Lat','$Lng')";

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