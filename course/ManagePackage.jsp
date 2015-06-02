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
                           
                          int count_pid=0;
         PreparedStatement ps3 = con.prepareStatement("select * from count_user");
         ResultSet rs3 = ps3.executeQuery();
         
         if(rs3.next())
         {
             
             count_pid = rs3.getInt("count_pid");
         }
         
         if(request.getParameter("packageid")!=null && !request.getParameter("packageid").equals(""))
         {
             int ppid = Integer.parseInt(request.getParameter("packageid"));
               
               
                      PreparedStatement ps5=con.prepareStatement("update package set fee =?,name=?,num_lang=?,num_db=? where pid=?");
                      ps5.setInt(1, Integer.parseInt(request.getParameter("showAfee")));
                      ps5.setString(2, request.getParameter("Pname"));
                      ps5.setInt(3, Integer.parseInt(request.getParameter("Nlang")));
                      ps5.setInt(4, Integer.parseInt(request.getParameter("Ndb")));                     
                      ps5.setInt(5, ppid);
                      ps5.executeUpdate();
               
               
               
               
              /* if(request.getParameter("showAfee")!=null)
              {
                      PreparedStatement ps5=con.prepareStatement("update package set fee =? where pid=?");
                      ps5.setInt(1, Integer.parseInt(request.getParameter("showAfee")));
                      ps5.setInt(2, ppid);
                      ps5.executeUpdate();
              }
              
               if(request.getParameter("Pname")!=null)
              {
                      PreparedStatement ps5=con.prepareStatement("update package set name =? where pid=?");
                      ps5.setString(1, request.getParameter("Pname"));
                      ps5.setInt(2, ppid);
                      ps5.executeUpdate();
              }
               if(request.getParameter("Nlang")!=null)
              {
                      PreparedStatement ps5=con.prepareStatement("update package set num_lang =? where pid=?");
                      ps5.setInt(1, Integer.parseInt(request.getParameter("Nlang")));
                      ps5.setInt(2, ppid);
                      ps5.executeUpdate();
              }
              if(request.getParameter("Ndb")!=null)
              {
                      PreparedStatement ps5=con.prepareStatement("update package set num_db =? where pid=?");
                      ps5.setInt(1, Integer.parseInt(request.getParameter("Ndb")));
                      ps5.setInt(2, ppid);
                      ps5.executeUpdate();
              }  */
              
                //session.setAttribute("updated", "yes");
                response.sendRedirect(basePath +"course/ManagePackage.jsp?updated=yes");
                
              
         }
         
        if( request.getParameter("showAfee")!=null && request.getParameter("Pname")!=null && request.getParameter("Nlang")!=null && request.getParameter("Ndb")!=null)
         {
           
              
              System.out.println("inside if block");
              PreparedStatement ps4=con.prepareStatement("insert into package values(?,?,?,?,?)");
              ps4.setInt(1, count_pid); 
              ps4.setInt(2, Integer.parseInt(request.getParameter("showAfee")));
              ps4.setString(3, request.getParameter("Pname"));
              ps4.setInt(4, Integer.parseInt(request.getParameter("Nlang")));
              ps4.setInt(5, Integer.parseInt(request.getParameter("Ndb")));
             
              int j = ps4.executeUpdate();
              System.out.println("Package inserted successfully");
              
              
              count_pid++;
              PreparedStatement ps5=con.prepareStatement("update count_user set count_pid=?");
              ps5.setInt(1, count_pid); 
              int k = ps5.executeUpdate();
              System.out.println("count updated for package");
              
              
               if(j==1 && k==1)
              {               
                //session.setAttribute("added", "yes");
                response.sendRedirect(basePath +"course/ManagePackage.jsp?added=yes");
                
              }
              else
              {
                //session.setAttribute("notadded", "no");
               response.sendRedirect(basePath +"course/ManagePackage.jsp?notadded=no");
              }
         
         }
       
         
        
                           
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <link rel="icon" href="css/images/ratico.ico">
    <title>Manage Package</title>
    
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

  function show(id)
  {
    if(document.getElementById(id).checked==true)
    {
      if(document.getElementById("cfee").value =="")
      {
       
       document.getElementById("cfee").value = parseInt("0");
      }
      
       var display = parseInt(document.getElementById("cfee").value) + parseInt(document.getElementById(id).value);
       document.getElementById("cfee").value = display;
      
    }
    else
    {
       var display = document.getElementById("cfee").value - document.getElementById(id).value;
       document.getElementById("cfee").value = display;
     }
   
  }
  
  
  
  function loadpid(pid) // Putting values in textboxes 
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
	         x=xmlhttp.responseXML.documentElement.getElementsByTagName("SPACK");
	    	 
	    	if(x[0]==null)
	    	{
	    		
	    		empty();
	    		return;
	    	}
	    	
	    	var paid = x[0].getElementsByTagName("PID");
	    	paid = paid[0].firstChild.nodeValue;
	    	
	    	var afee = x[0].getElementsByTagName("FEE");
	    	afee = afee[0].firstChild.nodeValue;
	    	
	    	var pnm = x[0].getElementsByTagName("NAME");
	    	pnm = pnm[0].firstChild.nodeValue;
	    	
	    	var lng = x[0].getElementsByTagName("LANG");
	    	lng = lng[0].firstChild.nodeValue;
	    	
	    	
	    	var ddb = x[0].getElementsByTagName("DB");
	    	ddb = ddb[0].firstChild.nodeValue;
	    	  
	    	document.getElementById("paid").value = paid;
	    	document.getElementById("Actfee").value = afee;	    	 
	    	document.getElementById("Packname").value = pnm;
	    	document.getElementById("Numlang").value=lng;
	        document.getElementById("Numdb").value=ddb;
	    	
	      
	     }
	   
	   }
	  
	var path = "<%=basePath%>"+"course/MPback.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(pid);
	}
  
  
  function empty()
  {
  
                document.getElementById("paid").value = "";
	    		document.getElementById("cfee").value = "";
	    		document.getElementById("discount").value = "";
	    		document.getElementById("Actfee").value = "";	    		
	    		document.getElementById("Packname").value="";
	    		document.getElementById("Numlang").value="";
	    		document.getElementById("Numdb").value="";
  }
  
  
  function filldisc(id)   //Calculating discount
  {
      var cfee = document.getElementById("cfee").value;
      var actfee = document.getElementById(id).value;
      
      document.getElementById("discount").value = cfee-actfee;
  }
  
  function demo(pid)  //filling the package details to edit
    {
      // window.location.replace("EditClass.jsp?classid="+classid);
      empty();
      loadpid("pid="+pid);
      
    }
  
  
  function spack(id) //Showing packages
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
  
  
   function delpack(dltid)  //Delete package record
    {
		 spack("dltid="+dltid);
    }
  
  
 function showPackage()
 {
    empty();
    id="pack=yy";
    spack(id);
 
 }

</script>


  </head>
  
  <body>
    <form method="post" name="form" class="form-horizontal" >
    
         
         <fieldset>
          <legend><h1><strong>&nbsp;Manage Package</strong></h1></legend>
          
          
           <%
           if (request.getParameter("updated")!=null)
        {
            %>

    <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Package updated.
   		 </div>

            <%
           // session.removeAttribute("updated");
           
            
        }
        
        
         %> 
          
          
          
            <%
           if (request.getParameter("added")!=null)
        {
            %>

    <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Package added.
   		 </div>

            <%
            //session.removeAttribute("added");
            
        }
        
        
         %> 
         <%
           if (request.getParameter("notadded")!=null)
        {
            %>

    <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Could not add new package, please try again.
   		 </div>

            <%
            //session.removeAttribute("notadded");
            
        }
        
        
         %> 
          
          
          
          
          <div class="form-group">
		 <div class="col-sm-3">
		 
		   	<ul class="list-group">
		   	<li class="list-group-item disabled"><span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;&nbsp;<strong>Languages</strong></li>
          <li class="list-group-item">
          
  


		   	<%
		   	 PreparedStatement ps = con.prepareStatement("select * from course");		   	 
		   	 ResultSet rs=ps.executeQuery();
		   	 
		   	 while(rs.next())
		   	 {
		   	     %><br>
		   	     <input type="checkbox" name="<%=rs.getString(1)%>" value="<%=rs.getInt(3)%>" id="<%=rs.getString(1)%>" onchange="show(this.id)"></input>&nbsp;&nbsp;&nbsp;
		   	     <%=rs.getString(2)%> &nbsp;&nbsp;&nbsp;
		   	    
		   	     <%
		   	 
		   	 }
		   	 %>
		   
		   </li>
     </ul>
     
    </div>
   
         <div class="col-sm-3">
         </div>
         
         
         
         
         <div class="col-sm-3">
		 
		   	<ul class="list-group">
		   	<li class="list-group-item disabled"><span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;&nbsp;<strong>Databases</strong></li>
          <li class="list-group-item">
          
  


		   	<%
		   	 PreparedStatement ps1 = con.prepareStatement("select * from dbcourse");		   	 
		   	 ResultSet rs1=ps1.executeQuery();
		   	 
		   	 while(rs1.next())
		   	 {
		   	     %><br>
		   	     <input type="checkbox" name="<%=rs1.getString(1)%>" value="<%=rs1.getInt(4)%>" id="<%=rs1.getString(1)%>" onchange="show(this.id)"></input>&nbsp;&nbsp;&nbsp;
		   	     <%=rs1.getString(2)%> &nbsp;&nbsp;&nbsp;
		   	    
		   	     <%
		   	     
		   	   }
		   	   %>
		   	   
		   	   </li>
		   	 </ul>
		   	 </div>
		   	 </div>
		   	 
		   	 <div id="fill">
		   	 
		   	 
		   	 </div>
		   	 
		   	 <input type="hidden" id="paid" name="packageid" value=""></input> 
		   	 
		   	 
							<div class="form-group"> 
					 		    <label for="langSelected" class="col-sm-3 control-label">Calculated Fees: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="showCfee" class="form-control" id="cfee" readonly></input>
					 		    </div> 
					   		</div> 
					   		
					   		<div class="form-group"> 
					 		    <label for="disc" class="col-sm-3 control-label">Total Discount: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="disc" class="form-control" id="discount" readonly></input>
					 		    </div> 
					   		</div> 
					   		
					   		<div class="form-group"> 
					 		    <label for="Actfee" class="col-sm-3 control-label">Enter Actual Fees: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="showAfee" class="form-control" id="Actfee" onblur="filldisc(this.id);" required="true"></input>
					 		    </div> 
					   		</div> 
					   		
					   		
					   		<div class="form-group"> 
					 		    <label for="Pname" class="col-sm-3 control-label">Enter Package Name: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="Pname" class="form-control" id="Packname" required="true"></input>
					 		    </div> 
					   		</div> 
					   		
		   	               
		   	                 <div class="form-group"> 
					 		    <label for="Nlang" class="col-sm-3 control-label">Number of Languages: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="Nlang" class="form-control" id="Numlang" required="true"></input>
					 		    </div> 
					   		</div> 
					   		
					   		
					   		<div class="form-group"> 
					 		    <label for="Ndb" class="col-sm-3 control-label">Number of Databases: </label> 
					 		    <div class="col-sm-4">  
					 		      <input type="text" name="Ndb" class="form-control" id="Numdb" required="true"></input>
					 		    </div> 
					   		</div> 
					 <div class="form-group">  		
					<div class="col-sm-offset-4">   		
		   	 <input type="submit" class="btn btn-primary" value="Add New/Update Package">
		   	 <input type="button" class="btn btn-info" value="Show Packages" onclick="showPackage();">
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