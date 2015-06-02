<%@page import="com.login.DBInfo"%>
<%@ page language="java" import="java.util.*, java.text.*,com.login.*, java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println("Page loaded");
/*

	try
	{

		String name = request.getParameter("stname");
		String fname = request.getParameter("stfname");
		String email = request.getParameter("stemail");
		String per_address = request.getParameter("stpadd");
		String parent_mobile = request.getParameter("stpmobile");
		String mobile = request.getParameter("stmobile");
		String local_address = request.getParameter("stladd");
		String gender = request.getParameter("stgender");
		String dob = request.getParameter("dob");
		String deg_id = request.getParameter("stdegree");
		String sem_id = request.getParameter("stsemester");
		String clg_id = request.getParameter("stcollege");
		String univ = request.getParameter("stuniv");
		String p_id = request.getParameter("packageid");
		String language_id[] = request.getParameterValues("lang");
		String db_id[] = request.getParameterValues("db");
		String center = request.getParameter("center");
		
		 Student stu = new Student(name, mobile, fname, email, parent_mobile, local_address, per_address, dob, sem_id, deg_id, clg_id, gender, univ, p_id, center, language_id, db_id);
			
			
			int i = stu.insertUser();	
			if(i==0)
			{
				response.sendRedirect("registrationstudent.jsp");
			}
		
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
*/
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    
    
	
		
	

  <link rel="stylesheet" href="css/bootstrap.css" type="text/css"></link>
  </head>
  
  <body>
    <div class="jumbotron" style="background-color:white;width:1200px;margin-left:auto;margin-right:auto;">
   		<fieldset>
          <legend><h2><strong>&nbsp;Student Photograph</strong></h2></legend>
          </fieldset>
        <br />
        <br />
		<form name="form" class="form-horizontal">
       	<img class="img-thumbnail " src="student/profile/noimage.jpg" style="margin-left:425px;"></img>
        <hr />
       

        <div class="form-group row">
            <div class="col-sm-3">        
                <input type="file" class="form-control btn-default" onchange="check_extension(this.value, event)"   />
               
			</div>

            <div class="col-md-2"><input type="submit" class="btn btn-primary" value="Upload Pic" ></input></div>
        
        	
        <div class="col-md-2" >
        	<h3><span class="label label-info" >&nbsp;&nbsp;OR&nbsp;&nbsp;</span></h3>
        </div>
        <div class="col-md-4" >
		        <button type="button" class="btn btn-default btn-lg">
		  			<span class="glyphicon glyphicon-camera"></span>&nbsp;&nbsp; <a href="#" onclick="window.open('htdocs/CaptureImage.jsp','_blank')">Take Snapshot</a>
				</button> 
		</div>
    
     </div>
     <div class="form-group"></div>
     <div class="form-group"></div>
     <div class="form-group"></div>
     	<div class="form-group">
     	<div style="margin-left:460px;">
     		<input type="submit" name="submit" id="submit" value="Proceed >>>" class="btn-lg btn-primary" disabled="disabled">
     </div>
        </div>
      </div>
      </form>
    </div>
    <script type="text/javascript">
        var hash = {
            '.jpg': 1,
            '.JPG':1,
            '.jpeg': 1,
            '.png': 1,
            '.bmp': 1,
            '.tif':1,
            '.gif': 1,
            '.JPEG': 1,
            '.PNG': 1,
            '.BMP':1
        };

        function check_extension(filename, e) {
            var re = /\..+$/;
            var ext = filename.match(re);
            //var submitEl = document.getElementById('Button1');
            //alert("file type is : " + hash[ext]);
            if (hash[ext] == 1) {
               // document.getElementById('Button3').disabled = false;
                //submitEl.disabled = false;
                document.getElementById("submit").disabled = false;
                return true;
            } else {
              //  document.getElementById('Button3').disabled = true;
                //submitEl.disabled = true;
				form.reset();
                return false;
            }
        }
    </script>
  </body>
</html>
