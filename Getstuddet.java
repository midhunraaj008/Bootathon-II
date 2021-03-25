import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/Getstuddet")
public class Getstuddet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn;
	PreparedStatement ps;
	public Getstuddet() throws SQLException, ClassNotFoundException{
		conn = DBConnection.Getconnection(); 
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String Name = request.getParameter("name");
		String Rno = request.getParameter("regno");
		String Dept = request.getParameter("dept");
		String Sec = request.getParameter("sec");
		String Mob = request.getParameter("mobno");
	
		try {
			ps = conn.prepareStatement("create table "+Rno+"(sno int PRIMARY KEY AUTO_INCREMENT, sem varchar(26), subcode varchar(26), subtitle varchar(26),credits varchar(5), gradepoints varchar(2));");
			ps.executeUpdate();
			ps = conn.prepareStatement("insert into details values(?,?,?,?,?) ");
			ps.setString(1, Name);
			ps.setString(2, Rno);
			ps.setString(3, Dept);
			ps.setString(4, Sec);
			ps.setString(5, Mob);
			int x = ps.executeUpdate();
			if(x > 0)
				out.println("<script> alert(\"Data Added Successfully\") </script>");
			ps.close();
			conn.close();
			response.sendRedirect("index.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
        out.close();
		
		
	}

}
