<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*" %> 
<%
try
{	 
	Class.forName("com.mysql.jdbc.Driver");  //load driver 
	
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin",""); 

		int sno1=Integer.parseInt(request.getParameter("delete"));
		String name=request.getParameter("val1"); 
		String query = "DELETE FROM "+name+" WHERE sno="+sno1;
		System.out.println(query);
		Statement st=con.createStatement(); //sql delete query		
		st.executeUpdate(query); //execute query
		con.setAutoCommit(true);
		con.close(); //close connection
		response.sendRedirect("index.jsp");
		
}
catch(Exception e)
{
	out.println(e);
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>