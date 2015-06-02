<%@page import="com.login.SendMail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Connection con = null;
	
	
	try
	{
		con = DBInfo.getConn();
	if(request.getParameter("center")!=null)
	{
		String data = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
		data += "<TAG>";
		String query = "select * from inquiry  where substring(queryid from 6 for 2) = ? order by queryid";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, request.getParameter("center"));
		ResultSet rs = ps.executeQuery();
		
		response.setContentType("text/xml;charset=UTF-8");
	
		while(rs.next())
		{
			data += "<QUERY>";
			data += "<QID>"+rs.getString(1)+"</QID>";
			data += "<NAME>"+rs.getString(2)+"</NAME>";
			data += "<MOBILE>"+rs.getString(3)+"</MOBILE>";
			data += "<EMAIL>"+rs.getString(4)+"</EMAIL>";
			data += "<COURSE>"+rs.getString(5)+"</COURSE>";
			data += "<Q>"+rs.getString(6)+"</Q>";
			data += "</QUERY>";
		}
		data += "</TAG>";
		
		out.write(data);
		System.out.println("Content type is : "+response.getContentType()+data);
		
	}
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
		SendMail.sendReport(e, basePath);
	}
	finally
	{
		if(con!=null)
		{
			try
			{ con.close(); }
			catch(Exception e)
			{	SendMail.sendReport(e, basePath); }
		}
	}

%>


