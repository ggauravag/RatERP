<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.login.*,java.sql.ResultSet" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Connection con = null;
%>







<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title>Individual Courses</title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<link rel="shortcut icon" href="css/images/ratico.ico" />
	<link rel="stylesheet" href="css/overview.css" type="text/css" media="all" /> 
        <link rel="stylesheet" type="text/css" href="css/style3.css" />
       <script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
	<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js">
--></script>

	

	<script src="js/jquery.nivo.slider.pack.js" type="text/javascript" charset="utf-8"></script>
	
	<script src="js/functions.js" type="text/javascript" charset="utf-8"></script>
   
   <link rel="stylesheet" type="text/css" href="css/querystyle.css" />
    <script>
    function validateForm()
{
var x=document.forms["Form1"]["email"].value;
var name=document.forms["Form1"]["name"].value;
var city=document.forms["Form1"]["city"].value;
var college=document.forms["Form1"]["collegename"].value;
var query=document.forms["Form1"]["query"].value;

var atpos=x.indexOf("@");
var dotpos=x.lastIndexOf(".");

if(name==null || name=="")
{
alert("Please enter your name");
document.Form1.name.focus();
return false;
}
else if(city==null || city=="")
{
alert("Please enter your city");
document.Form1.city.focus();
return false;
}
else if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
  {
  alert("Not a valid e-mail address");
  document.Form1.email.focus();
  return false;
  }
 else if(college==null || college=="")
{
alert("Please enter your college name");
document.Form1.collegename.focus();
return false;
}else if(query==null || query=="")
{
alert("Please write some text !!!");
document.Form1.query.focus();
return false;
} 
}
 </script>

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


<script>
$(document).ready(function(){
  $("#button").click(function(){
    $("#div1").load("css/News.txt");
  });
});
</script>



    <link rel="stylesheet" href="css/ratmenu.css" type="text/css" media="all" />


	
	</head>		
<body>&nbsp; 
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
    </td><td width="20">=</td><td>
					
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
		<li class='has-sub'><a class='active' href="training.jsp">Trainings &amp; Courses</a>
			<ul>
				<li><a class='active' href="individual.jsp">Individual Courses</a></li>
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

	<!-- END Header -->
		<!-- Navigation -->
		<!-- END Navigation -->
			<p>&nbsp;</p>
		
		<!-- Main -->
		<div id="main">
		
	<h2><font size=6>Core Java</font></h2>
	<p>This Java training course  provides extensive experience with the Java language and its object-oriented  features. In this Java training course, you use Java to create text-based and  GUI applications. Active Learning provides other Java training courses covering  more advanced technologies. Recently updated to cover the Java 6 platform, this  course will also benefit professionals who wish to take the Sun Certified Java  Programmer (SCJP) certification.</p>
	<p>&nbsp;</p>
			<p>&nbsp;</p>
			<h3>Duration: 90 Hrs</h3>
			
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			
			<h4>Who should attend :</h4>
			
			<p>&nbsp;</p>
			<ul>
			<li><p>&nbsp;&nbsp; Those working towards building  skills in Java based application development. Prior knowledge of C programming  language is not must in Road Ahead for learning Java here.</p>	
			</li></ul>
			
	
	
		<p>&nbsp;</p>
				<p>&nbsp;</p>
<p class="a-link"><a href="individual.jsp" class="btn-gray" title="Back"><span>Back</span></a></p>				
			<p>&nbsp;</p>

                   </div>
				<ul id="flip" class="ca-menu">
                    <li >
                    <a>
                         <span class="ca-icon">Z</span>
                            <div class="ca-content">
                                <h2 class="ca-main">What you want to know ?</h2>
                                <h3 class="ca-sub">Let us help you!!</h3>
                            </div>
                        </a>
                    </li>
    </ul>
    
<div id="panel">
			<div id="page-wrap">

		
		
		<p align="center"><font size="4" color="red" face="century gothic"><b>You may write here</b></font></p>
					
		<div id="contact-area">
			
			<form name="Form1" method="post" onsubmit="" action="">
				<label for="Name">Name:</label>
				<input type="text" required="true" name="name" id="name" />
				
				<label for="City">Mobile:</label>
				<input type="text" required="true" name="mobile" id="mobile" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number"/>
	
				<label for="Email">Email:</label>
				<input type="email" required="true" name="email" id="email" placeHolder="Example: abc@xyz.com"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" title="Please enter a valid email address" />
				
				<label for="Collegename">College:</label>
				<input type="text" name="collegename" id="collegename" />
				
				<input type="hidden" name="course" value="1">
				
				<label for="Query">Query:</label><br />
				<textarea name="query" required="true" rows="20" cols="20" id="query"></textarea>
				
				

				<input type="submit" name="submit" value="Submit" class="submit-button" />
			</form>
				</div>
				
				</div></div>
				<p>&nbsp;</p>
				
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				
				<%
				
				try
				{
					con = DBInfo.getConn();
					if(request.getParameter("submit")!=null)
					{
						String name = request.getParameter("name");
						String mobile = request.getParameter("mobile");
						String email = request.getParameter("email");
						String college = request.getParameter("collegename");
						String query = request.getParameter("query");
						String course = request.getParameter("course");
					
						String stmt = "insert into inquiry values(?,?,?,?,?,?)";
						PreparedStatement ps = con.prepareStatement(stmt);
						
						java.util.Date d = new java.util.Date();
						java.text.SimpleDateFormat format = new java.text.SimpleDateFormat ("yyyyMM");
					
						String sid=format.format(d).substring(2);
						
						sid=sid+"/OT/";
						String query1 = "select query from count_user";
						PreparedStatement ps1 = con.prepareStatement(query1);
						ResultSet rs1 = ps1.executeQuery();
						
						int count = 0;
						if(rs1.next())
							count = rs1.getInt(1);
						
						sid += String.format("%05d", count);						
						ps.setString(1, sid);
						ps.setString(2, name);
						ps.setString(3, mobile);
						ps.setString(4, email);
						ps.setString(5, course);
						ps.setString(6, query);
						
						int i = ps.executeUpdate();
						if(i==1)
						{
							%>
								<div class="alert alert-success " role="alert"><span class="glyphicon glyphicon-ok"></span> Thank You ! We will respond to your query soon ! <br> Your Query ID is : <strong><%=sid %>.</strong> Keep it for future reference. </div>
							<%
						}
						else
						{
							%>
								<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-remove"></span><strong> Oh Snap ! </strong>Something went wrong while processing your query. Please try again !</div>
							<% 
						}
							
					}
									
				}
				catch(Exception e)
				{
					e.printStackTrace();
					SendMail.sendReport(e, basePath);
				}
				finally
				{
				  if (con != null)
				  {
				     try 
				     { 
				     	con.close(); 
				     	System.out.println("Connection closed");
				     } 
				     catch (Exception e) 
				     { 
				     	e.printStackTrace();
				     } 
				  }
				}
				 %>
				
				
				
				
				
				<!--<p class="a-link"><a href="courseds.jsp" class="btn-red" title="Data Structure"><span>Data Structure</span></a></p>
				<p class="a-link"><a href="course9i.jsp" class="btn-red" title="Oracle 9i"><span>Oracle 9i</span></a></p>				
				<p class="a-link"><a href="coursest.jsp" class="btn-red" title="Software Testing"><span>Software Testing</span></a></p>				
				
				
				-->
				
				
				
				</div>
		
			</div>	</div>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
				
			
			<div style="clear: both;"></div>
		</div>
	
	</div>
			<div class="cl">&nbsp;</div>
		
		    
			<p>&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p>&nbsp;</p>
		    <!-- END Main -->
		    
		      
	</div>
</div></div>
      
	<div id="footer-push">&nbsp;</div>

<!-- END Wrapper -->

<!-- Footer -->
<div id="footer">
	<div class="shell">
	
		<p class="footer-nav"><a href="front.html" title="Home">Home</a><span>|</span><a href="overview.html" title="About">About</a><span>|</span><a href="certificate.html" title="Certifications">Certifications</a><span>|</span><a href="training.html" title="Training and Courses">Courses</a><span>|</span><a href="packages.html" title="Packages">Packages</a><span>|</span><a href="solution.html" title="Solutions">Solutions</a><span>|</span><a href="contactus.html" title="Contacts">Contacts	</a></p>
		<p class="copy">Copyrights &copy; Road Ahead Technologies IPL 2013</p>
		<p>Developed & Maintained By <a target="_blank" href="http://www.dreambit.in" >DreamBit Technologies</a></p>
				
		
		</div>
</div>



<!-- END Footer -->
</body>
</html>
