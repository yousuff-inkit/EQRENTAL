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
	 $('#clientwindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '50%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	 $('#agmtwindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '50%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#agmtwindow').jqxWindow('close');
	 $('#rdodocdate').attr('checked',true);
	 $('#datetype').val('1');
	 $('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('masterClientSearch.jsp?id=1', $('#clientwindow'));
	});
	$('#agmtno').dblclick(function(){
		$('#agmtwindow').jqxWindow('open');
		$('#agmtwindow').jqxWindow('focus');
		agmtSearchContent('masterAgmtSearch.jsp?id=1', $('#agmtwindow'));
	});
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
});
function getClient(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('masterClientSearch.jsp?id=1', $('#clientwindow'));
   	}
   	else{
    }
}

function getAgmt(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#agmtwindow').jqxWindow('open');
		$('#agmtwindow').jqxWindow('focus');
		agmtSearchContent('masterAgmtSearch.jsp?id=1', $('#agmtwindow'));
   	}
   	else{
    }
}
function clientSearchContent(url) {
	$.get(url).done(function (data) {
   		$('#clientwindow').jqxWindow('setContent', data);
	}); 
}
function agmtSearchContent(url) {
	$.get(url).done(function (data) {
   		$('#agmtwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	if($('#cmbbranch').val()=="" || $('#cmbbranch').val()=="a"){
		$.messager.alert('warning','Please select a branch');
		return false;
	}
	/* var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	}*/
	var branch=$('#cmbbranch').val();
	var fromdate=$('#fromdate').val();
	var todate=$('#todate').val();
	var cldocno=$('#hidclient').val();
	var agmtno=$('#hidagmtno').val();
	var datetype=$('#datetype').val();
	$('#overlay,#PleaseWait').show();
	$("#agmtdiv").load("agmtGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+cldocno+"&agmtno="+agmtno+"&id=1&datetype="+datetype);	
	
}
	function funNotify(){
	
	}
	function setValues(){
		if($('#msg').val()!=""){
 			$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
 		}
	}
	function funExportBtn(){
		
	}
	
	function funTarifChange(){
		if(document.getElementById("agmtdocno").value==""){
			$.messager.alert('warning','Please select an agreement');
			return false;
		}
		
		$.messager.confirm('Confirm', 'Are you Sure?', function(r){
			if (r){
				tarifChangeAJAX();
			}
	 		});
	}

	function tarifChangeAJAX(){
		var arr=new Array();
		var rows=$('#tarifChangeGrid').jqxGrid('getrows');
		for(var i=0;i<rows.length;i++){
			arr.push(rows[i].rate+" :: "+rows[i].cdw+" :: "
					   +rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "
					   +rows[i].exkmrte+" :: "+rows[i].chaufchg+" :: "+rows[i].chaufexchg+" :: "+rows[i].totalcostpermonth+" :: "+rows[i].drivercostpermonth+" :: "+rows[i].securitypass+" :: "+rows[i].fuel+" :: "+rows[i].salik+" :: "+rows[i].safetyacc+" :: "+rows[i].diw+" :: "+rows[i].hpd+" :: "+rows[i].rateperexhr+" :: ");
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items= x.responseText;
				if(items.trim()=="0")
				{
					$.messager.alert('Message','Updated Successfully');
					funClearData();
					funreload(1);
				}
				else
				{
					$.messager.alert('Message','Not Updated');
				}
		}
		else
		{
			   
		}
		}
		x.open("GET", "tarifChangeAJAX.jsp?agmtdocno="+$("#agmtdocno").val()+"&tarifarray="+arr, true);
		x.send();
	}
	
	function funExportBtn(){
			
	}
	
	function setDateType(){
		if($('#rdodocdate').attr('checked')==true){
			$('#datetype').val('1');
		}
		else if($('#rdooutdate').attr('checked')==true){
			$('#datetype').val('2');
		}
	}
	
	function funClearData(){
		$('#rdodocdate').attr('checked',true);
		$('#datetype').val('1');
		//$('#cmbbranch').val('a');
		//$("#cmbbranch").val($("#cmbbranch option:first").val());
		$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1));
		$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
		$('#hidagmtno,#agmtno,#client,#hidclient,#agmtdocno').val('');
		$('#tarifChangeGrid,#agmtGrid').jqxGrid('clear');
	}
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmDashboardVehicleReturn" action="saveDashboardVehicleReturn">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%">
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>	
										<tr>
											<td colspan="2" align="center">
												<input type="radio" name="rdodate" id="rdodocdate" onchange="setDateType();"> <label class="branch" for="rdodocdate">Doc Date</label>&nbsp;&nbsp;
												<input type="radio" name="rdodate" id="rdooutdate" onchange="setDateType();"> <label class="branch" for="rdooutdate">Out Date</label>
											</td>
										</tr>
										<tr>
											<td width="34%" align="right">
												<label class="branch">From Date</label>
											</td>
											<td width="66%">
												<div id="fromdate"></div>
											</td>
										</tr>
		 								<tr>
		 									<td width="34%" align="right">
		 										<label class="branch">To Date</label>
		 									</td>
         									<td width="66%">
         										<div id="todate"></div>
                							</td>
                						</tr> 
        								<tr>
	  										<td align="right">
	  											<label class="branch">Client</label>
	  										</td>
	  										<td align="left">
	  											<input type="text" id="client" name="client"  style="height:18px;" readonly placeholder="Press F3 to Search" onkeydown="getClient(event);">
	  											<input type="hidden" id="hidclient" name="hidclient"  style="height:18px;">
	  										</td>
	  									</tr>
	  									<tr>
	  										<td align="right">
	  											<label class="branch">Agreement</label>
	  										</td>
	  										<td align="left">
	  											<input type="text" id="agmtno" name="agmtno"  style="height:18px;" readonly placeholder="Press F3 to Search" onkeydown="getAgmt(event);">
	  											<input type="hidden" id="hidagmtno" name="hidagmtno"  style="height:18px;">
	  										</td>
	  									</tr>
	  									<tr>
											<td colspan="2" align="center">
												<hr>
											</td>
										</tr>
										<tr>
											<td colspan="2" align="center">
												<input type="button" name="btnclear" id="btnclear" class="myButton" value="Clear" onclick="funClearData();">&nbsp;&nbsp;
												<input type="button" name="btnchange" id="btnchange" class="myButton" value="Change Tariff" onclick="funTarifChange();">
											</td>
										</tr>
										<tr>
											<td colspan="2"><br><br><br><br><br><br><br><br></td>
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
    									<td><div id="tarifchangediv"><jsp:include page="tarifChangeGrid.jsp"></jsp:include></div></td>
  									</tr>
								</table>
							</td>
						</tr>
					</table>
			  		<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  		<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  		<input type="hidden" name="agmtdocno" id="agmtdocno" value='<s:property value="agmtdocno"/>'>
			  		<input type="hidden" name="datetype" id="datetype" value='<s:property value="datetype"/>'>
					</div>
					<div id="clientwindow">
						<div><img id="loadingImage1" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;" /></div>
					</div>
					<div id="agmtwindow">
						<div><img id="loadingImage2" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;" /></div>
					</div>
				</div>
			</form>
		</body>
</html>