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
  background-color: #31b0d5;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	    $('#agmtsearchwindow').jqxWindow({ width: '62%', height: '55%',  maxHeight: '60%' ,maxWidth: '80%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#agmtsearchwindow').jqxWindow('close');
		
		$('#agmtno').dblclick(function(){
			$('#agmtsearchwindow').jqxWindow('open');
			$('#agmtsearchwindow').jqxWindow('focus');
	 		agmtSearchContent('masterAgmtSearch.jsp', $('#agmtsearchwindow'));
		});
	});
	
	function getAgmt(event){
		var x= event.keyCode;
		if(x==114){
			$('#agmtsearchwindow').jqxWindow('open');
			$('#agmtsearchwindow').jqxWindow('focus');
	 		agmtSearchContent('masterAgmtSearch.jsp', $('#agmtsearchwindow'));
	   }
	   else{
	   }
	}
	
	function agmtSearchContent(url) {
		$.get(url).done(function (data) {
	    	$('#agmtsearchwindow').jqxWindow('setContent', data);
		}); 
	}
	function funreload(event){
		var branch=document.getElementById("cmbbranch").value;
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
		var agmtno=document.getElementById("hidagmtno").value;
		$('#selectedagmtno,#selectedtotal,#deletedrows').val('');
		$("#overlay, #PleaseWait").show();
		$('#agmtdiv').load('agmtGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&agmtno='+agmtno+'&id=1');
	}
	
	function setValues(){
		
	}
	
	function funClearData(){
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     $('#selectedagmtno,#selectedtotal,#deletedrows').val('');
	     $('#agmtno,#hidagmtno').val('');
	}
	
	function funExportBtn(){
		if(parseInt(window.parent.chkexportdata.value)=="1") {
			JSONToCSVCon(data, 'Cancel Replacements', true);
		}else {
			 $("#repCancelGrid").jqxGrid('exportdata', 'xls', 'Cancel Replacements');
		}
	}
	
	function funSaveData(){
		var selectedrows=$('#agmtPaymentUpdateGrid').jqxGrid('getselectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select any valid documents');
			return false;
		}
		var currenttotal=parseFloat(($("#agmtPaymentUpdateGrid").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'])).sum);
		var total=parseFloat($('#selectedtotal').val());
		//alert(currenttotal+"//"+total);
		if(total!=currenttotal){
			$.messager.alert('Warning','Total not tally');
			return false;
		}
		else{
			var dataarray=new Array();
			for(var i=0;i<selectedrows.length;i++){
				var date=$('#agmtPaymentUpdateGrid').jqxGrid('getcelltext',selectedrows[i],'chequedate');
				var agmtno=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',selectedrows[i],'agmtno');
				var chequedate=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',selectedrows[i],'chequedate');
				var amount=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',selectedrows[i],'amount');
				var chequeno=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',selectedrows[i],'chequeno');
				var bpvno=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',selectedrows[i],'bpvno');
				var srno=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',selectedrows[i],'detaildocno');
				dataarray.push(agmtno+"::"+amount+"::"+chequeno+"::"+chequedate+"::"+bpvno+"::"+srno+"::"+date);
			}
			var deletedrows=$('#deletedrows').val();
			$.messager.confirm('Confirm', 'Do you want to save?', function(r){
 				if (r){
					saveDataAJAX(dataarray,deletedrows);
 				}
	 		});
		}	
		
	}
	function saveDataAJAX(dataarray,deletedrows){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = parseInt(x.responseText.trim());
				if(items==0){
					$.messager.alert('Message','Successfully Saved');
					funreload("");
				}
				else{
					$.messager.alert('Message','Not Saved');
				}
			}
			else {
			}
		}
		x.open("GET","saveDataAJAX.jsp?dataarray="+dataarray+"&deletedrows="+deletedrows+"&selectedagmtno="+$('#selectedagmtno').val(), true);
		x.send();
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
	
    <tr>
	 <td width="35%" align="right"><label class="branch">From</label></td>
     <td width="65%" align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr>
		<td align="right"><label class="branch">Agmt No</label></td>
		<td align="left">
			<input type="hidden" name="hidagmtno" id="hidagmtno" placeholder="Press F3 to Search" readonly style="height:18px;" onkeydown="getAgmt(event);">
			<input type="text" name="agmtno" id="agmtno" placeholder="Press F3 to Search" readonly style="height:18px;">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<hr>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="button" name="btnsave" id="btnsave" class="myButtons" onclick="funSaveData();">Save</button>&nbsp;&nbsp;
			<button type="button" name="btnclear" id="btnclear" class="myButtons" onclick="funClearData();">Clear</button>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<br><br><br><br><br><br><br><br><br><br><br><br><br>
		</td>
	</tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="agmtdiv"><jsp:include page="agmtGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr>
			 <td><div id="agmtpaymentdiv"><jsp:include page="agmtPaymentGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<input type="hidden" name="selectedagmtno" id="selectedagmtno">
<input type="hidden" name="selectedtotal" id="selectedtotal">
<input type="hidden" name="deletedrows" id="deletedrows">
<div id="agmtsearchwindow">
	<div></div>
</div>
</div> 
</body>
</html>