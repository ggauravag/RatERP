<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.SendMail"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection con = null;
	
	try
	{
	String type =(String)session.getAttribute("type");
	
		if(type != null && (type.equals("ADMIN") || type.equals("HELPDESK")))
		{
			
		}
		else
		{
			response.sendRedirect("../Unauthorize.jsp");
			return;
		}
	
		con = DBInfo.getConn();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Add Expenditure</title>
    <%
    SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd");
           	if(request.getParameter("add")!=null)
           	{
           		int amount = Integer.parseInt(request.getParameter("amount"));
           		String remarks = request.getParameter("remarks");
           		String date = request.getParameter("date");
           	
           	
           		java.util.Date d = format1.parse(date);
           	
           		PreparedStatement ps = con.prepareStatement("insert into expenditure values(?,?,?,?)");
           		ps.setInt(1,amount);
           		ps.setString(2, remarks);
           		ps.setDate(3, new java.sql.Date(d.getTime()));
           		ps.setString(4, (String)session.getAttribute("id"));
           		int i = ps.executeUpdate();
           		
           		session.setAttribute("op", i);
           		response.sendRedirect("AddExpenditure.jsp");
           		return;
           		
           	}
           
            %>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/bootstrap.css" type="text/css"></link>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script></head>
  </head>
  
  <body>
    <form>
     <fieldset>
           <legend><strong>&nbsp;&nbsp;Add Expenditure</strong></legend>
           
            <%
            
          if(session.getAttribute("op") != null && (Integer)session.getAttribute("op") == 0)
          {
           %>
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Something went wrong, please try again later.
   		 </div>
   		 <%
   		 session.removeAttribute("op");
   		  }
   		 	if(session.getAttribute("op") != null && (Integer)session.getAttribute("op") == 1)
   		  {
   		  %>
   		  	<div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong> Success !</strong> Expenditure has been added.
   		 	</div>
   		  <%
   		  session.removeAttribute("op");
   		  }
   		  else
   		  {
   		  
   		  }
   		   %>
           <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Expenditure Amount :</label>
           	<label style="color:red">*</label>
           <div class="col-sm-5">
           <input type="text" name="amount" class="form-control" placeholder="Enter Amount" id="amount" required="true" onkeypress="return isNumberKey(event)"  ></input>
            </div>
            </div>
            
            <div class="form-group">
		   <label for="inputEmail" class="col-sm-2 control-label" align="left">Remarks :</label> 
		   	<label style="color:red">*</label>
		   <div class="col-sm-5">  
		   <input type="text" name="remarks" class="form-control" id="inputEmail" placeholder="Enter Remarks"   required="true"  ></input>
		   </div>
			</div>
            
            <div class="form-group">	
		   <label for="inputMobile" class="col-sm-2 control-label" align="left">Date :</label> 
		   <label style="color:red">*</label>
		   <div class="col-sm-3">  
		   <input type="text" name="date" class="form-control" required="true" value="<%=format1.format( new java.util.Date())%>"></input>
		   </div>
		   </div>
		   <br>
		   <br>
		   <div class="form-group">
		   <input type="submit" name="add" value="Add Expenditure" class="btn btn-lg btn-success col-sm-offset-2">
		   </div>
		   
       </fieldset>
       
  </form>
    <script type="text/javascript">
    function isNumberKey(evt)
       {
          var charCode = (evt.which) ? evt.which : evt.keyCode;
          if (charCode != 46 && charCode > 31 
            && (charCode < 48 || charCode > 57))
             return false;

          return true;
       }
    
    </script>
  </body>
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
</html>
