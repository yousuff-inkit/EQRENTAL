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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
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



.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"] {
    width: 100%;
}

input[type="radio"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 10px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

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

/* Icon buttons (rental agreement / booking / client review) untouched by the 24px/30px system */
.icons {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #ECF8E0;
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
 
	
	
	// $('#vehiclewindow1').jqxWindow({ autoOpen: false,width: '80%', height: '80%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 240, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	  $('#movementwindow').jqxWindow({ autoOpen: false,width: '77%', height: '74%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Movement Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); 
$('#securitypasswindow').jqxWindow({ autoOpen: false,width: '60%', height: '60%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Security Pass Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});	  
$('#clientreview').click(function(){
	  	   var url=document.URL;
	  		var reurl=url.split("com");
	  		  window.parent.formName.value="Client Review";
	  		  window.parent.formCode.value="CRW";

	   top.addTab("Client Review",reurl[0]+"com/operations/clientrelations/clientreview/clientReview.jsp");

      }); 
	    $('#rabutton').click(function(){
	  	   var url=document.URL;
	  		var reurl=url.split("com");
	  		  window.parent.formName.value="Rental Agreement Create";
	  		  window.parent.formCode.value="RAG";

	   top.addTab("Rental Agreement",reurl[0]+"com/operations/agreement/rentalagreement/rentalAgreement.jsp");

	   });  
	   
	    $('#bookingbtn').click(function(){
		  	   var url=document.URL;
		  		var reurl=url.split("com");
		  		  window.parent.formName.value="Booking";
		  		  window.parent.formCode.value="VBR";

		   top.addTab("Booking",reurl[0]+"com/operations/marketing/booking/booking.jsp");

		   });  
		   
	  //rabutton bookingbtn
});
function securityPassSearchContent(url) {
	$('#securitypasswindow').jqxWindow('focus'); 
	$.get(url).done(function (data) {
		$('#securitypasswindow').jqxWindow('setContent', data);
	}); 
	 
 }
function funreload(event)  
{     
	document.getElementById("fleetno").value="";
	document.getElementById("brach").value="";
	document.getElementById("grp").value="";
	 disitems();
	 
	 
	 var barchval = document.getElementById("cmbbranch").value;
     
	 $("#fleetdiv").load("readyToRentGrid.jsp?brchval="+barchval);
	 
	 $("#maintariffGrid").jqxGrid('clear');
	 $("#jqxgridtarifrr").jqxGrid('clear');
	
	}
	
	
function funExportBtn()
{
	
//	$("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'ReadyToRent');
	
	
	
	 if(parseInt(window.parent.chkexportdata.value)=="1")
	 {
	 JSONToCSVCon(sssss, 'ReadyToRent', true);
	 }
 else
	 {
	   $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'ReadyToRent');
	 }
	
	
	
	}
	
function disitems()
{
	 $('#btnvehicle').attr("disabled",true);
	 $('#btnmove').attr("disabled",true);
	 $('#btnclient').attr("disabled",true);
	 
}
	
 function getVehicleMov(){
	  var fleetno=document.getElementById("fleetno").value;
	  var vals=0;
	  var ready="ready";
	  $('#movementwindow').jqxWindow('setContent', '');
	  $('#movementwindow').jqxWindow('open');  
	  movementSearchContent("<%=contextPath%>/com/dashboard/vehicle/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+vals+"&todate="+vals+"&ready="+ready);
	 }
 
 function movementSearchContent(url) {
	 //$('#vehiclewindow').jqxWindow('open'); 
	 $('#movementwindow').jqxWindow('focus'); 
	 $.get(url).done(function (data) {
	$('#movementwindow').jqxWindow('setContent', data);
	}); 
	 
 }
 function changeClientAttachContent(url) {
		$.get(url).done(function (data) {
			    $('#windowattach').jqxWindow('open');
				$('#windowattach').jqxWindow('setContent',data);
				$('#windowattach').jqxWindow('bringToFront');
	}); 
	}
 function funClientAttach(){
	
	 
		if ($("#docno").val()!="") {
			  $("#windowattach").jqxWindow('setTitle',"VEH - "+document.getElementById("docno").value);
			changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+document.getElementById("docno").value);		
		} else {
			$.messager.alert('Message','Select Fleet....!','warning');
			return;
		}
	}
 function openclientreview()
 {
	   var url=document.URL;
		var reurl=url.split("com");
		  window.parent.formName.value="Client Review";
		  window.parent.formCode.value="CRW";

 top.addTab("Client Review",reurl[0]+"com/operations/clientrelations/clientreview/clientReview.jsp");

 }
 /* function getRentalAgreement(){
	  var docno = $('#txtdocno').val();
	  
	  if(docno==''){
	    $.messager.alert('Message','Choose an Agreement.','warning');
	    return 0;
	   }
	  
	  var url=document.URL;
	  var reurl=url.split("com");
	  
	  window.parent.formName.value="Client Review";
	  window.parent.formCode.value="CRW";
	  
	  var detName= "Client Review";
	  var path= "com/operations/clientrelationsclientreviewDetails.action?mode=view&docno="+docno;
	  top.addTab( detName,reurl[0]+""+path);
	 }
  */
<%--  function getVehicle(){
	 $('#vehiclewindow1').jqxWindow('setContent', '');
	 $('#vehiclewindow1').jqxWindow('open'); 
	  vehicleSearchContent("<%=contextPath%>/com/controlcentre/masters/vehicle/saveVehicle1.action?mode=view&fleetno="+document.getElementById("fleetno").value);
	}
	function vehicleSearchContent(url) {
		 //$('#vehiclewindow').jqxWindow('open'); 
		 $('#vehiclewindow1').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		$('#vehiclewindow1').jqxWindow('setContent', data);
		}); 
		}
		  --%>
	

</script>
</head>
  
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

	<div class="sidebar-filters">
		<div class="sidebar-scroll-content">

			<div class="filter-card">
				<table class="filter-table">
					<tr>
						<td class="label-cell">Fleet</td>
						<td><input type="text" name="fleetno" id="fleetno" readonly="readonly" value='<s:property value="fleetno"/>' ></td>
					</tr>
				</table>
				<div style="text-align: center;">
					<input type="button" name="btnvehicle" id="btnvehicle" value="Attach" class="myButton" onclick="funClientAttach();">
					<input type="button" name="btnmove" id="btnmove" value="Movement" class="myButton" onClick="getVehicleMov();">
				</div>
				<div style="text-align: center; margin-top: 10px;">
					<button type="button"  title="Rental Agreement"  class="icons" id="rabutton"  value='<s:property value="rabutton"/>'> 
						<img alt="Rental Agreement" src="<%=contextPath%>/icons/openra.png"> 
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button"  title="Booking"  class="icons" id="bookingbtn"  value='<s:property value="bookingbtn"/>'>
						<img alt="Booking" src="<%=contextPath%>/icons/openbk.png"> 
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button"  title="Client Review"  class="icons" id="clientreview"  value='<s:property value="clientreview"/>'>
						<img alt="Client Review" src="<%=contextPath%>/icons/openclientreview.png"> 
					</button>
				</div>
			</div>

			<div class="filter-card">
				<div id="mastertariff"><jsp:include page="masterTariffgrid.jsp"></jsp:include></div>
			</div>

		</div>
	</div>

	<div class="main-content-wrapper">
		<div class="top-toolbar-container">
			<jsp:include page="../../heading.jsp"></jsp:include>
		</div>
		<div class="scrollable-grid-area">
			<div id="fleetdiv"><jsp:include page="readyToRentGrid.jsp"></jsp:include></div>
			<div id="tariffdiv"><jsp:include page="tariffShowgrid.jsp"></jsp:include></div>
		</div>
	</div>

</div>

<div style="display:none;">
	<input type="hidden" name="brach" id="brach" value='<s:property value="brach"/>' >
	<input type="hidden" name="grp" id="grp" value='<s:property value="grp"/>' >
	<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
</div>

</div>

<label hidden="true" id="trncodeval"></label>
 <label  hidden="true" id="statusval"></label>
<div id="movementwindow">
<div></div>
</div> 
<div id="securitypasswindow">
<div></div>
</div> 
</div>


</body>
</html>
