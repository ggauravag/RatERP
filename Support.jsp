<%@page import="com.login.AppendableObjectOutputStream"%>
<%@page import="com.login.Option"%>
<%@page import="java.io.File"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="com.login.SetPrivilege"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(request.getServletContext().getRealPath("/privilege/"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Support.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  </head>
  
  <body>
  
  <%
  String path1 = request.getServletContext().getRealPath("/privilege/");
  //System.out.println(path1);
  
  
  
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
            v[6].add("Enable/Disable Account");
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
            
            v[17].add("Add Expenditure");
            opt[17] = new Option("Accounts", v[17]);
            
            
            
            
            
  //v.add("Take Action");
 // v.add("Manage Employee Record");
  //v.add("Add Study Material Issuance");
    ObjectOutputStream output = SetPrivilege.openFile("ADMIN",path1);
  
  output.writeObject(opt[0]);
  output.writeObject(opt[1]);
  output.writeObject(opt[2]);
  output.writeObject(opt[3]);
  output.writeObject(opt[4]);
  output.writeObject(opt[5]);
  output.writeObject(opt[6]);
  output.writeObject(opt[7]);
  output.writeObject(opt[8]);
  output.writeObject(opt[9]);
  output.writeObject(opt[10]);
  output.writeObject(opt[11]);
  output.writeObject(opt[16]);
  output.flush();
  output.close();
  
  
  
  ObjectOutputStream output1 = SetPrivilege.openFile("STUDENT", path1);
  output1.writeObject(opt[14]);
  output1.writeObject(opt[15]);
  output1.writeObject(opt[13]);
  output1.flush();
  output1.close();
  
  ObjectOutputStream output2 = SetPrivilege.openFile("HELPDESK", path1);
  output2.writeObject(opt[0]);
  output2.writeObject(opt[1]);
  output2.writeObject(opt[3]);
  output2.writeObject(opt[4]);
  output2.writeObject(opt[5]);
  output2.writeObject(opt[8]);
  output2.writeObject(opt[16]);
  output2.writeObject(opt[17]);
  output2.flush();
  output2.close();
  
  ObjectOutputStream output3 = SetPrivilege.openFile("TRAINER", path1);
  output3.writeObject(opt[7]);
  output3.writeObject(opt[11]);
  output3.writeObject(opt[12]);
  output3.flush();
  output3.close();
  
  
   %>
    <h1 align="center">Default Privileges has been set successfully</h1> <br>
  </body>
</html>
