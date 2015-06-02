<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title> Solutions </title>
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
		<li class='has-sub'><a>About Us</a>
			<ul>
				<li><a href="overview.jsp" target="_top">Overview</a></li>
				
				<li  class='last'><a href="managementteam.jsp">Management Team</a></li>
			</ul>
		</li>
		<li class='has-sub'><a  href="training.jsp">Trainings &amp; Courses</a>
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
		<li class='has-sub' ><a class='active'>Solutions</a>
			<ul >
				<li ><a class='active' href="solution.jsp" target="_top">Solutions for Corporates</a>
				
				<ul >
				<li><a href="solution.jsp" target="_top">Solutions for Corporates</a></li>
				<li><a href="solution.jsp#itlearn" target="_top">IT Learning Solutions</a></li>
				<li  class='last' ><a href="solution.jsp#college" target="_top">Solutions for Colleges</a></li>
			</ul>
				
				</li>
				<li><a href="solution.jsp#itlearn" target="_top">IT Learning Solutions</a></li>
				<li  class='last' ><a href="solution.jsp#college" target="_top">Solutions for Colleges</a></li>
			</ul>
		</li>
		<li class='has-sub'><a>Certifications</a>
			<ul>
				<li><a href="certificate.jsp" target="_top">Java Certifications</a></li>
				<li><a href="certificate.jsp#oraclecerti" target="_top">Oracle Certifications</a></li>
				<li><a href="certificate.jsp#mscerti" target="_top">Microsoft Certifications</a></li>
				<li><a href="certificate.jsp#redhatcerti" target="_top">Redhat Certifications</a></li>
				<li  class='last' ><a href="certificate.jsp#ugcerti" target="_top">UGC approved Certifications</a></li>
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
	
					<h2>Solutions for Corporates</h2>
					<p>Road Ahead  Technologies offers cutting-edge learning solutions to various companies, universities,  technology majors and training corporations. The company&rsquo;s expertise in  strategic consulting, design,&nbsp;customized content, off-the-shelf content, training  delivery, hi-end technology training, testing &amp; assessment, and learning  management enables large organisations to train&nbsp;cost effectively and  efficiently. It facilitates a learning environment that meets their existing  and emerging skills requirements. At RAT, we are committed to deliver high end  solutions with the right blend of knowledge, skills and expertise.</p>

	
					<h2 id = "itlearn">IT Learning Solutions</h2>
					<p>A dream of  creating a talent pool of bright young minds who would power the engine of  growth of IT industry give birth to Road Ahead Technologies &ndash; an organization  which started from a small  infrastructure of an institute with just 30 students in a small class room is  today a company providing learning &amp; knowledge solutions to more than 10000  students all over India. <br />
  &nbsp;<br />
            In last 6 years, RAT has successfully trained more than 3000 IT professionals who are presently working at some of the very  elite posts in the industry not only in India but in countries like United  States, U.K., Australia, etc.<br />
  Since the beginning, the emphasis has been on  the use of technology in education. Not only are all the education programs  technology-intensive but we also provide technology-based learning solutions to  leading corporates across the world. We also have partnership with UGC approved  state University to whom we are a provider of technology and content as well as  a partner in the formal education space.&nbsp;<br />
  <br />
            RAT&rsquo;s strong research orientation enables it to constantly innovate in the  areas of instructional design methodologies and curricula development. A unique  &ldquo;industry-endorsed curriculum,&rdquo; crafted by RAT enhances the employability of  learners and equips them for the real world of work. At the same time, the  company also addresses the skill requirements of IT professionals and engineers  who wish to upgrade their skills on new and emerging technologies. <br />
  <br />
         </p>

 </p>
          <p >Some Key learning  solutions for Individuals include the following: </p>
          <ul>
            <li>
              <h4> &nbsp; &nbsp;Technology Learning Solutions for Engineers </h4>
            </li>
          </ul>
          <p > RAT helps engineering students and  engineering graduates get acquainted with high-end technologies and meet  requirements across their academic lifecycle. </p>
          <ul>
            <li>
              <h4> &nbsp;&nbsp; Basic Computer Programs </h4>
            </li>
          </ul>
          <p > RAT  has created IT awareness programs to equip large  number of people with basic IT skills thereby bridging the digital divide.  Housewives, school and college students, senior citizens can enroll here &nbsp;to learn the basics of computers. </p>
          <ul>
            <li>
              <h4> &nbsp; &nbsp;Short Term Technology Programs </h4>
            </li>
          </ul>
          <p>It provides Programs in Alliance with major  software &amp; technology vendors like Microsoft, Pearson, Sun Microsystems,  Oracle, leading to global certifications.<br />
          </p>

		 	<h2 id = "college">Solutions for Colleges</h2>
					<p>It offers IT training programs for students in Universities and Colleges. The company has tied up with reputed University. It gives chance to students of colleges & universities to work on projects during Industrial Training programs are a unique combination of Technology learning and real life technical projects. The project helps the students to satisfy the university guidelines along with technical learning & experience.</p>

	

	
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


