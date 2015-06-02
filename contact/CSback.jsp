<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>

  <%
       Connection con=null;
  try
  {
           con = DBInfo.getConn();
           
           
           String name = request.getParameter("name");
           String cid = request.getParameter("courseid");
           String pid = request.getParameter("packageid");
           String classid = request.getParameter("classid");
           String sdate = request.getParameter("sdate");
           String edate = request.getParameter("edate");
           String all = request.getParameter("all");
           
           
           
           if(all!=null)
           {
               
               int count=0;
               PreparedStatement ps = con.prepareStatement("select count(*) from student ");              
               ResultSet rs= ps.executeQuery();
               
               if(rs.next())
               {
                  count = rs.getInt(1);	 
               
               }
               
               
               PreparedStatement ps1 = con.prepareStatement("select * from student");
               ResultSet rs1= ps1.executeQuery();
               
               response.setContentType("text/xml;charset=UTF-8");
               String xml="";
               xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			   xml += "<QUERY>";
  			   
  			   
  			   while(rs1.next())
               {
                   	
			    xml += "<STUDENT>";
			    xml += "<ID>"+rs1.getString(1)+"</ID>";
  				xml += "<NAME>"+rs1.getString(2)+"</NAME>"; 				
  				xml += "<EMAIL>"+rs1.getString(3)+"</EMAIL>";
  				xml += "<MOBILE>"+rs1.getString(4)+"</MOBILE>";
  				xml += "<IMAGE>"+rs1.getString(18)+"</IMAGE>";
  				xml += "<COUNT>"+count+"</COUNT>";
  				xml += "</STUDENT>";
               }
  			   
               xml += "</QUERY>";	
               out.write(xml);
  			   System.out.println(xml);
  			    ps1.close();
               
                
           }
           
           
           
           if(sdate!=null && edate!=null)
           {
               
               int count=0;
               PreparedStatement ps = con.prepareStatement("select count(*) from student where substr(studentid,1,4)>=? and substr(studentid,1,4)<=?");
               ps.setString(1,sdate);
               ps.setString(2,edate);
               ResultSet rs= ps.executeQuery();
               
               if(rs.next())
               {
                  count = rs.getInt(1);	 
               
               }
               
               
               PreparedStatement ps1 = con.prepareStatement("select * from student where substr(studentid,1,4)>=? and substr(studentid,1,4)<=?");
               ps1.setString(1,sdate);
               ps1.setString(2,edate);           
               ResultSet rs1= ps1.executeQuery();
               
               response.setContentType("text/xml;charset=UTF-8");
               String xml="";
               xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			   xml += "<QUERY>";
  			   
  			   
  			   while(rs1.next())
               {
                   	
			    xml += "<STUDENT>";
			    xml += "<ID>"+rs1.getString(1)+"</ID>";
  				xml += "<NAME>"+rs1.getString(2)+"</NAME>"; 				
  				xml += "<EMAIL>"+rs1.getString(3)+"</EMAIL>";
  				xml += "<MOBILE>"+rs1.getString(4)+"</MOBILE>";
  				xml += "<IMAGE>"+rs1.getString(18)+"</IMAGE>";
  				xml += "<COUNT>"+count+"</COUNT>";
  				xml += "</STUDENT>";
               }
  			   
               xml += "</QUERY>";	
               out.write(xml);
  			   System.out.println(xml);
  			    ps1.close();
               
                
           }
           
           
            if(classid!=null)
           {
               
               int count =0;
           
               PreparedStatement ps = con.prepareStatement("select Count(*) from student where class like ? or class like ? ");
               ps.setString(1,classid+",%");
               ps.setString(2,"%,"+classid+",%");              
               ResultSet rs= ps.executeQuery();
               
               if(rs.next())
               {
                 count = rs.getInt(1);	 
               }
               
               
               PreparedStatement ps1 = con.prepareStatement("select * from student where class like ? or class like ? ");
               ps1.setString(1,classid+",%");
               ps1.setString(2,"%,"+classid+",%");             
               ResultSet rs1= ps1.executeQuery();
               
               response.setContentType("text/xml;charset=UTF-8");
               String xml="";
               xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			   xml += "<QUERY>";
  			   
  			   
  			   while(rs1.next())
               {
                   	
			    xml += "<STUDENT>";
			    xml += "<ID>"+rs1.getString(1)+"</ID>";
  				xml += "<NAME>"+rs1.getString(2)+"</NAME>"; 				
  				xml += "<EMAIL>"+rs1.getString(3)+"</EMAIL>";
  				xml += "<MOBILE>"+rs1.getString(4)+"</MOBILE>";
  				xml += "<IMAGE>"+rs1.getString(18)+"</IMAGE>";
  				xml += "<COUNT>"+count+"</COUNT>";
  				xml += "</STUDENT>";
               }
  			   
               xml += "</QUERY>";	
               out.write(xml);
  			   System.out.println(xml);
  			    ps1.close();
                
           }
           
           
           
            if(pid!=null)
           {
               
                int count=0;
               PreparedStatement ps = con.prepareStatement("select Count(*) from student where packageid like ?");
               ps.setString(1,pid);               
               ResultSet rs= ps.executeQuery();
              
               if(rs.next())
               {
                 count = rs.getInt(1);	 
               
               }
               
               PreparedStatement ps1 = con.prepareStatement("select * from student where packageid like ?");
               ps1.setString(1,pid);              
               ResultSet rs1= ps1.executeQuery();
               
               response.setContentType("text/xml;charset=UTF-8");
               String xml="";
               xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			   xml += "<QUERY>";
  			   
  			   
  			   while(rs1.next())
               {
                   	
			    xml += "<STUDENT>";
			    xml += "<ID>"+rs1.getString(1)+"</ID>";
  				xml += "<NAME>"+rs1.getString(2)+"</NAME>"; 				
  				xml += "<EMAIL>"+rs1.getString(3)+"</EMAIL>";
  				xml += "<MOBILE>"+rs1.getString(4)+"</MOBILE>";
  				xml += "<IMAGE>"+rs1.getString(18)+"</IMAGE>";
  				xml += "<COUNT>"+count+"</COUNT>";
  				xml += "</STUDENT>";
               }
  			   
               xml += "</QUERY>";	
               out.write(xml);
  			   System.out.println(xml);
  			    ps1.close();
           }
           
           
           if(cid!=null)
           {
               
               int count=0;
           
               PreparedStatement ps = con.prepareStatement("select Count(*) from student where (language like ? or language like ? or language like ?) or (db like ? or db like ? or db like ?)");
               ps.setString(1,cid+", %");
               ps.setString(2,"%, "+cid+",%");
               ps.setString(3,"% "+cid);
               ps.setString(4,cid+",%");
               ps.setString(5,"%,"+cid+",%");
               ps.setString(6,"%,"+cid);
               ResultSet rs= ps.executeQuery();
               
                if(rs.next())
               {
                    	count= rs.getInt(1);
               
               }
              
  			   ps.close();
               
               PreparedStatement ps1 = con.prepareStatement("select * from student where (language like ? or language like ? or language like ?) or (db like ? or db like ? or db like ?)");
               ps1.setString(1,cid+", %");
               ps1.setString(2,"%, "+cid+",%");
               ps1.setString(3,"% "+cid);
               ps1.setString(4,cid+",%");
               ps1.setString(5,"%,"+cid+",%");
               ps1.setString(6,"%,"+cid);
               ResultSet rs1= ps1.executeQuery();
               
               response.setContentType("text/xml;charset=UTF-8");
               String xml="";
               xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			   xml += "<QUERY>";
  			   
  			   
  			   while(rs1.next())
               {
			    xml += "<STUDENT>";
			    xml += "<ID>"+rs1.getString(1)+"</ID>";
  				xml += "<NAME>"+rs1.getString(2)+"</NAME>"; 				
  				xml += "<EMAIL>"+rs1.getString(3)+"</EMAIL>";
  				xml += "<MOBILE>"+rs1.getString(4)+"</MOBILE>";
  				xml += "<IMAGE>"+rs1.getString(18)+"</IMAGE>";
  				xml += "<COUNT>"+count+"</COUNT>";
  				xml += "</STUDENT>";
               }
  			   
               xml += "</QUERY>";	
            out.write(xml);
  			System.out.println(xml);
  			ps.close();
           } 
           
           
           if(name!=null)
           {
                 int count=0;
           
               PreparedStatement ps = con.prepareStatement("select Count(*) from student where name like ?");
               ps.setString(1,"%"+name+"%");
               ResultSet rs= ps.executeQuery();
               
                if(rs.next())
               {
                    	count= rs.getInt(1);
               
               }
           
               PreparedStatement ps1 = con.prepareStatement("select * from student where name like ?");
               ps1.setString(1,"%"+name+"%");
               ResultSet rs1= ps1.executeQuery();
               
               response.setContentType("text/xml;charset=UTF-8");
               String xml="";
               xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			   xml += "<QUERY>";
  			   
  			   
               while(rs1.next())
               {
                    
			  		
			    xml += "<STUDENT>";
			    xml += "<ID>"+rs1.getString(1)+"</ID>";
  				xml += "<NAME>"+rs1.getString(2)+"</NAME>"; 				
  				xml += "<EMAIL>"+rs1.getString(3)+"</EMAIL>";
  				xml += "<MOBILE>"+rs1.getString(4)+"</MOBILE>";
  				xml += "<IMAGE>"+rs1.getString(18)+"</IMAGE>";
  				xml += "<COUNT>"+count+"</COUNT>";
  				xml += "</STUDENT>";
               }
               
               
               
            xml += "</QUERY>";	
            out.write(xml);
  			System.out.println(xml);
  			ps.close();
           
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

