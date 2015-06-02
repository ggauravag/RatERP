<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.login.DBInfo,com.login.SendMail"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection con = null;
	boolean print = false;
	
	try
	{

		con = DBInfo.getConn();
		
		
		if(request.getParameter("confirmDetails")!=null)
		{
			String stuname = request.getParameter("stuname");
			String collge = request.getParameter("college");
			String degree = request.getParameter("degree");
			String semester = request.getParameter("semester");
			String stdate = request.getParameter("stdate");
			String enddate = request.getParameter("enddate");
			String course = request.getParameter("course");
			String performance = request.getParameter("performance");
			String title = request.getParameter("title");
			String desc = request.getParameter("desc");
			String stuid = request.getParameter("stuid");
			String courseid = request.getParameter("courseid");
			String recv = request.getParameter("recv");
			
			//System.out.println(stuname+collge+degree+semester+stdate+enddate+course+performance+title+desc);
			
			int count = 0;
			String query = "select certificate from count_user";
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				count = rs.getInt(1);
			}
			
			query = "update count_user set certificate = certificate + 1";
			ps.close();
			ps = con.prepareStatement(query);
			ps.executeUpdate();
			
			java.util.Date d = new java.util.Date();
			SimpleDateFormat format = new SimpleDateFormat ("yyyyMM");
		
			String sid=format.format(d).substring(2);
			sid=sid+"/CER/";
			sid += String.format("%07d", count);
			System.out.println("certificate id is : "+sid);
			
			
			query = "insert into certification values(?,?,now(),?,?,?,?,?,?,?)";
			ps.close();
			ps = con.prepareStatement(query);
			ps.setString(1, sid);
			ps.setString(2, stuid);
			ps.setString(3, recv);
			ps.setString(4, (String)session.getAttribute("id"));
			ps.setString(5, title+";"+desc);
			ps.setString(6, courseid);
			ps.setString(7, stdate);
			ps.setString(8, enddate);
			ps.setString(9, performance);
			
			int i = ps.executeUpdate();
			if(i == 1)
			{
				RequestDispatcher rd = request.getRequestDispatcher("PrintCertificate.jsp");
				rd.forward(request, response);
				return;
			}
			else
			{
				
				print = true;
			}
			
			
			
		}
		
		

	String stuid = request.getParameter("stuid");
	String courseid = request.getParameter("courseid");
	
	//System.out.println("Data : "+stuid+","+courseid);
	
	//c.setTime(d);
	//System.out.println(new SimpleDateFormat("MMM-yy").format(d));
	
	PreparedStatement ps = con.prepareStatement("select st.name,st.email,st.mobile,c.name,d.name,st.semid from student st, degree d, college c where st.studentid = ? and st.collegeid = c.collegeid and st.degreeid = d.degreeid");
	ps.setString(1, stuid);
	ResultSet res = ps.executeQuery();
	if(res.next())
		System.out.println("Yes student is there");
	
	PreparedStatement ps1 = con.prepareStatement("select cv.name,c.start_date,c.end_date from student st, class c,courseview cv where c.courseid = ? and cv.courseid = c.courseid and c.end_date is not null and st.studentid = ? and (st.class like concat('%,',c.classid,',%') or st.class like concat(c.classid,',%')) order by c.start_date;");
	ps1.setString(1, courseid);
	ps1.setString(2, stuid);
	//System.out.println(ps1);
	ResultSet rs1 = ps1.executeQuery();
	String op = "";
	if(rs1.next())
	{
	
	System.out.println("yes result date");
	
	}
	else
	{
		op = "fail";
		System.out.println("No result date");
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
     	if(op.equals("fail"))
     	{
     	
     		%>
     			
     			<div align="center">
     					<h2 style="color:red">No Certificate can be issued as Class has not ended yet.</h2>
     			
     			</div>
     		<%
     		return;
     	}
     %>
     <% 
     	if(print == true)
     	{
     	
     		%>
     			
     			<div align="center">
     					<h2 style="color:red">There were some errors while issuing certificate. Please contact System Administrator or try again later.</h2>
     			</div>
     		<%
     		
     	}
     %>
   <form method="post" class="form-horizontal" name="optionForm" >
	      <fieldset>
	      <legend><h1>Confirm Details</h1></legend>
	       <div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Student Name :</label> 
		   	
		   <div class="col-sm-4">  
		   <input type="text" name="stuname" class="form-control" id="Name" value="<%=res.getString(1) %>" required></input>
		   </div>
			</div>
			
			<input type=hidden name="stuid" value="<%=stuid %>">
			<input type=hidden name="courseid" value="<%=courseid %>">
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">College Name :</label> 
		   	
		   <div class="col-sm-3">  
		   <input type="text" name="college" class="form-control" id="Name" value="<%=res.getString(4) %>" required></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Degree :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="degree" class="form-control" id="Name" value="<%=res.getString(5) %>" required></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Semester :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="semester" class="form-control" id="Name" value="<%=res.getString(6) %>" required></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Start Date :</label> 
		   	
		   <div class="col-sm-2">  
		   <%System.out.println("The date");System.out.println("Date is : "+rs1.getDate(2)+","+rs1.getString(2)); %>
		   <input type="text" name="stdate" class="form-control" id="Name" value="<%=new SimpleDateFormat("MMM-yy").format(rs1.getDate(2)) %>" required></input><label style="color:black">* Indicative Date</label>
		   </div>
			</div>
			
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">End Date :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="enddate" class="form-control" id="Name" value="<%=new SimpleDateFormat("MMM-yy").format(rs1.getDate(3)) %>" required></input><label style="color:black">* Indicative Date</label>
		   </div>
			</div>
			
			
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Technology :</label> 
		   	
		   <div class="col-sm-2">  
		   <input type="text" name="course" class="form-control" id="Name" value="<%=rs1.getString(1) %>" required readonly></input>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Performance :</label> 
		   	
		   <div class="col-sm-2">  
		   <select name="performance" class="form-control">
		   		<option value="Outstanding">Outstanding</option>
		   		<option value="Excellent">Excellent</option>
		   		<option value="Very Good">Very Good</option>
		   		<option value="Good">Good</option>
		   		<option value="Satisfactory">Satisfactory</option>
		   		<option value="Poor">Poor</option>
		   </select>
		    </div>
			</div>
		   
		   
           <div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Project Title :</label> 
		   	
		   <div class="col-sm-5">  
		   <input type="text" name="title" class="form-control" id="Name" required></input><label style="color:red">* Maximum Length of title can be 100 Characters</label>
		   </div>
			</div>
			
			<div class="form-group">
		   <label for="Name" class="col-sm-2 control-label" align="left">Received By :</label> 
		   	
		   <div class="col-sm-5">  
		 	 <select name="recv" class="form-control">
		   		<option value="Self">Self</option>
		   		<option value="Post">Sent Through Post</option>
		   		<option value="Friend">Through Friend</option>
		   		<option value="Other">Other</option>
		   	
		   </select>
		   </div>
			</div>
		  
			
			
			<div class="form-group">
		   <label for="Pname" class="col-sm-2 control-label" align="left">Project Description :</label> 
		   	
		   <div class="col-sm-6">  
		   <textarea name="desc" cols="10" rows="5" class="form-control"></textarea>
		   </div>
		  
			</div>	
			
			
			<div class="form-group">
		  		<input type="submit" name="confirmDetails" class="btn btn-lg btn-success col-sm-offset-4" value="Generate Certificate">
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
