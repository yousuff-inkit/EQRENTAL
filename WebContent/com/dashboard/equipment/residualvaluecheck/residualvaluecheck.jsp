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
<style type="text/css">
#btnvehreturn{
opacity:0;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	$("#excelExport").click(function() {
		 /* JSONToCSVConvertor(defleetexceldata, 'DeFleet List', true);
		 JSONToCSVCon(invoicedata, 'Rental Invoice', true); */
		//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
	}); 
	
	$('#fleetwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#fleetwindow').jqxWindow('close');
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");   
	 
	 $('#fleetno').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
 });
	 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
});
function funExportBtn(){
	JSONToCSVCon(defleetexceldata, 'Residual Value check', true);
}


function funreload(event)
{
	
	
	var fromdateval=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
	if(fromdateval==0){
		$('#fromdate').jqxDateTimeInput('focus');
		return false;
	}
	var todateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	if(todateval==0){
		$('#todate').jqxDateTimeInput('focus');
		return false;
	}
	var branch=$('#cmbbranch').val();
	var fromdate=$('#fromdate').val();
	var todate=$('#todate').val();
	var fleetno=$('#fleetno').val();
	$('#overlay,#PleaseWait').show();
	$("#residualdiv").load("residualvalueGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&fleetno="+fleetno+"&id=1");	
	
}
	function funNotify(){
	
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
		
	}
	function getfleetdata(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#fleetwindow').jqxWindow('open');


		  fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));     }
		 else{
			 }
		 }

	function fleetSearchContent(url) {
	 
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#fleetwindow').jqxWindow('open');
	 		$('#fleetwindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 
	function funclear(){
		document.getElementById("fleetno").value="";
		document.getElementById("resval").value="";
		document.getElementById("purcost").value="";
		$('#deFleetListGrid').jqxGrid('clear');
	}
	function funupadte()
	{

	  var fleetno=document.getElementById("fleetno").value;
	  
	  var resval=document.getElementById("resval").value;
	  var purcost=document.getElementById("purcost").value;
	  
	  savegriddata(fleetno,resval,purcost);
	
	}	
		


	function savegriddata(fleetno,resval,purcost)
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
				var items=x.responseText.trim();
			if(items=="0"){
				 document.getElementById("fleetno").value="";
				 document.getElementById("resval").value="";
				 document.getElementById("purcost").value="";
				 
				  
	              $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			 		   
			     });
			}
			else if(items=="-1"){
				$.messager.alert('Message', 'Vehicle Purchase Not Found', function(r){
			 		   
			     });
			     document.getElementById("fleetno").value="";
				 document.getElementById("resval").value="";
				 document.getElementById("purcost").value="";
			}
			else{
				$.messager.alert('Message', '  Record Not Updated ', function(r){
			 		   
			     });
			}
				 funreload(event); 
				 
				 disitems();
				 
				
				}
			
		}
			
	x.open("GET","save.jsp?fleet="+fleetno+"&resval="+resval+"&purcost="+purcost,true);

	x.send();
			
	}

	function funupadtecheck()
	  
	{

	  var fleetno=document.getElementById("fleetno").value;
	  
	  var resval=document.getElementById("resval").value;
	  var purcost=document.getElementById("purcost").value;
	  
	  savegriddatacheck(fleetno,resval,purcost);
	}	
		


	function savegriddatacheck(fleetno,resval,purcost)
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
				var items=x.responseText;
			if(items>=1){
			
				$('#btnupdate').hide();
				  
	            
			}
			else{
				$('#btnupdate').show();
			}
		
				 
				
				}
			
		}
			
	x.open("GET","savecheck.jsp?fleet="+fleetno+"&resval="+resval+"&purcost="+purcost,true);

	x.send();
			
	}
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmDeFleetVehicleList" action="saveDashboardVehicleReturn">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%">
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>	
									<tr><td width="34%" align="right"><label class="branch">From Date</label></td><td width="66%"><div id="fromdate"></div></td></tr>
									<tr><td width="34%" align="right"><label class="branch">To Date</label></td><td width="66%"><div id="todate"></div></td></tr>
									<tr><td width="34%" align="right"><label class="branch">Fleet No</label></td><td width="66%"><input type="text" id="fleetno" placeholder="Press F3 To Search" name="fleetno"  style="height:18px;" readonly onkeydown="getfleetdata(event);"></td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td width="34%" align="right"><label class="branch">Residual Value</label></td><td width="66%"><input type="text" id="resval" name="resval" style="height:18px;" ></td></tr>
									<tr><td width="34%" align="right"><label class="branch">Purchase Cost</label></td><td width="66%"><input type="text" id="purcost" name="purcost" style="height:18px;" ></td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2" align="center"></td></tr>
									<tr><td colspan="2" align="center"><button type="button" id="btnupdate" name="btnupdate" class="myButton" onclick="funupadte();">UPDATE</button>&nbsp;&nbsp;<button type="button" id="btnclear" name="btnclear" class="myButton" onclick="funclear();">CLEAR</button></td></tr>
									
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
								 	<tr><td colspan="2">&nbsp;<br><br></td></tr>
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%" border="0">
  								<tr>
    								<td><div id="residualdiv"><jsp:include page="residualvalueGrid.jsp"></jsp:include></div></td>
  								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div id="fleetwindow"><div></div>
</div>
		</div>
		<input type="hidden" name="invgridlength" id="invgridlength"  value='<s:property value="invgridlength"/>'>
		<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
		<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
	</form>
</body>
</html>