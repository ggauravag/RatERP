<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.login.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


       




%>
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title>..:: Login to RAT Panel ::.. </title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" ></meta>
	
	<link rel="shortcut icon" href="css/images/ratico.ico" ></link>
	
		<link rel="stylesheet" href="css/bootstrap.css" type="text/css"></link>
	<link rel="stylesheet" href="css/overview.css" type="text/css" media="all" ></link> 

        <link rel="stylesheet" type="text/css" href="css/style9.css"></link>
      <link rel="stylesheet" href="css/ratmenu.css" type="text/css" media="all" ></link> 
   
       <script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
		
	<script src="js/jquery.nivo.slider.pack.js" type="text/javascript" charset="utf-8"></script>
	
	<script src="js/functions.js" type="text/javascript" charset="utf-8"></script>
    

<script>
$(document).ready(function(){

  $("#button").click(function(){
    $("#div1").load("css/News.txt");
  });
});

function preventBack(){window.history.forward();}
  setTimeout("preventBack()", 0);
  window.onunload=function(){null};
</script>

  
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
	
	
	
	
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	
	
	</head>
<body>
<!-- Wrapper -->
	<div id="wrapper">
<div class="shell">



<table width="1000">

<tr>
<td>&nbsp;</td><td>&nbsp;</td>
<td  >
<img src ="css/images/rat.png" height = "110" width = "174"></img>
 
		<!-- Header -->
	</td>

		
    <td width="500">	
<h4 id="logo" align="right"><font size ="2" face="century gothic" color= "white"> If you don't design your own life plan,<br> chances are you'll fall into someone else's plan. <br>And guess what they have planned for you? Not much...</font></h4>
	<font face="brush script mt" size ="6" color= "Silver"><h5  align="right" title="RAT">Jim Rohn</h5></font>
    </td><td width="20">&nbsp;</td><td>
					
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
		<li class='has-sub'><a class='active' >About Us</a>
			<ul>
				<li><a class='active' href="overview.jsp" target="_top">Overview</a></li>
				
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
		<li class='has-sub'><a>Testimonials</a>
			<ul>
				<li><a href="employeestest.jsp">Employees</a></li>
				<li  class='last' ><a href="studenttest.jsp">Students</a></li>
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
		
<!-- 	<li><a href="career.jsp">Careers</a></li> -->
			
		<li ><a href="contactus.jsp">Contact</a>
		<li ><a href="login.jsp">Log In</a>		
	</ul>
</div>	

	<!-- END Header -->

		<!-- Navigation -->
		<!-- END Navigation -->
			<p>&nbsp;</p>
		
		
		<!-- Main -->
		
 		<div id="main">
			<div>
			 			<div class="large-col">
					<br>
					<br>
	 	<fieldset>
		<legend> &nbsp;&nbsp;Login to RAT Panel &nbsp;&nbsp;&nbsp;</legend>
		<p>&nbsp;</p>
		
		</fieldset>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			        <h4 class="modal-title" id="myModalLabel">Reset Password</h4>
			      </div>
			      <form method="post" class="form-horizontal" >
			      <div class="modal-body">
			        	
			        	
			        	
			        	
			        	
							<div class="form-group"> 
					 		    <label for="inputEmail" class="col-sm-3 control-label">Enter Email : </label> 
					 		    <div class="col-sm-7">  
					 		      <input type="email" name="email" class="form-control" id="inputEmail1" placeholder="Enter registered Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true"  ></input>
					 		    </div> 
					   		</div> 
			        	
			        	
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <input type="submit" value="Reset Password" name="reset" class="btn btn-primary" role="button" data-toggle="modal" data-target="#myModal" ></input>
			      </div>
			      </form>
			    </div>
			  </div>
		</div>
		
		
		
		
		
 		
 		
 		<%
  		String username = "";
  		String password = "";
  		if(request.getParameter("login") != null)
  		{
  			UserBean user = new UserBean(request.getParameter("username"), request.getParameter("password"));
  			if(user.isNew())
  			{
  				response.sendRedirect("ResetPassword.jsp?id="+AESCrypto.encrypt(user.getUserid())+"");
  				
  			}
  			else if(user.login())
  			{
  				if(request.getParameter("cookie")!=null)
  				{
  				Cookie c = new Cookie("_idRAT", AESCrypto.encrypt(user.getUserid()));
  				response.addCookie(c);
  				}
  				
  				
  				HttpSession hs = request.getSession();
  				hs.setMaxInactiveInterval(600);
  				hs.setAttribute("name", user.getName());
  				hs.setAttribute("id", user.getUserid());
  				
  				String utype = user.getUsertype();
  				if(utype.equals("ADMIN"))
  				{
  					hs.setAttribute("type","ADMIN");	
  				}
  				else if(utype.equals("STUDENT"))
  				{
  					hs.setAttribute("type", "STUDENT");
  				}
  				else if(utype.equals("HELPDESK"))
  				{
  					hs.setAttribute("type", "HELPDESK");
  				}
  				else if(utype.equals("TRAINER"))
  				{
  					hs.setAttribute("type", "TRAINER");
  				}
  				else if(utype.equals("DBA"))
  				{
  					hs.setAttribute("type", "DBA");
  				}
  				else
  				{
  					response.sendRedirect("Error.jsp");
  					return;
  				}
  				
  				response.sendRedirect("dashboard.jsp");
  			}
  			else
  			{
  				%>
  					<div class="alert alert-danger alert-dismissible fade in" id="message" role="alert" aria-hidden="true">
				      <span class="glyphicon glyphicon-remove"></span>
				      <strong>Incorrect email-id & password combination.</strong>
    				</div>
  				
  				<%
  			}
  			
  			
  			
  		}
  		
  		
		else if(request.getParameter("reset")!=null)
		{
			UserBean user = new UserBean(request.getParameter("email"),0);
			if(user.loginByEmail())
			{
				user.resetPassword(basePath);
				%>
					<div class="alert alert-success " role="alert"><span class="glyphicon glyphicon-ok"></span><strong> Success ! </strong>Password reset link has been mailed to you successfully.</div>
				<% 
			}
			else
			{
				%>
					<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-remove"></span><strong> Oh Snap ! </strong>Email entered is not registered with us.</div>
				<%
			}  			
		}
					   
  		
  		else
  			{
  				UserBean userold = null;
  				Cookie cookies[] = request.getCookies();
  				if(cookies != null)
  				{
  				
	  				for(int i = 0; i < cookies.length; i++)
	  				{
	  					if(cookies[i].getName().equals("_idRAT"))
	  					{
	  						userold = new UserBean(AESCrypto.decrypt(cookies[i].getValue().toString()));
	  						if(userold.loginByid())
	  						{
	  							username = userold.getUsername();
	  							password = userold.getPassword();
	  						}
	  						break;
	  					}
	  				}
  				}
  			}
   %>
 		
 		
 		
		
		
		
        <form action="login.jsp" method="post" role="form" name="login" class="form-horizontal"  > 
 		
 		<div class="form-group"> 
 		    <label for="inputEmail" class="col-sm-2 control-label">Email : </label> 
 		    <div class="col-sm-6">  
 		      <input type="email" name="username" class="form-control" id="inputEmail" placeholder="Enter registered Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true" value="<%=username%>" >
 		    </div> 
   		</div> 
  		
 		<div class="form-group" > 
 		    <label for="inputPassword" class="col-sm-2 control-label">Password : </label> 
 		    <div class="col-sm-6"> 
 		      <input type="password" class="form-control" required="true" id="inputPassword" placeholder="Enter Password" name="password" value="<%=password%>"> 
 		    </div> 
 		    <div class="col-md-2">
 				<a  role="button" data-toggle="modal" data-target="#myModal" > Forgot Password ? </a> 
 			</div> 
   		</div> 
 				<div class="form-group"> 
 				    <div class="col-sm-offset-2 col-sm-2"> 
 				      <div class="checkbox"> 
 				      <input style="margin-top:1px;" type="checkbox" name="cookie" value="y">
 				        <label> 
 				           Remember me 
 				        </label> 
 				        </div>
 				        </div>
 				        
				      
 				      
 		    	</div> 
   		</div>	 
 		<div class="form-group"> 
 		    <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" class="btn btn-primary" value="Log In" name="login" /> 
 		     
 		    </div>
   		</div> 
   		
   		<div class="form-group"> 
 		    <div class="col-sm-3"> 
 		     <input type="reset" class="btn btn-default" /> 
 		     
 		    </div>
   		</div> 
		</form>
		
						
				
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
	
		<p class="footer-nav"><a href="index.jsp" title="Home">Home</a><span>|</span><a href="overview.jsp" title="About">About</a><span>|</span><a href="certificate.jsp" title="Certifications">Certifications</a><span>|</span><a href="training.jsp" title="Training and Courses">Courses</a><span>|</span><a href="packages.jsp" title="Packages">Packages</a><span>|</span><a href="solution.jsp" title="Solutions">Solutions</a><span>|</span><a href="contactus.jsp" title="Contacts">Contacts	</a></p>
		<p class="copy">Copyrights &copy; Road Ahead Technologies IPL 2014</p>
		<p>Developed & Maintained By <a target="_blank" href="http://www.dreambit.in" >DreamBit Technologies</a></p>
				
		
		</div>
</div>

<script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>


