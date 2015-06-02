<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.EOFException"%>
<%@page import="java.io.ObjectInputStream"%>
<%@ page import="java.sql.*, com.login.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


              
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
var temp=0;
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
			    	
			    	temp =count;
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
             loadStu("name="+d);
          }
        }
        
        else if(field == "2") // Course is selected
        {
          var d=document.getElementById('courseid').value;
          if(d!=null && d!="")
          {
             loadStu("courseid="+d);
          }
        }
        
        
        else if(field == "3")  //Package is selected
        {
          var d=document.getElementById('packageid').value;
          if(d!=null && d!="")
          {
             loadStu("packageid="+d);
          }
        }
        
        
        else if(field =="4")  //Class is selected
        {
          var d = document.getElementById("classid").value;
         
          if(d!=null && d!="")
          {
            loadStu("classid="+d);
          }
        }
        
        
        else if(field =="5")  //Date is selected
        {
          var sm = document.getElementById("smonth").value;
          var sy = document.getElementById("syear").value;
          var em = document.getElementById("emonth").value;
          var ey = document.getElementById("eyear").value;
          
        
         
         if(sm!=null && sm!="" && sy!=null && sy!="" && em!=null && em!="" && ey!=null && ey!="")
          {
         
              var start_date = sy+sm;
              var end_date = ey+em;
              loadStu("sdate="+start_date+"&edate="+end_date);
          
          }
        
        
        }
        
        else if(field =="6")  //Date is selected
        {
           loadStu("all=all");
        }
        
        else
        {
          return;
          
        }
}

</script>

  </head>
  
  <body>
  
  <form method="get" class="form-horizontal">
   
  
   <fieldset>
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
           </fieldset>
           
           <br>
           
           <div class="form-group" id="fill">
           
           </div>
           
            <div class="form-group" id="display">
           
           </div>
           
   		<div class="form-group">
   		<div class="col-sm-3"></div>
   		
         <strong>  <label class="col-sm-1 control-label" >Total Count : </label><label class="col-sm-1 control-label" id="cnt"></label></strong>
           
           
         </div>
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
         lang +=  "<div class='col-sm-3'><select name='selectCourse' class='form-control' Id='courseid' onchange='searchRecord();'>";   
                
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
         pack +=  "<div class='col-sm-3'><select name='selectPackage' class='form-control' Id='packageid' onchange='searchRecord();'>";   
                
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
        cc +=  "<div class='col-sm-3'><select name='selectClass' class='form-control' Id='classid' onchange='searchRecord();'>";   
                
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
            cc += "<div class='col-sm-1'><select name='selectSmonth' class='form-control' Id='smonth'>";
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
            
            cc += "<div class='col-sm-1'><select name='selectSyear' class='form-control' Id='syear'>";
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
            cc += "<div class='col-sm-1'><select name='selectEmonth' class='form-control' Id='emonth' >";
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
            
            cc += "<div class='col-sm-1'><select name='selectEyear' class='form-control' Id='eyear' >";
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
