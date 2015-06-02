<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.login.*" %>
<%@page import="java.io.EOFException"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	  if(session == null || session.getAttribute("type") == null || !session.getAttribute("type").equals("STUDENT"))
      {
      	response.sendRedirect("../Unauthorize.jsp");
      	return;
      }



                       Connection con = null;
     
     try
     {
     	          con = DBInfo.getConn();
                   
                   String stid = (String)session.getAttribute("id");
                   //System.out.println("Studnet id in session is: "+stid);
                   //String stid="1408/TR/STU/00041";
                   Student stu = null;
                   
                   
                   
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

  </head>
  
  <body>
  <form method="post" class="form-horizontal" name="optionForm">
  
  <br>
 <div class="form-group">
		 <div class="col-sm-3">
		 
		   	<ul class="list-group">
		   	<li class="list-group-item disabled"><span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;&nbsp;<strong>Courses completed</strong></li>
          <li class="list-group-item">
          
  


		   	<%
		   	 PreparedStatement ps3 = con.prepareStatement("select distinct(co.name) from student st,class c,(select courseid,name from course union select dbid,dbname from dbcourse) co where st.studentid=? and c.end_date is not null and co.courseid = c.courseid and (st.class like concat('%,',c.classid,',%') or st.class like concat(c.classid,',%'))");
		   	 ps3.setString(1, stid);
		   	 ResultSet rs3=ps3.executeQuery();
		   	 
		   	 while(rs3.next())
		   	 {
		   	     %><br>
		   	     <span class="glyphicon glyphicon-ok"></span>&nbsp;
		   	     <%=rs3.getString("co.name") %>
		   	     <%
		   	 
		   	 }
		   	 %>
		   	 
		   	 
		   	 
		   	 
		   	 
		   </li>
     </ul>
     
    </div>
  <div class="col-sm-4"></div>
  
  
       <div class="col-sm-3">
		 
		   	<ul class="list-group">
		   	<li class="list-group-item disabled"><span class="glyphicon glyphicon-remove"></span>&nbsp;&nbsp;&nbsp;<strong>Courses not completed</strong></li>
          <li class="list-group-item">
          
  


		   	<%
		   	 PreparedStatement ps4 = con.prepareStatement("select co.name from student st,(select courseid,name from course union select dbid,dbname from dbcourse) co where st.studentid=? and ((st.language like concat('%, ',co.courseid,',%') or st.language like concat('%, ',co.courseid) or st.language like concat(co.courseid,',%')) or (st.db like concat('%,',co.courseid,',%') or st.db like concat('%,',co.courseid) or st.db like concat(co.courseid,',%'))) and co.name not in(select co.name from student st,class c,(select courseid,name from course union select dbid,dbname from dbcourse) co where st.studentid=? and co.courseid = c.courseid and c.classid is not null and (st.class like concat('%,',c.classid,',%') or st.class like concat(c.classid,',%')))");
		   	 ps4.setString(1, stid);
		   	 ps4.setString(2, stid);
		   	 ResultSet rs4=ps4.executeQuery();
		   	 
		   	 while(rs4.next())
		   	 {
		   	     %><br>
		   	     <span class="glyphicon glyphicon-remove"></span>&nbsp;
		   	     <%=rs4.getString("co.name") %>
		   	     <%
		   	 
		   	 }
		   	 %>
		   	 
		   	 
		   	 
		   	 
		   	 
		   </li>
     </ul>
      
    </div>
  
  
  
  
  </div>
     <fieldset>
     <legend><strong>&nbsp;Classes Details :</strong></legend>
           <fieldset>
           <legend><strong>&nbsp;Active :</strong></legend>
           
           <table class="table table-striped">
	      <tr><th>CLASS ID</th>
          <th>CLASS TIME</th>
          <th>SCHEDULE</th>
          <th>CENTER</th>
          <th>TRAINER NAME</th>
          <th>START DATE</th>         
          </tr>
         
         
            <%   
                ResultSet rs = null;
                PreparedStatement ps = con.prepareStatement("select c.classid, c.time, c.schedule, c.center, t.name,c.start_date,c.end_date from student st,class c,trainer t where (st.class like concat('%,',c.classid,',%') or st.class like concat(c.classid,',%')) and st.studentid=? and c.end_date is null and c.trainerid = t.trainerid");
                ps.setString(1, stid);
                rs=ps.executeQuery();
                
                
               // System.out.println("Inside rs1");
                while(rs.next())
                {
                
                   
                   %>
                   <tr><td><%= rs.getString(1)%></td>
                   <td><%=rs.getString(2)%></td>  
                   <td><%=rs.getString(3)%></td>  
                   <td><%=rs.getString(4)%></td>  
                   <td><%=rs.getString(5)%></td>  
                   <td><%=rs.getString(6)%></td>                 
                   
                   </tr>
                   <% 
                   
                  }// End of while loop
                
	   %>
	   </table>
           
           
           </fieldset>
  
  <hr>
  
  
           <fieldset>
           <legend><strong>&nbsp;Completed :</strong></legend>
           
           <table class="table table-striped">
	      <tr><th>CLASS ID</th>
          <th>CLASS TIME</th>
          <th>SCHEDULE</th>
          <th>CENTER</th>
          <th>TRAINER NAME</th>
          <th>START DATE</th>
          <th>END DATE</th>         
          </tr>
         
         
            <%   
                ResultSet rs1 = null;
                PreparedStatement ps1 = con.prepareStatement("select c.classid, c.time, c.schedule, c.center, t.name,c.start_date,c.end_date from student st,class c,trainer t where (st.class like concat('%,',c.classid,',%') or st.class like concat(c.classid,',%')) and st.studentid=? and c.end_date is not null and c.trainerid = t.trainerid");
                ps1.setString(1, stid);
                rs1=ps1.executeQuery();
                
                
               // System.out.println("Inside rs1");
                while(rs1.next())
                {
                
                   
                   %>
                   <tr><td><%= rs1.getString(1)%></td>
                   <td><%=rs1.getString(2)%></td>  
                   <td><%=rs1.getString(3)%></td>  
                   <td><%=rs1.getString(4)%></td>  
                   <td><%=rs1.getString(5)%></td>  
                   <td><%=rs1.getString(6)%></td>                 
                   <td><%=rs1.getString(7)%></td>
                   </tr>
                   <% 
                   
                  }// End of while loop
                
	   %>
	   </table>
           
           
           </fieldset>
  
    <hr>
    
          <fieldset>
           <legend><strong>&nbsp;Other Current Active :</strong></legend>
           
           <table class="table table-striped">
	      <tr><th>CLASS ID</th>
          <th>CLASS TIME</th>
          <th>SCHEDULE</th>
          <th>COURSE NAME</th>
          <th>CENTER</th>
          <th>TRAINER NAME</th>
          <th>START DATE</th>         
          </tr>
         
         
            <%   
                ResultSet rs2 = null;
                PreparedStatement ps2 = con.prepareStatement("select c.classid, c.time, c.schedule, co.name , c.center, t.name,c.start_date,c.end_date from student st, class c, trainer t, (select courseid,name from course union select dbid,dbname from dbcourse) co where (st.class not like concat('%,',c.classid,',%') and st.class not like concat(c.classid,',%')) and st.studentid=? and c.end_date is null and c.trainerid = t.trainerid and co.courseid = c.courseid and ((st.language like concat('%, ',c.courseid,',%') or st.language like concat('%, ',c.courseid) or st.language like concat(c.courseid,',%')) or (st.db like concat('%,',c.courseid,',%') or st.db like concat('%,',c.courseid) or st.db like concat(c.courseid,',%')) ) ;");
                ps2.setString(1, stid);
                rs2=ps2.executeQuery();
                
                
               // System.out.println("Inside rs1");
                while(rs2.next())
                {
                
                   
                   %>
                   <tr><td><%=rs2.getString(1)%></td>
                   <td><%=rs2.getString(2)%></td>  
                   <td><%=rs2.getString(3)%></td>  
                   <td><%=rs2.getString(4)%></td>  
                   <td><%=rs2.getString(5)%></td>  
                   <td><%=rs2.getString(6)%></td>                 
                   <td><%=rs2.getString(7)%></td>  
                   </tr>
                   <% 
                   
                  }// End of while loop
                
	   %>
	   </table>
           
           
           </fieldset>
  
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
