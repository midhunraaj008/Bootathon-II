import java.sql.*;
public class DBConnection {

	public static Connection conn;
	
	public static Connection Getconnection() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/student";
        String dbUser ="admin";
        String dbPass ="";
        conn=DriverManager.getConnection(url,dbUser,dbPass);
        System.out.println("Connection Established");
        return conn;
	}
}
