<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.ObjectInputStream"%>
<%@ page import="java.sql.*, com.login.*" %>
<%@page import="java.io.EOFException"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Student student[] = null;
String check = null;

	HttpSession session1 = request.getSession(false);
	 if(session1 == null)
	 {
	 	response.sendRedirect("Unauthorize.jsp");
	 	return;
	 }
	 else
	 {
	 	String type=(String)session1.getAttribute("type");
	 	String name = (String)session1.getAttribute("name");
	 	System.out.println(type+":"+name);
	 	if(type==null)
	 	{
	 		response.sendRedirect("Unauthorize.jsp");
	 		return;
	 	}	
	 }
	
	
	
	
	
	
	if(request.getParameter("print")!=null)
	{
		String [] select = request.getParameterValues("selectStudent");
		session.setAttribute("select", select);
		check = "open";
		
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="icon" href="css/images/ratico.ico">
    <title>RAT Panel</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
    <link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
    <script src="js/ie-emulation-modes-warning.js"></script>   
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    <script>
    	<%
    		if(check!=null && check.equals("open"))
    		{
    				%>
    				
    				window.open("student/PrintID.jsp", "_blank", "width=600", false);
    				<%
    		
    		}
    	%>
    	
    </script>
  </head>
  
  <body onload="load();">
   <form method="post" class="form-horizontal" name="optionForm">
   
       <fieldset>
           <legend><strong>&nbsp;&nbsp;Issue ID Card To Student</strong></legend>
           
           <div class="form-group">
           <label for="selectCriteria" class="col-sm-2 control-label" align="left">Select Criteria :</label>
           <div class="col-sm-2">
           <select name="selectCriteria" onchange="values(this.value);" class="form-control">
           <option value="" selected="selected">Select</option>
           <option value="1">Packages</option>
           <option value="2">Courses</option>
           <option value="3">Database Course</option>
           <option value="4">Student ID</option>
           <option value="5">Name</option>
           </select>
            </div>
             </div>
                
                
             <div class="form-group" Id="fill">  
                               
                  
            </div>
            
        <div class="form-group"> 
 		    <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" class="btn btn-primary" value="Find Students >>>" name="issueID"/> 
 		    </div>
   		</div> 
            
       </fieldset>
       
       
       
       
       <fieldset>
       <legend><strong>&nbsp;&nbsp;Check Student Details</strong></legend>
       <div class="form-group" Id="displayRecord">
       
       <table class="table table-striped col-sm-11" >
       <tr>
             <th></th>
              <th>Select</th>
              <th>Name</th>
              <th>Student ID</th>
              <th>Email ID</th>
              <th>Mobile No.</th>
              <th>F.Name</th>
              <th>Languages</th>
              <th>Databases</th>
              <th>Package ID</th>
       </tr>
       <%
       
       Connection con = null;
       try
       {
       
       
       
      con = DBInfo.getConn();
      try
       {
         if((request.getParameter("selectPackage")!=null) && (!request.getParameter("selectPackage").equals("")))
         {
              int packid = Integer.valueOf(request.getParameter("selectPackage"));              
              PreparedStatement ps = con.prepareStatement("select * from student where packageid=?");    
              ps.setInt(1,packid);  
              ResultSet rs = ps.executeQuery();
              int row = 0;
              if(rs.last())
              {
              	row = rs.getRow();
              	rs.beforeFirst();
              }
              student = new Student[row];  
              row = 0;
             %>
            
             <% 
              while(rs.next())
              {
              	  student[row] = new Student(rs.getString(1));
              	  if(student[row].fetchRecord() && student[row].calculateFees())
              	  	{
              	       
              %> 
              
              <tr>
              <td></td>
              <td><input type="checkbox" name="selectStudent" value="<%=row%>"></input></td>
              <td><%=student[row].getName()%></td>
              <td><%=student[row].getSid()%></td>
              <td><%=student[row].getEmail()%></td>
              <td><%=student[row].getMobile()%></td>
              <td><%=student[row].getFatherName()%></td>
              <td><%=student[row].getLanguage() %></td>
              <td><%=student[row].getDatabase() %></td>
              <td><%=student[row].getPackageName() %></td>
              
              </tr>
         <%		     }
         			row++;
              }
              session.setAttribute("students",student);
         } 
         
         else if((request.getParameter("selectCourse")!=null) && (!request.getParameter("selectCourse").equals("")))
         {
              PreparedStatement ps = con.prepareStatement("select * from student where language like '%"+request.getParameter("selectCourse")+"%'");    
             
              ResultSet rs = ps.executeQuery();
              
              int row = 0;
              if(rs.last())
              {
              	row = rs.getRow();
              	rs.beforeFirst();
              }
              student = new Student[row];  
              row = 0;
              
              while(rs.next())
              {
              	  student[row] = new Student(rs.getString(1));
              	  if(student[row].fetchRecord() && student[row].calculateFees())
              	  	{
                %>
           
                  
              <tr>
              <td></td>
              <td><input type="checkbox" name="selectStudent" value="<%=row%>"></input></td>
              <td><%=student[row].getName()%></td>
              <td><%=student[row].getSid()%></td>
              <td><%=student[row].getEmail()%></td>
              <td><%=student[row].getMobile()%></td>
              <td><%=student[row].getFatherName()%></td>
              <td><%=student[row].getLanguage() %></td>
              <td><%=student[row].getDatabase() %></td>
              <td><%=student[row].getPackageName() %></td>
              
              </tr>
              
           <% }
           		row++;
             }//End of while
             session.setAttribute("students",student);
              
          } // End of elseif
    
          else if((request.getParameter("selectDBcourse")!=null) && (!request.getParameter("selectDBcourse").equals("")))
          {
              PreparedStatement ps = con.prepareStatement("select * from student where db like '%"+request.getParameter("selectDBcourse")+"%'");    
              System.out.println("The parameter is : "+request.getParameter("selectDBcourse"));
              //ps.setString(1,request.getParameter("selectDBcourse"));  
              ResultSet rs = ps.executeQuery();
              
             int row = 0;
              if(rs.last())
              {
              	row = rs.getRow();
              	rs.beforeFirst();
              }
              student = new Student[row];  
              row = 0;
              
              while(rs.next())
              {
              	  student[row] = new Student(rs.getString(1));
              	  if(student[row].fetchRecord() && student[row].calculateFees())
              	  	{
                %>
              
                  
              <tr>
              <td></td>
             <td><input type="checkbox" name="selectStudent" value="<%=row%>"></input></td>
              <td><%=student[row].getName()%></td>
              <td><%=student[row].getSid()%></td>
              <td><%=student[row].getEmail()%></td>
              <td><%=student[row].getMobile()%></td>
              <td><%=student[row].getFatherName()%></td>
              <td><%=student[row].getLanguage() %></td>
              <td><%=student[row].getDatabase() %></td>
              <td><%=student[row].getPackageName() %></td>
              
              </tr>
          <%	}
          		row++;
             }
             session.setAttribute("students",student);
             
         }    
       
        else if((request.getParameter("studentName")!=null) && (!request.getParameter("studentName").equals("")))
          {
              PreparedStatement ps = con.prepareStatement("select * from student where name like '%"+request.getParameter("studentName")+"%'");    
                
              ResultSet rs = ps.executeQuery();
              int row = 0;
              if(rs.last())
              {
              	row = rs.getRow();
              	rs.beforeFirst();
              }
              student = new Student[row];  
              row = 0;
              
              while(rs.next())
              {
              	  student[row] = new Student(rs.getString(1));
              	  if(student[row].fetchRecord() && student[row].calculateFees())
              	  	{
                %>
              
                  
              <tr>
              <td></td>
              <td><input type="checkbox" name="selectStudent" value="<%=row%>"></input></td>
              <td><%=student[row].getName()%></td>
              <td><%=student[row].getSid()%></td>
              <td><%=student[row].getEmail()%></td>
              <td><%=student[row].getMobile()%></td>
              <td><%=student[row].getFatherName()%></td>
              <td><%=student[row].getLanguage() %></td>
              <td><%=student[row].getDatabase() %></td>
              <td><%=student[row].getPackageName() %></td>
              
              </tr>
          <%	}
          		row++;
             }
             session.setAttribute("students",student);
             
          }
          
       else if((request.getParameter("text1")!=null) && (request.getParameter("text4")!=null) && (!request.getParameter("text1").equals("")) && (!request.getParameter("text4").equals("")))
          {
          
              String text = request.getParameter("text1")+"/"+request.getParameter("text2")+"/"+request.getParameter("text3")+"/"+request.getParameter("text4");
              System.out.println("The text is : "+text);
              PreparedStatement ps = con.prepareStatement("select * from student where studentid=?");    
              ps.setString(1,text);  
              ResultSet rs = ps.executeQuery();
              int row = 0;
              if(rs.last())
              {
              	row = rs.getRow();
              	rs.beforeFirst();
              }
              student = new Student[row];  
              row = 0;
              
              while(rs.next())
              {
              	  student[row] = new Student(rs.getString(1));
              	  if(student[row].fetchRecord() && student[row].calculateFees())
              	  	{
                %>
              
                  
              <tr>
              <td></td>
              <td><input type="checkbox" name="selectStudent" value="<%=row%>"></input></td>
              <td><%=student[row].getName()%></td>
              <td><%=student[row].getSid()%></td>
              <td><%=student[row].getEmail()%></td>
              <td><%=student[row].getMobile()%></td>
              <td><%=student[row].getFatherName()%></td>
              <td><%=student[row].getLanguage() %></td>
              <td><%=student[row].getDatabase() %></td>
              <td><%=student[row].getPackageName() %></td>
              
              </tr>
          <%	}
          		row++;
             }
             session.setAttribute("students",student);
             
          }
           
       }//End of Try
       
       catch(Exception e)
       {
       
       e.printStackTrace();
       
       }   
          %>
         
       </table>
       </div>
       </fieldset>
       <div class="form-group ">
       <input type="submit" name="print"  class="btn btn-success col-sm-offset-5" value="Generate I-Card">
       </div>
   </form>
   
   <script type="text/javascript">
   
   function checkStudent(e)
   {
   		alert("Function called");
   		var cbox = document.optionForm.selectStudent;
   		alert("Checkbox : "+cbox.value);
   		if(cbox.value == "")
   		{
   			alert("No Student Selected");
   			e.preventDefault();
   		}
   
   }
   
   
   function load()
   {
     
    //document.getElementById('val').style.visibility = "hidden";
    //document.getElementById('displayRecord').style.visibility = "hidden";
    
   }  
   
   function values(Criteria)
   {
      
     
      if(Criteria == "" || Criteria == null)
      {
        document.getElementById('displayRecord').style.visibility = "hidden";
      }
            
      if(Criteria == "1")
      { 
         
     var pack = "";
     pack += "<label class='col-sm-2 control-label' Id='lbl'>Select Package :</label>";
       <%
         try
         {
               String stmt = "Select * from package";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
        %>        
         pack +=  "<div class='col-sm-2'><select name='selectPackage' class='form-control' Id='packageid'>";   
                
           <% 
             while(rs.next())
               {              
            %>
           pack += "<option value='<%=String.valueOf(rs.getInt(1))%>'><%=rs.getString(3)%></option>";           
           <%
               }   
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
          pack +=  "</select></div>";
               
        document.getElementById('fill').innerHTML = pack;
                
      }
      
      if(Criteria == "2")
      { 
         
          var cour = "";
          cour += "<label class='col-sm-2 control-label' Id='lbl'>Select Course :</label>";
       <%
          try
            {            
               String stmt = "Select * from course";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
        %>        
         cour +=  "<div class='col-sm-2'><select name='selectCourse' class='form-control' Id='courseid'>";   
                
           <% 
             while(rs.next())
               {              
            %>
         cour += "<option value='<%=rs.getString(1)%>'><%=rs.getString(2) %></option>";           
           <%
               }   
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
         cour +=  "</select></div>";
               
        document.getElementById('fill').innerHTML = cour;
                
      }
     
      if(Criteria == "3")
      { 
         
          var db = "";
          db += "<label class='col-sm-2 control-label' Id='lbl'>Select DataBase :</label>";
       <%
          try
            {
            
               String stmt = "Select * from dbcourse";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
        %>        
         db +=  "<div class='col-sm-2'><select name='selectDBcourse' class='form-control' Id='dbcourseid'>";   
                
           <% 
             while(rs.next())
               {              
            %>
         db += "<option value='<%=rs.getString(1)%>'><%=rs.getString(2) %></option>";           
           <%
               }   
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
         db +=  "</select></div>";
               
        document.getElementById('fill').innerHTML = db;
                
      }
      
      if(Criteria == "4")
      {
         var ID = "";
         
        
        ID += "<label class='col-sm-2 control-label' Id='lbl'>Enter Student ID :</label>";
        ID +=  "<div class='col-sm-1'><input type='text' name='text1' Id='val1' class='form-control' required='true'></input></div>";
        ID +=  "<div class='col-sm-1'><select name='text2' class='form-control' Id='val2'><option value='TR'>Tonk Road</option><option value='PN'>Pratap Nagar</option><option value='KK'>Kukas</option><option value='OT'>Other</option></select></div>";
        ID +=  "<div class='col-sm-1'><input type='text' name='text3' Id='val3' class='form-control' value='STU' readonly='true'></input></div>";
		ID +=  "<div class='col-sm-1'><input type='text' name='text4' Id='val4' class='form-control' Maxlength='5'></input></div>";
		
         
         document.getElementById('fill').innerHTML = ID;
      }
      
      if(Criteria == "5")
      {
         var name ="";
         name += "<label class='col-sm-2 control-label' Id='lbl'>Enter Name :</label>";
         name += "<div class='col-sm-2'><input type='text' class='form-control' name='studentName' Id='stname'></input></div>";
      
           document.getElementById('fill').innerHTML = name;
      }
   }
   
   <%
   	}
       		catch(Exception e)
       		{
       			e.printStackTrace();
       			response.sendRedirect("Error.jsp");
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
  
   </script>
  </body>
</html>
