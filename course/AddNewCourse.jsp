<%@page import="com.sun.mail.iap.Response"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="com.login.SendMail"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*,java.text.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String type = (String)session.getAttribute("type");
	if(type != null && (type.equals("ADMIN") || type.equals("HELPDESK")))
	{
		
	}
	else
	{
		response.sendRedirect("Unauthorize.jsp");
		return;
	}

                       Connection con = null;
         
     try
     {
         con = DBInfo.getConn();
         int count_lang=0;
         int count_db =0;
         int count_sm=0;
         PreparedStatement ps = con.prepareStatement("select * from count_user");
         ResultSet rs = ps.executeQuery();
         
         if(rs.next())
         {
             count_lang = rs.getInt("count_lang");
             count_db = rs.getInt("count_db");
             count_sm = rs.getInt("sm");
         }
         
         
         if(request.getParameter("selectCriteria")!=null && request.getParameter("Cname")!=null && request.getParameter("fee")!=null && request.getParameter("selectduration")!=null && request.getParameter("selectmodule")!=null )
         {
            int mod = Integer.parseInt(request.getParameter("selectmodule"));
              
             
         
             if(request.getParameter("selectCriteria").equalsIgnoreCase("Language"))
             {
               
              PreparedStatement ps1=con.prepareStatement("insert into course values(?,?,?,?,?,?)");
              ps1.setInt(1, count_lang); 
              ps1.setString(2, request.getParameter("Cname"));
              ps1.setInt(3, Integer.parseInt(request.getParameter("fee")));
              ps1.setString(4, request.getParameter("selectduration"));
              ps1.setInt(5, mod);
              ps1.setString(6, null);
              int j = ps1.executeUpdate();
              System.out.println("language inserted");
              
              
              for(int i=1;i<=mod;i++)
              {
                  PreparedStatement ps3 = con.prepareStatement("insert into studymaterial values(?,?,?,?)");
                  ps3.setInt(1, count_sm++);
                  ps3.setString(2, "Module"+i);
                  ps3.setString(3, request.getParameter("mod"+i));
                  ps3.setInt(4, count_lang);
                  ps3.executeUpdate();
              }
              System.out.println("module inserted");
              
              PreparedStatement ps4=con.prepareStatement("update count_user set sm=?");
              ps4.setInt(1, count_sm); 
              int l = ps4.executeUpdate();
              System.out.println("count updated for study material");
              
              count_lang++;
              PreparedStatement ps2=con.prepareStatement("update count_user set count_lang=?");
              ps2.setInt(1, count_lang); 
              int k = ps2.executeUpdate();
              System.out.println("count updated for language");
              
              if(j==1 && k==1)
              {               
                
                response.sendRedirect(basePath +"course/AddNewCourse.jsp?up=d");
                
              }
              else
              {
               response.sendRedirect(basePath +"course/AddNewCourse.jsp?no=d");
              }
             }
             else
             {
              PreparedStatement ps1=con.prepareStatement("insert into dbcourse values(?,?,?,?,?,?)");
              ps1.setInt(1, count_db); 
              ps1.setString(2, request.getParameter("Cname"));
              ps1.setInt(3, Integer.parseInt(request.getParameter("fee")));
              ps1.setString(4, request.getParameter("selectduration"));
              ps1.setInt(5, mod);
              ps1.setString(6, null);
              int j = ps1.executeUpdate();
              System.out.println("Database inserted");
              
              for(int i=1;i<=mod;i++)
              {
                  PreparedStatement ps3 = con.prepareStatement("insert into studymaterial values(?,?,?,?)");
                  ps3.setInt(1, count_sm++);
                  ps3.setString(2, "Module"+i);
                  ps3.setString(3, request.getParameter("mod"+i));
                  ps3.setInt(4, count_db);
                  ps3.executeUpdate();
              }
              System.out.println("module inserted");
              
              PreparedStatement ps4=con.prepareStatement("update count_user set sm=?");
              ps4.setInt(1, count_sm); 
              int l = ps4.executeUpdate();
              System.out.println("count updated for study material");
              
              
              count_db++;
              PreparedStatement ps2=con.prepareStatement("update count_user set count_db=?");
              ps2.setInt(1, count_db); 
              int k = ps2.executeUpdate();
              System.out.println("count updated for database");
              
              
              
              if(j==1 && k==1)
              {
                response.sendRedirect(basePath +"course/AddNewCourse.jsp?up=d");
              }
              else
              {
               response.sendRedirect(basePath +"course/AddNewCourse.jsp?no=d");
              }
             
             }
         
         }
         
         

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Add New Course</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="css/images/ratico.ico">
    
    <script type="text/javascript">
    
    
    function showmod(num)
    {
    //alert("function called");
       var display="";
         for(var i=1;i<=num;i++)
         {
                display += "";
                display += "<div class='form-group'>";
                display += "<label class='col-sm-3 control-label' Id='lbl'>Enter Remarks(Module "+i+") :</label>";
                display += "<div class='col-sm-4'><input type='text' name='mod"+i+"' Id='module"+i+"' class='form-control'></input></div>";
                display += "</div>";
         }
    
        
       document.getElementById("fill").innerHTML = display;
       
    }
   
    </script>

  </head>
  
  <body>
     <form method="post" class="form-horizontal">
    
          <fieldset>
          <legend><h1><strong>&nbsp;Add New Course</strong></h1></legend>
          
          
          
           <%
           if (request.getParameter("up")!=null)
        {
            %>

    <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Course added.
   		 </div>

            <%
            
            
        }
        
        
         %> 
         <%
           if (request.getParameter("no")!=null)
        {
            %>

    <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Could not add new course, please try again.
   		 </div>

            <%
            
            
        }
        
        
         %> 
          
          
          
          
          <div class="form-group">
           <label for="selectCriteria" class="col-sm-2 control-label" align="left">Select Course type :</label>
           <div class="col-sm-3">
           <select name="selectCriteria" id="selectCriteria" class="form-control">
           <option value="" selected="selected">Select</option>
           <option value="Language">Language</option>
           <option value="Database">Database</option>                  
           </select>
           </div>
           </div>
           
           
          <div class="form-group">
          <label class="col-sm-2 control-label" Id="lbl">Enter Course Name :</label>
          <div class="col-sm-5"><input type="text" name="Cname" Id="Course" class="form-control"></input>
          </div>
          </div>
       
           
         <div class="form-group">
        <label class="col-sm-2 control-label" Id="lbl">Enter Fees :</label>
       <div class="col-sm-5"><input type="text" name="fee" Id="Cfee" class="form-control"></input>
       </div>
       </div>
         
         
         <div class="form-group">
        <label class="col-sm-2 control-label" Id="lbl">Select Duration(in months) :</label>
        <div class="col-sm-5"><select name="selectduration" class="form-control" Id="duration">
        <option value="" selected="selected">select</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
        </select>
        </div>
        </div>
         
         
         
        <div class="form-group">
        <label class="col-sm-2 control-label" Id="lbl">Select Number of Modules :</label>
        <div class="col-sm-5"><select name="selectmodule" class="form-control" Id="module" onchange="showmod(this.value);">
        <option value="" selected="selected">select</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
        </select>
        </div>
        </div>
         
         <div id="fill">
         
         </div>
         
         
                   <div class="col-sm-offset-3">
				   <input type="submit" name="add" class="btn-lg btn-success" value="Add Course" >
				   </div>
         
         
          </fieldset>
          
     <%
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
       
        %>
     </form>
  </body>
</html>
