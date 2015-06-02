<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*,com.login.SendMail" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection con = null;
	
	if(session == null || session.getAttribute("type") == null || (!session.getAttribute("type").equals("TRAINER") && !session.getAttribute("type").equals("ADMIN")))
    {
      	response.sendRedirect("../Unauthorize.jsp");
      	return;
    }
	
	
	try
	{
		con = DBInfo.getConn();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ViewFeedback.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	 <link href="css/bootstrap.min.css" rel="stylesheet">
     <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
     <script type="text/javascript" src="js/bootstrap.js"></script>
	
  </head>
  
  <body>
  
  	  <fieldset>
	   <legend><strong>&nbsp;View Feedback</strong></legend>
	    <div class="panel-group col-sm-12" id="accordion">
	    <%
	    	PreparedStatement ps = con.prepareStatement("select distinct classid,course,center,schedule,time from feedview where trainerid=?");
	    	ps.setString(1, (String)session.getAttribute("id"));
	    	
	    	ResultSet rs = ps.executeQuery();
	    	while(rs.next())
	    	{
	    	%>
	   			<div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rs.getString(1)%>">
			         <strong> <%=rs.getString(2) %></strong>&nbsp;&nbsp;Schedule :<strong><%=rs.getString(4) %></strong>&nbsp;&nbsp;Center : <strong><%=rs.getString(3) %></strong>&nbsp;&nbsp;&nbsp;Time : <strong><%=rs.getString(5) %></strong>
			        </a>
			      </h4>
			    </div>
			    <div id="collapse<%=rs.getString(1)%>" class="panel-collapse collapse">
			      <div class="panel-body">
			        <%
			        
			        	PreparedStatement ps1 = con.prepareStatement("select feedback from feedview where trainerid = ? and classid = ?");
			        	
			        	ps1.setString(1, (String)session.getAttribute("id"));
			        	ps1.setString(2, rs.getString(1));
			        	
			        	ResultSet rs1 = ps1.executeQuery();
			        	
			        	while(rs1.next())
			        	{
			        		%>
			        			<div class="col-sm-offset-1">
			        				<label><%=rs1.getString(1) %></label>
			        				<hr>
			        			</div>
			        		
			        		<%
			        	}
			        %>
			       
			        </div>
			        </div>
			         </div>
			        <% 	
			  }     
	    	%>
	    </div>
	   
    </fieldset>
  </body>
 <%
			
				}
				catch(Exception e)
				{
					e.printStackTrace();
					SendMail.sendReport(e, basePath);
					response.sendRedirect("../Error.jsp");
				
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
</html>
