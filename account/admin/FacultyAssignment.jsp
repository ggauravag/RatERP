<%@ page language="java" import="java.util.*,com.login.*,java.sql.*,java.io.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	if(session == null || session.getAttribute("type") == null || (!session.getAttribute("type").equals("TRAINER") && !session.getAttribute("type").equals("ADMIN")))
    {
      	response.sendRedirect("../Unauthorize.jsp");
      	return;
    }


Connection con = null;

	try
	{

		con = DBInfo.getConn();
		
		String contentType = request.getContentType();
		
		if(request.getParameter("form")!=null && request.getParameter("form").equals("delete"))
		{
			String upid = request.getParameter("upid");
			//System.out.println("The upload to be deleted is : "+upid);
			PreparedStatement ps = con.prepareStatement("select file from upload where up_id = ?");
			ps.setInt(1, Integer.parseInt(upid));
			ResultSet rs = ps.executeQuery();
		
			if(rs.next())
			{
				File toDelete = new File(config.getServletContext().getRealPath("/account/")+rs.getString(1));
				if(toDelete.delete())
				{
					
					PreparedStatement ps1 = con.prepareStatement("delete from upload where up_id = "+upid+"");
					int result = ps1.executeUpdate();
					session.setAttribute("delete", result);
					response.sendRedirect("FacultyAssignment.jsp");
					System.out.println("File successfully deleted");
					return;
				}
				else
				{
					session.setAttribute("delete", 0);
					response.sendRedirect("FacultyAssignment.jsp");
					return;
				}
			}
			else
			{
				session.setAttribute("delete", 0);
				response.sendRedirect("FacultyAssignment.jsp");
				return;
			}
			
			
		
		}
		
		
			
	           
	         

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Upload Assignment</title>
    
	
	 <link href="css/bootstrap.min.css" rel="stylesheet">
     <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
     <script type="text/javascript" src="js/bootstrap.js"></script>

  </head>
  
  <body>
   	
    	
    	<input type="hidden" id="stuid" name="trainerid" value="<%=(String)session.getAttribute("id") %>">
	        <% 
	     
   		  if(session.getAttribute("delete")!= null && (Integer)session.getAttribute("delete") == 1)
   		  {
           %>
          <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Assignment has been deleted.
   		  </div>
   		   <%
   		   session.removeAttribute("delete");
   		  }
   		  else if(session.getAttribute("delete")!= null && (Integer)session.getAttribute("delete") == 0)
   		  {
 			%>
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Unable to delete assignment, please try again.
   		  </div>
   		   <%
   		   session.removeAttribute("delete");
   		  }
   		  else
   		  {
   		  
   		  
   		  }
   		  
   		  %>
	      
	      
			
			<form name="deleteForm">
			<input type="hidden" name="form" value="delete">
			<input type="hidden" name="upid" id="upid">
			<fieldset>
			<legend><label>Upload History</label></legend>
			 <div class="panel-group col-sm-12" id="accordion">
			<%
				PreparedStatement ps = con.prepareStatement("select distinct u.trainer,t.name,c.center,c.classid,cv.name,c.time,c.schedule from upload u,class c,trainer t,courseview cv where cv.courseid = c.courseid and u.classid = c.classid and t.trainerid = u.trainer");
				
				
				ResultSet rs = ps.executeQuery();
				
				while(rs.next())
				{
					
	   			%>
	   			<div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rs.getString(4)%>">
			         <strong> <%=rs.getString(5) %></strong>&nbsp;&nbsp;&nbsp;&nbsp;Schedule :<strong><%=rs.getString(7) %></strong>&nbsp;&nbsp;Center : <strong><%=rs.getString(3) %></strong>
			        </a>
			      </h4>
			    </div>
			    <div id="collapse<%=rs.getString(4)%>" class="panel-collapse collapse">
			      <div class="panel-body">
			        <%
			        
			        	PreparedStatement ps1 = con.prepareStatement("select * from upload where classid = ? and trainer = ? order by up_id desc");
			        	ps1.setString(1, rs.getString(4));
			        	ps1.setString(2, rs.getString(1));
			        	
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
			        			<a href="account<%=url%>" download>Download File</a><div class="col-sm-offset-3"><button id="<%=rs1.getInt(1) %>" onclick="deleteUp(this.id);form.submit();" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button></div>
			        			<br>
			        			<%
			        			}
			        			%>
			        			<strong>TYPE : </strong><%=rs1.getString(8) %><br>
			        			<strong>TITLE : </strong><h4><%=rs1.getString(2) %></h4><br>
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
					
					
			
			
			</fieldset>
			
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
    	
    	
    
    </form>
    <script type="text/javascript">
    	function deleteUp(upid)
    	{
    		//alert("The Upload id is : "+upid);
    		document.getElementById("upid").value = upid;
    	}
    
    </script>
  </body>
</html>
