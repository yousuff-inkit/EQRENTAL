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
			$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		  
			$('#btnupdate').click(function(){
				var selectedrows=$('#equipGrid').jqxGrid('getselectedrowindexes');
				if(selectedrows.length==0){
					$.messager.alert('Warning','Please select Equipment','warning');
					return false;
				}
				var equiparray=new Array();
				
				for(var i=0;i<selectedrows.length;i++){
					var calcdocno=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'calcdocno');
					var amount=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'amount');
					var vatamt=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'vatamt');
					var netamount=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'netamount');
					var invdate=$('#equipGrid').jqxGrid('getcelltext',selectedrows[i],'invdate');
					var invtodate=$('#equipGrid').jqxGrid('getcelltext',selectedrows[i],'invtodate');
					var daysused=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'daysused');
					var rate=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
					var vatpercent=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'vatpercent');
					var fleetno=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
					var flname=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'flname');
					
					equiparray.push(calcdocno+" :: "+invdate+" :: "+invtodate+" :: "+amount+" :: "+vatamt+" :: "+netamount+" :: "+daysused+" :: "+rate+" :: "+vatpercent+" :: "+fleetno+" :: "+flname);
				}
				var brhid=$('#docbrhid').val();
				var contractdocno=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'doc_no');
				var contractvocno=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'voc_no');
				var cldocno=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'cldocno');
				var periodupto=$('#periodupto').jqxDateTimeInput('val');
				var delcharges=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'delcharges');
				var collectcharges=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'collectcharges');
				var srvcharges=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'srvcharges');
				var srvdesc=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'srvdesc');
				if(delcharges=="" || delcharges==null || delcharges=="undefined" || typeof(delcharges)=="undefined"){
					delcharges="0.0";
				}
				if(collectcharges=="" || collectcharges==null || collectcharges=="undefined" || typeof(collectcharges)=="undefined"){
					collectcharges="0.0";
				}
				if(srvcharges=="" || srvcharges==null || srvcharges=="undefined" || typeof(srvcharges)=="undefined"){
					srvcharges="0.0";
				}
				$.messager.confirm('Confirm', 'Do you want to create invoice?', function(r){
					if (r){
						$.post('saveData.jsp',{'brhid':brhid,'delcharges':delcharges,'collectcharges':collectcharges,'srvcharges':srvcharges,'srvdesc':srvdesc,'contractdocno':contractdocno,'equiparray[]':equiparray,'periodupto':periodupto,'cldocno':cldocno,'contractvocno':contractvocno},function(data,status){
							data=JSON.parse(data);
							var invno=data.invvocno;
							if(data.errorstatus=="0"){
								$.messager.alert('Message','Invoice generated #'+invno,'message');
								$('#equipGrid').jqxGrid('clear');
								funreload("");
							}
							else{
								$.messager.alert('Warning','Not Saved','warning');
								return false;
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
			if(brhid=="" || brhid=="a"){
				$.messager.alert('Warning','Please select a branch','warning');
				return false;
			}
	 		var periodupto=$('#periodupto').jqxDateTimeInput('val');
			 $("#overlay, #PleaseWait").show();

	   		$("#contractdiv").load("contractGrid.jsp?brhid="+brhid+"&periodupto="+periodupto+"&id=1");
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
.filter-table div[id^="periodupto"] {
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
</head>
<body onload="getBranch();setValues();">
	<form id="frmEquipInvProcessing" action="saveEquipInvProcessing">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>

                <div class="master-container">

                    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
                    <div class="sidebar-filters">
                        <div class="sidebar-scroll-content">
                            
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Period Upto</td>
                                        <td><div id="periodupto" name="periodupto"></div></td>
                                    </tr>
                                </table>
                            </div>

                            <div class="filter-card">
                                <input type="button" name="btnupdate" id="btnupdate" value="Update" class="btn-submit">
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
                            
                            <div style="height: 15px;"></div>
                            
                            <div id="equipdiv">
                                <jsp:include page="equipGrid.jsp"></jsp:include>
                            </div>

                        </div>

                    </div>

                </div>

                <!-- Hidden Inputs Maintained Outside the Layout Flow -->
                <div style="display:none;">
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' >
                    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
                    <input type="hidden" name="docbrhid" id="docbrhid">
                </div>

			</div>
		</div>
	</form>
</body>
</html>