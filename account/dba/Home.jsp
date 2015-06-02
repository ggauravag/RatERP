<%@page import="com.login.SendMail"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
boolean isAdmin = false;
Connection con = null;

	String type = (String)session.getAttribute("type");
	if(type != null && type.equals("DBA"))
	{
		isAdmin = true;
	}
	else
	{
		response.sendRedirect("../Unauthorize.jsp");
		return;
	}


try
{


con = DBInfo.getConn();

	

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
   <title>Database Admin Panel</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  
 

    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./css/navbar-fixed-top.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="./js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="./js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
textarea {
   font-size: 10pt;
   font-family: Arial;
   font-weight:bold;
} 
</style>
   
  </head>

 <body>

    <!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" >RAT Database Management Panel </a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li ><a href="account/dba/Home.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;Home</a></li>
          
           
          </ul>
          <ul class="nav navbar-nav navbar-right">
          	 <li><a style="color: blue">Welcome ! <%=session.getAttribute("name") %></a></li>
            <li><a href="Logout.jsp"><span class="glyphicon glyphicon-off"></span>&nbsp;Log Out</a></li>
          
           
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    
       <form class="form-horizontal" role="form" method="post" >
	      <fieldset>
	       <legend> <h2>&nbsp;&nbsp;Query Space</h2><input type="submit" name="exe" class="btn btn-success col-sm-offset-1" value="Execute"><input type="reset" class="btn btn-default col-sm-offset-1" value="Clear Space"></legend>
	       
	       <textarea cols="145" rows="10" name="query" style="font-size:bold" class="col-sm-offset-1"></textarea>
	       
	        </fieldset>
        
        </form>
        <fieldset>
        <legend> <h2>&nbsp;&nbsp;Result Space</h2></legend>
       <%
       			if(request.getParameter("exe")!=null)
       			{
       				String query = request.getParameter("query");
       				System.out.println("The query is : "+query);
       				
       				String queries[] = query.split(";");
       				System.out.println("No of queries : "+queries.length);
       				
       				ResultSet rs = null;
	       			int result = 0;
	       			boolean isResult = false;
       				
       				
       		try
       		{		
       				java.util.Date startDate = new java.util.Date();
       				java.util.Date endDate = new java.util.Date();
       				for(int i = 0; i < queries.length; i++)
       				{
       					boolean isSelect = queries[i].startsWith("select") || queries[i].startsWith("SELECT") || queries[i].startsWith("show") || queries[i].startsWith("SHOW");
	       				boolean isUpdate = queries[i].startsWith("update") || queries[i].startsWith("UPDATE");
	       				boolean isDelete = queries[i].startsWith("delete") || queries[i].startsWith("DELETE");
	       				boolean isCreate = queries[i].startsWith("create") || queries[i].startsWith("CREATE");
	       				boolean isDrop = queries[i].startsWith("drop") || queries[i].startsWith("DROP");
	       				boolean isTruncate = queries[i].startsWith("truncate") || queries[i].startsWith("truncate");
	       				boolean isAlter = queries[i].startsWith("alter") || queries[i].startsWith("ALTER");
	       				boolean isInsert = queries[i].startsWith("insert") || queries[i].startsWith("INSERT");
	       				boolean isDesc = queries[i].startsWith("desc") || queries[i].startsWith("DESC");
	       				
	       				
	       				if(isSelect || isDesc)
	       				{
	       					System.out.println("Its a select query");
	       					PreparedStatement ps = con.prepareStatement(queries[i]);
	       					rs = ps.executeQuery();
	       					isResult = true;
	       				}
	       				else if(isUpdate || isDelete || isInsert)
	       				{
	       					System.out.println("Its a update or delete");
	       					PreparedStatement ps = con.prepareStatement(queries[i]);
	       					startDate = new java.util.Date();
	       					result = ps.executeUpdate();
	       					endDate = new java.util.Date();
	       				}
	       				else if(isCreate || isAlter)
	       				{
	       					System.out.println("Its a create query");
	       					PreparedStatement ps = con.prepareStatement(queries[i]);
	       					startDate = new java.util.Date();
	       					result = ps.executeUpdate();
	       					endDate = new java.util.Date();
	       				
	       				}
	       				else if(isDrop || isTruncate)
	       				{
	       					System.out.println("Its an alter query");
	       					PreparedStatement ps = con.prepareStatement(queries[i]);
	       					startDate = new java.util.Date();
	       					result = ps.executeUpdate();
	       					endDate = new java.util.Date();
	       				}
	       				else
	       				{
	       					System.out.println("its none of these");
	       					PreparedStatement ps = con.prepareStatement(queries[i]);
	       					startDate = new java.util.Date();
	       					result = ps.executeUpdate();
	       					endDate = new java.util.Date();
	       				}
	       				
	       				
	       				
       				}
       				
       				
       				if(isResult)
       				{
       					ResultSetMetaData metadata = rs.getMetaData();
       					int columns = metadata.getColumnCount();
       					%>
       						<div>
							  <table class="table table-striped" style="margin-left:20px;" >
							  <tr>
							  <%
							  	for(int col = 1; col <= columns; col++)
							  	{
							  		%><th><%=metadata.getColumnName(col).toUpperCase() %></th><%
							  	}
							  	
							  	
							   %>	
							  </tr>
							  <%
							  
							  while(rs.next())
							  {
							  %><tr><%
							  	for(int col = 1; col <= columns; col++)
							  	{
							  		if(metadata.getColumnType(col) == Types.VARCHAR)
							  		{	%><td><%=rs.getString(col) %></td><% }
							  		if(metadata.getColumnType(col) == Types.INTEGER)
							  		{	%><td><%=rs.getInt(col) %></td><% }
							  		if(metadata.getColumnType(col) == Types.CHAR)
							  		{	%><td><%=rs.getString(col) %></td><% }
							  		if(metadata.getColumnType(col) == Types.DATE)
							  		{	%><td><%=rs.getDate(col) %></td><% }
							  		if(metadata.getColumnType(col) == Types.TIME)
							  		{	%><td><%=rs.getTime(col) %></td><% }
							  		if(metadata.getColumnType(col) == Types.TIMESTAMP)
							  		{	%><td><%=rs.getTimestamp(col) %></td><% }
							  	}
							  %></tr><%
							  }
							   %>
							  </table>
							</div>
       					
       					
       					
       					
       					
       					
       					<%
       				}
       				else
       				{
       				long msElapsedTime =(endDate.getTime() - startDate.getTime());
       					%>
       				<div class="alert alert-info" role="alert"><%=result %> row(s) affected<br><%=msElapsedTime %> ms taken</div>
       				<%
       				
       				}
       			}
       			catch(Exception e)
       			{
       				%>
       				<div class="alert alert-danger" role="alert"><%=e.getMessage() %></div>
       				<%
       			}
       			
       		}
       
        %>
       
       
		  
	
          </fieldset>
        </p>
     


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
  </body>
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
  	if(con!=null)
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