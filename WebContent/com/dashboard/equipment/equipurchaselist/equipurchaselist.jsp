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
	<script type="text/javascript">
		$(document).ready(function () {
			$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
			$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
		       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
		       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
		       document.getElementById("sum").checked=true;
		       funchange();
		});
		function funExportBtn(){
			if(document.getElementById("sum").checked){
			$("#contractdiv").excelexportjs({
				containerid: "contractdiv",
				datatype: 'json',
				dataset: null,
				gridId: "contractGrid",
				columns: getColumns("contractGrid"),
				worksheetName: "Equipurchaselist1"
			});
			}else if(document.getElementById("det").checked){
			$("#vehpuchase").excelexportjs({
				containerid: "vehpuchase",
				datatype: 'json',
				dataset: null,
				gridId: "vehpurchasedirgrid",
				columns: getColumns("vehpurchasedirgrid"),
				worksheetName: "Equipurchaselist2"
			});	
			}else{}
		}
	
	 
		function funreload(event){
			var brhid = document.getElementById("cmbbranch").value;
			var todate=$('#todate').val();
	 		var fromdate=$('#fromdate').val();
	   		$("#overlay, #PleaseWait").show();
	   		if(document.getElementById("sum").checked){
	   			$("#contractdiv").load("contractGrid.jsp?brhid="+brhid+"&fromdate="+fromdate+"&id=1&todate="+todate);
	 		}else if(document.getElementById("det").checked){
	 			 $("#vehpuchase").load("vehpurchaseDetails.jsp?brhid="+brhid+"&fromdate="+fromdate+"&id=1&todate="+todate);
	 		}else{}
	   		
	 	}
	 	function funClearData(){
	 		$('#contractGrid').jqxGrid('clear');
	 	}
	 	function funchange(){
	 		if(document.getElementById("sum").checked){
	 			$("#vehpuchase").hide();
	 			$("#contractdiv").show();
	 		}else if(document.getElementById("det").checked){
	 			$("#vehpuchase").show();
	 			$("#contractdiv").hide();  
	 		}else{}
	 	}
	</script>

<style>
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
    height: 100vh;
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
.filter-table div[id^="todate"] {
    width: 100%;
}

/* Checkbox & Radio layout */
input[type="radio"], input[type="checkbox"] {
    margin: 0 5px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 15px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

/* ===== RIGHT CONTENT AREA (Horizontally Aligned Heading) ===== */
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
</head>
<body onload="getBranch();">
	<form id="frmEquippurlist">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>

                <div class="master-container">

                    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
                    <div class="sidebar-filters">
                        <div class="sidebar-scroll-content">
                            
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">From Date</td>
                                        <td><div id="fromdate" name="fromdate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To Date</td>
                                        <td><div id="todate" name="todate"></div></td>
                                    </tr>
                                </table>

                                <!-- Summary / Detail Radio Selection -->
                                <div class="radio-group">
                                    <label for="sum" class="branch">
                                        <input type="radio" id="sum" name="rdio" value="summary" onchange="funchange()">
                                        Summary
                                    </label>
                                    <label for="det" class="branch">
                                        <input type="radio" id="det" name="rdio" value="detail" onchange="funchange()">
                                        Detail
                                    </label>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT PANEL (WORKSPACE GRIDS) ================= -->
                    <div class="main-content-wrapper">
                        
                        <!-- Horizontally Aligned Heading Toolbar -->
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="scrollable-grid-area">
                            
                            <div id="contractdiv">
                                <jsp:include page="contractGrid.jsp"></jsp:include>
                            </div>
                            
                            <div id="vehpuchase">
                                <jsp:include page="vehpurchaseDetails.jsp"></jsp:include>
                            </div>

                        </div>

                    </div>

                </div>

			</div>
		</div>
	</form>
</body>
</html>