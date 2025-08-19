
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<style type="text/css">
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	
	$('#loadsalikdata').hide();
	  $('#loadtrafficdata').hide();
	  
	 // $('#loadinvoicesalicgrid').hide();
	 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 
	 
	    
	  
});

 function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  }
	 	 
	   if (!(document.getElementById('radio_salik').checked || document.getElementById('radio_traffic').checked)) {
		   
		   $.messager.alert('Message','Select Salik / Traffic','warning');
		   return false;
	   }
	 	 
	   else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var satcateg;
	
	 if (document.getElementById('radio_salik').checked) {
			
		 satcateg=$("#radio_salik").val();
		 $("#overlay, #PleaseWait").show();
		 
		  $("#loadsalikdata").load("invoicesalicGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg);
		  
		}
	 else if (document.getElementById('radio_traffic').checked) {
			
		 satcateg=$("#radio_traffic").val();
		 
		 $("#overlay, #PleaseWait").show();
		 
		  $("#loadtrafficdata").load("invoicetrafficGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg);
		  
		}
	
	
		   }
	}
 

	 function load(){
		 $('#loadsalikdata').show();
		 
		 
	 }
function fundisable(){
	

	
	if (document.getElementById('radio_salik').checked) {
		
		  $('#loadsalikdata').show();
		  $('#loadtrafficdata').hide();
		  $('#loadinvoicesalicgrid').hide();
		  
		}
	 else if (document.getElementById('radio_traffic').checked) {
		 
		  $('#loadsalikdata').hide();
		  $('#loadtrafficdata').show();
		  $('#loadinvoicesalicgrid').hide();
		}
	 }
	

	 function funExportBtn(){
			if(document.getElementById("radio_salik").checked==true){
				
			 JSONToCSVCon(salicexcel, 'Staff Salik', true);
		}
			else if(document.getElementById("radio_traffic").checked==true){
				JSONToCSVCon(trafficexcel, 'Staff Traffic', true);
			}
		} 
</script>
</head>
<body onload="getBranch();load();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
   <tr><td colspan="2">&nbsp;</td></tr> 
	 	<tr ><td align="right" > <label class="branch">Salik</label></td> <td ><input type="radio" checked="checked" id="radio_salik" name="category" value="salik" onchange="fundisable();"> 
	 	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="branch">Traffic</label>
         <input type="radio" id="radio_traffic" name="category" value="radio_traffic" onchange="fundisable();">
         <%--  <button type="button" class="icon" style="align: right;" id="btnExcel" title="Export current Document to Excel" onclick="funExportDateWiseBtn();">
							<img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
						</button> --%>
         </td>
	 	</tr>
	 	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr><div id="loadsalikdata">
				<jsp:include page="invoicesalicGrid.jsp"></jsp:include> 
			</div></tr>
			
			<%-- <tr><div id="loadinvoicesalicgrid">
				 <jsp:include page="invoicedsalikGrid.jsp"></jsp:include> 
				</div></tr> --%>
		
<tr><div id="loadtrafficdata">
				 <jsp:include page="invoicetrafficGrid.jsp"></jsp:include> 
				</div></tr>
				
	</table>
</tr>
</table>

</div>
<div id="accountSearchwindow">
   <div ></div>
</div> 
</div>
</body>
</html>