<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>

  <%
       Connection con=null;
       
  try
  {
           con = DBInfo.getConn();
  
  			
  			
  		
  	    String courseid = request.getParameter("courseid");
  	 
  	    //System.out.println("Id is:"+id);
  	    //System.out.println("classid id is:"+cid);
  	    //System.out.println("action is:"+action);
  	    //System.out.println("course id is:"+courseid);
  	    
  	  
  		 
  		 if(courseid != null && courseid != "")
  		 {
  		   String op="";
  		   //System.out.println("inside courseid");
  		   PreparedStatement stmt = con.prepareStatement("select st.studentid,st.name,st.mobile,cv.name,(select certificateid from certification where studentid = st.studentid and courseid = cv.courseid) as certificate,cv.courseid from student st,cerview cv where cv.courseid = ? and (concat(replace(st.language,' ',''),',',st.db) like concat('%,',cv.courseid,',%') or concat(replace(st.language,' ',''),',',st.db) like concat(cv.courseid,',%')) order by certificate");
  		   stmt.setString(1, courseid);  //id is starting
  		 
  		   ResultSet rd = stmt.executeQuery();
  		   response.setContentType("text/xml;charset=UTF-8");
  		   
  		    op.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  		    op += "<QUERY>";
  			//System.out.println(response.getContentType());
  			
  		    while(rd.next())
  			{
  				op += "<STUDENT>";
  				op += "<SID>"+rd.getString(1)+"</SID>";
  				op += "<NAME>"+rd.getString(2)+"</NAME>";
  				op += "<MOBILE>"+rd.getString(3)+"</MOBILE>";
  				op += "<COURSE>"+rd.getString(4)+"</COURSE>";
  				op += "<CERTIFICATE>"+rd.getString(5)+"</CERTIFICATE>";
  				op += "<CID>"+rd.getString(6)+"</CID>";
  				op += "</STUDENT>";
  			}
  			op += "</QUERY>";
  			System.out.println(op);
  			out.write(op);
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