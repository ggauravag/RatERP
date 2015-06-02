<%@page import="com.login.Student"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.DBInfo,java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.login.SendMail"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String certificates[] = request.getParameterValues("certificate");
	String stuid = request.getParameter("studentQuery");
	String type = (String)session.getAttribute("type");
	if(type != null && (type.equals("ADMIN") || type.equals("HELPDESK")))
	{
		
	}
	else
	{
		response.sendRedirect("../Unauthorize.jsp");
		return;
	}
	//System.out.println(stuid);
Connection con = null;
Student stu = null;
try
{
	con = DBInfo.getConn();	
	
	
	if(request.getParameter("paid")!=null)
	{
		response.sendRedirect("Enroll.jsp");
		return;
	}
	
	
	if(stuid!=null && stuid != "" && certificates != null)
	{
		String cer = "";
		for(int i = 0; i < certificates.length; i++)
		{
			if(i!=certificates.length - 1)
				cer += certificates[i]+",";
			else
				cer += certificates[i];
		}
	
		String query = "update student set certificate = ? where studentid = ? ";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, cer);
		ps.setString(2, stuid);
		int i = ps.executeUpdate();
		if(i == 1)
		{
			//session.setAttribute("newid", stuid);
			
		}
		else
		{
			response.sendRedirect("../Error.jsp");
			return;
		}
		stu = new Student(stuid);
		if(stu!=null && stu.fetchRecord() && stu.calculateFees())
		{
			session.setAttribute("object", stu);
			System.out.println("Student record fetched");
		}
		else
		{
			response.sendRedirect("../Error.jsp");
		}
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <link rel="stylesheet" href="../../css/bootstrap.css" type="text/css"></link>
<script type="text/javascript" src="../../js/jquery-1.7.1.min.js"></script>
  <script type="text/javascript" src="../../js/bootstrap.js"></script></head>
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
		window.open("DepFee.jsp?payee="+payee.value+"&amount="+fees+"", "_blank", "width=600", false);
	}

	function payCheque(cid, bid, date)
	{
		var cno = document.getElementById(cid).value;
		var bank = document.getElementById(bid).value;
		var date = document.getElementById(date).value;
		var fees = document.getElementById("totalfee").value;
		
		window.open("DepFee.jsp?amount="+fees+"&cheque="+cno+"&bank="+bank+"&date="+date+"", "_blank", "width=600", false);
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
			window.open("DepFee.jsp?cash="+cash+"&inst=1&inst1="+inst1+"&date1="+date1+"", "_blank", "width=600", false);
			
		}
		if(radioID == "2")
		{
			window.open("DepFee.jsp?cash="+cash+"&inst=2&inst1="+inst1+"&date1="+date1+"&inst2="+inst2+"&date2="+date2+"", "_blank", "width=600", false);
		}
		if(radioID == "3")
		{
			window.open("DepFee.jsp?cash="+cash+"&inst=3&inst1="+inst1+"&date1="+date1+"&inst2="+inst2+"&date2="+date2+"&inst3="+inst3+"&date3="+date3+"", "_blank", "width=600", false);
		}
	}

  </script>
  <body>
  	<form method="post" name="form" class="form-horizontal" action="" >
          
         <fieldset>&nbsp; <legend><h1><strong>Student Registration</strong></h1></legend>
          
          
          
          <fieldset>
           <legend><strong>&nbsp;Student Details</strong></legend>
            </fieldset>
           <div class="form-group">
           <label for="inputName" class="col-sm-2 control-label" align="left">Student ID :</label>
           
           <div class="col-sm-6">
          
          <label class="control-label"><%=stuid %></label>
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
		   		<label for="inputEmail" class="col-sm-2 control-label" align="left"></label> 
		   	<label class="col-sm-4 control-label">&nbsp;&nbsp;</label>
				  <div class="form-group has-success has-feedback">
				   <div class="col-sm-3">
				   		<label for="inputEmail" class="control-label" align="left">Total Fees : </label> 
				   </div>
				   
				   <div class="col-sm-2">  
				   		<input type="text" value="<%=(stu.getCertificateFees()) %>" name="pfees" class="form-control" id="totalfee" ><span class="glyphicon glyphicon-ok form-control-feedback"></span></input>
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
        	session.setAttribute("newstid", stuid);
        	
         %>
        
        </div>
    </div>
  </div>
</div>
           
  </fieldset>
   
  
   </form>
  </body>
</html>

  <%
  	}
  	catch(Exception e)
  	{
  		e.printStackTrace();
  		SendMail.sendReport(e, basePath);
  		response.sendRedirect("../Error.jsp");
  	}
  	finally
  	{
  		if(con != null)
  		{
  			try
  			{	con.close(); }
  			catch(Exception e)
  			{
  				e.printStackTrace();
  				}
  		}
  	
  	}
  
   %>
</html>
