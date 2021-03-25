<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>  
<%@ page import="java.io.*" %>  
<%@ page import="java.net.*" %>  
<%@ page import="java.util.*" %>  

<%
try
{	

	Class.forName("com.mysql.jdbc.Driver"); //load driver
	Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin","");
				
		String regno,mobile;
		String phone = null;
		String username = "admin";
		String password = "admin";
		String address = "http://192.168.1.101";
		String port = "8090";
		String code,subject,result;
		int gp;
		ResultSet rs1,rs2,rs3;
		float credits,sumcredits=0,sumgp=0;
		PreparedStatement ps1,ps2,ps3; //create statement		
		ps1=con1.prepareStatement("select regno from details"); //sql select query 
		rs1=ps1.executeQuery(); //execute query and store in resultset object rs.
		while(rs1.next())
		{
			Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin","");
			regno = rs1.getString("regno");
			result = "Code-Subject-Credits-Grade\n";
				ps2 = con2.prepareStatement("select * from "+regno);
				rs2 = ps2.executeQuery();
				while(rs2.next()){
					code = rs2.getString("subcode");
					subject = rs2.getString("subtitle");
					credits = Float.parseFloat(rs2.getString("credits"));
					gp = Integer.parseInt(rs2.getString("gradepoints"));
					sumcredits += credits;
					sumgp += (float)gp*credits;
					result += code+" "+subject+" "+credits+" "+gp+"\n";				
				}
				result += "CGPA = "+Float.toString(sumgp/sumcredits);
				System.out.println(result);

				Connection con3 = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin","");

				ps3 = con3.prepareStatement("select mobile from details where regno=?");
		    	ps3.setString(1,regno);
		    	rs3 = ps3.executeQuery();
		    	if(rs3.next())
		    			phone = rs3.getString("mobile");
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
		
		System.out.println("Message sent Successfully !");		
		response.sendRedirect("index.jsp");
	
}
catch(Exception e)
{
	out.println(e+"Full try");
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	    <style> 
input[type=text] {
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  border: 2px solid black;
  border-radius: 4px;
}
</style>
	    <link rel="stylesheet" href="css/nav.css">
	    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
	    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js">
	    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js">
	    <link rel="stylesheet" type="text/css" href="css/main.css">
		<title>SKCT Results</title>
		<script>  
        var request=new XMLHttpRequest();  
		function searchInfo(){  
		var name=document.vinform.name.value;  
		var url="db.jsp?val="+name;  
  
	try{  
		request.onreadystatechange=function(){  
		if(request.readyState==4){  
		var val=request.responseText;  
		document.getElementById('mylocation').innerHTML=val;  
		}  
		}
		request.open("GET",url,true);  
		request.send();  
		}catch(e){alert("Unable to connect to server");}  
		}  
		</script>  
		
	</head>	
<body>

</body>
</html>