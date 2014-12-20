<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>Database Final</title>
<style type="text/css">	
body {
	text-align:center;
	color: black;
	background-color: white;
	font-family: Courier;
}

fieldset {
	font-size:1.0em;
	background-color: lightgrey;
}

.fancy {
	color: blue;
	background-color: white;
}

</style>
</head>

<body>
   
<form method="post" action="<?php $_PHP_SELF ?>">
<fieldset>
<legend>Search the store database</legend>
<p> 
<label for="sql_command">Query: </label>
<input name="sql_command" type="text" id="sql_command">
</p> 
<p>
<input name="update" type="submit" id="update" value="Submit">
</p>
</fieldset>
</form>

<?php
	if(isset($_POST['update'])) {
		$dbhost = 'localhost';	// IP address / location of the db
		$dbuser = 'root';			// username
		$dbpass = '';			// password
		$dbname = 'store';			// name of the db you want to access
		$con = mysql_connect($dbhost, $dbuser, $dbpass);

		// check to make sure you are connected
		if(! $con ) {
			die('Could not connect: ' . mysql_error());
		}

		// store the sql command in a variable.
		$sql = $_POST['sql_command'];

		// select the db
		mysql_select_db($dbname, $con);

		// run command and store results in $retval
		$retval = mysql_query($sql, $con);

		// if the mysql_query returned an error code, kill it and display the error
		if(! $retval ) {
			die('<br>Could not update data: ' . mysql_error());				
		}
		else {	
			// promp for successful update
			print "Updated data successfully<br>";

			// display the return values in a table
			print "<table style='width:100%' class='fancy'>";	// begining table
			$i=0;
			print '<tr>';
			while($i < mysql_num_fields($retval)){
				$meta=mysql_fetch_field($retval,$i);
				print '<td>'.$meta->name.'</td>';
				$i=$i+1;
			}
			print '</tr>';
			
			
			while($record = mysql_fetch_row($retval)) {
				print "<tr>";	// start table row
				foreach($record as $key => $value){
					print "<td> ".$record[$key]." </td>";	// add one data element
				}
				print "</tr>";	// end table row
			}
			print "</table>";	// end table
		}

		// close the connection
		mysql_close($con);
	}
?>

</body>
</html>