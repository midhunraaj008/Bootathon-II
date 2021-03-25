<%@ page import="java.sql.*" %>  
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
if(session.getAttribute("login")!=null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("index.jsp");
}
%>
<%
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	PreparedStatement ps;
	String rollno = request.getParameter("login"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin","");
	if(request.getParameter("btn_login")!=null) 
	{
		try{
        	ps = conn.prepareStatement("select * from "+rollno);
        	ResultSet rs = ps.executeQuery();
        	out.println("<html><head><title>Student Marksheet</title><link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\"></head><body>");
        	out.println("<h2 align='center'>Result</h2>");
        	out.println("<table border=1>");
        	out.println("<tr><td>Subject Code</td><td>Subject Name</td><td>Credits</td><td>Grade Points</td></tr>");
        	String code,sem,subject;
        	int gp,Sno;
        	float cgpa,credits,sumcredits=0,sumgp=0;;
        	while(rs.next()){
        		Sno = rs.getInt("sno");
        		sem = rs.getString("sem");
        		code = rs.getString("subcode");
        		subject = rs.getString("subtitle");
        		credits = rs.getFloat("credits");
        		gp = rs.getInt("gradepoints");
        		sumcredits += credits;
        		sumgp += (float)gp*credits;
        		out.println("<tr><td>"+Sno+"<tr><td>"+sem+"<tr><td>"+code+"</td><td>"+subject+"</td><td>"+credits+"</td><td>"+gp+"</td></tr>");
        	}
        	cgpa=sumgp/sumcredits;
        	out.println("<tr><td colspan='6' align='right'>CGPA : "+cgpa+"</td><td>%.2f</td></tr>");
        	out.println();
        	out.println("</table>");
        	out.println("</body></head>");
        	conn.close();
        }catch(Exception e){
        	out.println("Error!");
        }
	}

%>
