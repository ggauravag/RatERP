<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,com.login.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


               
               
                 Connection con = null;
     
			     try
			     {
			     	con = DBInfo.getConn();
			     

     if(request.getParameter("dltemp")!=null && request.getParameter("dltemp")!="")
     {
          
        PreparedStatement ps5 = con.prepareStatement("update staff set end_date=now() where userid=?");  
          ps5.setString(1, request.getParameter("dltemp"));
         int i= ps5.executeUpdate();
         
         if(i==1)
          {             
                response.sendRedirect(basePath+"employee/ManageEmp.jsp");
          }
     }

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <link rel="icon" href="css/images/ratico.ico">
    <title>Manage Employee</title>
    
    
    <link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
   
    <script src="js/ie-emulation-modes-warning.js"></script>   
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>

  </head>
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
  
  </script>
  <body>
  <form method="post" class="form-horizontal" name="form1">
   <% 
   if(request.getParameter("Criteria")!="" && request.getParameter("Criteria")!=null)
   {
    session.setAttribute( "TheType", request.getParameter("Criteria"));
     System.out.println("Session value is:"+session.getAttribute( "TheType" ));
     		
     }
     else
     {     
     System.out.println("Session value is:"+session.getAttribute( "TheType" ));    	     	
     }
     
     %>
  
   
   
       <fieldset>
           <legend><strong>&nbsp;&nbsp;Search Employee</strong></legend>
             <%
           if (session.getAttribute("Update")!=null)
        {
            %>

    <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Employee Details updated.
   		 </div>

            <%
           
           session.setAttribute("Update", null);
            
        }
        
        %>
         
  
           <div class="form-group">
            <label for="selectCriteria" class="col-sm-2 control-label" align="left">User Type :</label>
            <label style="color:red">*</label>
            <div class="col-sm-3">
           <select name="Criteria" id="selectCriteria" class="form-control">
           <option value="" selected="selected">--------Select--------</option>          
           <option value="HELPDESK">HELPDESK</option>
           <option value="TRAINER">TRAINER</option>
           <option value="STAFF">STAFF</option>
           </select>
           </div>
           </div>
		   
		   <div class="form-group"> 
 		    <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" class="btn btn-primary" value="Search Employees >>>"/> 
 		    </div>
   		  </div>
		   
		   <div id="fill">
		   
		   </div>
		   
		   
		   <%
		   
		   if(request.getParameter("Criteria")!=null || session.getAttribute( "TheType" )!=null)
     		    {
     		    
     		    System.out.println("Session value is:"+session.getAttribute( "TheType" ));
     		    String temp="";
     		    
     		    if(request.getParameter("Criteria")!=null && request.getParameter("Criteria")!="")
     		    {
     		      temp = request.getParameter("Criteria");
     		    }
     		    else if(session.getAttribute( "TheType" ).toString()!=null && session.getAttribute( "TheType" ).toString()!="")
     		    {
     		      temp = session.getAttribute( "TheType" ).toString();
     		    }
     		    else
     		    {
     		      temp="";
     		    }
     		    
     		    
     		    System.out.println("The type is:"+temp);
     		    %>
     		    
     		    <div class="col-sm-12">
		      <table id="table" class="table table-hover">
		       <tr>
		       <th>Edit</th>
		       <th>EMPLOYEE ID</th>
		       <th>Name</th>
		       <th>Mobile</th>
		       <th>Email</th>
		       <th>Address</th>
		       <th>Salary</th>
		       <th>Joining Date</th>
		       <th>Delete</th>
		       
		       </tr>
     		    <% 
     		       PreparedStatement ps = con.prepareStatement("select * from staff where type=? and end_date is null"); 
     		       ps.setString(1, temp);   
     		       ResultSet rs = ps.executeQuery();
     		       
     		       while(rs.next())
     		       {
     		           %>
     		           <tr>
     		           <td><input type="radio" onchange = "this.form.submit();" name="empid" value="<%=rs.getString("userid")%>"></td>
     		           <td><%=rs.getString("userid")%></td>
     		           <td><%=rs.getString("name")%></td>
     		           <td><%=rs.getString("mobile")%></td>
     		           <td><%=rs.getString("email")%></td>
     		           <td><%=rs.getString("address")%></td>
     		           <td><%=rs.getInt("salary")%></td>
     		           <td><%=rs.getString("start_date")%></td>
     		           <td><input type="submit" name="dltemp" value="<%=rs.getString("userid")%>" class="btn btn-primary"></td>
     		           </tr>
     		           <% 
     		       } 	
     		       
     		       ps.close();	    
     		    }
     		   
     		 %>
     	
     		
     	
     	
     	</table>
     	</div>
     	</fieldset>
     	
     	</form>
     	
     	
     	<form method="post" class="form-horizontal" name="form2" action="<%=basePath+"employee/UpdatingEmp.jsp"%>">
     	<%
     	if(request.getParameter("empid")!=null && request.getParameter("empid")!="")
     	{
     	     System.out.println("The empid is:"+request.getParameter("empid"));
     	    PreparedStatement ps1 = con.prepareStatement("select * from staff where userid=?");
     	    ps1.setString(1,request.getParameter("empid"));
     	    ResultSet rs1 = ps1.executeQuery();
     	    
     	    if(rs1.next())
     	    {
     	    
     	
     	 %>
     <fieldset>
           <legend><strong>&nbsp;&nbsp;Edit Employee</strong></legend>
           
           
           <div class="form-group">
           <label for="inputEid" class="col-sm-2 control-label" align="left">Employee ID :</label>          	
           <div class="col-sm-5">
           <input type="text" name="Eid" value=<%=rs1.getString(1) %> class="form-control" id="inputEid" readonly="true"  onblur="correct(this.id)"></input>
            </div>           
            </div>
           
           
     	    <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Employee Name :</label>          	
           <div class="col-sm-5">
           <input type="text" name="empname" value=<%=rs1.getString(2) %> disabled="disabled" class="form-control" placeholder="Enter Employee Name" id="inputName" required="true" onblur="correct(this.id)"></input>
            </div>
            <div class="col-sm-1">
		    <input type="checkbox" id="editnm" value="inputName" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
		    </div>
            </div>
            
            <div class="form-group">
		   <label for="inputEmail" class="col-sm-2 control-label" align="left">Email ID :</label> 		   
		   <div class="col-sm-5">  
		   <input type="email" name="empemail" value=<%=rs1.getString(4) %> disabled="disabled" class="form-control" id="inputEmail" placeholder="Enter Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ></input>
		   </div>
		   <div class="col-sm-1">
		    <input type="checkbox" id="editemaild" value="inputEmail" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
		    </div>
			</div>
            
            <div class="form-group">	
		   <label for="inputMobile" class="col-sm-2 control-label" align="left">Mobile No. :</label> 		 
		   <div class="col-sm-3">  
		   <input type="text" class="form-control" value=<%=rs1.getString(3) %> disabled="disabled" Maxlength="10" name="empmobile" id="inputMobile" pattern="^[7-9][0-9]{9}$" required="true"  Placeholder="Enter Mobile No."/></input>
		   </div>
		   <div class="col-sm-1">
		    <input type="checkbox" id="editmb" value="inputMobile" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
		    </div>
		   </div>
		   
		   
		   <div class="form-group">	
		   <label for="inputDOB" class="col-sm-2 control-label" align="left">D.O.J :</label> 		  
		   <div class="col-sm-3">  
		   <input type="text" class="form-control" value=<%=rs1.getString(8) %> disabled="disabled" name="empdob" id="inputDOB" required="true"/></input>
		   </div>
		   <div class="col-sm-1">
		    <input type="checkbox" id="editdb" value="inputDOB" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
		    </div>
		   </div>
		   
		   
		    <div class="form-group">
		     <label for="inputSalary" class="col-sm-2 control-label">Salary :</label>
		     <div class="col-sm-2">
		     <input type="text" class="form-control" value=<%=rs1.getInt(6) %> disabled="disabled" name="empsalary" id="inputSalary" Placeholder="Enter Salary"/></input>
		     </div>
		     <div class="col-sm-1">
		    <input type="checkbox" id="editsal" value="inputSalary" onchange="editEnable(this.id, this.value)" >&nbsp;Edit
		    </div>
		     </div>
		   
		     <div class="col-sm-offset-3">
			<input type="submit" name="add" class="btn-lg btn-success" value="Confirm Details" >
			</div>
		   
		   <%
		   
		   }
		   ps1.close();
		   rs1.close();
		   } %>
		</fieldset>
</form>
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
