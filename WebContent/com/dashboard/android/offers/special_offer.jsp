
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

$(document).ready(function ()
{
	
	document.getElementById("branchdiv").style.visibility="hidden";
	document.getElementById("branchlabel").style.visibility="hidden";
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
	var curtodate=$('#todate').jqxDateTimeInput('getDate');
	 var onemonthforwarddate=new Date(curtodate.setMonth(curtodate.getMonth()+1));
    $('#todate').jqxDateTimeInput('setDate', onemonthforwarddate) ; 
    
    
	  $('#name').dblclick(function(){
		  
	  	    $('#vehiclewindow').jqxWindow('open');
	   
	      vehSearchContent('vehiclesearch.jsp?', $('#vehiclewindow')); 
    });
    
    $('#vehiclewindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Vehicle Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	$('#vehiclewindow').jqxWindow('close');
    
});

 function funreload(event)
{
		
	 $("#offergrid").load("offerGrid.jsp?id=1"); 
}
 
 function  funClearData()
 {
	 
	
	 
 }

 function funExportBtn(){
	    

	  // JSONToCSVConvertor(checkinoutexcel, 'Check In-Out List', true);
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


	  function getVehInfo(event){
		  
		  //var doc=document.getElementById("sdocno").value;
		  //alert("name"+doc);
			 var x= event.keyCode;
			 if(x==114){
			 $('#vehiclewindow').jqxWindow('open');


			 vehSearchContent('vehiclesearch.jsp?doc='+doc, $('#vehiclewindow'));   
			 }
			 else{
				 }
			 } 
		function vehSearchContent(url) {
		 	 //alert(url);
		 		 $.get(url).done(function (data) {
		 			 
		 			 $('#vehiclewindow').jqxWindow('open');
		 		$('#vehiclewindow').jqxWindow('setContent', data);
		 
		 	}); 
		 	} 
	  
	  
	  
	function funSubmit()
	{
		//var from=document.getElementById("fromdate").value;
		//var tod=document.getElementById("todate").value;
		var from=$('#fromdate').jqxDateTimeInput('val');
		var to=$('#todate').jqxDateTimeInput('val');
		var vname=document.getElementById("name").value;
		var monthly=document.getElementById("monthly").value;
		var weekly=document.getElementById("weekly").value;
		var daily=document.getElementById("daily").value;
		var adult=document.getElementById("adult").value;
		var door=document.getElementById("door").value;
		var luggage=document.getElementById("luggage").value;
		var fuel=document.getElementById("fuel").value;
		var wheel=document.getElementById("wheel").value;
		
		var fromdate=new Date($("#fromdate").jqxDateTimeInput("getDate"));
		fromdate.setHours(0,0,0,0);
		var todate=new Date($("#todate").jqxDateTimeInput("getDate"));
		todate.setHours(0,0,0,0);
		//alert(fromdate);
		
		//alert("from:"+from+"::to::"+to);
		/* alert("from:"+from+"::to::"+to+"::"+vname+"::"+monthly+"::"+weekly+"::"+daily+"::"+adult+"::"+door+"::"+luggage+"::"+fuel+"::"+wheel); */
		if(from==""|| to==""||vname==""||monthly==""||weekly==""||daily==""||adult==""||door==""||luggage==""||fuel==""||wheel=="" )
		{
			$.messager.alert('Message','Please Enter all fields.','warning');
			return false;
		}
		 if(fromdate>=todate)
		{
			$.messager.alert('Message','To date is greater than from date.','warning');
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
	        		  //alert("Successfully Saved");
	        		  $.messager.alert('Message','Successfully Saved.','warning');
	        		  //location.reload();
	        		  funclearField();
	        		  funreload("");
	          	  }
	        	  else
	        	  {
	        		  //alert("Not Saved");
	        		  $.messager.alert('Message','Not Saved.','warning');
	        	  }
	          }
	      }

	     x.open("GET","offerInsertion.jsp?from="+from+"&to="+to+"&vname="+vname+"&monthly="+monthly+"&weekly="+weekly+"&daily="+daily+"&adult="+adult+"&door="+door+"&luggage="+luggage+"&fuel="+fuel+"&wheel="+wheel, true);
	     x.send();
		
	}
	function funclearField()
	{

		$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
		var curtodate=$('#todate').jqxDateTimeInput('getDate');
		 var onemonthforwarddate=new Date(curtodate.setMonth(curtodate.getMonth()+1));
	    $('#todate').jqxDateTimeInput('setDate', onemonthforwarddate) ; 
	    
	    
		document.getElementById("name").value="";
		document.getElementById("monthly").value="";
		document.getElementById("weekly").value="";
		document.getElementById("daily").value="";
		document.getElementById("adult").value="";
		document.getElementById("door").value="";
		document.getElementById("luggage").value="";
		document.getElementById("fuel").value="";
		document.getElementById("wheel").value="";
	}
	
	function funDeleteData()
	{
		var doc=document.getElementById("sdocno").value;
		if(doc=="")
		{
			alert(" Please select the document ");
			return false;
		}
		
		var x=new XMLHttpRequest();
	    x.onreadystatechange=function()
	    {
	          if (x.readyState == 4 && x.status == 200)
	          {
	        	  var msg=x.responseText.trim();
	        	  //alert(msg);
	                if(msg=="1")
	                {
	                	
	                	alert("Deleted Successfully");
	                	funclearField();
	                	funreload("");
	                }
	                else
	                {
	                    
	                   alert("Not Deleted");
	                }
	        	  
	          }
	      }

	     x.open("GET","deleteOffer.jsp?doc="+doc, true);
	     x.send();
		
		
		
	}
	
	function funUpdate()
	{
		var doc=document.getElementById("sdocno").value;
		var from=$('#fromdate').jqxDateTimeInput('val');
		var to=$('#todate').jqxDateTimeInput('val');
		var vname=document.getElementById("name").value;
		var monthly=document.getElementById("monthly").value;
		var weekly=document.getElementById("weekly").value;
		var daily=document.getElementById("daily").value;
		var adult=document.getElementById("adult").value;
		var door=document.getElementById("door").value;
		var luggage=document.getElementById("luggage").value;
		var fuel=document.getElementById("fuel").value;
		var wheel=document.getElementById("wheel").value;
		
		/* var fromdate=new Date($("#fromdate").jqxDateTimeInput("getDate"));
		fromdate.setHours(0,0,0,0);
		var todate=new Date($("#todate").jqxDateTimeInput("getDate"));
		todate.setHours(0,0,0,0); */
		//alert(doc);
		if(doc=="")
		{
			alert(" Please select the document ");
			return false;
		}
		var x=new XMLHttpRequest();
	    x.onreadystatechange=function()
	    {
	          if (x.readyState == 4 && x.status == 200)
	          {
	        	  var msg=x.responseText.trim();
	        	  //alert(msg);
	                if(msg=="1")
	                {
	                	
	                	alert("Updated Successfully");
	                	funclearField();
		        		  funreload("");
	                }
	                else
	                {
	                    
	                   alert("Not Updated");
	                }
	        	  
	          }
	      }

	     x.open("GET","updateOffer.jsp?doc="+doc+"&from="+from+"&to="+to+"&vname="+vname+"&monthly="+monthly+"&weekly="+weekly+"&daily="+daily+"&adult="+adult+"&door="+door+"&luggage="+luggage+"&fuel="+fuel+"&wheel="+wheel, true);
	     x.send();
		
	}
	
	 function getUserDetails(event)
	 {
	     
	 }
	 function userSearchContent(url) {
	   $('#userDetailsToWindow').jqxWindow('open');
	  $.get(url).done(function (data) {
	   $('#userDetailsToWindow').jqxWindow('setContent', data);
	  }); 
	 }
	 
	 function isNumber(evt,id) 
	 {
			//Function to restrict characters and enter number only
		 var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		 if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		 {
			      $.messager.alert('Warning','Enter Numbers Only');
			      $("#"+id+"").focus();
			      return false;
			          
	     }
			        
	     return true;
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
		
		<tr>
			<td align="right"><label class="branch">From</label></td>
     		<td align="left"><div id="fromdate" name="fromdate"></div></td></tr>
		</tr>
		<tr>
			<td align="right"><label class="branch">To</label></td>
     		<td align="left"><div id="todate" name="todate"></div></td></tr>
		</tr>
		<tr>
			<td align="right"><label class="branch" >Vehicle Name</label></td>
     		<td align="left" ><input type="text" id="name" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getVehInfo(event);" onclick="this.placeholder='' "></td>
		</tr>
		<tr>
			<td align="right"><label class="branch">Monthly AED</label></td>
     		<td align="left"><input type="text" id="monthly" onkeypress="javascript:return isNumber (event,id)"></td>
		</tr>
		<tr>
			<td align="right"><label class="branch">Weekly AED</label></td>
     		<td align="left"><input type="text" id="weekly" onkeypress="javascript:return isNumber (event,id)"></td>
		</tr>
		<tr>
			<td align="right"><label class="branch">Daily AED</label></td>
     		<td align="left"><input type="text" id="daily" onkeypress="javascript:return isNumber (event,id)"></td>
		</tr>
		<tr>
			<td align="right"><label class="branch">No. of Adult Passenger</label></td>
     		<td align="left"><input type="text" id="adult" onkeypress="javascript:return isNumber (event,id)"></td>
		</tr>
		<tr>
			<td align="right"><label class="branch">No. of Doors</label></td>
     		<td align="left"><input type="text" id="door" onkeypress="javascript:return isNumber (event,id)"></td>
		</tr>
		<tr>
			<td align="right"><label class="branch">No. of Luggage</label></td>
     		<td align="left"><input type="text" id="luggage" onkeypress="javascript:return isNumber (event,id)"></td>
		</tr>
		<tr>
			<td align="right"><label class="branch">Fuel Capacity</label></td>
     		<td align="left"><input type="text" id="fuel"></td>
		</tr>
		<tr>
			<td align="right"><label class="branch">Four Wheel drive</label></td>
			<td align="left">
				<select id="wheel">
				    <option value="1">Available</option>
				    <option value="0">Non-Available</option>	
				</select>
			</td>
     		<!-- <td align="left"><input type="text" id="wheel"></td> -->
		</tr>
		
		<tr>
			<td align="center" ><input type="button" id="btnsubmit" name="btnsubmit" value="Save" class="myButton" onclick="funSubmit()"></td>
		<!-- </tr>
		<tr> -->
			<td align="center"><input type="button" id="btnclear" name="btnclear" value="Clear" class="myButton" onclick="funDeleteData()"></td>
		</tr>
		<tr>
			<td colspan="2" align="center" style="padding-top:5px;"><input type="button" id="btnsubmit" name="btnsubmit" value="Update" class="myButton" onclick="funUpdate()"></td>
		</tr>
		<tr>
			<td height="100"></td>
		</tr>	
	</table>
<td width="80%">
	<table width="100%">
	
		<tr>
			<td><div id="offergrid"><jsp:include page="offerGrid.jsp"></jsp:include></div></td>
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
 <div id="vehiclewindow">
   <div ></div>
</div>
</form>
</body>
</html>