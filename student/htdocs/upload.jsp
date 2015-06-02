<%@page import="com.login.DBInfo"%>
<%@ page language="java" import="java.util.*, java.io.*, java.sql.*,com.login.SendMail" pageEncoding="ISO-8859-1"%>
<%
	Connection con = null;
	String path = request.getContextPath();
		System.out.println(path);
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String contentType = request.getContentType();
		String path1 = request.getServletContext().getRealPath("/student/profile/");

		System.out.println("Content Type : "+contentType);
		DataInputStream stream = new DataInputStream(request.getInputStream());
		int size = request.getContentLength();
		System.out.println("Content Length : "+size);
		byte dataBytes[] = new byte[size];
		int byteRead = 0;
		int totalBytesRead = 0;
		while (totalBytesRead < size) {
		byteRead = stream.read(dataBytes, totalBytesRead,size);
		totalBytesRead += byteRead;
		}
		String imageString = new String(dataBytes);
		
           
		String id = (String)session.getAttribute("newid");
		if(id == null)
		{
			System.out.println("No user to save image");
		
		}
		path1 = path1 + "/"+"Student"+id.substring(12)+".jpg";
		System.out.println(path1);
		
		OutputStream outputStream = null;
        
        try {
            con = DBInfo.getConn();
        
           outputStream = new FileOutputStream(new File(path1));
           outputStream.write(dataBytes);
           PreparedStatement ps = con.prepareStatement("update student set photo=? where studentid=?");
           outputStream.flush();
           outputStream.close();
           ps.setString(1, "profile/"+"Student"+id.substring(12)+".jpg");
           ps.setString(2, id);
           int i = ps.executeUpdate();
           if(i==1)
           {
           		System.out.println("Student Image saved");
           }
           else
           {
          		System.out.println("Error while saving image");
           }
           
            
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
		out.print("Success");


%>


