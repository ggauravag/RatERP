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
                     Connection con = DBInfo.getConn();
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
 var students = [];
 
 var stuarray = [];

 var pagesize = 2;
 
 var indexStudent = 0;

	function stuobj(sid, name, mobile, email, pid, address, parent, lang, db, img)
    	{
    		this.id = sid; 
    		this.name  = name;
    		this.mobile = mobile;
    		this.email = email;
    		this.pid = pid;
    		this.address = address;
    		this.parent = parent;
    		this.lang = lang;
    		this.db = db;
    		this.img = img;
		}
		
		
		function loadStudent(data)
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
			         //document.getElementById("table").innerHTML=xmlhttp.responseText;
			    	 //alert(xmlhttp.responseXML);	
			    	 y=xmlhttp.responseXML.documentElement.getElementsByTagName("STUDENT");
			    	 stuarray = [];
			    	 var k ;
			    	 for(k = 0; k < y.length; k++)
			    		{
			    			//alert("Just pushing students");
			    			var sid = y[k].getElementsByTagName("ID");
				    		sid = sid[0].firstChild.nodeValue;
				    	
					    	var name = y[k].getElementsByTagName("NAME");
					    	name = name[0].firstChild.nodeValue;
					    	//alert("Just pushing students");
					    	var email = y[k].getElementsByTagName("EMAIL");
					    	email = email[0].firstChild.nodeValue;
					    	
					    	var pid = y[k].getElementsByTagName("PID");
					    	pid = pid[0].firstChild.nodeValue;
					    	//alert("Just pushing students");
					    	var address = y[k].getElementsByTagName("ADDRESS");
					    	address = address[0].firstChild.nodeValue;
					    	
					    	var parent = y[k].getElementsByTagName("PARENT");
					    	parent = parent[0].firstChild.nodeValue;
					    	//alert("Just pushing students");
					    	var lang = y[k].getElementsByTagName("LANG");
					    	
					    	if(lang[0] == null || lang[0].firstChild == null)
					    		lang = "";
					    	else
					    		lang = lang[0].firstChild.nodeValue;
					    	
					    	//alert("Just pushing students");
					    	var db = y[k].getElementsByTagName("DB");
					    	if(db[0] == null || db[0].firstChild == null)
					    		db = "";
					    	else
					    		db = db[0].firstChild.nodeValue;
					    	
					    	var img = y[k].getElementsByTagName("IMAGE");
					    	img = img[0].firstChild.nodeValue;
					    	
					    	var mobile = y[k].getElementsByTagName("MOBILE");
					    	mobile = mobile[0].firstChild.nodeValue;
					    	
				    	//alert("ID, Name, Mobile, k : "+sid+" "+name+" "+mobile+" "+k);
				    	stuarray.push(new stuobj(sid, name, mobile, email, pid, address, parent, lang, db, img));
		    			//alert("The length is : "+stuarray.length);
		    			
		    		}
			    	
			    	 //alert("just after loading,The length is : "+stuarray.length+" and index is : "+index);
			    	 indexStudent = 0;
			    	 drawStu();
			     }
			   
			 }
			  
			var path = "<%=basePath%>"+"student/searchQuery.jsp";
			xmlhttp.open("POST",path,true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send(data);
		}
		
		
		
		function displayStudents()
		{
		
			var classid = document.forms["optionForm"].classid.value;
			if(classid == null)
			{
				alert("Please select a class first");
				return;
			}
			
			var data = "csid="+classid;
			//alert("Before loading,The length is : "+stuarray.length);
			loadStudent(data);
			//alert("After loading & before drawing,The length is : "+stuarray.length);
			//drawStu();
			//alert("After drawing,The Index is  : "+index);
		}
		
		
		function displayPrev()
    	{
    		//alert("index is : "+indexStudent+" and students is : "+stuarray.length)
    		if(stuarray.length > 0 && indexStudent > pagesize)
    		{
    			if((indexStudent - (2*pagesize)) < 0)
    				indexStudent = 0;
    			else
    				indexStudent = indexStudent - (2*pagesize);
    			drawStu();
    		}
    		//alert("index is : "+indexStudent+" and students is : "+stuarray.length)
    	
    	}
    	
    	function displayNext()
    	{
    		//alert("index is : "+indexStudent+" and students is : "+stuarray.length)
    		if(indexStudent < stuarray.length)
    		{
    			drawStu();
    		}
    		//alert("index is : "+indexStudent+" and students is : "+stuarray.length)
    	}
    	
    	function drawStu()
		{
			var i = 0;
			var display = "";
			//alert("Draw Student called");
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
	       	
	       	//alert("The length during drawing is : "+stuarray.length);
			     		
			for(i = indexStudent; i < stuarray.length && i < indexStudent + pagesize; i++)
			{
			    //alert("Drawing row number : "+i+" with index : "+index+" and array length : "+stuarray.length);
				display += "<tr>";
				display += "<td>"+stuarray[i].id+"</td>";
				display += "<td>"+stuarray[i].name+"</td>";
				display += "<td>"+stuarray[i].email+"</td>";
				display += "<td>"+stuarray[i].mobile+"</td>";
				display += "<td>"+stuarray[i].pid+"</td>";
				display += "<td><a  data-toggle='tooltip' title='"+stuarray[i].address+"'>View</a></td>";
				display += "<td>"+stuarray[i].parent+"</td>";
				display += "<td>"+stuarray[i].lang+"</td>";
				display += "<td>"+stuarray[i].db+"</td>";
				display += "<td><img src="+stuarray[i].img+" height='50px' width='50px'></td>";
				display += "</tr>";
			}
			////alert("Draw table called with index :"+index);
			indexStudent = i;
			//alert("Draw table called with index :"+index);
			document.getElementById("table").innerHTML = display;
		
		}
		
		
//--------------------------------------------------------------------------------------------///
// ------------------------------------------------------------------------------------------///		
		
		
		


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
	         //document.getElementById("table").innerHTML=xmlhttp.responseText;
	    	 //alert(xmlhttp.responseXML);	
	    	 
	    	 y=xmlhttp.responseXML.documentElement.getElementsByTagName("VIEWCLASS");
	    	 
	    	 if(y[0]!=null)
	    	 {
	    	  ritesh();
	    	 }
	    	 
	    	   
	     }
	   
	   }
	  
	var path = "<%=basePath%>"+"class/SearchClass.jsp";
	xmlhttp.open("POST",path,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(id);
}

  
		function ritesh()
		{
  				var k;
	    		students = [];
	    		index = 0;
	    		//alert("Just pushing students");
	    		for(k = 0; k < y.length; k++)
	    		{
	    			//alert("Just pushing students");
	    			var tid = y[k].getElementsByTagName("CID");
			    	tid = tid[0].firstChild.nodeValue;
			    	//alert(tid);
			    	var tm = y[k].getElementsByTagName("TIME");
			    	tm = tm[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var schd = y[k].getElementsByTagName("SCHED");
			    	schd = schd[0].firstChild.nodeValue;
			    	
			    	var cntr = y[k].getElementsByTagName("CENTER");
			    	cntr = cntr[0].firstChild.nodeValue;
			    	
			    	var tname = y[k].getElementsByTagName("TNAME");
			    	tname = tname[0].firstChild.nodeValue;
			    	
			    	var sdt = y[k].getElementsByTagName("SDATE");
			    	sdt = sdt[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	
			    	
			    	//alert("ID, Name, Mobile, k : "+tid+" "+tm+" "+schd+""+cntr+""+tname+""+sdt);
			    	students.push(new student(tid,tm,schd,cntr,tname,sdt));
	    		}
	    	   	drawTable(); 
		}  
  
  
 
    	
    	function student(tid,tm,schd,cntr,tname,sdt)
    	{
    		this.tid = tid; 
    		this.tm  = tm;
    		this.schd = schd;
    		this.cntr = cntr;
    		this.tname = tname;
    		this.sdt = sdt;
		} 
		
		
		
		
		
 
function drawTable()
{
			var i = 0;
			var dd = "";
			//alert("Draw table called");
			dd += "<table class='table table-striped'>";
			dd += "<tr><th>Select Class</th>";
			var ff = document.getElementById("criteria").value;
			if(ff == "1")
			{
			
	       	dd += "<th>Class ID</th>";
	       	dd += "<th>TIME</th>";
	       	dd += "<th>SCHEDULE</th>";
	       	dd += "<th>CENTER</th>";
	       	dd += "<th>TRAINER NAME</th>";
	       	dd += "<th>START DATE</th>";
	       	dd += "</tr>";
			}
			else if(ff == "2")
			{
			    dd += "<th>Class ID</th>";
		       	dd += "<th>TIME</th>";
		       	dd += "<th>SCHEDULE</th>";
		       	dd += "<th>COURSE ID</th>";
		       	dd += "<th>TRAINER NAME</th>";
		       	dd += "<th>START DATE</th>";
		       	dd += "</tr>";
			}
			else if(ff == "3")
			{
			    dd += "<th>Class ID</th>";
		       	dd += "<th>TIME</th>";
		       	dd += "<th>SCHEDULE</th>";
		       	dd += "<th>COURSE ID</th>";
		       	dd += "<th>CENTER</th>";
		       	dd += "<th>START DATE</th>";
		       	dd += "</tr>";
			}
			else if(ff == "4")
			{
			  var cd = document.getElementById("cid").value;
			    dd += "<th>COURSE ID</th>";
		       	dd += "<th>TIME</th>";
		       	dd += "<th>SCHEDULE</th>";
		       	dd += "<th>CENTER</th>";
		       	dd += "<th>Trainer Name</th>";
		       	dd += "<th>START DATE</th>";
		       	dd += "</tr>";
		       	
		       	
		       	for(i = index; i < students.length && i < index + 15; i++)
		    	{
			       //alert("Draw table called for loop"+students[i].tid);
				dd += "<tr>";
				dd += "<td><input type='radio' name='classid' id='clsid' value="+cd+" ></td>";				
				dd += "<td>"+students[i].tid+"</td>";
				dd += "<td>"+students[i].tm+"</td>";
				dd += "<td>"+students[i].schd+"</td>";
				dd += "<td>"+students[i].cntr+"</td>";
				dd += "<td>"+students[i].tname+"</td>";
				dd += "<td>"+students[i].sdt+"</td>";
				dd += "</tr>"; 
				
		    	} 
			
			
			}
			else
			{
			
			}
        if(ff != "4")
        {
           
			for(i = index; i < students.length && i < index + 15; i++)
			{
			//alert("Draw table called for loop"+students[i].tid);
				dd += "<tr>";
				dd += "<td><input type='radio' name='classid' id='clsid' value="+students[i].tid+"></td>";				
				dd += "<td>"+students[i].tid+"</td>";
				dd += "<td>"+students[i].tm+"</td>";
				dd += "<td>"+students[i].schd+"</td>";
				dd += "<td>"+students[i].cntr+"</td>";
				dd += "<td>"+students[i].tname+"</td>";
				dd += "<td>"+students[i].sdt+"</td>";
				dd += "</tr>"; 
				
			} 
		}	
			dd += "</table>";
			//alert("Draw table called with index :"+index);
			index = i;
			//alert("Draw table called with index :"+index);
			document.getElementById("display").innerHTML = dd;
		
}
 
 
 
  function searchRecord()
    {
    document.getElementById("display").innerHTML = "";
    
    
    	var field = document.getElementById("criteria").value;
    	if(field == "1")  //Course is selected
    	{
    		
    		
    		var d=document.getElementById("courseid").value;
    		var data = "VcourseID="+d;
    		loadID(data);
    		
    	
    	}
    	else if(field == "2") // Center is selected
    	{
    		
    	    var cn = document.getElementById("center").value;
    		var data = "center="+cn;
    		loadID(data);
    		
    	}
    	else if(field == "3") //TrainerName is selected
    	{
    		var tnm = document.getElementById("trainerid").value;
    		
    		var data = "tn="+tnm;
    		loadID(data);
    	
    	}
    	else if(field == "4") //Class id is selected
    	{
    		var cd = document.getElementById("cid").value;
 
    		
    		var data = "vcid="+cd;
    		loadID(data);
    	
    	}
    	
    }
    
    
    	
    
    
  </script>




  </head>
  
  <body>
    <form method="post" class="form-horizontal" name="optionForm">
   
    <fieldset>
           <legend><strong>&nbsp;&nbsp;Search Class</strong></legend>
           
           <div class="form-group">
           <label for="selectCriteria" class="col-sm-2 control-label" align="left">Select Criteria :</label>
            <div class="col-sm-3">
                <select name="selectCriteria" id="criteria" class="form-control" onchange="CriteriaSelected(this.value);">
                  <option value="" selected="selected">Select</option>
                  <option value="1">Course</option>
                  <option value="2">Centre</option>
                  <option value="3">Trainer Name</option>
                  <option value="4">Class ID</option>
                </select>
            </div>
           </div>
           
           <div class="form-group" Id="fill">
           
           
               
           </div>
           
           <div class="form-group"> 
 		    <div class="col-sm-offset-5 col-sm-2"> 
 		     <input type="button" class="btn btn-primary" value="Search Classes >>>" onclick="searchRecord();" name="searchcls"/> 
 		    </div>
   		</div>
      </fieldset>
      
     
     <fieldset>
       <legend><strong>&nbsp;&nbsp;Search Result</strong></legend>
       <div class="form-group">
      <div class="col-sm-12" id="display">
     	
     	
     	
     	
    </div>
    <input type=button class="btn btn-info col-sm-offset-5" value="Display Student" id="disbtn" onclick="displayStudents()">
  </div>
       </fieldset>
       
       
       <fieldset>
       <legend><strong>&nbsp;&nbsp;Students</strong></legend>
       <div class="form-group">
      <div class="col-sm-12" id="display">
     	<table id="table" class="table table-striped">
     	
     	
     	</table>
    </div>
    
  </div>
  <ul class="pager">
  			<li><a href="javascript:displayPrev()">&lt;- Previous</a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<li><a href="javascript:displayNext()">Next -&gt;</a></li>
		</ul>
       </fieldset>
       
       
       
       
      
      </form>
        <script type="text/javascript">
       
       function CriteriaSelected(Criteria)
     {
     
       
       if(Criteria == "" || Criteria == null)
       {
           return;
       }
     
       else if(Criteria == "1")     //course is selected
       {
       
          
            var crse = "";
             crse += "<div class='form-group'><label class='col-sm-2 control-label' Id='lbl'>Select Course :</label>";
        <%
              try{
			       PreparedStatement ps = con.prepareStatement("Select * from course");
			       ResultSet rs = ps.executeQuery();       
        %>        
         crse +=  "<div class='col-sm-3'><select name='course' class='form-control' Id='courseid'>";   
               
           <% 
             while(rs.next())
               {              
            %>
          crse += "<option value='<%=String.valueOf(rs.getString(1))%>'><%=rs.getString(2)%></option>";           
           <%
               }
               
            %>
          crse += "<option disabled='disabled'>----------DataBase Courses-------</option>";  
            <%
               PreparedStatement ps1 = con.prepareStatement("Select * from dbcourse");
			   ResultSet rs1 = ps1.executeQuery(); 
            
               while(rs1.next())
               { 
            %>
            crse += "<option value='<%=String.valueOf(rs1.getString(1))%>'><%=rs1.getString(2)%></option>";           
           <%
               }
               
            }
            catch(Exception e)
            {
             e.printStackTrace();
            }
             %>  
          crse +=  "</select></div></div>";
               
        document.getElementById('fill').innerHTML = crse; 
       }
       else if(Criteria == "2")     //center is selected
       {
          var data="";
          
          data += "<div class='form-group'><label class='col-sm-2 control-label' Id='lbl'>Select Center :</label>";
          data += "<div class='col-sm-3'><select name='center' class='form-control' Id='center'>";   
          data += "<option value='TR'>Tonk Road</option>";
          data += "<option value='PN'>Pratap Nagar</option>";
          data += "<option value='KK'>Kukas</option>";
          data += "<option value='OT'>Other</option>";
          data += "</select></div></div>";
          
          document.getElementById('fill').innerHTML = data; 
       }
       else if(Criteria == "3")     //Trainerid is selected
       {
          var ID = "";
        ID += "<div class='form-group'><label class='col-sm-2 control-label' Id='lbl'>Select Trainer Name :</label>";
        <%
              try{
			       PreparedStatement ps = con.prepareStatement("Select * from trainer");
			       ResultSet rs = ps.executeQuery();       
        %>        
         ID +=  "<div class='col-sm-3'><select name='trainer' class='form-control' Id='trainerid'>";   
               
           <% 
             while(rs.next())
               {              
            %>
          ID += "<option value='<%=String.valueOf(rs.getString(1))%>'><%=rs.getString(2)%></option>";           
           <%
               } //End of while
            }//End of try
            catch(Exception e)
            {
             e.printStackTrace();
            }
             %>  
          ID +=  "</select></div></div>";
         
         document.getElementById('fill').innerHTML = ID;
       }
       else if(Criteria == "4")     //class id is selected
       {
           var dt = "";
             dt += "<div class='form-group'><label class='col-sm-2 control-label' Id='lbl'>Select Class ID :</label>";
         <%
              try{
			       PreparedStatement ps = con.prepareStatement("Select classid from class");
			       ResultSet rs = ps.executeQuery();       
         %>        
         dt +=  "<div class='col-sm-3'><select name='cid' class='form-control' Id='cid'>";   
               
           <% 
             while(rs.next())
               {              
            %>
          dt += "<option value='<%=String.valueOf(rs.getString(1))%>'><%=rs.getString(1)%></option>";           
           <%
               }
             }
             catch(Exception e)
             {
               e.printStackTrace();
             }
            %>
            dt +=  "</select></div></div>";
            document.getElementById('fill').innerHTML = dt;
       }
       else
       {
        return;
       }
    }
       
       
</script>  
  </body>
</html>
