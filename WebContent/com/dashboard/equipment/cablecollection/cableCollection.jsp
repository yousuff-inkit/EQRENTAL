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
	    	
	    	$("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
		 	$("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			var onemonthbefore=new Date();
			onemonthbefore=new Date(onemonthbefore.setMonth(onemonthbefore.getMonth()-1));
			$('#fromdate').jqxDateTimeInput('setDate',onemonthbefore);
			
		});
		function funExportBtn(){
			$("#cableGrid").excelexportjs({
				containerid: "cableGrid",
				datatype: 'json',
				dataset: null,
				gridId: "cableGrid",
				columns: getColumns("cableGrid"),
				worksheetName: "Cable Data"
			});
						
		}
	
		function setValues(){
			if(($('#msg').val()!="")){
				$.messager.alert('Message',$('#msg').val());
			}
		}
		function funreload(event){
			var brhid = document.getElementById("cmbbranch").value;
			/*if(brhid=="a" || brhid==""){
				$.messager.alert('Warning','Please select branch','warning');
				return false;
			}*/
	 		var fromdate=$('#fromdate').jqxDateTimeInput('val');
			var todate=$('#todate').jqxDateTimeInput('val');
			
			var collectstatus="1";
			if(document.getElementById("rdotobecollected").checked==true){
				collectstatus="1";
			}
			else if(document.getElementById("rdoall").checked==true){
				collectstatus="0";
			}
	   		$("#overlay, #PleaseWait").show();
	   		$("#cablediv").load("cableGrid.jsp?brhid="+brhid+"&fromdate="+fromdate+"&todate="+todate+"&id=1&collectstatus="+collectstatus);
	 	}
	 	function funClearData(){
	 		$('#contractGrid').jqxGrid('clear');
	 	}
	 	
	 	function funCollectCable(){
	 		var gridindex=$('#rowindex').val();
	 		var contractdocno=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "contractdocno");
	 		var contractvocno=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "contractvocno");
	 		var collectqty=$('#collectqty').val();
	 		var assetgrpdocno=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "assetgrpdocno");
	 		var cablerowno=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "cablerowno");//rowno in my_cableissue
	 		var cableqty=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "qty");//Qty of cable issued
	 		var savedcollectqty=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "collectqty");//Qty of cable collected
	 		
	 		if(parseFloat(collectqty)>parseFloat(cableqty)){
	 			$.messager.alert('Warning','Collect Qty cannot be more than issued qty');
	 			$('#collectqty').val($('#cableGrid').jqxGrid('getcellvalue', gridindex, "qty"));
	 			return false;
	 		}
	 		
	 		if(parseFloat(cableqty)-parseFloat(savedcollectqty)==0){
	 			$.messager.alert('Warning','Collection already done');
	 			return false;
	 		}
	 		$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 			if (r){
	 				$.post('collectCable.jsp',{'contractdocno':contractdocno,'collectqty':collectqty,'assetgrpdocno':assetgrpdocno,'cablerowno':cablerowno},function(data,status){
	 		 			data=JSON.parse(data);
	 		 			if(data.errorstatus=="0"){
	 		 				$.messager.alert('Message','Successfully Collected');
	 		 				funreload("");
	 		 			}
	 		 			else{
	 		 				$.messager.alert('Warning','Not Collected');
	 		 			}
	 		 		});
	 			}
	 		});
	 		
	 		
	 	}
	</script>

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
<body onload="getBranch();setValues();">
	<form id="frmCableCollection" >
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

                                <div class="radio-group">
                                    <label><input type="radio" name="rdotype" id="rdotobecollected" checked> To Be Collected</label>
                                    <label><input type="radio" name="rdotype" id="rdoall"> All</label>
                                </div>
                            </div>

                            <div class="filter-card">
                                <div style="text-align: center; margin-bottom: 12px;">
                                    <label style="font-weight:bold; color:red; font-size: 12px;">Selected Contract : <span class="selected-contract"></span></label>
                                </div>
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Cable</td>
                                        <td><input type="text" name="cablename" id="cablename" disabled></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Quantity</td>
                                        <td><input type="text" name="collectqty" id="collectqty"></td>
                                    </tr>
                                </table>
                                <button type="button" name="btncollect" id="btncollect" class="btn-submit" onclick="funCollectCable();">Collect</button>
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
                            <div id="cablediv">
                                <jsp:include page="cableGrid.jsp"></jsp:include>
                            </div>
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