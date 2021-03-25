<%@page import="java.sql.*" %>


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


<nav class="navbar navbar-default navbar-inverse" role="navigation" >
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">SKCT Results</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">SKCT Results</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="index.html">Add Record</a></li>
        <li><a href="Studdet.html">Add Student</a></li>
        <li class="active"><a href="#">Post Mail</a></li>
        <li><a href="sendsms.jsp">Post SMS</a></li>
      </ul>
  <!--      
      <form class="navbar-form navbar-left" role="search" name="vinform">  
      <div class="form-group">
      <input type="search" name="name" class="form-control" placeholder="Search by Rollno" onkeyup="searchInfo()">  
      </div>
      <span id="mylocation"></span> 
      </form>  
 -->
      <ul class="nav navbar-nav navbar-right">
        <li class="active"><a href="logout.jsp">Logout</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div>
<br><br>
<center><h3>Search by Student rollno</h3>  
      <form name="vinform">  
      <input type="text"  class="form-control" STYLE="color: black;" name="name" onkeyup="searchInfo()">  
      </form>  
  </center>
<span id="mylocation"></span> 
		<br><br><br><br>
	</div>	
</body>

</html>