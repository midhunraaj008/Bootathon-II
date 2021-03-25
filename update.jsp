<%@ page import="java.sql.*" %>

<%
try
{
	
Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin","");
	if(request.getParameter("btn_update")!=null) //check button click event not null
	{
		int hide; 
		
		String subcode1,subtitle1,credits1,gradepoints1,sem1;
		String name=request.getParameter("txt_val");
		hide=Integer.parseInt(request.getParameter("txt_hide")); //it is hidden id get for update record
		sem1=request.getParameter("txt_sem");
		subcode1=request.getParameter("txt_subcode");  //txt_name
		subtitle1=request.getParameter("txt_subtitle"); //txt_owner
		credits1=request.getParameter("txt_credits");
		gradepoints1=request.getParameter("txt_gradepoints");
		
		String upquery = "UPDATE "+name+" SET sno='"+hide+"',sem='"+sem1+"',subcode='"+subcode1+"',subtitle='"+subtitle1+"',credits='"+credits1+"',gradepoints='"+gradepoints1+"' WHERE sno='"+hide+"'";
		Statement stmt=con.createStatement(); 
		stmt.execute(upquery); //execute query
		con.setAutoCommit(true);
		con.close(); //connection close

		out.println("Update Successfully...! Click Back link."); //after update record successfully message
	}	
	
}
catch(Exception e)
{
	out.println(e);
}

%>

<html>

	<head>
	
		<title>Skct Results</title>
		
	<!--css for div main class and table-->
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
				var sem = document.myform.txt_sem;
				var subcode = document.myform.txt_subcode;
				var subtitle = document.myform.txt_subtitle;
				var credits = document.myform.txt_credits;
				var gradepoints = document.myform.txt_gradepoints;
				
				if (sem.value == "")
				{
					window.alert("please enter sem ?");
					name.focus();
					return false;
				}
				if (subcode.value == "")
				{
					window.alert("please enter subcode ?");
					name.focus();
					return false;
				}
				if (subtitle.value == "")
				{
					window.alert("please enter subtitle ?");
					owner.focus();
					return false;
				}
				if (credits.value == "")
				{
					window.alert("please enter credits ?");
					name.focus();
					return false;
				}
				if (gradepoints.value == "")
				{
					window.alert("please enter gradepoints ?");
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
			<h1>Update Record</h1>
		</center>
		
		<table>	
		   <%
		try
		{
		
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin","");
 
	
			if(request.getParameter("edit")!=null) 
			{	

				int id=Integer.valueOf(request.getParameter("edit"));
				String name=request.getParameter("val1");
				String subcode2,subtitle2,gradepoints2,credits2,sem2;
				String query = "SELECT * FROM "+name+" WHERE sno="+id;
				Statement st = con.createStatement();
				ResultSet rs=st.executeQuery(query); // execute query store in resultset object rs.
				
				while(rs.next()) 
				{
					id=rs.getInt(1);
					sem2=rs.getString(2);
					subcode2=rs.getString(3);
					subtitle2=rs.getString(4);
					credits2=rs.getString(5);
					gradepoints2=rs.getString(6);
			%>
			<tr>
				<td>Semester</td>
				<td><input type="text" name="txt_sem" value="<%=sem2%>"></td>
			</tr>
			<tr>
				<td>Subject code</td>
				<td><input type="text" name="txt_subcode" value="<%=subcode2%>"></td>
			</tr>
			
			<tr>
				<td>Subtitle</td>
				<td><input type="text" name="txt_subtitle" value="<%=subtitle2%>"></td>
			</tr>	
			<tr>
				<td>Credits</td>
				<td><input type="text" name="txt_credits" value="<%=credits2%>"></td>
			</tr>
			
			<tr>
				<td>Gradepoints</td>
				<td><input type="text" name="txt_gradepoints" value="<%=gradepoints2%>"></td>
			</tr>	
			
			<tr>
				<td><input type="submit" name="btn_update" value="Update"></td>	
			</tr>
				
				<input type="hidden" name="txt_hide" value="<%=id%>">
				<input type="hidden" name="txt_val" value="<%=name%>">
		<%
				}
			}
		}
		catch(Exception e)
		{
			out.println(e);
		}
		%>	
		</table>
		
		<center>
				<h1><a href="index.jsp">Back</a></h1>
		</center>
		
	</form>

	</div>
	

</body>

</html>