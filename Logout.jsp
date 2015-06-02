<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String name = (String)session.getAttribute("type");
	String type = (String)session.getAttribute("name");
	if(name!= null && type!= null)
	{
		System.out.println("Name : "+name+" , Type : "+type);
		session.removeAttribute("name");
		session.removeAttribute("type");
		session.invalidate();
		//response.setHeader("Refresh", "0; URL="+basePath+"index.jsp");
		System.out.println("URL Is : "+basePath+"index.jsp");
	}
	

%>

<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title>..:: Log Out ::.. </title>
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
	function Redirect()
	{
    window.location="<%=basePath%>";
	}


setTimeout('Redirect()', 1000);



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
		<legend> &nbsp;&nbsp;You have been successfully logged out. &nbsp;&nbsp;&nbsp;</legend>
		<p>&nbsp;</p>
		
		</fieldset>
		
		
 		
 		
 		
 		
 		
 		
		
		
		
      
						
				
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
		<p class="copy">Copyrights &copy; Road Ahead Technologies IPL 2013</p>
		<p>Developed & Maintained By <a target="_blank" href="http://www.dreambit.in" >DreamBit Technologies</a></p>
				
		
		</div>
</div>

<script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>


