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


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Contact Student</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="icon" href="css/images/ratico.ico">

    <link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>

<script type="text/javascript">

function loadStu(data)
	{
	var xmlhttp;
	//alert('ajax called with data'+data);
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  
	  if (xmlhttp.overrideMimeType)
	  {
 		xmlhttp.overrideMimeType('text/xml');
 		//alert("Response overrided");
 		}
	  
	  
	xmlhttp.onreadystatechange=function()
	  {
	  //alert("ajax state change : "+xmlhttp.readyState+"status is : "+xmlhttp.status);
	
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    	
	    	x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
	    		//alert("No of records is  "+x.length);
	    		var k;
	    		students = [];
	    		index = 0;
	    		
	    		for(k = 0; k < x.length; k++)
	    		{
	    			
	    			var sid = x[k].getElementsByTagName("ID");
			    	sid = sid[0].firstChild.nodeValue;
			    	
			    	var name = x[k].getElementsByTagName("NAME");
			    	name = name[0].firstChild.nodeValue;
			    	
			    	var email = x[k].getElementsByTagName("EMAIL");
			    	email = email[0].firstChild.nodeValue;
			    	
			    	var mobile = x[k].getElementsByTagName("MOBILE");
			    	mobile = mobile[0].firstChild.nodeValue;
			    	
			    	var img = x[k].getElementsByTagName("IMAGE");
			    	img = img[0].firstChild.nodeValue;
			    	
			    	var count = x[k].getElementsByTagName("COUNT");
			    	
			    	if(count[0] == null || count[0].firstChild == null)
			    		count = "";
			    	else
			    		count = count[0].firstChild.nodeValue;
			    	
			    	
			    	students.push(new student(sid, name, email, mobile, img ,count));
	    		}
	    		
	    		//alert("Number of records : "+students.length);
	    		
	    		drawTable();
	    	
	    	
	    }
	   
	  }
	  
	  var path = "<%=basePath%>"+"contact/CSback.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(data);
}
		
	 var index = 0;
	
	var students = [];
    	
    	function student(sid, name, email, mobile, img ,count)
    	{
    		this.sid = sid; 
    		this.name  = name;
    		this.mobile = mobile;    	
    		this.email = email;   		
    		this.img = img;
    		this.count = count;
		}
	
    	function drawTable()
		{
			var i = 0;
			var display = "";
			
			var field = document.getElementById("selectCriteria").value;
    	     if(field == "1")   // Name is selected
    	     {
    	     
    	        
			    display += "<table class='table table-striped'>";
		       	display += "<tr><th></th><th><input type='checkbox' name='selectsms' id='sms'>&nbsp;&nbsp;Send SMS&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='selectemail' id='email'>&nbsp;&nbsp;Send Email</th>";
		       	display += "<th>Student ID</th>";
		       	display += "<th>Name</th>";
		       	display += "<th>EmailId</th>";
		       	display += "<th>Mobile</th>";		       		       	
       	        display += "<th>Photo</th></tr>";
	       
	      
     		           document.getElementById("cnt").innerText =students[i].count;
				
					for(i = index; i < students.length && i < index + 15; i++)
					{
					    
						display += "<td></td><td></td>";
						display += "<td>"+students[i].sid+"</td>";
						display += "<td>"+students[i].name+"</td>";
						display += "<td>"+students[i].email+"</td>";
						display += "<td>"+students[i].mobile+"</td>";		
						display += "<td><img src="+students[i].img+" height='50px' width='50px'></td>";			
						display += "</tr>";
						
					}
					
					index = i;
					
					
			
			}
			
			else
			{
			   
			    display += "<table class='table table-striped'>";
		       	display += "<tr><th></th><th><input type='checkbox' name='selectsms' id='selectallsms'>&nbsp;&nbsp;Send SMS &nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='selectemail' id='selectallemail'>&nbsp;&nbsp;Send Email</th>";
		       	display += "<th>Student ID</th>";
		       	display += "<th>Name</th>";
		       	display += "<th>EmailId</th>";
		       	display += "<th>Mobile</th>";		       		       	
       	        //display += "<th>Total Count="+students[i].count+"</th></tr>";
       	        
       	             	        
       	       document.getElementById("cnt").innerText =students[i].count;
       	       
       	        for(i = index; i < students.length && i < index + 15; i++)
					{					    
						display += "<tr><td></td><td></td>";					
						display += "<td>"+students[i].sid+"</td>";
						display += "<td>"+students[i].name+"</td>";
						display += "<td>"+students[i].email+"</td>";
						display += "<td>"+students[i].mobile+"</td>";										
						display += "</tr>";						
					}					
					index = i;
			}
			
			document.getElementById("display").innerHTML = display;
		
}


 function displayPrev()
    	{
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(student.length > 0 && index > 15)
    		{
    			if(index - 30 < 0)
    				index = 0;
    			else
    				index = index - 30;
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    	
    	}
    	
    	function displayNext()
    	{
    		//alert("index is : "+index+" and students is : "+students.length)
    		if(index < students.length - 1)
    		{
    			drawTable();
    		}
    		//alert("index is : "+index+" and students is : "+students.length)
    	} 
    	
    	
    function setValue(name,value)
	{
		document.getElementById("data").name = name;
		document.getElementById("data").value = value;
		console.log(document.getElementById("data").name+":"+document.getElementById("data").value);
	}
    	
	
function searchRecord()
{
    document.getElementById("display").innerHTML = "";
    document.getElementById("cnt").innerText =0;
   var field = document.getElementById("selectCriteria").value;
    	if(field == "1")   // Name is selected
    	{
          var d = document.getElementById('stname').value;
          if(d!=null && d!="")
          {
          setValue("name", d)
             loadStu("name="+d);
          }
        }
        
        else if(field == "2") // Course is selected
        {
          var d=document.getElementById('courseid').value;
          if(d!=null && d!="")
          {
          setValue("courseid", d)
             loadStu("courseid="+d);
          }
        }
        
        
        else if(field == "3")  //Package is selected
        {
          var d=document.getElementById('packageid').value;
          if(d!=null && d!="")
          {
          setValue("packageid", d)
             loadStu("packageid="+d);
          }
        }
        
        
        else if(field =="4")  //Class is selected
        {
          var d = document.getElementById("classid").value;
         
          if(d!=null && d!="")
          {
          setValue("classid", d)
            loadStu("classid="+d);
          }
        }
        
        
        else if(field =="5")  //Date is selected
        {
          var sm = document.getElementById("smonth").value;
          var sy = document.getElementById("syear").value;
          var em = document.getElementById("emonth").value;
          var ey = document.getElementById("eyear").value;
          
         // alert(sy+sm);
         
         if(sm!=null && sm!="" && sy!=null && sy!="" && em!=null && em!="" && ey!=null && ey!="")
          {
         
              var start_date = sy+sm;
              var end_date = ey+em;
              setValue("date", start_date+","+end_date)
              
              loadStu("sdate="+start_date+"&edate="+end_date);
          
          }
        
        
        }
        
        else if(field =="6")  //Date is selected
        {
        	setValue("all","all");
           loadStu("all=all");
        }
        
        else
        {
          return;
          
        }
}


function calcLength(id)
{
	var sms = document.getElementById(id).value;
	document.getElementById("len").innerHTML = sms.length;
}

</script>

  </head>
  
  <body>
  
  <form method="post" class="form-horizontal" action="contact/SendMessage.jsp">
   
  
   <fieldset>
  <%
          		if(session.getAttribute("msg")!=null)
          		{
          				if(session.getAttribute("msg").equals("success"))
          				{
          					%>
					  		<div class="alert alert-success alert-dismissible" role="alert">
					 			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					  			<strong>Success !</strong> Message(s) has been sent.
							</div>
					  		<%
          				}
          				else
          				{
          					%>
					  		<div class="alert alert-warning alert-dismissible" role="alert">
					 			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					  			<strong>Oh Snap !</strong> Something went wrong while sending message(s), please try again.
							</div>
					  		<%
          				}
          				
          				session.removeAttribute("msg");
          		
          		}
          		else
          		{
          			System.out.println("No op");
          		}
          
           %>
           <legend><strong>&nbsp;&nbsp;Send Message</strong></legend>
           
           <div class="form-group">
           <label for="selectCriteria" class="col-sm-2 control-label" align="left">Select Criteria :</label>
           <div class="col-sm-3">
           <select name="selectCriteria" id="selectCriteria" class="form-control" onchange="CriteriaSelected(this.value);">
           <option value="" selected="selected">Select</option>
           <option value="1">Name</option>
           <option value="2">Course</option>
           <option value="3">Package</option>
           <option value="4">Class</option>
           <option value="5">Date</option>
           <option value="6">All</option>
           </select>
           </div>
           </div>
           
           
           <br>
           
           <div class="form-group" id="fill">
           
           </div>
           
           <div class="col-sm-12" >
           <div id="display">
           
           </div>
           <div class="form-group">
   		<div class="col-sm-3"></div>
   		
         <strong>  <label class="col-sm-3 control-label" >Total Count : </label><label class="col-sm-1 control-label" id="cnt"></label></strong>
           
           
         </div>
       
       	<ul class="pager">
  			<li><a href="javascript:displayPrev()">&lt;- Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next -&gt;</a></li>
		</ul>
       </div>
       </fieldset>
           
           <fieldset>
           <legend><strong>Send Message</strong></legend>
   			<div class="form-group">
         
		      <label for="center" class="col-sm-3 control-label" align="left">Email Message :<br>( Max 100 Emails in a Day ) </label> 
		      	<div class="col-sm-5">
		      		<textarea name="messageEmail" class="form-control" rows="10"></textarea>
		      	</div>
		      </div>
   			<div class="form-group">
         
		      <label for="center" class="col-sm-3 control-label" align="left">SMS Message :<br>( 160 Characters Per Message )<br>Current Length : <strong id="len" style="color:green"></strong> </label> 
		      	<div class="col-sm-5">
		      		<textarea name="messageSMS" class="form-control" rows="4" id="smsL" onkeydown="calcLength(this.id)" ></textarea>
		      	</div>
		      </div>
		      <div class="form-group">
		      	<input type="submit" name="send" class="btn btn-lg btn-success col-sm-offset-5" value="Send Message">
		      
		      </div>
		      
		      <input type=hidden name="" value="" id="data">
		      </fieldset>
           
   		
           </form>
           
           
           
           <script type="text/javascript">

  function CriteriaSelected(Criteria)
     {
     document.getElementById("display").innerHTML = "";
     document.getElementById('fill').innerHTML = "";
     document.getElementById("cnt").innerText =0;
       if(Criteria == "" || Criteria == null)
       {
           return;
       }
     
       else if(Criteria == "1")     //Student Name is selected
       {
             var name ="";
          
           name += "<div class='form-group'><label class='col-sm-2 control-label' Id='lbl'>Enter Name :</label>";
           name += "<div class='col-sm-3'><input type='text' class='form-control' name='studentName' Id='stname'></input></div></div>";
           name += "<div class='form-group'>"; 
 		   name += "<div class='col-sm-offset-3 col-sm-2'>"; 
 		   name += "<input type='button' class='btn btn-primary' value='Search Student >>>' onclick='searchRecord();'/></div></div>"; 
 		    
           document.getElementById('fill').innerHTML = name;
       }
       
       else if(Criteria == "2")    //Course is selected
       {
             var lang = "";
          lang += "<label class='col-sm-2 control-label' Id='lbl'>Select Course :</label>";
       <%
                     
               
               PreparedStatement ps = con.prepareStatement("Select * from course");
               ResultSet rs = ps.executeQuery();       
        %>        
         lang +=  "<div class='col-sm-3'><select name='selectCourse' class='form-control' Id='courseid' onchange='searchRecord();'><option >--- Select ---</option>";   
                
           <% 
             while(rs.next())
               {              
            %>
         lang += "<option value='<%=rs.getString(1)%>'><%=rs.getString(2) %></option>";           
           <%
               }   
         
            %>
         lang += "<option value='' disabled='disabled'>Database Courses</option>"; 
         
         <%  
              
               PreparedStatement ps1 = con.prepareStatement("Select * from dbcourse");
               ResultSet rs1 = ps1.executeQuery(); 
                while(rs1.next())
               {   
         %>
         
         lang += "<option value='<%=rs1.getString(1)%>'><%=rs1.getString(2) %></option>";           
           <%
               }   
         
           %>
         lang +=  "</select></div>";
               
        document.getElementById('fill').innerHTML = lang;
       }
       
       else if(Criteria == "3")   //Package is selected
       {
       
           var pack = "";
             pack += "<label class='col-sm-2 control-label' Id='lbl'>Select Package :</label>";
       <%
        
               
               PreparedStatement ps2 = con.prepareStatement("Select * from package");
               ResultSet rs2 = ps2.executeQuery();       
        %>        
         pack +=  "<div class='col-sm-3'><select name='selectPackage' class='form-control' Id='packageid' onchange='searchRecord();'><option >--- Select ---</option>";   
                
           <% 
             while(rs2.next())
               {              
            %>
           pack += "<option value='<%=String.valueOf(rs2.getInt(1))%>'><%=rs2.getString(3)%></option>";           
           <%
               }   
         
            %>
          pack +=  "</select></div>";
               
        document.getElementById('fill').innerHTML = pack;
       
       
       }
       
       else if(Criteria == "4") //Class is selected
       {
       
        var cc = "";
             cc += "<label class='col-sm-2 control-label' Id='lbl'>Select Class :</label>";
       <%
        
               
               PreparedStatement ps6 = con.prepareStatement("select c.classid,c.time,c.schedule,c.center,cv.name,t.name from class c,courseview cv,trainer t where c.courseid=cv.courseid and c.trainerid=t.trainerid and c.end_date is NULL");
               ResultSet rs6 = ps6.executeQuery();       
        %>        
        cc +=  "<div class='col-sm-8'><select name='selectClass' class='form-control' Id='classid' onchange='searchRecord();'><option >--- Select ---</option>";   
                
           <% 
             while(rs6.next())
               {              
            %>
           cc += "<option value='<%=String.valueOf(rs6.getInt(1))%>'><%=rs6.getString(2)+" | "+rs6.getString(5)+" | "+rs6.getString(3)+" | "+rs6.getString(4)+" | "+rs6.getString(6)%></option>";           
           <%
               }   
         
            %>
          cc +=  "</select></div>";
 		   
         
         
          document.getElementById('fill').innerHTML = cc;
       }
       
       else if(Criteria == "5") //Date is selected
       {
            var cc ="";
            cc += "<div class='form-group'><label class='col-sm-2 control-label' Id='lbl'>Select Start Date:</label>";
            cc += "<div class='col-sm-2'><select name='selectSmonth' class='form-control' Id='smonth'><option >--- Select ---</option>";
            cc += "<option value='01'>JANUARY</option>";
            cc += "<option value='02'>FEBRUARY</option>";
            cc += "<option value='03'>MARCH</option>";
            cc += "<option value='04'>APRIL</option>";
            cc += "<option value='05'>MAY</option>";
            cc += "<option value='06'>JUNE</option>";
            cc += "<option value='07'>JULY</option>";
            cc += "<option value='08'>AUGUST</option>";
            cc += "<option value='09'>SEPTEMBER</option>";
            cc += "<option value='10'>OCTOBER</option>";
            cc += "<option value='11'>NOVEMBER</option>";
            cc += "<option value='12'>DECEMBER</option></select></div>";
            
            cc += "<div class='col-sm-2'><select name='selectSyear' class='form-control' Id='syear'><option >--- Select ---</option>";
            cc += "<option value='14'>2014</option>";
            cc += "<option value='15'>2015</option>";
            cc += "<option value='16'>2016</option>";
            cc += "<option value='17'>2017</option>";
            cc += "<option value='18'>2018</option>";
            cc += "<option value='19'>2019</option>";
            cc += "<option value='20'>2020</option>";
            cc += "<option value='21'>2021</option>";
            cc += "<option value='22'>2022</option>";
            cc += "<option value='23'>2023</option>";
            cc += "<option value='24'>2024</option>";
            cc += "<option value='25'>2025</option></select></div></div>";
            
            cc += "<div class='form-group'><label class='col-sm-2 control-label' Id='lbl'>Select End Date:</label>";
            cc += "<div class='col-sm-2'><select name='selectEmonth' class='form-control' Id='emonth' ><option >--- Select ---</option>";
            cc += "<option value='01'>JANUARY</option>";
            cc += "<option value='02'>FEBRUARY</option>";
            cc += "<option value='03'>MARCH</option>";
            cc += "<option value='04'>APRIL</option>";
            cc += "<option value='05'>MAY</option>";
            cc += "<option value='06'>JUNE</option>";
            cc += "<option value='07'>JULY</option>";
            cc += "<option value='08'>AUGUST</option>";
            cc += "<option value='09'>SEPTEMBER</option>";
            cc += "<option value='10'>OCTOBER</option>";
            cc += "<option value='11'>NOVEMBER</option>";
            cc += "<option value='12'>DECEMBER</option></select></div>";
            
            cc += "<div class='col-sm-2'><select name='selectEyear' class='form-control' Id='eyear' ><option >--- Select ---</option>";
            cc += "<option value='14'>2014</option>";
            cc += "<option value='15'>2015</option>";
            cc += "<option value='16'>2016</option>";
            cc += "<option value='17'>2017</option>";
            cc += "<option value='18'>2018</option>";
            cc += "<option value='19'>2019</option>";
            cc += "<option value='20'>2020</option>";
            cc += "<option value='21'>2021</option>";
            cc += "<option value='22'>2022</option>";
            cc += "<option value='23'>2023</option>";
            cc += "<option value='24'>2024</option>";
            cc += "<option value='25'>2025</option></select></div></div>";
            
            
            
            cc += "<div class='form-group'>"; 
 		    cc += "<div class='col-sm-offset-3 col-sm-2'>"; 
 		    cc += "<input type='button' class='btn btn-primary' value='Search Students >>>' onclick='searchRecord();'/></div></div>"; 
 		   
            
            document.getElementById('fill').innerHTML = cc;
       }
       
       else if(Criteria == "6") //All Students are selected
       {
            searchRecord();
       }
       
       
      }

</script>
           
  </body>
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
