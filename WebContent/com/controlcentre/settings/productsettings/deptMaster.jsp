<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
 
<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">

$(document).ready(function () { 
	$('#btnSearch').attr('disabled', true);
	
	/* Formatted jqxDateTimeInput heights to match modern UI 24px */
	$("#date").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue'});
	
	/* Force internal alignment AFTER render */
    setTimeout(function () {
        $("#date").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
	 
	document.getElementById("formdet").innerText="Department Master(DPM)";
	document.getElementById("formdetail").value="Department Master";
	document.getElementById("formdetailcode").value="DPM";
	window.parent.formCode.value="DPM";
	window.parent.formName.value="Department Master";
});
	
function funFocus(){
	document.getElementById("dept").focus();
}

function funReadOnly() {
	$('#frmdept input').attr('readonly', true);
	$('#date').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly() {
	$('#frmdept input').attr('readonly', false);
	$('#date').jqxDateTimeInput({ disabled: false}); 
	$('#docno').attr('readonly', true);
}

function setValues() {
	if($('#date').val()){
		$("#date").jqxDateTimeInput('val', $('#date').val());
	}
	if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
	}
}
	    
function funNotify(){
	if(document.getElementById("dept").value==''){
		document.getElementById("errormsg").innerText="Department is Mandatory.";
		return false;
	}
	document.getElementById("errormsg").innerText="";
	return 1;
}

function funChkButton() {
	/* funReset(); */
}

</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmdept" action="savedeptAction" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <div class="middle-panel">
            <span class="middle-panel-title">Department Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:120px;" />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Department</label>
                <input type="text" name="dept" id="dept" placeholder="Department Name" value='<s:property value="dept"/>' style="width: 250px;" />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Existing Departments</span>
            <div class="grid-container">
                <div id="dptgrid"><jsp:include page="deptGrid.jsp"></jsp:include></div> 
            </div>
        </div>

        <!-- Hidden Fields -->
        <div style="display:none;">
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        </div>
        
        <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px;"></div>

    </div>
</form>
</div>
</body>
</html>