<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
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

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%>
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
    height: 100%;
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
.filter-table div[id^="nonrevenuedate"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit, .myButton {
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

/* ===== RIGHT CONTENT AREA ===== */
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

	 $("#nonrevenuedate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});


});


function funreload(event)
{

	 var barchval = document.getElementById("cmbbranch").value;
	 var exdate = $('#nonrevenuedate').val();

	  $("#nondiv").load("nonrevenueGrid.jsp?barchval="+barchval+'&exdate='+exdate);


	}

function funExportBtn(){
	  //$("#nonmovement").jqxGrid('exportdata', 'xls', 'Non Revenue Movement');


	  /* if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(expdatass, 'Non Revenue Movement', true);
	    }
	   else
	    {
	    $("#insexpgrid").jqxGrid('exportdata', 'xls', 'Non Revenue Movement');
	    }*/
	$("#nondiv").excelexportjs({
   		containerid: "nondiv",
   		datatype: 'json',
   		dataset: null,
   		gridId: "nonmovement",
   		columns: getColumns("nonmovement") ,
   		worksheetName:"Non Revenue Movement"
   		});

	  }



</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>

<div class="master-container">

	<div class="sidebar-filters">
		<div class="sidebar-scroll-content">

			<div class="filter-card">
				<table class="filter-table">
					<tr>
						<td class="label-cell">Up To</td>
						<td><div id="nonrevenuedate" name="nonrevenuedate" value='<s:property value="nonrevenuedate"/>'></div></td>
					</tr>
				</table>
			</div>

			<div class="filter-card">
				<div id='pieChart1' style="width: 100%; height: 170px;"></div>
			</div>

		</div>
	</div>

	<div class="main-content-wrapper">
		<div class="top-toolbar-container">
			<jsp:include page="../../heading.jsp"></jsp:include>
		</div>
		<div class="scrollable-grid-area">
			<div id="nondiv"><jsp:include page="nonrevenueGrid.jsp"></jsp:include></div>
		</div>
	</div>

</div>

</div>
</div>
</body>
</html>
