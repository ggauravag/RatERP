<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>



  <%
   String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  
  Connection con = null;
  try
  {
  		
  		String qid = request.getParameter("qid");
  		
  		
  		//System.out.println("Page Called");
  		
  		String id = request.getParameter("id");
  		String name = request.getParameter("name");
  		String mobile = request.getParameter("mobile");
  		String email = request.getParameter("email");
  		String pid = request.getParameter("pid");
  		String lang = request.getParameter("lang");
  		String dbid = request.getParameter("dbid");
  		String clg = request.getParameter("clg");
  		String sem = request.getParameter("sem");
  		String degree = request.getParameter("degree");
  		String classid = request.getParameter("classid");
  		String csid = request.getParameter("csid");
  		String smid = request.getParameter("smid");
  		String center = request.getParameter("center");
  		String certid = request.getParameter("certid");
  		
  		con = DBInfo.getConn();
  		ResultSet res = null;
  		PreparedStatement stmt = null;
  		String data = "";
  		if(certid!=null)
  		{
  			String query = "select * from student where certificate like '%,"+certid+",%' or certificate like '"+certid+"%' or certificate like '%,"+certid+"%'";
  			response.setContentType("text/xml;charset=UTF-8");
  			
  			PreparedStatement ps = con.prepareStatement(query);
  			//ps.setString(1, qid);
  			System.out.println(ps);
  			ResultSet rs = ps.executeQuery();
  			String xml = "";
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			while(rs.next())
  			{
  				
  				xml += "<STU>";
  				xml += "<ID>"+rs.getString(1)+"</ID>";
  				xml += "<NAME>"+rs.getString(2)+"</NAME>";
  				xml += "<MOBILE>"+rs.getString(4)+"</MOBILE>";
  				xml += "<EMAIL>"+rs.getString(3)+"</EMAIL>";
  				xml += "<CERT>"+rs.getString(22)+"</CERT>";
  				xml += "<LADD>"+rs.getString(8)+"</LADD>";
  				xml += "</STU>";
  				//System.out.println("Call success");
  			}
  			xml += "</QUERY>";	
  			out.write(xml);
  			System.out.println(xml);
  			return;
  		
  		
  		
  		}
  		else if(qid!=null)
  		{
  			String query = "select * from student where studentid=?";
  			response.setContentType("text/xml;charset=UTF-8");
  			
  			PreparedStatement ps = con.prepareStatement(query);
  			ps.setString(1, qid);
  			System.out.println(ps);
  			ResultSet rs = ps.executeQuery();
  			String xml = "";
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			if(rs.next())
  			{
  				
  				xml += "<STUDENT>";
  				xml += "<NAME>"+rs.getString(2)+"</NAME>";
  				xml += "<MOBILE>"+rs.getString(4)+"</MOBILE>";
  				xml += "<EMAIL>"+rs.getString(3)+"</EMAIL>";
  				xml += "<DOB>"+rs.getDate(5)+"</DOB>";
  				xml += "<CERT>"+rs.getString(22)+"</CERT>";
  				xml += "<LADD>"+rs.getString(8)+"</LADD>";
  				xml += "<COLLEGE>"+rs.getString(9)+"</COLLEGE>";
  				xml += "<SEM>"+rs.getString(10)+"</SEM>";
  				xml += "<DEGREE>"+rs.getString(11)+"</DEGREE>";
  				xml += "<PARENT>"+rs.getString(12)+"</PARENT>";
  				xml += "<GENDER>"+rs.getString(15)+"</GENDER>";
  				xml += "<FATHER>"+rs.getString(16)+"</FATHER>";
  				xml += "<PADD>"+rs.getString(18)+"</PADD>";
  				xml += "</STUDENT>";
  				//System.out.println("Call success");
  			}
  			xml += "</QUERY>";	
  			out.write(xml);
  			System.out.println(xml);
  			return;
  		}
  		else if(center != null)
  		{
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			xml += "<TAG>";
			String query = "select q.queryid,q.name,q.mobile,q.email,c.name,q.query from inquiry q,(select `name`,courseid from course union select dbname,dbid from dbcourse) c where q.cpid = c.courseid and substring(q.queryid from 6 for 2) = ? order by q.queryid";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, request.getParameter("center"));
			ResultSet rs = ps.executeQuery();
			
			
		
			while(rs.next())
			{
				xml += "<QUERY>";
				xml += "<QID>"+rs.getString(1)+"</QID>";
				xml += "<NAME>"+rs.getString(2)+"</NAME>";
				xml += "<MOBILE>"+rs.getString(3)+"</MOBILE>";
				xml += "<EMAIL>"+rs.getString(4)+"</EMAIL>";
				xml += "<COURSE>"+rs.getString(5)+"</COURSE>";
				xml += "<Q>"+rs.getString(6)+"</Q>";
				xml += "</QUERY>";
			}
			xml += "</TAG>";
			
			out.write(xml);
			////System.out.println("Content type is : "+response.getContentType()+xml);
			
  		
  		}
  		else if(name!=null)
  		{
  			stmt = con.prepareStatement("select * from student where name like '%"+name+"%' order by name");
  			//response.setContentType("text/xml;charset=UTF-8");
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			////System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		////System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		}
  		else if(mobile!=null)
  		{
  			stmt = con.prepareStatement("select * from student where mobile=? order by name");
  			stmt.setString(1, mobile);
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		}
  		else if(email!=null)
  		{
  			stmt = con.prepareStatement("select * from student where email=? order by name");
  			stmt.setString(1, email);
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		
  		}
  		else if(pid!=null)
  		{
  			stmt = con.prepareStatement("select * from student where packageid=? order by name");
  			stmt.setString(1, pid);
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		
  		}
  		else if(degree!=null)
  		{
  			stmt = con.prepareStatement("select * from student where degreeid=? order by name");
  			stmt.setString(1, degree);
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		
  		}
  		else if(lang!=null)
  		{
  			stmt = con.prepareStatement("select * from student where language like '%"+lang+"%' order by name");
  			//response.setContentType("text/xml;charset=UTF-8");
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		
  		}
  		else if(dbid!=null)
  		{
  			stmt = con.prepareStatement("select * from student where db like '%"+dbid+"%' order by name");
  		    //response.setContentType("text/xml;charset=UTF-8");
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		
  		}
  		else if(sem!=null)
  		{
  			stmt = con.prepareStatement("select * from student where semid=? order by name");
  			stmt.setString(1, sem);
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		
  		}
  		else if(clg!=null)
  		{
  			stmt = con.prepareStatement("select * from student where collegeid=? order by name");
  			stmt.setString(1, clg);
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		
  		}
  		else if(csid != null)
  		{
  			stmt = con.prepareStatement("select * from student where class like '%,"+csid+",%' or class like '"+csid+",%' order by name");
  			//response.setContentType("text/xml;charset=UTF-8");
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		}
  		else if(id!=null)
  		{
  			stmt = con.prepareStatement("select * from student where studentid=? order by name");
  			stmt.setString(1, id);
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY>";
  			//System.out.println(response.getContentType());
  			while(res.next())
	  		{
	  		
	  			    xml += "<STUDENT>";
	  				xml += "<ID>"+res.getString("studentid")+"</ID>";
	  				xml += "<NAME>"+res.getString("name")+"</NAME>";
	  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
	  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
	  				xml += "<PID>"+res.getInt(6)+"</PID>";
	  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
	  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
	  				xml += "<LANG>"+res.getString(13)+"</LANG>";
	  				xml += "<DB>"+res.getString(14)+"</DB>";
	  				xml += "<IMAGE>'student/"+res.getString(19)+"'</IMAGE>";
	  				xml += "</STUDENT>";
	  		 
	  		}
	  		
	  		xml += "</QUERY>";
	  		
	  		out.write(xml);
	  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		
  		}
  		else if(classid!=null)
  		{
  			stmt = con.prepareStatement("select * from studymaterial where courseid=? order by name");
  			response.setContentType("text/html;charset=UTF-8");
  			stmt.setString(1, classid);
  			res = stmt.executeQuery();
  			data = "<option value=''>--------------</option>";
  			while(res.next())
  			{
  				data += "<option value='"+res.getString("smid")+"'>"+res.getString("name")+"</option>";
  			}
  			out.write(data);
  			//System.out.println(data);
  			
  		}
  		else if(smid!=null)
  		{
  			String cid = request.getParameter("class");
  			stmt = con.prepareStatement("select * from student where class like '%"+cid+"%' AND studymat not like '%"+smid+"%' order by name");
  			////System.out.println(stmt);
  			res = stmt.executeQuery();
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			//System.out.println(response.getContentType());
  			xml += "<QUERY>";
  			while(res.next())
  			{
  				xml += "<STUDENT>";
  				xml += "<ID>"+res.getString("studentid")+"</ID>";
  				xml += "<NAME>"+res.getString("name")+"</NAME>";
  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
  				xml += "</STUDENT>";
  			}
  			xml += "</QUERY>";
  			//System.out.println(xml);
  			out.write(xml);
  			
  		
  		}
  		else
  		{
  		
  		
  		
  		}
  		/* data += "<table class='table table-striped'>";
       	data += "<tr><th>Student ID</th>";
       	data += "<th>Name</th>";
       	data += "<th>Email</th>";
       	data += "<th>Mobile</th>";
       	data += "<th>P-ID</th>";
       	data += "<th>Local Add.</th>";
       	data += "<th>Parent Mob.</th>";
       	data += "<th>Language</th>";
       	data += "<th>Database</th>";
       	data += "<th>Image</th>";	
       	data += "</tr>"; */
       	
       	
       /* 	response.setContentType("text/xml;charset=UTF-8");
       	
  		String xml = "";	
  		xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
       	xml += "<QUERY>";
  		while(res.next())
  		{
  		
  			    xml += "<STUDENT>";
  				xml += "<ID>"+res.getString("studentid")+"</ID>";
  				xml += "<NAME>"+res.getString("name")+"</NAME>";
  				xml += "<EMAIL>"+res.getString(3)+"</EMAIL>";
  				xml += "<MOBILE>"+res.getString("mobile")+"</MOBILE>";
  				xml += "<PID>"+res.getInt(6)+"</PID>";
  				xml += "<ADDRESS>"+res.getString(8)+"</ADDRESS>";
  				xml += "<PARENT>"+res.getString(12)+"</PARENT>";
  				xml += "<LANG>"+res.getString(13)+"</LANG>";
  				xml += "<DB>"+res.getString(14)+"</DB>";
  				xml += "<IMG><img src='student/"+res.getString(19)+"' height='50px' width='75px'></IMG>";
  				xml += "</STUDENT>";
  		  */
  		
  			/* data += "<tr>";
  			data += "<td>"+res.getString(1)+"</td>";
  			data += "<td>"+res.getString(2)+"</td>";
  			data += "<td>"+res.getString(3)+"</td>";
  			data += "<td>"+res.getString(4)+"</td>";
  			data += "<td>"+res.getInt(6)+"</td>";
  			data += "<td>"+res.getString(8)+"</td>";
  			data += "<td>"+res.getString(12)+"</td>";
  			data += "<td>"+res.getString(13)+"</td>";
  			data += "<td>"+res.getString(14)+"</td>";
  			data += "<td><img src='student/"+res.getString(19)+"' height='50px'></td>";
  			data += "</tr>"; */
  		
  		//}
  		
  		/* xml += "</QUERY>";
  		
  		out.write(xml);
  		//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
  		con.close(); */
  		//return;
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
  
  

