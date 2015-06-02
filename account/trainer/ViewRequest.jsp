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
			  console.log("ajax state change : "+xmlhttp.readyState+"status is : "+xmlhttp.status);
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
	
  </head>
  
  <body>
  
  	  <fieldset>
	   <legend><strong>&nbsp;View Problems</strong></legend>
	    <input type="hidden" id="stuid" name="stuid" value="<%=(String)session.getAttribute("id") %>">
	       
	       <input type="hidden" id="stuname" name="stuname" value="<%=(String)session.getAttribute("name") %>">
	       
	    <div class="panel-group col-sm-12" id="accordion">
	    <%
	    	PreparedStatement ps = con.prepareStatement("select * from discussion where trainerid = ? order by id desc");
	    	ps.setString(1, (String)session.getAttribute("id"));
	    	
	    	ResultSet rs = ps.executeQuery();
	    	while(rs.next())
	    	{
	    	%>
	   			<div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rs.getInt(1)%>">
			         <strong> <%=rs.getString(7) %></strong>
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
			        			<a href="account/<%=url%>">Source Code</a>
			        			<br>
			        			<label>
			        		<%
			        	}
			        	else
			        	{
			        		%>
			        			<label>
			        		<%
			        	}
			        	
			        	
			        	
			        			
			        			 %>
			        			 <%=rs.getString(4) %>
			        </label>
			       
			      </div>
			      
			      <div id="comment<%=rs.getInt(1) %>">
			      <%
			      
			       PreparedStatement stmt1 = con.prepareStatement("select d.id,st.name,d.comment from discussion d,user st where discussid = ? and d.studenttid = st.userid;");
			       	stmt1.setInt(1, rs.getInt(1));
			   	
			       	ResultSet rs1 = stmt1.executeQuery();
			       	System.out.println("Prepared Stamt is : "+stmt1);
			       	while(rs1.next())
			       	{
			       System.out.println("The comment is "+rs1.getString(3)+" by "+rs1.getString(2));
			       %>
			      <div style="box-shadow: 2px 2px 1px #888888;background-color:yellow;margin-left:5px;margin-right:5px;margin-bottom:5px;">
			     <strong> <%=rs1.getString(2) %> </strong><i>wrote : </i><%=rs1.getString(3) %>
			      </div>
			      <%
			      	}
			      
			       %>
			      
			      </div>
			      <br>
			      <div>
			      <textarea cols="100" class="col-sm-8 col-sm-offset-1" id="comnew<%=rs.getInt(1) %>" ></textarea>
			    	<button class="btn btn-primary col-sm-offset-1" id="comnew<%=rs.getInt(1) %>" onclick="addComment(this.id);"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Post</button>
			      </div>
			        
			      <br>
			    </div>
			         </div>
			        <% 	
			  }     
	    	%>
	    </div>
	   
    </fieldset>
    <script type="text/javascript">
  
  			var newComment = "";
  			var divId = "";
  
  			function drawComment()
  			{
  			
  				var name = document.getElementById("stuname").value;
  			
  				//var value = document.getElementById("numcom").innerText;
  				
  				//value = parseInt(value) + 1;
  				
  				//document.getElementById("numcom").innerText = value;
  				
  			
  				document.getElementById(divId).innerHTML += " <div style=\"box-shadow: 2px 2px 1px #888888;background-color:yellow;margin-left:5px;margin-right:5px;margin-bottom:5px;\"><strong>"+name+"</strong><i> wrote : </i>"+newComment+"</div>";
			 
			    
			    //console.log(document.getElementById(divId).innerHTML);
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
