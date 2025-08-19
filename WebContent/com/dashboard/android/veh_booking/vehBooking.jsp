
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
		
	 $("#bookinggrid").load("bookingGrid.jsp?id=1");  
}
 
 function  funClearData(){
	 
	 $('#user').val('');
	 $('#sdocno').val('');
	 $('#usdocno').val('');
	  if (document.getElementById("user").value == "") {
	        $('#user').attr('placeholder', 'Press F3 to Search'); 
	    }
	  
	 
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
		var userdoc=document.getElementById("usdocno").value;
		//alert(userdoc);
		
		
			if(doc=="")
			{
			alert(" Please select the document ");
			return false;
			}
			/* if(userdoc=="")
			{
			alert(" Please select a user ");
			return false;
			} */
		 	var x=new XMLHttpRequest();
	        x.onreadystatechange=function()
	        {
	            
	           
	            if (x.readyState == 4 && x.status == 200)
	            {
	                
	               var msg=x.responseText.trim();
	                
	                
	                if(msg=="updated")
	                {
	                	funreload();
	                	funClearData();
	                	alert("Updated Successfully");
	                }
	                else
	                {
	                    
	                   alert("Not Updated");
	                }
	            }
	        

	        }
	    x.open("GET", "bookingStatus.jsp?doc="+doc+"&userdoc="+userdoc, true);
	    x.send();
		
		
	}
	 function getUserDetails(event){
	     var x= event.keyCode;
	     if(x==114){
	    	 userSearchContent("userSearch.jsp");
	     }
	     else{
	      }
	     }
	 function userSearchContent(url) {
	   $('#userDetailsToWindow').jqxWindow('open');
	  $.get(url).done(function (data) {
	   $('#userDetailsToWindow').jqxWindow('setContent', data);
	  }); 
	 }
</script>
</head>
<body>
<form autocomplete="off" id="rentalform">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">

<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		<!-- <tr>
			<td style="font-size:80%">User</td>
			<td height="30"><input type="text" id="user" name="user" placeholder="Press F3 to search" onkeydown="getUserDetails(event);"></td>
		</tr> -->
		<!-- <tr>
			<td style="font-size:80%">Status</td>
			<td height="30"><input type="text" id="status" name="status"></td>
		</tr>  -->
		
		<tr>
			<td colspan="2" align="center" ><input type="button" id="btnsubmit" name="btnsubmit" value="Submit" class="myButton" onclick="funSubmit()"></td>
		<!-- </tr>
		<tr> -->
			<!-- <td align="center"><input type="button" id="btnclear" name="btnclear" value="Clear" class="myButton" onclick="funClearData()"></td> -->
		</tr>
		<tr>
			<td height="400"></td>
		</tr>	
	</table>
<td width="80%">
	<table width="100%">
	
		<tr>
			<td><div id="bookinggrid"><jsp:include page="bookingGrid.jsp"></jsp:include></div></td>
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