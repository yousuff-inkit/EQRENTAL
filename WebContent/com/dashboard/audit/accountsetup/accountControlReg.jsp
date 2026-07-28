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
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

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
	
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("body").prepend('<div id="overlaysub" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWaitsub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");
	 
     $('#accountWindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Account Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#accountWindow').jqxWindow('close');
	 
	 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
});

function funreload(event)
{
	var barchval = document.getElementById("cmbbranch").value;
    $("#overlaysub, #PleaseWaitsub").show();
    $("#accountControlReg").load("accountControlRegGrid.jsp?&id=1");
}
	
function getAccount(rowBoundIndex){
	$('#accountWindow').jqxWindow('open');
    accountSearch('accountsSearchGL.jsp?rowBoundIndex='+rowBoundIndex);
}
	 
function accountSearch(url) {
    $.get(url).done(function (data) {
	    $('#accountWindow').jqxWindow('setContent', data);
    }); 
}

function funExportBtn(){
	JSONToCSVCon(accountexcel, 'Accounts Setup', true);
}  

function funupdate(codename,acno){
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false)
        {
            return false; 
        }
        else{
            updatedata(codename,acno);	
        }
    });
}

function updatedata(codename,acno)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
        {
            var items=x.responseText;
            if(items==1){		
                $.messager.alert('Message', '  Record Successfully Updated ', function(r){
                    var barchval = document.getElementById("cmbbranch").value;
                    $("#overlaysub, #PleaseWaitsub").show();
                    $("#accountControlReg").load("accountControlRegGrid.jsp?&id=1");
                });
                funreload(event); 
            }
        }
	}
    x.open("GET","savedata.jsp?codename="+codename+"&acno="+acno,true);
    x.send();
}

</script>
</head>
<body onload="setval()">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <!-- Original form had no filter inputs on the left side except hidden fields -->
                <div class="filter-card" style="display: none;">
                    <table class="release-filter-table">
                        <!-- Empty placeholder to maintain structure for future additions -->
                    </table>
                </div>

                <!-- Hidden Fields -->
                <input type="hidden" name="hidocno" id="hidocno" value='<s:property value="hidocno"/>' >
                <input type="hidden" name="chkvalue" id="chkvalue" value='<s:property value="chkvalue"/>' >
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="accountControlReg"><jsp:include page="accountControlRegGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="accountWindow">
        <div></div>
    </div>

</div>
</body>
</html>