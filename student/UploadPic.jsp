<%@page import="com.login.DBInfo"%>
<%@ page language="java" import="java.io.*,java.util.*, java.text.*,com.login.*, java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println("Internal upload pic");

Student stu = null;



Connection con = null;
String contentType = request.getContentType();
String photo = "profile/noimage.jpg";
	 try
	 {
		con = DBInfo.getConn();
		String name = request.getParameter("stname");
		
		if(request.getParameter("type")!=null && request.getParameter("type").equals("enroll"))
		{
			
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
			String center = request.getParameter("center");
			String cert[] = request.getParameterValues("certificate");
			System.out.println(cert);
			
			stu = new Student(name, mobile, fname, email, parent_mobile, local_address, per_address, dob, sem_id, deg_id, clg_id, gender, univ, center, cert);
			
			int	i = stu.insertCertificate();	
				if(i==0)
				{
					session.setAttribute("err", "duplicate");
					response.sendRedirect("registrationstudent.jsp");
					System.out.println("unable to enter record in student");
				}
				photo = stu.getPhoto();
				System.out.println("Photo get : "+photo);
				session.setAttribute("newid", stu.getSid());
		
		}
		
		
	
	
	
	
	else if((contentType != null) && contentType.indexOf("multipart/form-data") >= 0)
	{
			System.out.println("From upload pic");
		
		
			DataInputStream in = new DataInputStream(request.getInputStream());
			int formDataLength = request.getContentLength();
			System.out.println(formDataLength);
			byte dataBytes[] = new byte[formDataLength];
			int byteRead = 0;
			int totalBytesRead = 0;
			
			while (totalBytesRead < formDataLength)
			{
				byteRead = in.read(dataBytes, totalBytesRead,formDataLength);
				totalBytesRead += byteRead;
			}
			
			String file = new String(dataBytes);
			
			String saveFile = file.substring(file.indexOf("filename=\"") + 10);
			saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
			saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
			
			System.out.println("The previous save file is "+saveFile.substring(saveFile.indexOf('.')));
		
			
			int lastIndex = contentType.lastIndexOf("=");
			String boundary = contentType.substring(lastIndex + 1,contentType.length());
			int pos;
			pos = file.indexOf("filename=\"");
			pos = file.indexOf("\n", pos) + 1;
			pos = file.indexOf("\n", pos) + 1;
			pos = file.indexOf("\n", pos) + 1;
			int boundaryLocation = file.indexOf(boundary, pos) - 4;
			int startPos = ((file.substring(0, pos)).getBytes()).length;
			int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
			
			
			
			
			
			
			
			
			String path1 = request.getServletContext().getRealPath("/student/profile/");
			path1 = path1 + "/Student"+((String)session.getAttribute("newid")).substring(12)+saveFile.substring(saveFile.indexOf('.')).toLowerCase();
			OutputStream outputStream = null;
        
	        try 
	        {
	           outputStream = new FileOutputStream(new File(path1));
	            outputStream.write(dataBytes, startPos, (endPos - startPos));
				outputStream.flush();
				outputStream.close();
	           PreparedStatement ps = con.prepareStatement("update student set photo=? where studentid=?");
	           outputStream.flush();
	           outputStream.close();
	           ps.setString(1, "profile/"+"Student"+((String)session.getAttribute("newid")).substring(12)+saveFile.substring(saveFile.indexOf('.')).toLowerCase());
	           ps.setString(2, (String)session.getAttribute("newid"));
	           int i = ps.executeUpdate();
	           if(i==1)
	           {
	           		System.out.println("Student Image saved");
	           		photo = "profile/"+"Student"+((String)session.getAttribute("newid")).substring(12)+saveFile.substring(saveFile.indexOf('.')).toLowerCase();
	           }
	           else
	           {
	          		System.out.println("Error while saving image");
	           }
	           
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("../Error.jsp");
	            SendMail.sendReport(e, basePath);
	        }
				
	
		
	
	}
	
	
	else if(session.getAttribute("newid")!=null)
	{
	System.out.println("From webcam");
	System.out.println("the content type is "+request.getContentType());
	System.out.println("Is this from uploaded pic button ? "+request.getParameter("uploadpic"));
	try {
			PreparedStatement ps = con.prepareStatement("select photo from student where studentid=?");
			ps.setString(1, (String)session.getAttribute("newid"));
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				photo = rs.getString("photo");
			}
			
 		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	 else if(name!=null)
		{
			System.out.println("from new user");
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
			if(db_id == null)
			{
				db_id = new String[]{};
			}
			if(language_id == null)
			{
				language_id = new String[]{};
			}
			String center = request.getParameter("center");
			
			 stu = new Student(name, mobile, fname, email, parent_mobile, local_address, per_address, dob, sem_id, deg_id, clg_id, gender, univ, p_id, center, language_id, db_id);
				
				
				
				
				String pass = stu.insertUser();
				session.setAttribute("pwd", pass);
				int i = stu.insertStudent();	
				if(i==0)
				{
					session.setAttribute("err", "duplicate");
					response.sendRedirect("registrationstudent.jsp");
					System.out.println("unable to enter record in student");
				}
				photo = stu.getPhoto();
				System.out.println("Photo get : "+photo);
				session.setAttribute("newid", stu.getSid());
		}
	

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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    
    
	
		
	

 

  <link rel="stylesheet" href="../css/bootstrap.css" type="text/css"></link></head>
  
  <body>
    <div class="jumbotron" style="background-color:white;width:1200px;margin-left:auto;margin-right:auto;">
   		<fieldset>
          <legend><h2><strong>&nbsp;Student Registration : Step 2 Of 4</strong></h2></legend>
          </fieldset>
        <br />
        <br />
		<form name="form" class="form-horizontal" enctype="multipart/form-data" method="post">
       		<img class="img-thumbnail" height="160" width="215" src="<%=photo%>" style="margin-left:400px;"></img>
        	<%
        		System.out.println("Photo URL = "+photo);
        	 %>
        	<hr />
       

        <div class="form-group row">
            <div class="col-sm-3">        
                <input type="file" name="photo" class="form-control btn-default" onchange="check_extension(this.value, event)"  required="true" />  
			</div>

            <div class="col-md-2">
            	<input type="submit" name="uploadpic" class="btn btn-primary" value="Upload Pic" onclick="document.getElementById('submit').disabled = false;" ></input>
            </div>
        
        	<div class="col-md-2" >
        		<h3><span class="label label-info" >&nbsp;&nbsp;OR&nbsp;&nbsp;</span></h3>
        	</div>
        	
        	<div class="col-md-4" >
		        <button type="button" class="btn btn-default btn-lg">
		  			<span class="glyphicon glyphicon-camera"></span>&nbsp;&nbsp; <a href="#" onclick="window.open('htdocs/CaptureImage.jsp', '_top', 'width=500');document.getElementById('submit').disabled = false;">Take Snapshot</a>
				</button> 
			</div>
    		
     	</div>
     
     	<div class="form-group"></div>
     	<div class="form-group"></div>
     	<div class="form-group"></div>
     	</form>
     	<form action="GenerateReceipt.jsp">
     	<div class="form-group">
	     	<div style="margin-left:400px;">
	     		<input type="submit" name="submit" id="submit" value="Proceed >>>" class="btn-lg btn-primary" />
	     		
	     	</div>
	     	
        </div>
        </form>
        <button class="btn-lg btn-default" onclick="location.reload(true)"><span class="glyphicon glyphicon-refresh"></span>&nbsp;Reload</button>
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
				document.getElementById("submit").disabled = true;
                return false;
            }
        }
    </script>
  </body>
</html>
