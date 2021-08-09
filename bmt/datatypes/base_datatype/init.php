<?php 	
	include('datatypes/base_datatype/phpFunctions.php');
		
	if(!isset($_GET['id']) && !(isset($_GET['action']))){
		include('datatypes/base_datatype/completeTable.php');
	}elseif(isset($_GET['action'])){
		include('datatypes/base_datatype/'.$_GET['action'].'.php');
	}
	
	include('datatypes/base_datatype/JSFunctions.php');
?>