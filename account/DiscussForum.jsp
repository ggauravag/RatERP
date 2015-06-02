<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*,com.login.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
	
	

	if(id == null || name == null)
	{
		response.sendRedirect("../Unauthorize.jsp");
		return;
	}
	
	Connection con = null;
	try
	{
	
		PreparedStatement stmt = null;
		con = DBInfo.getConn();
		ResultSet rs = null;
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
   <title>Discussion Forum</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  
 

    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./css/navbar-fixed-top.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="./js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="./js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

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
			 // alert("ajax state change : "+xmlhttp.readyState+"status is : "+xmlhttp.status);
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

    <!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" >RAT Discussion Forum </a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li ><a href="./dashboard.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;Home</a></li>
          
           
          </ul>
          <ul class="nav navbar-nav navbar-right">
          	 <li><a style="color: blue">Welcome ! <%=session.getAttribute("name") %></a></li>
            <li><a href="Logout.jsp"><span class="glyphicon glyphicon-off"></span>&nbsp;Log Out</a></li>
          
           
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    
       <form class="form-horizontal" role="form" method="post" >
       
           <input type="hidden" id="stuid" name="stuid" value="<%=(String)session.getAttribute("id") %>">
	       
	       <input type="hidden" id="stuname" name="stuname" value="<%=(String)session.getAttribute("name") %>">
	     
	      <fieldset>
	       <legend> <h2>&nbsp;&nbsp;Recent Posts</h2></legend>
	       <div class="panel-group col-sm-12" id="accordion">
	       
	      <%
  		
  		stmt = con.prepareStatement("select d.id,d.studenttid,d.file,d.comment,(case ifnull(d.trainerid,'NULL') when 'NULL' then 'No Trainer' else (select `name` from trainer where trainerid = d.trainerid) end) as 'trainer',d.title,(select count(*) from discussion where discussid = d.id ) total from discussion d where d.discussid is null order by id desc");
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
        </form>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
    <script type="text/javascript">
  
  			var newComment = "";
  			var divId = "";
  
  			function drawComment()
  			{
  			
  				var name = document.getElementById("stuname").value;
  			
  				var value = document.getElementById("numcom").innerText;
  				
  				value = parseInt(value) + 1;
  				
  				document.getElementById("numcom").innerText = value;
  				//alert("Comment added");
  				
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
  <%
  }
  catch(Exception e)
  {
  	e.printStackTrace();
  }	
  finally
  {
  	if(con!=null)
  	{
  		try
  		{	con.close(); }
  		catch(Exception e)
  		{
  			e.printStackTrace();
  		}
  	}
  }
  
   %>
</html>