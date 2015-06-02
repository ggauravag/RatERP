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

	String type1 = (String)session.getAttribute("type");
	if(type1 != null && (type1.equals("ADMIN") || type1.equals("HELPDESK")))
	{
		
	}
	else
	{
		response.sendRedirect("../Unauthorize.jsp");
		return;
	}



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
 	session.removeAttribute("err"); 
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
	var index = 0;
	var pagesize = 15;
	
		var students = [];
		
		function drawReset()
		{
			document.getElementById("table").innerHTML= "";
		
		}
		
    	
    	function student(sid, name, mobile, email,ladd)
    	{
    		this.id = sid; 
    		this.name  = name;
    		this.mobile = mobile;
    		//this.select = false;
    		this.email = email;
    		this.ladd = ladd;
		}
	
	function displayPrev()
    	{
    	
    		
			//if (val) val = val.substring(1);
			
			//addSelect();
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(students.length > 0 && index > pagesize)
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
    		//addSelect();
    	
    	
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
			
			
	       
	       	display += "<tr>";
	       	display += "<th>Student ID</th>";
	       	display += "<th>Name</ th>";
	       	display += "<th>Email</th>";
	       	display += "<th>Mobile</th>";
	       	display += "<th>Address</th>";
	       	
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
				display += "<td>"+students[i].id+"</td>";
				display += "<td>"+students[i].name+"</td>";
				display += "<td>"+students[i].email+"</td>";
				display += "<td>"+students[i].mobile+"</td>";
				
				display += "<td>"+students[i].ladd+"</td>";
				display += "</tr>";
				
			}
			////alert("Draw table called with index :"+index);
			index = i;
			//alert("Draw table called with index :"+index);
			document.getElementById("table").innerHTML = display;
		
		}
	
	
	function loadQuery(data)
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
	    	//alert(xmlhttp.responseXML);
	    	
	    	y=xmlhttp.responseXML.documentElement.getElementsByTagName("STU");
	    	if(y[0] != null)
	    	{
	    		var k;
	    		students = [];
	    		index = 0;
	    		//alert("Just pushing students");
	    		for(k = 0; k < y.length; k++)
	    		{
	    			//alert("Just pushing students");
	    			var sid = y[k].getElementsByTagName("ID");
			    	sid = sid[0].firstChild.nodeValue;
			    	
			    	var name = y[k].getElementsByTagName("NAME");
			    	name = name[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var email = y[k].getElementsByTagName("EMAIL");
			    	email = email[0].firstChild.nodeValue;
			    	
			    	
			    	
			    	
			    	
			    	//alert("Just pushing students");
			    	
			    	
			    	
			    	var ladd = y[k].getElementsByTagName("LADD");
			    	ladd = ladd[0].firstChild.nodeValue;
			    	
			    	var mobile = y[k].getElementsByTagName("MOBILE");
			    	mobile = mobile[0].firstChild.nodeValue;
			    	
			    	//alert("ID, Name, Mobile, k : "+sid+" "+name+" "+mobile+" "+k);
			    	students.push(new student(sid, name, mobile, email,ladd));
	    		}
	    		
	    		//alert("Number of records : "+students.length);
	    		
	    		drawTable();
	    	
	    		return;
	    	}
	    	drawReset();
	    	
	    	x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
	    	console.log("Response XML is : "+xmlhttp.responseXML);
	    	console.log("Response Text is : "+xmlhttp.responseText)
	    	if(x[0]==null)
	    	{
	    		document.getElementById("message").innerHTML = "<div class='alert alert-danger'><span class='glyphicon glyphicon-remove'></span>&nbsp;No Student exists with entered ID !</div>";
	    		
	    		
	    		
	    		
	    		document.getElementById("inputName").value = "";
		    	document.getElementById("inputName").disabled = false;
		    	document.getElementById("inputEmail").value = "";
		    	document.getElementById("inputEmail").disabled = false;
		    	document.getElementById("inputParent").value = "";
		    	document.getElementById("inputParent").disabled = false;
		    	document.getElementById("PAddress").value = "";
		    	document.getElementById("PAddress").disabled = false;
		    	document.getElementById("inputFname").value = "";
		    	document.getElementById("inputFname").disabled = false;
		    	document.getElementById("selectDegree").value = "";
		    	document.getElementById("selectDegree").disabled = false;
		    	document.getElementById("selectCollege").value = "";
		    	document.getElementById("selectCollege").disabled = false;
		    	document.getElementById("selectSemester").value = "";
		    	document.getElementById("selectSemester").disabled = false;
		    	document.getElementById("LAddress").value = "";
		    	document.getElementById("LAddress").disabled = false;
		    	document.getElementById("inputStudent").value = "";
		    	document.getElementById("inputStudent").disabled = false;
		    	document.getElementById("dob").value = "";
		    	//document.getElementById("formUp").action = "account/helpdesk/AddCertificate.jsp";
		    	try
		    	{
		    		for(var j = 201; j < 210; j++)
		    		{
		    			document.getElementById("cer"+j).checked = false;
		    			document.getElementById("cer"+j).disabled = false;
		    		}
		    	
		    	}
		    	catch(err)
		    	{
		    	
		    	}
		    	document.getElementById("dob").disabled = false;
	    		
	    		return;
	    	}
	    	
	    	
	    	var name = x[0].getElementsByTagName("NAME");
	    	name = name[0].firstChild.nodeValue;
	    	
	    	var mobile = x[0].getElementsByTagName("MOBILE");
	    	mobile = mobile[0].firstChild.nodeValue;
	    	
	    	var ladd = x[0].getElementsByTagName("LADD");
	    	ladd = ladd[0].firstChild.nodeValue;
	    	
	    	var padd = x[0].getElementsByTagName("PADD");
	    	padd = padd[0].firstChild.nodeValue;
	    	
	    	var college = x[0].getElementsByTagName("COLLEGE");
	    	college = college[0].firstChild.nodeValue;
	    	
	    	var sem = x[0].getElementsByTagName("SEM");
	    	sem = sem[0].firstChild.nodeValue;
	    	
	    	var degree = x[0].getElementsByTagName("DEGREE");
	    	degree = degree[0].firstChild.nodeValue;
	    	
	    	var parent = x[0].getElementsByTagName("PARENT");
	    	parent = parent[0].firstChild.nodeValue;
	    	
	    	var cert = x[0].getElementsByTagName("CERT");
	    	cert = cert[0].firstChild.nodeValue;
	    	
	    	var gender = x[0].getElementsByTagName("GENDER");
	    	gender = gender[0].firstChild.nodeValue;
	    	
	    	var father = x[0].getElementsByTagName("FATHER");
	    	father = father[0].firstChild.nodeValue;
	    	
	    	var dob = x[0].getElementsByTagName("DOB");
	    	dob = dob[0].firstChild.nodeValue;
	    	
	    	var email = x[0].getElementsByTagName("EMAIL");
	    	email = email[0].firstChild.nodeValue;
	    	
	    	var certificates = cert.split(",");
	    	for(var c = 0; c < certificates.length; c++)
	    	{
	    		document.getElementById("cer"+certificates[c]).checked = true;
	    		document.getElementById("cer"+certificates[c]).disabled = true;
	    	}
	    	document.getElementById("inputName").value = capitalize(name);
	    	document.getElementById("inputName").disabled = true;
	    	document.getElementById("inputEmail").value = email;
	    	document.getElementById("inputEmail").disabled = true;
	    	document.getElementById("inputParent").value = parent;
	    	document.getElementById("inputParent").disabled = true;
	    	document.getElementById("PAddress").value = padd;
	    	document.getElementById("PAddress").disabled = true;
	    	document.getElementById("inputFname").value = father;
	    	document.getElementById("inputFname").disabled = true;
	    	document.getElementById("selectDegree").value = degree;
	    	document.getElementById("selectDegree").disabled = true;
	    	document.getElementById("selectCollege").value = college;
	    	document.getElementById("selectCollege").disabled = true;
	    	document.getElementById("selectSemester").value = sem;
	    	document.getElementById("selectSemester").disabled = true;
	    	document.getElementById("LAddress").value = ladd;
	    	document.getElementById("LAddress").disabled = true;
	    	document.getElementById("inputStudent").value = mobile;
	    	document.getElementById("inputStudent").disabled = true;
	    	document.getElementById("dob").value = dob;
	    	document.getElementById("formUp").action = "account/helpdesk/AddCertificate.jsp";
	    	document.getElementById("dob").disabled = true;
	    	document.getElementById("message").innerHTML = "<div class='alert alert-success col-sm-5'><span class='glyphicon glyphicon-ok '></span>&nbsp;Valid Student ID !</div>";
	    }
	   
	  }
	  
	  var path = "<%=basePath%>"+"account/helpdesk/searchQuery.jsp";
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
        
		if(queryID.length == 16)
		{
			//alert(queryID+keynum.toString());
			loadQuery("qid="+queryID+keynum.toString());
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
	
	function copyAddress()
	{
		if(document.getElementById("same").checked)
		{
			document.getElementById("LAddress").value = document.getElementById("PAddress").value;
		}
		else
		{
			document.getElementById("LAddress").value = "";
		}
	}
	
	
	
	function checkSelect(checkID)
	{
		if(document.getElementById(checkID).checked)
			return true;
		else
			return false;
	}
	
	
	
	
	function addUniv(id)
	{
		document.getElementById(id).setAttribute("name", "stuniv");
	}
	
	</script>
    
  </head>
  
  <body>
   	<%
   		if(request.getParameter("adddegree")!=null)
   		{
   			PreparedStatement ps = con.prepareStatement("insert into degree values(?,?)");
   			ps.setString(1,null);
   			ps.setString(2,request.getParameter("adddegree"));
   			int i = ps.executeUpdate();
   			
   		}
   		else if(request.getParameter("addclg")!=null)
   		{
   			PreparedStatement ps = con.prepareStatement("insert into college values(?,?)");
   			ps.setString(1,null);
   			ps.setString(2,request.getParameter("addclg"));
   			int i = ps.executeUpdate();
   		
   		}
   	 %>
   	<div class="modal fade" id="addCollege" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			        <h4 class="modal-title" id="myModalLabel">Add College</h4>
			      </div>
			      <form method="post" class="form-horizontal" >
			      <div class="modal-body">
			        	
			        	<div>
			        	
			        	</div>
			        	
			        	
			        	
							<div class="form-group"> 
					 		    <label for="inputEmail" class="col-sm-4 control-label">Enter College Name : </label> 
					 		    <div class="col-sm-7">  
					 		      <input type="text" name="addclg" class="form-control" id="inputEmail1" placeholder="Enter College Name ( E.g. SKIT )"  required="true"  ></input>
					 		    </div> 
					   		</div> 
			        	
			        	
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <input type="submit" value="Submit" name="reset" class="btn btn-primary" role="button" data-toggle="modal" data-target="#addCollege" ></input>
			      </div>
			      </form>
			    </div>
			  </div>
		</div>
		
		<div class="modal fade" id="addDegree" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			        <h4 class="modal-title" id="myModalLabel">Add Degree</h4>
			      </div>
			      <form method="post" class="form-horizontal" >
			      <div class="modal-body">
			        	
			        	
			        	
			        	
			        	
							<div class="form-group"> 
					 		    <label for="inputEmail" class="col-sm-3 control-label">Degree Name : </label> 
					 		    <div class="col-sm-7">  
					 		      <input type="text" name="adddegree" class="form-control" id="inputEmail1" placeholder="Enter Degree Name ( E.g. B.Tech )" required="true"  ></input>
					 		    </div> 
					   		</div> 
			        	
			        	
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <input type="submit" value="Submit" name="reset" class="btn btn-primary" role="button" data-toggle="modal" data-target="#addDegree" ></input>
			      </div>
			      </form>
			    </div>
			  </div>
		</div>
		
		
		
   	
   		
       	 <form method="post" name="form" action="student/UploadPic.jsp" class="form-horizontal" id="formUp" >
          <input type="hidden" name="stuid" value="">
         <fieldset>
          <legend><h1><strong>&nbsp;Student Registration : Step 1 Of 2</strong></h1></legend>
          </fieldset>
          <%
          if(dup.equals("duplicate"))
          {
          
           %>
          
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Duplicate Entry !</strong> A Student is already registered with the entered mobile number.
   		 </div>
   		 
   		 <%
   		  }
   		  else if(dup.equals("success"))
   		  {
   		  %>
   		  	<div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Registration Success !</strong> Student has been successfully registered with Student ID : <%=session.getAttribute("newstid") %>.
   		 </div>
   		  
   		  
   		  <%
   		  }
   		  else
   		  {
   		  
   		  }
   		   %>
          <input type="hidden" name="updateEnroll" id="updateEnroll">
		   <div class="form-group">
	           <label for="inputQuery" class="col-sm-2 control-label" align="left">Student ID :</label>
	           <div class="col-sm-4">
	           		<input type="text" name="studentQuery" class="form-control" onkeypress="fetchResult(this.id, event)" placeholder="Enter Student Id ( if already registered )" id="inputQuery"></input>
	            </div>
	            <div id="message" class="col-sm-3">
	           		
		           	
	           	</div>
	           	
            </div> 
         
           <fieldset>
           <legend><strong>&nbsp;Student Details</strong></legend>
           <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Name :</label>
           	<label style="color:red">*</label>
           <div class="col-sm-6">
           <input type="text" name="stname" class="form-control" placeholder="Enter Name" id="inputName" required="true" onblur="correct(this.id)"></input>
            </div>
            </div>
         
           <div class="form-group">
           <label for="inputFname" class="col-sm-2 control-label" align="left">Father's Name :</label>
           		<label style="color:red">*</label>
           <div class="col-sm-6">
           <input type="text" name="stfname" class="form-control" placeholder="Enter Father's Name" id="inputFname" required="true" onblur="correct(this.id)"></input>
            </div>
            </div>
           
           <div class="form-group">
		   <label for="inputEmail" class="col-sm-2 control-label" align="left">Email ID :</label> 
		   	<label style="color:red">*</label>
		   <div class="col-sm-7">  
		   <input type="email" name="stemail" class="form-control" id="inputEmail" placeholder="Enter Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true"  ></input>
		   </div>
			</div>	
			
		   <div class="form-group">
		   <label for="PAddress" class="col-sm-2 control-label" align="left">Permanent Address :</label> 
		   	<label style="color:red">*</label>
		   <div class="col-sm-7">  
		   <textarea class="form-control" name="stpadd" rows="3" id="PAddress" placeholder="Enter Permanent Address" required="true" onblur="correct(this.id)"></textarea>
		   </div>   	
		   </div>
		   	
		   <div class="form-group">	
		   <label for="inputParent" class="col-sm-2 control-label" align="left">Parents Contact No. :</label> 
		   <label style="color:red">*</label>
		   <div class="col-sm-2">  
		   <input type="text" class="form-control" Maxlength="10" name="stpmobile" id="inputParent" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No."/></input>
		   </div>
		  
		   
		   
		   
		   <label for="inputStudent" class="col-sm-3 control-label" align="left">Student Contact No. :</label> 
		   <div class="col-sm-2">  
		   
		   <input type="text" required="true" class="form-control" Maxlength="10" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" name="stmobile" id="inputStudent" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No."/></input>
		   </div>
		   </div>
		   
		   <div class="form-group">
		   <label for="LAddress" class="col-sm-2 control-label" align="left">Local Address :</label> 
		   		<label style="color:red">*</label>
		   <div class="col-sm-7">  
		   <textarea class="form-control" name="stladd" rows="3" id="LAddress" placeholder="Enter Local Address" required="true"></textarea>
		   </div>
		   </div>
		  
		   <div class="checkbox col-sm-offset-2">
		   	<input type="checkbox" id="same" onClick="copyAddress()">Same as Permanent Address
		   </div>
		  
		   <div class="form-group">
		   <label for="Gender" class="col-sm-2 control-label" align="left">Gender :</label> 
		   <div class="col-sm-2">  
		   <label class="col-1 control-label"><input type="radio" Name="stgender" value="Male" id="genderMale" checked="true">&nbsp;&nbsp;&nbsp;Male</input></label>
		   </div>
		   <div class="col-sm-2">
		   <label class="col-1 control-label"><input type="radio" Name="stgender" value="Female" id="genderFemale">&nbsp;&nbsp;&nbsp;Female</input></label>
		   </div>
		   </div>
		   
		   <div class="form-group">
		   <label for="dob" class="col-sm-2 control-label" align="left">Date Of Birth :
		   </label>
		   <div class="col-sm-2">
		   	<input type="date" class="form-control" required="true" name="dob" id="dob" >
		   </div>
		   </div>
           </fieldset>
           
           <fieldset>
           <legend><strong>&nbsp;Academic Background</strong></legend>
           <div class="form-group">
            <label for="selectDegree" class="col-sm-2 control-label" align="left">Degree :</label>
            <div class="col-sm-2">
           
                    
            <%
              try
              {
              
                   
			       String stmt = "Select * from degree";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                           
             %>
            <select name="stdegree" id="selectDegree" class="form-control">
           
             <% 
                 while(rs.next()) 
                 {
                   %>
                   <option value="<%=String.valueOf(rs.getInt(1))%>"><%= rs.getString(2) %></option> 
                   <% 
                 }
                 
                   }
                   catch(Exception e)
                   {
                     e.printStackTrace();
                   } %>
            </select>
            </div>
           
            <div class="col-sm-1">
            		<a role="button" data-toggle="modal" data-target="#addDegree">Add Degree</a>
            </div>
           
          
           
          
            <label for="selectSemester" class="col-sm-2 control-label" align="left">Semester :</label>
            <div class="col-sm-2">
            <%
              try
              {
              
                   
			       String stmt = "Select * from semester";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                           
             %>
            <select name="stsemester" id="selectSemester" class="form-control">
           
             <% 
                 while(rs.next()) 
                 {
                   %>
                   <option value="<%=String.valueOf(rs.getInt(1))%>"><%= rs.getString(2) %></option> 
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
            <label for="selectCollege" class="col-sm-2 control-label" align="left">College :</label>
            <div class="col-sm-2">
           
                    
            <%
              try
              {
              
                   
			       String stmt = "Select * from college";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                           
             %>
            <select name="stcollege" id="selectCollege" class="form-control">
           
             <% 
                 while(rs.next()) 
                 {
                   %>
                   <option value="<%=String.valueOf(rs.getInt(1))%>"><%= rs.getString(2) %></option> 
                   <% 
                 }
                 	
                   }
                   catch(Exception e)
                   {
                     e.printStackTrace();
                   } %>
            </select>
            </div>
           
           <div class="col-sm-1">
            		<a role="button" data-toggle="modal" data-target="#addCollege">Add College</a>
            </div>
          
           
          
            <label for="selectUniversity" class="col-sm-2 control-label" align="left">University :</label>
            <div class="col-sm-2">
            <input type="text" class="form-control" Placeholder="Example : RTU" id="inputUniversity" onclick="addUniv(this.id)"></input> 
            </div>
            </div>
           
           
           
         
        
      
        <fieldset>
           <legend><strong>&nbsp;Certificate Details</strong></legend>
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
		     <label for="course" class="col-sm-2 control-label" align="left">Select Certificate :</label> 
             <div class="col-sm-6"> 
             <div class="input-group">
             <%
              try
              {
              
                   
			       String stmt = "Select * from certificate";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		<label class="checkbox-inline col-sm-4">
             			<input type="checkbox" onclick="selectCourse(this.id)" name="certificate" id="cer<%=rs.getString(1)%>" value="<%=rs.getString(1)%>"> <%= rs.getString(2) %>
             		</label>
             		<%
             		}
             }
             catch(Exception e)
             {
              e.printStackTrace();
             } %>
             </div>
		     </div>
		     </div>
		     
		     
		     
		   
             </div>
		     </div>
		     </div>
		     
		     
		     
		     
		     <div class="form-group"> 
 		     <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" class="btn btn-primary btn-lg" value="Proceed >>>" /> 		     
 		     </div>
   		 
   		     
   		    
 		     <div class="col-sm-2"> 
 		     <input type="reset" class="btn btn-default btn-lg" value="Reset"/>     
 		     </div>
   		     </div> 
             </fieldset>
             <fieldset>
             <legend><strong>View Enrolled Students</strong></legend>
             <div class="form-group col-sm-3">
             	<select class="form-control" id="certid" onchange="loadResult(this.value)">
             	<option value="">--- Select ---</option>
             	<% 
             		String stmt = "Select * from certificate";
			       PreparedStatement ps = con.prepareStatement(stmt);
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
             <div class="col-sm-12">
       	<table class='table table-striped ' id="table">
       	
       	
       	</table>
       	<ul class="pager">
  			<li><a href="javascript:displayPrev()">&lt;- Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next -&gt;</a></li>
		</ul>
       </div>
             </fieldset>




</form>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- <script src="js/jquery.min.js"></script>
    
    <script src="js/docs.min.js"></script> -->
    <script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
function loadResult(value)
{
	if(value == "")
	{
		drawReset();
		return;
	}
		
		
	var data = "certid="+value;
	loadQuery(data);
	


}


</script>
    
  </body>
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
</html>
