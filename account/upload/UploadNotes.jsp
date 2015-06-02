<%@page import="java.util.Random"%>
<%@ page language="java" import="java.util.List,java.util.Iterator,java.sql.*,com.login.*,java.io.*" pageEncoding="ISO-8859-1"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
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
					response.sendRedirect("UploadAssignment.jsp");
					System.out.println("File successfully deleted");
					return;
				}
				else
				{
					session.setAttribute("delete", 0);
					response.sendRedirect("UploadAssignment.jsp");
					return;
				}
			}
			else
			{
				session.setAttribute("delete", 0);
				response.sendRedirect("UploadAssignment.jsp");
				return;
			}
		}
		else if((contentType != null) && contentType.indexOf("multipart/form-data") >= 0)
		{
		
			
		
			String classid = null;
			String trainer = null;
			String desc = null;
			String title = null;
			String filename = null;
			
		
			FileItemFactory factory = new DiskFileItemFactory();
	      	ServletFileUpload upload = new ServletFileUpload(factory);
	      	List items = null;
		
	      	try 
	      	{
				items = upload.parseRequest(request);
			} 
         	catch (FileUploadException e) 
         	{
             e.printStackTrace();
            }
          
          
            Iterator itr = items.iterator();
			
			
			
			
			Random random =  new Random();
			int rand = random.nextInt(10000);
			
            while (itr.hasNext()) 
            {
              	FileItem item = (FileItem) itr.next();

              	if (!item.isFormField()) 
              	{
                  	try {

					  File savedFile = null;
                      String itemName = item.getName();
                      if(itemName != "" && itemName.contains("."))
                        {
                        	String idl = (String)session.getAttribute("id");
                     		//filename = "/upload/File"+((String)session.getAttribute("id")).substring(12)+itemName.substring(itemName.indexOf('.')).toLowerCase();
                      		filename = "/upload/File"+(idl).substring(8,11)+idl.substring(12)+itemName.toLowerCase();
                      		savedFile = new File(config.getServletContext().getRealPath("/account/")+filename);
						}
						
					  System.out.println("Got a file : "+itemName+" With file name : "+filename);
                      item.write(savedFile);
                        
                  		} 
                     catch (Exception e) 
                  		{
                      		e.printStackTrace();
                  		}
                } 
              	else 
              	{
                      String name = item.getFieldName();
		              String value = item.getString();
		              if(name.equals("classid"))
		              	classid = value;
		              if(name.equals("title"))
		              	title = value;
		              if(name.equals("desc"))
		              	desc = value;
		              if(name.equals("trainerid"))
		              	trainer = value;
		              System.out.println(name+" : : "+value);
              	}
      	
			
			}
		
			
	           
	           PreparedStatement ps = con.prepareStatement("insert into upload(title,file,remarks,date,trainer,classid,type) values(?,?,?,now(),?,?,?)");
	          
	           ps.setString(1,title);
	           ps.setString(2, filename);
	           ps.setString(3, desc);
	           ps.setString(4, trainer);
	           ps.setString(5, classid);
	           ps.setString(6, "STUDY-MATERIAL");
	           
	           int i = ps.executeUpdate();
	           if(i==1)
	           {
	           		System.out.println("Problem Uploaded");
	           		
	           }
	           else
	           {
	          		System.out.println("Error while uploading problem");
	           }
	           
	           session.setAttribute("up", i);
	           response.sendRedirect("UploadNotes.jsp");
	         	return;
	         }


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Upload Notes</title>
    
	
	 <link href="css/bootstrap.min.css" rel="stylesheet">
     <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
     <script type="text/javascript" src="js/bootstrap.js"></script>

  </head>
  
  <body>
    <form method="post" class="form-horizontal" name="optionForm" enctype="multipart/form-data">
    	
    	<fieldset>
    	<legend><h3>Upload Material</h3></legend>
    	<input type="hidden" id="stuid" name="trainerid" value="<%=(String)session.getAttribute("id") %>">
	        <% 
	       if(session.getAttribute("up")!= null && (Integer)session.getAttribute("up") == 1)
          {
           %>
          <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Files have been uploaded.
   		  </div>
   		   <%
   		   session.removeAttribute("up");
   		  }
   		  else if(session.getAttribute("up")!= null && (Integer)session.getAttribute("up") == 0)
   		  {
 			%>
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Unable to upload your notes, please try again.
   		  </div>
   		   <%
   		   session.removeAttribute("up");
   		  }
   		  else
   		  {
   		  	System.out.println("No uploaded");
   		  
   		  }
   		  
   		  %>
	      
	       <div class="form-group">
		   <label for="Email" class="col-sm-2 control-label" align="left">Select Class :</label> 
		   	
		   <div class="col-sm-6">  
		 <select name="classid" class="form-control" required>
		 	<%
		 		PreparedStatement stmt = con.prepareStatement("select c.classid,co.name,c.time,c.center,c.schedule from class c, courseview co where c.trainerid = ? and c.end_date is null and c.courseid = co.courseid");
		 		stmt.setString(1, (String)session.getAttribute("id"));
		 		ResultSet rs = stmt.executeQuery();
		 		while(rs.next())
		 		{
		 			%><option value="<%=rs.getString(1)%>"><%=rs.getString(2) %> - <%=rs.getString(3) %> - <%=rs.getString(4) %> - <%=rs.getString(5) %></option><%
		 		}
		 	 %>
		 	
		 </select>
		   </div>
			</div>	
	       
	       
	       
	       
	       
	       <div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Title / Name :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="title" class="form-control" id="Name" required></input><label style="color:red">* Maximum Length of title can be 250 Characters</label>
		   </div>
			</div>
			
			
				<div class="form-group">
		   <label for="Mobile" class="col-sm-2 control-label"  align="left">Upload File :</label> 
		   	
		   <div class="col-sm-4">  
		   	<input type="file" name="file" class="form-control"><label>* For Source Codes</label>
		   </div>
		   
		   
           
		   </div>
		  
			
			
			<div class="form-group">
		   <label for="Pname" class="col-sm-2 control-label" align="left">Description :</label> 
		   	
		   <div class="col-sm-6">  
		   <textarea name="desc" cols="10" rows="5" class="form-control" required></textarea>
		   </div>
		   <div class="col-sm-4">
		  
		   </div>
			</div>	
			
				<div class="form-group">
		  		<input type="submit" name="addprob" class="btn btn-primary col-sm-offset-4" value="Post Problem">
			</div>
			
			</fieldset>
			</form>
			
			<form name="deleteForm">
			<input type="hidden" name="form" value="delete">
			<input type="hidden" name="upid" id="upid">
			<fieldset>
			<legend><label>Upload History</label></legend>
			 <div class="panel-group col-sm-12" id="accordion">
			<%
				PreparedStatement ps = con.prepareStatement("select distinct c.classid,cv.name,c.schedule,c.center,(select count(*) from upload where trainer = u.trainer and classid = u.classid) count from upload u,class c,courseview cv where trainer = ? and c.classid = u.classid and cv.courseid = c.courseid");
				ps.setString(1, (String)session.getAttribute("id"));
				
				ResultSet res = ps.executeQuery();
				
				while(res.next())
				{
					
	   			%>
	   			<div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=res.getString(1)%>">
			         <strong> <%=res.getString(2) %></strong>&nbsp;&nbsp;&nbsp;No. Of Uploads : <strong><font id="numcom"><%=res.getInt(5) %></font></strong>&nbsp;&nbsp;Schedule :<strong><%=res.getString(3) %></strong>&nbsp;&nbsp;Center : <strong><%=res.getString(4) %></strong>
			        </a>
			      </h4>
			    </div>
			    <div id="collapse<%=res.getString(1)%>" class="panel-collapse collapse">
			      <div class="panel-body">
			        <%
			        
			        	PreparedStatement ps1 = con.prepareStatement("select * from upload where classid = ? and trainer = ? order by up_id desc");
			        	ps1.setString(1, res.getString(1));
			        	ps1.setString(2, (String)session.getAttribute("id"));
			        	
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
