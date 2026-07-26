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

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
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

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM INPUTS & SELECTS ===== */
input[type="text"], select,
.release-filter-table input[type="text"],
.release-filter-table select {
    width: 100%;
    height: 24px;             
    padding: 2px 8px;         
    border: 1px solid #ccd6e0;
    border-radius: 4px;       
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100% !important;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* Action buttons layout */
.release-secondary-actions, .release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

.release-actions .btn-submit {
    min-width: 100px;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
.main-content-area {
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

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    gap: 15px;
}

/* ===== GRID SPECIFIC STYLES ===== */
.tax-fieldset {
    border: 1px solid #e1e8ed;
    border-radius: 8px;
    padding: 15px;
    background: #fff;
    margin: 0;
}
.tax-fieldset legend {
    font-weight: 600;
    color: #4e5e71;
    padding: 0 8px;
    font-size: 14px;
}
.net-total-container {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    margin-top: 10px;
    margin-right: 30px;
}
.net-total-container input[type="text"] {
    width: 150px;
    text-align: right;
    font-weight: bold;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    
    $('#nettotal,#totalinput,#totaloutput').val("0");
});

function funreload(event)
{
    var fromdate = $('#fromdate').jqxDateTimeInput('val');
    var todate = $('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
    $('#nettotal,#totalinput,#totaloutput').val("0");
    var nettotal = parseFloat($('#nettotal').val());
    var branch = $('#cmbbranch').val();
    funRoundAmt(nettotal,"nettotal");
    $("#vatoutputdiv").load("vatOutputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&branch="+branch);
    $("#vatinputdiv").load("vatInputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&branch="+branch);
}

function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
	
function funExportBtn(){
    $("#vatInputGrid").excelexportjs({
        containerid: "vatInputGrid",   
        datatype: 'json',
        dataset: null,
        gridId: "vatInputGrid",
        columns: getColumns("vatInputGrid") ,   
        worksheetName:"VAT Input"  
    }); 
    
    $("#vatOutputGrid").excelexportjs({
        containerid: "vatOutputGrid",   
        datatype: 'json',
        dataset: null,
        gridId: "vatOutputGrid",
        columns: getColumns("vatOutputGrid") ,   
        worksheetName:"VAT Output"  
    }); 
}
	
function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('select').find('option').prop("selected", false);
    $('#fromdate').jqxDateTimeInput('setDate',new Date());
    $('#todate').jqxDateTimeInput('setDate',new Date());
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
    $('#nettotal,#totalinput,#totaloutput').val("0");
}
	
</script>
</head>
<body onload="setValues();getBranch();">
<form id="frmReplaceList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">From Date</td>
                            <td><div id="fromdate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To Date</td>
                            <td><div id="todate"></div></td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <!-- Making the clear button visible for UX as funClearData exists -->
                        <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                        <!-- <button type="button" name="btnrepprint" id="btnrepprint" class="btn-submit" onclick="funPrintData();">Print</button> -->
                    </div>

                    <!-- Hidden Fields & Spacers -->
                    <input type="hidden" name="totalinput" id="totalinput" value='<s:property value="totalinput"/>'>
                    <input type="hidden" name="totaloutput" id="totaloutput" value='<s:property value="totaloutput"/>'>
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
                    
                    <div style="height: 250px;"></div>
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                
                <fieldset class="tax-fieldset">
                    <legend>Output Tax</legend>
                    <div id="vatoutputdiv"><jsp:include page="vatOutputGrid.jsp"></jsp:include></div>
                </fieldset>

                <fieldset class="tax-fieldset">
                    <legend>Input Tax</legend>
                    <div id="vatinputdiv"><jsp:include page="vatInputGrid.jsp"></jsp:include></div>
                </fieldset>

                <div class="net-total-container">
                    <label class="branch" style="font-weight:bold;">Net Total</label>
                    <input type="text" name="nettotal" id="nettotal" value='<s:property value="nettotal"/>' readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                </div>

            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="clientsearchwindow">
        <div></div>
    </div>
    <div id="agmtnowindow">
        <div></div>
    </div>
</div>
</form>
</body>
</html>