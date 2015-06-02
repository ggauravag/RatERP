<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title>Overview </title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<!-- <link rel="stylesheet" href="css/style.css" type="text/css" media="all" /> -->
	<link rel="shortcut icon" href="css/images/ratico.ico" />
	<link rel="stylesheet" href="css/overview.css" type="text/css" media="all" /> 
        <link rel="stylesheet" type="text/css" href="css/style9.css" />
       <script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
	
	<script src="js/jquery.nivo.slider.pack.js" type="text/javascript" charset="utf-8"></script>
	
	<script src="js/functions.js" type="text/javascript" charset="utf-8"></script>
    

<script>
$(document).ready(function(){
  $("#button").click(function(){
    $("#div1").load("css/News.txt");
  });
});
</script>

<link rel="stylesheet" href="css/ratmenu.css" type="text/css" media="all" /> 
   
	
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
		
	<li><a href="career.jsp">Careers</a></li>
			
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
					<h2>Know us in Detail !!!</h2>
					<p>Road Ahead Technologies (I) Pvt. Ltd. incorporated in 2004 is an ISO 9001:2008 certified organization that operates through well-defined systems and procedures. We have been relentlessly endeavoring to provide end to end solutions to the Information Technology Industry with our expertise developed through the profound experience we continue contributing in training, consulting and Software Development Services,  all over Rajasthan.<Br>
					<br>
It provides information and resources on IT education, training, development and services for everyone involved in the sector - from students to educators and employers to employees. RAT through its strategic alliances with global leaders like Oracle formulates the link between individuals and agencies with IT skills, opportunities and solutions. <br>
<br>
This helps the students keep up to date with the latest learning and professional accreditation in the industry. It has been our mission to provide timely programs that 
respond to the needs of the industry, RAT has been at the forefront and has pioneered various training programs.</p>
				<p>&nbsp;</p>
					<h2 id=awards >AWARDS</h2>
					<p><ul>
                <li> &nbsp; Road Ahead Technologies is prometric  centre for oracle as well as for all the certification courses.</li>
              
                <li> &nbsp; We had a tie-up with a UGC approved State  University.</li>
              
                <li> &nbsp; We are providing an opportunity of doing  Live projects in various renound companies of IT sector.</li>
              
              
                <li> &nbsp; In a very short span, we have trained  more than 5000 IT professionals from almost every part of Rajasthan.</li>
              
              
                <li> &nbsp; More than 3000 trained professionals from  Road Ahead Technologies, Jaipur are presently working at some of the very  elite posts in the industry not &nbsp; only in India but in countries like United  States, U.K., Australia, etc. also.</li>
              
              
                <li> &nbsp; It also holds the most unique and most  easy way to learn Java and .net correspondence course packages &ldquo;based on  technical psyche&rdquo;.</li>
             
              
                <li> &nbsp; We specialize in providing a unique  summer training program for IT students across the country.</li>
                </ul></p>
				
				
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



<!-- END Footer -->
</body>
</html>


