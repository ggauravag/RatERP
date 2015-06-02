<%@ page import="java.io.EOFException"%>
<%@ page import="java.io.ObjectInputStream"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.login.*"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";



if(session == null)
{
	response.sendRedirect("Unauthorize.jsp");
	return;
}

Dictionary dict = new Hashtable<String, String>();
dict.put("Manage Student Records", "glyphicon glyphicon-folder-open");
dict.put("Manage Classes", "glyphicon glyphicon-dashboard");
dict.put("Manage Accounts", "glyphicon glyphicon-folder-close");
dict.put("Accounts", "glyphicon glyphicon-folder-close");
dict.put("Student Registration","glyphicon glyphicon-file");
dict.put("Contact Student","glyphicon glyphicon-envelope");
dict.put("Manage Courses", "glyphicon glyphicon-list-alt");
dict.put("Manage Employees","glyphicon glyphicon-user");
dict.put("Upload Study Material","glyphicon glyphicon-book");
dict.put("Manage Certification","glyphicon glyphicon-euro");
dict.put("View Feedback","glyphicon glyphicon-hand-left");
dict.put("View Assignment/Problems", "glyphicon glyphicon-file");
dict.put("Student Interaction", "glyphicon glyphicon-transfer");
dict.put("View Schedule", "glyphicon glyphicon-time");
dict.put("View Study Material", "glyphicon glyphicon-book");
dict.put("View Account Details", "glyphicon glyphicon-folder-open");
dict.put("Interact with Faculty", "glyphicon glyphicon-transfer");

dict.put("Register Student", "student/registrationstudent.jsp");
dict.put("Manage Queries", "student/RegisterQuery.jsp");
dict.put("Search Student", "student/searchStudent.jsp");
dict.put("Issue ID Card", "student/IssueIDStudent.jsp");
dict.put("Fee Record", "student/FeeRecord.jsp");
dict.put("Edit Student Details", "student/EditStudentDetails.jsp");
dict.put("Issue Study Material", "student/IssueSM.jsp");
dict.put("View Classes", "class/ViewClass.jsp");
dict.put("Add New Classes", "class/NewClass.jsp");
dict.put("Edit Class", "class/EditClass.jsp");
dict.put("View Time Table", "class/TimeTable.jsp");
dict.put("Add Expenditure", "account/helpdesk/AddExpenditure.jsp");
dict.put("View Balance Sheet", "account/admin/BalanceSheet.jsp");
dict.put("View Fee Deposited", "account/admin/ViewDepFee.jsp");
dict.put("Send Email/SMS", "contact/ContactStudent.jsp");
//dict.put("Send SMS", "student/registrationstudent.jsp");
dict.put("Add New Course", "course/AddNewCourse.jsp");

dict.put("Edit/Delete Course", "course/EditDeleteCourse.jsp");
dict.put("Manage Packages", "course/ManagePackage.jsp");
dict.put("Add New Employee", "employee/AddNewEmp.jsp");
dict.put("Enable/Disable Account", "employee/ManagePriv.jsp");
dict.put("Manage Privileges", "account/admin/ManagePrivilege.jsp");
dict.put("Manage Employee Record", "employee/ManageEmp.jsp");
dict.put("Project/Notes", "account/upload/UploadNotes.jsp");
dict.put("Assignment", "account/upload/UploadAssignment.jsp");
dict.put("Enroll Student", "account/helpdesk/Enroll.jsp");
dict.put("View/Search Certification", "student/registrationstudent.jsp");

dict.put("Class Feedback", "account/admin/ClassFeedback.jsp");
dict.put("Take Action", "account/admin/TakeAction.jsp");
dict.put("Faculty Assignment", "account/admin/FacultyAssignment.jsp");
dict.put("Student Problems", "account/admin/StudentProblems.jsp");
dict.put("Raise Problem","account/student/RaiseProblem.jsp");
dict.put("Account Details", "account/student/EditStudentAccountDetails.jsp");
dict.put("Course Details", "account/student/StuCourses.jsp");
dict.put("Give Feedback", "account/student/GiveFeedback.jsp");
dict.put("Notes/Assignment","account/student/ViewUploads.jsp");
dict.put("View Feedback","account/trainer/ViewFeedback.jsp");
dict.put("View Request","account/trainer/ViewRequest.jsp");
dict.put("View Class Schedule","account/trainer/ViewSchedule.jsp");
dict.put("View Trainer Schedule","account/helpdesk/ViewClassSchedule.jsp");
dict.put("Issue/View Certificates","account/helpdesk/IssueCertificate.jsp");

String type=(String)session.getAttribute("type");
String name = (String)session.getAttribute("name");

 if(type == null || name == null)
 {
 	response.sendRedirect("Unauthorize.jsp");
 	return;
 }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="icon" href="css/images/ratico.ico">
	<title>RAT Panel</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/dashboard.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
     <script>
		function loadPanel(file, divID)
		{
		var xmlhttp;
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
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
		    document.getElementById(divID).innerHTML=xmlhttp.responseText;
		    }
		  }
		xmlhttp.open("POST", file, true);
		xmlhttp.send(null);
		}
		
		
</script>    
    
  </head>
  
  <body>

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Road Ahead Technologies</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#"><span class="glyphicon glyphicon-dashboard"></span>&nbsp;Dashboard</a></li>
            <li><a href="#"><span class="glyphicon glyphicon-cog"></span>&nbsp;Settings</a></li>
            <li><a href="#"><span class="glyphicon glyphicon-user"></span>&nbsp;Profile</a></li>
            <li><a href="#"><span class="glyphicon glyphicon-hand-up"></span>&nbsp;Help</a></li>
            <li><a href="Logout.jsp"><span class="glyphicon glyphicon-off"></span>&nbsp;Log Out</a></li>
          </ul>
           <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form> 
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
        
        
        <%
        ObjectInputStream input = null;
        try
        {
        	String path1 = request.getServletContext().getRealPath("/privilege/");
        	if(type.equals("DBA"))
        	{
        		response.sendRedirect("account/dba/Home.jsp");
        		return;
        	}
        	if(type!=null)
        	{
        		input = SetPrivilege.readFile(type, path1);
        	}
        	else
        	{
        		response.sendRedirect("Unauthorize.jsp");
        		return;
        	}
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
        			<ul class="nav nav-sidebar">
            			<li class="active"><a><span class="<%=(String)dict.get((String)option.getHeader())%>"></span>&nbsp;&nbsp;<%=(String)option.getHeader()%></a></li>
        		<%
        		Vector<String> options = option.getOptions();
        		int size = options.size();
        		for(int i = 0; i < size; i++)
        		{
        			String op = options.elementAt(i);
        			
        			dict.get(op);
        			out.println();
        			%><li><a target="iframe" href="<%=(String)dict.get(op)%>" ><%=op %></a></li><%

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
        catch(Exception e)
        {
        	e.printStackTrace();
			SendMail.sendReport(e, basePath);
        	response.sendRedirect("Error.jsp");
        }
        
         %>
      
        </div>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
       		
       		
       		
          <div class="page-header"><h2>Dashboard</h2></div>
          <h3 align="right">Welcome ! <%=name %></h3>
          
           		<iframe style="margin-top:-10px;" sandbox="allow-same-origin allow-scripts allow-forms allow-top-navigation allow-popups" scrolling="no" name="iframe" width="1083" seamless height="1500" frameborder=0></iframe>
        </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/docs.min.js"></script>
  </body>
</html>
