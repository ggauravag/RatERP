<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*,com.login.SendMail" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.println(request.getRemoteAddr()+" : "+request.getRemoteHost()+" : "+request.getRemotePort()+" : "+request.getRequestURL());

Connection con = null;
try
{

	con = DBInfo.getConn();

	HttpSession session1 =  request.getSession(false);

	if(session1==null)
	{
	response.sendRedirect("Unauthorize.jsp");
	return;
	}
	String id = (String)session.getAttribute("id"); 
	if(id == null)
	{
	response.sendRedirect("Unauthorize.jsp");
	return;
	}
	 String center = id.substring(5, 7);
	System.out.println("The center is : "+center);
	
	String status = request.getParameter("status");

	if(request.getParameter("value")!=null)
	{
		PreparedStatement ps = null;
		String values = request.getParameter("value");
		StringTokenizer tokens = new StringTokenizer(values,",");
		String modid = request.getParameter("module");
		String st = null;
		
		while(tokens.hasMoreTokens())
		{
			String sid = tokens.nextToken();
			st = "";
			String sql = "{ CALL AddStudyMat(?,?) }";
			CallableStatement call = con.prepareCall(sql);
			call.setString(1, sid);
			call.setString(2, modid+",");
			//System.out.println("Call statement is : "+call+" and ID is : "+sid+" operation is :"+call.execute());
			call.execute();
			
			st = "success";
			call.close();
			
			
		
			//System.out.println("The token is :"+tokens.nextToken());
		}
		
		
		if(st.equals("success"))
		{
			response.sendRedirect("IssueSM.jsp?status=success");
				return;
		
		}
		if(st.equals("failure"))
		{
			response.sendRedirect("IssueSM.jsp?status=failure");
				return;
		
		}
		
	
	}
	
	
	
	Dictionary dict = new Hashtable<String,String>();
	PreparedStatement ps = con.prepareStatement("select * from course");
	ResultSet res = ps.executeQuery();
	int index = 0;
	while(res.next())
	{
		dict.put(res.getString("courseid"), res.getString("name"));
		index++;
		//System.out.println("Dict updated");
	}
	res.close();
	ps.close();
	ps = con.prepareStatement("select * from dbcourse");
	res = ps.executeQuery();
	while(res.next())
	{
		dict.put(String.valueOf(res.getInt("dbid")), res.getString("dbname"));
		index++;
		//System.out.println("Dict updated\n-------------");
	}
	res.close();
	ps.close();


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Issue Study Material</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  <link rel="stylesheet" href="css/bootstrap.css" type="text/css"></link>
  
  </head>
  
  <body>
  <form class="form-horizontal" role="form">
   <fieldset>
 <legend><strong><h1>Issue Study Material</h1></strong></legend>
  </fieldset>
  <br>
  <%
  	//System.out.println("Status is :"+status);
  	if(status!=null && status.equals("success"))
  	{
  		%>
  		<div class="alert alert-success alert-dismissible" role="alert">
 			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
  			<strong>Success!</strong> Study Material Issued.
		</div>
  		<%
  	}
  	if(status!=null && status.equals("failure"))
  	{
  	    %>
  		<div class="alert alert-warning alert-dismissible" role="alert">
 			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
  			<strong>Oh Snap !</strong> Something went wrong while issuing material, please try again.
		</div>
  		<%
  	}
  
   %>
  <br>
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Select Class : </label>
    
    <div class="col-sm-4">
    <select name="class" id="class" class="form-control" onchange="callAjax(this.id,this.value.split(',')[0])">
    <option value="">--------</option>
    <%
    	ps = con.prepareStatement("select * from class where center=?");
    	ps.setString(1, center);
    	//System.out.println("The stmt is : "+ps.toString());
        res = ps.executeQuery();
    	while(res.next())
    	{
    		//System.out.println("Inside");
    		%><option value="<%=res.getString("courseid")+","+res.getString("classid") %>" ><%=(String)dict.get(res.getString("courseid"))+" - "+res.getString("schedule")+" - "+res.getString("time") %></option><%
    	}
    	res.close();
    	ps.close();
     %>
    </select>
    </div>
    
    <label class="col-sm-2 control-label">Select Material : </label>
    
    <div class="col-sm-3">
    <select name="module" id="module" class="form-control" onchange="callAjax(this.id,this.value)">
    
    
    </select>
    </div>
  </div>
 
  <div class="form-group">
    <div class="col-sm-offset-1 col-sm-10">
     	<table id="table" class="table table-hover">
     		
     	
     	
     	</table>
     	<ul class="pager">
  			<li><a href="javascript:displayPrev()">Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next</a></li>
		</ul>
    </div>
  </div>
  
  <div class="form-group">
  	<input type="submit" value="Issue Study Material" onclick="prepareData();" class="btn btn-success col-sm-offset-5"> 
  	<input id="hidden" name="value" hidden>
  </div>
</form>
    <script type="text/javascript">
   
   		var index = 0;
   		
    	function displayPrev()
    	{
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(student.length > 0 && index > 20)
    		{
    			if(index - 40 < 0)
    				index = 0;
    			else
    				index = index - 40;
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    	
    	}
    	
    	function displayNext()
    	{
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(index < students.length - 1)
    		{
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    	}
    	    	

	  	
	  	function callAjax(id,smid)
	  	{
	  		var data;
		  	if(id=="class" && smid!="")
		  	{
		  		//alert("Class changed");
		  		data = "classid="+smid;
		  	}
		  	else if(id=="module" && smid!="")
		  	{
		  		//alert("Module changed");
		  		var cid = document.getElementById("class").value.split(',')[1];
		  		data = "smid="+smid+"&class="+cid;
		  	}
		  	else
		  	{
		  		return;
		  	}
	  		
	  		
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
	 // alert("ajax state change : "+xmlhttp.readyState+"status is : "+xmlhttp.status);
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    	//alert("Ajax is ready");
	    	if(id == "class")
	    	{
	    	//alert("The response is : "+xmlhttp.responseText);	    	
	    	document.getElementById("module").innerHTML=xmlhttp.responseText;
	    	}
	    	else if(id == "module")
	    	{
	    		//alert("Response in Text is "+xmlhttp.responseText);
	    		//alert("Response in XML is "+xmlhttp.responseXML);
	    		x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
	    		//alert("Response in XML is "+x.length);
	    		var k;
	    		students = [];
	    		index = 0;
	    		for(k = 0; k < x.length; k++)
	    		{
	    			
	    			var sid = x[k].getElementsByTagName("ID");
			    	sid = sid[0].firstChild.nodeValue;
			    	
			    	var name = x[k].getElementsByTagName("NAME");
			    	name = name[0].firstChild.nodeValue;
			    	
			    	var mobile = x[k].getElementsByTagName("MOBILE");
			    	mobile = mobile[0].firstChild.nodeValue;
			    	
			    	//alert("ID, Name, Mobile, k : "+sid+" "+name+" "+mobile+" "+k);
			    	students.push(new student(sid, name, mobile));
	    		}
	    		
	    		//alert("Number of records : "+students.length);
	    		
	    		drawTable();
	    		
	    		
	    		
	    		
	    	
	    	}
	    	else
			{
			///alert("Value of id : "+id);
			}  
	    		   
	    	//alert(xmlhttp.responseXML);
	    	/* x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
	    	
	    	if(x[0]==null)
	    	{
	    		document.getElementById("message").innerHTML = "<div class='alert alert-danger'><span class='glyphicon glyphicon-remove'></span>&nbsp;Invalid Query ID !</div>";
	    		document.getElementById("inputName").value = "";
	    		document.getElementById("inputEmail").value = "";
	    		document.getElementById("inputStudent").value = "";
	    		
	    		return;
	    	}
	    	
	    	
	    	var name = x[0].getElementsByTagName("NAME");
	    	name = name[0].firstChild.nodeValue;
	    	
	    	var mobile = x[0].getElementsByTagName("MOBILE");
	    	mobile = mobile[0].firstChild.nodeValue;
	    	
	    	var email = x[0].getElementsByTagName("EMAIL");
	    	email = email[0].firstChild.nodeValue;
	    	
	    	
	    	document.getElementById("inputName").value = capitalize(name);
	    	document.getElementById("inputEmail").value = email;
	    	document.getElementById("inputStudent").value = mobile;
	    	document.getElementById("message").innerHTML = "<div class='alert alert-success'><span class='glyphicon glyphicon-ok '></span>&nbsp;Valid Query ID !</div>";
	    */ }
	   
	  }
	  
		  var path = "<%=basePath%>"+"student/searchQuery.jsp";
		  xmlhttp.open("POST",path,true);
		  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		  xmlhttp.send(data);
	  	
	  	
	  	}
	  	
	  	
	  	var students = [];
    	
    	function student(id, name, mobile)
    	{
    		this.id = id; 
    		this.name  = name;
    		this.mobile = mobile;
    		this.select = false;
    		
		}
		
		   
		
		function drawTable()
		{
			var i = 0;
			var display = "";
			//alert("Draw table called");
			display += "<tr>";
     			display += "<th>Select</th>";
     			display +="<th>Student ID</th>";
     			display +="<th>Name</th>";
     			display +="<th>Mobile</th>";
     			display += "</tr>";
     		
			for(i = index; i < students.length && i < index + 20; i++)
			{
			//alert("Draw table called");
				display += "<tr>";
				display += "<td><input type=checkbox onclick='addData(this.value, this)' value='"+i+"'></td>";
				display += "<td>"+students[i].id+"</td>";
				display += "<td>"+students[i].name+"</td>";
				display += "<td>"+students[i].mobile+"</td>";
				display += "</tr>";
				
			}
			////alert("Draw table called with index :"+index);
			index = i;
			//alert("Draw table called with index :"+index);
			document.getElementById("table").innerHTML = display;
		
		}
		
		
		function addData(index,cbox)
		{
			if(cbox.checked)
			{
				
				students[index].select = true;
			}
			else
			{
				//alert("student deselected");
				students[index].select = false;
			}
			
		}
		
		function prepareData()
		{
			var i;
			for(i = 0; i < students.length;i++)
			{
				
				if(students[i].select)
				{
					document.getElementById("hidden").value += students[i].id + ",";
					//alert("Student selected with id : "+students[i].id);
				}
			}
			//alert("The final data is : "+document.getElementById("hidden").value);
		
		}
	  	
	
    
    </script>
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
  </body>
</html>
