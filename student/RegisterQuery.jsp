<%@page import="java.io.EOFException"%>
<%@page import="java.io.ObjectInputStream"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.login.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.println(basePath);
// HttpSession session1 =  request.getSession(false);

// if(session1==null)
// {
// 	response.sendRedirect("Unauthorize.jsp");
// }

// String type=(String)session1.getAttribute("type");
 HttpSession session1 = request.getSession(false);
 String dup = null;
 if(session1 == null)
 {
 	response.sendRedirect("Unauthorize.jsp");
 	return;
 }
 else
 {
 	String type=(String)session1.getAttribute("type");
 	String name = (String)session1.getAttribute("name");
 	dup = (String)session1.getAttribute("err");
 	if (dup == null)
 		dup = "";
 	System.out.println(type+":"+name);
 	if(type==null)
 	{
 		response.sendRedirect("Unauthorize.jsp");
 		return;
 	}
 	
 	
 	
 }
 
 
 Connection con = null;
 try
 {
 
 
 con = DBInfo.getConn();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="icon" href="css/images/ratico.ico">
	<title>RAT Panel</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

  	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    
	<script>
	
	var queries = [];
	
	var index = 0;
	
	var pageSize = 15;
    	
    	function query(qid, name, mobile, email, course, q)
    	{
    		this.qid = qid; 
    		this.name  = name;
    		this.mobile = mobile;
    		this.email = email;
    		this.course = course;
    		this.q = q;
		}
    
	
	
	
	
	
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
	  
	 
	  
	  
	xmlhttp.onreadystatechange=function()
	  {
	  //alert("ajax state change : "+xmlhttp.readyState+"status is : "+xmlhttp.status);
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    	//document.getElementById("displayRecord").innerHTML=xmlhttp.responseText;
	    	//alert("responseXML is : "+xmlhttp.responseXML+", responseText "+xmlhttp.responseText);
// 	    		var parser = new DOMParser();
// 				var xmlDoc = parser.parseFromString(xmlhttp.responseText,"text/xml");
// 	    		alert("The parsed response is : "+xmlDoc);
	
				//alert(xmlhttp.getResponseHeader("Content-Type"));

	    		x=xmlhttp.responseXML.documentElement.getElementsByTagName("QUERY");
	    		//alert("No of records is  "+x.length);
	    		var k;
	    		queries = [];
	    		index = 0;
	    	
	    		for(k = 0; k < x.length; k++)
	    		{
	    			//alert("Just pushing students");
	    			var qid = x[k].getElementsByTagName("QID");
			    	qid = qid[0].firstChild.nodeValue;
			    	
			    	var name = x[k].getElementsByTagName("NAME");
			    	name = name[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var email = x[k].getElementsByTagName("EMAIL");
			    	email = email[0].firstChild.nodeValue;
			    	
			    	var mobile = x[k].getElementsByTagName("MOBILE");
			    	mobile = mobile[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	
			    	
			    	
			    	//alert("Just pushing students");
			    	var course = x[k].getElementsByTagName("COURSE");
			    	
			    	if(course[0] == null || course[0].firstChild == null)
			    		course = "";
			    	else
			    		course = course[0].firstChild.nodeValue;
			    	
			    	//alert("Just pushing students");
			    	
			    	var q = x[k].getElementsByTagName("Q");
			    	q = q[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	
			    	
			    	
			    	queries.push(new query(qid,name,mobile,email,course,q));
	    		}
	    		
	    		//alert("Number of records : "+queries.length);
	    		
	    		drawTable();
	     }
	   
	  }
	  
	  var path = "<%=basePath%>"+"student/searchQuery.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(data);
	}
	
	
	function fetchResult(inputID, e)
	{
		var queryID = document.getElementById(inputID).value;
		var keynum;

            if(window.event)
            { // IE					
            	keynum = e.keyCode;
            }
            else
     		{
	     		if(e.which)
	     		{ // Netscape/Firefox/Opera					
	            	keynum = e.which;
	            }
            }
        keynum = String.fromCharCode(keynum);
        
		if(queryID.length == 9)
		{
			//alert(queryID+keynum.toString());
			//loadQuery(queryID+keynum.toString());
		}
	}
	
	
	function capitalize( str )
	{
	    var pieces = str.split(" ");
	    for ( var i = 0; i < pieces.length; i++ )
	    {
	        var j = pieces[i].charAt(0).toUpperCase();
	        
	        pieces[i] = j + pieces[i].substr(1).toLowerCase();
	    }
	    return pieces.join(" ");
	}
	
	function correct(inputID)
	{
		var value = document.getElementById(inputID).value;
		value = capitalize(value);
		document.getElementById(inputID).value = value;
	}
	
	
	
	function loadData()
	{
		var value = document.getElementById("cen").value;
		var data = "center="+value;
		loadQuery(data);
	
	}
	
	
	function displayPrev()
    	{
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(queries.length > 0 && index > pageSize)
    		{
    			if(index - (2*pageSize) < 0)
    				index = 0;
    			else
    				index = index - (2*pageSize);
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    	
    	}
    	
    	function displayNext()
    	{
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(index < queries.length)
    		{
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    	}
    	
    	function drawTable()
		{
			var i = 0;
			var display = "";
			//alert("Draw table called");
			
			
	       	display += "<tr><th>Query ID</th>";
	       	display += "<th>Name</th>";
	       	display += "<th>Email</th>";
	       	display += "<th>Mobile</th>";
	       	display += "<th>Course</th>";
	       	display += "<th>Query</th>";
	       	display += "</tr>";
			

     		
			for(i = index; i < queries.length && i < index + pageSize; i++)
			{
			//alert("Draw table called");
				display += "<tr>";
				
				display += "<td>"+queries[i].qid+"</td>";
				display += "<td>"+queries[i].name+"</td>";
				display += "<td>"+queries[i].email+"</td>";
				display += "<td>"+queries[i].mobile+"</td>";
				display += "<td>"+queries[i].course+"</td>";
				display += "<td>"+queries[i].q+"</td>";
				
				display += "</tr>";
				
			}
			////alert("Draw table called with index :"+index);
			index = i;
			//alert("Draw table called with index :"+index);
			document.getElementById("table").innerHTML = display;
		
		}
	
	</script>
    
  </head>
  
  <body>
   	<%
   		int i = 0;
   		
   		if(request.getParameter("submit")!=null)
   		{
   			String stname = request.getParameter("stname");
   			String stmobile = request.getParameter("stmobile");
   			String stemail = request.getParameter("stemail");
   			String course = request.getParameter("course");
   			String center = request.getParameter("center");
   			
   			java.util.Date d = new java.util.Date();
			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat ("yyyyMM");
		
			String sid=format.format(d).substring(2);
			
			sid=sid+"/"+center+"/";
			String query = "select query from count_user";
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			int count = 0;
			if(rs.next())
				count = rs.getInt(1);
			
			sid += String.format("%05d", count);
			System.out.println("Query id is : "+sid);
   		
   			ps.close();
   			ps = con.prepareStatement("insert into inquiry values(?,?,?,?,?,?)");
   			ps.setString(1,sid);
   			ps.setString(2, stname);
   			ps.setString(3, stmobile);
   			ps.setString(4, stemail);
   			ps.setString(5, course);
   			ps.setString(6,"I am interested in "+course);
   			System.out.println(ps);
   			i = ps.executeUpdate();
   			ps.close();
   			
   			ps = con.prepareStatement("update count_user set query = query + 1");
   			i = ps.executeUpdate();
   			
   			session.setAttribute("qid", i);
   			session.setAttribute("qid1", sid);
   			//response.sendRedirect("RegisterQuery.jsp");
   			
   		}
   	 %>
   	
			      
		
		
   	
   		
       	 <form method="post" name="form" action="" class="form-horizontal" >
          
         <fieldset>
          <legend><h3><strong>&nbsp;Register Query</strong></h3></legend>
          
          <%
          System.out.println("Session : "+session.getAttribute("qid")+" , "+session.getAttribute("qid1"));
          if(session.getAttribute("qid") != null && (Integer)session.getAttribute("qid") == 0)
          {
          
           %>
          
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Something went wrong while registering query, try again.
   		 </div>
   		 
   		 <%
   		  }
   		  else if(session.getAttribute("qid") != null && (Integer)session.getAttribute("qid") == 1)
   		  {
   		  %>
   		  	<div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Registration Success !</strong> Query has been successfully registered with ID : <strong><%=session.getAttribute("qid1") %></strong>.
   		 </div>
   		  
   		  
   		  <%
   		  session.removeAttribute("qid");
   		  session.removeAttribute("qid1");
   		  }
   		
   		   %>
          
		   <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Name :</label>
           	<label style="color:red">*</label>
           <div class="col-sm-6">
           <input type="text" name="stname" class="form-control" placeholder="Enter Name" id="inputName" required="true" onblur="correct(this.id)"></input>
            </div>
            </div>
            
            <div class="form-group">
            <label for="inputStudent" class="col-sm-2 control-label" align="left">Contact No. :</label> 
		   <div class="col-sm-2">  
		   
		   <input type="text" required="true" class="form-control" Maxlength="10" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" name="stmobile" id="inputStudent" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No."/></input>
		   </div>
		  </div>
            
            
            <div class="form-group">
		   <label for="inputEmail" class="col-sm-2 control-label" align="left">Email ID :</label> 
		   	<label style="color:red">*</label>
		   <div class="col-sm-5">  
		   <input type="email" name="stemail" class="form-control" id="inputEmail" placeholder="Enter Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true"  ></input>
		   </div>
			</div>
			
			
			 <div class="form-group">
		     <label for="course" class="col-sm-2 control-label" align="left">Course Of Interest :</label> 
             <div class="col-sm-6"> 
             <div class="input-group">
             <select name="course" class="form-control">
             <%
              try
              {
              
                   
			       String stmt = "select * from course union select * from dbcourse";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		
             			<option value="<%=rs.getString(1)%>"> <%= rs.getString(2) %></option>
             		
             		<%
             		}
             }
             catch(Exception e)
             {
              e.printStackTrace();
             } %>
             </select>
             </div>
		     </div>
		     </div>
		     
		     
		      <div class="form-group">
		      <label for="course" class="col-sm-2 control-label" align="left">Registration Center :</label> 
		      	<div class="col-sm-2">
		      		<select name="center" class="form-control">
		      			<option value="TR">Tonk Road</option>
		      			<option value="PN">Pratap Nagar</option>
		      			<option value="KK">Kukas</option>
		      			<option value="OT">Other</option>
		      			
		      		</select>
		      	</div>
		      </div>
		     
		     
		     <div class="form-group"> 
 		     <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" name="submit" class="btn btn-success btn-lg" value="Register Query" /> 		     
 		     </div>
 		     </div>
		     </fieldset>
		     
		    </form> 
		  
           <fieldset>
           <legend><strong>&nbsp;View Queries</strong></legend>
          	<div >
          		<table id="table" class="table table-striped">
          		
          		</table>
          		<ul class="pager">
  			<li><a href="javascript:displayPrev()">&lt;- Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next -&gt;</a></li>
		</ul>
          	</div>
         
           </fieldset>
           
           <div class="form-group">
		      <label for="course" class="col-sm-2 control-label" align="left">Registration Center :</label> 
		      	<div class="col-sm-2">
		      		<select name="center" id="cen" class="form-control" onchange="">
		      			<option value="TR">Tonk Road</option>
		      			<option value="PN">Pratap Nagar</option>
		      			<option value="KK">Kukas</option>
		      			<option value="OT">Other</option>
		      			
		      		</select>
		      	</div>
		      </div>
           
           
            <div class="form-group"> 
 		     <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="button" class="btn btn-primary btn-lg" value="Show Queries" onclick="loadData()" /> 		     
 		     </div>
   		 
   		     
   		    
 		     <div class="col-sm-2"> 
 		     <input type="reset" class="btn btn-default btn-lg" value="Reset" onclick="document.getElementById('table').innerHTML = ''"/>     
 		     </div>
   		     </div> 
       
           
           <%
             
             
             
             
             }
       		catch(Exception e)
       		{
       			e.printStackTrace();
       			response.sendRedirect("Error.jsp");
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
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- <script src="js/jquery.min.js"></script>
    
    <script src="js/docs.min.js"></script> -->
    <script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
    
  </body>
</html>
