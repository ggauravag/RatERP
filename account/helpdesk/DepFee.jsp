<%@page import="java.util.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.DBInfo"%>
<%@page import="javax.xml.bind.DataBindingException"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.login.*"%>
<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Connection con = null;
try
{

	con = DBInfo.getConn();
	String payee = request.getParameter("payee");
	String amount = request.getParameter("amount");
	String cheque = request.getParameter("cheque");
	String bank = request.getParameter("bank");
	String date = request.getParameter("date");
	String inst = request.getParameter("inst");
	String update = request.getParameter("update");
	int up;
	if(update != null)
		up = Integer.parseInt(update);
	else
		up = 0;
	
	Student stu = (Student)session.getAttribute("object");
	
	//SendMail.sendWelcome(stu,basePath);
	String check = null;
	String date1 = null, date2 = null, date3 = null;
	int inst1 = 0, inst2 = 0, inst3 = 0;
	int cash = 0;
	String mode = "";
	int amt = 0;
	try
	{
	
	
	
	String helpid = (String)request.getSession(false).getAttribute("id");
	if( payee != null )
	{
		amt = Integer.parseInt(amount);
		PreparedStatement ps2 = null;
		if(up == 1)
		{
			 ps2 = con.prepareStatement("update student set deposit_fee=deposit_fee + ? where studentid=?");
			ps2.setInt(1, (amt));
			ps2.setString(2, stu.getSid());
			int j = ps2.executeUpdate();
			ps2.close();
		}
		else
		{
			ps2 = con.prepareStatement("update student set deposit_fee= deposit_fee + ? where studentid=?");
			ps2.setInt(1, (amt));
			ps2.setString(2, stu.getSid());
			int j = ps2.executeUpdate();
			ps2.close();
		}
		
		
		
		mode = "CASH";
		
		ps2 = con.prepareStatement("insert into transaction values(?,?,?,?,?,?,?)");
		ps2.setString(1, stu.generateTxnID());
		ps2.setString(2, stu.getSid());
		ps2.setInt(3, amt);
		Date d = new Date();
		java.sql.Date dob = new java.sql.Date(d.getTime());
		ps2.setDate(4, dob);
		ps2.setString(5, "CASH");
		ps2.setString(6, payee);
		ps2.setString(7, helpid);
		int result = ps2.executeUpdate();
		if(result == 1)
		{
			System.out.println("Transaction Created Successfully");
		}
		else
		{
			System.out.println("Unable to enter transaction");
		}
		
	}
	else if( cheque!= null && bank != null && date != null)
	{
		amt = Integer.parseInt(amount);
		
		PreparedStatement ps2 = null;
		if(up == 1)
		{
			 ps2 = con.prepareStatement("update student set deposit_fee=deposit_fee + ? where studentid=?");
			ps2.setInt(1, (amt));
			ps2.setString(2, stu.getSid());
			int j = ps2.executeUpdate();
			ps2.close();
		}
		else
		{
			ps2 = con.prepareStatement("update student set deposit_fee=deposit_fee + ? where studentid=?");
			ps2.setInt(1, (amt));
			ps2.setString(2, stu.getSid());
			int j = ps2.executeUpdate();
			ps2.close();
		}
		
		mode = "CHEQUE";
		System.out.println(date);
		
		ps2 = con.prepareStatement("insert into transaction values(?,?,?,?,?,?,?)");
		ps2.setString(1, stu.generateTxnID());
		ps2.setString(2, stu.getSid());
		ps2.setInt(3, amt);
		Date d = new Date();
		java.sql.Date dob = new java.sql.Date(d.getTime());
		ps2.setDate(4, dob);
		ps2.setString(5, "CHEQUE/"+cheque+"/"+bank+"/"+date);
		ps2.setString(6, "SELF");
		ps2.setString(7, helpid);
		int result = ps2.executeUpdate();
		if(result == 1)
		{
			System.out.println("Transaction Created Successfully");
		}
		else
		{
			System.out.println("Unable to enter transaction");
		}
	}
	else if( inst!= null )
	{
		cash = Integer.parseInt(request.getParameter("cash"));
		
		PreparedStatement ps1 = null;
		if(up == 1)
		{
			 ps1 = con.prepareStatement("update student set deposit_fee=deposit_fee + ? where studentid=?");
			ps1.setInt(1, (amt));
			ps1.setString(2, stu.getSid());
			int j = ps1.executeUpdate();
			ps1.close();
		}
		else
		{
			ps1 = con.prepareStatement("update student set deposit_fee=deposit_fee + ? where studentid=?");
			ps1.setInt(1, (amt));
			ps1.setString(2, stu.getSid());
			int j = ps1.executeUpdate();
			ps1.close();
		}
			
			mode="INSTALLMENT";
			
		ps1 = con.prepareStatement("insert into transaction values(?,?,?,?,?,?,?)");
		ps1.setString(1, stu.generateTxnID());
		ps1.setString(2, stu.getSid());
		ps1.setInt(3, cash);
		Date d5 = new Date();
		java.sql.Date dob5 = new java.sql.Date(d5.getTime());
		ps1.setDate(4, dob5);
		ps1.setString(5, "INSTALLMENT:"+inst);
		ps1.setString(6, "SELF");
		ps1.setString(7, helpid);
		int result = ps1.executeUpdate();
		if(result == 1)
		{
			System.out.println("Transaction Created Successfully");
		}
		else
		{
			System.out.println("Unable to enter transaction");
		}	
			
			
		
		
		if(inst.equals("1"))
		{
			
			inst1 = Integer.parseInt(request.getParameter("inst1"));
			date1 = request.getParameter("date1");
			amt = inst1 + cash;
			
			PreparedStatement ps = con.prepareStatement("insert into installment(studentid,amount,date,status) values(?,?,?,?)");
			
			ps.setString(1, stu.getSid() );
			ps.setInt(2, inst1);
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date d = sdf1.parse(date1);
			java.sql.Date dob = new java.sql.Date(d.getTime());
			ps.setDate(3, dob);
			ps.setString(4, "DUE");
			int i = ps.executeUpdate();
			if(i==1)
			{
			System.out.println("Successfully created installments");
			}
			else
			{
				System.out.println("unabl to create installment");
			
			}
			ps.close();
			
			
			
			
		}
		
		if(inst.equals("2"))
		{
			inst1 = Integer.parseInt(request.getParameter("inst1"));
			inst2 = Integer.parseInt(request.getParameter("inst2"));
			
			date1 = request.getParameter("date1");
			date2 = request.getParameter("date2");
			
			amt = inst1 + inst2 + cash;
			
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			PreparedStatement ps = con.prepareStatement("insert into installment(studentid,amount,date,status) values(?,?,?,?),(?,?,?,?)");
		
			ps.setString(1, stu.getSid() );
			ps.setInt(2, (inst1));
			
			java.util.Date d = sdf1.parse(date1);
			java.sql.Date dob = new java.sql.Date(d.getTime());
			ps.setDate(3, dob);
			ps.setString(4, "DUE");
			
			
			ps.setString(5, stu.getSid());
			ps.setInt(6, inst2 );
			java.util.Date d2 = sdf1.parse(date2);
			java.sql.Date dob1 = new java.sql.Date(d2.getTime());
			ps.setDate(7, dob1);
			ps.setString(8, "DUE");
			int i = ps.executeUpdate();
			if(i==1)
			{
			System.out.println("Successfully created installments");
			}
			else
			{
				System.out.println("unabl to create installment");
			
			}
			
			
		}
		
		if(inst.equals("3"))
		{
			inst1 = Integer.parseInt(request.getParameter("inst1"));
			inst2 = Integer.parseInt(request.getParameter("inst2"));
			inst3 = Integer.parseInt(request.getParameter("inst3"));
			date1 = request.getParameter("date1");
			date2 = request.getParameter("date2");
			date3 = request.getParameter("date3");
			
			amt = inst1 + inst2 + inst3 + cash;
			
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			PreparedStatement ps = con.prepareStatement("insert into installment(studentid,amount,date,status) values(?,?,?,?),(?,?,?,?),(?,?,?,?)");
		
			ps.setString(1, stu.getSid() );
			ps.setInt(2, (inst1));
			
			java.util.Date d = sdf1.parse(date1);
			java.sql.Date dob = new java.sql.Date(d.getTime());
			ps.setDate(3, dob);
			ps.setString(4, "DUE");
			
	
			ps.setString(5, stu.getSid());
			ps.setInt(6, inst2 );
			java.util.Date d2 = sdf1.parse(date2);
			java.sql.Date dob1 = new java.sql.Date(d2.getTime());
			ps.setDate(7, dob1);
			ps.setString(8, "DUE");
			
			
			
			ps.setString(9, stu.getSid() );
			ps.setInt(10, (inst1));
			
			java.util.Date d3 = sdf1.parse(date3);
			java.sql.Date dob3 = new java.sql.Date(d3.getTime());
			ps.setDate(11, dob3);
			ps.setString(12, "DUE");
			int i = ps.executeUpdate();
			if(i==1)
			{
			System.out.println("Successfully created installments");
			}
			else
			{
				System.out.println("unabl to create installment");
			
			}
			
		
		
		}
	
	}
	else
	{
		check = "close";
		System.out.println("No mode : "+payee+amount+check+date+cash+cheque);
	}
	
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
	<link rel="stylesheet" href="../../css/bootstrap.css" type="text/css"></link>
	<script type="text/javascript">
	<%	
		
	if(check!=null && check.equals("close"))
	{
	%>
		
		window.close();
		
		
	<%
	}
		
	%>
	
	window.onbeforeunload = function() {
        return "Don't Refresh the page";
    }
    
    window.onload = function () {
        document.onkeydown = function (e) {
            return (e.which || e.keyCode) != 116;
        };
    }
	</script>
	
	
  </head>
  
  <body >
  <form method="post" name="form" class="form-horizontal" >
  <fieldset>
 <legend><table><tr><td><img src="../../css/images/rat.png" height="100"></img></td><td align="right"><strong><h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Road Ahead Technologies</h1></strong></td></tr></table></legend>
  </fieldset>
  	 <fieldset>
  	 	<legend><h3><strong>&nbsp;Student Details</strong></h3></legend>
  	 </fieldset>
         
           <table  width="1000px" align="center">
           		<tr>
           			<td align="center"> <label class="control-label" >Receipt ID :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getTXNID() %></h4></label></td>
           			<td align="center"> <label class="control-label" >Student ID :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getSid() %></h4></label></td>
           		</tr>
           		<tr>
           			<td align="center"> <label class="control-label" >Student Name :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getName() %></h4></label></td>
           			<td align="center"> <label class="control-label" >Father Name :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getFatherName() %></h4></label></td>
           		</tr>
           		<tr>
           			<td align="center"> <label class="control-label" >Payment Mode :</label></td>
           			<td align="center"><label class="control-label"><h4><%=mode %></h4></label></td>
           			<td align="center"> <label class="control-label" >Package :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getPackageName() %></h4></label></td>
           		</tr>
           		<tr>
           			<td align="center"> <label class="control-label" >Language Course :</label></td>
           			<td align="center" colspan="3"><label class="control-label"><h4>&nbsp;
           			<%
           				String l[] = stu.getLString();
           				for(int i = 0; i < l.length; i++)
           				{
           					//System.out.println("iNSIDE ARRAY");
           					if(i!=l.length-1 && l[i]!=null)
           						out.print(l[i]+", ");
           					else if(l[i]!=null)
           						out.print(l[i]);
           				
           				}
           				
           			 %>
           			</h4></label></td>
           			
           		</tr>
           		<tr>
           			<td align="center"> <label class="control-label" >Database Course :</label></td>
           			<td align="center" colspan="3"><label class="control-label"><h4>&nbsp;
           			<%
           				String d[] = stu.getDString();
           				for(int i = 0; i < d.length; i++)
           				{
           				//System.out.println("iNSIDE ARRAY");
           					if(i!=d.length-1 && d[i]!=null)
           						out.print(d[i]+", ");
           					else if(d[i]!=null)
           						out.print(d[i]);
           				
           				}
           			
           			 %>
           			</h4></label></td>
           			
           		</tr>
           		<tr>
           			<td align="center"> <label class="control-label" >Student Mobile :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getMobile() %></h4></label></td>
           			<td align="center"> <label class="control-label" >Student Email :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getEmail() %></h4></label></td>
           		</tr>
           
           
           </table>
        <br>
         <fieldset>
  	 	<legend><h3><strong>&nbsp;Fee Receipt</strong></h3></legend>
  	 </fieldset>
  	 <table width="1000px" align="center">
  	 	<tr>
  	 	
  	 	<th>Details</th>
  	 	<th>Fees</th>
  	 	</tr>
  	 	
  	 	<tr>
  	 	<td>&nbsp;</td>
  	 	<td>&nbsp;</td>
  	 	</tr>
  	 	
  	 	<%
  	 			
  	 			
  	 			{
  	 				
  	 					%>
  	 						<tr>
  	 							<td>Certificate </td>
  	 							<td>Rs. <%=stu.getCertificateFees()%></td>
  	 						</tr>
  	 					
  	 						<tr>
  	 						<td>&nbsp;</td>
  	 						<td>&nbsp;</td>
  	 						</tr>
  	 					
  	 					
  	 					
  	 					
  	 					
  	 						
  	 					<%
  	 				
  	 			
  	 			
  	 			
  	 			
  	 			}
  	 	
  	 	 %>
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	<tr>
  	 	<td>&nbsp;</td>
  	 	<td>_____________</td>
  	 	</tr>
  	 	
  	 	
  	 	<tr>
  	 	<td>&nbsp;</td>
  	 	<td>&nbsp;</td>
  	 	</tr>
  	 	
  	 	<tr>
  	 	<td><label class="control-label">Total Fees</label></td>
  	 	<td><%
  	 		if(mode.equals("CASH") ||  mode.equals("CHEQUE"))
  	 		{
  	 			%><%=amt%><%
  	 		}
  	 		else
  	 		{
  	 			if(inst.equals("1"))
  	 			{
  	 				%><%=amt%><%
  	 			}
  	 			if(inst.equals("2"))
  	 			{
  	 				%><%=amt%><%
  	 			}
  	 			if(inst.equals("3"))
  	 			{
  	 			
  	 				%><%=amt%><%
  	 			}
  	 		
  	 		}
  	 	
  	 	
  	 	 %></td>
  	 	</tr>
  	 </table>
  	 <br>
  	 <fieldset>
  	 	<legend><h3><strong>&nbsp;Payment Details</strong></h3></legend>
  	 </fieldset>
  	 
  	 
  	 <table width="1000px" align="center">
  	 	
  	 	
  	 	<tr>
  	 	<td>&nbsp;</td>
  	 	<td>&nbsp;</td>
  	 	</tr>
  	 	
  	 	<%
  	 	if(mode.equals("CASH"))
  	 		{
  	 			%>
  	 			
  	 				<tr>
  	 				<td><label class="control-label">Fees Paid</label></td>
  	 				<td><%=amount %></td>
  	 				</tr>
  	 				<%
  	 					SendMail.sendReceipt(stu, path, mode, amount, 0);
  	 				 %>
  	 			
  	 			<% 
  	 		}
  	 		else if(mode.equals("CHEQUE"))
  	 		{
  	 			%>
  	 				<tr>
  	 				<td><label class="control-label">Fees Paid Through Cheque Number : <%=cheque %>&nbsp;<%=bank %>&nbsp;<%=date.toString() %></label></td>
  	 				<td><%=amount %></td>
  	 				</tr>
  	 				
  	 				<tr>
  	 				<td>* Subject to realization of amount</td>
  	 				<td></td>
  	 				</tr>
  	 				<%
  	 					SendMail.sendReceipt(stu, path, mode, amount, 0);
  	 				 %>
  	 			
  	 			<% 
  	 		
  	 		}
  	 		else if(mode.equals("INSTALLMENT"))
  	 		{
  	 		%>
  	 			<tr>
  	 				<td><label class="control-label">Fees Paid (in Cash)</label></td>
  	 				<td><%=cash %></td>
  	 				</tr>
  	 		<% 
  	 		}
  	 	
  	 	
  	 	
  	 	
  	 	 %>
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	<tr>
  	 	<td>&nbsp;</td>
  	 	<td>&nbsp;</td>
  	 	</tr>
  	 	
  	 	
  	 	<tr>
  	 	<td><label class="control-label">Dues ( If any )</label></td>
  	 	<td>Rs. 
  	 	<%
  	 		if(mode.equals("CASH") ||  mode.equals("CHEQUE"))
  	 		{
  	 			%><%=0%><%
  	 		}
  	 		else
  	 		{
  	 			if(inst.equals("1"))
  	 			{
  	 				%><%=inst1%><%
  	 				
  	 					SendMail.sendReceipt(stu, path, mode, String.valueOf(cash), inst1);
  	 				 
  	 			}
  	 			if(inst.equals("2"))
  	 			{
  	 				%><%=inst1 + inst2%><%
  	 				SendMail.sendReceipt(stu, path, mode, String.valueOf(cash), inst1+inst2);
  	 			}
  	 			if(inst.equals("3"))
  	 			{
  	 			
  	 				%><%=inst1+inst2+inst3%><%
  	 				SendMail.sendReceipt(stu, path, mode, String.valueOf(cash), inst1+inst2+inst3);
  	 			}
  	 		}
  	 	
  	 	 %>
  	 	
  	 	</td>
  	 	</tr>
  	 	
  	 	
  	 	
  	 	
  	 	<tr>
  	 	<td>&nbsp;</td>
  	 	<td>&nbsp;</td>
  	 	</tr>
  	 	
  	 	
  	 </table>
  	 
  	 <table border="1" width="1000px" align="center">
  	 	<tr>
  	 	<td align="center"><label class="control-label">Installment Number</label></th>
  	 	<td align="center"><label class="control-label">Amount</label></th>
  	 	<td align="center"><label class="control-label">Date</label></th>
  	 	<td align="center"><label class="control-label">Signature</label></th>
  	 	</tr>
  	 	
  	 	<%
  	 		if(mode.equals("INSTALLMENT"))
  	 		{
  	 		System.out.println("installment");
  	 			if(inst.equals("1"))
  	 			{
  	 			System.out.println("One installment");
  	 				%>
  	 					<tr>
				  	 		<td align="center">Installment 1</td>
				  	 		<td align="center" ><h4>&nbsp;<%=inst1 %></h4></td>
				  	 		<td align="center">&nbsp;<h4><%=date1 %></h4></td>
				  	 		<td align="center"><H4>&nbsp;</H4></td>
				  	 	</tr>
  	 	
  	 	
  	 				
  	 				<% 
  	 			}
  	 			if(inst.equals("2"))
  	 			{
  	 			System.out.println("two installment");
  	 				%>
  	 				<tr>
				  	 		<td align="center">Installment 1</td>
				  	 		<td align="center" ><h4>&nbsp;<%=inst1 %></h4></td>
				  	 		<td align="center">&nbsp;<h4><%=date1 %></h4></td>
				  	 		<td align="center"><H4>&nbsp;</H4></td>
				  	 	</tr>
			  	 	
			  	 	<tr>
			  	 		<td align="center">Installment 2</td>
			  	 		<td align="center" ><h4>&nbsp;<%=inst2 %></h4></td>
			  	 		<td align="center">&nbsp;<h4><%=date2 %></h4></td>
			  	 		<td align="center"><H4>&nbsp;</H4></td>
			  	 	</tr>
  	 				
  	 				
  	 				<% 
  	 			}
  	 			if(inst.equals("3"))
  	 			{
  	 			System.out.println("three installment");
  	 				%>
  	 				
  	 				<tr>
				  	 		<td align="center">Installment 1</td>
				  	 		<td align="center" ><h4>&nbsp;<%=inst1 %></h4></td>
				  	 		<td align="center"><h4><%=date1 %></h4></td>
				  	 		<td align="center"><H4>&nbsp;</H4></td>
				  	 	</tr>
			  	 	
			  	 	<tr>
			  	 		<td align="center">Installment 2</td>
			  	 		<td align="center" ><h4>&nbsp;<%=inst2 %></h4></td>
			  	 		<td align="center"><h4><%=date2 %></h4></td>
			  	 		<td align="center"><H4>&nbsp;</H4></td>
			  	 	</tr>
			  	 	
			  	 	<tr>
			  	 		<td align="center">Installment 3</td>
			  	 		<td align="center" ><h4>&nbsp;<%=inst3 %></h4></td>
			  	 		<td align="center"><h4><%=date3 %></h4></td>
			  	 		<td align="center"><H4>&nbsp;</H4></td>
			  	 	</tr>
  	 				
  	 				
  	 				<% 
  	 			}
  	 		
  	 		}
  	 	
  	 	 %>
  	 	
  	 	
  	 
  	 </table>
  	 
  	 
  	 <br>
  	 <fieldset>
  	 	<legend>&nbsp;</legend>
  	 </fieldset>
       <strong>TONK ROAD CENTER</strong> 
		A-13, Vikas Marg, Mansinghpura, Gatta, Near TVS Showroom, Tonk Road, Jaipur(RAJ.)
		Contact No.: +91-141-3216335, 9309295818
		Email id: roadaheadtechnologies@gmail.com
       <br>
       <strong>PRATAP NAGAR CENTER</strong>
First Floor, Gold Square Complex, Opp.Roadways Bus Depot, Kumbha Marg, Pratap Nagar, Jaipur(RAJ.)
Contact No.: +91-141-3156335, 9309295818
Email id: roadaheadtech.pn@gmail.com

<br>
<strong>KUKAS CENTER</strong>
A-75, Ayodhya, Residency, RIICO Industrial Area, Kukas, Jaipur(RAJ.)
Contact No.: +91-141-3153534, 9309295818
Email id: training@ratindia.com
     
          
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
           
           
   </form>
  </body>
</html>
