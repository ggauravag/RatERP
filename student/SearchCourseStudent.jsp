<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>



  <%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  
  
  Connection con = null;
  try
  {
  
        String courseid = request.getParameter("courseid");
  		//response.setContentType("text/html;charset=UTF-8");
  		response.setContentType("text/xml;charset=UTF-8");
  		System.out.println("Page Called");
  		System.out.println("Courseid is: "+courseid);
  		if(courseid == null)
  		{
  			out.write("");
  			return;
  		}
  		else
  		{
  		   
  			String query="Select * from student where language like (?) OR db like (?) order by name";
  			con = DBInfo.getConn();
  			PreparedStatement ps = con.prepareStatement(query);
  			ps.setString(1,"%"+courseid+"%");
  			ps.setString(2,"%"+courseid+"%");
  			ResultSet res = ps.executeQuery();
  	     String data = "";	
  	     data.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			data += "<QUERY>";
        /* data += "<table class='table table-striped'>";
       	data += "<tr><th></th><th>Select</th>";
       	data += "<th>Student ID</th>";
       	data += "<th>Name</ th>";
       	data += "<th>Email</th>";
       	data += "<th>Mobile</th>";
       	data += "<th>P-ID</th>";
       	data += "<th>Parent Mob.</th>";
       	data += "<th>Language</th>";
       	data += "<th>Database</th>";
       	data += "<th>Image</th>";	
       	data += "</tr>"; */
  			while(res.next())
  			{
  			   
  			    /*  data += "<tr><td></td>";
  			data += "<td><input type='checkbox' name='st' value='"+res.getString(1)+"'></td>";
  			data += "<td>"+res.getString(1)+"</td>";
  			data += "<td>"+res.getString(2)+"</td>";
  			data += "<td>"+res.getString(3)+"</td>";
  			data += "<td>"+res.getString(4)+"</td>";
  			data += "<td>"+res.getInt(6)+"</td>";
  			data += "<td>"+res.getString(12)+"</td>";
  			data += "<td>"+res.getString(13)+"</td>";
  			data += "<td>"+res.getString(14)+"</td>";
  			data += "<td><img src='student/"+res.getString(19)+"' height='50px'></td>";
  			data += "</tr>"; */
  					data += "<STUDENT>";
	  				data += "<ID>"+res.getString("studentid")+"</ID>";
	  				data += "<NAME>"+res.getString("name")+"</NAME>";
	  				data += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				data += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				data += "<PID>"+res.getInt(6)+"</PID>";
	  				data += "<LANG>"+res.getString(13)+"</LANG>";
	  				data += "<DB>"+res.getString(14)+"</DB>";
	  				data += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				data += "</STUDENT>";
  			
  				
  			
  			}
  				data += "</QUERY>";
  			out.write(data);
  			System.out.println(data);
  			con.close();
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