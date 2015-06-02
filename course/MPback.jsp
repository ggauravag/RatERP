<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>

  <%
       Connection con=null;
  try
  {
           con = DBInfo.getConn();
  
                String pack = request.getParameter("pack");
                String dltid = request.getParameter("dltid");
                String pid = request.getParameter("pid");
                String lang = request.getParameter("lang");
                String db = request.getParameter("db");
                String cid = request.getParameter("lid");
                String dbid = request.getParameter("dbid");
                String dltlang = request.getParameter("deletelg");
                String dltdb = request.getParameter("deletedb");
  
         if(dltid!=null)
	  	    {
	  	       
	  	       PreparedStatement ps1=con.prepareStatement("delete from package where pid=?");
	  	       ps1.setString(1, dltid);
	  	       int j = ps1.executeUpdate();
	  	       if(j==1)
	  	       {
	  	         System.out.println("Deleted successfully"); 	         
	  	       }
	  	        pack="yy";
	  	       ps1.close();
	  	    }
	  	    
	  	    if(dltlang!=null)
	  	    {
	  	       
	  	       PreparedStatement ps1=con.prepareStatement("delete from course where courseid=?");
	  	       ps1.setString(1, dltlang);
	  	       int j = ps1.executeUpdate();	  	       
	  	       if(j==1)
	  	       {
	  	         System.out.println("Deleted successfully"); 	         
	  	       }
	  	        lang="lang";
	  	       ps1.close();
	  	    }
	  	    
	  	    if(dltdb!=null)
	  	    {
	  	       
	  	       PreparedStatement ps1=con.prepareStatement("delete from dbcourse where dbid=?");
	  	       ps1.setString(1, dltdb);
	  	       int j = ps1.executeUpdate();	  	       
	  	       if(j==1)
	  	       {
	  	         System.out.println("Deleted successfully"); 	         
	  	       }
	  	        db="db";
	  	       ps1.close();
	  	    }
  
  
         if(pack!=null)
         {
                 
		  		
		  		String data = "";
		  		
		  		PreparedStatement stmt = con.prepareStatement("select * from package");
		  	    
		  		ResultSet res = stmt.executeQuery();
		  		response.setContentType("text/html;charset=UTF-8");
		  		
		  		
		  		data += "<table class='table table-striped'>";
		       	data += "<tr><th></th><th>Edit</th>";
		       	data += "<th>Fees</th>";
		       	data += "<th>Package Name</th>";
		       	data += "<th>Languages</th>";
		       	data += "<th>Databases</th>";		       		       	
       	        data += "<th>Delete</th></tr>";	
       	        
       	        
			  			while(res.next())
			  			{
			  			   
			  			data += "<tr><td></td>";
			  			data += "<td><input type='radio' name='gn' id="+res.getInt(1)+" onchange='demo(this.id);'></td>";
			  			data += "<td>"+res.getInt(2)+"</td>";
			  			data += "<td>"+res.getString(3)+"</td>";
			  			data += "<td>"+res.getInt(4)+"</td>";
			  			data += "<td>"+res.getInt(5)+"</td>";
			  			data += "<td><input type='button' Text='Delete' id="+res.getInt(1)+" class='btn btn-primary' value='Delete' onclick='delpack(this.id);'></td>";			
			  			data += "</tr>";
  				
  			
  			}
  				
  			out.write(data);
  			//System.out.println(data);
  			stmt.close();
         }
  
  
	  
	  	 if(pid!=null)
  		 {
  		  
  		    ResultSet rs = null;
	  		PreparedStatement stmt = null;	  		
	  		
	  		stmt = con.prepareStatement("select * from package where pid=?");
	  	    stmt.setString(1, pid);
	  		rs = stmt.executeQuery();
	  		response.setContentType("text/xml;charset=UTF-8");
	  		
	  		String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			//System.out.println("Hello");
  			xml += "<PACK>";
  		    if(rs.next())
  			{
  				xml += "<SPACK>";
  				xml += "<PID>"+rs.getInt(1)+"</PID>";
  				xml += "<FEE>"+rs.getInt(2)+"</FEE>";
  				xml += "<NAME>"+rs.getString(3)+"</NAME>";
  				xml += "<LANG>"+rs.getInt(4)+"</LANG>";  				
  				xml += "<DB>"+rs.getInt(5)+"</DB>"; 				
  				xml += "</SPACK>";
  			}
  			xml += "</PACK>";
  			//System.out.println(xml);
  			out.write(xml);
  			return;
  		
  		 }   
	  
	  
	   if(lang!=null)
         {
                 
		  		
		  		String data = "";
		  		
		  		PreparedStatement stmt = con.prepareStatement("select * from course");
		  	    
		  		ResultSet res = stmt.executeQuery();
		  		response.setContentType("text/html;charset=UTF-8");
		  		
		  		
		  		data += "<table class='table table-striped'>";
		       	data += "<tr><th></th><th>Edit</th>";
		       	data += "<th>Course Name</th>";
		       	data += "<th>Course Fee</th>";
		       	data += "<th>Duration</th>";
		       	data += "<th>Study Material</th>";		       	       		       	
       	        data += "<th>Delete</th></tr>";	
       	        
       	        
			  			while(res.next())
			  			{
			  			   
			  			data += "<tr><td></td>";
			  			data += "<td><input type='radio' name='gn' id="+res.getInt(1)+" onchange='demo(this.id);'></td>";
			  			data += "<td>"+res.getString(2)+"</td>";
			  			data += "<td>"+res.getInt(3)+"</td>";
			  			data += "<td>"+res.getInt(4)+"</td>";
			  			data += "<td>"+res.getInt(5)+"</td>";
			  			data += "<td><input type='button' Text='Delete' id="+res.getInt(1)+" class='btn btn-primary' value='Delete' onclick='dellang(this.id);'></td>";			
			  			data += "</tr>";
  				
  			
  			}
  				
  			out.write(data);
  			//System.out.println(data);
  			stmt.close();
         }
  
  
      
       if(db!=null)
         {
                 
		  		
		  		String data = "";
		  		
		  		PreparedStatement stmt = con.prepareStatement("select * from dbcourse");
		  	    
		  		ResultSet res = stmt.executeQuery();
		  		response.setContentType("text/html;charset=UTF-8");
		  		
		  		
		  		data += "<table class='table table-striped'>";
		       	data += "<tr><th></th><th>Edit</th>";
		       	data += "<th>Course Name</th>";
		       	data += "<th>Duration</th>";
		       	data += "<th>Course Fee</th>";
		       	data += "<th>Study Material</th>";		       	       		       	
       	        data += "<th>Delete</th></tr>";	
       	        
       	        
			  			while(res.next())
			  			{
			  			   
			  			data += "<tr><td></td>";
			  			data += "<td><input type='radio' name='gn' id="+res.getInt(1)+" onchange='demodb(this.id);'></td>";
			  			data += "<td>"+res.getString(2)+"</td>";
			  			data += "<td>"+res.getInt(3)+"</td>";
			  			data += "<td>"+res.getInt(4)+"</td>";
			  			data += "<td>"+res.getInt(5)+"</td>";
			  			data += "<td><input type='button' Text='Delete' id="+res.getInt(1)+" class='btn btn-primary' value='Delete' onclick='deldb(this.id);'></td>";			
			  			data += "</tr>";
  				
  			
  			}
  				
  			out.write(data);
  			//System.out.println(data);
  			stmt.close();
         }
         
         if(cid!=null)
  		 {
  		  
  		    ResultSet rs = null;
	  		PreparedStatement stmt = null;	  		
	  		
	  		stmt = con.prepareStatement("select * from course where courseid=?");
	  	    stmt.setString(1, cid);
	  		rs = stmt.executeQuery();
	  		response.setContentType("text/xml;charset=UTF-8");
	  		
	  		String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			//System.out.println("Hello");
  			xml += "<LANG>";
  		    if(rs.next())
  			{
  				xml += "<COURSE>";
  				xml += "<CID>"+rs.getInt(1)+"</CID>";
  				xml += "<NAME>"+rs.getString(2)+"</NAME>";
  				xml += "<FEE>"+rs.getInt(3)+"</FEE>";
  				xml += "<DUR>"+rs.getInt(4)+"</DUR>";  				 				
  				xml += "</COURSE>";
  			}
  			xml += "</LANG>";
  			System.out.println(xml);
  			out.write(xml);
  			return;
  		
  		 }  
  		 
  		 if(dbid!=null)
  		 {
  		  
  		    ResultSet rs = null;
	  		PreparedStatement stmt = null;	  		
	  		
	  		stmt = con.prepareStatement("select * from dbcourse where dbid=?");
	  	    stmt.setString(1, dbid);
	  		rs = stmt.executeQuery();
	  		response.setContentType("text/xml;charset=UTF-8");
	  		
	  		String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			
  			xml += "<DB>";
  		    if(rs.next())
  			{
  				xml += "<DBCOURSE>";
  				xml += "<DBID>"+rs.getInt(1)+"</DBID>";
  				xml += "<DBNAME>"+rs.getString(2)+"</DBNAME>";
  				xml += "<DBDUR>"+rs.getInt(3)+"</DBDUR>";
  				xml += "<DBFEE>"+rs.getInt(4)+"</DBFEE>";  				 				
  				xml += "</DBCOURSE>";
  			}
  			xml += "</DB>";
  			System.out.println(xml);
  			out.write(xml);
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