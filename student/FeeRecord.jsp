<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.ObjectInputStream"%>
<%@ page import="java.sql.*, com.login.*" %>
<%@ page import="java.io.EOFException"%>
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
	
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
    <script src="js/ie-emulation-modes-warning.js"></script>   
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    
    
    <script>
    function loadName(name)
	{
	  
	var xmlhttp;
	//alert('ajax called');
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	   //alert("ajax state change : "+xmlhttp.readyState+"status is : "+xmlhttp.status);
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	     
	  //document.getElementById(divID).innerHTML=xmlhttp.responseText;
	    	//alert(xmlhttp.responseXML);
	     x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENTRECORD");
	      
	      if(x[0]==null)
	    	{
	    		//document.getElementById("message").innerHTML = "<div class='alert alert-danger'><span class='glyphicon glyphicon-remove'></span>&nbsp;Name Does not exist!</div>";	    		
	    		document.getElementById("serialNumber").value = "";
	    		document.getElementById("Image").value = "";
	    		document.getElementById("StudentID").value = "";
	    		document.getElementById("Name").value = "";
	    		document.getElementById("Email").value = "";
	    		document.getElementById("Mobile").value = "";
	    		document.getElementById("Amount").value = "";
	    		document.getElementById("Date").value = "";
	    		document.getElementById("Status").value = "";
	    		return;
	    	}
	    else
	    {
	       
	       var i=1;
	      //alert("for loop");
	      while(x[i].read())
	      {	
	    	alert("inside else");
	    	
	    	var img = x[i].getElementsByTagName("IMAGE");
	    	img = img[0].firstChild.nodeValue;
	    	
	    	var stid = x[i].getElementsByTagName("STUDENTID");
	    	stid = stid[0].firstChild.nodeValue;
	    	
	    	var name = x[i].getElementsByTagName("NAME");
	    	name = name[0].firstChild.nodeValue;
	    	
	    	var email = x[i].getElementsByTagName("EMAIL");
	    	email = email[0].firstChild.nodeValue;
	    	
	    	var mobile = x[i].getElementsByTagName("MOBILE");
	    	mobile = mobile[0].firstChild.nodeValue;
	    	
	    	var amt = x[i].getElementsByTagName("AMOUNT");
	    	amt = amt[0].firstChild.nodeValue;
	    	
	    	var date = x[i].getElementsByTagName("DATE");
	    	date = date[0].firstChild.nodeValue;
	    	
	    	var status = x[i].getElementsByTagName("STATUS");
	    	status = status[0].firstChild.nodeValue;
	       
	       
	        
	       
	    	//document.getElementById("Image").value = img;
	    	document.getElementById("StudentID").value = stid;
	    	document.getElementById("Name").value = email;	    	
	    	document.getElementById("Email").value = mobile;
	    	document.getElementById("Mobile").value = capitalize(name);
	    	document.getElementById("Amount").value = email;
	    	document.getElementById("Date").value = date;
	    	document.getElementById("status").value = date;
	    	//document.getElementById("message").innerHTML = "<div class='alert alert-success'><span class='glyphicon glyphicon-ok '></span>&nbsp;Valid Query ID !</div>";
	         i++;
	       }
	     }
	    }   
	   } 
	var path = "<%=basePath%>"+"student/searchNameDynamic.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	var data = "sname="+ name;
	xmlhttp.send(data); 
	   
    }     
        function fetchresult(inputid, e)
        {
            
        var name = document.getElementById('stname').value;
		var keynum;
              
            if(window.event)
            { // IE		
                 //alert("function called1");			
            	keynum = e.keyCode;
            }
            else
     		{
	     		if(e.which)
	     		{ // Netscape/Firefox/Opera					
	            	
	            	keynum = e.which;
	            }
            }
        keynum = String.fromCharCode(keynum);
        
		   if(name.length > 0)
		    {   
		    	//alert(name+keynum.toString());
		     	loadName(name+keynum.toString());
		    }
        }
        
        
        
        
        
         function CriteriaSelected(option)
        {
           if(option == "NAME")
           {
           var name ="";
          
           name += "<label class='col-sm-2 control-label' Id='lbl'>Enter Name :</label>";
           name += "<div Id='message' class='col-sm-3'><input type='text' class='form-control' onkeypress='fetchresult(this.id, event)' name='studentName' Id='stname'></input></div>";
      
           document.getElementById('fill').innerHTML = name;
           document.getElementById('fill').style.visibility = "visible";
           }
           else
           {
              document.getElementById('fill').style.visibility = "hidden";
           }
        } 
    </script>
  </head>
  
  <body onload="load();">
    <form method="post" class="form-horizontal" name="optionForm">
    
        <fieldset>
           <legend><strong>&nbsp;&nbsp;Fee Structure</strong></legend>
           
           <div class="form-group">
           <label for="selectCriteria" class="col-sm-2 control-label">Select Option :</label>
           <div class="col-sm-3">
           <select name="selectOption" class="form-control" onchange="CriteriaSelected(this.value);">
           <option value="" selected="selected">Select</option>
           <option value="DUE">Due Fee</option>
           <option value="NAME">Student Name</option>
           <option value="PAID">Paid Fee</option>
           </select>
           </div>
           </div>
           
           <div class="form-group" Id="fill">
           
            </div>
           
            <div class="form-group"> 
 		    <div class="col-sm-offset-3 col-sm-2"> 
 		      <input type="submit" class="btn btn-primary" value="Find Students >>>" name="feeName"/> 
 		    </div>
   		    </div>
        </fieldset>
        
        <fieldset>
       <legend><strong>&nbsp;&nbsp;Fee Structure Display</strong></legend>
       <div class="form-group" Id="displayFeeRecord">
       
       <table align="center" class="table table-striped" >
       <tr>
              <th></th>
              <th>S.No</th>
              <th>Image</th>
              <th>Student ID</th>
              <th>Name</th>
              <th>Email ID</th>
              <th>Mobile No.</th>
              <th>Amount</th>
              <th>Date</th>
              <th>Status</th>
              <th>Pay</th>
              <th>Remind</th>
              <th></th>
              
       </tr>
       <tr>
              <td></td>
              <td><label Id=""></label></td>
              <td></td>
              <td><label Id="StudentID"></label></td>
              <td><label Id="Name"></label></td>
              <td><label Id="Email"></label></td>
              <td><label Id="Mobile"></label></td>
              <td><label Id="Amount"></label></td>
              <td><label Id="Date"></label></td>
              <td><label Id="Status"></label></td>
              <td><label Id=""></label></td>
              <td><label Id=""></label></td>
              <td></td>
              
       </tr>
         <%
         
       Connection con = null;
      try
       {
       		con = DBInfo.getConn();
       
         if((request.getParameter("selectOption")!=null) && request.getParameter("selectOption")!="")
         {
              String value = request.getParameter("selectOption");           
              
              if(value.equals("NAME"))
              {
                 String stmt="Select installment.studentid,installment.inst_id,student.name,student.email,student.mobile,student.photo,installment.amount,installment.date,installment.status from installment INNER JOIN student on installment.studentid = student.studentid where student.name LIKE ? order by installment.studentid";
                 PreparedStatement ps = con.prepareStatement(stmt); 
                 ps.setString(1,"%"+request.getParameter("studentName")+"%");   
                 ResultSet rs = ps.executeQuery();
                 
                 int i=0;       
              while(rs.next())
               {
                %>
               
              <tr>
              <td></td>
              <td><%=++i%></td>
              <td><a href="javascript:window.open('student/ViewImage.jsp?IMAGE=<%=rs.getString("photo") %>','_blank','width=300,height=200,resizable=no');">View</a></td>
              <td><%=rs.getString("studentid")%></td>
              <td><%=rs.getString("name")%></td>
              <td><%=rs.getString("email")%></td>
              <td><%=rs.getString("mobile")%></td>
              <td><%=rs.getInt("amount")%></td>
              <td><%=rs.getDate("date")%></td>
              <td><%=rs.getString("status")%></td>
              <%
                if(rs.getString("status").equals("DUE"))
                {
               %>
              <td><a href="javascript:window.open('student/DepositInstallment.jsp?instid=<%=rs.getInt("inst_id")%>&stid=<%=rs.getString("studentid")%>&amt=<%=rs.getString("amount")%>','_blank','width=600');">PAY</a></td>
              <td><a href="javascript:window.open('student/SendReminder.jsp?stid=<%=rs.getString("studentid") %>&inst=<%=rs.getInt("amount") %>&date=<%=rs.getDate("date")%>','_blank','width=200');">REMIND</a></td>              
              </tr>
               <%
                }
                else
                {
                %>
                  <td></td>
                  <td></td>
                  </tr>
               <% 
                }
               }
              }
              else if(value.equals("DUE"))
              {
                 String stmt="Select installment.studentid,installment.inst_id,student.name,student.email,student.mobile,student.photo,installment.amount,installment.date,installment.status from installment INNER JOIN student on installment.studentid = student.studentid where installment.status=? order by installment.studentid";
                 PreparedStatement ps = con.prepareStatement(stmt); 
                 ps.setString(1,value);   
                 ResultSet rs = ps.executeQuery();
                 
                 int i=0;       
              while(rs.next())
              { 
              %> 
                
              <tr>
              <td></td>
              <td><%=++i%></td>
              <td><a href="javascript:window.open('student/ViewImage.jsp?IMAGE=<%=rs.getString("photo") %>','_blank','width=300,height=200,resizable=no');">View</a></td>
              <td><%=rs.getString("studentid")%></td>
              <td><%=rs.getString("name")%></td>
              <td><%=rs.getString("email")%></td>
              <td><%=rs.getString("mobile")%></td>
              <td><%=rs.getInt("amount")%></td>
              <td><%=rs.getDate("date")%></td>
              <td><%=rs.getString("status")%></td>
              <td><a href="javascript:window.open('student/DepositInstallment.jsp?instid=<%=rs.getInt("inst_id")%>&stid=<%=rs.getString("studentid")%>&amt=<%=rs.getString("amount")%>','_blank','width=600');">PAY</a></td>
              <td><a href="javascript:window.open('student/SendReminder.jsp?stid=<%=rs.getString("studentid") %>&inst=<%=rs.getInt("amount") %>&date=<%=rs.getDate("date")%>','_blank','width=200');">REMIND</a></td>              
              </tr>
         <%
              }
           }    
           else if(value.equals("PAID"))
           {
                 String stmt="Select installment.studentid,student.name,student.photo,student.email,student.mobile,installment.amount,installment.date,installment.status from installment INNER JOIN student on installment.studentid = student.studentid where installment.status=? order by installment.studentid";
                 PreparedStatement ps = con.prepareStatement(stmt); 
                 ps.setString(1,value);   
                 ResultSet rs = ps.executeQuery();
                 
                 int i=0;       
              while(rs.next())
              {
               %>
              <tr>
              <td></td>
              <td><%=++i%></td>
              <td><a href="javascript:window.open('student/ViewImage.jsp?IMAGE=<%=rs.getString("photo") %>','_blank','width=300,height=200,resizable=no');">View</a></td>
              <td><%=rs.getString("studentid")%></td>
              <td><%=rs.getString("name")%></td>
              <td><%=rs.getString("email")%></td>
              <td><%=rs.getString("mobile")%></td>
              <td><%=rs.getInt("amount")%></td>
              <td><%=rs.getDate("date")%></td>
              <td><%=rs.getString("status")%></td>
              <td></td>
              <td></td>           
              </tr>
              <% 
              }
           }    
         }
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
       </table>
       </div>    
       </fieldset>
    </form>
  </body>
</html>
