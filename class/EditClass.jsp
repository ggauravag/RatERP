<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.login.*" %>
<%@page import="java.io.EOFException"%>
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
          
          
          
          if(request.getParameter("update")!=null)
          {
          		String sche[] = request.getParameterValues("sch");
          		String cid = request.getParameter("cid");
          		String sttime = request.getParameter("stime1")+":"+request.getParameter("stime2")+":00";
          		String stu = request.getParameter("stu");
          		System.out.println("The value are : "+cid+"; "+sttime+"; "+stu);
          		
          		String student[] = stu.split(",");
	         	String sched = "";
	         	for(int n = 0; n < sche.length; n++)
	         	{
	         		if(n != 0)
	         			sched += ","+sche[n];
	         		else
	         			sched += sche[n];
	         	}
	         	
	         	String query = "update class set schedule=?, time=? where classid=?";
	         	PreparedStatement ps = con.prepareStatement(query);
	         	ps.setString(1, sched);
	         	ps.setString(2, sttime);
	         	ps.setString(3, cid);
	         	
	         	int j = ps.executeUpdate();
	         	
	         	
	         	String students = "";
	         	for(int n = 0; n < student.length; n++)
	         	{
	         		if(n == 0)
	         			students = "'"+student[n]+"'";
	         		else
	         			students += ",'"+student[n]+"'";
	         	
	         	}
	         	
	         	
	         
	         	query = "update student set class = concat(class,?) where studentid in ("+students+")";
	         	ps = con.prepareStatement(query);
	         	ps.setString(1, cid+",");
	         
	         	
	         	//System.out.println("The statement is : "+ps);
	        	
	        	j = ps.executeUpdate();
	        	
	         	session.setAttribute("class", j);
          
          }
  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <link rel="icon" href="css/images/ratico.ico">
    <title>RAT Panel</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	
	<link href="css/bootstrap.min.css" rel="stylesheet"> 

<script type="text/javascript">
function loadstu(id)
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
	        // document.getElementById("displayStudents").innerHTML=xmlhttp.responseText;
	    	 //alert(xmlhttp.responseXML);	  
	    	 
	    	  y=xmlhttp.responseXML.documentElement.getElementsByTagName("STD");
	    	 
	    	    var k;
	    		students = [];
	    		index = 0;
	    		//alert("Just pushing students");
	    		for(k = 0; k < y.length; k++)
	    		{
	    			//alert("Just pushing students");
	    			var stid = y[k].getElementsByTagName("STID");
			    	stid = stid[0].firstChild.nodeValue;
			    	//alert(stid);
			    	var name = y[k].getElementsByTagName("SNAME");
			    	name = name[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var email = y[k].getElementsByTagName("SEMAIL");
			    	email = email[0].firstChild.nodeValue;
			    	
			    	var mobile = y[k].getElementsByTagName("SMOBILE");
			    	mobile = mobile[0].firstChild.nodeValue;
			    	
			    	var dob = y[k].getElementsByTagName("SDOB");
			    	dob = dob[0].firstChild.nodeValue;
			    	
			    	var pckg = y[k].getElementsByTagName("SPCK");
			    	pckg = pckg[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	
			    	var lang = y[k].getElementsByTagName("SLANG");
			    	
			    	if(lang[0] == null || lang[0].firstChild == null)
			    		lang = "";
			    	else
			    		lang = lang[0].firstChild.nodeValue;
			    	
			    	//alert("Just pushing students");
			    	var db = y[k].getElementsByTagName("SDB");
			    	if(db[0] == null || db[0].firstChild == null)
			    		db = "";
			    	else
			    		db = db[0].firstChild.nodeValue;
			    	
			    	var cls = y[k].getElementsByTagName("SCLASS");
			    	//cls = cls[0].firstChild.nodeValue;
			    	if(cls[0] == null || cls[0].firstChild == null)
			    		cls = "";
			    	else
			    		cls = cls[0].firstChild.nodeValue;
			    	
			    	//alert("ID, Name, Mobile, k : "+stid+" "+name+" "+mobile);
			    	students.push(new student(stid, name, email, mobile, dob, pckg, lang, db, cls));
	    		}
	    	   	drawTable(); 
	     }
	   
	   }
	  
	var path = "<%=basePath%>"+"class/SearchClass.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(id);
	}


	var index = 0;
	var pagesize = 15;


		function addSelect()
		{
			var checkboxes = document.getElementsByName("st");
			for (var i=0, n=checkboxes.length;i<n;i++) {
				
			  if (checkboxes[i].checked) 
			  {
			  	students[parseInt(checkboxes[i].value)].select = true;
			  }
			  else
			  {
			  	students[parseInt(checkboxes[i].value)].select = false;
			  }
			}
			
			var container = document.getElementById("starray");
			var data = "";
			for(var i = 0; i < students.length; i++)
			{
				if(students[i].select)
				{
					if(data != "")
						data += ","+students[i].stid;
					else
						data += students[i].stid +"";
				}
			}
			
			container.value = data;
			//alert("Data is : "+document.getElementById("starray").value);
			
		}
    
    
    function displayPrev()
    	{
    	
    		
			//if (val) val = val.substring(1);
			
			addSelect();
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(student.length > 0 && index > pagesize)
    		{
    			if(index - (2*pagesize) < 0)
    				index = 0;
    			else
    				index = index - (2*pagesize);
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    	
    	}
    	
    	function displayNext()
    	{
    		addSelect();
    	
    	
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(index <= students.length - 1)
    		{
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    		
    		
			//if (val) val = val.substring(1);
    	}



function drawTable()
		{
			var i = 0;
			var display = "";
			//alert("Draw table called");
			
			display += "<table class='table table-striped'>";
	       	display += "<tr><th>Select</th><th>Student ID</th>";
	       	display += "<th>Name</th>";
	       	display += "<th>Email</th>";
	       	display += "<th>Mobile</th>";
	       	display += "<th>Dob</th>";
	       	display += "<th>Package Name</th>";
	       	display += "<th>Language</th>";
	       	display += "<th>Database</th>";
	       	display += "<th>CLASS</th>";	
	       	display += "</tr>";
			
			

			for(i = index; i < students.length && i < index + 15; i++)
			{
			//alert("Draw table called for loop"+students[i].stid);
				display += "<tr>";
				if(students[i].select)
					display += "<td><input type='checkbox' name='st' id='st"+i+"' value='"+i+"' checked></td>";
				else
					display += "<td><input type='checkbox' name='st' id='st"+i+"' value='"+i+"'></td>";
				display += "<td>"+students[i].stid+"</td>";
				display += "<td>"+students[i].name+"</td>";
				display += "<td>"+students[i].email+"</td>";
				display += "<td>"+students[i].mobile+"</td>";
				display += "<td>"+students[i].dob+"</td>";
				display += "<td>"+students[i].pckg+"</td>";
				display += "<td>"+students[i].lang+"</td>";
				display += "<td>"+students[i].db+"</td>";
				display += "<td>"+students[i].cls+"</td>";
				display += "</tr>";
				
			}
			
			display += "</table>";
			////alert("Draw table called with index :"+index);
			index = i;
			//alert("Draw table called with index :"+index);
			document.getElementById("displayStudents").innerHTML = display;
		
		}

function loadID(id)
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
	  
	var path = "<%=basePath%>"+"class/SearchClass.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(id);
	}
	
	
function loadclass(cid)
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
	     
	     
	         x=xmlhttp.responseXML.documentElement.getElementsByTagName("CID");
	    	 
	    	 
	    	 
	    	 
	    	if(x[0]==null)
	    	{
	    		
	    		document.getElementById("cloc").value = "";
	    		document.getElementById("ctid").value = "";
	    		document.getElementById("ccid").value = "";
	    		document.getElementById("dd1").value = "";	    		
	    		document.getElementById("hour").value="";
	    		document.getElementById("min").value="";
	    		
	    		
	    		
	    		return;
	    	}
	    	
	   
	    	
	    	var cent = x[0].getElementsByTagName("CENTER");
	    	cent = cent[0].firstChild.nodeValue;
	    	
	    	var tid = x[0].getElementsByTagName("TRAINER");
	    	tid = tid[0].firstChild.nodeValue;
	    	
	    	var clid = x[0].getElementsByTagName("CLASSID");
	    	clid = clid[0].firstChild.nodeValue;
	    	
	    	var startdt = x[0].getElementsByTagName("SDATE");
	    	startdt = startdt[0].firstChild.nodeValue;
	    	
	    	var tt = x[0].getElementsByTagName("TIME");
	    	tt = tt[0].firstChild.nodeValue;
	    	
	    	var sch = x[0].getElementsByTagName("SCHD");
	    	sch = sch[0].firstChild.nodeValue;
	    	
	    	var a=tt.substring(0, 2);
	    	var b=tt.substring(3,5);
	    	//var c=tt.substring(6,8);
	    	var temp = new Array();
	    	temp = sch.split(",");
	    	
	    	for(var i=0;i<7;i++)
	    	{
	    	  if(temp[i]=="Monday")
	    	  {
	    	   document.getElementById("mon").checked=true;
	    	  }
	    	  else if(temp[i]=="Tuesday")
	    	  {
	    	   document.getElementById("tue").checked=true;
	    	  }
	    	  else if(temp[i]=="Wednesday")
	    	  {
	    	   document.getElementById("wed").checked=true;
	    	  }
	    	  else if(temp[i]=="Thursday")
	    	  {
	    	   document.getElementById("thu").checked=true;
	    	  }
	    	  else if(temp[i]=="Friday")
	    	  {
	    	   document.getElementById("fri").checked=true;
	    	  }
	    	  else if(temp[i]=="Saturday")
	    	  {
	    	   document.getElementById("sat").checked=true;
	    	  }
	    	  else if(temp[i]=="Sunday")
	    	  {
	    	   document.getElementById("sun").checked=true;
	    	  }
	    	  
	    	  
	    	}
	    	document.getElementById("cloc").value = cent;
	    	document.getElementById("ctid").value = tid;
	    	document.getElementById("ccid").value = clid; 
	    	document.getElementById("dd1").value = startdt;
	    	document.getElementById("hour").value=a;
	    	document.getElementById("min").value=b;
	    	document.getElementById("cid").value = clid;
	    	//alert("Value stored is : "+document.getElementById("cid").value);
	      
	      
	     }
	   
	   }
	  
	var path = "<%=basePath%>"+"class/SearchClass.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(cid);
	}
	
	
	var students = [];
    	
    	function student(stid, name, email, mobile, dob, pckg, lang, db, cls)
    	{
    		this.stid = stid; 
    		this.name  = name;
    		this.email = email;
    		this.mobile = mobile;
    		this.dob = dob;
    		this.pckg = pckg;
    		this.lang = lang;
    		this.db = db;
    		this.cls = cls;
		}
	
	
	
	
	function searchRecord(id) //Searching the record
    {
      empty();
      //alert("function called");
      loadID("id="+id);
      
    }
    
    function empty()
    {
      document.getElementById("mon").checked=false;
      document.getElementById("tue").checked=false;
      document.getElementById("wed").checked=false;
      document.getElementById("thu").checked=false;
      document.getElementById("fri").checked=false;
      document.getElementById("sat").checked=false;
      document.getElementById("sun").checked=false;
      document.getElementById("cloc").value = "";
	  document.getElementById("ctid").value = "";
	  document.getElementById("ccid").value = "";
	  document.getElementById("dd1").value = "";	    		
	  document.getElementById("hour").value="";
	  document.getElementById("min").value="";
	  document.getElementById("cid").value = "";
    } 
   
   
    function demo(classid)  //filling the class details to edit
    {
      // window.location.replace("EditClass.jsp?classid="+classid);
      empty();
      loadclass("classid="+classid);
      
    }
    
    function delclass(dltid)  //Delete class record
    {
			      loadID("id="+dltid+"&action=del");
			      empty();
    }
   
    function viewrecord() //Display student details
    {
       
       loadstu("classid="+document.getElementById("ccid").value+"&courseid="+document.getElementById("courseid").value);
    }
   
</script>

  </head>
  
  <body>
   <form method="get" class="form-horizontal" name="optionForm" action="">
   
   <%
          		if(session.getAttribute("class")!=null)
          		{
          				if(((Integer)session.getAttribute("class")) >= 1)
          				{
          					%>
					  		<div class="alert alert-success alert-dismissible" role="alert">
					 			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					  			<strong>Success !</strong> Class has been updated.
							</div>
					  		<%
          				}
          				else
          				{
          					%>
					  		<div class="alert alert-warning alert-dismissible" role="alert">
					 			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					  			<strong>Oh Snap !</strong> Something went wrong while updating class, please try again.
							</div>
					  		<%
          				}
          				
          				session.removeAttribute("class");
          		
          		}
          		else
          		{
          			System.out.println("No op");
          		}
          
           %>
   
   
    <fieldset>
           <legend><strong>&nbsp;&nbsp;Search Class</strong></legend>
           
           <div class="form-group">
           <label for="selectCourse" class="col-sm-2 control-label" align="left">Select Course :</label>
           <div class="col-sm-3">
           <%
              try
              {
               
			       String stmt = "Select * from course";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                           
             %>
           <select  id="courseid" class="form-control" onchange="searchRecord(this.value);" >
           <option value="" selected="selected">Select</option>
                 <% 
                 while(rs.next()) 
                 {
                   %>
                   <option value="<%=String.valueOf(rs.getString(1))%>"><%= rs.getString(2) %></option> 
                   <% 
                 }
                 %>
                 <option disabled="disabled">----------DataBase Courses-------</option>
                 <% 
                   }
                   catch(Exception e)
                   {
                     e.printStackTrace();
                   } 
                
                try
                {
              
                   
			       String stmt = "Select * from dbcourse";
			       PreparedStatement ps = con.prepareStatement(stmt);
			       ResultSet rs = ps.executeQuery();
                  while(rs.next()) 
                  {
                    %>  
                   
                 
                    <option value="<%=String.valueOf(rs.getString(1))%>"><%= rs.getString(2) %></option> 
                   <% 
                  }//End of while loop
                 }//End of try
                   catch(Exception e)
                   {
                     e.printStackTrace();
                   } 
                 %>
           </select>
           </div>
           </div>
           
           
           <div class="form-group" Id="fill">
           
           
               
           </div>         
       </fieldset>
       
       
       <fieldset>
       <legend><strong>&nbsp;&nbsp;Edit Class</strong></legend>
       
       <div class="form-group">
         <label for="loc" class="col-sm-2 control-label" align="left">Class Location :</label> 
		      	<div class="col-sm-3">
		      	 <input type="text" class="form-control" id="cloc" disabled="disabled"></input>
		      	</div>
       </div>
       
       <div class="form-group">
         <label for="tid" class="col-sm-2 control-label" align="left">Trainer Name :</label> 
		      	<div class="col-sm-3">
		      	 <input type="text"  class="form-control" id="ctid" disabled="disabled"></input>
		      	</div>
       </div>
       
       <div class="form-group">
         <label for="cid" class="col-sm-2 control-label" align="left">Class ID :</label> 
		      	<div class="col-sm-3">
		      	 <input type="text" name="cid" class="form-control" id="ccid" disabled="disabled"></input>
		      	</div>
       </div>
       
       <div class="form-group">
         <label for="dd" class="col-sm-2 control-label" align="left">Date :</label> 
		      	<div class="col-sm-3">
		      	 <input type="text"  class="form-control" id="dd1" disabled="disabled"></input>
		         </div>
		         
		        
       </div>
       
       <div class="form-group">
		      <label for="sched" class="col-sm-2 control-label" align="left">Schedule :</label> 
		      	<div class="col-sm-9">
		               
		               <label class="checkbox-inline col-sm-2">
		                <input type="checkbox" name="sch" id="mon" value="Monday">Monday
		                </label>
		               <label class="checkbox-inline col-sm-2">
		                <input type="checkbox" name="sch" id="tue" value="Tuesday">Tuesday
		                </label>
		               <label class="checkbox-inline col-sm-2">
		                <input type="checkbox" name="sch" id="wed" value="Wednesday">Wednesday
		                </label>
		               
		               
		        </div>
		     </div>
		     
		     <div class="form-group">
		     
		     <div class="col-sm-offset-2 col-sm-9">
		     
		                <label class="checkbox-inline col-sm-2"> 
		                <input type="checkbox" name="sch" id="thu" value="Thursday">Thursday
		                </label>
		               <label class="checkbox-inline col-sm-2">
		                <input type="checkbox" name="sch" id="fri" value="Friday">Friday
		                </label>
		               <label class="checkbox-inline col-sm-2"> 
		                <input type="checkbox" name="sch" id="sat" value="Saturday">Saturday</label>
		               <label class="checkbox-inline col-sm-2"> 
		                <input type="checkbox" name="sch" id="sun" value="Sunday">Sunday
		               </label>
		     </div>
		     </div>
		     
		     <div class="form-group">
		      <label for="sched" class="col-sm-2 control-label" align="left">Start Time :</label> 
		      	<div class="col-sm-2">
		      	   <select name="stime1" class="form-control" id="hour">
		      	     <option selected="selected" value="" disabled="disabled">-Select-</option>
		      	     <option value="08">08</option>
		      	     <option value="09">09</option>
		      	     <option value="10">10</option>
		      	     <option value="11">11</option>
		      	     <option value="12">12</option>
		      	     <option value="13">13</option>
		      	     <option value="14">14</option>
		      	     <option value="15">15</option>
		      	     <option value="16">16</option>
		      	     <option value="17">17</option>
		      	     <option value="18">18</option>
		      	     <option value="19">19</option>
		      	     <option value="20">20</option>
		      	     <option value="21">21</option>
		      	   </select>
		      	</div>
		      	
		      	<div class="col-sm-2">
		      	  <input type=hidden name=stu id=starray >	
		      	  <input type="hidden" name="cid" id="cid">
		      	   <select name="stime2" class="form-control" id="min">	
		      	   <option selected="selected" value="" disabled="disabled">-Select-</option>	      	    
		      	     <option value="00">00</option>
		      	     <option value="15">15</option>
		      	     <option value="30">30</option>
		      	     <option value="45">45</option>
		      	     </select>
		      	 </div> 
		      	 
		      	 <!-- <div class="col-sm-1">
		      	 
		      	   <select name="stime3" class="form-control" id="AP">
		      	   <option selected="selected" value="" disabled="disabled">-Select-</option>		      	    
		      	     <option value="11">AM</option>
		      	     <option value="00" selected="selected">PM</option>
		      	     
		      	     </select>
		      	 </div>  -->
		    </div>
		    
		    
		    <div class="form-group">
		    <div class="col-sm-3">
		    </div>
		      	<div class="col-sm-6">
		      	<input type="button" name="view" class="btn btn-primary" id="show" value="Show Students" onclick="viewrecord();"></input>
		      	 
		      	 
		      	 <input type="submit" name="update" class="btn btn-success " id="updt" value="Update" onclick="addSelect()"></input>
		      	</div>
            </div>
       </fieldset>
    
    
    <fieldset>
       <legend><strong>&nbsp;&nbsp;Add Students</strong></legend>
       <div id="displayStudents">
       
       </div>
       <ul class="pager">
  			<li><a href="javascript:displayPrev()">&lt;- Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next -&gt;</a></li>
		</ul>
       
       </fieldset>
          
       
       <%}
       catch(Exception e)
       {
         e.printStackTrace();
       }
       finally
       {
         if(con!=null)
         {
         
          try
          {
          con.close();
          }
          catch(Exception e)
          {
           e.printStackTrace();
          }
         }
       }
        %>
       </form>
  </body>
</html>
