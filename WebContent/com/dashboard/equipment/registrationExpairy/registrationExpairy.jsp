
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

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
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#regexpdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	$('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close'); 
	$('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
	 	clientSearchContent('clientMasterSearch.jsp', $('#clientwindow'));
	});
});

function getClient(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('focus');
 		clientSearchContent('clientMasterSearch.jsp', $('#clientwindow'));
   }
   else{
   }
}
function clientSearchContent(url) {
	$.get(url).done(function (data) {
   		$('#clientwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var exdate = $('#regexpdate').val();
	 var fromdate = $('#fromdate').jqxDateTimeInput('val');
	 var cldocno=$('#cldocno').val();
	 $("#overlay, #PleaseWait").show(); 
	 $("#explistdiv").load("registrationExpairyGrid.jsp?barchval="+barchval+'&exdate='+exdate+'&fromdate='+fromdate+'&id=1&cldocno='+cldocno);
}
	
function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
		  
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}

function funExportBtn(){
	$("#clientwindow").excelexportjs({      
   		containerid: "clientwindow", 
   		datatype: 'json', 
   		dataset: null, 
   		gridId: "regexpgrid",            
   		columns: getColumns("regexpgrid") , 
   		worksheetName:"Registration Expiry"     
   		}); 
	   
	   
	   /*if(parseInt(window.parent.chkexportdata.value)=="1")
		 {
		 JSONToCSVCon(expdata, 'Registration Expiry', true);
		 }
	 else
		 {
		 $("#regexpgrid").jqxGrid('exportdata', 'xls', 'Registration Expiry');
		 }*/
		   
	   
	   
	   
	 }


</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
		<td align="right"><label class="branch">From</label></td>
        <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
	 </tr> 
	 <tr>
		<td align="right"><label class="branch">To</label></td>
        <td align="left"><div id="regexpdate" name="regexpdate" value='<s:property value="regexpdate"/>'></div></td>
	 </tr> 
	 <tr>
		<td align="right"><label class="branch">Client</label></td>
        <td align="left"><input type="text" name="client" id="client" placeholder="Press F3 to Search" onkeydown="getClient(event);"></td>
        <input type="hidden" name="cldocno" id="cldocno">
	 </tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='pieChart1' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="explistdiv"><jsp:include page="registrationExpairyGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<div id="clientwindow"><div></div></div>
</div>
</div>
</body>
</html>