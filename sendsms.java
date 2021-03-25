import java.io.IOException;
import java.sql.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sendsms")
public class sendsms extends HttpServlet {
	private static final long serialVersionUID = 1L;
    String regno = "18tucs101";
    Connection conn;
    public sendsms() {
        super();
        try {
			conn = DBConnection.Getconnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			
		String phone = null;
		String username = "admin";
		String password = "admin";
		String address = "http://192.168.1.101";
		String port = "8090";
	    PreparedStatement ps;
	    ResultSet rs;
	    String code,subject;
    	int gp;
    	float credits,sumcredits=0,sumgp=0;
    	String result = "Code-Subject-Credits-Grade\n";
		try {
			ps = conn.prepareStatement("select * from "+regno);
			rs = ps.executeQuery();
			while(rs.next()){
				code = rs.getString("subcode");
				subject = rs.getString("subtitle");
				credits = Float.parseFloat(rs.getString("credits"));
				gp = Integer.parseInt(rs.getString("gradepoints"));
				sumcredits += credits;
				sumgp += (float)gp*credits;
				result += code+" "+subject+" "+credits+" "+gp+"\n";
				System.out.println(result);
			}
			result += "CGPA = "+Float.toString(sumgp/sumcredits);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	    try{
	    	ps = conn.prepareStatement("select mobile from details where regno=?");
	    	ps.setString(1,regno);
	    	rs = ps.executeQuery();
	    	if(rs.next())
	    			phone = rs.getString("mobile");
	    }
	    catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    String message = "This is a Test !";
	    System.out.println(phone);
	    
	    
	    URL url = new URL(
				address+":"+port+"/SendSMS?username="+username+"&password="+password+
				"&phone="+phone+"&message="+URLEncoder.encode(result,"UTF-8"));
		
		URLConnection connection = url.openConnection();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		String inputLine;
		while((inputLine = bufferedReader.readLine()) !=null){
			System.out.println(inputLine);
		}
		bufferedReader.close();
	    
	}

}
