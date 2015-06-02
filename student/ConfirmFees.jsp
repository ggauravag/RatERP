<%@page import="java.sql.ResultSet"%>
<%@page import="com.login.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Connection con = null;
	String name = request.getParameter("stname");
	String fname = request.getParameter("stfname");
	String email = request.getParameter("stemail");
	String per_address = request.getParameter("stpadd");
	String parent_mobile = request.getParameter("stpmobile");
	String mobile = request.getParameter("stmobile");
	String local_address = request.getParameter("stladd");
	String id = (String)session.getAttribute("newid");
	
	
	try
	{
	
	con = DBInfo.getConn();
	
	if(request.getParameter("paid")!=null)
	{
		session.removeAttribute("newid");
	
		response.sendRedirect("registrationstudent.jsp");
	
	}
	
	
	if(name!=null)
	{
		PreparedStatement ps = con.prepareStatement("UPDATE student AS t1 JOIN user AS t2 ON t1.studentid = t2.userid SET t1.name = ?, t2.name = ? WHERE t1.studentid = ?"); 
		ps.setString(1, name);
		ps.setString(2, name);
		ps.setString(3, id);
		System.out.println("The name updated : "+ps.executeUpdate());;
	}
	if(fname!=null)
	{
		PreparedStatement ps = con.prepareStatement("UPDATE student AS t1 SET t1.f_name = ? WHERE t1.studentid = ?"); 
		ps.setString(1, fname);
	
		ps.setString(2, id);
		System.out.println("The father name updated : "+ps.executeUpdate());
	}
	if(email!=null)
	{
		PreparedStatement ps = con.prepareStatement("UPDATE student AS t1 JOIN user AS t2 ON t1.studentid = t2.userid SET t1.email = ?, t2.email = ? WHERE t1.studentid = ?"); 
		ps.setString(1, email);
		ps.setString(2, email);
		ps.setString(3, id);
		System.out.println("The email updated : "+ps.executeUpdate());;
	}
	if(per_address!=null)
	{
		PreparedStatement ps = con.prepareStatement("UPDATE student AS t1 SET t1.paddress = ? WHERE t1.studentid = ?"); 
		ps.setString(1, per_address);
	
		ps.setString(2, id);
		System.out.println("The permanent address updated : "+ps.executeUpdate());
	}
	
	if(parent_mobile!=null)
	{
		PreparedStatement ps = con.prepareStatement("UPDATE student AS t1 SET t1.parent_mob = ? WHERE t1.studentid = ?"); 
		ps.setString(1, parent_mobile);
	
		ps.setString(2, id);
		System.out.println("The parent mobile updated : "+ps.executeUpdate());
	}
	if(mobile!=null)
	{
		PreparedStatement ps = con.prepareStatement("UPDATE student AS t1 JOIN user AS t2 ON t1.studentid = t2.userid SET t1.mobile = ?, t2.mobile = ? WHERE t1.studentid = ?"); 
		ps.setString(1, mobile);
		ps.setString(2, mobile);
		ps.setString(3, id);
		System.out.println("The mobile updated : "+ps.executeUpdate());;
	}
	if(local_address!=null)
	{
		PreparedStatement ps = con.prepareStatement("UPDATE student AS t1 SET t1.laddress = ? WHERE t1.studentid = ?"); 
		ps.setString(1, local_address);
	
		ps.setString(2, id);
		System.out.println("The local address updated : "+ps.executeUpdate());
	}
	
	
	Student stu = null;

	
	if(id!=null)
	{
	
	 	stu = new Student(id);
	 	
		if(stu.fetchRecord() && stu.calculateFees())
		{
			System.out.println("Student record fetched");
			session.setAttribute("object", stu);
			
		}
		else
		{
			System.out.println("Unable to fetch student with id : "+id);
			response.sendRedirect("registrationstudent.jsp");
		
		}
	}
	else
	{

		response.sendRedirect("UploadPic.jsp");
	}
	
	
	
	
	
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <link rel="stylesheet" href="../css/bootstrap.css" type="text/css"></link>
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
  <script type="text/javascript" src="../js/bootstrap.js"></script></head>
  <script>
  function validate(evt) {
  var theEvent = evt || window.event;
  var key = theEvent.keyCode || theEvent.which;
  key = String.fromCharCode( key );
  var regex = /[0-9]|\./;
  if( !regex.test(key) ) {
    theEvent.returnValue = false;
    if(theEvent.preventDefault) theEvent.preventDefault();
  }
}
var balance = 0;


function nextMonth(){
var thisMonth = this.getMonth();
this.setMonth(thisMonth+1);
if(this.getMonth() != thisMonth+1 && this.getMonth() != 0)
this.setDate(0);
}
 
Date.prototype.nextMonth = nextMonth;
Date.prototype.prevMonth = prevMonth;


function getdate(add)
{
	var today = new Date();
   
	
	if(add == 1)
	{
		today.nextMonth();
	}
	if(add == 2)
	{
		today.nextMonth();
		today.nextMonth();
	}
	if(add == 3)
	{
		today.nextMonth();
		today.nextMonth();
		today.nextMonth();
	}
	
	 var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

    //alert("Month is : "+mm);
        if(dd<10){dd='0'+dd} if(mm<10){mm='0'+mm} var today = yyyy+"-"+mm+"-"+dd;
   return today;

}



function calcInstallment(id)
{
	
	

	var cash = parseInt(document.getElementById(id).value);
	//alert("Cash is : "+cash);
	if( cash > 500)
	{
	//alert("amount greater than 500");
	var total = parseInt(document.getElementById("totalfee").value);
	balance = total - cash;
	var radios = document.getElementsByName("installment");
	for (var i = 0; i< radios.length;  i++)
	{
    radios[i].disabled = false;
    }
    
    }
}

	function selectInstallment(id)
	{
	//alert("Select Installment called with "+id);
		
		var inst1 = document.getElementById("instcash1");
		var inst2 = document.getElementById("instcash2");
		var inst3 = document.getElementById("instcash3");
		var date1 = document.getElementById("date1");
		var date2 = document.getElementById("date2");
		var date3 = document.getElementById("date3");
		
		if(id == "1")
		{
			inst1.disabled = false;
			inst1.value =  parseInt(balance)+500;
			
			inst2.disabled = true;
			inst3.disabled = true;
			
			//alert("Value : "+getdate(1));
			date1.value = getdate(1);
			date1.disabled = false;
			
			date2.disabled = true;
			date3.disabled = true;	
		}
		
		if(id == "2")
		{
			inst1.disabled = false;
			inst1.value = parseInt((balance+500)/2);
			
			inst2.disabled = false;
			inst2.value = parseInt((balance+500)/2);
			
			inst3.disabled = true;
			
			date1.value = getdate(1);
			date1.disabled = false;
			
			date2.value = getdate(2);
			date2.disabled = false;
			
			date3.disabled = true;
			
		}
		
		if(id == "3")
		{
			inst1.disabled = false;
			inst1.value = parseInt((balance+500)/3);
			
			inst2.disabled = false;
			inst2.value = parseInt((balance+500)/3);
			
			inst3.disabled = false;
			inst3.value = parseInt((balance+500)/3);
			
			date1.value = getdate(1);
			date1.disabled = false;
			
			date2.value = getdate(2);
			date2.disabled = false;
			
			date3.value = getdate(3);
			date3.disabled = false;
			
		}
	}
	

	function payCash(payID)
	{
		var payee = document.getElementById(payID);
		var fees = document.getElementById("totalfee").value;
		window.open("DepositFee.jsp?payee="+payee.value+"&amount="+fees+"", "_blank", "width=600", false);
	}

	function payCheque(cid, bid, date)
	{
		var cno = document.getElementById(cid).value;
		var bank = document.getElementById(bid).value;
		var date = document.getElementById(date).value;
		var fees = document.getElementById("totalfee").value;
		
		window.open("DepositFee.jsp?amount="+fees+"&cheque="+cno+"&bank="+bank+"&date="+date+"", "_blank", "width=600", false);
	}
	
	function payInst(radioID)
	{
	
		var inst1 = document.getElementById("instcash1").value;
		var inst2 = document.getElementById("instcash2").value;
		var inst3 = document.getElementById("instcash3").value;
		var date1 = document.getElementById("date1").value;
		var date2 = document.getElementById("date2").value;
		var date3 = document.getElementById("date3").value;
		var cash = document.getElementById("instcash").value;
		if(radioID == "1")
		{
			window.open("DepositFee.jsp?cash="+cash+"&inst=1&inst1="+inst1+"&date1="+date1+"", "_blank", "width=600", false);
		}
		if(radioID == "2")
		{
			window.open("DepositFee.jsp?cash="+cash+"&inst=2&inst1="+inst1+"&date1="+date1+"&inst2="+inst2+"&date2="+date2+"", "_blank", "width=600", false);
		}
		if(radioID == "3")
		{
			window.open("DepositFee.jsp?cash="+cash+"&inst=3&inst1="+inst1+"&date1="+date1+"&inst2="+inst2+"&date2="+date2+"&inst3="+inst3+"&date3="+date3+"", "_blank", "width=600", false);
		}
	}

  </script>
  <body>
  	<form method="post" name="form" class="form-horizontal" >
          
         <fieldset>&nbsp;<legend><h1><strong>Student Registration : Step 4 Of 4</strong></h1></legend>
          
          
          
          <fieldset>
           <legend><strong>&nbsp;Student Details</strong></legend>
            </fieldset>
           <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Student ID :</label>
           
           <div class="col-sm-6">
          
          <label class="control-label"><%=id %></label>
          </div>
            </div>
            
            
            <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Student Name :</label>
           
           <div class="col-sm-6">
          
          <label class="control-label"><%=stu.getName() %></label>
          </div>
            </div>
            
            <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Student Mobile :</label>
           
           <div class="col-sm-6">
          
          <label class="control-label"><%=stu.getMobile() %></label>
          </div>
            </div>
            
            
            <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Student Email :</label>
           
           <div class="col-sm-6">
          
          <label class="control-label"><%=stu.getEmail() %></label>
          </div>
            </div>
  
  </fieldset>
  		 <fieldset>
           <legend><strong>&nbsp;Fees Details</strong></legend>
  <%
  		PreparedStatement stmt = con.prepareStatement("select name from package where pid=?");
  		stmt.setInt(1, stu.getPackageid() );
  		ResultSet res = stmt.executeQuery();
  		String p_name = null;
  		if(res.next())
  		{
  		
  			p_name = res.getString(1);
  		}
   %>
  
			<div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left">Package Selected :</label> 
		   	<label class="col-sm-2 control-label">&nbsp;&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<%=p_name %></label>
				   <div class="col-sm-3"></div>
				   
				   <div class="col-sm-2">
				   		<label for="inputEmail" class="control-label" align="left">Package Price :</label> 
				   </div>
				   
				   <div class="col-sm-2">  
				   		<input type="text" value="<%=stu.getPackageFees() %>" name="pfees" class="form-control" id="pFees" disabled ></input>
				   </div>
			</div>  
			
			<div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left">Certifcate Selected :</label> 
		   		<div class="col-sm-5">
		   		<%
             	String s = stu.getCertificate();
             	PreparedStatement ps1 = null;
             	ResultSet rs1 = null;
             	if(s!=null && !s.equals(""))
             	{
             	 ps1 = con.prepareStatement("select courseid from certificate where certificateid in ("+s+")");
             		System.out.println("PS is : "+ps1);
             	rs1 =	ps1.executeQuery();
             	int i = 0;
             	while(rs1.next())
				{
					%>
					<label><span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<%=rs1.getString(1) %>&nbsp;</label>
					<%
				}   
				
				ps1.close();
				rs1.close();         
              }
              %>
		   	
				   </div>
				   <div class="col-sm-2">
				   		<label for="inputEmail" class="control-label" >Certificate Fees :</label> 
				   </div>
				   
				   <div class="col-sm-2">  
				   		<input type="text" value="<%=stu.getCertificateFees() %>" name="cerfees" class="form-control" id="cerFees" disabled ></input>
				   </div>
			</div> 
  
  
  
  			 <div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left">Language Selected :</label> 
		   		<div class="col-sm-5">
		   		<%
             	 s = stu.getLanguage();
             	
             	if(s!=null && !s.equals(""))
             	{
             	 ps1 = con.prepareStatement("select name from course where courseid in ("+s+")");
             	
             	rs1 =	ps1.executeQuery();
             	int i = 0;
             	while(rs1.next())
				{ 
					%>
					<label><span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<%=rs1.getString("name") %>&nbsp;</label>
					<%
				}   
				
				ps1.close();
				rs1.close();         
              }
              %>
		   	
				   </div>
				   <div class="col-sm-2">
				   		<label for="inputEmail" class="control-label" >Language Fees :</label> 
				   </div>
				   
				   <div class="col-sm-2">  
				   		<input type="text" value="<%=stu.getLanguageFees() %>" name="tfees" class="form-control" id="tFees" disabled ></input>
				   </div>
			</div> 
			
			
			<div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left">Database Selected :</label> 
		   		<div class="col-sm-5">
		   		 <%
             	String s1 = stu.getDatabase();
             	if(s1!=null && !s1.equals(""))
             	{
             	ps1 = con.prepareStatement("select dbname from dbcourse where dbid in ("+s1+")");
             	
             	rs1 =	ps1.executeQuery();
             	int j = 0;
             	while(rs1.next())
				{
					%>
					<label>&nbsp;&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<%=rs1.getString("dbname") %>&nbsp;</label>
					<%
				}   
				
				ps1.close();
				rs1.close();   
				}
              %>
		   	
				   </div>
				   <div class="col-sm-2">
				   		<label for="inputEmail" class="control-label" align="left">Databases Fees :</label> 
				   </div>
				   
				   <div class="col-sm-2">  
				   		<input type="text" value="<%=stu.getDbFees() %>" name="pfees" class="form-control" id="pFees" disabled ></input>
				   </div>
			</div>  
			
			
			<div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left"></label> 
		   	<label class="col-sm-4 control-label">&nbsp;&nbsp;</label>
				   <div class="col-sm-3">
				   		<label for="inputEmail" class="control-label" align="left">Registration Fees : (One Time)</label> 
				   </div>
				   <%
				   		int amount = 0;
						if(stu.getPackageFees()==0)
						{
							amount = 500;
						}
									   
				    %>
				   
				   <div class="col-sm-2">  
				   		<input type="text" value="<%=amount %>"  name="pfees" class="form-control" id="pFees" ></input>
				   </div>
			</div>   
			
			
			<div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left"></label> 
		   	<label class="col-sm-4 control-label">&nbsp;&nbsp;</label>
				   <div class="col-sm-3">
				   		<label for="inputEmail" class="control-label" align="left">Discount ( Package ) : (-)</label> 
				   </div>
				   
				   
				   <div class="col-sm-2">  
				   		<input type="text" value="<%=stu.getDiscount() %>" name="pfees" class="form-control" id="pFees" ></input>
				   </div>
			</div>  
			
			<div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left"></label> 
		   	<label class="col-sm-4 control-label">&nbsp;&nbsp;</label>
				  <div class="form-group has-success has-feedback">
				   <div class="col-sm-3">
				   		<label for="inputEmail" class="control-label" align="left">Total Fees : </label> 
				   </div>
				   
				   <div class="col-sm-2">  
				   		<input type="text" value="<%=((stu.getLanguageFees() + stu.getDbFees() + stu.getCertificateFees() + amount) - stu.getDiscount()) %>" name="pfees" class="form-control" id="totalfee" ><span class="glyphicon glyphicon-ok form-control-feedback"></span></input>
				   </div>
				   </div>
			</div>  
			</fieldset>
			
			 <fieldset>
           <legend><strong>&nbsp;Payment Details</strong></legend>
           
           
           <div class="panel-group" id="accordion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Cash Payment
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="panel-body">
        	
        	<div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left">Received From : </label> 
		   	
				  
				   
				   <div class="col-sm-3">  
				   		<input type="text" placeHolder="Shri XYZ" name="payee" class="form-control" id="payee"  ></input>
				   </div>
				   
				   <div>
				   <input type="submit" name="paid" class="btn-lg btn-success" value="Generate Receipt" onclick="payCash('payee')">
				   </div>
			</div>  
        
        </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
          Cheque Payment
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">
      
      <div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left">Cheque Number : </label> 
		   	
				   <div class="col-sm-3">  
				   		<input type="text" placeHolder="Enter Instrument Number" name="cheque" class="form-control" id="cheque" onkeypress='validate(event)' ></input>
				   </div>	   
	  </div>
	  
	  <div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left">Bank & Branch : </label> 
		   	
				   <div class="col-sm-5">  
				   		<input type="text" placeHolder="Enter Bank Details" name="bank" class="form-control" id="bank"  ></input>
				   </div>		   
	  </div>
	  
	  <div class="form-group">
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left">Instrument Date : </label> 
		   	
				   <div class="col-sm-5">  
				   		<input type="date"  name="date" class="form-control" id="date"  ></input>
				   </div>		   
	  </div>
	  <div class="col-sm-offset-2">
				   <input type="submit" name="paid" class="btn-lg btn-success" value="Generate Receipt" onclick="payCheque('cheque','bank','date')">
				   </div>
	  
      
      
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
          Installment
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse">
      <div class="panel-body">
        
        <div class="form-group">
		   		<label for="inputEmail" class="col-sm-3 control-label" align="left">Enter Cash Deposited : </label> 
		   	
				   <div class="col-sm-3">  
				   		<input type="text" placeHolder="Enter Initial Cash" name="instcash" class="form-control" id="instcash" onkeypress="validate(event);" oninput="calcInstallment(this.id);" ></input>
				   </div>
				      
	  </div>
	  
	  <div class="form-group" >
		   		<label for="inputEmail" class="col-sm-3 control-label" align="left">Select Installment Plan : </label> 
		   	
				   <div class="col-sm-5 ">  
				   		<label class="col-1 control-label"><input type="radio" name="installment" value="1" id="1" onchange="selectInstallment(this.id)" disabled>&nbsp;One Month</input></label>
				   		<label class="col-1 control-label"><input type="radio" name="installment" value="2" id="2" onchange="selectInstallment(this.id)" disabled>&nbsp;Two Month</input></label>
				   		<label class="col-1 control-label"><input type="radio" name="installment" value="3" id="3" onchange="selectInstallment(this.id)" disabled>&nbsp;Three Month</input></label>
				   </div>		   
	  </div>
	  
	  <div class="form-group">
		   		<label for="inputEmail" class="col-sm-3 control-label" align="left">Instrument Date & Amount: </label> 
		   	
				   <div class="col-sm-2">  
				   <input type="text" placeHolder="First Installment" name="inst1" class="form-control" id="instcash1" onkeypress='validate(event)' disabled ></input>
				   		<input type="date"  name="date1" class="form-control" id="date1" disabled ></input>
				   </div>
				   
				    <div class="col-sm-2">  
				   <input type="text" placeHolder="Second Installment" name="inst2" class="form-control" id="instcash2" onkeypress='validate(event)' disabled ></input>
				   		<input type="date"  name="date2"  class="form-control" id="date2"  disabled></input>
				   </div>
				   
				    <div class="col-sm-2">  
				   <input type="text" placeHolder="Third Installment" name="inst3" class="form-control" id="instcash3" onkeypress='validate(event)' disabled ></input>
				   		<input type="date"  name="date3"  class="form-control" id="date3" disabled ></input>
				   </div>		   
	  </div>
	  <div class="col-sm-offset-3">
				   <input type="submit" name="paid" class="btn-lg btn-success" value="Generate Receipt" onclick="payInst(document.form.installment.value)">
				   </div>
	  
        
        <%
        	session.setAttribute("err", "success");
        	session.setAttribute("newstid", id);
        	
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
        
        </div>
    </div>
  </div>
</div>
           
  </fieldset>
   
  
   </form>
  </body>
</html>
