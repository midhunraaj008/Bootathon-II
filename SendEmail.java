import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SendEmail", urlPatterns = {"/SendEmail"})
public class SendEmail extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String regno = "18tucs101";
    Connection conn;
    String name,email;
    String subject = "Semester Examination Result";
    String msg =  "Code-Subject-Credits-Grade\n";
    SendEmail()
    {
    	super();
        try {
			conn = DBConnection.Getconnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        PreparedStatement ps;
	    ResultSet rs;
	    String code;
    	int gp;
    	float credits,sumcredits=0,sumgp=0;
        final String username = "";//your email id
        final String password = "";// your password
        Properties props = new Properties();
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(username));
            MimeBodyPart textPart = new MimeBodyPart();
            Multipart multipart = new MimeMultipart();
            ps = conn.prepareStatement("select * from details where regno=?");
	    	ps.setString(1,regno);
	    	rs = ps.executeQuery();
	    	if(rs.next())
	    	{
	    			email = (rs.getString("regno")).toLowerCase()+"@skct.edu.in";
	    			name = rs.getString("name");
	    	}
	    	ps = conn.prepareStatement("select * from "+regno);
			rs = ps.executeQuery();
			while(rs.next()){
				code = rs.getString("subcode");
				subject = rs.getString("subtitle");
				credits = Float.parseFloat(rs.getString("credits"));
				gp = Integer.parseInt(rs.getString("gradepoints"));
				sumcredits += credits;
				sumgp += (float)gp*credits;
				msg += code+" "+subject+" "+credits+" "+gp+"\n";
			}
			msg += "CGPA = "+Float.toString(sumgp/sumcredits);
            String final_Text = "Name: " + name + "    " + "Email: " + email + "    " + "Subject: " + subject + "    " + "Mesaage: " + msg;
            textPart.setText(final_Text);
            message.setSubject(subject);
            multipart.addBodyPart(textPart);
            message.setContent(multipart);
            message.setSubject("Semester Examination Result");
            //out.println("Sending");
            Transport.send(message);
            out.println("<center><h2 style='color:green;'>Email Sent Successfully.</h2>");
            out.println("Thank you " + name + ", your message has been submitted to us.</center>");
        } catch (Exception e) {
            out.println(e);
        }
 	
    }

}