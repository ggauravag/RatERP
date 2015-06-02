<%@page import="java.util.Random"%>
<%@ page language="java" import="java.util.List,java.util.Iterator,java.sql.*,com.login.*,java.io.*" pageEncoding="ISO-8859-1"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	  if(session == null || session.getAttribute("type") == null || !session.getAttribute("type").equals("STUDENT"))
      {
      	response.sendRedirect("../Unauthorize.jsp");
      	return;
      }
      
      Connection con = null;
      int i = 0;
      int up = 0;
      try
      {
      	con = DBInfo.getConn();
      	
      	System.out.println("*************** START ***************");
      	
      	
      	
      	
      	String contentType = request.getContentType();
      	if((contentType != null) && contentType.indexOf("multipart/form-data") >= 0)
		{
		
			up = 1;
			String stuid = null;
			String trainer = null;
			String desc = null;
			String title = null;
			String uploadfile = null;
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
                     		filename = "/upload/Problem"+((String)session.getAttribute("id")).substring(12)+rand+itemName.substring(itemName.indexOf('.')).toLowerCase();
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
		              if(name.equals("stuid"))
		              	stuid = value;
		              if(name.equals("title"))
		              	title = value;
		              if(name.equals("desc"))
		              	desc = value;
		              if(name.equals("trainerid"))
		              	trainer = value;
		              System.out.println(name+" : : "+value);
              	}
      	
			
			}
		
			
	           
	           PreparedStatement ps = con.prepareStatement("insert into discussion(studenttid,file,comment,trainerid,title) values(?,?,?,?,?)");
	          
	           ps.setString(1,stuid);
	           ps.setString(2, filename);
	           ps.setString(3, desc);
	           ps.setString(4, trainer);
	           ps.setString(5, title);
	           
	           i = ps.executeUpdate();
	           if(i==1)
	           {
	           		System.out.println("Problem Uploaded");
	           		
	           }
	           else
	           {
	          		System.out.println("Error while uploading problem");
	           }
	           
	         
	         }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Raise Problem</title>
    
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
	 <script type="text/javascript"> 
         function loadQuery(data)
		 {
			var xmlhttp;
			//alert('ajax called with data'+data);
			if (window.XMLHttpRequest)
			  {// code for IE7+, Firefox, Chrome, Opera, Safari
			  xmlhttp=new XMLHttpRequest();
			  }
			else
			  {// code for IE6, IE5
			  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			  }
			  
			  if (xmlhttp.overrideMimeType)
			  {
		 		xmlhttp.overrideMimeType('text/xml');
		 		//alert("Response overrided");
		 		}
			  
			  
			xmlhttp.onreadystatechange=function()
			  {
			  //alert("ajax state change : "+xmlhttp.readyState+"status is : "+xmlhttp.status);
			  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			    {
			    	
			    		x=xmlhttp.responseXML.documentElement.getElementsByTagName("RESPONSE");
			    		
			    	
			    		var response = x[0].getElementsByTagName("STATUS");
			    		response = response[0].firstChild.nodeValue;
			    		
			    		
			    		if(response == "1")
			    		{
			    			drawComment();
			    		}
			    		else if(response == "0")
			    		{
			    			drawFailure();
			    		}
			    		else
			    		{
			    		
			    		}
			     }
			   
			  }
			  
			  var path = "<%=basePath%>"+"account/PostComment.jsp";
			xmlhttp.open("POST",path,true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send(data);
			}
         </script>
  </head>
  
  <body>
    <form method="post" class="form-horizontal" name="optionForm" enctype="multipart/form-data">
    
       	
	      <fieldset><legend><strong>Raise Problem</strong></legend>
	     <% 
	       if(i == 1 && up == 1)
          {
           %>
          <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Your problem has been posted successfully.
   		  </div>
   		   <%
   		  }
   		  if(up == 1 && i == 0)
   		  {
 			%>
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Unable to upload your problem, please try again.
   		  </div>
   		   <%
   		  }
   		  
   		  %>
	       
	       <input type="hidden" id="stuid" name="stuid" value="<%=(String)session.getAttribute("id") %>">
	       
	       <input type="hidden" id="stuname" name="stuname" value="<%=(String)session.getAttribute("name") %>">
	       
	       <div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Problem Title :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="title" class="form-control" id="Name" required></input><label style="color:red">* Maximum Length of title can be 100 Characters</label>
		   </div>
			</div>
			
			
			
			<div class="form-group">
		   <label for="Email" class="col-sm-2 control-label" align="left">Select Trainer :</label> 
		   	
		   <div class="col-sm-3">  
		 <select name="trainerid" class="form-control" required>
		 	<%
		 		PreparedStatement stmt = con.prepareStatement("select * from trainer");
		 		ResultSet rs = stmt.executeQuery();
		 		while(rs.next())
		 		{
		 			%><option value="<%=rs.getString(1)%>"><%=rs.getString(2) %></option><%
		 		}
		 	 %>
		 	 <option value="">General Discussion</option>
		 </select>
		   </div>
			</div>	
			
			
			<div class="form-group">
		   <label for="Mobile" class="col-sm-2 control-label"  align="left">Upload File :</label> 
		   	
		   <div class="col-sm-4">  
		   	<input type="file" name="file" class="form-control"><label>* Only Source Code or Image file</label>
		   </div>
		   
		   
           
		   </div>
		  
			
			
			<div class="form-group">
		   <label for="Pname" class="col-sm-2 control-label" align="left">Problem Description :</label> 
		   	
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
	   <fieldset>
	   <legend><strong>&nbsp;Problem History</strong></legend>
	   
	   <a href="account/DiscussForum.jsp" target="_blank" style="margin-left:5px;">View Discussion Forum</a>
	  
	   	<div class="panel-group" id="accordion">
  
  <%
  		stmt.close();
  		stmt = con.prepareStatement("select d.id,d.studenttid,d.file,d.comment,(case ifnull(d.trainerid,'NULL') when 'NULL' then 'No Trainer' else (select `name` from trainer where trainerid = d.trainerid) end) as 'trainer',d.title,(select count(*) from discussion where discussid = d.id ) total from discussion d where d.studenttid = ? and d.discussid is null order by id desc");
  		stmt.setString(1, (String)session.getAttribute("id"));
  		rs.close();
  		rs = stmt.executeQuery();
  		
  		while(rs.next())
  		{
  %>
			  <div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rs.getInt(1)%>">
			         <strong> <%=rs.getString(6) %></strong>&nbsp;&nbsp;&nbsp;<i>Trainer : <strong><%=rs.getString(5) %></strong></i> &nbsp;&nbsp;&nbsp;Comments : <font id="numcom"><%=rs.getInt(7) %></font>
			        </a>
			      </h4>
			    </div>
			    <div id="collapse<%=rs.getInt(1)%>" class="panel-collapse collapse">
			      <div class="panel-body">
			        <%
			        	String url = rs.getString(3);
			        	if(url != null && (url.endsWith(".jpg") || url.endsWith(".png") || url.endsWith(".jpeg") || url.endsWith(".jpg")))
			        	{
			        		%>
			        			<img src="account/<%=url%>" class="img-thumbnail" style="float:left;">
			        			<br>
			        			<label style="float:left;margin-left:5px">
			        		<%
			        	}
			        	else if(url!=null)
			        	{
			        		%>
			        			<a href="account/<%=url%>" download>Source Code</a>
			        			<br>
			        			<label>
			        		<%
			        	}
			        	
			        	
			        	
			        			Clob clob = rs.getClob(4);
			        			int l = (int)clob.length();
			        			long pos = 1;
			        			out.write(clob.getSubString(pos, l));
			        			 %>
			        </label>
			       
			      </div>
			      
			      <div id="comment<%=rs.getInt(1) %>">
			      <%
			      
			       PreparedStatement stmt1 = con.prepareStatement("select d.id,st.name,d.file,d.comment,d.trainerid,d.discussid,d.title from discussion d,(select studentid,name from student union select trainerid,name from trainer) st where d.discussid = ? and d.studenttid = st.studentid");
			       	stmt1.setInt(1, rs.getInt(1));
			   
			       	ResultSet rs1 = stmt1.executeQuery();
			       	
			       	while(rs1.next())
			       	{
			       
			       %>
			      <div style="box-shadow: 2px 2px 1px #888888;background-color:yellow;margin-left:5px;margin-right:5px;margin-bottom:5px;">
			     <strong> <%=rs1.getString(2) %> </strong><i>wrote : </i><%
			     			
			     			     clob = rs1.getClob(4);
			        			 l = (int)clob.length();
			        			 pos = 1;
			        			 out.write(clob.getSubString(pos, l));
			      %>
			      </div>
			      <%
			      	}
			      
			       %>
			      
			      </div>
			      <br>
			      <div>
			      <textarea cols="100" class="col-sm-8 col-sm-offset-1" id="comnew<%=rs.getInt(1) %>" ></textarea>
			    	<button class="btn btn-primary col-sm-offset-1" id="comnew<%=rs.getInt(1) %>" onclick="addComment(this.id)"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Post</button>
			      </div>
			        
			      <br>
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
         
        
  <script type="text/javascript">
  
  			var newComment = "";
  			var divId = "";
  
  			function drawComment()
  			{
  			
  				var name = document.getElementById("stuname").value;
  			
  				var value = document.getElementById("numcom").innerText;
  				
  				value = parseInt(value) + 1;
  				
  				document.getElementById("numcom").innerText = value;
  			
  				document.getElementById(divId).innerHTML += " <div style=\"box-shadow: 2px 2px 1px #888888;background-color:yellow;margin-left:5px;margin-right:5px;margin-bottom:5px;\"><strong>"+name+"</strong><i> wrote : </i>"+newComment+"</div>";
			
			 	}
  			
  			
  			function drawFailure()
  			{
  				var id = "comnew"+divId.replace("comment","");
  				document.getElementById(id).value = newComment;
  			}
  
  			
  
  			function addComment(id)
			{
				//alert('Function called');
				var comm = document.getElementById(id).value;
				document.getElementById(id).value = "";
				//comm = document.forms["optionForm"].comment.value;
				//alert("the comment is : "+comm);
				id = id.replace("comnew","");
				//alert("The id is : "+id+", and value is : "+comm);
				divId = "comment"+id;
				newComment = comm;
				
				var sid = document.getElementById("stuid").value;
				//alert("The student id is : "+sid);
				var data = "commentid="+id+"&comment="+comm+"&stu="+sid;
				console.log(data);
				loadQuery(data);
				
			}
  
  
  </script>
  </body>
</html>
