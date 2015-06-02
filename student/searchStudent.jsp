<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.ObjectInputStream"%>
<%@ page import="java.sql.*, com.login.*" %>
<%@page import="java.io.EOFException"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
HttpSession session1 = request.getSession(false);
 if(session1 == null)
 {
 	response.sendRedirect("Unauthorize.jsp");
 	return;
 }
 else
 {
 	String type=(String)session1.getAttribute("type");
 	String name = (String)session1.getAttribute("name");
 	System.out.println(type+":"+name);
 	if(type==null)
 	{
 		response.sendRedirect("Unauthorize.jsp");
 		return;
 	}
 	
 	
 	
 }

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="icon" href="css/images/ratico.ico">
    <title>Student Search</title>
    
	
	
	
	<link href="css/bootstrap.min.css" rel="stylesheet"> 
    <link href="css/dashboard.css" rel="stylesheet">
   
    <script src="js/ie-emulation-modes-warning.js"></script>   
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript">
    function loadQuery(data)
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
	    	//document.getElementById("displayRecord").innerHTML=xmlhttp.responseText;
	    	//alert("responseXML is : "+xmlhttp.responseXML);
	    		//var parser = new DOMParser();
				//var xmlDoc = parser.parseFromString(xmlhttp.responseText,"text/xml");
	    	//alert("The parsed response is : "+xmlDoc);
	    		x=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
	    		//alert("No of records is  "+x.length);
	    		var k;
	    		students = [];
	    		index = 0;
	    		//alert("Just pushing students");
	    		for(k = 0; k < x.length; k++)
	    		{
	    			//alert("Just pushing students");
	    			var sid = x[k].getElementsByTagName("ID");
			    	sid = sid[0].firstChild.nodeValue;
			    	
			    	var name = x[k].getElementsByTagName("NAME");
			    	name = name[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var email = x[k].getElementsByTagName("EMAIL");
			    	email = email[0].firstChild.nodeValue;
			    	
			    	var pid = x[k].getElementsByTagName("PID");
			    	pid = pid[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var address = x[k].getElementsByTagName("ADDRESS");
			    	address = address[0].firstChild.nodeValue;
			    	
			    	var parent = x[k].getElementsByTagName("PARENT");
			    	parent = parent[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var lang = x[k].getElementsByTagName("LANG");
			    	
			    	if(lang[0] == null || lang[0].firstChild == null)
			    		lang = "";
			    	else
			    		lang = lang[0].firstChild.nodeValue;
			    	
			    	//alert("Just pushing students");
			    	var db = x[k].getElementsByTagName("DB");
			    	if(db[0] == null || db[0].firstChild == null)
			    		db = "";
			    	else
			    		db = db[0].firstChild.nodeValue;
			    	
			    	var img = x[k].getElementsByTagName("IMAGE");
			    	img = img[0].firstChild.nodeValue;
			    	
			    	var mobile = x[k].getElementsByTagName("MOBILE");
			    	mobile = mobile[0].firstChild.nodeValue;
			    	
			    	//alert("ID, Name, Mobile, k : "+sid+" "+name+" "+mobile+" "+k);
			    	students.push(new student(sid, name, mobile, email, pid, address, parent, lang, db, img));
	    		}
	    		
	    		//alert("Number of records : "+students.length);
	    		
	    		drawTable();
	     }
	   
	  }
	  
	  var path = "<%=basePath%>"+"student/searchQuery.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(data);
	}
    
    var index = 0;
    
    function searchRecord()
    {
    	var field = document.getElementById("selectCriteria").value;
    	if(field == "1")
    	{
    		var a = document.getElementById("val1").value;
    		var b = document.getElementById("val2").value;
    		var c = document.getElementById("val3").value;
    		var d = document.getElementById("val4").value;
    		
    		var id = a + "/" + b + "/" + c + "/" + d;
    		//alert("Search criteria is id with value : "+id);
    		
    		var data = "id="+id;
    		loadQuery(data);
    		
    	
    	}
    	else if(field == "2")
    	{
    		var name = document.getElementById("stname").value;
    		//alert("Search criteria is name with value : "+name);
    		
    		var data = "name="+name;
    		loadQuery(data);
    		
    	}
    	else if(field == "3")
    	{
    		var email = document.getElementById("inputEmail").value;
    		//alert("Search criteria is email with value : "+email);
    		
    		var data = "email="+email;
    		loadQuery(data);
    	
    	}
    	else if(field == "4")
    	{
    		var mobile = document.getElementById("inputParent").value;
    		//alert("Search criteria is mobile with value : "+mobile);
    		
    		var data = "mobile="+mobile;
    		loadQuery(data);
    	
    	}
    	
    	else if(field == "5")
    	{
    		var pid = document.getElementById("packageid").value;
    		//alert("Search criteria is package with value : "+pid);
    		
    		var data = "pid="+pid;
    		loadQuery(data);
    	
    	}
    	
    	else if(field == "6")
    	{
    		var lang = document.getElementById("languageid").value;
    		//alert("Search criteria is lang with value : "+lang);
    		
    		var data = "lang="+lang;
    		loadQuery(data);
    	
    	}
    	else if(field == "7")
    	{
    		var dbid = document.getElementById("dbcourseid").value;
    		//alert("Search criteria is dbcourse with value : "+dbid);
    		
    		var data = "dbid="+dbid;
    		loadQuery(data);
    	
    	}
    	else if( field == "8")
    	{
    		var clg = document.getElementById("collegeid").value;
    		//alert("Search criteria is clg with value : "+clg);
    		
    		var data = "clg="+clg;
    		loadQuery(data);
    	
    	}
    	else if(field == "9")
    	{
    		var sem = document.getElementById("semesterid").value;
    		//alert("Search criteria is sem with value : "+sem);
    		
    		var data = "sem="+sem;
    		loadQuery(data);
    	
    	}
    	else if(field == "10")
    	{
    		var degree = document.getElementById("degreeid").value;
    		//alert("Search criteria is degree with value : "+degree);
    		
    		var data = "degree="+degree;
    		loadQuery(data);
    	
    	}
    	else
    	{
    	
    	}
    
    }
    
    	var students = [];
    	
    	function student(sid, name, mobile, email, pid, address, parent, lang, db, img)
    	{
    		this.id = sid; 
    		this.name  = name;
    		this.mobile = mobile;
    		this.select = false;
    		this.email = email;
    		this.pid = pid;
    		this.address = address;
    		this.parent = parent;
    		this.lang = lang;
    		this.db = db;
    		this.img = img;
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
    	
    	function drawTable()
		{
			var i = 0;
			var display = "";
			//alert("Draw table called");
			
			
	       	display += "<tr><th>Student ID</th>";
	       	display += "<th>Name</th>";
	       	display += "<th>Email</th>";
	       	display += "<th>Mobile</th>";
	       	display += "<th>P-ID</th>";
	       	display += "<th>Local Add.</th>";
	       	display += "<th>Parent Mob.</th>";
	       	display += "<th>Language</th>";
	       	display += "<th>Database</th>";
	       	display += "<th>Image</th>";	
	       	display += "</tr>";
			
			
// 			/* display += "<tr>";
//      			display += "<th>Select</th>";
//      			display +="<th>Student ID</th>";
//      			display +="<th>Name</th>";
//      			display +="<th>Mobile</th>";
//      			display += "</tr>"; */
     		
			for(i = index; i < students.length && i < index + 15; i++)
			{
			//alert("Draw table called");
				display += "<tr>";
				
				display += "<td>"+students[i].id+"</td>";
				display += "<td>"+students[i].name+"</td>";
				display += "<td>"+students[i].email+"</td>";
				display += "<td>"+students[i].mobile+"</td>";
				display += "<td>"+students[i].pid+"</td>";
				display += "<td><a  data-toggle='tooltip' title='"+students[i].address+"'>View</a></td>";
				display += "<td>"+students[i].parent+"</td>";
				display += "<td>"+students[i].lang+"</td>";
				display += "<td>"+students[i].db+"</td>";
				display += "<td><img src="+students[i].img+" height='50px' width='50px'></td>";
				
				display += "</tr>";
				
			}
			////alert("Draw table called with index :"+index);
			index = i;
			//alert("Draw table called with index :"+index);
			document.getElementById("table").innerHTML = display;
		
		}
    	
    	
    	
    
    
    </script>
  </head>
  
  <body>
    <form method="get" class="form-horizontal" onsubmit="return false;" name="optionForm">
   
       <fieldset>
           <legend><strong>&nbsp;&nbsp;Search Student</strong></legend>
           
           <div class="form-group">
           <label for="selectCriteria" class="col-sm-2 control-label" align="left">Select Criteria :</label>
           <div class="col-sm-3">
           <select name="selectCriteria" id="selectCriteria" class="form-control" onchange="CriteriaSelected(this.value);">
           <option value="" selected="selected">Select</option>
           <option value="1">RAT ID</option>
           <option value="2">Name</option>
           <option value="3">Email ID</option>
           <option value="4">Mobile Number</option>
           <option value="5">Package Enrolled</option>
           <option value="6">Language Enrolled</option>
           <option value="7">DataBase Enrolled</option>
           <option value="8">College Name</option>
           <option value="9">Semester</option>
           <option value="10">Degree</option>          
           </select>
           </div>
           </div>
           <%
           Connection con = null;
           try
           {
           
           
          	con = DBInfo.getConn();
            %>
           
           <div class="form-group" Id="fill">
           
           
               
           </div>
           
           <div class="form-group"> 
 		    <div class="col-sm-offset-3 col-sm-2"> 
 		     <input type="submit" class="btn btn-primary" value="Search Students >>>" onclick="searchRecord();" name="issueID"/> 
 		    </div>
   		</div>
       </fieldset>
       
       <fieldset>
       <legend><strong>&nbsp;&nbsp;Search Result</strong></legend>
       <div class="form-group">
    <div class="col-sm-12">
     	<table id="table" class="table table-hover">
     		
     	
     	
     	</table>
     	<ul class="pager">
  			<li><a href="javascript:displayPrev()">&lt;- Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next -&gt;</a></li>
		</ul>
    </div>
  </div>
       </fieldset>
     </form>
     
     
     <script type="text/javascript">
     
     function CriteriaSelected(Criteria)
     {
       if(Criteria == "" || Criteria == null)
       {
           
       }
     
       else if(Criteria == "1")     //student id is selected
       {
          var ID = "";
         
        
        ID += "<label class='col-sm-2 control-label' Id='lbl'>Enter Student ID :</label>";
        ID +=  "<div class='col-sm-1'><input type='text' name='text1' Id='val1' class='form-control' required='true'></input></div>";
        ID +=  "<div class='col-sm-1'><select name='text2' class='form-control' Id='val2'><option value='TR'>Tonk Road</option><option value='PN'>Pratap Nagar</option><option value='KK'>Kukas</option><option value='OT'>Other</option></select></div>";
        ID +=  "<div class='col-sm-1'><input type='text' name='text3' Id='val3' class='form-control' value='STU' readonly='true'></input></div>";
		ID +=  "<div class='col-sm-1'><input type='text' name='text4' Id='val4' class='form-control' Maxlength='5'></input></div>";
		
         
         document.getElementById('fill').innerHTML = ID;
       }
       
       else if(Criteria == "2")    //student name is selected
       {
          var name ="";
          
           name += "<label class='col-sm-2 control-label' Id='lbl'>Enter Name :</label>";
           name += "<div class='col-sm-3'><input type='text' class='form-control' name='studentName' Id='stname'></input></div>";
      
           document.getElementById('fill').innerHTML = name;
       }
       
       else if(Criteria == "3")    //student email id is selected
       {
        var mail = "";
        
        mail += "<label class='col-sm-2 control-label' Id='lbl'>Enter Email ID :</label>";
        mail += "<div class='col-sm-3'><input type='email' name='stumail' class='form-control' id='inputEmail' placeholder='Enter Email Id(Ex. xyz@gmail.com)'  pattern='\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*' required='true'></input></div>";
        
          document.getElementById('fill').innerHTML = mail;
       }
       
       else if(Criteria == "4")    //student mobile number is selected
       {
          var mob ="";
          
           mob += "<label class='col-sm-2 control-label' Id='lbl'>Enter Mobile No. :</label>";
           mob += "<div class='col-sm-3'><input type='text' class='form-control' Maxlength='10' name='stumobile' id='inputParent' pattern='^[7-9][0-9]{9}$' Placeholder='Enter Mobile No.(Ex. 9876543210)'></input></div>";
      
           document.getElementById('fill').innerHTML = mob;
       }
       
       else if(Criteria == "5")  //Package enrolled is selected
       {
             var pack = "";
             pack += "<label class='col-sm-2 control-label' Id='lbl'>Select Package :</label>";
       <%
         try
         {
               String stmt = "Select * from package";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
        %>        
         pack +=  "<div class='col-sm-3'><select name='selectPackage' class='form-control' Id='packageid'>";   
                
           <% 
             while(rs.next())
               {              
            %>
           pack += "<option value='<%=String.valueOf(rs.getInt(1))%>'><%=rs.getString(3)%></option>";           
           <%
               }   
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
          pack +=  "</select></div>";
               
        document.getElementById('fill').innerHTML = pack;
       }
       
       else if(Criteria == "6")  //Language enrolled is selected
       {
            var lang = "";
          lang += "<label class='col-sm-2 control-label' Id='lbl'>Select Language :</label>";
       <%
          try
            {            
               String stmt = "Select * from course";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
        %>        
         lang +=  "<div class='col-sm-3'><select name='selectLanguage' class='form-control' Id='languageid'>";   
                
           <% 
             while(rs.next())
               {              
            %>
         lang += "<option value='<%=rs.getString(1)%>'><%=rs.getString(2) %></option>";           
           <%
               }   
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
         lang +=  "</select></div>";
               
        document.getElementById('fill').innerHTML = lang;
       }
       
       else if(Criteria == "7")  //Database enrolled is selected
       {
            var db = "";
          db += "<label class='col-sm-2 control-label' Id='lbl'>Select DataBase :</label>";
         <%
          try
            {
            
               String stmt = "Select * from dbcourse";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
          %>        
         db +=  "<div class='col-sm-3'><select name='selectDBcourse' class='form-control' Id='dbcourseid'>";   
                
            <% 
             while(rs.next())
               {              
             %>
         db += "<option value='<%=rs.getString(1)%>'><%=rs.getString(2) %></option>";           
           <%
               }   
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
         db +=  "</select></div>";
               
        document.getElementById('fill').innerHTML = db;
       }
       
       else if(Criteria == "8")  //College name is selected
       {
           var clgname = "";
           
           clgname += "<label class='col-sm-2 control-label' Id='lbl'>Select College Name :</label>";
           <%
         try
         {
            
               String stmt = "Select * from college";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
          %> 
          
          clgname +=  "<div class='col-sm-3'><select name='selectCollege' class='form-control' Id='collegeid'>";
      
             <% 
             while(rs.next())
               {              
             %>
         clgname += "<option value='<%=rs.getString(1)%>'><%=rs.getString(2) %></option>";           
           <%
               }   
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
          
          clgname +=  "</select></div>";
          
          document.getElementById('fill').innerHTML = clgname;
       }
       
       else if(Criteria == "9")  //Semester of student is selected
       {
          var sem = "";
           
           sem += "<label class='col-sm-2 control-label' Id='lbl'>Select Semester :</label>";
           <%
         try
         {
            
               String stmt = "Select * from semester";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
          %> 
          
          sem +=  "<div class='col-sm-3'><select name='selectSemester' class='form-control' Id='semesterid'>";
      
             <% 
             while(rs.next())
               {              
             %>
         sem += "<option value='<%=rs.getString(1)%>'><%=rs.getString(2) %></option>";           
           <%
               }   
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
          
          sem +=  "</select></div>";
          
          document.getElementById('fill').innerHTML = sem;
       }
       
       else if(Criteria == "10") //Degree of student is selected
       {
       
          var degree = "";
           
           degree += "<label class='col-sm-2 control-label' Id='lbl'>Select Student's Degree :</label>";
           <%
         try
         {
            
               String stmt = "Select * from degree";
               PreparedStatement ps = con.prepareStatement(stmt);
               ResultSet rs = ps.executeQuery();       
          %> 
          
          degree +=  "<div class='col-sm-3'><select name='selectDegree' class='form-control' Id='degreeid'>";
      
             <% 
             while(rs.next())
               {              
             %>
         degree += "<option value='<%=rs.getString(1)%>'><%=rs.getString(2) %></option>";           
           <%
               }  
               
         }
         catch(Exception e)
         {
               e.printStackTrace();
         }
            %>
          
          degree +=  "</select></div>";
          
          document.getElementById('fill').innerHTML = degree;
       }
     }
     </script>
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
  </body>
</html>
