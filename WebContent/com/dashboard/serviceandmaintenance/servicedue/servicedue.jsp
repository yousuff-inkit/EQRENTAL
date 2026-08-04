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
    .master-container {
        display: flex;
        height: 100%;
        width: 100%;
        box-sizing: border-box;
    }
    .sidebar-filters {
        flex: 0 0 330px;
        width: 330px;
        height: 100%;
        background: #fff;
        box-sizing: border-box;
        overflow-y: auto;
    }
    .sidebar-scroll-content {
        padding: 12px;
        box-sizing: border-box;
    }
    .filter-card {
        background: #ffffff;
        border: 1px solid #e1e8ed;
        border-radius: 6px;
        padding: 12px;
        margin-bottom: 12px;
        box-sizing: border-box;
    }
    .filter-table {
        width: 100%;
        border-collapse: collapse;
    }
    .filter-table td {
        padding: 4px 6px;
        box-sizing: border-box;
    }
    .label-cell {
        font-size: 12px;
        font-weight: 600;
        color: #4e5e71;
        text-align: right;
        white-space: nowrap;
    }
    .filter-table input[type="text"],
    .filter-table select {
        width: 100%;
        height: 24px;
        padding: 2px 8px;
        border-radius: 4px;
        font-size: 12px;
        box-sizing: border-box;
    }
    .main-content-wrapper {
        flex: 1 1 auto;
        height: 100%;
        display: flex;
        flex-direction: column;
        box-sizing: border-box;
        min-width: 0;
    }
    .top-toolbar-container {
        width: 100%;
        padding: 10px 15px;
        background: #ffffff;
        border-bottom: 1px solid #e1e8ed;
        box-sizing: border-box;
        flex-shrink: 0;
    }
    .scrollable-grid-area {
        flex: 1 1 auto;
        overflow-y: auto;
        box-sizing: border-box;
        padding: 10px 15px;
    }
</style>

<script type="text/javascript">

	$(document).ready(function () {


		 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});


		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");



	});



	function inspectionSearchContent(url) {
		 $('#inspectionWindow').jqxWindow('focus');
		 $.get(url).done(function (data) {
		 $('#inspectionWindow').jqxWindow('setContent', data);
		});
		}



	function funreload(event){

		 var branchval = document.getElementById("cmbbranch").value;
		 var avgkm = document.getElementById("avgkm").value;

		 var uptodate = $('#uptodate').val();

		 if(avgkm==""){
			 $.messager.alert('Message','Please Enter Avg KM/Month','warning');
			 return 0;
		 }

		$("#overlay, #PleaseWait").show();


	          $("#servicedueDiv").load("servicedueGrid.jsp?branchval="+branchval+'&avgkm='+avgkm+'&uptodate='+uptodate);

		}



	    function funExportBtn(){
	    	var type = $('#cmbtype').val();

			   if(type==1)
			   {
				   JSONToCSVCon(summaryexceldata, 'Vehicle sale Invoice List(Summary)', true);

			   }

			   else
			   {

				   JSONToCSVCon(detailexceldata, 'Vehicle sale Invoice List(Detail)', true);

			   }
	 }

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- Sidebar filters (Bug 2: no <table> wrapper, flex: 0 0 330px) -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td align="left">
                            <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Avg KM/Month</td>
                        <td align="left">
                            <input type="text" name="avgkm" id="avgkm" value='<s:property value="avgkm"/>'>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Main content: heading.jsp moved to top toolbar (Bug 1) -->
    <div class="main-content-wrapper">
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
        <div class="scrollable-grid-area">
            <div id="servicedueDiv"><jsp:include page="servicedueGrid.jsp"></jsp:include></div>
        </div>
    </div>

</div>

</div>
</div>
</body>
</html>
