<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.EOFException"%>
<%@page import="com.login.Option"%>
<%@page import="com.login.SetPrivilege"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="com.login.SendMail"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


	try
	{
	String type = (String)session.getAttribute("type");
	if(type != null && (type.equals("ADMIN")))
		{
			
		}
		else
		{
			response.sendRedirect("../Unauthorize.jsp");
			return;
		}
	

	String path1 = request.getServletContext().getRealPath("/privilege/");
	Dictionary<String,Integer> dic = new Hashtable<String,Integer>();
			dic.put("Manage Student Records", 0);
			dic.put("Manage Classes", 1);
			dic.put("Manage Accounts", 2);
			dic.put("Student Registration", 3);
			dic.put("Contact Student", 4);
			dic.put("Manage Courses", 5);
			dic.put("Manage Employees", 6);
			dic.put("Upload Study Material", 7);
			dic.put("Manage Certification", 8);
			dic.put("View Feedback", 9);
			dic.put("View Assignment/Problems", 10);
			dic.put("Student Interaction", 11);
			dic.put("View Schedule", 12);
			dic.put("Interact with Faculty", 13);
			dic.put("View Account Details", 14);
			dic.put("View Study Material", 15);
			dic.put("View Schedule", 16);
			
			
			Vector v[] = new Vector[20];
  			Option opt[] = new Option[20];
  
			  for(int i = 0; i < 20;i++)
			  {
			  	v[i] = new Vector();
			  }
			  
			
            
            v[0].add("Search Student");
            v[0].add("Issue ID Card");
            v[0].add("Fee Record");
			v[0].add("Edit Student Details");
			v[0].add("Issue Study Material");
			opt[0] = new Option("Manage Student Records",v[0]);
			
			
			v[1].add("View Classes");
            v[1].add("Add New Classes");
            v[1].add("Edit Class");
            v[1].add("View Time Table");
			opt[1] = new Option("Manage Classes",v[1]);
			
			
			v[2].add("Add Expenditure");
            v[2].add("View Balance Sheet");
			v[2].add("View Fee Deposited");
			opt[2] = new Option("Manage Accounts", v[2]);
			
			v[3].add("Register Student");
			v[3].add("Manage Queries");
			opt[3] = new Option("Student Registration", v[3]);
			
			
			v[4].add("Send Email/SMS");
            //v[4].add("Send SMS");
            opt[4] = new Option("Contact Student", v[4]);
            
            
            v[5].add("Add New Course");
          
			v[5].add("Edit/Delete Course");
			v[5].add("Manage Packages");
			opt[5] = new Option("Manage Courses", v[5]);
			
			
			 v[6].add("Add New Employee");
            v[6].add("Enable/Disable Employee");
			v[6].add("Manage Privileges");
			v[6].add("Manage Employee Record");
			opt[6] = new Option("Manage Employees", v[6]);
			
			
			v[7].add("Project/Notes");
            v[7].add("Assignment");
            opt[7] = new Option("Upload Study Material", v[7]);
            
             v[8].add("Enroll Student");
            v[8].add("Issue/View Certificates");
            opt[8] = new Option("Manage Certification", v[8]);
            
            
         
            v[9].add("Class Feedback");
			v[9].add("Take Action");
			opt[9] = new Option("View Feedback", v[9]);
			
			
			v[10].add("Faculty Assignment");
            v[10].add("Student Problems");
            opt[10] = new Option("View Assignment/Problems", v[10]);
            
            v[11].add("View Feedback");
            v[11].add("View Request");
            opt[11] = new Option("Student Interaction", v[11]);
            
              v[12].add("View Class Schedule");
            opt[12] = new Option("View Schedule", v[12]);
            
            v[13].add("Raise Problem");
            v[13].add("Give Feedback");
            opt[13] = new Option("Interact with Faculty", v[13]);
            
            v[14].add("Account Details");
            v[14].add("Course Details");
            opt[14] = new Option("View Account Details", v[14]);
            
            
            v[15].add("Notes/Assignment");
            opt[15] = new Option("View Study Material", v[15]);
            
            
            v[16].add("View Trainer Schedule");
            opt[16] = new Option("View Schedule", v[16]);
            
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Manage Privilege</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<script type="text/javascript">
	
	function callAjax(utype)
	{
		if(utype == "null")
		{
		document.getElementById("data").innerHTML = "";
			return;
		}
			
		//alert("Funtion called");
		document.forms["uForm"].submit();
	}
	
	
	
	setTimeout(function (){document.getElementById("utype").value = "<%=request.getParameter("type")%>";}, 0);
	</script>

  </head>
  
  <body>
  <form method="post" name="uForm">
  	<input type="hidden" name="form" value="uForm">
   		<fieldset>
   			<legend>Manage Privilege</legend>

	<div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Select User Type : </label>
    
    <div class="col-sm-4">
    <select name="type" id="utype" class="form-control" onchange="callAjax(this.value)">
    <option value="null">---- Select ----</option>
   		<option value="ADMIN">ADMIN</option>
   		<option value="TRAINER">TRAINER</option>
   		<option value="HELPDESK">HELPDESK</option>
   		<option value="STUDENT">STUDENT</option>
    </select>
    
    </div>   
    </div>		
   		</fieldset>
   		
   		
   		<fieldset>
   			<legend>Current Privileges</legend>
   			<div class="form-group" id="data">
   			<%
   				if(request.getParameter("update") != null && request.getParameterValues("options")!=null)
   				{
   					String opts[] = request.getParameterValues("options");
   					type = request.getParameter("type");
   					ObjectOutputStream output = SetPrivilege.openFile(type,path1);
 					
 					if(output == null)
 					{
 						System.out.println("Type : "+type+", Path is : "+path1+", OUtput is : "+output);
 					}
 					
   					for(int i = 0; i < opts.length; i++)
   					{
   						System.out.println("Option number (opts[i]) : "+opts[i]+", opt[opts[i]] : "+opt[Integer.parseInt(opts[i])].getHeader());
   					 	output.writeObject(opt[Integer.parseInt(opts[i])]);
   					}   				
   					
   					output.flush();
   					output.close();
   				
   				}
   				
   				if(request.getParameter("reset") != null)
   				{
   					response.sendRedirect("../../Support.jsp");
   					return;
   				
   				}
   			
   			
   				if(request.getParameter("type")!=null)
   				{
   					type = request.getParameter("type");
   					ObjectInputStream input = null;
   					try
   					{
		   					System.out.println(path1);
		   					input = SetPrivilege.readFile(type, path1);
		   					if(input == null)
				        	{
				        		System.out.println("Outer .....Unable to open file");
				        		
				        		return;
				        	}
				        	Option option;
				        	while(true)
				        	{
				        		option = (Option)input.readObject();
				        		if(option == null)
				        		{
				        			//System.out.println("No object to be read");
				        		}
				        		else
				        		{
				        			//System.out.println("Object read");
				        		}
				        		
				        		
				        		%>
				        			
				            			<input type="checkbox" class="" checked name="options" value="<%=dic.get(option.getHeader())%>" ><label class="control-label">&nbsp;&nbsp;<%=option.getHeader()%></label>
				        				<ul>
				        		<%
				        		Vector<String> options = option.getOptions();
				        		int size = options.size();
				        		for(int i = 0; i < size; i++)
				        		{
				        			String op = options.elementAt(i);
				        			
				   					%>
				   						<li><%=op %></li>
				   					<%
				        		}
				        		out.println("</ul>");
				        	
				        	}
   					}
			        catch(EOFException exp)
			        {
			        	//System.out.println("File read complete");
			        	input.close();
			        	SetPrivilege.closeInput();
			        }
   				}
   			
   			
   			
   			
   			
   			
   			 %>
   			</div>
   			<input type="submit" name="update" value="Save Privileges" class="btn-lg btn-success col-sm-offset-2">
   			<input type="submit" name="reset" value="Reset Default" class="btn-lg btn-reset col-sm-offset-3">
   		</fieldset>
   		
   		
   		</form>
  </body>
  <%
  	}
  	catch(Exception e)
  	{
  		e.printStackTrace();
  		SendMail.sendReport(e, basePath);
  		response.sendRedirect("../Error.jsp");
  	}
  
   %>
</html>
