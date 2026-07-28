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
    width: 290px; 
    flex: 0 0 290px; 
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
    display: flex;
    flex-direction: column;
    gap: 12px;
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
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

.radio-group {
    display: flex;
    gap: 15px;
    align-items: center;
    font-size: 12px;
    color: #333;
    padding: 2px 0;
    justify-content: center;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-weight: 600;
}
.radio-group input[type="radio"] {
    margin-right: 4px;
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
}
</style>

<script type="text/javascript">

$(document).ready(function () {
    $("#btnExcel").click(function() {
        JSONToCSVCon(exceldata, 'Datalog Report', true);
    });
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#vehdetaildiv').hide();
    
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
    
    $('#userwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#userwindow').jqxWindow('close');
    
    $('#formwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Form Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#formwindow').jqxWindow('close');
    
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 

    $('#user').dblclick(function(){
        userSearchContent('userSearchGrid.jsp?check=1');
    });
    
    $('#form').dblclick(function(){
        if (document.getElementById('formbtn').checked){
            formSearchContent('formSearchGrid.jsp?check=1');
        }
        else if (document.getElementById('bibtn').checked){
            formSearchContent('formsearchgrid1.jsp?check=1');
        }
    });
});

function getUser(event){
    var x= event.keyCode;
    if(x==114){
        userSearchContent('userSearchGrid.jsp?check=1');
    }
}

function getForm(event){
    if (document.getElementById('formbtn').checked){
        var x= event.keyCode;
        if(x==114){
            formSearchContent('formSearchGrid.jsp?check=1');	
        }
    }
    else if (document.getElementById('bibtn').checked){
        var x= event.keyCode;
        if(x==114){
            formSearchContent('formsearchgrid1.jsp?check=1');	
        }
    }
}
    
function userSearchContent(url) {
    $('#userwindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#userwindow').jqxWindow('setContent', data);
        $('#userwindow').jqxWindow('bringToFront');
    }); 
}

function formSearchContent(url) {
    $('#formwindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#formwindow').jqxWindow('setContent', data);
        $('#formwindow').jqxWindow('bringToFront');
    }); 
}

function funreload(event)
{
    if(document.getElementById("cmbbranch").value==""){
        $.messager.alert('Warning','Please Select Branch');
        return false;
    }
    var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
    if(dateval==1){
        var branch=document.getElementById("cmbbranch").value;
        var fromdate=$('#fromdate').jqxDateTimeInput('val');
        var todate=$('#todate').jqxDateTimeInput('val');
        var hidform=document.getElementById("hidform").value;
        var hiduser=document.getElementById("hiduser").value;
        
        $("#overlay, #PleaseWait").show();
        var test ="10";
        
        if (document.getElementById('formbtn').checked){
            var formbtn=document.getElementById("formbtn").value;
            $("#Readygrid").load("subgrid.jsp?branch="+branch+"&test="+test+"&from="+fromdate+"&to="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+formbtn);
            $("#logdiv").load("datalogGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+formbtn);   	 
        }
        else if (document.getElementById('bibtn').checked){
            var bibtn=document.getElementById("bibtn").value;
            $("#Readygrid").load("subgrid.jsp?branch="+branch+"&test="+test+"&from="+fromdate+"&to="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+bibtn);
            $("#logdiv").load("datalogGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+bibtn);   	 
        }
    }
}
	
function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
        $("#overlay, #PleaseWait").hide();
    }
}

function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('#fromdate').jqxDateTimeInput('setDate',new Date());
    $('#todate').jqxDateTimeInput('setDate',new Date());
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 	
}

</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmCostUpdate" method="post" action="saveCostUpdate">
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
                        <tr>
                            <td colspan="2">
                                <div class="radio-group" style="padding-top: 5px;">
                                    <label><input type="radio" name="chk" checked="checked" id="formbtn" value="formbtn" onchange="funchkval()">Form</label>
                                    <label><input type="radio" name="chk" id="bibtn" value="bibtn" onchange="funchkval()">BI</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Form Name</td>
                            <td>
                                <input type="text" name="form" id="form" placeholder="Press F3 to Search" onKeyDown="getForm(event);" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">User</td>
                            <td>
                                <input type="text" name="user" id="user" placeholder="Press F3 to Search" onKeyDown="getUser(event);" readonly>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions" style="margin-top: 15px; border-top: 1px solid #e3e8ee; padding-top: 15px;">
                        <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                    </div>
                </div>

                <!-- Secondary Sub-Grid Container explicitly separated from pure filters -->
                <div class="filter-card" style="padding: 10px;">
                    <div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include></div>
                </div>

                <!-- Hidden inputs -->
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="hiduser" id="hiduser">
                <input type="hidden" name="hidform" id="hidform">	
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="logdiv"><jsp:include page="datalogGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="userwindow">
        <div></div><div></div>
    </div>
    <div id="formwindow">
        <div></div><div></div>
    </div>
</div>
</form>
</body>
</html>