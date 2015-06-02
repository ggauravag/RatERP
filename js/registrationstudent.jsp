<%@page import="java.io.EOFException"%>
<%@page import="java.io.ObjectInputStream"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.login.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

// HttpSession session1 =  request.getSession(false);

// if(session1==null)
// {
// 	response.sendRedirect("Unauthorize.jsp");
// }

// String type=(String)session1.getAttribute("type");
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

  
    <link href="css/dashboard.css" rel="stylesheet">

   
    <script src="js/ie-emulation-modes-warning.js"></script>

   
    <script src="js/ie10-viewport-bug-workaround.js"></script>
	<script>
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
	
	
	
	</script>
    
  </head>
  
  <body>
   	
   		
       	  <form method="post" name="form" class="form-horizontal" >
          
         <fieldset>
          <legend><h1><strong>&nbsp;Student Registration</strong></h1></legend>
          </fieldset>
		   <div class="form-group">
	           <label for="inputQuery" class="col-sm-2 control-label" align="left">Query ID :</label>
	           <div class="col-sm-6">
	           		<input type="text" class="form-control" placeholder="Enter Query Id ( if inquired before )" id="inputQuery"></input>
	            </div>
            </div> 
         
           <fieldset>
           <legend><strong>&nbsp;Student Details</strong></legend>
           <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Name :</label>
           	<label style="color:red">*</label>
           <div class="col-sm-6">
           <input type="text" class="form-control" placeholder="Enter Name" id="inputName" required="true" onblur="correct(this.id)"></input>
            </div>
            </div>
         
           <div class="form-group">
           <label for="inputFname" class="col-sm-2 control-label" align="left">Father's Name :</label>
           		<label style="color:red">*</label>
           <div class="col-sm-6">
           <input type="text" class="form-control" placeholder="Enter Father's Name" id="inputFname" required="true" onblur="correct(this.id)"></input>
            </div>
            </div>
           
           <div class="form-group">
		   <label for="inputEmail" class="col-sm-2 control-label" align="left">Email ID :</label> 
		   	<label style="color:red">*</label>
		   <div class="col-sm-7">  
		   <input type="email" name="email" class="form-control" id="inputEmail" placeholder="Enter Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true"  ></input>
		   </div>
			</div>	
			
		   <div class="form-group">
		   <label for="PAddress" class="col-sm-2 control-label" align="left">Permanent Address :</label> 
		   	<label style="color:red">*</label>
		   <div class="col-sm-7">  
		   <textarea class="form-control" rows="3" id="PAddress" placeholder="Enter Permanent Address" required="true" onblur="correct(this.id)"></textarea>
		   </div>   	
		   </div>
		   	
		   <div class="form-group">	
		   <label for="inputParent" class="col-sm-2 control-label" align="left">Parents Contact No. :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" required="true" class="form-control" Maxlength="10" name="mobile" id="inputParent" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No."/></input>
		   </div>
		  
		   
		   <div class="col-sm-1"></div>
		   
		   <label for="inputStudent" class="col-sm-2 control-label" align="left">Student Contact No. :</label> 
		   		<label style="color:red">*</label>
		   <div class="col-sm-2">  
		   <input type="text" required="true" class="form-control" Maxlength="10" name="mobile" id="inputStudent" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No."/></input>
		   </div>
		   </div>
		   
		   <div class="form-group">
		   <label for="LAddress" class="col-sm-2 control-label" align="left">Local Address :</label> 
		   		<label style="color:red">*</label>
		   <div class="col-sm-7">  
		   <textarea class="form-control" rows="3" id="LAddress" placeholder="Enter Local Address" required="true"></textarea>
		   </div>
		   </div>
		  
		   <div class="checkbox col-sm-offset-2">
		   	<input type="checkbox" id="same" name="same" onClick="copyAddress()">Same as Permanent Address
		   </div>
		  
		   <div class="form-group">
		   <label for="Gender" class="col-sm-2 control-label" align="left">Gender :</label> 
		   <div class="col-sm-2">  
		   <label class="col-1 control-label"><input type="radio" Name="Gender" value="Male" id="genderMale" checked="true">&nbsp;&nbsp;&nbsp;Male</input></label>
		   </div>
		   <div class="col-sm-2">
		   <label class="col-1 control-label"><input type="radio" Name="Gender" value="Male" id="genderFemale">&nbsp;&nbsp;&nbsp;Female</input></label>
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
              
                   Connection con = DBInfo.getConn();
			       String stmt = "Select * from degree";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                           
             %>
            <select name="degree" id="selectDegree" class="form-control">
           
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
           
           
          
           
          
            <label for="selectSemester" class="col-sm-2 control-label" align="left">Semester :</label>
            <div class="col-sm-2">
            <%
              try
              {
              
                   Connection con = DBInfo.getConn();
			       String stmt = "Select * from semester";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                           
             %>
            <select name="semester" id="selectSemester" class="form-control">
           
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
              
                   Connection con = DBInfo.getConn();
			       String stmt = "Select * from college";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                           
             %>
            <select name="college" id="selectCollege" class="form-control">
           
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
           
           
          
           
          
            <label for="selectUniversity" class="col-sm-2 control-label" align="left">University :</label>
            <div class="col-sm-2">
            <input type="text" class="form-control" Placeholder="Example : RTU" id="inputUniversity" ></input> 
            </div>
            </div>
           
           
           
         
        
      
        <fieldset>
           <legend><strong>&nbsp;Course Details</strong></legend>
           <div class="form-group">
		   <label for="package" class="col-sm-2 control-label" align="left">Package Enroll For :</label> 
		   <div class="col-sm-7"> 
           <div class="input-group">
           
            <%
              try
              {
              
                   Connection con = DBInfo.getConn();
			       String stmt = "Select * from package";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
		             %>
		             <label class="radio-inline col-sm-4">
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
              
                   Connection con = DBInfo.getConn();
			       String stmt = "Select * from course";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		<label class="checkbox-inline col-sm-4">
             			<input type="checkbox" onclick="selectCourse(this.id)" name="<%=rs.getString(1)%>" id="<%=rs.getString(1)%>" value="y"> <%= rs.getString(2) %>
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
              
                   Connection con = DBInfo.getConn();
			       String stmt = "Select * from dbcourse";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                   
                   while(rs.next())
                   {        
             		%>
             		<label class="checkbox-inline col-sm-5">
             			<input type="checkbox" onclick="selectDBCourse(this.id)" name="<%=rs.getString(1)%>" id="db<%=rs.getString(1)%>" value="y"> <%= rs.getString(2) %>
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
 		     <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" class="btn btn-primary btn-lg" value="Proceed >>>" name="click" /> 		     
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
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/docs.min.js"></script>
    <script type="text/javascript">
    
    
    
    function selectPackage(value)
	{
		
		if(value == "2" || value == "3" || value == "4")
		{
			var android = document.getElementById("5");
			android.checked = true;
			android.disabled = true;
			
		}
		else
		{
			var android = document.getElementById("5");
			android.checked = false;
			android.disabled = false;
		}
		
	}
    </script>
  </body>
</html>
