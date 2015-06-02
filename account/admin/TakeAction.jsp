<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*,com.login.SendMail" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection con = null;
	if(session == null || session.getAttribute("type") == null || !session.getAttribute("type").equals("ADMIN"))
    {
      	response.sendRedirect("../Unauthorize.jsp");
      	return;
    }
	
	try
	{
		con = DBInfo.getConn();
		
		
		if(request.getParameter("form")!= null && request.getParameter("form").equals("stu"))
		{
			String stuid = request.getParameter("stuid");
			String message = request.getParameter("message");
			
			if(stuid != null && stuid != "" && message != "" && message != null)
			{
				//SendMail.sendReset(stuid, "", message, path);
				boolean flag = SendMail.sendAction(message, stuid, basePath);
				session.setAttribute("flag", flag);
				response.sendRedirect("TakeAction.jsp");
				return;
			}
			//System.out.println(stuid+message);
		
		}
		else
		{
			System.out.println("No Form");
		
		}

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
  	<legend><h2>Contact Faculty</h2></legend>
  	 <% 
	       if(session.getAttribute("flag")!=null && (Boolean)session.getAttribute("flag") == true)
          {
           %>
          <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Message Has been successfully sent.
   		  </div>
   		   <%
   		   session.removeAttribute("flag");
   		  }
   		  if(session.getAttribute("flag")!=null && (Boolean)session.getAttribute("flag") == false)
   		  {
 			%>
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Unable to send message, please try again.
   		  </div>
   		   <%
   		   session.removeAttribute("flag");
   		  }
   		  
   		  %>
  		<div class="form-group">
  			<div class="col-sm-4">
  			<div class="form-group">
  			<select name="trainer" class="form-control" id="trainer" >
          			<option value=""> ---- Select ---- </option>
          		<%
          			String query1 = "select * from trainer";
          			PreparedStatement ps3 = con.prepareStatement(query1);
          			ResultSet rs3 = ps3.executeQuery();
          			
          			while(rs3.next())
          			{
          				%>
          					<option value="<%=rs3.getString(1)%>"><%=rs3.getString(2) %></option>
          				<%
          			}
          		
          		 %>
          		</select>
          		</div>
          		<div class="form-group">
          		<textarea class="form-control" id="trainermsg"></textarea>
          		</div>
          		<div class="form-group">
          		<input type="button" class="btn btn-primary col-sm-offset-3" value="Send Message" onclick="fillTrainer()">
  				</div>
  			</div>
  		
  		</div>
  		<form name="messageForm" action="" method="post">
  			<input type=hidden name="form" value="stu">
  			<input type="hidden" id="message" name="message">
  			<input type="hidden" id="stuid" name="stuid">
  		
  		</form>
  </fieldset>
  
  	  <fieldset>
	   <legend><strong>&nbsp;Class Feedback</strong></legend>
	     
	    <div class="panel-group col-sm-12" id="accordion">
	    <%
	    	PreparedStatement ps = con.prepareStatement("select distinct f.classid,co.name,t.name,c.center,c.schedule,c.time from feedback f, trainer t, class c, courseview co where f.classid = c.classid and c.trainerid = t.trainerid and co.courseid = c.courseid");
	    	ResultSet rs = ps.executeQuery();
	    	while(rs.next())
	    	{
	    	%>
	   			<div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=rs.getString(1)%>">
			         <strong> <%=rs.getString(2) %></strong> - <%=rs.getString(3) %> - <%=rs.getString(4) %> - <%=rs.getString(5) %> - <%=rs.getString(6) %>
			        </a>
			      </h4>
			    </div>
			    <div id="collapse<%=rs.getString(1)%>" class="panel-collapse collapse">
			      <div class="panel-body">
			        <%
			        
			        	PreparedStatement ps1 = con.prepareStatement("select u.userid,u.name,f.feedback,f.feedbackid from feedview f, user u where u.userid = f.userid and f.classid = ?;");
			        	ps1.setString(1, rs.getString(1));
			        	
			        	ResultSet rs1 = ps1.executeQuery();
			        	
			        	while(rs1.next())
			        	{
			        		%>
			        			<div class="col-sm-offset-1">
			        			<label>Student ID :</label> <div id="sid<%=rs1.getInt(4)%>"><%=rs1.getString(1) %></div><br>
			        				<label>Name : </label> <%=rs1.getString(2) %><br>
			        				<label><%=rs1.getString(3) %></label><br>
			        				<label>Message : </label>&nbsp;&nbsp;<textarea class="form-control" name="message" id="message<%=rs1.getInt(4)%>"></textarea>
			        				<div class="form-group">
			        				<button class="btn btn-primary" id="button<%=rs1.getInt(4)%>" onclick="sendMessage(this.id)"><span class="glyphicon glyphicon-envelope"></span>&nbsp;Send Message</button>
			        				</div>
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
    <script type="text/javascript">
    
    function fillTrainer()
    {
    
    	var msg = document.getElementById("trainermsg").value;
    	var tid = document.getElementById("trainer").value;
    	
    	if(msg == null || msg == "" || tid == "" || tid != null)
    		return;
    		
    	document.getElementById("stuid").value = tid;
    	document.getElementById("message").value = msg;
    		
    	document.forms["messageForm"].submit();
    
    }
    
    
    function sendMessage(id)
    {
    	var msgid = id.replace("button","");
    	
    	var stuid = "sid"+msgid;
    	
    	msgid = "message"+msgid;
    	//alert(document.getElementById(msgid).value);
    
    	var message = document.getElementById(msgid).value;
    	var studentid = document.getElementById(stuid).innerText;
    	
    	if(message == null || message == "")
    		return;
    	
    	
    	document.getElementById("stuid").value = studentid;
    	document.getElementById("message").value = message;
    	
    	//alert("Message : "+document.getElementById("message").value+", ID : "+document.getElementById("stuid").value);
    	document.forms["messageForm"].submit();
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
