<%@ page language="java" import="java.util.*,com.login.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String type = (String)session.getAttribute("type");
	if(type != null && (type.equals("ADMIN") || type.equals("HELPDESK")))
	{
		
	}
	else
	{
		response.sendRedirect("../Unauthorize.jsp");
		return;
	}


	Connection con = null;
	try
	{
	
		con = DBInfo.getConn();
	
	
	String name = request.getParameter("name");
	String cid = request.getParameter("courseid");
	String packageid = request.getParameter("packageid");
	String classid = request.getParameter("classid");
	String date = request.getParameter("date");
	String all = request.getParameter("all");
	
	System.out.println("Name : "+name+",Course : "+cid+", Pack : "+packageid+",Class : "+cid+", Date : "+date+", ALL : "+all);
	
	if(name != null)
	{
		PreparedStatement ps = con.prepareStatement("select email,mobile from student where name like ?");
               ps.setString(1,"%"+name+"%");
               ResultSet rs= ps.executeQuery();    
              
               String email = request.getParameter("messageEmail");
               String mobmsg = request.getParameter("messageSMS");
               String ems[] = request.getParameterValues("selectemail");
               String sms[] = request.getParameterValues("selectsms");
               
               
               String emails[] = null;
               		
               		if(ems != null && ems.length >= 1)
               		{
               		
               			if(rs.next())
               			{
               		
		               		int g = rs.getRow();
							System.out.println(g);
							rs.last();
					
							int j = rs.getRow();
						//System.out.println("Count i : "+(j-g+1));
							
							
						if(j-g+1 < 100)
							emails = new String[j-g+1];
						else
							emails = new String[99];
							
												
							rs.beforeFirst();
							int k = 0;
							while(rs.next() && k < 99)
							{
								emails[k] = rs.getString(1);
								k++;
							}
							
							
							SendMail.sendMessage(email, emails, basePath);
					
					}	
               		else
               		{
               		
               	
               		}
               
               }
               if(sms != null && sms.length >= 1)
               {
               		String mobiles = "";
               		rs.beforeFirst();
               		while(rs.next())
               		{
               			mobiles += rs.getString(2)+",";
               		}
               		
               		ProactiveSMS.sendSMS(mobiles, mobmsg);
               
               }
	
	}
	else if(cid != null)
	{
		 PreparedStatement ps = con.prepareStatement("select email,mobile from student where (language like ? or language like ? or language like ?) or (db like ? or db like ? or db like ?)");
               ps.setString(1,cid+", %");
               ps.setString(2,"%, "+cid+",%");
               ps.setString(3,"% "+cid);
               ps.setString(4,cid+",%");
               ps.setString(5,"%,"+cid+",%");
               ps.setString(6,"%,"+cid);     
               ResultSet rs= ps.executeQuery();
               String email = request.getParameter("messageEmail");
               String mobmsg = request.getParameter("messageSMS");
               String ems[] = request.getParameterValues("selectemail");
               String sms[] = request.getParameterValues("selectsms");
               
               
               String emails[] = null;
               		
               		if(ems != null && ems.length >= 1)
               		{
               		
               			if(rs.next())
               			{
               		
		               		int g = rs.getRow();
							System.out.println(g);
							rs.last();
					
							int j = rs.getRow();
						//System.out.println("Count i : "+(j-g+1));
							
							
						if(j-g+1 < 100)
							emails = new String[j-g+1];
						else
							emails = new String[99];
							
												
							rs.beforeFirst();
							int k = 0;
							while(rs.next() && k < 99)
							{
								emails[k] = rs.getString(1);
								k++;
							}
							
							
							SendMail.sendMessage(email, emails, basePath);
					
					}	
               		else
               		{
               		
               	
               		}
               
               }
               if(sms != null && sms.length >= 1)
               {
               		String mobiles = "";
               		rs.beforeFirst();
               		while(rs.next())
               		{
               			mobiles += rs.getString(2)+",";
               			//System.out.println(rs.getString(2));
               		}
               		
               		ProactiveSMS.sendSMS(mobiles, mobmsg);
               
               }
	
	}
	else if(packageid != null)
	{
		PreparedStatement ps = con.prepareStatement("select email,mobile from student where packageid like ?");
               ps.setString(1,packageid);               
               
               ResultSet rs= ps.executeQuery();
               String email = request.getParameter("messageEmail");
               String mobmsg = request.getParameter("messageSMS");
               String ems[] = request.getParameterValues("selectemail");
               String sms[] = request.getParameterValues("selectsms");
               
               
               String emails[] = null;
               		
               		if(ems != null && ems.length >= 1)
               		{
               		
               			if(rs.next())
               			{
               		
		               		int g = rs.getRow();
							System.out.println(g);
							rs.last();
					
							int j = rs.getRow();
						//System.out.println("Count i : "+(j-g+1));
							
							
						if(j-g+1 < 100)
							emails = new String[j-g+1];
						else
							emails = new String[99];
							
												
							rs.beforeFirst();
							int k = 0;
							while(rs.next() && k < 99)
							{
								emails[k] = rs.getString(1);
								k++;
							}
							
							
							SendMail.sendMessage(email, emails, basePath);
					
					}	
               		else
               		{
               		
               	
               		}
               
               }
               if(sms != null && sms.length >= 1)
               {
               		String mobiles = "";
               		rs.beforeFirst();
               		while(rs.next())
               		{
               			mobiles += rs.getString(2)+",";
               		}
               		
               		ProactiveSMS.sendSMS(mobiles, mobmsg);
               
               }
	
	}
	else if(classid != null)
	{
		PreparedStatement ps = con.prepareStatement("select email,mobile from student where class like ? or class like ? ");
               ps.setString(1,classid+",%");
               ps.setString(2,"%,"+classid+",%");           
               ResultSet rs= ps.executeQuery();
               String email = request.getParameter("messageEmail");
               String mobmsg = request.getParameter("messageSMS");
               String ems[] = request.getParameterValues("selectemail");
               String sms[] = request.getParameterValues("selectsms");
               
               
               String emails[] = null;
               		
               		if(ems != null && ems.length >= 1)
               		{
               		
               			if(rs.next())
               			{
               		
		               		int g = rs.getRow();
							System.out.println(g);
							rs.last();
					
							int j = rs.getRow();
						//System.out.println("Count i : "+(j-g+1));
							
							
						if(j-g+1 < 100)
							emails = new String[j-g+1];
						else
							emails = new String[99];
							
												
							rs.beforeFirst();
							int k = 0;
							while(rs.next() && k < 99)
							{
								emails[k] = rs.getString(1);
								k++;
							}
							
							
							SendMail.sendMessage(email, emails, basePath);
					
					}	
               		else
               		{
               		
               	
               		}
               
               }
               if(sms != null && sms.length >= 1)
               {
               		String mobiles = "";
               		rs.beforeFirst();
               		while(rs.next())
               		{
               			mobiles += rs.getString(2)+",";
               		}
               		
               		ProactiveSMS.sendSMS(mobiles, mobmsg);
               
               }
	
	}
	else if(date != null)
	{
		String dates[]  = date.split(",");
		
		PreparedStatement ps1 = con.prepareStatement("select email,mobile from student where substr(studentid,1,4)>=? and substr(studentid,1,4)<=?");
               ps1.setString(1,dates[0]);
               ps1.setString(2,dates[1]);    
               ResultSet rs= ps1.executeQuery();
               String email = request.getParameter("messageEmail");
               String mobmsg = request.getParameter("messageSMS");
               String ems[] = request.getParameterValues("selectemail");
               String sms[] = request.getParameterValues("selectsms");
               
               
               String emails[] = null;
               		
               		if(ems != null && ems.length >= 1)
               		{
               		
               			if(rs.next())
               			{
               		
		               		int g = rs.getRow();
							System.out.println(g);
							rs.last();
					
							int j = rs.getRow();
						//System.out.println("Count i : "+(j-g+1));
							
							
						if(j-g+1 < 100)
							emails = new String[j-g+1];
						else
							emails = new String[99];
							
												
							rs.beforeFirst();
							int k = 0;
							while(rs.next() && k < 99)
							{
								emails[k] = rs.getString(1);
								k++;
							}
							
							
							SendMail.sendMessage(email, emails, basePath);
					
					}	
               		else
               		{
               		
               	
               		}
               
               }
               if(sms != null && sms.length >= 1)
               {
               		String mobiles = "";
               		rs.beforeFirst();
               		while(rs.next())
               		{
               			mobiles += rs.getString(2)+",";
               		}
               		
               		ProactiveSMS.sendSMS(mobiles, mobmsg);
               
               }
	
		
	
	}
	else if(all != null)
	{
		PreparedStatement ps1 = con.prepareStatement("select email,mobile from student");
               ResultSet rs= ps1.executeQuery();
               String email = request.getParameter("messageEmail");
               String mobmsg = request.getParameter("messageSMS");
               String ems[] = request.getParameterValues("selectemail");
               String sms[] = request.getParameterValues("selectsms");
               
               
               String emails[] = null;
               		
               		if(ems != null && ems.length >= 1)
               		{
               		
               			if(rs.next())
               			{
               		
		               		int g = rs.getRow();
							System.out.println(g);
							rs.last();
					
							int j = rs.getRow();
						//System.out.println("Count i : "+(j-g+1));
							
							
						if(j-g+1 < 100)
							emails = new String[j-g+1];
						else
							emails = new String[99];
							
												
							rs.beforeFirst();
							int gh = 0;
							while(rs.next() && gh < 99)
							{
								emails[gh] = rs.getString(1);
								gh++;
							}
							
							
							SendMail.sendMessage(email, emails, basePath);
					
					}	
               		else
               		{
               		
               	
               		}
               
               }
               if(sms != null && sms.length >= 1)
               {
               		String mobiles = "";
               		rs.beforeFirst();
               		while(rs.next())
               		{
               			mobiles += rs.getString(2)+",";
               		}
               		
               		ProactiveSMS.sendSMS(mobiles, mobmsg);
               
               }
	
	}
	else
	{
		con.close();
		session.setAttribute("msg", "failure");
		return;
	
	}

	session.setAttribute("msg", "success");
	con.close();
	response.sendRedirect("ContactStudent.jsp");
	

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'SendMessage.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <br>
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
  	if(con!=null)
  	{
  		try
  		{	con.close(); }
  		catch(Exception e)
  		{
  			e.printStackTrace();
  		}
  	}
  }
  
  
   %>
</html>
