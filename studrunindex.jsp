<%@ page import="java.sql.*" %>  

<%
if(session.getAttribute("login")!=null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("stuindex.jsp");
}
%>

<%
try
{
	
Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "admin","");

	
	if(request.getParameter("btn_login")!=null) //check login button click event not null
	{
		String dbusername,dbpassword;
		
		String username,password;
		
		username=request.getParameter("txt_username"); //txt_username
		password=request.getParameter("txt_password"); //txt_password
		
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("select * from details where regno=? AND mobile=?"); //sql select query 
		pstmt.setString(1,username);
		pstmt.setString(2,password);
		
		ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.
		
		if(rs.next())
		{
			dbusername=rs.getString("regno");
			dbpassword=rs.getString("mobile");
			dbusername=dbusername.toLowerCase();
			dbpassword=dbpassword.toLowerCase();
			username=username.toLowerCase();
			password=password.toLowerCase();
			if(username.equals(dbusername) && password.equals(dbpassword))
			{
				session.setAttribute("login",dbusername); //session name is login and store fetchable database username address
				response.sendRedirect("stuindex.jsp"); //after login success redirect to welcome.jsp page
			}
		}
		else
		{
			request.setAttribute("errorMsg","invalid username or password"); //invalid error message for username or password wrong
		}
		
		con.close(); //close connection	
	}
	
}
catch(Exception e)
{
	out.println(e);
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>SKCT Results</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="images/icons/favicon1.ico"/>
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!-- 	<link rel="stylesheet" href="css/main1.css">
	<link rel="stylesheet" href="css/login-register.css"> -->
	<script>
		
		function validate()
		{
			var username = document.myform.txt_username;
			var password = document.myform.txt_password;
				
			if (username.value == null || username.value == "") //check username textbox not blank
			{
				window.alert("please enter username ?"); //alert message
				//username.style.background = '#f08080';
				username.focus();
				return false;
			}
			if (password.value == null || password.value == "") //check password textbox not blank
			{
				window.alert("please enter password ?"); //alert message
				//password.style.background = '#f08080'; 
				password.focus();
				return false;
			}
		}
			
	</script>

</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-5 p-b-20">
				<form class="login100-form validate-form" method="post" name="myform" onsubmit="return validate();">
					<span class="login100-form-title p-b-70">
						Welcome
					</span>
					<span class="login100-form-avatar">
						<img src="images/avatar-01.jpg" alt="AVATAR">
					</span>
                    <p style="color:red">				   		
					<%
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message for username or password 
					}
					%>
					</p>
					<div class="wrap-input100 validate-input m-t-25 m-b-35" data-validate = "Enter username">
						<input class="input100" type="text" name="txt_username">
						<span class="focus-input100" data-placeholder="Username"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-50" data-validate="Enter password">
						<input class="input100" type="password" name="txt_password">
						<span class="focus-input100" data-placeholder="Password"></span>
					</div>

					<div class="container-login100-form-btn">
					
						<button class="login100-form-btn" type="submit" name="btn_login" value="Login">Login</button>
						
						<!--  <button class="login100-form-btn">
							Login
						</button>-->
						
						
					</div>

 				<ul style="list-style-type:none;" class="login-more p-t-20" >
						<li class="m-b-8">
	
							<a href="runindex.jsp" class="txt2">
								Login as Admin
							</a>
						</li>

					</ul>
 	
				</form>
			</div>
		</div>
	</div>
		


	<div id="dropDownSelect1"></div>
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<script src="js/main.js"></script>

</body>
</html>