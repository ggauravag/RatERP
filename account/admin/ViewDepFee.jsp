<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.SendMail"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection con = null;
	
	try
	{
	String type =(String)session.getAttribute("type");
	
		if(type != null && (type.equals("ADMIN")))
		{
			
		}
		else
		{
			response.sendRedirect("../Unauthorize.jsp");
			return;
		}
	
		con = DBInfo.getConn();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>View Deposited Fees</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/bootstrap.css" type="text/css"></link>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script></head>
  </head>
  
  <body>
    <form>
     <fieldset>
           <legend><strong>View Deposited Fees</strong></legend>
           <div class="form-group">
		      <label for="sched" class="col-sm-1 control-label" align="left">Start Date :</label> 
		      	<div class="col-sm-3">
		      	<input type="date" name="stdate" class="form-control" required="true">
		      	
	
		      	</div>
		      	<label for="sched" class="col-sm-1 control-label" align="left">End Date :</label> 
		     
		      	<div class="col-sm-3">
		      	<input type="date" name="enddate" class="form-control" required="true">
		      	
		      	</div>
		      	
		      	<div class="col-sm-2">
		      	<input type="submit" name="search" value="Display" class="btn btn-primary">
		      	</div>
		    </div>
          
       </fieldset>
       <fieldset>
       	<legend><strong>Transaction Details</strong></legend>
       	<table class="table table-hover">
       	
       	<th>Transaction ID</th>
       	<th>Student Name</th>
       	<th>Amount</th>
       	<th>Date</th>
       	<th>Mode</th>
       	<th>Received From</th>
       	<th>Received By</th>
       	
       <%
       
       if(request.getParameter("search") != null)
       {
       
	       SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	       PreparedStatement ps = con.prepareStatement("select t.txnid,st.name,t.amount,t.datetime,t.mode,t.recv_from,sta.name from transaction t,student st,staff sta where t.studentid = st.studentid and t.servicedeskid = sta.userid and datetime >= ? and datetime <= ? order by datetime desc");
	       
	       ps.setDate(1, new java.sql.Date(format.parse(request.getParameter("stdate")).getTime()));
	       ps.setDate(2, new java.sql.Date(format.parse(request.getParameter("enddate")).getTime()));
	       
	       ResultSet res = ps.executeQuery();
	       
	       while(res.next())
	       {
	       %>
	       <tr>
	       <td><%=res.getString(1) %></td>
	       <td><%=res.getString(2) %></td>
	       <td><%=res.getInt(3) %></td>
	       <td><%=res.getDate(4) %></td>
	       <td><%=res.getString(5) %></td>
	       <td><%=res.getString(6) %></td>
	       <td><%=res.getString(7) %></td>
	       </tr>
	       <%
	       }
  			
  			
       }
       
        %>
       </table>
       </fieldset>
       
  </form>
    
  </body>
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
</html>
