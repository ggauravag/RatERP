<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="com.login.Student,com.login.SendMail" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Connection con = null;
	try
	{
		con = DBInfo.getConn();

		int old_dep_fee=0,old_due_amt=0,old_actual_fee=0,pid = 9;
		int cur_fee = 0;
		int old_max_fee = 0;
		int final_fee = 0;
		int expected_fee = 0;
		
		
		String stid = request.getParameter("stid");
		  Student stu2 = new Student(stid);
		  if(stu2.fetchRecord() && stu2.calculateFees())
		  {
		  	if(stu2.getPackageid()==9)
		  		old_actual_fee = stu2.getLanguageFees() + stu2.getDbFees() + 500;
		  	else
		  		old_actual_fee = stu2.getPackageFees();
		  		
		  	old_max_fee = stu2.getLanguageFees() + stu2.getDbFees();
		    System.out.println("Record fetched successfully at stu1 object"); 
		  }
		  
		  
		  		 PreparedStatement ps = con.prepareStatement("select deposit_fee from student where studentid=?");
	             ps.setString(1, stid);
	             ResultSet rs = ps.executeQuery();
	             
	             if(rs.next())
	             {
	               old_dep_fee = rs.getInt("deposit_fee");
	             }
	             
	             
	             PreparedStatement ps1 = con.prepareStatement("select amount from installment where studentid=? and status=?");
	             ps1.setString(1, stid);
	             ps1.setString(2, "DUE");
	             ResultSet rs1 = ps1.executeQuery();
	             
	             PreparedStatement ps2 = con.prepareStatement("delete from installment where studentid=? and status='DUE'");
	             ps2.setString(1, stid);
	             ps2.executeUpdate();
	             
	             while(rs1.next())
	             {
	               old_due_amt =  old_due_amt + rs1.getInt("amount");
	             }
	             
	             
	             int totalFee = old_dep_fee + old_due_amt;
		  
		
		if(request.getParameter("add")!=null)
		{
			System.out.println("User added new courses");
			String lang[] = request.getParameterValues("language");
			String db[] = request.getParameterValues("database");
			
			
			
			try
         	{
	             
	             
	             
	             
	             if(lang!=null && lang.length != 0)
	       		 {
	       		 		String langu = " ";
			              for(int i = 0; i < lang.length; i++)
				          {
					        if(i!=lang.length-1 && lang[i] != null)
						      langu = langu + lang[i] + ", ";
					        else
						      langu = langu + lang[i];
				          }
		         
					     if(langu!=null && langu!="")
					     {
					        String sql = "{ CALL AddLanguage(?,?) }";   //?=studentid,?=language
							CallableStatement call = con.prepareCall(sql);
							call.setString(1, stid);
							call.setString(2, ","+langu);
							//System.out.println("Call statement is : "+call+" and ID is : "+sid+" operation is :"+call.execute());
							call.execute();
							call.close();
					     }
				  }
				 else
				 {
				   System.out.println("No language selected");
				 }
				
				String dbstr = "";
				
				
				if(db!= null && db.length != 0)
        		{
        			
		            for(int i = 0; i < db.length; i++)
			         {
			         
			    	  if(i!=db.length-1 && db != null)
					    dbstr = dbstr + db[i].replaceAll("db", "") + ", ";
				      else
			   	   	    dbstr = dbstr + db[i].replaceAll("db", "");
			         }
	          
	          
			          if(dbstr!=null && dbstr!="")
				       {
				         String sql = "{ CALL AddDB(?,?) }";   //?=studentid,?=db
						CallableStatement call = con.prepareCall(sql);
						call.setString(1, stid);
						call.setString(2, ","+dbstr);
						//System.out.println("Call statement is : "+call+" and ID is : "+sid+" operation is :"+call.execute());
						call.execute();
						call.close();
				       }
		        }
		        else
			    {
			      System.out.println("No database selected");
			    }
			    
			    
			     Student stu1 = new Student(stid);
				 if(stu1.fetchRecord() && stu1.calculateFees())
				 {
				 	cur_fee = stu1.getDbFees() + stu1.getLanguageFees() - old_max_fee;
				 	final_fee = old_actual_fee + cur_fee;
				 	expected_fee = cur_fee + old_due_amt;
				 }
			    
	    
	    
		 }
         catch(Exception e)
         {
           e.printStackTrace();
         }
			
			
			
			
		
		
		
		}
		else if(request.getParameter("upgrade")!=null)
		{
			System.out.println("User upgraded package");
			pid = Integer.parseInt(request.getParameter("packageid"));
			String updb[] = request.getParameterValues("database");
			String upl[] = request.getParameterValues("language");
			String pack = request.getParameter("packageid");
			int pid1 = Integer.parseInt(pack);
			
			
				if(upl!=null && upl.length != 0)
	       		 {
	       		 		String langu = " ";
			              for(int i = 0; i < upl.length; i++)
				          {
					        if(i!=upl.length-1 && upl[i] != null)
						      langu = langu + upl[i] + ", ";
					        else
						      langu = langu + upl[i];
				          }
		         
					     if(langu!=null && langu!="")
					     {
					        String sql = "{ CALL AddLanguage(?,?) }";   //?=studentid,?=language
							CallableStatement call = con.prepareCall(sql);
							call.setString(1, stid);
							call.setString(2, ","+langu);
							//System.out.println("Call statement is : "+call+" and ID is : "+sid+" operation is :"+call.execute());
							call.execute();
							call.close();
					     }
				  }
				 else
				 {
				   System.out.println("No language selected");
				 }
				 
				 
				 
			
				String dbstr = "";
				
				if(updb!= null && updb.length != 0)
        		{
        			
		            for(int i = 0; i < updb.length; i++)
			         {
			         
			    	  if(i!=updb.length-1 && updb != null)
					    dbstr = dbstr + updb[i] + ", ";
				      else
			   	   	    dbstr = dbstr + updb[i];
			         }
	          
	          
			          if(dbstr!=null && dbstr!="")
				       {
				         String sql = "{ CALL AddDB(?,?) }";   //?=studentid,?=db
						CallableStatement call = con.prepareCall(sql);
						call.setString(1, stid);
						call.setString(2, ","+dbstr);
						//System.out.println("Call statement is : "+call+" and ID is : "+sid+" operation is :"+call.execute());
						call.execute();
						call.close();
				       }
		        }
		        else
			    {
			      System.out.println("No database selected");
			    }
			
			
			
			if(pid == 9)
		       {
		          System.out.println("Package not selected");
		          return;
		       }
       		else
		       {
		          PreparedStatement ps5 = con.prepareStatement("update student set packageid=? where studentid=?");
		          ps5.setInt(1, pid1);
		          ps5.setString(2, stid);
		          int j = ps5.executeUpdate();
		          if(j==1)
		            System.out.println("Successfully updated package");
		          else
		            System.out.println("Package not updated");
		       }
		       
		       
		       Student stunew = new Student(stid);
		       if(stunew.fetchRecord() && stunew.calculateFees())
		       {
		       		cur_fee = stunew.getPackageFees() - old_actual_fee;
				 	final_fee = old_actual_fee + cur_fee;
				 	expected_fee = cur_fee + old_due_amt;
		       }
		
		
		}
		else
		{
		
			response.sendRedirect("Unauthorize.jsp");
		
		}
		
       
          
         /*  
          String lang_val[] = request.getParameterValues("language");
          String db_val[] = request.getParameterValues("database"); */
         // String lang="",db="";
   			
      // pid = Integer.parseInt(request.getParameter("packageid"));
       
       /* if(pid == 0)
       {
          System.out.println("Package not selected");
       }
       else
       {
          PreparedStatement ps = con.prepareStatement("update student set packageid=? where studentid=?");
          ps.setInt(1, pid);
          ps.setString(2, stid);
          int j = ps.executeUpdate();
          if(j==1)
            System.out.println("Successfully updated package");
          else
            System.out.println("Package not updated");
       }
        */
        
        /*  try
         {
             PreparedStatement ps = con.prepareStatement("select deposit_fee from student where studentid=?");
             ps.setString(1, stid);
             ResultSet rs = ps.executeQuery();
             if(rs.next())
             {
               old_dep_fee = rs.getInt("deposit_fee");
             }
             
             
             PreparedStatement ps1 = con.prepareStatement("select amount from installment where studentid=? and status=?");
             ps1.setString(1, stid);
             ps1.setString(2, "DUE");
             ResultSet rs1 = ps1.executeQuery();
             while(rs1.next())
             {
               old_due_amt =  old_due_amt + rs1.getInt("amount");
             }
             
         }
         catch(Exception e)
         {
           e.printStackTrace();
         }
       
       Student stu = new Student(stid);
       
    if(stu.fetchRecord() && stu.calculateFees())
     {
       
      
      if(lang_val.length != 0)
       {
            for(int i = 0; i < lang_val.length; i++)
	          {
		        if(i!=lang_val.length-1 && lang_val[i] != null)
			      lang = lang + lang_val[i] + ", ";
		        else
			      lang = lang + lang_val[i];
	          }
	         
	     if(lang!=null && lang!="")
	     {
	        String sql = "{ CALL AddLanguage(?,?) }";   //?=studentid,?=language
			CallableStatement call = con.prepareCall(sql);
			call.setString(1, stid);
			call.setString(2, ","+lang);
			//System.out.println("Call statement is : "+call+" and ID is : "+sid+" operation is :"+call.execute());
			call.execute();
			call.close();
			
	     }
	 }
	 else
	 {
	   System.out.println("No language selected");
	 }
	 
     if(db_val!= null && db_val.length != 0)
        {
            for(int i = 0; i < db_val.length; i++)
	         {
	    	  if(i!=db_val.length-1 && db_val != null)
			    db = db + db_val[i] + ", ";
		      else
	   	   	    db = db + db_val[i];
	          }
	          
	          
	        if(db!=null && db!="")
	       {
	         String sql = "{ CALL AddDB(?,?) }";   //?=studentid,?=db
			CallableStatement call = con.prepareCall(sql);
			call.setString(1, stid);
			call.setString(2, ","+db);
			//System.out.println("Call statement is : "+call+" and ID is : "+sid+" operation is :"+call.execute());
			call.execute();
			call.close();
			
	       }
        }
        else
	    {
	      System.out.println("No database selected");
	    }
   }                                     */           
   
  Student stu1 = new Student(stid);
  if(stu1.fetchRecord() && stu1.calculateFees())
  {
    System.out.println("Record fetched successfully at stu1 object"); 
    session.setAttribute("object", stu1);
  }
  else
  {
     System.out.println("Record does not fetched"); 
   }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="icon" href="css/images/ratico.ico">
    
    <title>Check Payment</title>
    
	
   <link href="css/bootstrap.min.css" rel="stylesheet">
   <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script></head>
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
	if( cash >= 500)
	{
	//alert("amount greater than 500");
	var total = parseInt(document.getElementById("expfee").value);
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
		var fees = document.getElementById("expfee").value;
		window.open("DepositFee.jsp?payee="+payee.value+"&amount="+fees+"&update=1", "_blank", "width=600", false);
	}

	function payCheque(cid, bid, date)
	{
		var cno = document.getElementById(cid).value;
		var bank = document.getElementById(bid).value;
		var date = document.getElementById(date).value;
		var fees = document.getElementById("expfee").value;
		
		window.open("DepositFee.jsp?amount="+fees+"&cheque="+cno+"&bank="+bank+"&date="+date+"&update=1", "_blank", "width=600", false);
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
			window.open("student/DepositFee.jsp?cash="+cash+"&inst=1&inst1="+inst1+"&date1="+date1+"&update=1", "_blank", "width=600", false);
		}
		if(radioID == "2")
		{
			window.open("student/DepositFee.jsp?cash="+cash+"&inst=2&inst1="+inst1+"&date1="+date1+"&inst2="+inst2+"&date2="+date2+"&update=1", "_blank", "width=600", false);
		}
		if(radioID == "3")
		{
			window.open("student/DepositFee.jsp?cash="+cash+"&inst=3&inst1="+inst1+"&date1="+date1+"&inst2="+inst2+"&date2="+date2+"&inst3="+inst3+"&date3="+date3+"&update=1", "_blank", "width=600", false);
		}
	}

  </script>
  </head>
  
  <body>
      <form method="post" name="form" class="form-horizontal" >
       
          <fieldset>
           <legend><strong>&nbsp;Student Details</strong></legend>
           
           <div class="form-group">
           <label class="col-sm-3 control-label">Student ID :</label>           
           <div class="col-sm-6">         
               <label class="control-label"><%=stid %></label>
               </div>
           </div>
            
            
           <div class="form-group">
           <label class="col-sm-3 control-label" >Student Name :</label>
           <div class="col-sm-6"> 
               <label class="control-label"><%=stu1.getName() %></label>
               </div>
           </div>
            
            
            <div class="form-group">
            <label class="col-sm-3 control-label" >Student Mobile :</label>        
            <div class="col-sm-6">          
                <label class="control-label"><%=stu1.getMobile() %></label>
                </div>
           </div>
            
           <div class="form-group">
           <label class="col-sm-3 control-label">Student Email :</label>    
           <div class="col-sm-6">         
               <label class="control-label"><%=stu1.getEmail() %></label>
               </div>
           </div>
  
  </fieldset>
  
  
  
    <fieldset>
    <legend><strong>&nbsp;Selected Course</strong></legend>
    
         <div class="form-group">
       <label class="col-sm-3 control-label">Package :</label>
      <div class="col-sm-6">  
              
               <label class="control-label"><%=stu1.getPackageName()%></label>    
      
       </div>
       </div>
    
        <div class="form-group">
       <label class="col-sm-3 control-label">Languages :</label>
      <div class="col-sm-6">  
          <label class="control-label"><% 
          
           				String l[] = stu1.getLString();
           				for(int i = 0; i < l.length; i++)
           				{
           					
           					if(i!=l.length-1 && l[i]!=null)
           						out.print(l[i]+", ");
           					else if(l[i]!=null)
           						out.print(l[i]);
           				
           				}
           				
           			 %></label>
       
       </div>
       </div>
       
       
       <div class="form-group">
      <label class="col-sm-3 control-label">Databases :</label>
      <div class="col-sm-6">  
       <label class="control-label"><%
           				String d[] = stu1.getDString();
           				for(int i = 0; i < d.length; i++)
           				{
           				
           					if(i!=d.length-1 && d[i]!=null)
           						out.print(d[i]+", ");
           					else if(d[i]!=null)
           						out.print(d[i]);
           				
           				}
           			
           			 %>
       </label>
       </div>
       </div>
       
    </fieldset>
          
    
    
    
    
    <fieldset>
    <legend><strong>&nbsp;Old Fees Details</strong></legend>
         
           <div class="form-group">
           <label class="col-sm-3 control-label" >Total fee(included registration amount) :</label>
           <div class="col-sm-6"> 
           <label class="control-label"><%=old_actual_fee %></label>
           </div>
           </div>
           
           <div class="form-group">
           <label class="col-sm-3 control-label" >Due fee(if any) :</label>
           <div class="col-sm-6"> 
           <label class="control-label"><%=old_due_amt %></label>
           </div>
           </div>
    
           <div class="form-group">
           <label class="col-sm-3 control-label" > Deposited fee :</label>
           <div class="col-sm-6"> 
           <label class="control-label"><%=old_dep_fee %></label>
           </div>
           </div>
    </fieldset>
    
    
    <fieldset>
    <legend><strong>&nbsp;Final Fees Details</strong></legend>
         
           <div class="form-group">
           <label class="col-sm-3 control-label" >Total Fees :</label>
           <div class="col-sm-6"> 
           <%
           try
           {
	           
	             %>
	             <label class="control-label"><%=final_fee%> </label>
	             
	           <%            
	           
	             // System.out.println("Inside else");
	             
	            
           }
           catch(Exception e)
           {
             e.printStackTrace();
           }
             %>
           </div>
           </div>
           
           <div class="form-group">
           <label class="col-sm-3 control-label" >Current Fee :</label>
           <div class="col-sm-6"> 
          
	                 <input type="text" name="expectedfee" class="form-control" id="curfee" value="<%=cur_fee%>"></input>
	          
           </div>
           </div>
           
           
           
           
           
        
           <div class="form-group">
           <label class="col-sm-3 control-label" >Total Due ( Current Fee + Dues ) :</label>
           <div class="col-sm-6"> 
           <%
             try
             {
	             
	                 %>
	                 <input type="text" name="expectedfee" class="form-control" id="expfee" value="<%=expected_fee%>"></input>
	                          
	                 <% 
	             
	             
             
             }
             catch(Exception e)
             {
               e.printStackTrace();
             }
           
            %>
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
