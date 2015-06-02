<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>

  <%
       Connection con=null;
       String type = (String)session.getAttribute("type");
	if(type != null && (type.equals("ADMIN") || type.equals("HELPDESK")))
	{
		
	}
	else
	{
		response.sendRedirect("Unauthorize.jsp");
		return;
	}
  try
  {
           con = DBInfo.getConn();
  
  			String temp="";
  			
  		String id = request.getParameter("id");
  		String cid = request.getParameter("classid");
  	    String action = request.getParameter("action");
  	    String courseid = request.getParameter("courseid");
  	    String VcourseID = request.getParameter("VcourseID");
  	    String center = request.getParameter("center");
  	    String tnm = request.getParameter("tn");
  	    String vcid = request.getParameter("vcid");
  	    //System.out.println("Id is:"+id);
  	    //System.out.println("classid id is:"+cid);
  	    //System.out.println("action is:"+action);
  	    //System.out.println("course id is:"+courseid);
  	    
  	    if(action!=null)
  	    {
  	       
  	       PreparedStatement ps1=con.prepareStatement("select courseid from class where classid=? and end_date is null");
  	       ps1.setString(1, id);
  	       ResultSet rw=ps1.executeQuery();
  	       if(rw.next())
  	       {
  	         temp=rw.getString("courseid");
  	       }
  	       ps1.close();
  	       
  	       PreparedStatement ps=con.prepareStatement("update class set end_date=now() where classid=?");
  	       ps.setString(1, id);
  	       int i=ps.executeUpdate();
  	       if(i==1)
  	       {
  	         //System.out.println("Deleted successfully");
  	         id=temp;
  	       }
  	       ps.close();
  	    }
  	    
       if(id!=null)
  		{
  		//System.out.println("Page Called");
  		
  		ResultSet res = null;
  		PreparedStatement stmt = null;
  		String data = "";
  		
  		stmt = con.prepareStatement("select c.classid,c.time,c.schedule,c.center,t.name,c.courseid,c.start_date from class c,trainer t where c.courseid=? and c.trainerid=t.trainerid and c.end_date is null");
  	    stmt.setString(1, id);
  		res = stmt.executeQuery();
  		response.setContentType("text/html;charset=UTF-8");
  		
  		
  		data += "<table class='table table-striped'>";
       	data += "<tr><th></th><th>Edit</th>";
       	data += "<th>Time</th>";
       	data += "<th>Schedule</th>";
       	data += "<th>Center</th>";
       	data += "<th>Trainer Name</th>";
       	data += "<th>Start Date</th>";
       	data += "<th>Delete</th>";
       	data += "</tr>";
       	
  			while(res.next())
  			{
  			   
  			data += "<tr><td></td>";
  			data += "<td><input type='radio' name='gn' id="+res.getString(1)+" onchange='demo(this.id);'></td>";
  			data += "<td>"+res.getString(2)+"</td>";
  			data += "<td>"+res.getString(3)+"</td>";
  			data += "<td>"+res.getString(4)+"</td>";
  			data += "<td>"+res.getString(5)+"</td>";
  			
  			//data += "<td>"+res.getString(6)+"</td>";
  			data += "<td>"+res.getDate(7)+"</td>";
  			data += "<td><input type='button' Text='Delete' id="+res.getString(1)+" class='btn btn-primary' value='Delete' onclick='delclass(this.id);'></td>";			
  			data += "</tr>";
  				
  			
  			}
  				
  			out.write(data);
  			//System.out.println(data);
  			
  		 }
  		 
  		 if(courseid!=null)
  		 {
  		 
  		   String op="";
  		   //System.out.println("inside courseid");
  		   PreparedStatement stmt = con.prepareStatement("select s.studentid,s.name,s.email,s.mobile,s.dob,p.name,s.language,s.db,s.class from student s,package p where ((s.language like (?) or s.language like (?) or s.language like (?)) or (s.db like (?) or s.db like (?) or s.db like (?))) and s.class not like (?) and s.class not like (?) and s.class not like (?) and s.packageid=p.pid order by studentid desc");
  		   stmt.setString(1, courseid+",%");  //id is starting
  		   stmt.setString(2, "%, "+courseid+",%"); //id in between
  		   stmt.setString(3, "%, "+courseid); //id is in the ending
  		   stmt.setString(4, courseid+",%");  
  		   stmt.setString(5, "%,"+courseid+",%");
  		   stmt.setString(6, "%,"+courseid);
  		   stmt.setString(7, cid+",%");
  		   stmt.setString(8,"%,"+cid+",%");
  		   stmt.setString(9,"%,"+cid);
  		   ResultSet rd = stmt.executeQuery();
  		   response.setContentType("text/xml;charset=UTF-8");
  		   
  		    op.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			//System.out.println(response.getContentType());
  			op += "<STUDENT>";
  		    while(rd.next())
  			{
  				op += "<STD>";
  				op += "<STID>"+rd.getString(1)+"</STID>";
  				op += "<SNAME>"+rd.getString(2)+"</SNAME>";
  				op += "<SEMAIL>"+rd.getString(3)+"</SEMAIL>";
  				op += "<SMOBILE>"+rd.getString(4)+"</SMOBILE>";  				
  				op += "<SDOB>"+rd.getString(5)+"</SDOB>";
  				op += "<SPCK>"+rd.getString(6)+"</SPCK>";
  				op += "<SLANG>"+rd.getString(7)+"</SLANG>";  				
  				op += "<SDB>"+rd.getString(8)+"</SDB>";
  				op += "<SCLASS>"+rd.getString(9)+"</SCLASS>";
  				op += "</STD>";
  			}
  			op += "</STUDENT>";
  			//System.out.println(op);
  			out.write(op);
  			return;
  		   
  		 }
  		 
  		 
  		 
  		 if(cid!=null)
  		 {
  		  
  		    ResultSet rs = null;
	  		PreparedStatement stmt = null;	  		
	  		
	  		stmt = con.prepareStatement("select c.center,t.name,c.classid,c.start_date,c.time,c.schedule from class c,trainer t where c.classid=? and c.trainerid=t.trainerid and c.end_date is null");
	  	    stmt.setString(1, cid);
	  		rs = stmt.executeQuery();
	  		response.setContentType("text/xml;charset=UTF-8");
	  		
	  		String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			//System.out.println("Hello");
  			xml += "<CLASS>";
  		    if(rs.next())
  			{
  				xml += "<CID>";
  				xml += "<CENTER>"+rs.getString(1)+"</CENTER>";
  				xml += "<TRAINER>"+rs.getString(2)+"</TRAINER>";
  				xml += "<CLASSID>"+rs.getString(3)+"</CLASSID>";
  				xml += "<SDATE>"+rs.getString(4)+"</SDATE>";  				
  				xml += "<TIME>"+rs.getString(5)+"</TIME>";
  				xml += "<SCHD>"+rs.getString(6)+"</SCHD>";
  				xml += "</CID>";
  			}
  			xml += "</CLASS>";
  			//System.out.println(xml);
  			out.write(xml);
  			return;
  		
  		 }
  		 if(VcourseID!=null)
  		 {
  		    ResultSet rs = null;
	  		PreparedStatement stmt = null;
	  		String dw = "";
	  		
	  		stmt = con.prepareStatement("select c.classid,c.time,c.schedule,c.center,t.name,c.start_date from class c,trainer t where c.courseid=? and c.trainerid=t.trainerid and c.end_date is null");
	  	    stmt.setString(1, VcourseID);
	  		rs = stmt.executeQuery();
	  		response.setContentType("text/xml;charset=UTF-8");
	  		
  			dw.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			System.out.println(response.getContentType());
  			dw += "<CLASS>";
  		    while(rs.next())
  			{
  				dw += "<VIEWCLASS>";
  				dw += "<CID>"+rs.getString(1)+"</CID>";
  				dw += "<TIME>"+rs.getString(2)+"</TIME>";
  				dw += "<SCHED>"+rs.getString(3)+"</SCHED>";
  				dw += "<CENTER>"+rs.getString(4)+"</CENTER>";  				
  				dw += "<TNAME>"+rs.getString(5)+"</TNAME>";
  				dw += "<SDATE>"+rs.getString(6)+"</SDATE>";
  				dw += "</VIEWCLASS>";
  			}
  			dw += "</CLASS>";
  			//System.out.println(dw);
  			out.write(dw);
  			return;
	  	}
  		
  		 if(center!=null)
  		 {
  		 
  		    ResultSet rs = null;
	  		PreparedStatement stmt1 = null;
	  		String dw = "";
	  		//System.out.println("center function called");
	  		stmt1 = con.prepareStatement("select c.classid,c.time,c.schedule,c.courseid,t.name,c.start_date from class c,trainer t where c.center=? and c.trainerid=t.trainerid and c.end_date is null");
	  	    stmt1.setString(1, center);
	  		rs = stmt1.executeQuery();	  		
  			response.setContentType("text/xml;charset=UTF-8");
	  		
  			dw.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			System.out.println(response.getContentType());
  			dw += "<CLASS>";
  		    while(rs.next())
  			{
  				dw += "<VIEWCLASS>";
  				dw += "<CID>"+rs.getString(1)+"</CID>";
  				dw += "<TIME>"+rs.getString(2)+"</TIME>";
  				dw += "<SCHED>"+rs.getString(3)+"</SCHED>"; 				
  				dw += "<CENTER>"+rs.getString(4)+"</CENTER>";
  				dw += "<TNAME>"+rs.getString(5)+"</TNAME>";
  				dw += "<SDATE>"+rs.getString(6)+"</SDATE>";
  				dw += "</VIEWCLASS>";
  			}
  			dw += "</CLASS>";	
  			out.write(dw);
  			//System.out.println(dw);
  		 }
  		
  		 if(tnm!=null)
  		 {
  		 
  		    ResultSet rs = null;
	  		PreparedStatement stmt1 = null;
	  		String dw = "";
	  		//System.out.println("center function called");
	  		stmt1 = con.prepareStatement("select c.classid,c.time,c.schedule,c.courseid,center,c.start_date from class c where c.trainerid=? and c.end_date is null");
	  	    stmt1.setString(1, tnm);
	  		rs = stmt1.executeQuery();	  		
  			response.setContentType("text/xml;charset=UTF-8");
	  		
  			dw.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			//System.out.println(response.getContentType());
  			dw += "<CLASS>";
  		    while(rs.next())
  			{
  				dw += "<VIEWCLASS>";
  				dw += "<CID>"+rs.getString(1)+"</CID>";
  				dw += "<TIME>"+rs.getString(2)+"</TIME>";
  				dw += "<SCHED>"+rs.getString(3)+"</SCHED>"; 				
  				dw += "<CENTER>"+rs.getString(4)+"</CENTER>";
  				dw += "<TNAME>"+rs.getString(5)+"</TNAME>";
  				dw += "<SDATE>"+rs.getString(6)+"</SDATE>";
  				dw += "</VIEWCLASS>";
  			}
  			dw += "</CLASS>";	
  			out.write(dw);
  			//System.out.println(dw);
  		 }
  		 if(vcid!=null)
  		 {
  		    ResultSet rs = null;
	  		PreparedStatement stmt = null;
	  		String dw = "";
	  		
	  		stmt = con.prepareStatement("select c.courseid,c.time,c.schedule,c.center,t.name,c.start_date from class c,trainer t where c.classid=? and c.trainerid=t.trainerid and c.end_date is null");
	  	    stmt.setString(1, vcid);
	  		rs = stmt.executeQuery();
	  		response.setContentType("text/xml;charset=UTF-8");
	  		
  			dw.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			//System.out.println(response.getContentType());
  			dw += "<CLASS>";
  		    while(rs.next())
  			{
  				dw += "<VIEWCLASS>";
  				dw += "<CID>"+rs.getString(1)+"</CID>";
  				dw += "<TIME>"+rs.getString(2)+"</TIME>";
  				dw += "<SCHED>"+rs.getString(3)+"</SCHED>";
  				dw += "<CENTER>"+rs.getString(4)+"</CENTER>";  				
  				dw += "<TNAME>"+rs.getString(5)+"</TNAME>";
  				dw += "<SDATE>"+rs.getString(6)+"</SDATE>";
  				dw += "</VIEWCLASS>";
  			}
  			dw += "</CLASS>";
  			//System.out.println(dw);
  			out.write(dw);
  			return;
	  	}
  		 else
  		 {
  		   return;
  		 }
  		 
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
  
  finally
  {
    if(con!=null)
    {
      try
      {
        con.close();
      }
      catch(Exception e)
      {
        e.printStackTrace();
      }
    }
  
  }
  
  
  
  %>