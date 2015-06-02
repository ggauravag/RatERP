<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Error Page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet"> 
    
    <style type="text/css">
    
    div .error {
    
   
}
    </style>

  </head>
  
  <body>
  <div style="border: 2px solid;margin-left:30px;margin-right:30px;margin-top:30px;">
     	<div align="center" style="">
     	
     		<h1 style="color:red"><strong>ERROR</strong></h1>
     		<br>
     	
     	</div>
     	<div align="center">
     	<h4>Something went wrong while performing the operation.<br><br> System Administrator has been informed about the unexpected failure. </h4>
     	
     	</div>
     	<div align="center">
     	<h3><strong>Please try again later.</strong></h3>
     	
     	
     	</div>
     	</div>
  </body>
</html>
