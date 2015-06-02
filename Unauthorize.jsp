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
	
	<link rel="shortcut icon" href="css/images/ratico.ico" ></link>
    <link rel="stylesheet" href="css/homeslider.css" type="text/css"></link>
    <script>
    function Redirect()
	{
    window.location="<%=basePath%>";
	}


setTimeout('Redirect()', 1000);



function preventBack(){window.history.forward();}
  setTimeout("preventBack()", 0);
  window.onunload=function(){null};
  
    
    </script>
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
