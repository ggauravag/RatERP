<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.ObjectInputStream"%>
<%@ page import="java.sql.*, com.login.*" %>
<%@page import="java.io.EOFException"%>
<%@page import="java.text.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


                      Connection con=null;
                      
                      try
                      {
                        con = DBInfo.getConn();
                      int count_admin=0;
                      int count_hd=0;
                      int count_tr=0;
                      int count_stf=0;
         PreparedStatement ps = con.prepareStatement("select * from count_user");
         ResultSet rs = ps.executeQuery();
         
         if(rs.next())
         {
             count_admin = rs.getInt("admin");
             count_hd = rs.getInt("helpdesk");
             count_tr = rs.getInt("trainer");
             count_stf = rs.getInt("staff");
         }
            
		    java.util.Date d = new java.util.Date();      
			SimpleDateFormat format = new SimpleDateFormat("yyyyMM");		
			String sid=format.format(d).substring(2);
			sid=sid+"/";	
        if(request.getParameter("Utype")!=null && request.getParameter("Ucenter")!=null && request.getParameter("empname")!=null && request.getParameter("empemail")!=null && request.getParameter("empmobile")!=null && request.getParameter("empdob")!=null )
         {
              if(request.getParameter("Utype").equalsIgnoreCase("ADM"))
              {
                  count_admin++;
                  String pass = "";
			 		String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
			 		for(int h = 0; h < 6;h++)
			 		{
			 			pass += str.charAt(new Random().nextInt(60));
			 		}
	              PreparedStatement ps1=con.prepareStatement("insert into user values(?,?,?,?,?,?,?,?,?,?,?)");
	              ps1.setString(1, sid+request.getParameter("Ucenter")+"/ADM/"+count_admin); 
	              ps1.setString(2, request.getParameter("empname"));
	              ps1.setString(3, AESCrypto.encrypt(pass));
	              ps1.setString(4, request.getParameter("empemail"));
	              ps1.setString(5, request.getParameter("empmobile"));
	              ps1.setString(6, null);
				  ps1.setString(7, null);
	              ps1.setString(8, request.getParameter("empdob"));
	              ps1.setString(9,"ADMIN");
	              ps1.setTimestamp(10, null);
			      ps1.setString(11, "Y");
	            
	               int j = ps1.executeUpdate();
	               if(j==1)
	                   System.out.println("Admin record inserted");
	                   
	                   
	          PreparedStatement ps2=con.prepareStatement("update count_user set admin=?");
              ps2.setInt(1, count_admin); 
              int l = ps2.executeUpdate();
              if(l==1)
                   System.out.println("count updated for admin");
              
              
              response.sendRedirect(basePath +"employee/AddNewEmp.jsp");
                   
              }
              
              else if(request.getParameter("Utype").equalsIgnoreCase("HLD") && request.getParameter("empsalary")!=null && request.getParameter("empadd")!=null)
              {
                  count_hd++;
	              String pass = "";
			 		String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
			 		for(int h = 0; h < 6;h++)
			 		{
			 			pass += str.charAt(new Random().nextInt(60));
			 		}
	              PreparedStatement ps1=con.prepareStatement("insert into user values(?,?,?,?,?,?,?,?,?,?,?)");
	              ps1.setString(1, sid+request.getParameter("Ucenter")+"/HLD/"+count_hd); 
	              ps1.setString(2, request.getParameter("empname"));
	              ps1.setString(3, AESCrypto.encrypt(pass));
	              ps1.setString(4, request.getParameter("empemail"));
	              ps1.setString(5, request.getParameter("empmobile"));
	              ps1.setString(6, null);
				  ps1.setString(7, null);
	              ps1.setString(8, request.getParameter("empdob"));
	              ps1.setString(9,"HELPDESK");
	              ps1.setTimestamp(10, null);
			      ps1.setString(11, "Y");
	            
	               
	            
	               int j = ps1.executeUpdate();
	               if(j==1)
	                   System.out.println("Helpdesk record inserted");
	                   
              
                  PreparedStatement ps3=con.prepareStatement("insert into staff values(?,?,?,?,?,?,?)");
	              ps3.setString(1, sid+request.getParameter("Ucenter")+"/HLD/"+count_hd); 
	              ps3.setString(2, request.getParameter("empname"));
	              ps3.setString(3, request.getParameter("empmobile"));
	              ps3.setString(4, request.getParameter("empemail"));
	              ps3.setString(5, request.getParameter("empadd"));
	              ps3.setString(6, request.getParameter("empsalary"));
	              ps3.setString(7, request.getParameter("HELPDESK"));
	              
	              int k = ps3.executeUpdate();
	               if(k==1)
	                   System.out.println("Staff table record inserted");
	                   
	                   
	              
	              PreparedStatement ps2=con.prepareStatement("update count_user set helpdesk=?");
	              ps2.setInt(1, count_hd); 
	              int l = ps2.executeUpdate();
	              if(l==1)
                   System.out.println("count updated for helpdesk");
              
                   response.sendRedirect(basePath +"employee/AddNewEmp.jsp");
              }
              
              else if(request.getParameter("Utype").equalsIgnoreCase("TRA") && request.getParameter("empsalary")!=null && request.getParameter("empadd")!=null && request.getParameter("trainqui")!=null)
              {
                  count_tr++;
	              String pass = "";
			 		String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
			 		for(int h = 0; h < 6;h++)
			 		{
			 			pass += str.charAt(new Random().nextInt(60));
			 		}
	              PreparedStatement ps1=con.prepareStatement("insert into user values(?,?,?,?,?,?,?,?,?,?,?)");
	              ps1.setString(1, sid+request.getParameter("Ucenter")+"/TRA/"+count_tr); 
	              ps1.setString(2, request.getParameter("empname"));
	              ps1.setString(3, AESCrypto.encrypt(pass));
	              ps1.setString(4, request.getParameter("empemail"));
	              ps1.setString(5, request.getParameter("empmobile"));
	              ps1.setString(6, null);
				  ps1.setString(7, null);
	              ps1.setString(8, request.getParameter("empdob"));
	              ps1.setString(9,"TRAINER");
	              ps1.setTimestamp(10, null);
			      ps1.setString(11, "Y");
	            
	               int j = ps1.executeUpdate();
	               if(j==1)
	                   System.out.println("Trainer record inserted");
	                   
              
                  PreparedStatement ps3=con.prepareStatement("insert into staff values(?,?,?,?,?,?,?)");
	              ps3.setString(1, sid+request.getParameter("Ucenter")+"/TRA/"+count_tr); 
	              ps3.setString(2, request.getParameter("empname"));
	              ps3.setString(3, request.getParameter("empmobile"));
	              ps3.setString(4, request.getParameter("empemail"));
	              ps3.setString(5, request.getParameter("empadd"));
	              ps3.setString(6, request.getParameter("empsalary"));
	              ps3.setString(7, request.getParameter("TRAINER"));
	              
	              int k = ps3.executeUpdate();
	               if(k==1)
	                   System.out.println("Staff table record inserted");
	                   
	              PreparedStatement ps5=con.prepareStatement("insert into trainer values(?,?,?,?,?,?,?,?)");
	              ps5.setString(1, sid+request.getParameter("Ucenter")+"/TRA/"+count_tr); 
	              ps5.setString(2, request.getParameter("empname"));
	              ps5.setString(3, request.getParameter("empmobile"));
	              ps5.setString(4, request.getParameter("empemail"));
	              ps5.setString(5, request.getParameter("empdob"));
	              ps5.setString(6, request.getParameter("trainqui"));
	              ps5.setString(7, request.getParameter("empsalary"));            
	              ps5.setString(8, request.getParameter("empadd"));
	              
	              int m = ps5.executeUpdate();
	               if(m==1)
	                   System.out.println("Trainer table record inserted");
	             
	             
	              
	              PreparedStatement ps2=con.prepareStatement("update count_user set trainer=?");
	              ps2.setInt(1, count_tr); 
	              int l = ps2.executeUpdate();
	              if(l==1)
                   System.out.println("count updated for trainer");
                   
                   response.sendRedirect(basePath +"employee/AddNewEmp.jsp");
              }
              
               else if(request.getParameter("Utype").equalsIgnoreCase("STAFF") && request.getParameter("empsalary")!=null && request.getParameter("empadd")!=null)
               {
               
                    count_stf++;
                      PreparedStatement ps3=con.prepareStatement("insert into staff values(?,?,?,?,?,?,?)");
		              ps3.setString(1, sid+request.getParameter("Ucenter")+"/STAFF/"+count_stf); 
		              ps3.setString(2, request.getParameter("empname"));
		              ps3.setString(3, request.getParameter("empmobile"));
		              ps3.setString(4, request.getParameter("empemail"));
		              ps3.setString(5, request.getParameter("empadd"));
		              ps3.setString(6, request.getParameter("empsalary"));
		              ps3.setString(7, request.getParameter("STAFF"));
		              
		              int k = ps3.executeUpdate();
	               if(k==1)
	                   System.out.println("Staff table record inserted");
	               
	               
	              PreparedStatement ps2=con.prepareStatement("update count_user set staff=?");
	              ps2.setInt(1, count_stf); 
	              int l = ps2.executeUpdate();
	              if(l==1)
                   System.out.println("count updated for staff");
                   
                   
	               
                    response.sendRedirect(basePath +"employee/AddNewEmp.jsp");
               }
               else
               {
               
               }
         
         }
         
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="icon" href="css/images/ratico.ico">
    <title>Add New Employee</title>
    
    
    <link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
   
    <script src="js/ie-emulation-modes-warning.js"></script>   
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript">
    function capitalize( str )
	{
	    var pieces = str.split(" ");
	    for ( var i = 0; i < pieces.length; i++ )
	    {
	        var j = pieces[i].charAt(0).toUpperCase();
	        
	        pieces[i] = j + pieces[i].substr(1).toLowerCase();
	    }
	    return pieces.join(" ");
	}
	
	function correct(inputID)
	{
		var value = document.getElementById(inputID).value;
		value = capitalize(value);
		document.getElementById(inputID).value = value;
	}
	
	
    </script>
  </head>
  
  <body>
  <form method="post" class="form-horizontal">
   
       <fieldset>
           <legend><strong>&nbsp;&nbsp;Add New Employee</strong></legend>
           
           <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Employee Name :</label>
           	<label style="color:red">*</label>
           <div class="col-sm-5">
           <input type="text" name="empname" class="form-control" placeholder="Enter Employee Name" id="inputName" required="true" onblur="correct(this.id)"></input>
            </div>
            </div>
            
            <div class="form-group">
		   <label for="inputEmail" class="col-sm-2 control-label" align="left">Email ID :</label> 
		   	<label style="color:red">*</label>
		   <div class="col-sm-5">  
		   <input type="email" name="empemail" class="form-control" id="inputEmail" placeholder="Enter Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true"  ></input>
		   </div>
			</div>
            
            <div class="form-group">	
		   <label for="inputMobile" class="col-sm-2 control-label" align="left">Mobile No. :</label> 
		   <label style="color:red">*</label>
		   <div class="col-sm-3">  
		   <input type="text" class="form-control" Maxlength="10" name="empmobile" id="inputMobile" pattern="^[7-9][0-9]{9}$" required="true"  Placeholder="Enter Mobile No."/></input>
		   </div>
		   </div>
		   
		   
		   <div class="form-group">	
		   <label for="inputDOB" class="col-sm-2 control-label" align="left">D.O.B :</label> 
		   <label style="color:red">*</label>
		   <div class="col-sm-3">  
		   <input type="date" class="form-control" name="empdob" id="inputDOB" required="true"/></input>
		   </div>
		   </div>
		   
		   <div class="form-group">
            <label for="selectCenter" class="col-sm-2 control-label" align="left">User Center :</label>
            <label style="color:red">*</label>
            <div class="col-sm-3">
           <select name="Ucenter" id="selectCenter" class="form-control">
           <option value="" selected="selected">--------Select--------</option>
           <option value="TR">TONK ROAD</option>
           <option value="PN">PRATAP NAGAR</option>
           <option value="KK">KUKAS</option>
           <option value="OT">OTHER</option>
           </select>
            </div>
           </div>
		   
		   <div class="form-group">
            <label for="selectType" class="col-sm-2 control-label" align="left">User Type :</label>
            <label style="color:red">*</label>
            <div class="col-sm-3">
           <select name="Utype" id="selectType" class="form-control" onchange="UTYPE();">
           <option value="" selected="selected">--------Select--------</option>
           <option value="ADM">ADMIN</option>
           <option value="HLD">HELPDESK</option>
           <option value="TRA">TRAINER</option>
           <option value="STAFF">STAFF</option>
           </select>
           </div>
           </div>
		   
		   <div id="fill">
		   
		   </div>
		   
		   
		   
		   <div class="form-group"> 
 		    <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" class="btn btn-primary" value="Add New >>>"/> 
 		    </div>
   		</div>
       </fieldset>
       
  </form>
  <script type="text/javascript">
  
  function UTYPE()
	{
	    var id = document.getElementById("selectType").value;
	
	     
	        if(id=="HLD")
	       {
	    
	         var data="";
	       
	         data += "<div class='form-group'>";	
		     data += "<label for='inputSalary' class='col-sm-offset-1 col-sm-2 control-label'>Salary :</label>";
		     data += "<div class='col-sm-2'>";  
		     data += "<input type='text' class='form-control' name='empsalary' id='inputSalary' Placeholder='Enter Salary'/></input>";
		     data += "</div></div>";
		     
		     
		     data += "<div class='form-group'>";	
		     data += "<label for='inputAddr' class='col-sm-offset-1 col-sm-2 control-label'>Address :</label>";
		     data += "<div class='col-sm-2'>";  
		     data += "<textarea rows='3' class='form-control' name='empadd' id='inputAddr' Placeholder='Enter Address'></textarea>";
		     data += "</div></div>";
		     
	          document.getElementById('fill').innerHTML = data;
	       } 
	       
	       else if(id=="TRA")
	       {
	    
	         var data="";
	         
	         data += "<div class='form-group'>";	
		     data += "<label for='inputQuai' class='col-sm-offset-1 col-sm-2 control-label'>Qualification :</label>";
		     data += "<div class='col-sm-2'>";  
		     data += "<input type='text' class='form-control' name='trainqui' id='inputQuai' Placeholder='Enter Qualiication'/></input>";
		     data += "</div></div>";
	         
	         
	         data += "<div class='form-group'>";	
		     data += "<label for='inputSalary' class='col-sm-offset-1 col-sm-2 control-label'>Salary :</label>";
		     data += "<div class='col-sm-2'>";  
		     data += "<input type='text' class='form-control' name='empsalary' id='inputSalary' Placeholder='Enter Salary'/></input>";
		     data += "</div></div>";
		     
		     
		     data += "<div class='form-group'>";	
		     data += "<label for='inputAddr' class='col-sm-offset-1 col-sm-2 control-label'>Address :</label>";
		     data += "<div class='col-sm-2'>";  
		     data += "<textarea rows='3' class='form-control' name='empadd' id='inputAddr' Placeholder='Enter Address'></textarea>";
		     data += "</div></div>";
		     
	          document.getElementById('fill').innerHTML = data;
	       } 
	       else if(id=="STAFF")
	       {
	    
	         var data="";
	         
	         data += "<div class='form-group'>";	
		     data += "<label for='inputSalary' class='col-sm-offset-1 col-sm-2 control-label'>Salary :</label>";
		     data += "<div class='col-sm-2'>";  
		     data += "<input type='text' class='form-control' name='empsalary' id='inputSalary' Placeholder='Enter Salary'/></input>";
		     data += "</div></div>";
		     
		     
		     data += "<div class='form-group'>";	
		     data += "<label for='inputAddr' class='col-sm-offset-1 col-sm-2 control-label'>Address :</label>";
		     data += "<div class='col-sm-2'>";  
		     data += "<textarea rows='3' class='form-control' name='empadd' id='inputAddr' Placeholder='Enter Address'></textarea>";
		     data += "</div></div>";
		     document.getElementById('fill').innerHTML = data;
	       }
	       
	       else
	       {
	          document.getElementById('fill').innerHTML = "";
	       }
	       
	       
	}
  
  </script>
  
  
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
  </body>
</html>
