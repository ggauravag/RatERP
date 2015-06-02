<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.login.*" %>
<%@page import="java.io.EOFException"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

      Connection con = null;
                  
      if(session == null || session.getAttribute("type") == null || !session.getAttribute("type").equals("STUDENT"))
      {
      	response.sendRedirect("../Unauthorize.jsp");
      	return;
      }
                  
                  
               
               
     
     try
     {
     
     	          con = DBInfo.getConn();
                   
                   String stid = (String)session.getAttribute("id");
                   //System.out.println("Studnet id in session is: "+stid);
                   //String stid="1408/TR/STU/00041";
                   Student stu = null;
                   String upd="";
                   
                   
          
            
                if(request.getParameter("stmobile") != null )
                {
                    PreparedStatement ps = con.prepareStatement("update student set mobile=? where studentid=?");
                    ps.setString(1, request.getParameter("stmobile"));         
                    ps.setString(2, stid);
                    int j = ps.executeUpdate();
                    upd="mob";
                   // System.out.println("Student updated successfully");
                 
                } 
                
                if(request.getParameter("stladd") != null)
                {
                    PreparedStatement ps = con.prepareStatement("update student set laddress=? where studentid=?");
                    ps.setString(1, request.getParameter("stladd"));
                    ps.setString(2, stid);
                    int j = ps.executeUpdate();
                    upd="add";
                }
                
                if(request.getParameter("stsem") != null)
                {
                    PreparedStatement ps = con.prepareStatement("update student set semid=? where studentid=?");
                    ps.setString(1, request.getParameter("stsem"));
                    ps.setString(2, stid);
                    int j = ps.executeUpdate();
                    upd="sem";
                }
                   
               
                   
                   
                   

	
	if(stid!=null)
	{
	
	 	stu = new Student(stid);
	 	
		if(stu.fetchRecord() && stu.calculateFees())
		{
			System.out.println("Student record fetched");
		}
		else
		{
			System.out.println("Unable to fetch student with id : "+stid);
		}
	}
	else
	{

		response.sendRedirect(basePath+"student/Unauthorize.jsp");
	}
                   
                   
                   
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <link rel="icon" href="css/images/ratico.ico">
    <title>RAT Panel</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
   <link href="css/bootstrap.min.css" rel="stylesheet">
   <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
   
   <script type="text/javascript"> 
   
  
   var checked = 0;
   
   
   function enable(cbox)
   {
   	 if(cbox.checked)
   	 {
   	 	checked += 1;
   	 	document.getElementById("updatebtn").disabled = false;
   	 }
   	 else
   	 {
   	 	checked -= 1;
   	 	if(checked == 0)
   	 		document.getElementById("updatebtn").disabled = true;
   	 }
   
   }
   
   function checkLength(e,id)
   {
   		var add = document.getElementById(id).value;
   		
   		if(add.length > 290)
   		{
   			//alert('Great');
   			return false;
   		}
   		
   		return true;
   }
   
   
   
   function editEnable(id1, id2)
     	{
     	
     	//alert("function called");
		  if(document.getElementById(id1).checked == true)
		  {
			document.getElementById(id2).disabled = false;
		  }
		  else
		  {
			document.getElementById(id2).disabled = true;
		  }
	    } 
	    
     
   </script>
  </head>
  
  <body>
  <form method="post" class="form-horizontal" name="optionForm">
    
        <div class="form-group"> 
	       <div class="col-sm-2">  
	            <img src="<%=basePath+"student/"+stu.getPhoto() %> " alt="Profile pic" class="img-thumbnail">
	       </div> 
	       </div>
	      <fieldset>
           <legend><strong>&nbsp;Student Details</strong></legend>
	     <% 
	       if(!upd.equals(""))
          {
          
           %>
          
          <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Updated Successfully !</strong> Your Account has been updated successfully.
   		 </div>
   		 
   		 <%
   		  }%>
	       
	       <div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Name :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="stname" class="form-control" id="Name" value="<%=stu.getName()%>" readonly></input>
		   </div>
			</div>
			
			
			
			<div class="form-group">
		   <label for="Email" class="col-sm-2 control-label" align="left">Email :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="stemail" class="form-control" id="Email" value="<%=stu.getEmail()%>" readonly></input>
		   </div>
			</div>	
			
			
			<div class="form-group">
		   <label for="Mobile" class="col-sm-2 control-label"  align="left">Mobile :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="stmobile" class="form-control" Maxlength="10" pattern="^[7-9][0-9]{9}$" id="Mobile" value="<%=stu.getMobile()%>" disabled="disabled"></input>
		   </div>
		   
		   <div class="col-sm-1">
           <input type="checkbox" id="editmobile" value="Mobile" onchange="enable(this);editEnable(this.id,this.value)" >&nbsp;Edit
           </div>
           
		   </div>
		   <!-- <div class="form-group">
		   <label for="DOB" class="col-sm-2 control-label" align="left">DOB :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="stdob" class="form-control" id="DOB" value="" readonly></input> 
		   </div>
			</div> -->	
			
			
			<div class="form-group">
		   <label for="Pname" class="col-sm-2 control-label" align="left">Package :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="stpname" class="form-control" id="Pname" value="<%=stu.getPackageName()%>" readonly></input>
		   </div>
			</div>	
			
			
			<div class="form-group">
		   <label for="Lenroll" class="col-sm-2 control-label" align="left">Languages :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="stlnames" class="form-control" id="Lenroll" value="<%
           				String l[] = stu.getLString();
           				for(int i = 0; i < l.length; i++)
           				{
           					//System.out.println("iNSIDE ARRAY");
           					if(i!=l.length-1 && l[i]!=null)
           						out.print(l[i]+", ");
           					else if(l[i]!=null)
           						out.print(l[i]);
           				
           				}
           				
           			 %>" readonly></input>
		   </div>
			</div>
			
			
			<div class="form-group">
		   <label for="DBenroll" class="col-sm-2 control-label" align="left">Databases :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="stDBnames" class="form-control" id="DBenroll" value="<%
           				String d[] = stu.getDString();
           				for(int i = 0; i < d.length; i++)
           				{
           				//System.out.println("iNSIDE ARRAY");
           					if(i!=d.length-1 && d[i]!=null)
           						out.print(d[i]+", ");
           					else if(d[i]!=null)
           						out.print(d[i]);
           				
           				}
           				
           			 %>" readonly></input>
		   </div>
			</div>
			
			
			<div class="form-group">
		   <label for="FeeDeposited" class="col-sm-2 control-label" align="left">Fee Deposited :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="stfd" class="form-control" id="FeeDeposited" value="<%=stu.getDeposit()%>" readonly></input>
		   </div>
			</div>
			
			
			<div class="form-group">
		   <label for="Laddress" class="col-sm-2 control-label" align="left">Address :</label> 
		   	
		   <div class="col-sm-6">  
		   <input type="text" name="stladd" onkeypress="return checkLength(event,this.id);" class="form-control" id="Laddress" value="<%=stu.getLAddress()%>" disabled="disabled"></input>
		   </div>
		   
		   <div class="col-sm-1">
           <input type="checkbox" id="editadd" value="Laddress" onchange="enable(this);editEnable(this.id,this.value)" >&nbsp;Edit
           </div>
           
			</div>
			
			
			<div class="form-group">
		   <label for="college" class="col-sm-2 control-label" align="left">College :</label> 
		   	
		   <div class="col-sm-6">  
		   
		   <%
		       String clgnm="";
		      PreparedStatement ps =con.prepareStatement("select name from college where collegeid=?");
		      ps.setString(1, String.valueOf(stu.getCollege()));
		      ResultSet rs=ps.executeQuery();
		      if(rs.next())
		      {
		        clgnm=rs.getString("name");
		      }
		      
		    %>
		   
		   <input type="text" name="stclg" class="form-control" id="college" value="<%=clgnm%>" readonly></input>
		   </div>
			</div>
			
			
			<div class="form-group">
		   <label for="semester" class="col-sm-2 control-label" align="left">Semester :</label> 
		   	
		   <div class="col-sm-6">  
		   
		  <%--  <%
		       String semnm="";
		      PreparedStatement ps1 =con.prepareStatement("select name from semester where semid=?");
		      ps1.setString(1, String.valueOf(stu.getCollege()));
		      ResultSet rs1=ps1.executeQuery();
		      if(rs1.next())
		      {
		        semnm=rs1.getString("name");
		      }
		      
		    %> --%>
		   
		   <input type="text" name="stsem" class="form-control" pattern="^[1-8]{1}" maxlength="1" id="semester" value="<%=stu.getSem()%>" disabled="disabled"></input>
		   </div>
		   
		   <div class="col-sm-1">
           <input type="checkbox" id="editsem" value="semester" onchange="enable(this);editEnable(this.id,this.value)" >&nbsp;Edit
           </div>
			</div>
			
			<div class="col-sm-offset-3">
		<input type="submit" name="upgrade" class="btn-lg btn-success" id="updatebtn" value="Update Details" disabled >
	   </div>
	      </fieldset>
	     
	     
	   <fieldset>
	   <legend><strong>&nbsp;Installment Details</strong></legend>
	   
	   
	   
	   
	      <table class="table table-striped">
	      <tr><th>INSTALLMENT No.</th>
          <th>AMOUNT</th>
          <th>DUE DATE</th>
          <th>STATUS</th></tr>
         
         
            <%   
                ResultSet rs1 = null;
                PreparedStatement ps1 = con.prepareStatement("select * from installment where studentid=?");
                ps1.setString(1, stid);
                rs1=ps1.executeQuery();
                
                
                System.out.println("Inside rs1");
                while(rs1.next())
                {
                
                   
                   %>
                   <tr><td><%= rs1.getInt(1)%></td>
                   <td><%=rs1.getInt(3)%></td>                 
                   <td><%=rs1.getDate(4)%></td>
                   <td><%=rs1.getString(5)%></td></tr>
                   <% 
                   
                  }// End of while loop
                
	   %>
	   </table>
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
