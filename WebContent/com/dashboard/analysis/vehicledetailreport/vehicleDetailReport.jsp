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
	var branch=$('#cmbbranch').val();
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	$('#countdiv').load('countGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&id=1');
	$('#masterdiv').load('masterGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&id=1');
}

function funExportBtn(){
	if(parseInt(window.parent.chkexportdata.value)=="1")
	{
		JSONToCSVCon(masterexceldata, 'Vehicle Detail Report', true);
	}
}

</script>
</head>
<body onload="getBranch();">
<form id="frmVehicleDetailReport" action="" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td align="right"><label class="branch">From </label></td><td><div id="fromdate"></div></td></tr>
<tr><td align="right"><label class="branch">To </label></td><td><div id="todate"></div></td></tr>

<tr>
	<td colspan="2"><div id="countdiv" ><jsp:include page="countGrid.jsp"></jsp:include></div></td>
</tr>
<%-- <tr>
	<td colspan="2"><div id="count2div" ><jsp:include page="chart.jsp"></jsp:include></div></td>
</tr> --%>
<tr><td colspan="2">&nbsp;<br><br><br><br><br><br><br></td></tr>	
</table>
</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="masterdiv"><jsp:include page="masterGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td></tr>
		<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
		<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		
	</table>
</tr>
</table>
</div>
</div>
</form>
</body>
</html>