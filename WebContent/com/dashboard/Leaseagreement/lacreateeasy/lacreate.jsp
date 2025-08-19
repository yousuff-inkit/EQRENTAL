
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
	
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#timeout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",showCalendarButton:false});
	 $('#clientwindow').jqxWindow({ width: '65%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	 $('#fleetwindow').jqxWindow({ width: '65%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#fleetwindow').jqxWindow('close');
	 $('#deldriverwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Delivery Driver Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#deldriverwindow').jqxWindow('close');
	 $('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#driverinfowindow').jqxWindow('close'); 
	$('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#nationalityWindow').jqxWindow('close');
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	funChangeChkDelivery();
	funChangeChkAdvance();
		   
	 $('#clientname').dblclick(function(){
	 	$('#clientwindow').jqxWindow('open');
	   	clientSearchContent('clientSearchMaster.jsp?', $('#clientwindow')); 
     });
	   
	/* $('#fleetno').dblclick(function(){
	 	$('#fleetwindow').jqxWindow('open');
		fleetSearchContent('fleetSearchMaster.jsp?', $('#fleetwindow')); 
     });
	*/
	$('#deldriver').dblclick(function(){
	 	$('#deldriverwindow').jqxWindow('open');
		deldriverSearchContent('deldriverGrid.jsp?', $('#deldriverwindow')); 
     });
});
function nationalitySearchContent(url) {
		 	$('#nationalityWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#nationalityWindow').jqxWindow('setContent', data);
			$('#nationalityWindow').jqxWindow('bringToFront');
		}); 
		}
function driverinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#driverinfowindow').jqxWindow('open');
     		$('#driverinfowindow').jqxWindow('setContent', data);
     
     	}); 
     	}
function funChangeChkAdvance(){
	if(document.getElementById("chkadvance").checked==true){
		$('#hidchkadvance').val('1');
	}
	else{
		$('#hidchkadvance').val('0');
	}
		
}

function funChangeChkDelivery(){
	if(document.getElementById("chkdelivery").checked==true){
		$('#hidchkdelivery').val('1');
		$('#deldriver,#delcharges').attr('disabled',false);
	}
	else{
		$('#hidchkdelivery').val('0');
		$('#deldriver,#delcharges').attr('disabled',true);
	}
		
}
function funExportBtn(){
	
	 //JSONToCSVCon(dataildata, 'LA Due Date', true);
	   //$("#detailsgrid").jqxGrid('exportdata', 'xls', 'Lease List');
	 }

 
function getFleet(event){
	var x= event.keyCode;
	if(x==114){
		$('#fleetwindow').jqxWindow('open');
		fleetSearchContent('fleetSearchMaster.jsp?', $('#fleetwindow'));     }
	else{
	}
}
function fleetSearchContent(url) {
	$.get(url).done(function (data) {
		$('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);
	});
} 

function deldriverSearchContent(url) {
	$.get(url).done(function (data) {
		$('#deldriverwindow').jqxWindow('open');
		$('#deldriverwindow').jqxWindow('setContent', data);
	});
}
function getClient(event){
	var x= event.keyCode;
	if(x==114){
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientSearchMaster.jsp?', $('#clientwindow'));    }
	else{
	}
} 
function getDelDriver(event){
	var x= event.keyCode;
	if(x==114){
		$('#deldriverwindow').jqxWindow('open');
		deldriverSearchContent('deldriverGrid.jsp?', $('#deldriverwindow'));
	}
	else{
	}
} 
function clientSearchContent(url) {
	$.get(url).done(function (data) {
 		$('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 	}); 
 } 
function funreload(event)
{
	funcleardata();
	 var branch = document.getElementById("cmbbranch").value;
	 if(branch=="" || branch=="a"){
	 	$.messager.alert('warning','Please select a single branch');
	 	return false;
	 }
	 var uptodate = $('#uptodate').jqxDateTimeInput('val');
	 var cldocno=$('#cldocno').val();
	 $("#overlay, #PleaseWait").show();
	 $("#detailsdiv").load("detailsGrid.jsp?branch="+branch+"&uptodate="+uptodate+"&cldocno="+cldocno+"&id=1");
}


function  funcleardata()
{
	$('input:text,input:hidden,select#cmbinvtype,select#cmbfuelout').val('');
	$('input:checkbox').attr('checked',false);
	$("#jqxgrid2").jqxGrid('clear');
	$("#jqxgrid2").jqxGrid('addrow', null, {});
	$("#jqxgrid2").jqxGrid('addrow', null, {}); 
	funChangeChkDelivery();
	funChangeChkAdvance();
}

function funCreateAJAX(chkadvance,cmbinvtype,dateout,timeout,kmout,cmbfuelout,delivery,
deldriver,delcharges,masterrefno,fleetno,cldocno,duration,clientdrivers,masterrefsrno){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items=items.trim();
			if(parseInt(items)==0){
				$.messager.alert('Message','Successfully Created');
				funreload("");
			}
			else{
				$.messager.alert('Warning','Not Created');
				return false;
			}
			} else {
		}
	}
	x.open("GET", "createAgmt.jsp?chkadvance="+chkadvance+"&cmbinvtype="+cmbinvtype+"&dateout="+dateout+"&timeout="+timeout+"&kmout="+kmout+"&cmbfuelout="+cmbfuelout+"&delivery="+delivery+"&deldriver="+deldriver+"&delcharges="+delcharges+"&masterrefno="+masterrefno+"&fleetno="+fleetno+"&cldocno="+cldocno+"&duration="+duration+"&clientdrivers="+clientdrivers+"&masterrefsrno="+masterrefsrno, true);
	x.send();
}


function funCreateAgmt(){
	var chkadvance=$('#hidchkadvance').val();
	var cmbinvtype=$('#cmbinvtype').val();
	var dateout=$('#dateout').jqxDateTimeInput('val');
	var timeout=$('#timeout').jqxDateTimeInput('val');
	var kmout=$('#kmout').val();
	var cmbfuelout=$('#cmbfuelout').val();
	var delivery=$('#hidchkdelivery').val();
	var delcharges=$('#delcharges').val();
	var deldriver=$('#hiddeldriver').val();
	var masterrefno=$('#hidmasterrefno').val();
	var masterrefsrno=$('#hidmasterrefsrno').val();
	var fleetno=$('#fleetno').val();
	var cldocno=$('#cldocno').val();
	var duration=$('#duration').val();
	var driverrows=$('#jqxgrid2').jqxGrid('getrows');
	var clientdrivers=[];
	for(var i=0;i<driverrows.length;i++){
		var driverid=$('#jqxgrid2').jqxGrid('getcellvalue',i,'dr_id1');
		var name=$('#jqxgrid2').jqxGrid('getcellvalue',i,'name1');
		var dob=$('#jqxgrid2').jqxGrid('getcelltext',i,'dob1');
		var age=$('#jqxgrid2').jqxGrid('getcellvalue',i,'age1');
		var nation=$('#jqxgrid2').jqxGrid('getcellvalue',i,'nation1');
		var mobile=$('#jqxgrid2').jqxGrid('getcellvalue',i,'mobno1');
		var license=$('#jqxgrid2').jqxGrid('getcellvalue',i,'dlno1');
		var licenseissuedate=$('#jqxgrid2').jqxGrid('getcelltext',i,'issdate1');
		var licenseexpiry=$('#jqxgrid2').jqxGrid('getcelltext',i,'led1');
		var licensetype=$('#jqxgrid2').jqxGrid('getcellvalue',i,'ltype1');
		var issuedfrom=$('#jqxgrid2').jqxGrid('getcellvalue',i,'issfrm1');
		var passport=$('#jqxgrid2').jqxGrid('getcellvalue',i,'passport_no1');
		var passportexpiry=$('#jqxgrid2').jqxGrid('getcelltext',i,'pass_exp1');
		
		if(name!="undefined" && name!="" && name!=null && typeof(name)!="undefined"){
			clientdrivers.push(driverid+" :: "+name+" :: "+dob+" :: "+age+" :: "+nation+" :: "+mobile+" :: "+license+" :: "+licenseissuedate+" :: "+licenseexpiry+" :: "+licensetype+" :: "+issuedfrom+" :: "+passport+" :: "+passportexpiry);
		}
	}
	if(clientdrivers==""){
		$.messager.alert('Warning','Please Select Driver');
		return false;
	}
	$('#overlay,#PleaseWait').show();
	funCreateAJAX(chkadvance,cmbinvtype,dateout,timeout,kmout,cmbfuelout,delivery,deldriver,delcharges,masterrefno,fleetno,cldocno,duration,clientdrivers,masterrefsrno);
}
</script>
<style>
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}


</style>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr>
	<td align="right" width="20%"><label class="branch">Up To</label></td>
            <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
	</tr> 
	 <tr><td colspan="2"></td></tr>
 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 TO Search" readonly onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="clientname"/>'></td></tr> 
 <tr><td colspan="2"><fieldset><legend><span class="branch">Agreement Details</span></legend>
 <table width="100%">
  <tr>
    <td><span class="branch">Advance</span></td>
    <td><input type="checkbox" name="chkadvance" id="chkadvance" onChange="funChangeChkAdvance();"></td>
  </tr>
  <tr>
    <td><span class="branch">Invoice Type</span></td>
    <td>
    	<select name="cmbinvtype" id="cmbinvtype">
        	<option value="">--Select--</option>
            <option value="1">Month End</option>
            <option value="2">Period</option>
            <option value="3">Quarterly</option>
    	</select>
    </td>
  </tr>
  <tr>
    <td><span class="branch">Fleet</span></td>
    <td><input type="text" name="fleetno" id="fleetno"  readonly style="height:20px;" value='<s:property value="fleetno"/>'></td>
  </tr>
  <tr>
    <td><span class="branch">Date Out</span></td>
    <td><div id="dateout" name="dateout"></div></td>
  </tr>
  <tr>
    <td><span class="branch">Time Out</span></td>
    <td><div id="timeout" name="timeout"></div></td>
  </tr>
  <tr>
    <td><span class="branch">Km Out</span></td>
    <td><input type="text" name="kmout" id="kmout" style="height:20px;" value='<s:property value="kmout"/>'></td>
  </tr>
  <tr>
    <td><span class="branch">Fuel Out</span></td>
    <td><select name="cmbfuelout" id="cmbfuelout">  
        	<option value="">-Select-</option>
            <option value="0.000">Level 0/8</option>
            <option value="0.125">Level 1/8</option>
            <option value="0.250">Level 2/8</option>
            <option value="0.375">Level 3/8</option>
            <option value="0.500">Level 4/8</option>
            <option value="0.625">Level 5/8</option>
            <option value="0.750">Level 6/8</option>
            <option value="0.875">Level 7/8</option>
            <option value="1.000">Level 8/8</option>
        </select>
   </td>
  </tr>
  <tr>
    <td><span class="branch">Delivery</span></td>
    <td><input type="checkbox" name="chkdelivery" id="chkdelivery" onChange="funChangeChkDelivery();"></td>
  </tr>
  <tr>
    <td><span class="branch">Driver</span></td>
    <td><input type="text" name="deldriver" id="deldriver" placeholder="Press F3 TO Search" readonly onKeyDown="getDelDriver(event);" onclick="this.placeholder='' "  style="height:20px;" value='<s:property value="deldriver"/>'></td>
  </tr>
  <tr>
    <td><span class="branch">Delivery Charges</span></td>
    <td><input type="text" name="delcharges" id="delcharges" style="height:20px;" value='<s:property value="delcharges"/>'></td>
  </tr>
</table>

 </fieldset></td></tr>
	 <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()">&nbsp;&nbsp;<input type="button" class="myButtons" name="btncreate" id="btncreate"  value="Create" onclick="funCreateAgmt();"></td></tr>
      
	<tr>
	 <tr><td colspan="2"></td></tr>
	 <!-- <tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 270px;"></div></td> 
	</tr> -->	
	</table>
	</fieldset>
	
	
	<input type="hidden" name="cldocno" id="cldocno"  style="height:20px;width:70%;" value='<s:property value="cldocno"/>'>
	
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="detailsdiv"><jsp:include page="detailsGrid.jsp"></jsp:include></div>
				<fieldset><legend>Driver Details</legend>
                	<div id="driverdiv"><jsp:include page="driverGrid.jsp"></jsp:include></div>
                </fieldset>
             </td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clientwindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="deldriverwindow">
   <div ></div>
</div>
<div id="driverinfowindow">
   <div ></div>
</div>
<div id="nationalityWindow">
   <div ></div>
</div>
<input type="hidden" name="hidchkadvance" id="hidchkadvance">
<input type="hidden" name="hidchkdelivery" id="hidchkdelivery">
<input type="hidden" name="hidmasterrefno" id="hidmasterrefno">
<input type="hidden" name="hidmasterrefsrno" id="hidmasterrefsrno">
<input type="hidden" name="duration" id="duration">
<input type="hidden" name="hiddeldriver" id="hiddeldriver">
</div>
</div>
</body>
</html>
	 