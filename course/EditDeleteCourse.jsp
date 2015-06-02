<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.EOFException"%>
<%@page import="java.io.ObjectInputStream"%>
<%@ page import="java.sql.*, com.login.*" %>
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
             
             
                      Connection con = null;
						 try
						 {
 
 
                           con = DBInfo.getConn();
                  
                  
		        if(request.getParameter("courseid")!=null && !request.getParameter("courseid").equals("") && request.getParameter("showCfee")!=null && request.getParameter("showCdur")!=null && request.getParameter("showCname")!=null)
		         {
            
               
               
                      PreparedStatement ps5=con.prepareStatement("update course set name=?,fees =?,duration=? where courseid=?");
                      ps5.setString(1, request.getParameter("showCname"));
                      ps5.setInt(2, Integer.parseInt(request.getParameter("showCfee")));
                      ps5.setInt(3, Integer.parseInt(request.getParameter("showCdur")));
                      ps5.setInt(4, Integer.parseInt(request.getParameter("courseid")));                           
                      int i=ps5.executeUpdate();
                      if(i==1)
                      {
                         response.sendRedirect(basePath +"course/EditDeleteCourse.jsp?updated=yes");
                
                      }
                  } 
                  
                  if(request.getParameter("dbcourseid")!=null && !request.getParameter("dbcourseid").equals("") && request.getParameter("showCfee")!=null && request.getParameter("showCdur")!=null && request.getParameter("showCname")!=null)
		         {
            
               
               
                      PreparedStatement ps5=con.prepareStatement("update dbcourse set dbname=?,duration=?,fees =? where dbid=?");
                      ps5.setString(1, request.getParameter("showCname"));
                      ps5.setInt(2, Integer.parseInt(request.getParameter("showCdur")));
                      ps5.setInt(3, Integer.parseInt(request.getParameter("showCfee")));
                      ps5.setInt(4, Integer.parseInt(request.getParameter("dbcourseid")));                           
                      int i=ps5.executeUpdate();
                      if(i==1)
                      {
                         response.sendRedirect(basePath +"course/EditDeleteCourse.jsp?updated=yes");
                
                      }
                  } 
           

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="icon" href="css/images/ratico.ico">
    <title>Edit Courses</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
   
    <script src="js/ie-emulation-modes-warning.js"></script>   
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">

function loadtable(id) //Showing courses
	{
	
	var xmlhttp;
	//alert("ajax called with data"+id);
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
	         document.getElementById("fill").innerHTML=xmlhttp.responseText;
	    	 //alert(xmlhttp.responseXML);	    	
	     }
	   
	   }
	  
	var path = "<%=basePath%>"+"course/MPback.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(id);
	}



function loadid(id) // Putting values in textboxes 
	{
	
	var xmlhttp;
	//alert("ajax called with data"+cid);
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
	         x=xmlhttp.responseXML.documentElement.getElementsByTagName("COURSE");
	    	// y=xmlhttp.responseXML.documentElement.getElementsByTagName("DBCOURSE");
	    	
	    	
	    	if(x[0]==null )
	    	{
	    		
	    		empty();
	    		return;
	    	}
	    	
	    	/*  if(y[0]!=null && x[0]==null)
	    	{
	    	
	    	var cid = x[0].getElementsByTagName("DBID");
	    	cid = cid[0].firstChild.nodeValue;
	    	
	    	
	    	var nm = x[0].getElementsByTagName("DBNAME");
	    	nm = nm[0].firstChild.nodeValue;
	    	
	    	var dur = x[0].getElementsByTagName("DBDUR");
	    	dur = dur[0].firstChild.nodeValue;
	    	
	    	var cf = x[0].getElementsByTagName("DBFEE");
	    	cf = cf[0].firstChild.nodeValue;
	    	
	    	
	    	document.getElementById("Crid").value = cid;
	    	document.getElementById("CName").value = nm;
	    	document.getElementById("CFee").value= cf;
	        document.getElementById("CDur").value= dur;
	    	} */
	    	
	     if(x[0]!=null)
	    	{
	    	
	    	var cid = x[0].getElementsByTagName("CID");
	    	cid = cid[0].firstChild.nodeValue;
	    	
	    	
	    	var nm = x[0].getElementsByTagName("NAME");
	    	nm = nm[0].firstChild.nodeValue;
	    	
	    	var cf = x[0].getElementsByTagName("FEE");
	    	cf = cf[0].firstChild.nodeValue;
	    	
	    	
	    	var dur = x[0].getElementsByTagName("DUR");
	    	dur = dur[0].firstChild.nodeValue;
	    	  
	    	  	 empty();
	    	document.getElementById("Crid").value = cid;
	    	document.getElementById("CName").value = nm;
	    	document.getElementById("CFee").value= cf;
	        document.getElementById("CDur").value= dur;
	    	}
	    	
	    
	    	
	      
	     }
	   
	   }
	  
	var path = "<%=basePath%>"+"course/MPback.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(id);
	}
	
	
	function loaddb(id) // Putting values in textboxes 
	{
	
	var xmlhttp;
	//alert("ajax called with data"+cid);
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
	         x=xmlhttp.responseXML.documentElement.getElementsByTagName("DBCOURSE");
	    	// y=xmlhttp.responseXML.documentElement.getElementsByTagName("DBCOURSE");
	    	
	    	
	    	if(x[0]==null )
	    	{
	    		
	    		empty();
	    		return;
	    	}
	    	
	    	
	    	
	     if(x[0]!=null)
	    	{
	    	//alert("he");
	    	var cid = x[0].getElementsByTagName("DBID");
	    	cid = cid[0].firstChild.nodeValue;
	    	
	    	
	    	var nm = x[0].getElementsByTagName("DBNAME");
	    	nm = nm[0].firstChild.nodeValue;
	    	
	    	var cf = x[0].getElementsByTagName("DBFEE");
	    	cf = cf[0].firstChild.nodeValue;
	    	
	    	
	    	var dur = x[0].getElementsByTagName("DBDUR");
	    	dur = dur[0].firstChild.nodeValue;
	    	  
	    	  	 empty();
	    	document.getElementById("DBCrid").value = cid;
	    	document.getElementById("CName").value = nm;
	    	document.getElementById("CFee").value= cf;
	        document.getElementById("CDur").value= dur;
	    	}
	    	
	    
	    	
	      
	     }
	   
	   }
	  
	var path = "<%=basePath%>"+"course/MPback.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(id);
	}
	




function CriteriaSelected(Criteria)
     {
       if(Criteria == "" || Criteria == null)
       {
           
       }
     
       else if(Criteria == "1")     //student id is selected
       {
           empty();
           loadtable("lang=lang");
           
       }
       
       else if(Criteria == "2")
       {
           empty();
           loadtable("db=db");
       }
     }

function empty()
{
 document.getElementById("DBCrid").value="";
  document.getElementById("CName").value="";
  document.getElementById("CFee").value="";
  document.getElementById("CDur").value="";
  document.getElementById("Crid").value="";
}

function demo(id)
{
    empty();
    loadid("lid="+id);
}

function dellang(id)
{
     empty();
     loadtable("deletelg="+id);
}

function demodb(id)
{
    empty();
    loaddb("dbid="+id);
}

function deldb(id)
{
     empty();
     loadtable("deletedb="+id);
}
</script>
  </head>
  
  <body>
           <form method="post" name="form" class="form-horizontal" >
    
         
         <fieldset>
          <legend><h1><strong>&nbsp;Edit Courses</strong></h1></legend>
         
         
         <%
           if (request.getParameter("updated")!=null)
        {
            %>

    <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Course updated.
   		 </div>

            <%
           
           
            
        }
        
        
         %> 
         
          
           <div class="form-group">
           <label for="selectCriteria" class="col-sm-2 control-label" align="left">Select Course type :</label>
           <div class="col-sm-3">
           <select name="selectCriteria" id="selectCriteria" class="form-control" onchange="CriteriaSelected(this.value);">
           <option value="" selected="selected">Select</option>
           <option value="1">Language</option>
           <option value="2">Database</option>
          </select>
          </div>
          </div>
          
          
          <div id="fill" >
          
          </div>
          
          
          <input type="hidden" id="Crid" name="courseid" value=""></input> 
		   	 <input type="hidden" id="DBCrid" name="dbcourseid" value=""></input>
		   	 
							<div class="form-group"> 
					 		    <label for="showCname" class="col-sm-3 control-label">Course name: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="showCname" class="form-control" id="CName" required="true"></input>
					 		    </div> 
					   		</div> 
					   		
					   		<div class="form-group"> 
					 		    <label for="fee" class="col-sm-3 control-label">Course Fee: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="showCfee" class="form-control" id="CFee" required="true"></input>
					 		    </div> 
					   		</div> 
					   		
					   		<div class="form-group"> 
					 		    <label for="dur" class="col-sm-3 control-label">Course Duration: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="showCdur" class="form-control" id="CDur" required="true"></input>
					 		    </div> 
					   		</div> 
					   		
					   		
					   		<div class="form-group">  		
					<div class="col-sm-offset-4">   		
		   	 <input type="submit" class="btn btn-primary" value="Update Course >>>">
		   	  </div>
		   	 </div>
					   		
				<%
        	}
       		catch(Exception e)
       		{
       			e.printStackTrace();
       			response.sendRedirect("../Error.jsp");
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
          
          
            </fieldset>
          
      </form>
  </body>
</html>
