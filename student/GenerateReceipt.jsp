<%@page import="java.sql.*"%>
<%@ page language="java" import="java.util.*, com.login.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Connection con = null;

try
{


	con = DBInfo.getConn();
	Student stu = null;

	String id = (String)session.getAttribute("newid");
	if(id!=null)
	{
	
	    stu = new Student(id);
		if(stu!=null && stu.fetchRecord())
		{
			System.out.println("Student record fetched");
		}
		else
		{
			response.sendRedirect("UploadPic.jsp");
		}
	}
	else
	{

		response.sendRedirect("registrationstudent.jsp");
	}
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
  <link rel="stylesheet" href="../css/bootstrap.css" type="text/css"></link>
  <script type="text/javascript">
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
  </script>
  
  </head>
  
  <body>
  <form method="post" name="form" action="ConfirmFees.jsp" class="form-horizontal" >
          
         <fieldset>&nbsp;<legend><h1><strong>Student Registration : Step 3 of 4</strong></h1></legend>
          </fieldset>
		   
         
           <fieldset>
           <legend><strong>&nbsp;Confirm Student Details</strong></legend>
           <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Name :</label>
           
           <div class="col-sm-6">
           <input type="text" value="<%=stu.getName()%>" name="stname" class="form-control" placeholder="Enter Name" id="inputName" required="true" onblur="correct(this.id)" disabled></input>
            </div>
            <div class="col-sm-2">
            	<input type="checkbox" id="editname" value="inputName" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
            </div>
            </div>
         
           <div class="form-group">
           <label for="inputFname" class="col-sm-2 control-label" align="left">Father's Name :</label>
           		
           <div class="col-sm-6">
           <input type="text" name="stfname" value="<%=stu.getFatherName() %>" class="form-control" placeholder="Enter Father's Name" id="inputFname" required="true" onblur="correct(this.id)" disabled></input>
            </div>
             <div class="col-sm-2">
            	<input type="checkbox" id="editfname" value="inputFname" onchange="editEnable(this.id, this.value)">&nbsp;Edit
            </div>
            </div>
           
           <div class="form-group">
		   <label for="inputEmail" class="col-sm-2 control-label" align="left">Email ID :</label> 
		   
		   <div class="col-sm-7">  
		   <input type="email" name="stemail" value="<%=stu.getEmail() %>" class="form-control" id="inputEmail" placeholder="Enter Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true" disabled="disabled" ></input>
		   </div>
		    <div class="col-sm-2">
            	<input type="checkbox" id="editemail" value="inputEmail" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
            </div>
			</div>	
			
		   <div class="form-group">
		   <label for="PAddress" class="col-sm-2 control-label" align="left">Permanent Address :</label> 
		   	
		   <div class="col-sm-7">  
		   <textarea class="form-control" name="stpadd" rows="3" id="PAddress" placeholder="Enter Permanent Address" required="true" onblur="correct(this.id)" disabled="disabled"><%=stu.getPAddress() %></textarea>
		   </div>   
		    <div class="col-sm-2">
            	<input type="checkbox" id="editpaddr" value="PAddress" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
            </div>	
		   </div>
		   	
		   <div class="form-group">	
		   <label for="inputParent" class="col-sm-2 control-label" align="left">Parents Contact No. :</label> 
		 
		   <div class="col-sm-2">  
		   <input type="text" value="<%=stu.getParentMobile() %>" class="form-control" Maxlength="10" name="stpmobile" id="inputParent" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No." disabled="disabled"/></input>
		   </div>
		   <div class="col-sm-1">
            	<input type="checkbox" id="editpmob" value="inputParent" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
            </div>
		   
		   
		   
		   <label for="inputStudent" class="col-sm-2 control-label" align="left">Student Contact No. :</label> 
		   <div class="col-sm-2">  
		   
		   <input type="text" value="<%=stu.getMobile() %>" required="true" class="form-control" Maxlength="10" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" name="stmobile" id="inputStudent" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No." disabled="disabled"/></input>
		   </div>
		    <div class="col-sm-2">
            	<input type="checkbox" id="editsmobile" value="inputStudent" onchange="editEnable(this.id, this.value)">&nbsp;Edit
            </div>
		   </div>
		   
		   <div class="form-group">
		   <label for="LAddress" class="col-sm-2 control-label" align="left">Local Address :</label> 
		   		
		   <div class="col-sm-7">  
		   <textarea class="form-control" name="stladd" rows="3" id="LAddress" placeholder="Enter Local Address" required="true" disabled="disabled"><%=stu.getLAddress() %></textarea>
		   </div>
		    <div class="col-sm-2">
            	<input type="checkbox" id="editladdr" value="LAddress" onchange="editEnable(this.id, this.value)">&nbsp;Edit
            </div>
		   </div>
		  
		   <div class="checkbox col-sm-offset-2" style="margin-top:-10px;" >
		   	<input type="checkbox" id="same" onClick="copyAddress()">Same as Permanent Address
		   </div>
		  
		   <div class="form-group">
		   <label for="Gender" class="col-sm-2 control-label" align="left">Gender :</label> 
		   <div class="col-sm-2" style="margin-top:7px;">  
		   <label class="col-sm-2">Male</label>
		   </div>
		   </div>
		   
		   <div class="form-group">
		   <label for="dob" class="col-sm-2 control-label" align="left">Student Photograph :
		   </label>
		   <div class="col-sm-2">
		   	<img class="img-thumbnail" height="160" width="215" src="<%=stu.getPhoto() %>" ></img>
		   </div>
		    
		   </div>
           </fieldset>
           
                    
         
        
      
        <fieldset>
           <legend><strong>&nbsp;Course Details</strong></legend>
           
           
           
           
           
           
           <div class="form-group">
		   <label for="package" class="col-sm-2 control-label" align="left">Package Enroll For :</label> 
		   <div class="col-sm-7"> 
           <div class="input-group">
           <% 
           	PreparedStatement ps = con.prepareStatement("select name from package where pid=?");
           	ps.setInt(1,stu.getPackageid());
           	//System.out.println("The package id inquired for is : "+stu.getPackageid());
           	ResultSet res = ps.executeQuery();
           	if(res.next())
           	{        
           	           	  System.out.println("yes, it has package");
           	           	   %>
           <label><%=res.getString("name") %></label>
          	<%
          	}
          	 %>
             </div>    
             </div>
             </div>
             
             
              <div class="form-group">
		     <label for="course" class="col-sm-2 control-label" align="left">Specialized Certificates :</label> 
             <div class="col-sm-6"> 
             <div class="input-group">
             <%
             	String s = stu.getCertificate();
             	PreparedStatement ps1 = null;
             	ResultSet rs1 = null;
             	if(s!=null && !s.equals(""))
             	{
	             	ps1 = con.prepareStatement("select courseid from certificate where certificateid in ("+s+")");
	             	
	             	rs1 =	ps1.executeQuery();
	             	int i = 0;
	             	while(rs1.next())
					{
						%>
						<label>&nbsp;&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<%=rs1.getString(1) %>&nbsp;</label>
						<%
					}   
					ps1.close();
					rs1.close();
				}
				         
              %>
             
             
             </div>
		     </div>
		     </div>
             
             <div class="form-group">
		     <label for="course" class="col-sm-2 control-label" align="left">Language Courses :</label> 
             <div class="col-sm-6"> 
             <div class="input-group">
             <%
             	s = stu.getLanguage();
             	
             	if(s!=null && !s.equals(""))
             	{
	             	ps1 = con.prepareStatement("select name from course where courseid in ("+s+")");
	             	
	             	rs1 =	ps1.executeQuery();
	             	int i = 0;
	             	while(rs1.next())
					{
						%>
						<label>&nbsp;&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<%=rs1.getString("name") %>&nbsp;</label>
						<%
					}   
					ps1.close();
					rs1.close();
				}
				         
              %>
             
             
             </div>
		     </div>
		     </div>
		     
		     
		     
		      <div class="form-group">
		     <label for="course" class="col-sm-2 control-label" align="left">Select Database Courses :</label> 
             <div class="col-sm-10"> 
             <div class="input-group">
             <%
             String s1 = stu.getDatabase();
             if(s1!=null && !s1.equals(""))
             {
             	System.out.println("The db course is :"+s1);
             	ps1 = con.prepareStatement("select dbname from dbcourse where dbid in ("+s1+")");
             	
             	rs1 =	ps1.executeQuery();
             	int j = 0;
             	while(rs1.next())
				{
					%>
					<label>&nbsp;&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<%=rs1.getString("dbname") %>&nbsp;</label>
					<%
				}   
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
 		     <input type="submit" class="btn btn-success btn-lg" value="Confirm" /> 		     
 		     </div>
   		 
   		     
   		    
 		     <div class="col-sm-2"> 
 		     <input type="button" class="btn btn-default btn-lg" value="Back" onclick="window.history.back()"/>     
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
