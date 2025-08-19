<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
     var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
     $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	 
});

function funreload(event)
{
	var branch=document.getElementById("cmbbranch").value;
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	$('#overlay,#PleaseWait').show();
	$('#jobdetaillistdiv').load('jobDetailListGrid.jsp?branch='+branch+'&id=1&fromdate='+fromdate+'&todate='+todate);
}
function setValues(){

	 if($('#msg').val()!=""){
		 $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
		  }
	 
}
function funClearData(){
	$('#fromdate').jqxDateTimeInput('val',new Date());
	$('#todate').jqxDateTimeInput('val',new Date());
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	$('#jobDetailListGrid').jqxGrid('clear');
}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmLimoVehicleList" action="saveLimoVehicleList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" rowspan="2">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>


 <tr><td align="right"  width="30%"><label class="branch">From Date</label></td><td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr>
 <tr><td align="right"><label class="branch">To Date</label></td><td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr>
 <tr>
   <td align="center" colspan="2"><button id="btnclear" class="myButton" onclick="funClearData();" type="button">CLEAR</button></td>
 </tr>
 <tr>
   <td align="right" colspan="2">&nbsp;</td>
 </tr>
  <tr>
   <td align="right" colspan="2">&nbsp;</td>
 </tr>
  <tr>
   <td align="right" colspan="2">&nbsp;</td>
 </tr>
  <tr>
   <td align="right" colspan="2">&nbsp;</td>
 </tr>
 <tr>
   <td align="right" colspan="2">&nbsp;</td>
 </tr>
    <tr>
   <td colspan="2" align="center">&nbsp;</td>
   </tr>
   <tr>
   <td colspan="2" align="center">&nbsp;</td>
   </tr>
   <tr>
   <td colspan="2" align="center">&nbsp;</td>
   </tr>
   <tr>
   <td colspan="2" align="center"><br><br><br><br><br><br><br></td>
   </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td rowspan="2"><div id="jobdetaillistdiv"><jsp:include page="jobDetailListGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</div>
</form>
</body>
</html>