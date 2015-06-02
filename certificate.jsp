<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>





<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title>Certification </title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<!-- <link rel="stylesheet" href="css/style.css" type="text/css" media="all" /> -->
	<link rel="shortcut icon" href="css/images/ratico.ico" />
	<link rel="stylesheet" href="css/overview.css" type="text/css" media="all" /> 
        <link rel="stylesheet" type="text/css" href="css/style9.css" />
       
	   <script src="js/jquery.easing.js"></script>
		
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



<style>

#ratmenu{ height:37px; display:block; padding:0; margin:07px auto;  border:1px solid; border-radius:5px; } 
#ratmenu > ul {list-style:inside none; padding:0; margin:0;} 
#ratmenu > ul > li {list-style:inside none; padding:0; margin:0; float:left; display:block; position:relative;} 
#ratmenu > ul > li > a{ outline:none; display:block; position:relative; padding:12px 20px; font:bold 13px/100% Arial, Helvetica, sans-serif; text-align:center; text-decoration:none; text-shadow:1px 1px 0 rgba(0,0,0, 0.4); } 
#ratmenu > ul > li:first-child > a{border-radius:5px 0 0 5px;} 
#ratmenu > ul > li > a:after{ content:''; position:absolute; border-right:1px solid; top:-1px; bottom:-1px; right:-2px; z-index:99; } 
#ratmenu ul li.has-sub:hover > a:after{top:0; bottom:0;} 
#ratmenu > ul > li.has-sub > a:before{ content:''; position:absolute; top:18px; right:6px; border:5px solid transparent; border-top:5px solid #fff; } 
#ratmenu > ul > li.has-sub:hover > a:before{top:19px;} 
#ratmenu ul li.has-sub:hover > a{ background:#3f3f3f; border-color:#3f3f3f; padding-bottom:13px; padding-top:13px; top:-1px; z-index:999; } 
#ratmenu ul li.has-sub:hover > ul, #ratmenu ul li.has-sub:hover > div{display:block;} 
#ratmenu ul li.has-sub > a:hover{background:#3f3f3f; border-color:#3f3f3f;} 
#ratmenu ul li > ul, #ratmenu ul li > div{ display:none; width:auto; position:absolute; top:38px; padding:10px 0; background:#3f3f3f; border-radius:0 0 5px 5px; z-index:999; } 
#ratmenu ul li > ul{width:200px;} 
#ratmenu ul li > ul li{display:block; list-style:inside none; padding:0; margin:0; position:relative;} 
#ratmenu ul li > ul li a{ outline:none; display:block; position:relative; margin:0; padding:8px 20px; font:10pt Arial, Helvetica, sans-serif; color:#fff; text-decoration:none; text-shadow:1px 1px 0 rgba(0,0,0, 0.5); } 


#ratmenu ul li > ul li a.active{ background:#343336;} 

#ratmenu, #ratmenu > ul > li > ul > li a:hover{ background:#bf4143; background:-moz-linear-gradient(top,  #bf4143 0%, #a13742 100%); background:-webkit-gradient(linear, left top, left bottom, color-stop(0%,#bf4143), color-stop(100%,#a13742)); background:-webkit-linear-gradient(top,  #bf4143 0%,#a13742 100%); background:-o-linear-gradient(top,  #bf4143 0%,#a13742 100%); background:-ms-linear-gradient(top,  #bf4143 0%,#a13742 100%); background:linear-gradient(top,  #bf4143 0%,#a13742 100%); filter:progid:DXImageTransform.Microsoft.gradient( startColorstr='#bf4143', endColorstr='#a13742',GradientType=0 ); } 
#ratmenu{border-color:#712730;} 
#ratmenu > ul > li > a{border-right:1px solid #712730; color:#fff;} 
#ratmenu > ul > li > a:after{border-color:#f0696c;} 
#ratmenu > ul > li > a:hover{background:#8f2f34;}
#ratmenu > ul > li > a.active{background:#8f2f34;} 

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
		<li  ><a href="index.jsp">Home</a></li>
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
		<li class='has-sub'><a class='active'>Certifications</a>
			<ul>
				<li><a class='active' href="certificate.jsp" target="_top">Java Certifications</a></li>
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
					<h2>Certification Programs</h2>
	

            <h3 id="javacerti">Oracle Certifications</h3>
              <ul>
                <li>&nbsp;&nbsp; OCAJAVA</li>
                <li>&nbsp;&nbsp; OCPJP</li>
                <li>&nbsp;&nbsp; OCMJD</li>
                <li>&nbsp;&nbsp; OCPWCD</li>
                <li>&nbsp;&nbsp; OCPJWS</li>
                <li>&nbsp;&nbsp; OCPMAD</li>
                <li>&nbsp;&nbsp; OCMEA</li>
                
              </ul>
            
            <h3 id="mscerti">Microsoft Certifications</h3>
            
			  <ul class="level3">
                <li>&nbsp;&nbsp;Technology Specialist</li>
                <li>&nbsp;&nbsp;Professional Developer</li>
              </ul>
            
            <h3 id="oraclecerti">Oracle DataBase Certification</h3>
              <ul class="level3">
                <li>&nbsp;&nbsp;Introduction to Oracle9i: SQL</li>
                <li>&nbsp;&nbsp;Oracle9i: Program with PL/SQL</li>
                <li>&nbsp;&nbsp;Oracle9i: Database Administration Fundamentals I R2</li>
                <li>&nbsp;&nbsp;Oracle9i: Database Administration Fundamentals I R2</li>
                <li>&nbsp;&nbsp;Oracle 9i Database Performance Tuning R2 Ed2</li>
                <li>&nbsp;&nbsp;Oracle 9i Forms Developer: Build Internet Applications</li>
                <li>&nbsp;&nbsp;Data Warehousing Fundamentals Ed 1</li>
                <li>&nbsp;&nbsp;Data Warehouse Database Design</li>
                <li>&nbsp;&nbsp;Oracle9iAS: Discoverer for End Users Ed2</li>
                <li>&nbsp;&nbsp;Oracle Database 10g: New Features for Administrators Ed 2.1</li>
                <li>&nbsp;&nbsp;Oracle Database 10g: Introduction to SQL Ed 3</li>
                <li>&nbsp;&nbsp;Oracle Database 10g: Administration Workshop I Ed 3.1</li>
                <li>&nbsp;&nbsp;Oracle Database 10g: Administration Workshop II Ed 3.1</li>
                <li>&nbsp;&nbsp;Oracle Forms Developer 10g: Build Internet Applications Ed 2</li>
                <li>&nbsp;&nbsp;Oracle Reports Developer 10g:  Build Reports Ed 1</li>
                <li>&nbsp;&nbsp;Oracle Database 10g: Program with PL/SQL 2.1</li>
             </ul>
            
            <h3 id="redhatcerti">Redhat Certifications</h3>
              <ul>
                <li>&nbsp;&nbsp;Red hat linux Essential 033</li>
                <li>&nbsp;&nbsp;Red hat System Admin 133</li>
                <li>&nbsp;&nbsp;Red hat Security Admin 253</li>
              </ul>
            
            <h3 id="ugcerti">UGC approved Certifications</h3>
              <ul class="level3">
                <li>&nbsp;&nbsp;Certified professional in C Programming</li>
                <li>&nbsp;&nbsp;Certified Professional in Java Programming</li>
                <li>&nbsp;&nbsp;Certified Professional in Computer Programming</li>
                <li>&nbsp;&nbsp;Certified Professional in MY SQL</li>
                <li>&nbsp;&nbsp;Certified Professional in Linux Administrator</li>
                <li>&nbsp;&nbsp;Certified Professional in ASP.NET with C#.NET Programming</li>
                <li>&nbsp;&nbsp;Certified Professional in Web Programming</li>
                <li>&nbsp;&nbsp;Certified Professional in PHP Programming based Web designing</li>
                <li>&nbsp;&nbsp;Certified Professional in Advance Java Based Web Designing</li>
                <li>&nbsp;&nbsp;Certified Professional in C#.NET Programming</li>
                <li>&nbsp;&nbsp;Certified Professional in Oracle Database</li>
              </ul>
            
         
				
				
				
				
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


<!-- END Footer -->
</body>
</html>