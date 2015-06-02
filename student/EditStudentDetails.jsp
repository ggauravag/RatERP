<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,com.login.*" %>
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
     

            try
            {
            
                if(request.getParameter("studentName") != null )
                {
                    PreparedStatement ps = con.prepareStatement("update student set name=? where studentid=?");
                    ps.setString(1, request.getParameter("studentName"));         
                    ps.setString(2, request.getParameter("text1")+"/"+request.getParameter("text2")+"/STU/"+request.getParameter("text4"));
                    int j = ps.executeUpdate();
                    System.out.println("Student updated successfully");
                 
                } 
                
                if(request.getParameter("studentFName") != null)
                {
                    PreparedStatement ps = con.prepareStatement("update student set f_name=? where studentid=?");
                    ps.setString(1, request.getParameter("studentFName"));
                    ps.setString(2, request.getParameter("text1")+"/"+request.getParameter("text2")+"/STU/"+request.getParameter("text4"));
                    int j = ps.executeUpdate();
                    
                }
                
                if(request.getParameter("studentEmail") != null)
                {
                    PreparedStatement ps = con.prepareStatement("update student set email=? where studentid=?");
                    ps.setString(1, request.getParameter("studentEmail"));
                    ps.setString(2, request.getParameter("text1")+"/"+request.getParameter("text2")+"/STU/"+request.getParameter("text4"));
                    int j = ps.executeUpdate();
                    
                }
                
                if(request.getParameter("studentMobile") != null)
                {
                    PreparedStatement ps = con.prepareStatement("update student set mobile=? where studentid=?");
                    ps.setString(1, request.getParameter("studentMobile"));
                    ps.setString(2, request.getParameter("text1")+"/"+request.getParameter("text2")+"/STU/"+request.getParameter("text4"));
                    int j = ps.executeUpdate();
                    
                }
                
                if(request.getParameter("studentSem") != null)
                {
                    PreparedStatement ps = con.prepareStatement("update student set semid=? where studentid=?");
                    ps.setString(1, request.getParameter("studentSem"));
                    ps.setString(2, request.getParameter("text1")+"/"+request.getParameter("text2")+"/STU/"+request.getParameter("text4"));
                    int j = ps.executeUpdate();
                    
                }
                 
            }
            catch(Exception e)
            {
             e.printStackTrace();
            }
       %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="icon" href="css/images/ratico.ico">
    <title>Edit Student Deatils</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet"> 
    
    </head>
    <script >
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
	 // alert("ajax state change : "+xmlhttp.readyState+"status is : "+xmlhttp.status);
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    //document.getElementById("displayRecord").innerHTML=xmlhttp.responseText;
	    	//alert(xmlhttp.responseXML);
	    	 x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENTRECORD");
	    	
	    	if(x[0]==null)
	    	{
	    		
	    		document.getElementById("stName").value = "";
	    		document.getElementById("stFName").value = "";
	    		document.getElementById("stemailid").value = "";
	    		document.getElementById("stmobile").value ="";
	    		document.getElementById("stdob").value = "";
	    		document.getElementById("stfee").value ="";
	    		document.getElementById("stclg").value = "";
	    		document.getElementById("stsem").value ="";
	    		document.getElementById("stdegree").value ="";
	    		document.getElementById("stlang").value = "";
	    		document.getElementById("stdb").value ="";
	    		
	    		return;
	    	}
	    	
	    	
	    	var name = x[0].getElementsByTagName("NAME");
	    	name = name[0].firstChild.nodeValue;
	    	
	    	var fname = x[0].getElementsByTagName("FNAME");
	    	fname = fname[0].firstChild.nodeValue;
	    	
	    	var email = x[0].getElementsByTagName("EMAIL");
	    	email = email[0].firstChild.nodeValue;
	    	
	    	var mob = x[0].getElementsByTagName("MOBILE");
	    	mob = mob[0].firstChild.nodeValue;
	    	
	    	var dob = x[0].getElementsByTagName("DOB");
	    	dob = dob[0].firstChild.nodeValue;
	    	
	    	var fpaid = x[0].getElementsByTagName("FEEPAID");
	    	fpaid = fpaid[0].firstChild.nodeValue;
	    	
	    	var clg = x[0].getElementsByTagName("COLLEGE");
	    	clg = clg[0].firstChild.nodeValue;
	    	
	    	var sem = x[0].getElementsByTagName("SEMESTER");
	    	sem = sem[0].firstChild.nodeValue;
	    	
	    	var degree = x[0].getElementsByTagName("DEGREE");
	    	degree = degree[0].firstChild.nodeValue;
	    	
	    	var lang = x[0].getElementsByTagName("LANGUAGE");
	    	if(lang[0] == null || lang[0].firstChild == null)
			    lang = "";
			else
			    lang = lang[0].firstChild.nodeValue;
	    	
	    	var db = x[0].getElementsByTagName("DATABASE");
	    	if(db[0] == null || db[0].firstChild == null)
			    db = "";
			else
			   db = db[0].firstChild.nodeValue;
	    	
	    	var pid = x[0].getElementsByTagName("PID");
	    	pid = pid[0].firstChild.nodeValue;
	    	
	    	var pfee = x[0].getElementsByTagName("PFEE");
	    	pfee = pfee[0].firstChild.nodeValue;
	    	
	    	var nopid = x[0].getElementsByTagName("NOPID");
	    	nopid = nopid[0].firstChild.nodeValue;
	    	
	    	
	    	document.getElementById("stName").value = name;
	    	document.getElementById("stFName").value = fname;
	    	document.getElementById("stemailid").value = email;
	    	document.getElementById("stmobile").value = mob;
	    	document.getElementById("stdob").value = dob;
	    	document.getElementById("stfee").value = fpaid;
	    	document.getElementById("stclg").value = clg;
	    	document.getElementById("stsem").value = sem;
	    	document.getElementById("stdegree").value = degree;
	    	document.getElementById("stlang").value = lang;
	    	//alert("The lang before replacement is : "+lang);
	    	var find = " ";
			var re = new RegExp(find, "g");

			lang = lang.replace(re, "");
	    	//alert("The lang after replacement is : "+lang);
	    	var i = 0;
	    	var langs = lang.split(",");
	    	/* var str = "";
	    	for(i = 0; i < langs.length; i++)
	    	{
	    		str = str + "-" + langs[i];
	    	} */
	    	
	    	var pids = nopid.split(",");
	    	
	    	for(var k = 0; k < pids.length; k++)
	    	{
	    		document.getElementById("p"+pids[k]).disabled = true;
	    		
	    		//alert("Package disabled : "+pids[k]);
	    	}
	    	
	    	document.forms["up"].packageid.value = pid;
	    	
	    	//alert("the string is : "+str);
	    	for(i = 0; i < langs.length; i++)
	    	{
	    		document.getElementById(langs[i]).checked = true;
	    		document.getElementById(langs[i]).disabled = true;
	    		document.getElementById("l"+langs[i]).checked = true;
	    		document.getElementById("l"+langs[i]).disabled = true;
	    		//alert("Check boc with id:"+langs[i]);
	    		
	    	}
	    	
	    	db = db.replace(re,"");
	    	var dbs = db.split(",");
	    	//alert("databases is : "+dbs);
	    	//console.log(dbs);
	    	for(i = 0; i < dbs.length; i++)
	    	{
	    		document.getElementById("db"+dbs[i]).checked = true;
	    		document.getElementById("db"+dbs[i]).disabled = true;
	    		document.getElementById("dbu"+dbs[i]).checked = true;
	    		document.getElementById("dbu"+dbs[i]).disabled = true;
	    		
	    	}
	    	
	    	document.getElementById("stdb").value = db;
	    }
	   
	  }
	  
	var path = "<%=basePath%>"+"student/searchStudentID.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(data);
	}
        function fetchresult(value, e)
        {
            var a = document.getElementById("val1").value;
    		var b = document.getElementById("val2").value;
    		var c = document.getElementById("val3").value;
    		var d = document.getElementById("val4").value;
    		
    		var stid = a + "/" + b + "/" + c + "/" + d;
    		//alert("Search criteria is id with value : "+id);
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
            if(d.length == 4)
		    {
    	   // var data = "stid="+stid;
    		loadQuery("stid="+stid+keynum.toString());
    		document.getElementById('studentid').value = stid+keynum.toString();
    		document.getElementById('studentid2').value = stid+keynum.toString();
            }
           
      }
        
        function getfocus()
        {
          document.getElementById('val4').focus();
        }
        
        function editEnable(id1, id2)
     	{
		  if(document.getElementById(id1).checked == true)
		  {
			document.getElementById(id2).disabled = false;
		  }
		  else
		  {
			document.getElementById(id2).disabled = true;
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
    </script>
  
  
  <body>
    <form method="post" class="form-horizontal" name="optionForm">
    <div class="form-group">
      <label class="col-sm-2 control-label" Id="lbl">Enter Student ID :</label>
      <div class="col-sm-1"><input type="text" name="text1" Id="val1" class="form-control" required="true"></input></div>
      <div class="col-sm-2"><select onchange="getfocus();" name="text2" Id="val2" class="form-control"><option value="TR">Tonk Road</option><option value="PN">Pratap Nagar</option><option value="KK">Kukas</option><option value="OT">Other</option></select></div>
      <div class="col-sm-1"><input type="text" name="text3" Id="val3" class="form-control" value="STU" readonly="true"></input></div>
      <div class="col-sm-2"><input type="text" name="text4" Id="val4" class="form-control" onkeypress="fetchresult(this.id, event)" Maxlength="5" required="true"></input></div>
    </div>
    
    <div class="form-group">
    <label class="col-sm-2 control-label" align="left">Name :</label>
    <div class="col-sm-6">
    <input type="text" name="studentName" class="form-control" id="stName" disabled></input>
    </div>
    <div class="col-sm-1">
    <input type="checkbox" id="editname" value="stName" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
    </div>
    </div>
    
    <div class="form-group">
    <label class="col-sm-2 control-label" align="left">Father's Name :</label>
    <div class="col-sm-6">
    <input type="text" name="studentFName" class="form-control" id="stFName" disabled></input>
    </div>
    <div class="col-sm-1">
    <input type="checkbox" id="editfname" value="stFName" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
    </div>
    </div>
    <div class="form-group">
    <label class="col-sm-2 control-label" align="left">Email ID :</label>
    <div class="col-sm-6">
    <input type="text" name="studentEmail" class="form-control" id="stemailid" disabled></input>
    </div>
    <div class="col-sm-1">
    <input type="checkbox" id="editemaild" value="stemailid" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
    </div>
    </div>
    
    <div class="form-group">
    <label class="col-sm-2 control-label" align="left">Mobile No. :</label>
    <div class="col-sm-6">
    <input type="text" name="studentMobile" class="form-control" id="stmobile" disabled></input>
    </div>
    <div class="col-sm-1">
    <input type="checkbox" id="editmob" value="stmobile" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
    </div>
    </div>
    
    <div class="form-group">
    <label class="col-sm-2 control-label" align="left">D.O.B :</label>
    <div class="col-sm-6">
    <input type="text" name="studentDOB" class="form-control" id="stdob" disabled></input>
    </div>
    </div>
    
    <div class="form-group">
    <label class="col-sm-2 control-label" align="left">Deposited Fee :</label>
    <div class="col-sm-6">
    <input type="text" name="studentFee" class="form-control" id="stfee" disabled></input>
    </div>
    </div>
    
    <div class="form-group">
    <label class="col-sm-2 control-label" align="left">College :</label>
    
    <div class="col-sm-2">
           
                    
            <%
               
              try
              {
                   
                   
			       PreparedStatement ps = con.prepareStatement("Select * from college");
			       ResultSet rs = ps.executeQuery();
                           
             %>
            <select name="studentCollege" id="stclg" class="form-control" disabled>
           
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
    
    
    <label class="col-sm-1 control-label" align="left">Sem :</label>
    <div class="col-sm-1">
    
    <%
              try
              {
              
			       PreparedStatement ps = con.prepareStatement("Select * from semester");
			       ResultSet rs = ps.executeQuery();
                           
             %>
          <select name="studentSem" id="stsem" class="form-control">
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
    
    <label class="col-sm-1 control-label" align="left">Degree :</label>
    <div class="col-sm-2">
            
            <%
              try
              {
              
			       
			       PreparedStatement ps = con.prepareStatement("Select * from degree");
			       ResultSet rs = ps.executeQuery();
                           
             %>
            <select name="studentDegree" id="stdegree" class="form-control" disabled>
           
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
    <label class="col-sm-2 control-label" align="left">Languages :</label>
    <div class="col-sm-7">
    <input type="text" name="studentLang" class="form-control" id="stlang" disabled></input>
    </div>
    </div>
    
    <div class="form-group">
    <label class="col-sm-2 control-label" align="left">Databases :</label>
    <div class="col-sm-7">
    <input type="text" name="studentDB" class="form-control" id="stdb" disabled></input>
    </div>
    </div>
    
    
    <div class="form-group">
    <div class="col-sm-offset-4">
    <input type="submit" class="btn btn-primary" value="Update >>>" name="upd" /></input>
    </div>
    </div>
      
      </form>
      
      
      
      
      
      
      <form method="post" class="form-horizontal" action="<%=path%>/student/UpdateCourseReceipt.jsp">
    <fieldset>
    <legend><strong>&nbsp;Add/Update Course Details</strong></legend>
           
           
 <div class="panel-group" id="accordion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Add New Course
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
    <div class="panel-body">
        	
        	<div class="form-group">
		   	<label class="col-sm-2 control-label" align="left">Select Lanaguages: </label> 		   	   
		     <div class="col-sm-6"> 
             <div class="input-group">
             <%
                //session.setAttribute("Studentid", request.getParameter("text1")+"/"+request.getParameter("text2")+"/STU/"+request.getParameter("text4"));
              try
              {
              
			       PreparedStatement ps = con.prepareStatement("Select * from course");
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		<label class="checkbox-inline col-sm-4">
             			<input type="checkbox" name="language" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>"> <%= rs.getString(2) %>
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
		   		<label class="col-sm-2 control-label">Select Databases : </label> 
		   	   <div class="col-sm-10"> 
               <div class="input-group">
             <%
              try
              {
              
			       PreparedStatement ps = con.prepareStatement("Select * from dbcourse");
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		<label class="checkbox-inline col-sm-5">
             			<input type="checkbox" name="database" id="db<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" > <%= rs.getString(2) %>
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
	  
	               <div class="col-sm-offset-3">
				   <input type="submit" name="add" class="btn-lg btn-success" value="Confirm Details" >
				   </div>
	  <input type="hidden" name="stid" id="studentid">
        </div>
     </div>
    </div>
   </form>
   <form method="post" name="up" class="form-horizontal" action="<%=path%>/student/UpdateCourseReceipt.jsp">
  
  
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
          Upgrade Package
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">
        
               <div class="form-group">
		   	   <label class="col-sm-3 control-label">Select Packages : </label> 
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
		            <input type="radio" onClick="selectPackage(this.value);" id="p<%=rs.getInt("pid") %>" name="packageid" value="<%=String.valueOf(rs.getInt("pid"))%>"><strong> <%=rs.getString(3) %></strong>
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
		   	<label class="col-sm-3 control-label">Select Lanaguages: </label> 		   	   
		     <div class="col-sm-6"> 
             <div class="input-group">
             <%
              try
              {
              
			       PreparedStatement ps = con.prepareStatement("Select * from course");
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
              	     {        
             		%>
             		<label class="checkbox-inline col-sm-4">
             			<input type="checkbox" onclick="selectCourse(this.id)" name="language" id="l<%=rs.getString(1)%>" value="<%=rs.getString(1)%>"> <%= rs.getString(2) %>
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
		   		<label class="col-sm-3 control-label">Select Databases : </label> 
		   	   <div class="col-sm-9"> 
               <div class="input-group">
             <%
              try
              {
              
			       PreparedStatement ps = con.prepareStatement("Select * from dbcourse");
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		<label class="checkbox-inline col-sm-5">
             			<input type="checkbox" onclick="selectDBCourse(this.id)" name="database" id="dbu<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" > <%= rs.getString(2) %>
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
	  
	               <div class="col-sm-offset-3">
				   <input type="submit" name="upgrade" class="btn-lg btn-success" value="Confirm Details" >
				   </div>
	  
        
  </div>
  </div>
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
  </fieldset>
    
    <input type="hidden" name="stid" id="studentid2">
    </form>
  </body>
</html>
