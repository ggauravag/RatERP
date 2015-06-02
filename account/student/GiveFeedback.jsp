<%@page import="com.login.DBInfo"%>
<%@ page language="java" import="java.util.*,java.sql.*,com.login.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

 	if(session == null || session.getAttribute("type") == null || !session.getAttribute("type").equals("STUDENT"))
      {
      	response.sendRedirect("../Unauthorize.jsp");
      	return;
      }
      
      Connection con = null;
      
      try
      {
      
      	con = DBInfo.getConn();
      	
      	
      
      		
      	if(request.getParameter("feed")!=null)
      	{
      		String stuid = request.getParameter("stuid");
      		String feedback = request.getParameter("feedback");
      		String classid = request.getParameter("classid");
      		
      		System.out.println("Data is : "+stuid+feedback+classid);
      		
      		String query = "insert into feedback(userid,feedback,classid) values(?,?,?)";
      		
      		PreparedStatement ps = con.prepareStatement(query);
      		ps.setString(1, stuid);
      		ps.setString(2, feedback);
      		ps.setString(3, classid);
      		
      		int i = ps.executeUpdate();
      		
      		session.setAttribute("feed", i);
      		response.sendRedirect("GiveFeedback.jsp");
      		return;
      	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'GiveFeedback.jsp' starting page</title>
    
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
  	 <form method="post" class="form-horizontal" name="optionForm" >
    	
    	  <fieldset><legend><strong>Give Feedback</strong></legend>
    	  <% 
	       if(session.getAttribute("feed")!=null && (Integer)session.getAttribute("feed") == 1)
          {
           %>
          <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Your feedback has been submitted.
   		  </div>
   		   <%
   		   session.removeAttribute("feed");
   		  }
   		  else if(session.getAttribute("feed")!=null && (Integer)session.getAttribute("feed") == 0)
   		  {
 			%>
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Something went wrong while submitting feedback, try again.
   		  </div>
   		   <%
   		    session.removeAttribute("feed");
   		  }
   		  else
   		  {
   		  	System.out.println("No session found with 'feed'");
   		  }
   		  
   		  %>
    	  
    	  	 <input type="hidden" id="stuid" name="stuid" value="<%=(String)session.getAttribute("id") %>">
	       
	       
	       <div class="form-group">
		   <label for="Mobile" class="col-sm-2 control-label"  align="left">Select Class :</label> 
		   	
		   <div class="col-sm-6">  
		   	<select name="classid" class="form-control" required>
		 	<%
		 		PreparedStatement stmt = con.prepareStatement("select c.classid,c.trainerid,co.name,c.time,c.center,c.schedule from student st,class c,courseview co where (st.class like concat('%,',c.classid,',%') or st.class like concat(c.classid,',%')) and st.studentid = ? and c.courseid = co.courseid and c.end_date is null");
		 		stmt.setString(1, (String)session.getAttribute("id"));
		 		ResultSet rs = stmt.executeQuery();
		 		while(rs.next())
		 		{
		 			%><option value="<%=rs.getString(1)%>"><%=rs.getString(3) %> - <%=rs.getString(4) %> - <%=rs.getString(5) %> - <%=rs.getString(6) %></option><%
		 		}
		 	 %>
		 	 
		 </select> 
		 <label>* Only Active Classes</label>
		 </div>
		   
		   
           
		   </div>
	       
	       
	       
	       <div class="form-group">
		   <label for="Pname" class="col-sm-2 control-label" align="left">Feedback :</label> 
		   	
		   <div class="col-sm-6">  
		   <textarea name="feedback" cols="10" rows="5" class="form-control" required></textarea>
		   </div>
		   </div>
    	  
    	  <div class="form-group">
		  		<input type="submit" name="feed" class="btn btn-primary col-sm-offset-4" value="Send Feedback">
			</div>
    	
    		</fieldset>
    </form>  
    
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
