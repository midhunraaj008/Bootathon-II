<%@ page import="java.sql.*" %> 

<html>
<head>

<!--css for div main class and table -->
		<style type="text/css">
		
		.main
		{
			width:1020px;;
			margin-left:180px;
			padding: 10px;
			border: 2px solid black;
			
		}
		table
		{
			font-family: arial, sans-serif;
			border-collapse: collapse;
			width: 1000px;
		}
		td
		{
			border: 1px solid black;
			text-align: center;
			padding: 8px;
		}
		</style>
		
		</head>
		<body>
		<br><br>
		<div class="main">
		
		<br><br>
		<table>
		
			<tr>
			    <th>Semester</th>
				<th>Subject Code</th>
				<th>Subject Title</th>
				<th>Credits</th>
				<th>Grade Points</th>
			</tr>
		<%
		
		try
		{
			String name=request.getParameter("val");  
			Class.forName("com.mysql.jdbc.Driver");  //load driver 
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin",""); 

			String rollno=null;

		     if(session.getAttribute("login")!=null)
		      {
		          Object ob=session.getAttribute("login");
		          rollno=(String)ob;
		      }
		     String query = "SELECT * FROM "+rollno+" WHERE sem='"+name+"'";
				Statement st = con.createStatement();
				ResultSet rs=st.executeQuery(query);
			float gpa,credits,sumcredits=0,sumgp=0;
			if(!rs.isBeforeFirst()) {      
				 out.println("<p>No Record Found!</p>");   
				}else{  
			while(rs.next())
			{	
		%>
				<tr>
					<td><%=rs.getString("sem")%></td>
					<td><%=rs.getString("subcode")%></td>
					<td><%=rs.getString("subtitle")%></td>
					<td><%=rs.getString("credits")%></td>
					<td><%=rs.getString("gradepoints")%></td>			
				</tr>
		<%
		sumcredits=sumcredits+ Float.parseFloat(rs.getString(5));
		sumgp += Float.parseFloat(rs.getString(6))* Float.parseFloat(rs.getString(5));
			}
			gpa=sumgp/sumcredits;
			out.println("<tr><td colspan='6' align='right'>GPA : "+gpa+"</td></tr>");
			
			}
		}
		catch(Exception e)
		{
			out.println("<p>No Record Found!</p>"); 
		}
		
		
		%>
		
		</table>
		
		</div>
		
</body>
</body>
</html>