<%@page import="java.sql.ResultSet"%>
<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*,com.login.SendMail" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection con = null;
	if(session == null || session.getAttribute("type") == null || !session.getAttribute("type").equals("STUDENT"))
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
    
    <title>View Uploads</title>
    
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
	   <legend><strong>&nbsp;Problem History</strong></legend>
	    <div class="panel-group col-sm-12" id="accordion">
	   <%
	        String query = "select distinct c.classid,co.name,c.time,c.schedule,t.name,c.center,(select count(*) from upload where classid = c.classid) as count from student st,class c,upload up,trainer t,courseview co where (st.class like concat('%,',up.classid,',%') or st.class like concat(up.classid,',%')) and up.classid = c.classid and c.trainerid = t.trainerid and st.studentid = ? and co.courseid = c.courseid";
	   		PreparedStatement ps = con.prepareStatement(query);
	   		ps.setString(1, (String)session.getAttribute("id"));
	   		
	   		ResultSet rs = ps.executeQuery();
	   		
	   		while(rs.next())
	   		{
	   			%>
	   			<div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rs.getString(1)%>">
			         <strong> <%=rs.getString(2) %></strong>&nbsp;&nbsp;&nbsp;<i>Trainer : <strong><%=rs.getString(5) %></strong></i> &nbsp;&nbsp;&nbsp;No. Of Uploads : <strong><font id="numcom"><%=rs.getInt(7) %></font></strong>&nbsp;&nbsp;Schedule :<strong><%=rs.getString(4) %></strong> &nbsp;&nbsp;&nbsp;Time : <strong><%=rs.getString(3) %></strong>&nbsp;&nbsp;Center : <strong><%=rs.getString(6) %></strong>
			        </a>
			      </h4>
			    </div>
			    <div id="collapse<%=rs.getString(1)%>" class="panel-collapse collapse">
			      <div class="panel-body">
			        <%
			        
			        	PreparedStatement ps1 = con.prepareStatement("select * from upload where classid = ? order by up_id desc");
			        	ps1.setString(1, rs.getString(1));
			        	
			        	ResultSet rs1 = ps1.executeQuery();
			        	
			        	while(rs1.next())
			        	{
			        	
			        	String url = rs1.getString(3);
			        	
			        		%>
			        		<div>
			        		<%
			        			if(url != null && url != "")
			        			{
			        		 	%>
			        			<a href="account<%=url%>" download>Download File</a>
			        			<br>
			        			<%
			        			}
			        			%>
			        			<strong>TYPE : </strong><%=rs1.getString(8) %>
			        			<br>
			        			<label><%=rs1.getString(4) %></label>
			        		</div>
			        		<br>
			        		<hr>
			        		<br>
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
  
  <%
  		    }
       		catch(Exception e)
       		{
       			e.printStackTrace();
       			
       			response.sendRedirect("../Error.jsp");
       			SendMail.sendReport(e, basePath);
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
  
  </body>
</html>
