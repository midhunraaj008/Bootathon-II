import java.io.*;  
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Getdata")
public class Getdata extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn;
	PreparedStatement ps;
    public Getdata() throws SQLException, ClassNotFoundException{
        super();
        conn = DBConnection.Getconnection();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();  
        response.setContentType("text/html");  
        out.println("<html><body>"); 
        //out.println("<h3>test</h3>");
        try
        {	
        	ps = conn.prepareStatement("select * from details");
        	ResultSet rs = ps.executeQuery();
        	out.println("<h2 style=\"text-align:center;\"> Student Details </h2>");
        	out.println("<table border=1>");  
            out.println("<tr><th>Name</th><th>Register No</th><tr>");
            while(rs.next())
            {
            	String name = rs.getString("Name");
            	String regno = rs.getString("Register No");
            	out.println("<tr><td>" + name + "</td><td>" + regno + "</td></tr>"); 
            }
            out.println("</table>");  
            out.println("</html></body>");  
            conn.close(); 
        }
        catch(Exception e)
        {
        	out.println("error");
        }
	}



}
