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
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	document.getElementById("imgloading").style.display="none";
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
});

function funreload(event)
{
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	$('#overlay,#PleaseWait').show();
	$('#summarydiv').load('summaryGrid.jsp?check=1&fromdate='+fromdate+'&todate='+todate);
}
function funCalculate(){

}
	

function funNotify(){
	
}
function setValues(){

}

function funBusinessDailyReport(){
		 fromdate=$("#fromdate").val();
		 todate=$("#todate").val();
		 //alert(fromdate+"====="+todate);
	        var url=document.URL;
	        var reurl=url.split("businessDailyReport.jsp");
	       
	        var win= window.open(reurl[0]+"printbusinessdailyreport?fromDate="+fromdate+"&desc="+$("#hiddesc").val()+"&brch="+$("#hidbrch").val()+"&toDate="+todate+"&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	   
	   }

function funExportBtn(){
	JSONToCSVCon(data222, 'Buisness Daily Report', true);
	JSONToCSVCon(data333, 'Buisness Daily Report', true);
}
	
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmVehicleStatusSummary" action="saveVehicleStatusSummary" method="post">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%">
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
									<tr><td width="30%" align="right"><label class="branch">From Date</label></td><td width="70%"><div id="fromdate"></div></td></tr>
									<tr><td  align="right"><label class="branch">To Date</label></td><td><div id="todate"></div></td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnprint" name="btnprint" onclick="funBusinessDailyReport();">Print</button></td></tr>
									<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>	
									
								   
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr>
			 						<td>
			 							<div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
											<img id="imgloading" alt="" src="../../../../icons/31load.gif"/>
										</div>
										<div id="summarydiv"><jsp:include page="summaryGrid.jsp"></jsp:include></div>
										<div id="detailsdiv" style="margin-top:5px;"><jsp:include page="detailsGrid.jsp"></jsp:include></div>
									<input type="hidden" name="gridlength" id="gridlength" >
									<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
									<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
									<input type="hidden" name="hiddesc" id="hiddesc" value='<s:property value="hiddesc"/>'>
									<input type="hidden" name="hidbrch" id="hidbrch" value='<s:property value="hidbrch"/>'>
									</td>
			 					
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>
</body>
</html>