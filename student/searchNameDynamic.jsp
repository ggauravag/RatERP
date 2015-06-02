<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>


<%
 String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  
	Connection con = null;

  try
  {
  		
  		String stname = request.getParameter("sname");
  		response.setContentType("text/xml;charset=UTF-8");
  		System.out.println("Page Called");
  		if(stname == null)
  		{
  			out.write("");
  			return;
  		}
  		else
  		{
  		   
  			String query="Select installment.studentid,student.name,student.email,student.mobile,installment.amount,installment.date,installment.status from installment INNER JOIN student on installment.studentid = student.studentid where student.name LIKE ? order by installment.studentid";
  			con = DBInfo.getConn();
  			PreparedStatement ps = con.prepareStatement(query);
  			ps.setString(1,'%'+stname+'%');
  			ResultSet rs = ps.executeQuery();
  			String xml = "";
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			while(rs.next())
  			{
  			
  				xml += "<STUDENTRECORD>";
  				//xml += "<IMAGE>"+"CLick Here"+"</IMAGE>";
  				xml += "<STUDENTID>"+rs.getString("studentid")+"</STUDENTID>";
  				xml += "<NAME>"+rs.getString("name")+"</NAME>";
  				xml += "<EMAIL>"+rs.getString("email")+"</EMAIL>";
  				xml += "<MOBILE>"+rs.getString("mobile")+"</MOBILE>";
  				xml += "<AMOUNT>"+rs.getInt("amount")+"</AMOUNT>";
  				xml += "<DATE>"+rs.getDate("date")+"</DATE>";
  				xml += "<STATUS>"+rs.getString("status")+"</STATUS>";
  				xml += "</STUDENTRECORD>";
  				System.out.println("Call success");
  			}
  			xml += "</QUERY>";	
  			out.write(xml);
  			System.out.println(xml);
  			
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