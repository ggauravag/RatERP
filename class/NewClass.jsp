<%@page import="com.login.SendMail"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.text.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String type = (String)session.getAttribute("type");
	if(type != null && (type.equals("ADMIN") || type.equals("HELPDESK")))
	{
		
	}
	else
	{
		response.sendRedirect("Unauthorize.jsp");
		return;
	}
         Connection con = null;
         
     try
     {
         con = DBInfo.getConn();
         if(request.getParameter("AddClass")!=null)
         {
         	String center = request.getParameter("center");
         	String days[] = request.getParameterValues("day");
         	String trainer = request.getParameter("trainer");
         	String st_time = request.getParameter("stime1")+":"+request.getParameter("stime2")+":00";
         	String e_time = request.getParameter("etime1")+":"+request.getParameter("etime2")+":00";
         	String course = request.getParameter("lang");
         	String starray = request.getParameter("stu");
         	String stdate = request.getParameter("stdate");
         	
         	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = sdf1.parse(stdate);
			java.sql.Date d = new java.sql.Date(date.getTime());
			
         	String student[] = starray.split(",");
         	String sched = "";
         	for(int n = 0; n < days.length; n++)
         	{
         		if(n != 0)
         			sched += ","+days[n];
         		else
         			sched += days[n];
         	}
         	
         	
   
			  String sql = "{call AddClass (?)}";
		      CallableStatement stmt = con.prepareCall(sql);
		      stmt.registerOutParameter(1, java.sql.Types.INTEGER);
		      stmt.execute();
		      int count = stmt.getInt(1);
	         	//System.out.println("Add Class with : "+center+", "+days+", "+trainer+", "+st_time+", "+e_time+", "+course+", No of students :  "+student.length);
	         	String query = "insert into class values(?,?,?,?,?,?,?,?)";
	         	PreparedStatement ps = con.prepareStatement(query);
	         	ps.setString(1, count+"");
	         	ps.setString(2, st_time);
	         	ps.setString(3,sched);
	         	ps.setString(4, center);
	         	ps.setString(5, trainer);
	         	ps.setString(6, course);
	         	ps.setDate(7, d);
	         	ps.setDate(8,null);
	         	
	         	//System.out.println("Prepared Statement is : "+ps);
	         	int j = ps.executeUpdate();
	         	
	         	
	         	String students = "";
	         	for(int n = 0; n < student.length; n++)
	         	{
	         		if(n == 0)
	         			students = "'"+student[n]+"'";
	         		else
	         			students += ",'"+student[n]+"'";
	         	
	         	}
	         	
	         	
	         
	         	query = "update student set class = concat(class,?) where studentid in ("+students+")";
	         	ps = con.prepareStatement(query);
	         	ps.setString(1, count+",");
	         
	         	
	         	//System.out.println("The statement is : "+ps);
	        	
	        	j = ps.executeUpdate();
	        	
	         	session.setAttribute("class", j);
	         	
	         	//response.sendRedirect("NewClass.jsp");
         	
         	
         	//
         }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Add New Class</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
     <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="css/images/ratico.ico">
    
    <script type="text/javascript">
    function loadQuery(queryID)
	{
	var xmlhttp;
	//alert('ajax called');
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
	    //document.getElementById(divID).innerHTML=xmlhttp.responseText;
	    	//alert(xmlhttp.responseText);
	    	//document.getElementById("selectRecord").innerHTML = xmlhttp.responseText;
	    	
	    		x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
	    		//alert("No of records is  "+x.length);
	    		var k;
	    		students = [];
	    		index = 0;
	    		//alert("Just pushing students");
	    		for(k = 0; k < x.length; k++)
	    		{
	    			//alert("Just pushing students");
	    			var sid = x[k].getElementsByTagName("ID");
			    	sid = sid[0].firstChild.nodeValue;
			    	
			    	var name = x[k].getElementsByTagName("NAME");
			    	name = name[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var email = x[k].getElementsByTagName("EMAIL");
			    	email = email[0].firstChild.nodeValue;
			    	
			    	var pid = x[k].getElementsByTagName("PID");
			    	pid = pid[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	
			    	
			    	
			    	//alert("Just pushing students");
			    	var lang = x[k].getElementsByTagName("LANG");
			    	
			    	if(lang[0] == null || lang[0].firstChild == null)
			    		lang = "";
			    	else
			    		lang = lang[0].firstChild.nodeValue;
			    	
			    	//alert("Just pushing students");
			    	var db = x[k].getElementsByTagName("DB");
			    	if(db[0] == null || db[0].firstChild == null)
			    		db = "";
			    	else
			    		db = db[0].firstChild.nodeValue;
			    	
			    	var img = x[k].getElementsByTagName("IMAGE");
			    	img = img[0].firstChild.nodeValue;
			    	
			    	var mobile = x[k].getElementsByTagName("MOBILE");
			    	mobile = mobile[0].firstChild.nodeValue;
			    	
			    	//alert("ID, Name, Mobile, k : "+sid+" "+name+" "+mobile+" "+k);
			    	students.push(new student(sid, name, mobile, email, pid, lang, db, img));
	    		}
	    		
	    		//alert("Number of records : "+students.length);
	    		
	    		drawTable();
	    }
	   
	  }
	  
	  var path = "<%=basePath%>"+"student/SearchCourseStudent.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	var data = "courseid="+ queryID;
	xmlhttp.send(data);
	}
	
	var index = 0;
	var pagesize = 5;
	
     function fetchResult(cid, e)
	{
		var queryID = document.getElementById(cid).value;
	  loadQuery(queryID);
		
	}
	
	
		var students = [];
    	
    	function student(sid, name, mobile, email, pid, lang, db, img)
    	{
    		this.id = sid; 
    		this.name  = name;
    		this.mobile = mobile;
    		this.select = false;
    		this.email = email;
    		this.pid = pid;
    		this.lang = lang;
    		this.db = db;
    		this.img = img;
		}
    
    
    	function addSelect()
		{
			var checkboxes = document.getElementsByName("st");
			for (var i=0, n=checkboxes.length;i<n;i++) {
				
			  if (checkboxes[i].checked) 
			  {
			  	students[parseInt(checkboxes[i].value)].select = true;
			  }
			  else
			  {
			  	students[parseInt(checkboxes[i].value)].select = false;
			  }
			}
			
			var container = document.getElementById("starray");
			var data = "";
			for(var i = 0; i < students.length; i++)
			{
				if(students[i].select)
				{
					if(data != "")
						data += ","+students[i].id;
					else
						data += students[i].id +"";
				}
			}
			
			container.value = data;
			//alert("Data is : "+document.getElementById("starray").value);
			
		}
    
    
    function displayPrev()
    	{
    	
    		
			//if (val) val = val.substring(1);
			
			addSelect();
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(student.length > 0 && index > pagesize)
    		{
    			if(index - (2*pagesize) < 0)
    				index = 0;
    			else
    				index = index - (2*pagesize);
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    	
    	}
    	
    	function displayNext()
    	{
    		addSelect();
    	
    	
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(index <= students.length - 1)
    		{
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    		
    		
			//if (val) val = val.substring(1);
    	}
    	
    	function drawTable()
		{
			var i = 0;
			var display = "";
			//alert("Draw table called");
			
			
	       
	       	display += "<tr><th>Select</th>";
	       	display += "<th>Student ID</th>";
	       	display += "<th>Name</ th>";
	       	display += "<th>Email</th>";
	       	display += "<th>Mobile</th>";
	       	display += "<th>P-ID</th>";
	       	display += "<th>Language</th>";
	       	display += "<th>Database</th>";
	       	display += "<th>Image</th>";	
	       	display += "</tr>";
			
			
// 			/* display += "<tr>";
//      			display += "<th>Select</th>";
//      			display +="<th>Student ID</th>";
//      			display +="<th>Name</th>";
//      			display +="<th>Mobile</th>";
//      			display += "</tr>"; */
     		
			for(i = index; i < students.length && i < index + pagesize; i++)
			{
			//alert("Draw table called");
				display += "<tr>";
				if(students[i].select)
					display += "<td><input type='checkbox' name='st' id='st"+i+"' value='"+i+"' checked></td>";
				else
					display += "<td><input type='checkbox' name='st' id='st"+i+"' value='"+i+"'></td>";
				display += "<td>"+students[i].id+"</td>";
				display += "<td>"+students[i].name+"</td>";
				display += "<td>"+students[i].email+"</td>";
				display += "<td>"+students[i].mobile+"</td>";
				display += "<td>"+students[i].pid+"</td>";
				
				
				display += "<td>"+students[i].lang+"</td>";
				display += "<td>"+students[i].db+"</td>";
				display += "<td><img src="+students[i].img+" height='50px' width='50px'></td>";
				
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
    <form method="get" class="form-horizontal" action="">
    
          <fieldset>
          <legend><h1><strong>&nbsp;Add New Class</strong></h1></legend>
          </fieldset>
          <%
          		if(session.getAttribute("class")!=null)
          		{
          				if(((Integer)session.getAttribute("class")) >= 1)
          				{
          					%>
					  		<div class="alert alert-success alert-dismissible" role="alert">
					 			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					  			<strong>Success !</strong> New Class Created.
							</div>
					  		<%
          				}
          				else
          				{
          					%>
					  		<div class="alert alert-warning alert-dismissible" role="alert">
					 			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					  			<strong>Oh Snap !</strong> Something went wrong while creating new class, please try again.
							</div>
					  		<%
          				}
          				
          				session.removeAttribute("class");
          		
          		}
          		else
          		{
          			System.out.println("No op");
          		}
          
           %>
          
          <div class="form-group">
          <input type=hidden name=stu id=starray >	   
		      <label for="center" class="col-sm-2 control-label" align="left">Class Location :</label> 
		      	<div class="col-sm-2">
		      		<select name="center" class="form-control">
		      		    <option selected="selected" disabled="disabled">-Select-</option>
		      			<option value="TR">Tonk Road</option>
		      			<option value="PN">Pratap Nagar</option>
		      			<option value="KK">Kukas</option>
		      			<option value="OT">Other</option>
		      			
		      		</select>
		      	</div>
		      </div>
		      
		      
		      <div class="form-group">
         
		      <label for="center" class="col-sm-2 control-label" align="left">Start Date :</label> 
		      	<div class="col-sm-2">
		      		<input type=date name=stdate class="form-control">
		      	</div>
		      </div>
		      
		   
		     
		     <div class="form-group">
		      <label for="sched" class="col-sm-2 control-label" align="left">Schedule :</label> 
		      	<div class="col-sm-9">
		               
		               <label class="checkbox-inline col-sm-2">
		                <input type="checkbox" name="day" id="mon" value="Monday">Monday
		                </label>
		               <label class="checkbox-inline col-sm-2">
		                <input type="checkbox" name="day" id="tue" value="Tuesday">Tuesday
		                </label>
		               <label class="checkbox-inline col-sm-2">
		                <input type="checkbox" name="day" id="wed" value="Wednesday">Wednesday
		                </label>
		               
		               
		        </div>
		     </div>
		     
		     
		     <div class="form-group">
		     
		     <div class="col-sm-offset-2 col-sm-9">
		     
		                <label class="checkbox-inline col-sm-2"> 
		                <input type="checkbox" name="day" id="thu" value="Thursday">Thursday
		                </label>
		               <label class="checkbox-inline col-sm-2">
		                <input type="checkbox" name="day" id="fri" value="Friday">Friday
		                </label>
		               <label class="checkbox-inline col-sm-2"> 
		                <input type="checkbox" name="day" id="sat" value="Saturday">Saturday</label>
		               <label class="checkbox-inline col-sm-2"> 
		                <input type="checkbox" name="day" id="sun" value="Sunday">Sunday
		               </label>
		     </div>
		     </div>
		     
		     <div class="form-group">
		      <label for="course" class="col-sm-2 control-label" align="left">Trainer :</label> 
		      	<div class="col-sm-2">
		      	       <select name="trainer" class="form-control">
		      	       <option selected="selected" disabled="disabled">-Select-</option>
		      	       <%
                      try
                         {
                  
			               String stmt = "Select * from trainer";
			               PreparedStatement ps = con.prepareStatement(stmt);
			               ResultSet rs = ps.executeQuery();
                   
                            while(rs.next())
                             {        
             		       %>
             		       <option value="<%=rs.getString(1)%>" > <%= rs.getString(2) %></option>
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
		      	
		      	
		    <div class="form-group">
		      <label for="sched" class="col-sm-2 control-label" align="left">Start Time :</label> 
		      	<div class="col-sm-2">
		      	   <select name="stime1" class="form-control">
		      	     <option selected="selected" disabled="disabled">-Select-</option>
		      	     
		      	     <option value="06">6</option>
		      	     <option value="07">7</option>
		      	     <option value="08">8</option>
		      	     <option value="09">9</option>
		      	     <option value="10">10</option>
		      	     <option value="11">11</option>
		      	     <option value="12">12</option>
		      	      <option value="13">13</option>
		      	       <option value="14">14</option>
		      	        <option value="15">15</option>
		      	         <option value="16">16</option>
		      	          <option value="17">17</option>
		      	       <option value="18">18</option>
		      	        <option value="19">19</option>
		      	         <option value="20">20</option>
		      	          <option value="21">21</option>
		      	           
		      	   </select>
		      	</div>
		      	
		      	<div class="col-sm-2">
		      	 
		      	   <select name="stime2" class="form-control">		      	    
		      	     <option value="00">00</option>
		      	     <option value="15">15</option>
		      	     <option value="30">30</option>
		      	     <option value="45">45</option>
		      	     </select>
		      	 </div> 
		      	 
		      	
		    </div>
		    
		    
		    
		    
		    
		    
		    
		    <div class="form-group">
		     <label for="Lang" class="col-sm-2 control-label" align="left">Select Course :</label> 
             <div class="col-sm-3"> 
             <select name="lang" id="cid" class="form-control" onchange="fetchResult(this.id, event)">
             <option selected="selected" disabled="disabled">-Select Language-</option>
             <%
              try
              {
                          
			       String stmt = "Select * from course";
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
             
             <option disabled="disabled">-Select DataBase-</option>
             <%
              try
              {
                  
			       String stmt = "Select * from dbcourse";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		
             			<option value="<%=rs.getString(1)%>" > <%= rs.getString(2) %></option>
             	
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
		     
		     
		     
		     <fieldset>
       <legend><strong>&nbsp;&nbsp;Select Students</strong></legend>
       <div class="col-sm-12">
       	<table class='table table-striped ' id="table">
       	
       	
       	</table>
       	<ul class="pager">
  			<li><a href="javascript:displayPrev()">&lt;- Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next -&gt;</a></li>
		</ul>
       </div>
       <div class="form-group">	
       
       <input type="submit" name="AddClass" class="btn btn-success col-sm-offset-5" value="Add Students" onclick="addSelect()">		     
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
     </form>
  </body>
</html>
