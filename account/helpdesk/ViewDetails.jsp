<%@ page language="java" import="java.util.*,com.login.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Connection con = null;

	try
	{
		con = DBInfo.getConn();
	boolean fail = false;
	String certid = request.getParameter("cerid");
	String query = "select ce.datetime,ce.recv_by,ce.stdate,ce.perform,u.name,cv.name,ce.enddate,ce.project,st.name,c.name,d.name,st.semid from student st, degree d, college c,certification ce,user u, courseview cv where ce.certificateid = ? and st.collegeid = c.collegeid and st.degreeid = d.degreeid and ce.studentid = st.studentid and cv.courseid = ce.courseid and ce.servicedeskid = u.userid;";
	PreparedStatement ps = con.prepareStatement(query);
	ps.setString(1, certid);
	ResultSet res = ps.executeQuery();
	if(res.next())
	{
	
	}
	else
	{
		fail = true;
	
	}
	
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Student Details</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<link href="css/bootstrap.min.css" rel="stylesheet">
     <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
     <script type="text/javascript" src="js/bootstrap.js"></script><isindex>
    

  </head>
  
  <body>
  
    <%
    	if(fail == true)
    	{
    		%>
    			<div align="center" style="color:red;font-size:40px;">No certificate exists with specified ID</div>
    		<%
    		return;
    	}
     %>
   <form method="post" class="form-horizontal" name="optionForm" action="account/helpdesk/PrintCertificate.jsp" >
	      <fieldset>
	      <legend><h1>View Details</h1></legend>
	      
	      <div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Issue Date & Time :</label> 
		   	
		   <div class="col-sm-4">  
		   <input type="text" class="form-control" id="Name" value="<%=res.getString(1) %>" readonly></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Issued By :</label> 
		   	
		   <div class="col-sm-4">  
		   <input type="text"  class="form-control" id="Name" value="<%=res.getString(5) %>" readonly></input>
		   </div>
			</div>
	      
	      
	       <div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Student Name :</label> 
		   	
		   <div class="col-sm-4">  
		   <input type="text" name="stuname" class="form-control" id="Name" value="<%=res.getString(9) %>" readonly></input>
		   </div>
			</div>
			
				<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">College Name :</label> 
		   	
		   <div class="col-sm-3">  
		   <input type="text" name="college" class="form-control" id="Name" value="<%=res.getString(10) %>" readonly></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Degree :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="degree" class="form-control" id="Name" value="<%=res.getString(11) %>" readonly></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Semester :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="semester" class="form-control" id="Name" value="<%=res.getString(12) %>" readonly></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Start Date :</label> 
		   	
		   <div class="col-sm-2">  
		   <%//System.out.println("The date");System.out.println("Date is : "+rs1.getDate(2)+","+rs1.getString(2)); %>
		   <input type="text" name="stdate" class="form-control" id="Name" value="<%=res.getString(3) %>" readonly></input><label style="color:black">* Indicative Date</label>
		   </div>
			</div>
			
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">End Date :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="enddate" class="form-control" id="Name" value="<%=res.getString(7) %>" readonly></input><label style="color:black">* Indicative Date</label>
		   </div>
			</div>
			
			
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Technology :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="course" class="form-control" id="Name" value="<%=res.getString(6) %>" readonly></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Performance :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="performance" class="form-control" value="<%=res.getString(4) %>" readonly>
		   		
		    </div>
			</div>
		   
		   
           <div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Project Title :</label> 
		   	
		   <div class="col-sm-5">  
		   <input type="text" name="title" class="form-control" value="<%=res.getString(8).split(";")[0] %>" id="Name" readonly></input><label style="color:red">* Maximum Length of title can be 100 Characters</label>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left" readonly>Received By :</label> 
		   	
		   <div class="col-sm-5">  
		 	 <input name="recv" class="form-control" value="<%=res.getString(2) %>" readonly>
		   </div>
			</div>
		  
			
			
			<div class="form-group">
		   <label for="Pname" class="col-sm-2 control-label" align="left">Project Description :</label> 
		   	
		   <div class="col-sm-6">  
		   <textarea name="desc" cols="10" rows="5" class="form-control" readonly><%if(res.getString(8).split(";").length == 2)out.write(res.getString(8).split(";")[1]); %></textarea>
		   </div>
		  
			</div>	
			
			
			<div class="form-group">
		  		<input type="submit" name="confirmDetails" class="btn btn-lg btn-success col-sm-offset-4" value="View Certificate">
			</div>
			
			
			</fieldset>
			
			</form>
	  
   
  </body>
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
</html>
