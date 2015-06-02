<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Clob"%>

<%@page import="com.login.SendMail"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*,java.sql.Connection" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	if(session == null || session.getAttribute("type") == null)
    {
      	return;
    }



	//System.out.println("Page called");
	String commentid = request.getParameter("commentid");
	String comment = request.getParameter("comment");
	String stuid = request.getParameter("stu");
	Connection con = null;
		try
		{
	
			if(comment != null && commentid != null && stuid != null)
			{
				con = DBInfo.getConn();
				System.out.println("Data is : "+commentid+","+comment+","+stuid+"--------");
				String query = "insert into discussion(studenttid,comment,discussid) values(?,?,?)";
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, stuid);
				ps.setString(2, comment);
				ps.setInt(3, Integer.parseInt(commentid));
				int i = ps.executeUpdate();
				String xml = "";
				if(i == 1)
				{
					response.setContentType("text/xml;charset=UTF-8");
		  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		  			xml += "<QUERY><RESPONSE><STATUS>1</STATUS>";
		  			xml += "</RESPONSE></QUERY>";
		  			out.write(xml);
				}
				else
				{
					response.setContentType("text/xml;charset=UTF-8");
		  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		  			xml += "<QUERY><RESPONSE><STATUS>0</STATUS></RESPONSE></QUERY>";
		  			out.write(xml);
				}
				System.out.println("Response : "+response.getContentType()+" XML : "+xml);
			
			}

    
    	}
    	catch(Exception e)
    	{
    		SendMail.sendReport(e, basePath);
    		e.printStackTrace();
    	}
    	finally
    	{
    		if(con != null)
    		{
    			try
    			{ con.close(); }
    			catch(Exception e)
    			{	SendMail.sendReport(e, basePath);
    				e.printStackTrace();
    			}
    			
    		}
    	
    	}
    
     %>
 
