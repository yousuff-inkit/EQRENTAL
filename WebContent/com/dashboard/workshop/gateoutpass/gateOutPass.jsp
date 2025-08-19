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
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		  
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#gatewindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Gate In Pass Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#gatewindow').jqxWindow('close');
		
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#outdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	 $("#outtime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",value:new Date(),showCalendarButton:false});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#gateinpassdocno').dblclick(function(){
		    $('#gatewindow').jqxWindow('open');
			$('#gatewindow').jqxWindow('focus');
		 	searchContent('gateInPassSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')+'&branch='+$('#cmbbranch').val(), 'gatewindow');
		});
	 
});

function getGateInPass(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#gatewindow').jqxWindow('open');
		$('#gatewindow').jqxWindow('focus');
		searchContent('gateInPassSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')+'&branch='+$('#cmbbranch').val(), 'gatewindow');
   }
   else{
   }
}

function searchContent(url,windowid) {
	$.get(url).done(function (data) {
		$('#'+windowid).jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	
	if($('#cmbbranch').val()=='a'){
		$.messager.alert('Warning','Please Select a specific branch');
		return false;
	}
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
	var gatedocno=$('#gateinpassdocno').val();
	var branch=$('#cmbbranch').val();
    $("#overlay, #PleaseWait").show();
   	$("#gateoutpassdiv").load("gateOutPassGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&gatedocno="+gatedocno+"&branch="+branch);
   	setClientInvoice();
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   		$.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
		
		JSONToCSVCon(gateexceldata, 'Gate Out Pass Report of '+fromdate+' to '+todate, true);
		 }
	
		
	
	function funClearData(){
	
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	    $('#gatedocno').val('');
	    $('#gateinpassdocno,#remarks').val('');
	    
	}
	
	function funNotify(){
		if($('#cmbbranch').val()=='a'){
			$.messager.alert('Warning','Please Select a specific branch');
			return false;
		}
		if($('#gatedocno').val()==''){
			$.messager.alert('Warning','Please Select Valid Document');
			return false;
		}
		if($('#outdate').jqxDateTimeInput('getDate')==null){
			$.messager.alert('Warning','Out Date is Mandatory');
			return false;
		}
		if($('#outtime').jqxDateTimeInput('getDate')==null){
			$.messager.alert('Warning','Out Time is Mandatory');
			return false;
		}
		$.messager.confirm('Confirm', 'Do you want to update changes?', function(r){
			if (r){
				funSaveAJAX();
			}
		});
	}
	
	function funSaveAJAX(){
		var remarks=$('#remarks').val();
		remarks=remarks.trim();
		remarks=remarks.replace(/\n/g, " ");
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
				if(parseInt(items)>0){
					$.messager.alert('Message','Successfully Updated');
					$.messager.confirm('Confirm', 'Do you want to print document?', function(r){
						if (r){
							funPrint();
						}
						else
							{
							funClearData();
							}
					});
					
					
					$("#gateoutpassdiv").load("gateOutPassGrid.jsp?fromdate="+$('#fromdate').jqxDateTimeInput('val')+"&todate="+$('#todate').jqxDateTimeInput('val')+"&id=1&branch="+$('#cmbbranch').val());	
				}
				else{
					$.messager.alert('Message','Not Updated');
				}
				
			} else {
			}
		}
		x.open("GET", "updateGateOutPass.jsp?gatedocno="+$('#gatedocno').val()+"&outdate="+$('#outdate').jqxDateTimeInput('val')+"&outtime="+$('#outtime').jqxDateTimeInput('val')+"&amount="+$('#amount').val()+"&clientinvoice="+$('#hidchkclientinvoice').val()+"&remarks="+remarks+"&branch="+$("#cmbbranch").val(), true);
		x.send();
	}
	
	function setClientInvoice(){
		if(document.getElementById("chkclientinvoice").checked==true){
			document.getElementById("hidchkclientinvoice").value="1";
		}
		else{
			document.getElementById("hidchkclientinvoice").value="0";
		}
	}
	
	function funPrint(){
		  
		  var dtype='BGOP';
		  var url=document.URL;
		  var reurl=url.split("gateoutpass");
	      var brhid=<%= session.getAttribute("BRANCHID").toString()%>
	      var win= window.open(reurl[0]+"gateoutpassprint?docno="+document.getElementById("gatedocno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	      win.focus();
	  }
	
	
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmReplaceList" method="post" action="saveGateoutpass">
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
   <td align="right"><label class="branch">Gate In Pass Doc No</label></td>
   <td><input type="text" name="gateinpassdocno" id="gateinpassdocno" placeholder="Press F3 to Search" style="height:18px;" onkeydown="getGateInPass(event);"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Out Date</label></td>
   <td><div id="outdate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Out Time</label></td>
   <td><div id="outtime"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Amount</label></td>
   <td><input type="text" name="amount" id="amount" style="text-align:right;height:18px;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
 </tr>
<tr>
   <td align="right"><label class="branch">Remarks</label></td>
   <td><textarea id="remarks" name="remarks" readonly style="resize:none;" rows="10"></textarea></td>
 </tr>
 <tr><td colspan="2" align="center"><input type="checkbox" name="chkclientinvoice" id="chkclientinvoice" onchange="setClientInvoice();">&nbsp;<label class="branch">Client Invoice</label></td></tr>
 <tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;&nbsp;
	<input type="button" name="btnsave" id="btnsave" value="Save" class="myButtons" onclick="funNotify();">
	</div>
    </td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td colspan="2" align="center"><button class="myButton" type="button" id="btnprint" name="btnprint" onclick="funPrint();" > Print </button></td> -->
<!-- 		</tr> -->
<tr><td><br><br>
<br></td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%" >
		<tr>
			 <td><div id="gateoutpassdiv"><jsp:include page="gateOutPassGrid.jsp"></jsp:include></div></td>
			 		</tr>
	</table>
	 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="gatedocno" id="gatedocno" value='<s:property value="gatedocno"/>'>
				<input type="hidden" name="hidchkclientinvoice" id="hidchkclientinvoice" value='<s:property value="hidchkclientinvoice"/>'>
	
</tr>
</table>
</div>
<div id="gatewindow">
	<div></div>
</div>
</div>
</form>
</body>
</html>