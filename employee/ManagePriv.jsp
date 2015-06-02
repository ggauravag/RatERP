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
			     	
			    if(request.getParameter("enbl")!=null && request.getParameter("enbl")!="")
			     {
			          
			          PreparedStatement ps5 = con.prepareStatement("update user set status=? where userid=?");  
			          ps5.setString(1, "Y");
			          ps5.setString(2, request.getParameter("enbl"));
			          int i= ps5.executeUpdate();
			         
			         if(i==1)
			          {        session.setAttribute("Update", "yes");     
			                response.sendRedirect(basePath+"employee/ManagePriv.jsp");
			          }
			          ps5.close();
			     }
			     
			     if(request.getParameter("disbl")!=null && request.getParameter("disbl")!="")
			     {
			          
			          PreparedStatement ps4 = con.prepareStatement("update user set status=? where userid=?");  
			          ps4.setString(1, "N");
			          ps4.setString(2, request.getParameter("disbl"));
			          int i= ps4.executeUpdate();
			         
			         if(i==1)
			          {             
			                response.sendRedirect(basePath+"employee/ManagePriv.jsp");
			          }
			     }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Manage Privilege</title>
    
	<link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
   
    <script src="js/ie-emulation-modes-warning.js"></script>   
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>


  </head>
  
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
      		<strong>Success !</strong> Employee Enabled.
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
           <option value="ADMIN">ADMIN</option>
           <option value="HELPDESK">HELPDESK</option>
           <option value="TRAINER">TRAINER</option>         
           </select>
           </div>
           </div>
            
            
            <div class="form-group"> 
 		    <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" class="btn btn-primary" value="Search Records >>>"/> 
 		    </div>
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
		       <th></th>
		       <th>USER ID</th>
		       <th>Name</th>		       
		       <th>Email</th>
		       <th>Mobile</th>
		       <th>Last Login</th>
		       <th>Status</th>
		       <th>Enable</th>
		       <th>Disable</th>
		       </tr>
     		      
     		      
     		      <% 
     		       PreparedStatement ps = con.prepareStatement("select * from user where utype=?"); 
     		       ps.setString(1, temp);   
     		       ResultSet rs = ps.executeQuery();
     		       
     		       while(rs.next())
     		       {
     		           %>
     		           <tr>
     		           <td></td>
     		           <td><%=rs.getString("userid")%></td>
     		           <td><%=rs.getString("name")%></td>
     		           <td><%=rs.getString("email")%></td>
     		           <td><%=rs.getString("mobile")%></td>
     		           <td><%=rs.getString("last_log")%></td>
     		           <td><%=rs.getString("status")%></td>
     		           <td><input type="submit" name="enbl" value="<%=rs.getString("userid")%>" class="btn btn-primary"></td>
     		           <td><input type="submit" name="disbl" value="<%=rs.getString("userid")%>" class="btn btn-primary"></td>
     		           </tr>
     		           <% 
     		       } 	
     		       
     		       ps.close();	    
     		    }
     		   
     		 %>
    
    </table>
    </div>
   </fieldset>
  
  
  
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
         </form> 
       </body>  
</html>
