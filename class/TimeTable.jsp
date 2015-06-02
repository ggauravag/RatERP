<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.text.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String type = (String)session.getAttribute("type");
	if(type != null && (type.equals("ADMIN") || type.equals("HELPDESK") || type.equals("TRAINER")))
	{
		
	}
	else
	{
		response.sendRedirect("Unauthorize.jsp");
		return;
	}
	Connection con = null;
String days[] = new String[]{"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}; 
try
{   
	con = DBInfo.getConn();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Class Time Table</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
     <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="css/images/ratico.ico">
  
  </head>
  
  <body>
    <form method="get" class="form-horizontal" action="">
    
          <fieldset><legend><h1><strong> Time Table</strong></h1></legend>
          
          <div id="divA">
		   
		   </div>
          
          <fieldset>
       <legend><strong>&nbsp;&nbsp;Tonk Road Center</strong><input type="button" class="btn btn-success col-sm-offset-9" value="Print" onclick="printPage(this);">		     
	 </legend>
       
           <div class="col-sm-12">
       	<table class="table table-bordered" id="table">
       	
       	<%
       		String query = "select c.classid,c.time,c.schedule,c.center,c.trainerid,co.name,t.name,c.start_date from class c,course co,trainer t where c.center = 'TR' and c.courseid = co.courseid and c.trainerid = t.trainerid order by c.time";
       		PreparedStatement ps = con.prepareStatement(query);
       		ResultSet rs = ps.executeQuery();
       		
       		
       		%><tr><th style="text-align: center;color:red">DAY / TIME </th><%
       		while(rs.next())
       		{
       			%><th style="text-align: center"><%=rs.getString(2).substring(0, 5)%></th><%
       		}
       		
       		%></tr><%
       		
       		
       		int i = -1;
       		while(++i < 6)
       		{
       			rs.beforeFirst();
       			%>
       			<tr>
       					<td style="text-align: center;font-weight:bold"><%=days[i] %></td>
       					<%
       						while(rs.next())
       						{
       							String sch[] = rs.getString(3).split(",");
       							ArrayList<String> lst = new ArrayList<String>(Arrays.asList(sch));
       							if(lst.contains(days[i]))
       							{
       								%><td style="text-align: center"><%=rs.getString(6) %><br><font size="2" style="font-weight:bold"><%=rs.getString(7) %></font></td><%
       							}
       							else
       							{
       								%><td></td><%
       							}
       						}
       					
       					 %>
       			</tr>
       			<%
       		
       		}
       	
       	 %>
       	
       	
       	</table>
       
       </div>
          </fieldset>
          
          
		   <div id="divB">
		   
		   </div>
		<fieldset>
       <legend><strong>&nbsp;&nbsp;Pratap Nagar Center</strong></legend>
	       <div class="col-sm-12">
	       	<table class="table table-bordered " id="table">
	       		<%
       		 query = "select c.classid,c.time,c.schedule,c.center,c.trainerid,co.name,t.name,c.start_date from class c,course co,trainer t where c.center = 'PN' and c.courseid = co.courseid and c.trainerid = t.trainerid order by c.time";
       		 ps.close();
       		 ps = con.prepareStatement(query);
       		 rs = ps.executeQuery();
       		
       		
       		%><tr><th style="text-align: center;color:red">DAY / TIME </th><%
       		while(rs.next())
       		{
       			%><th style="text-align: center"><%=rs.getString(2).substring(0, 5)%></th><%
       		}
       		
       		%></tr><%
       		
       		
       		i = -1;
       		while(++i < 6)
       		{
       			rs.beforeFirst();
       			%>
       			<tr>
       					<td style="text-align: center;font-weight:bold"><%=days[i] %></td>
       					<%
       						while(rs.next())
       						{
       							String sch[] = rs.getString(3).split(",");
       							ArrayList<String> lst = new ArrayList<String>(Arrays.asList(sch));
       							if(lst.contains(days[i]))
       							{
       								%><td style="text-align: center"><%=rs.getString(6) %><br><font size="2" style="font-weight:bold"><%=rs.getString(7) %></font></td><%
       							}
       							else
       							{
       								%><td></td><%
       							}
       						}
       					
       					 %>
       			</tr>
       			<%
       		
       		}
       	
       	 %>
	       	
	       	</table>
	       </div>
       </fieldset>
       <div id="divC">
		   
		   </div>
       
        <fieldset>
       <legend><strong>&nbsp;&nbsp;Kukas Center</strong></legend>
        <div class="col-sm-12">
       	<table class="table table-bordered" id="table">
       			<%
       		query = "select c.classid,c.time,c.schedule,c.center,c.trainerid,co.name,t.name,c.start_date from class c,course co,trainer t where c.center = 'KK' and c.courseid = co.courseid and c.trainerid = t.trainerid order by c.time";
       		ps.close();
       		ps = con.prepareStatement(query);
       		rs = ps.executeQuery();
       		
       		
       		%><tr><th style="text-align: center;color:red">DAY / TIME </th><%
       		while(rs.next())
       		{
       			%><th style="text-align: center"><%=rs.getString(2).substring(0, 5)%></th><%
       		}
       		
       		%></tr><%
       		
       		
       		i = -1;
       		while(++i < 6)
       		{
       			rs.beforeFirst();
       			%>
       			<tr>
       					<td style="text-align: center;font-weight:bold"><%=days[i] %></td>
       					<%
       						while(rs.next())
       						{
       							String sch[] = rs.getString(3).split(",");
       							ArrayList<String> lst = new ArrayList<String>(Arrays.asList(sch));
       							if(lst.contains(days[i]))
       							{
       								%><td style="text-align: center"><%=rs.getString(6) %><br><font size="2" style="font-weight:bold"><%=rs.getString(7) %></font></td><%
       							}
       							else
       							{
       								%><td></td><%
       							}
       						}
       					
       					 %>
       			</tr>
       			<%
       		
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
     <script type="text/javascript">
     
     function printPage(btn)
     {
     	document.getElementById("divA").innerHTML = "<br><br><br><br><br>";
     	document.getElementById("divB").innerHTML = "<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
     	document.getElementById("divC").innerHTML = "<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
     	btn.style.visibility = 'hidden';
     	print();
     	btn.style.visibility = 'visible';
     	document.getElementById("divA").innerHTML = "";
     	document.getElementById("divB").innerHTML = "";
     	document.getElementById("divC").innerHTML = "";
     }
     
     </script>
  </body>
</html>
