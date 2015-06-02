<%@page import="sun.security.krb5.internal.crypto.Aes128"%>
<%@ page language="java" import="java.util.*,com.login.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Connection con = DBInfo.getConn();

	try
	{
	
	String encryptedid = request.getParameter("id");
	encryptedid.replace(" ", "+");
	String stid = AESCrypto.decrypt(encryptedid);
	
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">





<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title>Student Testimonials </title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<!-- <link rel="stylesheet" href="css/style.css" type="text/css" media="all" /> -->
	<link rel="shortcut icon" href="css/images/ratico.ico" />
	<link rel="stylesheet" href="css/overview.css" type="text/css" media="all" /> 
 	<link rel="stylesheet" href="css/ratmenu.css" type="text/css" media="all" /> 
   
    <link rel="stylesheet" type="text/css" href="css/style3.css" />
    <script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
	
	<script src="js/jquery.nivo.slider.pack.js" type="text/javascript" charset="utf-8"></script>
	
	<script src="js/functions.js" type="text/javascript" charset="utf-8"></script>
   
<link rel="stylesheet" type="text/css" href="css/querystyle.css" />
    
  

<script> 
$(document).ready(function(){
  $("#flip").click(function(){
    $("#panel").slideToggle("slow");
  });
});


</script>

<style type="text/css" >
#panel
{
display:none;
}
</style>
	
	</head>		
<body>
<!-- Wrapper -->
<div id="wrapper">
<div class="shell">

<script>
function facebook(){
var features ="left=300,top=100,menubar=no,location=no,width=800,height=550";
window.open("https://www.facebook.com/RAT.jaipur","Connect us on facebook",features);

}
function twitter(){
var features ="left=300,top=100,menubar=no,location=no,width=800,height=550";
window.open("http://www.twitter.com","Follow us on twitter",features);

}
</script>

<table width="1000">

<tr>
<td>&nbsp;</td><td>&nbsp;</td>
<td  >
<img src ="css/images/rat.png" height = "110" width = "174">
 
		<!-- Header -->
	</td>
<%
				try
				{
					if(request.getParameter("submit")!=null)
					{
						String id = request.getParameter("id").replace(" ", "+");
						String message = request.getParameter("password");
						
						
						String stmt = "update user set password = ? where userid = ?";
						PreparedStatement ps = con.prepareStatement(stmt);
						
						
						//System.out.println("Password is : "+message+", userid : "+id);
											
						ps.setString(1, AESCrypto.encrypt(message));
						ps.setString(2, AESCrypto.decrypt(id));
						
						
						int i = ps.executeUpdate();
						
						if(i==1) 
						{
							session.setAttribute("test", "true");	
							
							
						}
						else
						{
							session.setAttribute("test", "false");	 
							
							
						}
						
							
					}
								
				}
				catch(Exception e)
				{
					session.setAttribute("test", "false");
					e.printStackTrace();
				}
				 %>
		
    <td width="500">	
<h4 id="logo" align="right"><font size ="2" face="century gothic" color= "white"> If you don't design your own life plan,<br> chances are you'll fall into someone else's plan. <br>And guess what they have planned for you? Not much...</font></h4>
	<font face="brush script mt" size ="6" color= "Silver"><h5  align="right" title="RAT">Jim Rohn</h5></font>
    </td><td width="20"></td><td>
					
					<div class="socials">
						<a  onclick="facebook();" class="facebook-ico">facebook</a>
						<a onclick="twitter();" class="twitter-ico">twitter</a>
					</div>
					<div class="cl">&nbsp;</div>
				 
				<div class="cl">&nbsp;</div>
	</td></tr></table >	
			<div id='ratmenu'>
<ul>
		<li  ><a  href="index.jsp">Home</a></li>
		<li class='has-sub'><a>About Us</a>
			<ul>
				<li><a href="overview.jsp" target="_top">Overview</a></li>
				
				<li  class='last'><a href="managementteam.jsp">Management Team</a></li>
			</ul>
		</li>
		<li class='has-sub'><a href="training.jsp">Trainings &amp; Courses</a>
			<ul>
				<li><a href="individual.jsp">Individual Courses</a></li>
				<li><a href="training.jsp">Corporate Training</a></li>
				<li><a href="summertraining.jsp">Summer Training</a></li>
				<li  class='last'><a href="sixmonthtraining.jsp">6 Months Training</a></li>
			</ul>
		</li>
		<li class='has-sub'><a class='active'>Testimonials</a>
			<ul>
				<li><a  href="employeestest.jsp">Employees</a></li>
				<li  class='last' ><a class='active' href="studenttest.jsp">Students</a></li>
			</ul>
		</li>
		<li class='has-sub'><a>Solutions</a>
			<ul >
				<li><a href="solution.jsp" target="_top">Solutions for Corporates</a></li>
				<li><a href="solution.jsp" target="_top">IT Learning Solutions</a></li>
				<li  class='last' ><a href="solution.jsp" target="_top">Solutions for Colleges</a></li>
			</ul>
		</li>
		<li class='has-sub'><a>Certifications</a>
			<ul>
				<li><a href="certificate.jsp" target="_top">Java Certifications</a></li>
				<li><a href="certificate.jsp" target="_top">Oracle Certifications</a></li>
				<li><a href="certificate.jsp" target="_top">Microsoft Certifications</a></li>
				<li><a href="certificate.jsp" target="_top">Redhat Certifications</a></li>
				<li  class='last' ><a href="certificate.jsp" target="_top">UGC approved Certifications</a></li>
			</ul>
		</li>
		
	<li><a href="career.jsp">Careers</a></li>
			
		<li ><a href="contactus.jsp">Contact</a>
			<li ><a href="login.jsp">Log In</a>
	</ul>
</div>	

	<!-- END Header -->


	<!-- END Header -->
		<!-- Navigation -->
		<!-- END Navigation -->
			<p>&nbsp;</p>
	

		<!-- Main -->
	
		<div id="main">
		
			
	
		
			<div>
			<div class="large-col">
					<h2>Reset Password</h2>




				
				</div>
					<p>&nbsp;</p>
			<p>&nbsp;</p>
				
   
<div >

			<div align="center">

		
		
		<p align="center"><font size="4" color="green" face="century gothic"><b>Give your new password</b></font></p>
					
		<div id="contact-area">
			<p style="color:red;" id="msg" ></p>
			<form name="Form1" method="post"   action="">
				<input type=hidden name=id value="<%=stid%>">
				<label for="Name">New:</label>
				<input type="password"  id="pass1" required/>
				
				<label for="Message">Confirm :</label><br />
				<input type="password" name="password" id="pass2" required/>

				<input type="submit" name="submit" value="Reset" class="submit-button" onclick="return validate();" />
			</form>
			
			<div style="clear: both;"></div>
		</div>
	
	</div>
			</div>
			
			</div>
			<div class="cl">&nbsp;</div>
			</div>
		    </div>
			<p>&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p>&nbsp;</p>
			
		    <!-- END Main -->
	</div>

      </div>
	<div id="footer-push">&nbsp;</div>
</div> 
<!-- END Wrapper -->

<!-- Footer -->
<div id="footer">
	<div class="shell">
	
		<p class="footer-nav"><a href="front.html" title="Home">Home</a><span>|</span><a href="overview.jsp" title="About">About</a><span>|</span><a href="certificate.jsp" title="Certifications">Certifications</a><span>|</span><a href="training.jsp" title="Training and Courses">Courses</a><span>|</span><a href="packages.jsp" title="Packages">Packages</a><span>|</span><a href="solution.jsp" title="Solutions">Solutions</a><span>|</span><a href="contactus.jsp" title="Contacts">Contacts	</a></p>
		<p class="copy">Copyrights &copy; Road Ahead Technologies IPL 2013</p>
		<p>Developed & Maintained By <a target="_blank" href="http://www.dreambit.in" >DreamBit Technologies</a></p>
				
		
		</div>
</div>
<%
	}
	catch(Exception e)
	{
		e.printStackTrace();
		response.sendRedirect("Error.jsp");
	}
	finally
	{
				  if (con != null)
				  {
				     try 
				     { 
				     	con.close(); 
				     } 
				     catch (Exception e) 
				     { 
				     	e.printStackTrace();
				     } 
				  }
	}

 %>

<!-- END Footer -->
<script type="text/javascript">

	function preventBack(){window.history.forward();}
  setTimeout("preventBack()", 0);
  window.onunload=function(){null};
  
  function Redirect()
	{
    window.location="<%=basePath%>login.jsp";
	}
  
  	<%
  		if(session.getAttribute("test")!=null && session.getAttribute("test").equals("true"))
  		{
  			%>
  				setTimeout('Redirect()', 500);
  				alert('Your password has been reset successfully');
  				
  			<%
  		
  		}
  	
  	%>
  


	function validate()
	{
		var pass1 = document.getElementById("pass1").value;
		var pass2 = document.getElementById("pass2").value;
		
		if(pass1 == pass2)
		{
			document.getElementById("msg").innerHTML = "";
			return true;
		}
		else
		{
			document.getElementById("msg").innerHTML = "Both passwords does not match.";
			return false;
		}
	
	}

</script>
</body>
</html>


