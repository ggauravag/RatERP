
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <base href="<%=basePath%>">
    
    <title>Print Certificate</title>
    
	
	<style type="text/css" media="print">
        @page 
        {
            size: auto;   /* auto is the current printer page size */
            margin: 0mm;  /* this affects the margin in the printer settings */
        }
        
    </style>
 
  </head>
  
  <body style="color:white" >
 	
  
 
  <div style="background-image: url(account/image/cer4.jpg); background-repeat:no-repeat;height:145%; width:auto;-webkit-print-color-adjust:exact;">	<br>
  		<div style="color:black;transform: rotate(90deg);width:170px;position: fixed; left: 427px;top: 530px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:25px;"><strong>Gaurav Agarwal</strong></div>
  	<div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 280px;top: 540px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:25px;"><strong>Swami Keshvanand College Of Technology</strong></div>
  	
  	<div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 245px;top: 710px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:25px;font-weight:bold">B. Tech</div>
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 245px;top: 810px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:20px;font-weight:bold">5<sup>th</sup>/3<sup>rd</sup></div>
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 140px;top: 620px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:23px;font-weight:bold">Sep-14</div>
  
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 140px;top: 795px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:23px;font-weight:bold">Dec-14</div>
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 103px;top: 650px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:25px;font-weight:bold">Core Java</div>
  
   <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 42px;top: 620px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:25px;font-weight:bold">Online Banking</div>
  
  <div style="color:black;transform: rotate(90deg);width:400px;position: fixed; left: 10px;top: 855px;font-style:italic;font-family:'Monotype Corsiva',sans;font-size:23px;font-weight:bold">Satisfactory</div>
  
  </div>
  
  </body>
</html>
