<%@ page import="java.sql.*" %>  

<%
try
{	
	
Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin","");

	if(request.getParameter("btn_add")!=null) //check button click event not null
	{
		String name,owner;
		
		name=request.getParameter("txt_name"); //txt_name 
		owner=request.getParameter("txt_owner"); //txt_owner
		
		PreparedStatement pstmt=null; //create statement 
		
		pstmt=con.prepareStatement("insert into person(name,owner)values(?,?)"); //sql insert query 
		pstmt.setString(1,name); 
		pstmt.setString(2,owner);	
		pstmt.executeUpdate(); //execute query
		
		con.close();  //close connection 
		
		out.println("Insert Successfully...! Click Back link.");// after insert record successfully message
		
	}	
	
}
catch(Exception e)
{
	out.println(e);
}

%>

<html>

	<head>
	
		<title>JSP:Insert, Update, Delete using MySQL</title>
		
		<!--css for div main class and table -->
		<style type="text/css">
		
		.main
		{
			width:700px;;
			margin-left:250px;
			padding: 10px;
			border: 5px solid grey;
			
		}
		table
		{
			font-family: arial, sans-serif;
			border-collapse: collapse;
			width: 600px;
		}
		td
		{
			border: 5px solid silver;
			text-align: left;
			padding: 8px;
		}
		</style>
		
		<!-- javascript for form validation-->
		<script>
		
			function validate()
			{
				var name = document.myform.txt_name;
				var owner = document.myform.txt_owner;
				
				if (name.value == "")
				{
					window.alert("please enter name ?");
					name.focus();
					return false;
				}
				if (owner.value == "")
				{
					window.alert("please enter owner ?");
					owner.focus();
					return false;
				}
			}
			
		</script>
		
	</head>
	
	<body>

		<div class="main">

		<form method="post" name="myform"  onsubmit="return validate();">
	
			<center>
				<h1>Insert Record</h1>
			</center>
		
			
			<table>	
		
				<tr>
					<td>Name</td>
					<td><input type="text" name="txt_name"></td>
				</tr>
				
				<tr>
					<td>Owner</td>
					<td><input type="text" name="txt_owner"></td>
				</tr>	
				
				<tr>
					<td><input type="submit" name="btn_add" value="Insert"></td>	
				</tr>
				
			</table>
			
				<center>
					<h1><a href="index.jsp">Back</a></h1>
				</center>
				
		</form>
		
		</div>
		
	

</body>

</html>