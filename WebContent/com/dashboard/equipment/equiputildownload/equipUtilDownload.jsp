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
    width: 280px; /* Kept slightly narrower for standard toolbars */
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

/* jqx Date Container Mapping Rules */
.filter-table div[id^="date"] {
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
	<script type="text/javascript">
		$(document).ready(function () {
			$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			$('#btnupdate').click(function(){
				var date=$('#date').jqxDateTimeInput('val');
				$.messager.confirm('Confirm', 'Do you want to download?', function(r){
					if (r){
						
						$.post('saveData.jsp',{'date':date},function(data,status){
							data=JSON.parse(data);
							if(data.errorstatus=="0"){
								$.messager.alert('Message','Downloaded Successfully','success');
								funreload("");
							}
							else{
								$.messager.alert('Warning','Not Updated','warning');
							}
						});		
					}
				});
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
			/*if(brhid=="a" || brhid==""){
				$.messager.alert('Warning','Please select branch','warning');
				return false;
			}*/
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
	<form id="frmEquipUtil" action="saveEquipUtil">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				
                <div class="master-container">

                    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
                    <div class="sidebar-filters">
                        <div class="sidebar-scroll-content">
                            
                            <!-- Maintained Hidden Date Field -->
                            <div class="filter-card" style="display: none;">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Date</td>
                                        <td>
                                            <div id="date" name="date"></div>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div class="filter-card">
                                <input type="button" name="btnupdate" id="btnupdate" value="Download" class="btn-submit">
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
                                <%-- <jsp:include page="contractGrid.jsp"></jsp:include> --%>
                            </div>
                        </div>

                    </div>

                </div>

                <!-- Hidden Inputs Maintained Outside the Visual Layout -->
                <div style="display:none;">
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' >
                    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
                </div>

			</div>
		</div>
	</form>
</body>
</html>