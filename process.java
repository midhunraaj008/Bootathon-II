import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/process")
public class process extends HttpServlet {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
    {
    	response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String subcode1="",sem1="",subtitle1="",credits1="",gradepoints1="";
        
        String roll = request.getParameter("roll");
        String sem[] = request.getParameterValues("sem");
        String subcode[]=request.getParameterValues("subcode");
        String subtitle[]=request.getParameterValues("subtitle");
        String credits[]=request.getParameterValues("credits");
        String gradepoints[]=request.getParameterValues("gradepoints");
 
        try{
        	
        	Connection con = DBConnection.Getconnection();
           Statement st=null;
           st=con.createStatement();
          for (int i=0;i<subcode.length;i++)
           {	
        	  sem1 = sem[i];
        	  subcode1=subcode[i];
        	  subtitle1=subtitle[i];
        	  credits1=credits[i];
        	  gradepoints1=gradepoints[i];
        	  
            String sql="INSERT INTO `"+roll+"`(`sem`, `subcode`, `subtitle`, `credits`, `gradepoints`) VALUES ('"+sem1+"','"+subcode1+"','"+subtitle1+"','"+credits1+"','"+gradepoints1+"');";

                  int rs=st.executeUpdate(sql);
                 }
          response.sendRedirect("index.jsp");
          con.close();
      }catch(Exception e){
        e.printStackTrace();
      }
    }
}