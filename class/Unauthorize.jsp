<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>RAT Panel</title>
    
	
	<link rel="shortcut icon" href="css/images/ratico.ico" ></link>
    <link rel="stylesheet" href="css/homeslider.css" type="text/css"></link>
  </head>
  
  <body>
  <div id="wrapper">
  
    
    <fieldset>
    <legend align="center"><font color="red" size="24">Unauthorised Access</font></legend>
    <div align="center"><p><font color="white" size="6">Either your Session has expired <br>or you are not allowed to view this page.</font></p>
  	<br>
  	<div align="center"><h3><strong>Please login again to continue</strong></h3></div>
   </div></fieldset>
    </div>
  
  </body>
</html>
