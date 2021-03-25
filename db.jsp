<%@ page import="java.sql.*" %> 
<%
try
{	 
	Class.forName("com.mysql.jdbc.Driver");  //load driver 
	
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin",""); 
    
	if(request.getParameter("delete")!=null)
	{
		int sno1=Integer.parseInt(request.getParameter("delete"));
		String name=request.getParameter("val1"); 
		String query = "DELETE FROM "+name+" WHERE sno="+sno1;
		System.out.println(query);
		Statement st=con.createStatement(); //sql delete query		
		st.executeUpdate(query); //execute query
		con.setAutoCommit(true);
		
		con.close(); //close connection
	}
}
catch(Exception e)
{
	out.println(e);
}
%>	

<html>
<head>

<!--css for div main class and table -->
		<style type="text/css">
		
		.main
		{
			width:1000px;;
			margin-left:200px;
			padding: 10px;
			border: 2px solid grey;
			
		}
		table
		{
			font-family: arial, sans-serif;
			border-collapse: collapse;
			width: 990px;
		}
		td
		{
			border: 1px solid grey;
			text-align: center;
			padding: 8px;
		}
		</style>

		</head>
		<body>
		
		<div class="main">
		
		<br><br>
		<table>
		
			<tr>
			    <th>Sno</th>
			    <th>Semester</th>
				<th>Subject Code</th>
				<th>Subject Title</th>
				<th>Credits</th>
				<th>Grade Points</th>
			</tr>
		<%
		
		try
		{	
			response.setIntHeader("Refresh", 5);
			String name=request.getParameter("val");  
			Class.forName("com.mysql.jdbc.Driver");  //load driver 
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin",""); 


			PreparedStatement pstmt=null; //create statement
		
			pstmt=con.prepareStatement("select * from "+name); //sql select query  
			
			ResultSet rs=pstmt.executeQuery(); //execute query and set in resultset object rs.  
			if(!rs.isBeforeFirst()) {      
				 out.println("<p>No Record found!</p>");   
				}else{  
			while(rs.next())
			{	
		%>
				<tr>
					<td><%=rs.getInt(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><%=rs.getString(6)%></td>
					
					<td><a href="update.jsp?edit=<%=rs.getInt("sno")%>&val1=<%=name%>">Edit</a></td>
					<td><a href="Delete.jsp?delete=<%=rs.getInt("sno")%>&val1=<%=name%>">Delete</a></td>
				<!-- 	<td><a href="?delete=<%=rs.getInt("sno")%>&val1=<%=name%>">Delete</a></td>  -->
					
				</tr>
		<%
			}
				}
			
		}
		catch(Exception e)
		{	
			out.println("<p>No Result Found!</p>"); 
		}
		
		
		%>
		
		</table>
		
		</div>
		
</body>
</body>
</html>