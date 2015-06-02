<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date" %>
<%@page import="com.login.Student" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection con = null;
     try
     {
     con = DBInfo.getConn();
       
       int feepaid=0;
       Date d= new Date();
       String stid = request.getParameter("stid");
       response.setContentType("text/xml;charset=UTF-8");
       //System.out.println("Search Student ID called");
       
       if(stid == null)
  		{
  			out.write("");
  			return;
  		}
  		else
  		{
           Student stu = new Student(stid);
  		   if(stu.fetchRecord() && stu.calculateFees())
  		   {
  		   
  			PreparedStatement ps = con.prepareStatement("select * from student where studentid=?");
  			ps.setString(1,stid);
  			ResultSet rs = ps.executeQuery();
  			
  			PreparedStatement ps1 = con.prepareStatement("select fee from package where pid=?");
  			ps1.setInt(1, stu.getPackageid());
  			ResultSet rs1 = ps1.executeQuery();
  			
  			PreparedStatement ps3 = con.prepareStatement("select pid from package where fee <= (select fee from package p, student st where p.pid = st.packageid and st.studentid = ?)");
  			ps3.setString(1, stid);
  			ResultSet rs3 = ps3.executeQuery();
  			String nopack = "";
  			while(rs3.next())
  			{
  				if(rs3.isLast())
  					nopack += rs3.getInt(1);
  				else
  					nopack += rs3.getInt(1) + ",";
  			}
  			
  			String xml = "";
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>"; 
  			
  			if(rs.next())
  			{  		     
  			     feepaid = rs.getInt("deposit_fee"); 
  			     d=rs.getDate("dob");    
  			}
  			 
  			
  		        xml += "<STUDENTRECORD>";  				
  				xml += "<NAME>"+stu.getName()+"</NAME>";
  				xml += "<FNAME>"+stu.getFatherName()+"</FNAME>";
  				xml += "<EMAIL>"+stu.getEmail()+"</EMAIL>";
  				xml += "<MOBILE>"+stu.getMobile()+"</MOBILE>";
  				xml += "<DOB>"+d+"</DOB>";
  				xml += "<FEEPAID>"+feepaid+"</FEEPAID>";
  				xml += "<PID>"+stu.getPackageid()+"</PID>";
  				xml += "<NOPID>"+nopack+"</NOPID>";
  				xml += "<COLLEGE>"+stu.getCollege()+"</COLLEGE>";
  				xml += "<SEMESTER>"+stu.getSem()+"</SEMESTER>";
  				xml += "<DEGREE>"+stu.getDegree()+"</DEGREE>";
  				xml += "<LANGUAGE>"+stu.getLanguage()+"</LANGUAGE>";
  				xml += "<DATABASE>"+stu.getDatabase()+"</DATABASE>";
  				if(rs1.next())
  					xml += "<PFEE>"+rs1.getInt(1)+"</PFEE>";
  				
  				xml += "</STUDENTRECORD>";
  				xml += "</QUERY>";	
  				System.out.println("Call success");
  			    out.write(xml);
  			    System.out.println(xml);
  			    
  			    
  			  }
  			  else
  			  {
  			    System.out.println("Record does not fetched");
  			  
  			  }
  			  
  			  
  		}
  		
  		
     }
      	catch(Exception e)
       		{
       			e.printStackTrace();
       		
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