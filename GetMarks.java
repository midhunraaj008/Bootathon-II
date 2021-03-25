

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.io.PrintWriter;

@WebServlet("/GetMarks")
public class GetMarks extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn;
	PreparedStatement ps;
    
    public GetMarks() throws SQLException, ClassNotFoundException{
        super();
        conn=DBConnection.Getconnection();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();  
        response.setContentType("text/html");  
        out.println("<html><head><title>Student Registration</title><link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\"></head><body>");
        String rollno="18tucs101";
        try{
        	ps = conn.prepareStatement("select * from "+rollno);
        	ResultSet rs = ps.executeQuery();
        	out.println("<h2 align='center'>Result</h2>");
        	out.println("<table border=1>");
        	out.println("<tr><td>Subject Code</td><td>Subject Name</td><td>Credits</td><td>Grade Points</td></tr>");
        	String code,subject;
        	int gp;
        	float cgpa,credits,sumcredits=0,sumgp=0;;
        	while(rs.next()){
				code = rs.getString("subcode");
				subject = rs.getString("subtitle");
				credits = Float.parseFloat(rs.getString("credits"));
				gp = Integer.parseInt(rs.getString("gradepoints"));
				sumcredits += credits;
				sumgp += (float)gp*credits;
				out.println("<tr><td>"+code+"</td><td>"+subject+"</td><td>"+credits+"</td><td>"+gp+"</td></tr>");
			}
        	cgpa=sumgp/sumcredits;
        	out.printf("<tr><td colspan='3' align='right'>CGPA:</td><td>%.2f</td></tr>",cgpa);
        	out.println();
        	out.println("</table>");
        	out.println("</body></head>");
        	conn.close();
        }catch(Exception e){
        	out.println("Error!");
        }
	}

}
