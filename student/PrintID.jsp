<%@ page language="java" import="java.util.*, com.login.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

		Student[] students = (Student [])session.getAttribute("students");
		 String[] select = (String [])session.getAttribute("select");
	int length = 0;
	int even = 0;
	int odd = 0;
	int index = 0;
	String check = null;
	if(students !=null && select != null)
	{
		length = select.length;
		even = length/2;
		odd = length % 2;
	
	}
	else
	{
		 check = "close";
	}
	
	
	Dictionary dict = new Hashtable<String, String>();
	dict.put("RAT SILVER CARD","student/id/silvercard.png");
	dict.put("RAT GOLD CARD","student/id/goldcard.png");
	dict.put("RAT SUPER SAVER PACK","student/id/supersaver.png");
	dict.put("RAT PLATINUM CARD","student/id/platinumcard.png");
	dict.put("Job Ready Package","student/id/nopackage.png");
	dict.put("Complete Oracle","student/id/javaoracle.png");
	dict.put("Complete JAVA","student/id/javaoracle.png");
	dict.put("Complete .NET","student/id/nopackage.png");
	dict.put("No Package","student/id/nopackage.png");
	

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Print ID Card</title>
    
	
<script>
<%
if(check!=null && check.equals("close"))
{
%>
window.close();

<%

}

%>


</script>
 
  </head>
  
  <body  style="color:black;">
  <table width="675px;">
  	
  	<%
  	
  		for(int f=0; f < even; f++)
  		{
  			////System.out.println(students[Integer.parseInt(select[index])]);
//  			System.out.println(students[Integer.parseInt(select[index])].getPackageName());
  			//System.out.println(dict.get(students[Integer.parseInt(select[index])].getPackageName()));
  			
  			if(dict.get(students[Integer.parseInt(select[index])].getPackageName()).equals("student/id/nopackage.png"))
  			{
  			%>
  			<tr>
  		<td><div style="background-image: url(<%=(String)dict.get(students[Integer.parseInt(select[index])].getPackageName()) %>); background-repeat:no-repeat; width:auto;-webkit-print-color-adjust:exact;">
  			<%
  			}
  			else
  			{
  			%>
  				<tr>
  		<td><div style="background-image: url(<%=(String)dict.get(students[Integer.parseInt(select[index])].getPackageName()) %>); background-repeat:no-repeat; width:auto;-webkit-print-color-adjust:exact;">
 
  			<%
  			}
  			%>
 		 	<table width="320px">
  		<tr>
	  	<td rowspan="2" style="width:70px;">
	  		<img src="student/<%=students[Integer.parseInt(select[index])].getPhoto() %>" height="70px;"></img>
	  	</td >
	  	<td style="width:250px;">
	  		<label style="font-size: small;font-style: oblique;">Student ID :
	  		</label>
	  		<label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  		<br>
	  		<%=students[Integer.parseInt(select[index])].getSid() %>
	  		</label>
	  	</td>
  	</tr>
  	<tr>
  		
  		<td style="width:250px;"><label style="font-size: small;font-style: oblique;">Student Name :
	  		</label>
	  	<label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  		<br>
	  		<%=students[Integer.parseInt(select[index])].getName() %>
	  		</label>
	  		
	  		</td>
  	</tr>
  	<tr>
  		<td style="width:70px;"></td>
  		<td style="width:250px;"></td>
  	</tr>
  	
  	
  	<tr>
  		<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Courses :
	  		</label></td>
  		<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  	
	  	<%
	  	{
	  					String l[] = students[Integer.parseInt(select[index])].getLString();
           				for(int i = 0; i < l.length; i++)
           				{
           					//System.out.println("iNSIDE ARRAY");
           					if(i!=l.length-1 && l[i]!=null)
           						out.print(l[i]+",");
           					else if(l[i]!=null)
           						out.print(l[i]+",");
           				
           				}
           				
           				String d[] = students[Integer.parseInt(select[index])].getDString();
           				for(int i = 0; i < d.length; i++)
           				{
           				//System.out.println("iNSIDE ARRAY");
           					if(i!=d.length-1 && d[i]!=null)
           						out.print(d[i]+",");
           					else if(d[i]!=null)
           						out.print(d[i]);
           				
           				}
           	}
	  		
	  		 		%>
	  		</label></td>
  	</tr>
  	<tr>
  		<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Emergency Contact :
	  		</label></td>
  		<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  	
	  		<%=students[Integer.parseInt(select[index])].getParentMobile() %>
	  		</label></td>
  	
  	</tr>
  	<tr>
  		<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Validity :
	  		</label></td>
  		<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  	
	  		Lifetime
	  		</label></td>
  	</tr>
  	
  	
  	</table>
  	<br>
  	<br>
  	<br>
  	</div></td>
  	<% index++; 
  		if(dict.get(students[Integer.parseInt(select[index])].getPackageName()).equals("student/id/nopackage.png"))
  			{
  			%>
  			
  		<td><div style="background-image: url(<%=(String)dict.get(students[Integer.parseInt(select[index])].getPackageName()) %>); background-repeat:no-repeat; width:auto;-webkit-print-color-adjust:exact; color:black;">
  			<%
  			}
  			else
  			{
  			%>
  				
  		<td><div style="background-image: url(<%=(String)dict.get(students[Integer.parseInt(select[index])].getPackageName()) %>); background-repeat:no-repeat; width:auto;-webkit-print-color-adjust:exact; color:white;">
 
  			<%
  			}
  			%>
  	<table width="320px">
  	<tr>
	  	<td rowspan="2" style="width:70px;">
	  		<img src="student/<%=students[Integer.parseInt(select[index])].getPhoto() %>" height="70px;"></img>
	  	</td>
	  	<td style="width:250px;">
	  		<label style="font-size: small;font-style: oblique;">Student ID :
	  		</label>
	  		<label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  		<br>
	  		<%=students[Integer.parseInt(select[index])].getSid() %>
	  		</label>
	  	</td>
  	</tr>
  	<tr>
  		
  		<td style="width:250px;"><label style="font-size: small;font-style: oblique;">Student Name :
	  		</label>
	  	<label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  		<br>
	  		<%=students[Integer.parseInt(select[index])].getName() %>
	  		</label>
	  		
	  		</td>
  	</tr>
  	<tr>
  		<td style="width:70px;"></td>
  		<td style="width:250px;"></td>
  	</tr>
  	
  	
  	<tr>
  		<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Courses :
	  		</label></td>
  		<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  	
	  		<%
	  					String l[] = students[Integer.parseInt(select[index])].getLString();
           				for(int i = 0; i < l.length; i++)
           				{
           					//System.out.println("iNSIDE ARRAY");
           					if(i!=l.length-1 && l[i]!=null)
           						out.print(l[i]+",");
           					else if(l[i]!=null)
           						out.print(l[i]+",");
           				
           				}
           				
           				String d[] = students[Integer.parseInt(select[index])].getDString();
           				for(int i = 0; i < d.length; i++)
           				{
           				//System.out.println("iNSIDE ARRAY");
           					if(i!=d.length-1 && d[i]!=null)
           						out.print(d[i]+",");
           					else if(d[i]!=null)
           						out.print(d[i]);
           				
           				}
	  		
	  		 		%>
	  		</label></td>
  	</tr>
  	<tr>
  		<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Emergency Contact :
	  		</label></td>
  		<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  	
	  		<%=students[Integer.parseInt(select[index])].getParentMobile() %>
	  		</label></td>
  	
  	</tr>
  	<tr>
  		<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Validity :
	  		</label></td>
  		<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  	
	  		Lifetime
	  		</label></td>
  	</tr>
  	
  	
  	</table>
  
  	<br>
  	<br>
  	<br>
  	
  	</div></td>
  	</tr>
  		<% 
  		index++;
  		}
  		
  		
  		for(int g = 0; g < odd;g++)
  		{
  		/* System.out.println((students[Integer.parseInt(select[index])].getPackageName()));
  		System.out.println("Ignore case : "+students[Integer.parseInt(select[index])].getPackageName().compareTo("Complete Oracle"));
  		System.out.println(dict.get(students[Integer.parseInt(select[index])].getPackageName()));
  		System.out.println(dict.get("Complete Oracle")); */
  		%>
  				<tr>
  			<td>
  			<div style="background-image: url(<%=(String)dict.get(students[Integer.parseInt(select[index])].getPackageName()) %>); background-repeat:no-repeat; width:auto;-webkit-print-color-adjust:exact;">
  			<table width="320px">
  				<tr>
	  				<td rowspan="2" style="width:70px;">
	  					<img src="student/<%=students[Integer.parseInt(select[index])].getPhoto() %>" height="70px;"></img>
	  				</td>
	  				<td style="width:250px;">
	  					<label style="font-size: small;font-style: oblique;">Student ID :</label>
	  					<label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  					<br>
	  						<%=students[Integer.parseInt(select[index])].getSid() %>
	  					</label>
	  				</td>
  				</tr>
  				<tr>
  					<td style="width:250px;"><label style="font-size: small;font-style: oblique;">Student Name :</label>
	  					<label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  					<br>
	  						<%=students[Integer.parseInt(select[index])].getName() %>
	  					</label>
	  				</td>
  				</tr>
  				<tr>
			  		<td style="width:70px;"></td>
			  		<td style="width:250px;"></td>
  				</tr>
  				<tr>
  					<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Courses :</label></td>
  					<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  	
	  					<%
	  					String l[] = students[Integer.parseInt(select[index])].getLString();
           				for(int i = 0; i < l.length; i++)
           				{
           					//System.out.println("iNSIDE ARRAY");
           					if(i!=l.length-1 && l[i]!=null)
           						out.print(l[i]+",");
           					else if(l[i]!=null)
           						out.print(l[i]+",");
           				
           				}
           				
           				String d[] = students[Integer.parseInt(select[index])].getDString();
           				for(int i = 0; i < d.length; i++)
           				{
           				//System.out.println("iNSIDE ARRAY");
           					if(i!=d.length-1 && d[i]!=null)
           						out.print(d[i]+",");
           					else if(d[i]!=null)
           						out.print(d[i]);
           				
           				}
	  		
	  		 		%>
	  		</label></td>
  			</tr>
  			<tr>
  				<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Emergency Contact :</label></td>
  				<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  				<%=students[Integer.parseInt(select[index])].getParentMobile() %>
	  			</label></td>
  			</tr>
  			<tr>
  				<td style="width:70px;"><label style="font-size: small;font-style: oblique;">Validity :</label></td>
  				<td style="width:250px;"><label style="font-family: Consolas;font-size: small;font-weight: bolder;">
	  	
	  		Lifetime
	  		</label></td>
  			</tr>
  		</table>
  		<br>
  		<br>
  		<br>
  		</div>
  	</td>
  	</tr>
  		
  		<%
  		}
  	
  	%>
  		
  </table>
  </body>
</html>
