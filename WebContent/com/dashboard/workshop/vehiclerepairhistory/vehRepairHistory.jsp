<link href="../../../../css/css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <script type="text/javascript" src="../../js/dashboard.js"></script>  --%>
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
 
select{
    height:18px;
}
 .redClass
        {
            background-color: #FFEBEB;
        }
 .violetClass
        {
            background-color: #EBD6FF;
        }
	  
</style>

<script type="text/javascript">

$(document).ready(function () {
	
		$("body").prepend('<div id="overlays" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWaits' style='display: none;position:absolute; z-index: 1;top:150px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	    
	    $("body").prepend('<div id="overlaym" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWaitm' style='display: none;position:absolute; z-index: 1;top:400px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	// $("#podate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 $('#flnames').dblclick(function(){
		 vehicleSearchContent("vehicleSearch.jsp");

		});
	 $('#vehicleToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Equipment Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#vehicleToWindow').jqxWindow('close');
	 
	 
	 $('#client').dblclick(function(){
		 clientSearchContent("clientSearch.jsp");
		});
	 $('#clientToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientToWindow').jqxWindow('close');
	 
	 
});



function funreload(event)
{	
	if($('#fldocno').val()!="" || $('#cldocno').val()!=""){
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
	var docnos=$('#fldocno').val();
	var cldocno=$('#cldocno').val();
	/* alert(aprv); */
     $("#overlays, #PleaseWaits").show(); 
    $("#vehsparediv").load("spareGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&docno="+docnos+"&cldocno="+cldocno+"&id=1"); 
    
    $("#overlaym, #PleaseWaitm").show(); 
    $("#vehmaintenancediv").load("maintenanceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&docno="+docnos+"&cldocno="+cldocno+"&id=1");
	}else{
		$.messager.alert('Message','Client/Equipment is mandatory');
	}   	
}
	
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
		var fleetname=$('#flnames').val();
		
		JSONToCSVCon(spareexceldata, 'Spare Details of '+fleetname+' on '+fromdate+' to '+todate, true);
		JSONToCSVCon(maintenanceexceldata, 'Maintenance Details of '+fleetname+' on '+fromdate+' to '+todate, true);
	}
	
	function funPrintData() {
    	
		
    	}
	function funNotify(){

		return 1;
	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	    disablegrid();
	}
	
	function getVehicleDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	    	vehicleSearchContent("vehicleSearch.jsp");
	    }
	    else{
	     }
	    }
	function vehicleSearchContent(url) {
	 	$('#vehicleToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#vehicleToWindow').jqxWindow('setContent', data);
		}); 
	}
	
	function getClientDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	    	vehicleSearchContent("clientSearch.jsp");
	    }
	    else{
	     }
	    }
	function clientSearchContent(url) {
	 	$('#clientToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#clientToWindow').jqxWindow('setContent', data);
		}); 
	}
function disablegrid(){
		
		$("#vehrepairGrid").jqxGrid('clear');
		 $("#vehrepairGrid").jqxGrid({ disabled: true});
		 $("#maintenanceGrid").jqxGrid('clear');
		 $("#maintenanceGrid").jqxGrid({ disabled: true});
	}
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmWorkQuotationApproval" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
	<tr>
	<td width="23%" align="center">
	    <fieldset style="background: #ECF8E0;">
		<table width="100%">
		<jsp:include page="../../heading.jsp"></jsp:include>
	
	 <tr>
	   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
	 <tr>
	   <td align="right"><label class="branch">To Date</label></td>
	   <td><div id="todate"></div></td>
	 </tr>
	 <tr>
		<td align="right"><label class="branch">Equipment</label></td>
		<td>
			<input type="text" name="flnames" id="flnames" style="height:18px; margine:1px;" placeholder="Press F3 to Search" onkeydown="getVehicleDetails(event)">
			<input type="hidden" name="fldocno" id="fldocno">
		</td>
	</tr>
	<tr>
		<td align="right"><label class="branch">Client</label></td>
		<td>
			<input type="text" name="client" id="client" style="height:18px; margine:1px;" placeholder="Press F3 to Search" onkeydown="getClientDetails(event)">
			<input type="hidden" name="cldocno" id="cldocno">
		</td>
	</tr>
	
	 <tr >
		<td colspan="2" style="border-top:2px solid #DCDDDE;">
			<div style="text-align:center;">
			<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;&nbsp;
			</div>
	    </td>
	</tr>
	<tr ><td><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> </td></tr>	
	</table>
</fieldset>
</td>
<td width="77%">
			 
			 	 
			 <fieldset class="violetClass">
				<legend>Spare Details </legend>
				    <table width="100%" border="0">
					  <tr>
				   		<td><div id="vehsparediv"><jsp:include page="spareGrid.jsp"></jsp:include></div></td>
				   	  </tr>
					</table>
				</fieldset>
				
				<fieldset class="redClass">
				<legend>Maintenance Details </legend>
				    <table width="100%" border="0">
					  <tr>
				   		<td><div id="vehmaintenancediv"><jsp:include page="maintenanceGrid.jsp"></jsp:include></div></td>
				   	  </tr>
					</table>
				</fieldset>	 
			 	 
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
		
	</td>		
</tr>
</table>
</div>

</div>
</form>
<div id="vehicleToWindow">
	<div></div>
	</div>
<div id="clientToWindow">
	<div></div>
	</div>
</body>
</html>