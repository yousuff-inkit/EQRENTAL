
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />   
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#extendexpirydate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#issuedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#expirydate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#fleetwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	$('#fleetwindow').jqxWindow('close');
	$('#authoritywindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Authority Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	$('#authoritywindow').jqxWindow('close');
	$('#driverwindow').jqxWindow({ width: '60%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Driver Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	$('#driverwindow').jqxWindow('close');
	$('#vehicle').dblclick(function(){
		if($('#cmbtype').val()!="VEH"){
			$.messager.alert('Warning','Please select a valid type');
			return false;
		}
		else{
			$('#fleetwindow').jqxWindow('open');
			fleetSearchContent('fleetSearch.jsp?id=1', $('#fleetwindow')); 
    	}
    });
    $('#driver').dblclick(function(){
		if($('#cmbtype').val()!="DRV"){
			$.messager.alert('Warning','Please select a valid type');
			return false;
		}
		else{
			$('#driverwindow').jqxWindow('open');
			driverSearchContent('driverSearch.jsp?id=1', $('#driverwindow')); 
    	}
    });
    $('#authority').dblclick(function(){
		$('#authoritywindow').jqxWindow('open');
		authoritySearchContent('authoritySearch.jsp?id=1', $('#driverwindow')); 
    });
    
    funChangeDoc();
});
function fleetSearchContent(url) {
	$.get(url).done(function (data) {
		$('#fleetwindow').jqxWindow('open');
 		$('#fleetwindow').jqxWindow('setContent', data);
	}); 
}
function driverSearchContent(url) {
	$.get(url).done(function (data) {
		$('#driverwindow').jqxWindow('open');
 		$('#driverwindow').jqxWindow('setContent', data);
	}); 
}
function authoritySearchContent(url) {
	$.get(url).done(function (data) {
		$('#authoritywindow').jqxWindow('open');
 		$('#authoritywindow').jqxWindow('setContent', data);
	}); 
}

function getVehicle(event){
	var x= event.keyCode;
	if(x==114){
    	if($('#cmbtype').val()!="VEH"){
			$.messager.alert('Warning','Please select a valid type');
			return false;
		}
		else{
			$('#fleetwindow').jqxWindow('open');
			fleetSearchContent('fleetSearch.jsp?id=1', $('#fleetwindow')); 
    	}
    }
	else{
	}
}

function getDriver(event){
	var x= event.keyCode;
	if(x==114){
    	if($('#cmbtype').val()!="DRV"){
			$.messager.alert('Warning','Please select a valid type');
			return false;
		}
		else{
			$('#driverwindow').jqxWindow('open');
			driverSearchContent('driverSearch.jsp?id=1', $('#driverwindow')); 
    	}
    }
	else{
	}
}

function getAuthority(event){
	var x= event.keyCode;
	if(x==114){
		$('#authoritywindow').jqxWindow('open');
		authoritySearchContent('authoritySearch.jsp?id=1', $('#driverwindow')); 
    }
	else{
	}
}
function funreload(event)
{
	var documenttype=0;
	if(document.getElementById("rdonew").checked==true){
		documenttype=1;
	}
	else if(document.getElementById("rdoexpired").checked==true){
		documenttype=2;
	}
	var branch=$('#cmbbranch').val();
	var periodupto=$('#periodupto').jqxDateTimeInput('val');
	$('#overlay,#PleaseWait').show();
	$("#securitypassdiv").load("securityPassMgmtGrid.jsp?branch="+branch+"&id=1"+"&documenttype="+documenttype+"&periodupto="+periodupto);
	
}
	
function funClearData(){
	$('#securityPassMgmtGrid').jqxGrid('clear');
	$( ":input[type=text],:input[type=hidden]" ).val('');
	$('#cmbtype').val('');
	$('#issuedate,#expirydate,#periodupto,#extendexpirydate').jqxDateTimeInput('setDate',new Date());
	$('#cmbbranch').val('a');
	
}
function funChangeDoc(){
	if(document.getElementById("rdonew").checked==true){
		document.getElementById("fieldnewdoc").disabled=false;
		document.getElementById("fieldexpireddoc").disabled=true;
	}
	else if(document.getElementById("rdoexpired").checked==true){
		document.getElementById("fieldnewdoc").disabled=true;
		document.getElementById("fieldexpireddoc").disabled=false;
	}
	funClearData();
}

function funSaveData(){
	if($('#cmbbranch').val()=='' || $('#cmbbranch').val()=='a'){
		$.messager.alert('Warning','Please select a specific branch');
		return false;
	}
	if($('#authority').val()==''){
		$.messager.alert('Warning','Authority is mandatory');
		return false;
	}
	if($('#cmbtype').val()==''){
		$.messager.alert('Warning','Type is mandatory');
		return false;
	}
	if($('#cmbtype').val()!=''){
		if($('#cmbtype').val()=='VEH'){
			if($('#vehicle').val()==''){
				$.messager.alert('Warning','Vehicle is mandatory');
				return false;
			}
		}
		if($('#cmbtype').val()=='DRV'){
			if($('#driver').val()==''){
				$.messager.alert('Warning','Driver is mandatory');
				return false;
			}
		}
	}
	if($('#passno').val()==''){
		$.messager.alert('Warning','Pass No is mandatory');
		return false;
	}
	if($('#issuedate').jqxDateTimeInput('getDate')==null){
		$.messager.alert('Warning','Issue Date is mandatory');
		return false;
	}
	if($('#expirydate').jqxDateTimeInput('getDate')==null){
		$.messager.alert('Warning','Expiry Date is mandatory');
		return false;
	}
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
	    	if(r==false)
	     	{
	     		return false; 
	     	}
	     	else{
	     		$('#overlay,#PleaseWait').show();
	     		funSaveAJAX(1);
	     	}
		});
	
	
}

	function funDeleteData(){
	  var docno=$('#docno').val();
	    
	    $.messager.confirm('Message', 'Do you want to delete document?', function(r){
		    	if(r==false)
		     	{
		     		return false; 
		     	}
		     	else{
		     		$('#overlay,#PleaseWait').show();
		     		funDelete(docno);
		     	}
			});
	
	}

	function funDelete(docno){
	
	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				$('#overlay,#PleaseWait').hide();
				
				if(items>0){
					$.messager.alert('Warning','Record Successfully Deleted');
					funreload("");		
				}
				else{
					$.messager.alert('Warning','Not Deleted');
					
				}
			}
		}
		x.open("GET","saveData.jsp?docno="+docno,true);
		x.send();
	
	
	
	}
function funSaveAJAX(value){
	var authority=$('#hidauthority').val();
	var cmbtype=$('#cmbtype').val();
	var vehicle=$('#hidvehicle').val();
	var driver=$('#hiddriver').val();
	var drivertype=$('#hiddrivertype').val();
	var passno=$('#passno').val().replace(/ /g,"%20");
	var issuedate=$('#issuedate').jqxDateTimeInput('val');
	var expirydate=$('#expirydate').jqxDateTimeInput('val');
	var docno=$('#docno').val();
	var notes=$('#notes').val().replace(/ /g,"%20");
	var desc=$('#description').val().replace(/ /g,"%20");
	var extendexpirydate=$('#extendexpirydate').jqxDateTimeInput('val');
	var branch=$('#cmbbranch').val();
	if(docno!="" && value!="3"){
		value="2";
	}
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText.trim();
			$('#overlay,#PleaseWait').hide();
			if(items=="0"){
				$.messager.alert('Warning','Record Successfully Updated');
				funreload("");		
			}
			else{
				$.messager.alert('Warning','Not Updated');
				
			}
		}
	}
	x.open("GET","saveAJAX.jsp?documenttype="+value+"&authority="+authority+"&cmbtype="+cmbtype+"&vehicle="+vehicle+"&driver="+driver+"&passno="+passno+"&issuedate="+issuedate+"&expirydate="+expirydate+"&docno="+docno+"&notes="+notes+"&desc="+desc+"&extendexpirydate="+extendexpirydate+"&branch="+branch+"&hiddrivertype="+drivertype,true);
	x.send();
		
}

function funUpdate(){
	if($('#docno').val()==''){
		$.messager.alert('Warning','Please select a valid document');
		return false;
	}
	else if($('#expirydate').jqxDateTimeInput('getDate')==null){
		$.messager.alert('Warning','Please select extend expiry date');
		return false;
	}
	else{
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
	    	if(r==false)
	     	{
	     		return false; 
	     	}
	     	else{
	     		 funSaveAJAX(3);
	     	}
		});
	}
		
}
function funExportBtn(){
	JSONToCSVCon(secdataexcel, 'Security Pass Mgmt', true);
}

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
		<jsp:include page="../../heading.jsp"></jsp:include>
    	<tr><td colspan="2"><input type="radio" name="rdo"  checked="checked" id="rdonew" value="1" onchange="funChangeDoc();"><label class="branch">New Document</label>&nbsp;&nbsp;&nbsp;
    	<input type="radio" name="rdo" id="rdoexpired" value="2" onchange="funChangeDoc();"><label class="branch">Expired Document</label></td></tr>
	</table> 
	<fieldset id="fieldnewdoc" >
		<legend>Document Details</legend>
	  	<table width="100%">
      		<tr><td align="right"><label class="branch">Authority</label></td><td align="left"><input type="text" id="authority" style="height:20px;width:99%;" name="authority"  value='<s:property value="authority"/>' readonly placeholder="Press F3 to Search" onkeydown="getAuthority(event);"> </td>
      			<input type="hidden" id="hidauthority" style="height:20px;width:99%;" name="hidauthority"  value='<s:property value="hidauthority"/>'>
      		</tr>
      		<tr><td align="right"><label class="branch">Type</label></td><td align="left"><select name="cmbtype" id="cmbtype" style="height:20px;width:99%;"><option value="">--Select--</option><option value="VEH">Vehicle</option><option value="DRV">Driver</option></select></td></tr>
      		<tr><td  align="right" width="25%" ><label class="branch">Vehicle</label></td><td align="left"><input type="text" id="vehicle" style="height:20px;width:99%;" name="vehicle"  value='<s:property value="vehicle"/>' readonly placeholder="Press F3 to Search" onkeydown="getVehicle(event);"> </td>
      			<input type="hidden" id="hidvehicle" style="height:20px;width:99%;" name="hidvehicle"  value='<s:property value="hidvehicle"/>'>
      		</tr>
      		<tr><td  align="right" ><label class="branch">Driver</label></td><td align="left"><input type="text" id="driver" style="height:20px;width:99%;" name="driver"  value='<s:property value="driver"/>' readonly placeholder="Press F3 to Search" onkeydown="getDriver(event);"> </td>
      			<input type="hidden" id="hiddriver" style="height:20px;width:99%;" name="hiddriver"  value='<s:property value="hiddriver"/>'>
      			<input type="hidden" id="hiddrivertype" style="height:20px;width:99%;" name="hiddrivertype"  value='<s:property value="hiddrivertype"/>'>
      		</tr>
      		<tr><td align="right"><label class="branch">Pass No</label></td><td align="left"><input type="text" id="passno" style="height:20px;width:99%;" name="passno"  value='<s:property value="passno"/>'> </td></tr>
      		<tr><td align="right"><label class="branch">Description</label></td><td align="left"><input type="text" id="description" style="height:20px;width:99%;" name="description"  value='<s:property value="description"/>'> </td></tr>
	  		<tr><td align="right"><label class="branch">Issue Date</label></td><td align="left"><div id="issuedate" name="issuedate" value='<s:property value="issuedate"/>'></div></td></tr>
	  		<tr><td align="right"><label class="branch">Expiry Date</label></td><td align="left"><div id="expirydate" name="expirydate" value='<s:property value="expirydate"/>'></div></td></tr>
	  		<tr><td align="right"><label class="branch">Notes</label></td><td align="left"><input type="text" id="notes" name="notes" style="height:20px;width:99%;" value='<s:property value="passno"/>'></td></tr>
	  		<tr><td colspan="2"></td></tr> 
			<tr><td  align="center" colspan="2"><input type="Button" name="save" id="save" class="myButton" value="Save" onclick="funSaveData();"></td> </tr>
			<tr><td  align="center" colspan="2"><input type="Button" name="delete" id="delete" class="myButton" value="Delete" onclick="funDeleteData();"></td> </tr>
 		</table>
	</fieldset>
	<fieldset id="fieldexpireddoc">
		<legend>Extend Exp.Date</legend>
	  	<table width="100%" > 
	    	<tr><td align="left" ><label class="branch">Period Upto</label></td><td align="left"><div id='periodupto' name='periodupto' value='<s:property value="periodupto"/>'></div></td></tr>
	      	<tr><td align="left" ><label class="branch">Expiry Date</label></td><td align="left"><div id='extendexpirydate' name='extendexpirydate' value='<s:property value="extendexpirydate"/>'></div></td></tr>
 		  	<tr><td align="center" colspan="2"><input type="Button" name="update" id="update" class="myButton" value="Update Exp.Date" onclick="funUpdate();"></td> </tr> 
           	<tr><td>&nbsp;</td></tr>
 		</table>
	</fieldset>
	<input type="hidden" name="docno" id="docno" style="height:20px;width:70%;" value='<s:property value="docno"/>' >
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="securitypassdiv"><jsp:include page="securityPassMgmtGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>

</table>

</div>
</div>
<div id="fleetwindow"><div></div></div>
<div id="driverwindow"><div></div></div>
<div id="authoritywindow"><div></div></div>
</body>
</html>