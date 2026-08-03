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
textarea{
font-family:Tahoma;
font-size:12px;

}
.myButtons {
	 height: 30px !important;
    padding: 0 12px;
    border-radius: 4px;
    font-size: 13px;
    line-height: 30px;
    background: #1d4ed8 !important;
    color: #fff;
    border: none;
    cursor: pointer;
}
.myButtons:hover {
	  color: #fff;
     background: #1d4ed8;
  
}
.myButtons:active {
  color: #fff;
      background: #1d4ed8;
  
}
.myButtons:focus {
  color: #fff;
      background: #1d4ed8;
}

/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px;
    flex: 0 0 280px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px;
}

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.filter-card-heading {
    font-size: 12px;
    font-weight: 700;
    color: #4e5e71;
    margin-bottom: 8px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;
    padding: 2px 8px !important;
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* "Details" free-text field keeps its larger footprint (not a single-line filter field) */
#pickdesc {
    height: 50px !important;
}



/* jqx Date/Time Container Mapping Rules */
.filter-table div[id^="periodupto"],
.filter-table div[id^="indate"],
.filter-table div[id^="intime"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit, .myButton {
    height: 30px !important;
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
    margin-top: 10px;
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-wrapper {
    flex: 1;
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    padding: 15px 20px;
    overflow: auto;
    box-sizing: border-box;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	
	
	
	document.getElementById("btnpickupsave").style.display="none";
	$("#overlay, #PleaseWait").hide();
	 /* $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");     */
	    $('#agmtnowindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Contract Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#agmtnowindow').jqxWindow('close');
	    $("#periodupto").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#indate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 
	 $("#intime").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	funDisable();
	 $('#agmtvocno').dblclick(function(){
		 
				if(document.getElementById("cmbbranch").value==""){
					
					$.messager.alert('Message','Branch is Mandatory','warning');
					return false;
				}
				if(document.getElementById("cmbtype").value==""){
					$.messager.alert('Message','Agreement Type is Mandatory','warning');
					return false;
				}
	    $('#agmtnowindow').jqxWindow('open');
	$('#agmtnowindow').jqxWindow('focus');

	 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
		 
		 });
	 
	 funClearData();
});

function getAgmt(event){
	
	  /*  $('#gridRaSearch').jqxGrid('clear');
	 $("#gridRaSearch").jqxGrid("addrow", null, {}); */
	if(document.getElementById("cmbbranch").value==""){
		
		$.messager.alert('Message','Branch is Mandatory','warning');
		return false;
	}
	if(document.getElementById("cmbtype").value==""){
		$.messager.alert('Message','Agreement Type is Mandatory','warning');
		return false;
	}
	 var x= event.keyCode;
   if(x==114){
  	 
	    $('#agmtnowindow').jqxWindow('open');
		$('#agmtnowindow').jqxWindow('focus');
		 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
   }
   else{
    }
	
}
function agmtnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}
function funDisable(){
	/* $('input[type=text],[type=email],[type=hidden],[type=password], textarea').val('');
	$('select').find('option').prop("selected", false); */
	$('#pickupfield').prop('disabled',true);
	$('#indate').jqxDateTimeInput('disabled',true);
}
function funpickupadd(){
	$('#pickupfield').prop('disabled',false);
	$('#indate').jqxDateTimeInput('disabled',false);
	document.getElementById("btnpickupadd").style.display="none";
	document.getElementById("btnpickupsave").style.display="block";
}
function funpickupsave(){
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Message','Please Select a Branch','warning');
		return false;
	}
	if(document.getElementById("agmtvocno").value==""){
		$.messager.alert('Message','Agreement is Mandatory','warning');
		return false;
	}
	if($('#indate').jqxDateTimeInput('getDate')==null){
		$.messager.alert('Message','Pick Up Date is Mandatory','warning');
		return false;
	}
	if($('#intime').jqxDateTimeInput('getDate')==null){
		$.messager.alert('Message','Pick Up Time is Mandatory','warning');
		return false;
	}
	document.getElementById("mode").value="A";
	 $("#overlay, #PleaseWait").show();
	document.getElementById("frmEquipPickup").submit();

}

function funreload(event){
	  var branchval = document.getElementById("cmbbranch").value;	 
	 $("#pickupdiv").load("pickupGrid.jsp?branchval="+branchval);
 
 }
 function setValues(){
	getBranch();
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	
 }
	function funPickupPrint(){
		if(document.getElementById("docno").value==""){
			$.messager.alert('Message','Please Select a Document','warning');
		 	return false;
	 	}
	 	else{		 
			var url=document.URL;
		 	var reurl=url.split("com/");
			
			var win= window.open(reurl[0]+"com/dashboard/equipment/equippickup/equipPickUpPrint?docno="+document.getElementById("docno").value+"&brhid="+document.getElementById("brhid").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			win.focus();
	 	}
 	}
 
 function funPickupDelete(){
	 if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
			$.messager.alert('Message','Please Select a Branch','warning');
			return false;
		}
	 if(document.getElementById("docno").value==""){
		 $.messager.alert('Message','Please Select a Document','warning');
		 return false;
	 }
	 else{
		document.getElementById("mode").value="D";
		 $("#overlay, #PleaseWait").show();
		document.getElementById("frmEquipPickup").submit();
	 }
 }
 
 
 function funClearData(){
	 $('#cmbagmttype').val('');
	 $('#agmtvocno').val('');
	 $('#agmtno').val('');
	 $('#fleet_details').val('');
	 //$('#agmtdetails').val('');
	 $('#fleet_no').val('');
	 $('#indate').jqxDateTimeInput('setDate',null);
	 $('#intime').jqxDateTimeInput('setDate',null);
	 $('#inkm').val('');
	 $('#cmbinfuel').val('');
	 $('#pickdesc').val('');
	 $('#docno').val('');
	// $('#agmtdetails').innerText('');
	//document.getElementById("agmtdetails").innerText="";
 }
 
</script>
</head>
<body onload="setValues();">
	<form id="frmEquipPickup" action="saveEquipPickup" method="post" autocomplete="off">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>

				<div class="master-container">

					<div class="sidebar-filters">
						<div class="sidebar-scroll-content">

							<div class="filter-card">
								<table class="filter-table">
									<tr><td class="label-cell">Period Upto</td><td><div id="periodupto"></div></td></tr>
								</table>
								<div style="text-align: center;">
									<button type="button" class="myButtons" id="btnpickupadd" onclick="funpickupadd();">Add</button>&nbsp;
									<button type="button" class="myButtons" id="btnpickupsave" hidden="true" onclick="funpickupsave();">Save</button>
								</div>
							</div>

							<div class="filter-card" id="pickupfield">
								<div class="filter-card-heading">In Details</div>
								<table class="filter-table">
									<tr>
										<td class="label-cell">Contract</td>
										<td>
											<input type="text" name="agmtvocno" id="agmtvocno" onKeyDown="getAgmt(event);" readonly value='<s:property value="agmtvocno"/>'>
										</td>
									</tr>
									<tr>
										<td class="label-cell">Equipment</td>
										<td>
											<input type="text" name="fleetdetails" id="fleetdetails" value='<s:property value="fleetdetails"/>' readonly>
										</td>
									</tr>
									<tr>
										<td class="label-cell">Date</td>
										<td><div id="indate" name="indate" value='<s:property value="indate" />'></div></td>
									</tr>
									<tr>
										<td class="label-cell">Time</td>
										<td><div id="intime" name="intime" value='<s:property value="intime" />'></div></td>
									</tr>
									<tr>
										<td class="label-cell">Km</td>
										<td><input type="text" name="inkm" id="inkm" value='<s:property value="inkm" />'></td>
									</tr>
									<tr>
										<td class="label-cell">Fuel</td>
										<td>
											<select name="cmbinfuel" id="cmbinfuel" value='<s:property value="cmbinfuel" />'><option value="">--Select--</option>
												<option value=0.000>Level 0/8</option>
												<option value=0.125>Level 1/8</option>
												<option value=0.250>Level 2/8</option>
												<option value=0.375>Level 3/8</option>
												<option value=0.500>Level 4/8</option>
												<option value=0.625>Level 5/8</option>
												<option value=0.750>Level 6/8</option>
												<option value=0.875>Level 7/8</option>
												<option value=1.000>Level 8/8</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="label-cell">Details</td>
										<td><input type="text" name="pickdesc" id="pickdesc" value='<s:property value="pickdesc" />'></td>
									</tr>
								</table>
							</div>

							<div class="filter-card">
								<div style="text-align: center;">
									<button type="button" name="btnpickupprint" id="btnpickupprint" class="myButtons" onclick="funPickupPrint();">Print</button>&nbsp;&nbsp;&nbsp;
									<button type="button" name="btnpickupdelete" id="btnpickypdelete" class="myButtons" onclick="funPickupDelete();">Delete</button>
								</div>
								<textarea id="agmtdetails" name="agmtdetails" style="resize:none;width:100%; margin-top:10px; box-sizing:border-box;" rows="5" readonly></textarea>
							</div>

						</div>
					</div>

					<div class="main-content-wrapper">
						<div class="top-toolbar-container">
							<jsp:include page="../../heading.jsp"></jsp:include>
						</div>
						<div class="scrollable-grid-area">
							<div id="pickupdiv"><jsp:include page="pickupGrid.jsp"></jsp:include></div>
						</div>
					</div>

				</div>

				<!-- Hidden Inputs Maintained Outside Layout Flow -->
				<div style="display:none;">
					<input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>' />
					<input type="hidden" name="fleet_no" id="fleet_no" value='<s:property value="fleet_no"/>' readonly>
					<input type="hidden" name="gridlength" id="gridlength" >
					<input type="hidden" name="invgridlength" id="invgridlength" >
					<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
					<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
					<input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
					<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
					<input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
					<input type="hidden" name="calcdocno" id="calcdocno" value='<s:property value="calcdocno"/>'>
					<select name="cmbtype" id="cmbtype" value='<s:property value="cmbtype" />' hidden="true">
						<option value="ERC">Rental Contract</option>
					</select>
				</div>

			</div>
			<div id="agmtnowindow">
				<div></div>
			</div>
		</div>
	</form>
</body>
</html>
