<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {


	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 	
	
	  
});

function funreload(event)
{
	 var branchval = document.getElementById("cmbbranch").value;
	 $("#overlay, #PleaseWait").show();
	 $("#accidentsrepdiv").load("accidentsRepGrid.jsp?branchval="+branchval);
	
	}
	function funNotify(){
	
	    	
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		
	}
	 function funExportBtn(){
		 $("#accidentsRepGrid").jqxGrid('exportdata', 'xls', 'Damages');
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
    width: 250px; /* Kept slightly narrower since it has no active filters */
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
<form id="frmDashboardAccidentsReported" action="saveDashboardAccidentsReported">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">
            
            <!-- Kept exactly as originally provided to preserve backend functionality -->
            <div style="display:none;">
                <%-- <input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>'> --%>
                <!-- <input type="hidden" name="hidclient" id="hidclient" > -->
                <%-- <div id="Readygrid" ><jsp:include page="invnoGrid.jsp"></jsp:include></div> --%>
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
            <div id="accidentsrepdiv">
                <jsp:include page="accidentsRepGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
<div style="display:none;">
    <input type="hidden" name="gridlength" id="gridlength"  value='<s:property value="gridlength"/>'>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</div>

</div>
</div>
</form>
</body>
</html>