<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
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
input[type="text"], select, textarea,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px;             
    padding: 2px 8px;         
    border: 1px solid #ccd6e0;
    border-radius: 4px;       
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.filter-table input[readonly],
.filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: pointer;
}

input::placeholder {
    color: #9aa4b2;
    opacity: 1;
}

/* Fieldsets & Radios */
fieldset {
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    padding: 10px;
    margin-bottom: 12px;
    background: #fff;
}

legend {
    font-size: 11px;
    font-weight: bold;
    color: #4e5e71;
    padding: 0 5px;
    text-transform: uppercase;
}

input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    cursor: pointer;
    width: 14px;
    height: 14px;
    vertical-align: middle;
}

.branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
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
    text-align: center;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* ===== RIGHT CONTENT AREA ===== */
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
    background: #fff;
}

/* Misc */
#loadsalikdata, #loadtrafficdata {
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    overflow: hidden;
    height: 100%;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $('#loadsalikdata').hide();
    $('#loadtrafficdata').hide();

    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
    
    // Uniform 24px date inputs
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
    
    $('#todate').on('change', function (event) {
        var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
        if(fromdates>todates){
            $.messager.alert('Message','To Date Less Than From Date  ','warning');   
            return false;
        }   
    });
});

function funreload(event)
{
    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
    if(fromdates>todates){
        $.messager.alert('Message','To Date Less Than From Date  ','warning');   
        return false;
    }
        
    if (!(document.getElementById('radio_salik').checked || document.getElementById('radio_traffic').checked)) {
        $.messager.alert('Message','Select Salik / Traffic','warning');
        return false;
    } else {
        var barchval = document.getElementById("cmbbranch").value;
        var fromdate= $("#fromdate").val();
        var todate= $("#todate").val();
        var satcateg;
        
        if (document.getElementById('radio_salik').checked) {
             satcateg=$("#radio_salik").val();
             $("#overlay, #PleaseWait").show();
             $("#loadsalikdata").load("invoicesalicGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg);
        } else if (document.getElementById('radio_traffic').checked) {
             satcateg=$("#radio_traffic").val();
             $("#overlay, #PleaseWait").show();
             $("#loadtrafficdata").load("invoicetrafficGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg);
        }
    }
}
 
function load(){
    $('#loadsalikdata').show();
}

function fundisable(){
    if (document.getElementById('radio_salik').checked) {
        $('#loadsalikdata').show();
        $('#loadtrafficdata').hide();
    } else if (document.getElementById('radio_traffic').checked) {
        $('#loadsalikdata').hide();
        $('#loadtrafficdata').show();
    }
}

function funExportBtn(){
    if(document.getElementById("radio_salik").checked==true){
        JSONToCSVCon(salicexcel, 'Staff Salik', true);
    } else if(document.getElementById("radio_traffic").checked==true){
        JSONToCSVCon(trafficexcel, 'Staff Traffic', true);
    }
} 
</script>
</head>
<body onload="getBranch();load();">
<div id="mainBG" class="homeContent"> 

    <div class="master-container">

        <!-- ================= LEFT SIDEBAR ================= -->
        <div class="sidebar-filters">
            
            <div class="sidebar-scroll-content">
                
                <!-- Date Range Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                        </tr>
                    </table>
                </div>

                <!-- Category Settings -->
                <div class="filter-card">
                    <fieldset>
                        <legend>Category</legend>
                        <div style="display: flex; justify-content: space-around; padding: 5px 0;">
                            <label class="branch" for="radio_salik">
                                <input type="radio" checked="checked" id="radio_salik" name="category" value="salik" onchange="fundisable();"> Salik
                            </label>
                            <label class="branch" for="radio_traffic">
                                <input type="radio" id="radio_traffic" name="category" value="radio_traffic" onchange="fundisable();"> Traffic
                            </label>
                        </div>
                    </fieldset>
                </div>

                <!-- Hidden Data -->
                <div style="display:none;">
                    <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                </div>

            </div>
        </div>

        <!-- ================= RIGHT SIDE (GRIDS) ================= -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="loadsalikdata">
                    <jsp:include page="invoicesalicGrid.jsp"></jsp:include> 
                </div>
                <div id="loadtrafficdata" style="display:none;">
                    <jsp:include page="invoicetrafficGrid.jsp"></jsp:include> 
                </div>
            </div>

        </div>

    </div>

    <!-- POPUPS -->
    <div id="accountSearchwindow"><div></div></div> 

</div>
</body>
</html>