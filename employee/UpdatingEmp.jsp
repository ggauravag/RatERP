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
			     

//System.out.println(request.getParameter("empsalary")+":"+request.getParameter("empdob")+":"+request.getParameter("empmobile")+":"+request.getParameter("empemail")+":"+request.getParameter("Eid"));
         
         if(request.getParameter("Eid")!=null)
         {
          String id=request.getParameter("Eid");
         
         if(request.getParameter("empsalary")!=null)
         {
             PreparedStatement ps = con.prepareStatement("update staff set salary=? where userid=?");
             ps.setString(1, request.getParameter("empsalary"));
             ps.setString(2, id);
             ps.executeUpdate();
             ps.close();
         }
         
         if(request.getParameter("empdob")!=null)
         {
             PreparedStatement ps1 = con.prepareStatement("update staff set start_date=? where userid=?");
             ps1.setString(1, request.getParameter("empdob"));
             ps1.setString(2, id);
             ps1.executeUpdate();
             ps1.close();
         }
         
         if(request.getParameter("empmobile")!=null)
         {
             PreparedStatement ps2 = con.prepareStatement("update staff set mobile=? where userid=?");
             ps2.setString(1, request.getParameter("empmobile"));
             ps2.setString(2, id);
             ps2.executeUpdate();
             ps2.close();
         }
         
         if(request.getParameter("empemail")!=null)
         {
             PreparedStatement ps3 = con.prepareStatement("update staff set email=? where userid=?");
             ps3.setString(1, request.getParameter("empemail"));
             ps3.setString(2, id);
             ps3.executeUpdate();
             ps3.close();
         }
         
         if(request.getParameter("empname")!=null)
         {
             PreparedStatement ps4 = con.prepareStatement("update staff set name=? where userid=?");
             ps4.setString(1, request.getParameter("empname"));
             ps4.setString(2, id);
             ps4.executeUpdate();
             ps4.close();
         }
         
                   session.setAttribute("TheType","");
                   session.setAttribute("Update", "yes");
                   
                   System.out.println(session.getAttribute("Update"));
                   response.sendRedirect(basePath +"employee/ManageEmp.jsp");
            
          
          }
         


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'UpdatingEmp.jsp' starting page</title>
  

  </head>
  
  <body>
   
  </body><%
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
</html>
