<%@page import="com.login.UserBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

			String stuname = request.getParameter("stuname");
			String collge = request.getParameter("college");
			String degree = request.getParameter("degree");
			String semester = request.getParameter("semester");
			String stdate = request.getParameter("stdate");
			String enddate = request.getParameter("enddate");
			String course = request.getParameter("course");
			String performance = request.getParameter("performance");
			String title = request.getParameter("title");
			String desc = request.getParameter("desc");
			
	System.out.println("Print certificate called : "+stuname+collge+degree+semester+stdate+enddate+course+performance+title+desc);
			
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <base href="<%=basePath%>">
    
    <title>Print Certificate</title>
    
	

 
  </head>
  
  <body style="color:white" >
  
   
 	
  
 
  <div style="background-image: url(account/image/cer4.jpg); background-repeat:no-repeat;height:145%; width:auto;-webkit-print-color-adjust:exact;">	<br>
  		<div style="color:black;transform: rotate(90deg);width:170px;position: fixed; left: 427px;top: 530px;font-style:italic;text-align:center;font-family:'Monotype Corsiva',sans;font-size:25px;"><strong><%=stuname %></strong></div>
  	<div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 280px;top: 540px;font-style:italic;text-align:center;font-family:'Monotype Corsiva',sans;font-size:25px;"><strong><%=collge %></strong></div>
  	
  	<div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 245px;top: 710px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:25px;font-weight:bold"><%=degree %></div>
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 245px;top: 810px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:20px;font-weight:bold"><%=semester %><sup><%
  	double yr;
  	try
  	{
  	int sem = Integer.parseInt(semester);
  	yr = (double)sem / 2.0;
  	out.write(UserBean.printFormat(sem)+"</sup>/");
  	out.write(UserBean.getYear(yr)+"<sup>");
  	out.write(UserBean.printFormat(yr)+"</sup></div>");
  	}
  	catch(Exception e)
  	{
  		out.write("</sup>/<sup></sup></div>");
  	}
   %>
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 140px;top: 620px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:23px;font-weight:bold"><%=stdate %></div>
  
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 140px;top: 795px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:23px;font-weight:bold"><%=enddate %></div>
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 103px;top: 650px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:25px;font-weight:bold"><%=course %></div>
  
   <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 42px;top: 630px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:25px;font-weight:bold"><%=title %></div>
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 10px;top: 855px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:23px;font-weight:bold"><%=performance %></div>
  
  </div>
  </div>
  </body>
</html>
 	
  
  
 
  
  </body>
</html>
