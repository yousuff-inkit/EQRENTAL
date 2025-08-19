
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<script type="text/javascript">

$(document).ready(function () {
	document.getElementById("branchdiv").style.visibility="hidden";
	document.getElementById("branchlabel").style.visibility="hidden";
	
	/*  $('#user').dblclick(function(){
	      userSearchContent("userSearch.jsp");

	  }); */
	 
	 /* $('#userDetailsToWindow').jqxWindow({width: '20%', height: '50%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'User Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#userDetailsToWindow').jqxWindow('close'); */
});

 function funreload(event)
{
		
	 $("#profilegrid").load("profileGrid.jsp?id=1");  
}
 
 function  funClearData(){
	 
	 $('#name').val('');
	 $('#email').val('');
	 $('#mobile').val('');
	 $('#uname').val('');
	 $('#sdocno').val('');
	 $('#password').val('');
	 
 }

 function funExportBtn(){
	    

	   JSONToCSVConvertor(checkinoutexcel, 'Check In-Out List', true);
	   }
	  
	  
	  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {

	      var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	      
	     // alert("arrData");
	      var CSV = '';    
	      //Set Report title in first row or line
	      
	      CSV += ReportTitle + '\r\n\n';

	      //This condition will generate the Label/Header
	      if (ShowLabel) {
	          var row = "";
	          
	          //This loop will extract the label from 1st index of on array
	          for (var index in arrData[0]) {
	              
	              //Now convert each value to string and comma-seprated
	              row += index + ',';
	          }

	          row = row.slice(0, -1);
	          
	          //append Label row with line break
	          CSV += row + '\r\n';
	      }
	      
	      //1st loop is to extract each row
	      for (var i = 0; i < arrData.length; i++) {
	          var row = "";
	          
	          //2nd loop will extract each column and convert it in string comma-seprated
	          for (var index in arrData[i]) {
	              row += '"' + arrData[i][index] + '",';
	          }

	          row.slice(0, row.length - 1);
	          
	          //add a line break after each row
	          CSV += row + '\r\n';
	      }

	      if (CSV == '') {        
	          alert("Invalid data");
	          return;
	      }   
	      
	      //Generate a file name
	      var fileName = "";
	      //this will remove the blank-spaces from the title and replace it with an underscore
	      fileName += ReportTitle.replace(/ /g,"_");   
	      
	      //Initialize file format you want csv or xls
	      var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	      
	      // Now the little tricky part.
	      // you can use either>> window.open(uri);
	      // but this will not work in some browsers
	      // or you will not get the correct file extension    
	      
	      //this trick will generate a temp <a /> tag
	      var link = document.createElement("a");    
	      link.href = uri;
	      
	      //set the visibility hidden so it will not effect on your web-layout
	      link.style = "visibility:hidden";
	      link.download = fileName + ".csv";
	      
	      //this part will append the anchor tag and remove it after automatic click
	      document.body.appendChild(link);
	      link.click();
	      document.body.removeChild(link);
	  }

	function funSubmit()
	{
		var doc = document.getElementById("sdocno").value;
		var name=document.getElementById("name").value;
		var email=document.getElementById("email").value;
		var mobile=document.getElementById("mobile").value;
		var uname=document.getElementById("uname").value;
		var pswd=document.getElementById("password").value;
		//alert(doc+":"+name+"::"+email+"::"+mobile+"::"+uname);
		var letters = /^[A-Za-z, ]+$/;
 		var mail=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
  		var numbers = /^[0-9]+$/;
  		
		  if(name.match(letters))
		  {
		  }
		  else
		  {
		
			  $.messager.alert("Message","Username must have alphabet characters only");
		      document.getElementById('name').focus();
		      return false;
		  }
		
		  if(email.match(mail))
		  {
		  }
		  else
		  {
		    
			 $.messager.alert("Message","You have entered an invalid email address!");
		     document.getElementById('email').focus();
		     return false;
		  }
		
		 
	  if(mobile.length!=12)
		  {
		     
			$.messager.alert("Message","Mobile number should not be empty / length be between 10 to 12");
		    document.getElementById('mobile').focus();
		    return false;
		  } 
		  
		
		
		var x=new XMLHttpRequest();
	    x.onreadystatechange=function()
	    {
	         
	    	if (x.readyState == 4 && x.status == 200)
	        {
	        	var msg=x.responseText.trim();
	            if(msg=="1")
	            {
	              	funreload();
	               	funClearData();
	               	$.messager.alert("Message","Updated Successfully");
	            }
	            else
	            {
	                    
	            	$.messager.alert("Message","Not Updated");
	            }
	        }
	        

	    }
	    x.open("GET", "updateProfile.jsp?doc="+doc+"&name="+name+"&email="+email+"&mobile="+mobile+"&uname="+uname+"&pswd="+pswd, true);
	    x.send();
		
		
	}
	
	 function userSearchContent(url) {
	   $('#userDetailsToWindow').jqxWindow('open');
	  $.get(url).done(function (data) {
	   $('#userDetailsToWindow').jqxWindow('setContent', data);
	  }); 
	 }
	 
	 function disable()
	 {
		$('#name').attr("disabled",true);
		$('#email').attr("disabled",true);
		$('#mobile').attr("disabled",true);
		$('#uname').attr("disabled",true);
		$('#password').attr("disabled",true);
		
		$('#btnsubmit').attr("disabled",true);
		$('#btncancel').attr("disabled",true);
	 }
	 function funEditData()
	 {
		 var doc= document.getElementById("sdocno").value;
		 if(doc=="")
		{
			alert(" Please select the document ");
			return false;
		}
		$('#name').attr("disabled",false);
		$('#email').attr("disabled",false);
		$('#mobile').attr("disabled",false);
		$('#uname').attr("disabled",false);
		$('#password').attr("disabled",false);
			
		$('#btnsubmit').attr("disabled",false);
		$('#btncancel').attr("disabled",false);
	 }
	 function funCancel()
	 {
		document.getElementById("sdocno").value="";
		document.getElementById("name").value="";
		document.getElementById("email").value="";
		document.getElementById("mobile").value="";
		document.getElementById("uname").value="";
		document.getElementById("password").value="";
		 
		$('#name').attr("disabled",true);
		$('#email').attr("disabled",true);
		$('#mobile').attr("disabled",true);
		$('#uname').attr("disabled",true);
		$('#password').attr("disabled",true);
				
		$('#btnsubmit').attr("disabled",true);
		$('#btncancel').attr("disabled",true);
	 }
</script>
</head>
<body onload="disable()">
<form autocomplete="off" id="rentalform">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">

<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		 <tr>
			<td style="font-size:80%">Name</td>
			<td height="30"><input type="text" id="name" name="name"></td>
		</tr> 
		<tr>
			<td style="font-size:80%">Email</td>
			<td height="30"><input type="email" id="email" name="email"></td>
		</tr>
		<tr>
			<td style="font-size:80%">Mobile</td>
			<td height="30"><input type="number" id="mobile" name="mobile"></td>
		</tr>
		<tr>
			<td style="font-size:80%">Username</td>
			<td height="30"><input type="text" id="uname" name="uname"></td>
		</tr>
		<tr>
			<td style="font-size:80%">Password</td>
			<td height="30"><input type="password" id="password" name="password"></td>
		</tr>
		
		<tr>
			<td colspan="2" align="center"><input type="button" id="btnedit" name="btnedit" value="Edit" class="myButton" onclick="funEditData()"></td>
		</tr>
		<tr align="center">
			<td><input type="button" id="btnsubmit" name="btnsubmit" value="Save" class="myButton" onclick="funSubmit()"></td>
			<td><input type="button" id="btncancel" name="btncancel" value="Cancel" class="myButton" onclick="funCancel()"></td>
		</tr>
		<tr>
			<td height="200"></td>
		</tr>	
	</table>
<td width="80%">
	<table width="100%">
	
		<tr>
			<td><div id="profilegrid"><jsp:include page="profileGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr><td><input type="hidden" id="sdocno" name="sdocno"></td></tr>
		<tr><td><input type="hidden" id="usdocno" name="usdocno"></td></tr>
	</table>
</td>
</tr>
</table>
</fieldset>
</div>
</div>
<div id="userDetailsToWindow">
 <div></div>
 </div>
</form>
</body>
</html>