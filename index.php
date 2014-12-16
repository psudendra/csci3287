
<!DOCTYPE html>
	<head>
		<title>Database Final</title>
	</head>
	<body>
		<!-- This forms has the command text box and the submit button -->
		<form method="post" action="<?php $_PHP_SELF ?>">
			<table width="400" border="0" cellspacing="1" cellpadding="2">
				<tr>
					<!-- text that will go next to the text box -->
					<td width="110">SQL Command:</td>

					<!-- text box /-->
					<td><input name="sql_command" type="text" id="sql_command"></td>
				</tr>
				<tr>
					<td width="100"> </td>
					<td>
						<!-- submit button -->
						<input name="update" type="submit" id="update" value="Submit">
					</td>
				</tr>
				<tr>
					<td width="100"> </td>
					<td> </td>
				</tr>
			</table>
		</form>
		<?php
			if(isset($_POST['update']))
			{
				$dbhost = 'localhost';	// IP address / location of the db
				$dbuser = 'root';			// username
				$dbpass = '';			// password
				$dbname = 'store';			// name of the db you want to access
				$con = mysql_connect($dbhost, $dbuser, $dbpass);

				// check to make sure you are connected
				if(! $con )
				{
					die('Could not connect: ' . mysql_error());
				}

				// store the sql command in a variable.
				$sql = $_POST['sql_command'];

				// select the db
				mysql_select_db($dbname, $con);

				// run command and store results in $retval
				$retval = mysql_query($sql, $con);

				// if the mysql_query returned an error code, kill it and display the error
				if(! $retval )
				{
					die('<br>Could not update data: ' . mysql_error());				
				}
				else
				{	
					// promp for successful update
					echo "Updated data successfully<br>";

					// display the return values in a table
					echo "<table style='width:100%'>";	// begining table
					$i=0;
					echo '<tr>';
					while($i < mysql_num_fields($retval)){
						$meta=mysql_fetch_field($retval,$i);
						echo '<td>'.$meta->name.'</td>';
						$i=$i+1;
					}
					echo '</tr>';
					
					
					while($record = mysql_fetch_row($retval)){
						echo "<tr>";	// start table row
						foreach($record as $key => $value){
							echo "<td> ".$record[$key]." </td>";	// add one data element
						}
						echo "</tr>";	// end table row
					}
					echo "</table>";	// end table
				}

				// close the connection
				mysql_close($con);
			}
		?>
	</body>
</html>
