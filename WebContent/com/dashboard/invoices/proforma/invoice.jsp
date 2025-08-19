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
	$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	document.getElementById("imgloading").style.display="none";
	/*var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			$('#periodupto').jqxDateTimeInput('val',items);
			
		} else {

		}
	}
	x.open("GET","getLastDay.jsp?date="+$('#periodupto').jqxDateTimeInput('val'), true);
	x.send();*/
	
	
	$('#periodupto').on('change', function (event) 
			{  
				var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
				if(docdateval==0){
					$('#periodupto').jqxDateTimeInput('focus');
					return false;
				}
/*
			    var jsDate = event.args.date; 
			    var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
			 	var date=$('#uptodate').jqxDateTimeInput('val');
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(items=="0"){
							$.messager.alert('Warning','Date should be month end');
							return false;
						}
						else{
							return true;
						}
					} else {

					}
				}
				x.open("GET","checkMonthEnd.jsp?date="+date, true);
				x.send();*/

			});
});

function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	}
$("#overlay, #PleaseWait").show(); 
					var branch=$('#cmbbranch').val();
					var uptodate=$('#periodupto').jqxDateTimeInput('val');
					$('#invoicediv').load('invoiceGrid.jsp?branch='+branch+'&uptodate='+uptodate+'&mode=1');
	/* $("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1"); 
	 var date=$('#periodupto').jqxDateTimeInput('val');
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items=="0"){
					$.messager.alert('Warning','Date should be month end');
					return false;
				}
				else{
					
				}
			} else {

			}
		}
		x.open("GET","checkMonthEnd.jsp?date="+date, true);
		x.send();*/
	}
function funCalculate(){
	/* $("#overlay, #PleaseWait").show(); */
	
	var selectedrows=$('#invoiceGrid').jqxGrid('selectedrowindexes');
	if(selectedrows.length==0){
		$.messager.alert('Warning','Please select agreements');
		return false;
	}
	var agmtarray=new Array();
	for(var i=0;i<selectedrows.length;i++){
		agmtarray.push($('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'agmtno'));
	}
	var branch=$('#cmbbranch').val();
	var uptodate=$('#periodupto').jqxDateTimeInput('val');
	$('#overlay,#PleaseWait').show();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items=JSON.parse(items);
			$.each(items.calcdata, function( index, value ) {
				for(var i=0;i<selectedrows.length;i++){
					if(value.agmtno==$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'agmtno')){
						var totalamt=parseFloat(value.rent)+parseFloat(value.insurchg)+parseFloat(value.accchg)+parseFloat(value.salikamt)+parseFloat(value.saliksrvc)+parseFloat(value.trafficamt)+parseFloat(value.trafficsrvc);
						totalamt=totalamt.toFixed(2);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'totalamt',totalamt);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'rentalamt',value.rent);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'accamt',value.accchg);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'insuramt',value.insurchg);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'salikamt',value.salikamt);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'trafficamt',value.trafficamt);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'saliksrvc',value.saliksrvc);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'trafficsrvc',value.trafficsrvc);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'salikcount',value.salikcount);
						$('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'trafficcount',value.trafficcount);
					}
				}
			});
			$('#overlay,#PleaseWait').hide();
		}
		else {
		}
	}
	x.open("GET","calculateAmount.jsp?agmtarray="+agmtarray+"&branch="+branch+"&uptodate="+uptodate, true);
	x.send();
}
	

	function funNotify(){
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var selectedrows=$('#invoiceGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select agreements');
			return false;
		}
		var testamt=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[0],'rentalamt');
		if(testamt=="" || testamt=="undefined" || testamt==null || typeof(testamt)=="undefined"){
			$.messager.alert('Warning','Please Calculate');
			return false;
		}
		var agmtarray=new Array();
		for(var i=0;i<selectedrows.length;i++){
			var agmtno=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'agmtno');
			var totalamt=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'totalamt');
			var rentalamt=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'rentalamt');
			var accamt=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'accamt');
			var insuramt=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'insuramt');
			var salikamt=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'salikamt');
			var saliksrvc=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'saliksrvc');
			var salikcount=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'salikcount');
			var trafficamt=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'trafficamt');
			var trafficsrvc=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'trafficsrvc');
			var trafficcount=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'trafficcount');
			var fromdate=$('#invoiceGrid').jqxGrid('getcelltext',selectedrows[i],'fromdate');
			var todate=$('#invoiceGrid').jqxGrid('getcelltext',selectedrows[i],'todate');
			var agmtvocno=$('#invoiceGrid').jqxGrid('getcelltext',selectedrows[i],'agmtvocno');
			var datediff=$('#invoiceGrid').jqxGrid('getcelltext',selectedrows[i],'datediff');
			agmtarray.push(agmtno+"::"+totalamt+"::"+rentalamt+"::"+accamt+"::"+insuramt+"::"+salikamt+"::"+saliksrvc+"::"+salikcount+"::"+trafficamt+"::"+trafficsrvc+"::"+trafficcount+"::"+datediff);
		}
		
		var branch=$('#cmbbranch').val();
		var uptodate=$('#periodupto').jqxDateTimeInput('val');
		$('#overlay,#PleaseWait').show();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				items=JSON.parse(items);
				if(items.errorstatus=="1"){
					$.messager.alert('Message',items.errormsg);
					$('#invoiceGrid').jqxGrid('clear');
				}
				else{
					$.messager.alert('Warning',items.errormsg);
				}
				$('#overlay,#PleaseWait').hide();
			}
			else {
			}
		}
		x.open("GET","createProforma.jsp?agmtarray="+agmtarray+"&branch="+branch+"&uptodate="+uptodate, true);
		x.send();
		
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
	}
	function funExportBtn(){

/* 			 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(invoicedata, 'Rental Invoice', true);
		  }
		 else
		  {
			 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
		  }

		 */
		
	}
	
		
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmProforma" action="saveProforma" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
	<tr>
		<td width="20%">
    		<fieldset style="background: #ECF8E0;">
				<table width="100%">
					<jsp:include page="../../heading.jsp"></jsp:include>
					<tr><td width="40%" align="right"><label class="branch">Period Upto</label></td><td width="60%"><div id="periodupto" name="periodupto"></div></td></tr>
					<tr>
						<td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
					</tr>
					<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>	
				</table>
			</fieldset>
		</td>
		<td width="80%">
			<table width="100%">
				<tr>
			 		<td>
			 			<div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
							<img id="imgloading" alt="" src="../../../../icons/29load.gif"/>
						</div>
						<div id="invoicediv">
							<jsp:include page="invoiceGrid.jsp"></jsp:include>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</div>
<input type="hidden" name="invgridlength" id="invgridlength" >
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</form>
</body>
</html>