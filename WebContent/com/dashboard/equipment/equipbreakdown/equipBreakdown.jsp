
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
	<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
	<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
	<style type="text/css">
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

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"],
.filter-table div[id^="startdate"],
.filter-table div[id^="starttime"],
.filter-table div[id^="enddate"],
.filter-table div[id^="endtime"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit, .myButton {
    width: 100%;
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
			$("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy",value:new Date()});
		 	$("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy",value:new Date()});
			var onemonthbefore=new Date();
			onemonthbefore=new Date(onemonthbefore.setMonth(onemonthbefore.getMonth()-1));
			$('#fromdate').jqxDateTimeInput('setDate',onemonthbefore);
			
			$("#startdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy",value:null});
		 	$("#enddate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy",value:null});
			
			$("#starttime").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"HH:mm",value:null,showCalendarButton:false});
		 	$("#endtime").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"HH:mm",value:null,showCalendarButton:false});
		
			$('#btnupdate').click(function(){
				
				var rowindex=$('#rowindex').val();
				var eqdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'eqdocno');
				var eqclstatus=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'eqclstatus');
				if(eqdocno=="0" || (eqdocno!="0" && eqclstatus=="1")){
					if($('#startdate').jqxDateTimeInput('getDate')==null){
						$.messager.alert('Warning','Please enter start date','warning');
						return false;
					}
					if($('#starttime').jqxDateTimeInput('getDate')==null){
						$.messager.alert('Warning','Please enter start time','warning');
						return false;
					}
					
					var contractdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
					var fleetno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'currentfleetno');
					var calcdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'calcdocno');
					var date=$('#startdate').jqxDateTimeInput('val');
					var time=$('#starttime').jqxDateTimeInput('val');
					var brhid=$('#cmbbranch').val();
					var remarks=$('#remarks').val();
					$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
						if (r){
							$.post('saveData.jsp',{'remarks':remarks,'brhid':brhid,'contractdocno':contractdocno,'fleetno':fleetno,'calcdocno':calcdocno,'date':date,'time':time,'mode':1},function(data,status){
								data=JSON.parse(data);
								if(data.errorstatus=="0"){
									$.messager.alert('Message','Updated Successfully','success');
									funClearData();
									funreload("");
								}
								else{
									$.messager.alert('Warning','Not Updated','warning');
								}
							});		
						}
					});
				}
				else{
					if($('#enddate').jqxDateTimeInput('getDate')==null){
						$.messager.alert('Warning','Please enter end date','warning');
						return false;
					}
					if($('#endtime').jqxDateTimeInput('getDate')==null){
						$.messager.alert('Warning','Please enter end time','warning');
						return false;
					}
					if($('#amount').val()==''){
						$.messager.alert('Warning','Please enter amount','warning');
						return false;
					}
					var startdate=new Date($('#contractGrid').jqxGrid('getcellvalue',rowindex,'startdate'));
					startdate.setHours(0,0,0,0);
					var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
					enddate.setHours(0,0,0,0);
					if(enddate<startdate){
						$.messager.alert('Warning','End date cannot be less than start date','warning');
						return false;
					}
					if(enddate-startdate==0){
						var starttime=new Date();
						var tempstarttime=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'starttime');
						starttime.setHours(tempstarttime.split(":")[0]);
						starttime.setMinutes(tempstarttime.split(":")[1]);
						var endtime=new Date($('#endtime').jqxDateTimeInput('getDate'));
						if(endtime.getHours()<starttime.getHours()){
							$.messager.alert('Warning','End time cannot be less than start time','warning');
							return false;	
						}
						if(endtime.getHours()==starttime.getHours()){
							if(endtime.getMinutes()<starttime.getMinutes()){
								$.messager.alert('Warning','End time cannot be less than start time','warning');
								return false;
							}
						}
					}
					var contractdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
					var fleetno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'currentfleetno');
					var calcdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'calcdocno');
					var date=$('#enddate').jqxDateTimeInput('val');
					var time=$('#endtime').jqxDateTimeInput('val');
					var remarks=$('#remarks').val();
					var amount=$('#amount').val();
					var brhid=$('#cmbbranch').val();
					$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
						if (r){
							$.post('saveData.jsp',{'docno':eqdocno,'remarks':remarks,'amount':amount,'brhid':brhid,'contractdocno':contractdocno,'fleetno':fleetno,'calcdocno':calcdocno,'date':date,'time':time,'mode':2},function(data,status){
								data=JSON.parse(data);
								if(data.errorstatus=="0"){
									$.messager.alert('Message','Updated Successfully','success');
									funClearData();
									funreload("");
								}
								else{
									$.messager.alert('Warning','Not Updated','warning');
								}
							});		
						}
					});
				}
			});
		});
		function funExportBtn(){
			$("#contractGrid").excelexportjs({
				containerid: "contractGrid",
				datatype: 'json',
				dataset: null,
				gridId: "contractGrid",
				columns: getColumns("contractGrid"),
				worksheetName: "Contract Data"
			});
						
		}
	
		function setValues(){
			if(($('#msg').val()!="")){
				$.messager.alert('Message',$('#msg').val());
			}
		}
		function funreload(event){
			var brhid = document.getElementById("cmbbranch").value;
			if(brhid=="a" || brhid==""){
				$.messager.alert('Warning','Please select branch','warning');
				return false;
			}
	 		var fromdate=$('#fromdate').jqxDateTimeInput('val');
	 		var todate=$('#todate').jqxDateTimeInput('val');
	   		$("#contractdiv").load("contractGrid.jsp?brhid="+brhid+"&fromdate="+fromdate+"&todate="+todate+"&id=1");
	 	}
	 	function funClearData(){
	 		$('#startdate,#starttime,#enddate,#endtime').jqxDateTimeInput('setDate',null);
	 		$('#amount,#remarks').val('');
	 		$('#contractGrid').jqxGrid('clear');
	 	}
	</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmEquipBreakdown" action="saveEquipBreakdown">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>

				<div class="master-container">

					<div class="sidebar-filters">
						<div class="sidebar-scroll-content">

							<div class="filter-card">
								<table class="filter-table">
									<tr><td class="label-cell">From Date</td><td><div id="fromdate" name="fromdate"></div></td></tr>
									<tr><td class="label-cell">To Date</td><td><div id="todate" name="todate"></div></td></tr>
								</table>
							</div>

							<div class="filter-card">
								<div class="filter-card-heading">Start Details</div>
								<table class="filter-table">
									<tr>
										<td class="label-cell">Start Date</td>
										<td><div id="startdate" name="startdate"></div></td>
									</tr>
									<tr>
										<td class="label-cell">Start Time</td>
										<td><div id="starttime" name="starttime"></div></td>
									</tr>
								</table>
							</div>

							<div class="filter-card">
								<div class="filter-card-heading">End Details</div>
								<table class="filter-table">
									<tr>
										<td class="label-cell">End Date</td>
										<td><div id="enddate" name="enddate"></div></td>
									</tr>
									<tr>
										<td class="label-cell">End Time</td>
										<td><div id="endtime" name="endtime"></div></td>
									</tr>
									<tr>
										<td class="label-cell">Amount</td>
										<td><input type="text" name="amount" id="amount" style="text-align:right;"></td>
									</tr>
								</table>
							</div>

							<div class="filter-card">
								<table class="filter-table">
									<tr>
										<td class="label-cell">Remarks</td>
										<td><input type="text" name="remarks" id="remarks"></td>
									</tr>
								</table>
								<input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButton">
							</div>

						</div>
					</div>

					<div class="main-content-wrapper">
						<div class="top-toolbar-container">
							<jsp:include page="../../heading.jsp"></jsp:include>
						</div>
						<div class="scrollable-grid-area">
							<div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>
						</div>
					</div>

				</div>

				<!-- Hidden Inputs Maintained Outside Layout Flow -->
				<div style="display:none;">
					<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' >
					<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
				</div>

			</div>
		</div>
	</form>
</body>
</html>
