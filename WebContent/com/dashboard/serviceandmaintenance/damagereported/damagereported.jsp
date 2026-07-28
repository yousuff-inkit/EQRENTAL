
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	$('#attachmaintwindow').jqxWindow({ autoOpen: false,width: '55%', height: '50%',  maxHeight: '70%' ,maxWidth: '78%' , title: '' ,position: { x: 280, y: 120 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});   
});

function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;

	  $("#damagediv").load("damagereportedgrid.jsp?barchval="+barchval);
	  document.getElementById("fleetno").value="";
		document.getElementById("docno").value="";
		 $('#attachbtn').attr("disabled",true);	
	
	}
	
function funExportBtn(){
	   $("#damageGrid").jqxGrid('exportdata', 'xls', 'Damage Reported');
	 }
	
function funattachss(){
	
	
	  var fleetno=document.getElementById("fleetno").value;
	  var docno=document.getElementById("docno").value;
	  $("#attachmaintwindow").jqxWindow('setTitle',"VIP - "+document.getElementById("docno").value);
	  $('#attachmaintwindow').jqxWindow('setContent', '');
	  $('#attachmaintwindow').jqxWindow('open');  
	  inspSearchContent("newgrid.jsp?fleetno="+fleetno+"&docno="+docno);
	 }

function inspSearchContent(url) {
	 //$('#vehiclewindow').jqxWindow('open'); 
	 $('#attachmaintwindow').jqxWindow('focus'); 
	 $.get(url).done(function (data) {
	$('#attachmaintwindow').jqxWindow('setContent', data);
	}); 
	 
}

function findis()
{
	document.getElementById("fleetno").value="";
	document.getElementById("docno").value="";
	 $('#attachbtn').attr("disabled",true);	
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
    width: 250px; /* Kept slightly narrower since it has limited controls */
    flex: 0 0 250px; 
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

.btn-submit:disabled, .myButton:disabled {
    background: #9ca3af !important;
    color: #f3f4f6 !important;
    cursor: not-allowed;
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
<body onload="getBranch();findis()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">
            
            <div class="filter-card">
                <input type="Button" name="attachbtn" id="attachbtn" class="btn-submit" value="Attach" onclick="funattachss()">
            </div>

            <div class="filter-card">
                <div id='paychaaaaa' style="width: 100%; height: 170px;"></div>
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
            <div id="damagediv">
                <jsp:include page="damagereportedgrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Hidden Inputs & Modals Maintained Safely Outside Visual Layout -->
<input type="hidden" id="fleetno" name="fleetno">
<input type="hidden" id="docno" name="docno">

<div id="attachmaintwindow">
    <div></div>
</div> 

</div>
</div>
</body>
</html>