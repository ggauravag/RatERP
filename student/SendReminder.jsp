<%@ page language="java" import="java.util.*,com.login.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String amount = request.getParameter("inst");
	String date = request.getParameter("date");
	String stid = request.getParameter("stid");
	
	Student stu = null;
	if(stid!=null && amount != null && date != null)
	{
		stu = new Student(stid);
		
		if(stu.fetchRecord())
		{
			SendMail.sendReminder(stu, basePath, Integer.parseInt(amount), date);
			System.out.println("Reminder sent");
		}
	}
	else
	{
		System.out.println("Parameters are null");
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'SendReminder.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
	<script>
	function closeWindow()
	{
		setTimeout("window.close()",1000);
	}
	
	</script>
  </head>
  
  <body onload="closeWindow();">
    <div align="center">
    	<h1 style="color:green"><strong>*** SUCCESS ***</strong></h1>
    
    </div>
    <div align="center">
    	<h2>Reminder Sent Successfully</h2>
    </div>
  </body>
</html>
