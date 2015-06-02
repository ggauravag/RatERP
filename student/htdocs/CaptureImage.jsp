<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Image Capture</title>
	<meta name="generator" content="TextMate http://macromates.com/">
	<meta name="author" content="Joseph Huckaby">
	<!-- Date: 2008-03-15 -->
<link rel="stylesheet" href="../../css/bootstrap.css" type="text/css"></link></head>
<body>
	
	<fieldset>
           <legend><strong>&nbsp;Capture Student Photograph</strong></legend>
	
	
	<!-- First, include the JPEGCam JavaScript Library -->
	<script type="text/javascript" src="webcam.js"></script>
	
	<!-- Configure a few settings -->
	<script language="JavaScript">
		webcam.set_api_url( 'upload.jsp' );
		webcam.set_quality( 100 ); // JPEG quality (1 - 100)
		webcam.set_shutter_sound( true ); // play shutter click sound
	</script>
	
	<!-- Next, write the movie to the page at 320x240 -->
	<div class="col-sm-offset-4 img-thumbnail">
	<script language="JavaScript">
		document.write( webcam.get_html(220, 260) );
	</script>
	</div>
	<!-- Some buttons for controlling things -->
	<br/>
	<br/>
	<br/>
	<form role="form" class="form-horizontal col-sm-offset-4">
	 <div class="form-group">
	 	
		<input type=button class="btn btn-info" value="Configure" onClick="webcam.configure()">
		&nbsp;&nbsp;
		<input type=button value="Capture" class="btn btn-primary" onClick="webcam.freeze()">
		&nbsp;&nbsp;
		<input type=button value="Save" class="btn btn-success" onClick="do_upload()">
		&nbsp;&nbsp;
		<input type=button value="Reset" class="btn btn-default" onClick="webcam.reset()">
	 </div>
	</form>
	
	<!-- Code to handle the server response (see test.php) -->
	<script language="JavaScript">
		webcam.set_hook( 'onComplete', 'my_completion_handler' );
		
		function do_upload() {
			// upload to server
			//document.getElementById('upload_results').innerHTML = '<h1>Uploading...</h1>';
			webcam.upload();
		}
		
		function my_completion_handler(msg) {
			// extract URL out of PHP output
			/* if (msg.match(/(http\:\/\/\S+)/)) {
				var image_url = RegExp.$1;
				// show JPEG image in page
				document.getElementById('upload_results').innerHTML = 
					'<h1>Upload Successful!</h1>' + 
					'<h3>JPEG URL: ' + image_url + '</h3>' + 
					'<img src="' + image_url + '">';
				 */
				window.history.back();
			if(msg.equals("Success"))
			{
				// reset camera for another shot
				webcam.reset();
				//alert("Image Uploaded Successfully");
				window.close();
			}
			else 
			{
				
			}
		}
	</script>
	
	</td><td width=50>&nbsp;</td><td valign=top>
		<div id="upload_results" style="background-color:#eee;"></div>
	</td></tr></table>
</body>
</html>
