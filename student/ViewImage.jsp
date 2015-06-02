<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*, com.login.*" %>
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
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="icon" href="css/images/ratico.ico">

  </head>
  
  <body>
  
  <% 
          String url = request.getParameter("IMAGE");
          
          %>
            
            <img src="student/<%=url%>" height="200" ></img>
      
    
  </body>
</html>
