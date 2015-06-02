<%@ page language="java" import="java.util.*,com.login.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Connection con = null;

	try
	{
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Driver loaded");
			String url="jdbc:mysql://localhost:3306/raterp";
			String username="root";
			String password="rat";
			
			con=DriverManager.getConnection(url,username,password);
		

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
						String id = request.getParameter("stid");
						String message = request.getParameter("message");
						
						
						String stmt = "insert into testimonials values((select studentid from student where email=?),?);";
						PreparedStatement ps = con.prepareStatement(stmt);
						
						
											
						ps.setString(1, id);
						ps.setString(2, "\"  "+message+"  \"");
						
						
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
					SendMail.sendReport(e, basePath);
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
					<h2>Student Reviews</h2>

<p>" Taking decision is the hardest thing which we usually face in our life and same condition was mine before joining RAT , since i have to choose 1 institute among several center points and wrong decision can spoil your career but risk is everywhere so I  choose RAT and there i met Mr. Abhishek Jain, his encouraging nature and 24 X 7 help forced me to say that My decision was Right &rdquo; 
<br><br>
<div style="display:inline">

<h3 align=right  >Kshitij Kulshrestha </h3> 
<p align=right ><font color=#0066cc style="inline:inline">JECRC-UDML</font></p>
</div>
</p>


	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" Truly , I experienced a great while studying over here since there was no formality rather reality and I want to thanks Mr. Abhishek Jain to provide us every facility and his help anytime. <br><br><h3 align=right>Vinita Baniwal </h3> <p align=right><font color=#0066cc>JECRC-UDML</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>This institue Deserves the excellency, since they work hard to create our path simple . <br><br><h3 align=right>Anuj Mathur </h3> <p align=right><font color=#0066cc>JECRC-UDML</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>Awesome Experience , really i found a treasure over here ... :) <br><br><h3 align=right>Shrishma Taksali </h3> <p align=right><font color=#0066cc>JECRC-UDML</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p> " I enrolled in the Advance Java Class and would like to take  this opportunity to thank my trainer for their able guidance and great project  oriented approach. As a result of the trainers good industry exposure we have  got into good company without much of a problem in the technical round. He was  very knowledgeable and clearly he has got industry experience. I feel, overall  the training went very well!  <br><br><h3 align=right>Abhishek Dadhich </h3> <p align=right><font color=#0066cc>N/A</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p> " My instructor was really very experienced and had a good domain experience in  project implementation. His guidance has made things possible which otherwise  would have been immensely difficult for me to take up the wide challenges of  Java, myself being from non-IT background. I am very glad I took training from  Road Ahead and landed in a good company. <br><br><h3 align=right> Ankita Priyadarshini </h3> <p align=right><font color=#0066cc>N/A</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p> " I was a student in PHP, and now I myself have become a  good trainer in our office. Thanks to step by step approach to master the  training sessions and thereafter good experience of my faculty member has made  things easy for me. My path is now really moving in great pace and I hope to  catch with the industry experts very soon. " <br><br><h3 align=right>Deepak Jain </h3> <p align=right><font color=#0066cc>N/A</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>&quot;" I really would like to take this opportunity to thank  Mr. Abhishek Jain and for all their help throughout my training. I found him to  be amazing&nbsp; and genuine guide. He is always available through phone or  internet or chat to even solve the most trivial queries or doubts of mine. Thanks a lot Sir !!!   "<br><br><h3 align=right>Madhusudhan Sharma </h3> <p align=right><font color=#0066cc>N/A</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" Joining Rat was Mile Stone of my Carrier. The Practical knowledge whatever i learn was Helpful for me At the Time of Placement. At now i am Working as Web Designer ..At Concierge Technologies.
All Credit Goes to RAT..:):)  "<br><br><h3 align=right>Subodh Sharma </h3> <p align=right><font color=#0066cc>JECRC UDML</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" Really great experience with RAT 
and thanks to Mr. Abhishek Jain, his encouraging nature, his help me every time "<br><br><h3 align=right>Gaurav khandelwal  </h3> <p align=right><font color=#0066cc>RITM</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" I really would like to  thank Mr. Abhishek Jain and for all their help throughout my training. I found him like friendly-nature  with student . i think r@t is the place where u changed ur dreams in reality . Thank U Sir !!! "
 <br><br><h3 align=right>Vikram saini </h3> <p align=right><font color=#0066cc>Govt.Engg.College,Bikaner(ecb) </font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" The Best Experience i have ever had of learning programming is at RAT.They does not make you better,they make you best. RAT is a place which improves yourself apart from looking at others.
Thank You RAT !!!! "<br><br><h3 align=right>Hemant </h3> <p align=right><font color=#0066cc>B.K. Birla institute Of Engineering & Technology-Pilani</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" I think this is my best decision of joining rat. practical knowledge of java given by Abhishek sir is very useful and helpful in my working. I got placement in campus placement and credit goes to RAT. "
Thank you RAT and Specially thanks to Abhishek sir. "
 <br><br><h3 align=right>Mitesh Bharti </h3> <p align=right><font color=#0066cc>UDML</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" I would like to thank Mr. Abhishek Jain sir, for providing the best J2SE & J2EE training. He is very knowledgeable and experienced in his subject matter. He was always there to help.it is really awesome.... "<br><br><h3 align=right>Kuldeep Choudhary </h3> <p align=right><font color=#0066cc>RITM-Jaipur</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" RAT is my second step.it develops programming concept  mind in me. big thanks for mr. abhishek sir that helping and encouraging me. " <br><br><h3 align=right>Vikas </h3> <p align=right><font color=#0066cc>SKIT</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" I heartily congratulate RAT for the milestone. I did my J2EE and beyond that, Abhishek sir helped me a lot in securing admission into prestigious Cornell University with his recommendation letters.Its been an awesome journey for RAT til now and hoping that RAT will open several branches all over Rajasthan to provide training which will be of great help to future engineers. "<br><br><h3 align=right>Saikiran M </h3> <p align=right><font color=#0066cc>Masters in C.S</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" It was a great experience.i never expected it to make it possible as i had a great fear that i wont do better in java...there is gratification all around in training institutes but RAT is platform where i learnt team work,it made java easy for me and really great training center...i got placed at 3 companies and the thing that made it possible is java and really grateful to Mr.Abhishek jain sir..nw m being able to
undrstand projects requirments and can put requirments into d real word projects..this is the great experience with rat now i can prove myself at java among the best candidates.... "<br><br><h3 align=right>Pooja Sharma </h3> <p align=right><font color=#0066cc>Global Institute of Technology</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" Training experience with RAT was "Awesome". 24x7 help provided by the  institute via mail,text msgs,direct contact with Abhishek Sir was really  beneficial. Special "problem solving" classes conducted by sir each week,was an additional boon. Moreover , the friendly environment made by sir by his  humour brilliance,interactive jokes,was one more profit.Benefits of training includes , the really updated knowledge given to students. 
Programming at RAT helped me a lot.1000 s of examples provided by sir develops a thinking in you.Projects developed by me are great examples.I have myself developed many new features that I thought was sometimes ago impossible for me. Best part was that - sir helped all of us by solving our problems on our own laptops. Sir provided the working Apps. of Android on your own phones , so you 
have the complete working , error free apps. with you.
Overall experience was lovely. If we needed instant help , sir mailed us all the  programs and codes for our working projects. Special techniques with new languages and frameworks were provided by him for ease and short code  developing. "<br><br><h3 align=right>Chayan Bhatnagar </h3> <p align=right><font color=#0066cc>Global Institute of Technology</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" Rat is the best training center in the Jaipur for technical training because it provided the fully practical study. In rat the project are live presented at training time in class . .Befor going to RAT my confidence level was zero but In one month training only ,i made 3 projects in java, and not i m quite condidence in java and whole credit goes to only RAT ... "
 <br><br><h3 align=right>Pavan Kumar </h3> <p align=right><font color=#0066cc>Arya College Of Engineering & Research Center ,Kukas Jaipur</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" Road Ahead Technologies truly stands by its name.
My training experience at RAT in Advance Java helped me a lot to gain self confidence and an insight into the development environment. The practical approach, live programming technique, availability of Abhishek Sir and his motivational words paved the way for maximum gains in squeezed time frame of 45 days.
Wish the organisation heartiest congratulations and promise that it will continue setting the best standards in the field. " <br><br><h3 align=right>Himanshu Kala </h3> <p align=right><font color=#0066cc>SKIT</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" Rat provide me a very precious knowledge about computer programing before this my programing is not well i think that i can not program easily but from Rat I have got so much and i alway thanks to sir for their help........ "<br><br><h3 align=right>Keyur </h3> <p align=right><font color=#0066cc>SKIT</font></p></p>	
<hr><p>&nbsp;</p>

<p>&nbsp;</p>	
<p>" I did my summer training in J2EE, android and oracle in 2013.
I had learnt a lot there and it played an important role in my placement at  Cybage software,Pune. According to me it is the best institute for training. Thanks to the entire team of RAT. " <br><br><h3 align=right>Vineeta Rohila </h3> <p align=right><font color=#0066cc>BK Birla Institute of Engineering and Technology,Pilani</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" rat is best place for learning.. and would u like to do something than abhishek sir nd ritesh sir guides u..  " <br><br><h3 align=right>Nikhil Sharma </h3> <p align=right><font color=#0066cc>Poornima College of Engineering,jaipur</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>
" Road Ahead Technologies truly stands by its name. My training experience at RAT in Advance Java helped me a lot to gain self confidence and an insight into the development environment. The practical approach, live programming technique, availability of Abhishek Sir and his motivational words paved the way for maximum gains in squeezed time frame of 45 days. Wish the organisation heartiest congratulations and promise that it will continue setting the best standards in the field. "  <br><br><h3 align=right>Anand Kumar Saini </h3> <p align=right><font color=#0066cc>Govt. college of Engineering and Technology,Bikaner</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<p>" Truly got best training on java "<br><br><h3 align=right>Vishwanath Kumar </h3> <p align=right><font color=#0066cc>JECRC Jaipur</font></p></p>	
<hr><p>&nbsp;</p>
<p>&nbsp;</p>	
<%
	PreparedStatement stmt1 = con.prepareStatement("select a.name, b.name, c.message,a.photo from student a, college b, testimonials c where b.collegeid = (select collegeid from student where studentid = a.studentid ) and a.studentid = c.stid");
	ResultSet res = stmt1.executeQuery();
	while(res.next())
	{
		System.out.println("Record");
		%>
			<p><%=res.getString(3) %> <br>
			<br>
			<img src="student/<%=res.getString(4) %>"  height="100px">
			<h3 align=right><%=res.getString(1) %> </h3> 
			<p align=right><font color=#0066cc><%=res.getString(2) %></font></p></p>	
			<hr><p>&nbsp;</p>
			<p>&nbsp;</p>
		<%
	}
	stmt1.close();
 %>

				
				</div>
					<p>&nbsp;</p>
			<p>&nbsp;</p>
				<ul id="flip" class="ca-menu">
                    <li >
                        
                            <span class="ca-icon">Z</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Write your own testimonial</h2>
                                <h3 class="ca-sub">Let us help you!!</h3>
                            </div>
                        </a>
                    </li>
    </ul>
    <%
			if(session.getAttribute("test")!=null)
			{
			
				if(session.getAttribute("test").equals("true"))
				{
					%>
								<div class="alert alert-success " role="alert"><span class="glyphicon glyphicon-ok"></span> Thank You ! </strong> Your testimonial has been recorded. </div>
							<%
				}
				else
				{
					%>
								<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-remove"></span><strong> Oh Snap ! </strong> Looks like, you have already submitted your testimonial or your ID is not valid !</div>
							<%
				}
				session.removeAttribute("test");
			
			}
		 %>
<div id="panel">

			<div id="page-wrap">

		
		
		<p align="center"><font size="4" color="red" face="century gothic"><b>You may write here</b></font></p>
					
		<div id="contact-area">
			
			<form name="Form1" method="post"  action="">
				<label for="Name">Email ID :</label>
				<input type="text" name="stid" id="name" />
				
				<label for="Message">Testimony :</label><br />
				<textarea name="message" rows="20" cols="20" id="message"></textarea>

				<input type="submit" name="submit" value="Submit" class="submit-button" />
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
		SendMail.sendReport(e, basePath);
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
</body>
</html>


