<%@page import="com.login.SendMail"%>
<%@page import="sun.dc.pr.PRError"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date" %>
<%@page import="java.sql.*" %>
<%@page import="com.login.DBInfo" %>
<%@page import="com.login.Student" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

 Connection con = null;
 
 try
 {
 	con = DBInfo.getConn();
  
  String instid = request.getParameter("instid");
  String stid = request.getParameter("stid");
  String amt = request.getParameter("amt");
  
  PreparedStatement pp = con.prepareStatement("select deposit_fee from student where studentid=?");
  pp.setString(1, stid);
  ResultSet rr = pp.executeQuery();
  int depfee=0;
  if(rr.next())
  {
     depfee = rr.getInt("deposit_fee");
  }
  
  Student stu = new Student(stid);
  
  if(stu.fetchRecord() && stu.calculateFees())
  {
    System.out.println("Record fetched");
  }
  else
  {
    System.out.println("Record not fetched");
  }
  String mode = "INSTALLMENT";
  
  String tid = stu.generateTxnID();
  String helpid = (String)request.getSession(false).getAttribute("id");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>RAT Panel</title>
    
	
	
	<link rel="shortcut icon" href="css/images/ratico.ico" />
	<link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
    <script>
    window.onbeforeunload = function() {
        return "Don't Refresh the Page !";
    }
    
    
    window.onload = function () {
        document.onkeydown = function (e) {
            return (e.which || e.keyCode) != 116;
        };
    }
    
    </script>
  </head>
  
  <body>
    
  </body>
 <form method="post" name="form" class="form-horizontal" >
  <fieldset>
 <legend><table><tr><td><img src="css/images/rat.png" height="100"></img></td><td align="right"><strong><h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Road Ahead Technologies</h1></strong></td></tr></table></legend>
  </fieldset>
  	 <fieldset>
  	 	<legend><h3><strong>&nbsp;Student Details</strong></h3></legend>
  	 </fieldset>
           
           <table  width="1000px" align="center">
           		<tr>
           			<td align="center"> <label class="control-label" >Receipt ID :</label></td>
           			<td align="center"><label class="control-label"><h4><%=tid%></h4></label></td>
           			<td align="center"> <label class="control-label" >Student ID :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stid%></h4></label></td>
           		</tr>
           		<tr>
           			<td align="center"> <label class="control-label" >Student Name :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getName() %></h4></label></td>
           			<td align="center"> <label class="control-label" >Father Name :</label></td>
           			<td align="center"><label class="control-label"><h4><%=stu.getFatherName()%></h4></label></td>
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
  	 	<legend><h3><strong>&nbsp;Payment Details</strong></h3></legend>
  	 </fieldset>
  	 
  	 
  	 <table width="1000px" align="center">
  	 	
  	 	
  	 	<tr>
  	 	<td>&nbsp;</td>
  	 	<td>&nbsp;</td>
  	 	</tr>
  	 	
  	 	
  	 			<tr>
  	 				<td><label class="control-label">Fees Paid</label></td>
  	 				<td><%=depfee%></td>
  	 				</tr>
  	 	 	
  	 	<tr>
  	 	<td>&nbsp;</td>
  	 	<td>&nbsp;</td>
  	 	</tr>
  	 	
  	 	
  	 	<tr>
  	 	<td><label class="control-label">Dues ( If any )</label></td>
  	 	<td>Rs. 
  	 	<%
  	 	   try
  	 	   {
  	 		PreparedStatement ps=con.prepareStatement("select * from installment where studentid=? and status=? order by date");
  	 		ps.setString(1,stid);
  	 		ps.setString(2,"DUE");
  	 		ResultSet rs = ps.executeQuery();
  	 		int duefee=0;
  	 		int count =0;
  	 		
  	 		while(rs.next())
  	 		{
  	 		  count++;
  	 		  duefee = rs.getInt(3) + duefee;
  	 		}	
  	 		rs.beforeFirst();
  	 	     %>
  	 	       <%=duefee-Integer.parseInt(amt)%>
  	 	     
  	 	   
  	 	</td>
  	 	
  	 	</tr>
  	 	 
  	 	
  	 	<tr>
  	 	<td><label class="control-label">Date :</label></td>
  	 	<td><% 
  	 		SendMail.sendReceipt(stu, basePath, "CASH", amt, duefee-Integer.parseInt(amt));
  	 	      if(rs.next())
  	 	      {
  	 	        %>
  	 	        <%=rs.getDate("date") %>
  	 	        <%
  	 	      }
  	 	      ps.close();
  	 	  }
  	 	  catch(Exception e)
  	 	  {
  	 	    e.printStackTrace();
  	 	   
  	 	  }
  	 	  %></td>
  	 	</tr>
  	 	
  	 	
  	 </table>
  	 <%
  	    
  	    int totalfee = depfee+Integer.parseInt(amt);
  	    
  	    
  	   try
  	   {
  	     
  	      PreparedStatement ps1=con.prepareStatement("update student set deposit_fee=? where studentid=?");
  	      ps1.setInt(1, totalfee);
  	      ps1.setString(2, stid);
  	      int j = ps1.executeUpdate();
  	      ps1.close();                      //Connection close
  	      System.out.println("Student table updated successfully");
  	      
  	      PreparedStatement ps2=con.prepareStatement("update installment set status=? where inst_id=?");
  	      ps2.setString(1, "PAID");
  	      ps2.setString(2,instid);
  	      int k = ps2.executeUpdate();
  	      ps2.close();                       //Connection close
  	      System.out.println("Installment table updated successfully");
  	      
  	      PreparedStatement ps3=con.prepareStatement("insert into transaction values(?,?,?,?,?,?,?)");
  	      ps3.setString(1,tid);
  	      ps3.setString(2,stid);
  	      ps3.setInt(3,Integer.parseInt(amt));
  	      Date q = new Date();
		  java.sql.Date dob = new java.sql.Date(q.getTime());
  	      ps3.setDate(4, dob);
  	      ps3.setString(5,mode);
  	      ps3.setString(6, "SELF");
  	      ps3.setString(7,helpid);
  	      System.out.println("Data inserted in transaction table successfully");
  	      
  	     
  	      
  	      int a = ps3.executeUpdate();
  	      ps3.close();                      //Connection close
  	   }
  	   catch(Exception e)
  	   {
  	     e.printStackTrace();
  	   }
  	  %>
  	
  	 <br>
  	 <div class="col-sm-offset-4">
  	 <button onclick="print();return false;" class="btn btn-primary" value="Print"><span class="glyphicon glyphicon-print"></span></button>
  	 </div>
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
  <script type="text/javascript">
  function hidebutton(hide)
  {
    document.getElementById('hide').visibility = "hidden";
  }
  </script>
</html>
