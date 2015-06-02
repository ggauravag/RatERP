<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.DBInfo,com.login.*"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";



String type = (String)session.getAttribute("type");
	if(type != null && (type.equals("ADMIN") || type.equals("HELPDESK")))
	{
		
	}
	else
	{
		response.sendRedirect("../Unauthorize.jsp");
		return;
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
    
    <title>My JSP 'IssueCertificate.jsp' starting page</title>
    
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
	 	 var students = [];
		
		 var pagesize = 15;
		 
		 var indexStudent = 0;

		function student(sid, name, mobile, course, certificate,cid)
    	{
    		this.id = sid; 
    		this.name  = name;
    		this.mobile = mobile;
    		this.cid = cid;
    		this.course = course;
    		this.certificate = certificate;
		}
		
		function displayPrev()
    	{
    		//alert("index is : "+indexStudent+" and students is : "+stuarray.length)
    		if(students.length > 0 && indexStudent > pagesize)
    		{
    			if((indexStudent - (2*pagesize)) < 0)
    				indexStudent = 0;
    			else
    				indexStudent = indexStudent - (2*pagesize);
    			drawStu();
    		}
    		//alert("index is : "+indexStudent+" and students is : "+stuarray.length)
    	
    	}
    	
    	function displayNext()
    	{
    		//alert("index is : "+indexStudent+" and students is : "+stuarray.length)
    		if(indexStudent < students.length)
    		{
    			drawStu();
    		}
    		//alert("index is : "+indexStudent+" and students is : "+stuarray.length)
    	}
    	
    	function drawStu()
		{
			var i = 0;
			var display = "";
			//alert("Draw Student called");
	       	display += "<tr>";
	       	display += "<th>Student ID</th>";
	       	display += "<th>Name</th>";
	       	display += "<th>Mobile</th>";
	       	display += "<th>Course</th>";
	       	display += "<th>Certificate</th>";
	       	display += "<th>Option</th>";	
	       	display += "</tr>";
	       	
	       	//alert("The length during drawing is : "+stuarray.length);
			     		
			for(i = indexStudent; i < students.length && i < indexStudent + pagesize; i++)
			{
			    //alert("Drawing row number : "+i+" with index : "+index+" and array length : "+stuarray.length);
				display += "<tr>";
				display += "<td>"+students[i].id+"</td>";
				display += "<td>"+students[i].name+"</td>";
			
				display += "<td>"+students[i].mobile+"</td>";
				display += "<td>"+students[i].course+"</td>";
				
				if(students[i].certificate == "null")
				{
					display += "<td>No Certificate</td>";
					display += "<td><button class='btn btn-primary' id='"+students[i].id+","+students[i].cid+"' onclick='openWindow(this.id);return false;'>Issue Certificate</button></td>";
				}
				else
				{
					display += "<td>"+students[i].certificate+"</td>";
					display += "<td><button class='btn btn-primary' id='"+students[i].certificate+"' onclick='openView(this.id)' >View Details</button></td>";
				
				}
				display += "</tr>";
			}
			////alert("Draw table called with index :"+index);
			indexStudent = i;
			//alert("Draw table called with index :"+index);
			document.getElementById("table").innerHTML = display;
		
		}
		
		function openView(id)
		{
			window.open("account/helpdesk/ViewDetails.jsp?cerid="+id+"", "_blank", "width=600", false);
			//window.reload();
			
			
		
		
		}
		
		
		function openWindow(id)
		{
		
			var ids = id.split(",");
			
			window.open("account/helpdesk/EnterDetails.jsp?stuid="+ids[0]+"&courseid="+ids[1]+"", "_blank", "width=600", false);
			//window.reload();
			
			location.reload(true);
			console.log("Window Reloaded");
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
			    		y=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
			    		students = [];
			    		indexStudent = 0;
			    	 	var k ;
			    	 	for(k = 0; k < y.length; k++)
			    		{
			    			//alert("Just pushing students");
			    			var sid = y[k].getElementsByTagName("SID");
				    		sid = sid[0].firstChild.nodeValue;
				    	
					    	var name = y[k].getElementsByTagName("NAME");
					    	name = name[0].firstChild.nodeValue;
					    	//alert("Just pushing students");
					    	
					    	
					    	var course = y[k].getElementsByTagName("COURSE");
					    	course = course[0].firstChild.nodeValue;
					    	//alert("Just pushing students");
					    	
					    	
					    	
					    	var lang = y[k].getElementsByTagName("CERTIFICATE");
					    	
					    	if(lang[0] == null || lang[0].firstChild == null)
					    		lang = "";
					    	else
					    		lang = lang[0].firstChild.nodeValue;
					    	
					    	
					    	var mobile = y[k].getElementsByTagName("MOBILE");
					    	mobile = mobile[0].firstChild.nodeValue;
					    	
					    	var cid = y[k].getElementsByTagName("CID");
					    	cid = cid[0].firstChild.nodeValue;
					    	
				    	//alert("ID, Name, Mobile, k : "+sid+" "+name+" "+mobile+" "+k);
				    	students.push(new student(sid, name, mobile, course, lang,cid));
		    			//alert("The length is : "+stuarray.length);
			  			}
			  			
			  			drawStu();
			  
			  	}
			 }
			  var path = "<%=basePath%>"+"account/helpdesk/CertificateEnd.jsp";
			xmlhttp.open("POST",path,true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send(data);
		}
	 	
	 	
	 	
	 	function submitForm(value)
	 	{
	 		//alert(value);
	 		if(value == "")
	 			return;
	 		var data = "courseid="+value;
	 		loadQuery(data);
	 	
	 	}
	 
	 </script>

  </head>
  
  <body>
   
	
   
    <fieldset>
           <legend><strong>&nbsp;&nbsp;Search Course</strong></legend>
           
           <div class="form-group">
           <label for="selectCriteria" class="col-sm-2 control-label" align="left">Select Course :</label>
            <div class="col-sm-3">
                  <select class="form-control" name="course" onchange="submitForm(this.value)">
   					<option value="">---Select---</option>
   				<%
   					String query = "select * from cerview";
   					PreparedStatement ps = con.prepareStatement(query);
   					ResultSet rs = ps.executeQuery();
   					
   					while(rs.next())
   					{
   						%>
   							<option value="<%=rs.getString(1)%>"><%=rs.getString(2) %></option>
   						<% 
   					
   					}
   				
   				 %>
   			
   			</select>
           
            </div>
           </div>
           
          
           
         
      </fieldset>
      
     
     <fieldset>
      
       
       
       <fieldset>
       <legend><strong>&nbsp;&nbsp;Students</strong></legend>
       <div class="form-group">
      <div class="col-sm-12" id="display">
     	<table id="table" class="table table-striped">
     	
     	
     	</table>
    </div>
    
  </div>
  <ul class="pager">
  			<li><a href="javascript:displayPrev()">&lt;- Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next -&gt;</a></li>
		</ul>
       </fieldset>
       
       
       
       
    
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
