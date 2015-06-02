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
	    	//alert(xmlhttp.responseXML);
	    	x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
	    	
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
	    }
	   
	  }
	  
	  var path = "<%=basePath%>"+"student/searchQuery.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	var data = "qid="+ queryID;
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
			loadQuery(queryID+keynum.toString());
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
	
	var course = 0;
	var dbcourse = 0;
	
	function reset()
	{
		course = 0;
		dbcourse = 0;
	}
	
	function checkSelect(checkID)
	{
		if(document.getElementById(checkID).checked)
			return true;
		else
			return false;
	}
	
	function selectCourse(checkID)
	{
		
		if((document.form.packageid.value == "1" || document.form.packageid.value == "2") && course < 2)
		{
			if(checkSelect(checkID))
			{
				course++;
			}
			else
			{
				course--;
			}
		}
		else if((document.form.packageid.value == "1" || document.form.packageid.value == "2") && course == 2)
		{
			if(!checkSelect(checkID))
				course--;
			else
			{
				document.getElementById(checkID).checked = false;
			}
		}
		
		else if(document.form.packageid.value == "3" && course < 3)
		{
			if(checkSelect(checkID))
			{
				course++;
			}
			else
			{
				course--;
			}
		}
		
		else if(document.form.packageid.value == "3" && course == 3)
		{
			if(!checkSelect(checkID))
				course--;
			else
			{
				document.getElementById(checkID).checked = false;
			}
		}
		
		else if(document.form.packageid.value == "4" && course < 4)
		{
			if(checkSelect(checkID))
			{
				course++;
			}
			else
			{
				course--;
			}
		}
		
		else if(document.form.packageid.value == "4" && course == 4)
		{
			if(!checkSelect(checkID))
				course--;
			else
			{
				document.getElementById(checkID).checked = false;
			}
		}
		
		else
		{
		
		}
	}
	
	function selectDBCourse(checkID)
	{
		if((document.form.packageid.value == "1" || document.form.packageid.value == "2" || document.form.packageid.value == "3") && dbcourse < 2)
		{
			if(checkSelect(checkID))
			{
				dbcourse++;
			}
			else
			{
				dbcourse--;
			}
		}
		else if((document.form.packageid.value == "1" || document.form.packageid.value == "2" || document.form.packageid.value == "3") && dbcourse == 2)
		{
			if(!checkSelect(checkID))
				dbcourse--;
			else
			{
				document.getElementById(checkID).checked = false;
			}
		}
		
		
		else
		{
		
		}
	}
	
	
	function selectPackage(value)
	{
		
		if(value == "2" || value == "3" || value == "4")
		{
			var android = document.getElementById("5");
			android.checked = true;
			//android.disabled = true;
			
		}
		else
		{
			var android = document.getElementById("5");
			android.checked = false;
			//android.disabled = false;
		}
		reset();
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
		
		
		
   	
   		
       	 <form method="post" name="form" action="student/UploadPic.jsp" class="form-horizontal" >
          
         <fieldset>
          <legend><h1><strong>&nbsp;Student Registration : Step 1 Of 4</strong></h1></legend>
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
   		 session.removeAttribute("err");
   		  }
   		  else if(dup.equals("success"))
   		  {
   		  %>
   		  	<div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Registration Success !</strong> Student has been successfully registered with Student ID : <%=session.getAttribute("newstid") %>.
   		 	</div>
   		  <%
   		  session.removeAttribute("err");
   		  }
   		  else
   		  {
   		  
   		  }
   		   %>
          
		   <div class="form-group">
	           <label for="inputQuery" class="col-sm-2 control-label" align="left">Query ID :</label>
	           <div class="col-sm-4">
	           		<input type="text" class="form-control" onkeypress="fetchResult(this.id, event)" placeholder="Enter Query Id ( if inquired before )" id="inputQuery"></input>
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
		   	<input type="date" class="form-control" required="true" name="dob" >
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
           <legend><strong>&nbsp;Course Details</strong></legend>
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
		   <label for="package" class="col-sm-2 control-label" align="left">Package Enroll For :</label> 
		   <div class="col-sm-7"> 
           <div class="input-group">
           
            <%
              try
              {
              
                   
			       String stmt = "Select * from package";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
		             %>
		             <label class="radio-inline col-sm-5">
		            <input type="radio" onClick="selectPackage(this.value);" name="packageid" value="<%=String.valueOf(rs.getInt("pid"))%>" checked><strong> <%=rs.getString(3) %></strong>
             		</label>
             		<% 
             		}
             }
             catch(Exception e)
             {
              e.printStackTrace();
             } 
             
             %>
             
             </div>    
             </div>
             </div>
             
             <div class="form-group">
		     <label for="course" class="col-sm-2 control-label" align="left">Select Language Courses :</label> 
             <div class="col-sm-6"> 
             <div class="input-group">
             <%
              try
              {
              
                   
			       String stmt = "Select * from course";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		<label class="checkbox-inline col-sm-4">
             			<input type="checkbox" onclick="selectCourse(this.id)" name="lang" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>"> <%= rs.getString(2) %>
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
		     
		     
		     
		      <div class="form-group">
		     <label for="course" class="col-sm-2 control-label" align="left">Select Database Courses :</label> 
             <div class="col-sm-10"> 
             <div class="input-group">
             <%
              try
              {
              
                   
			       String stmt = "Select * from dbcourse";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		<label class="checkbox-inline col-sm-5">
             			<input type="checkbox" onclick="selectDBCourse(this.id)" name="db" id="db<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" > <%= rs.getString(2) %>
             		</label>
             		<%
             		}
             		
             }
             catch(Exception e)
             {
              e.printStackTrace();
             } 
             
             
             
             
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




</form>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- <script src="js/jquery.min.js"></script>
    
    <script src="js/docs.min.js"></script> -->
    <script src="js/jquery-1.7.1.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
    
  </body>
</html>
