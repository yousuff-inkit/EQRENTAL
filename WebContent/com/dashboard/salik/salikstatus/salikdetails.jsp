
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

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
        text-align: center;
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
    .hidden-fields {
        display: none;
    }
</style>
<script type="text/javascript">

$(document).ready(function () {
 
	$("#cmbbranch").attr('hidden',true); 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("body").prepend('<div id="suboverlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='subPleaseWait' style='display: none;position:absolute; z-index: 1;top:280px;left:100px;'><img src='../../../../icons/31load.gif'/></div>");
	
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
});

function funreload(event)
{
	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
	   {
	

 var fromdate= $("#fromdate").val();
 var todate= $("#todate").val(); 
 var chkincrecv= $("#hidchckincrecv").val(); 
	 var test ="10"; 
     	 $("#suboverlay, #subPleaseWait").show();
	  $("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&to="+todate+"&chkincrecv="+chkincrecv+"&id=1");
	//  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	   }
	
	}
	
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	//$('#gridlength').val(""); 
}

	
function funExportBtn()
{

	 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(data1, 'Salik Status', true);
		  }
		 else
		  {
			 $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Salik Status');
		  }
		
	
	
	}	
 function increcvcheck(){
	 if(document.getElementById("chckincrecv").checked){
		 document.getElementById("hidchckincrecv").value = 1;
		 
	 }
	 else{
		 document.getElementById("hidchckincrecv").value = 0;
		
	 }
} 
	
	/* function funsetaval()
	{
		  if (document.getElementById('det_chk').checked) {
		
		document.getElementById("chkdatails").value="search";
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empid');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empname');
		  }
		  else
			  {
			  document.getElementById("chkdatails").value="";
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empid');
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empname');
			  }
	}
	  */
	 
</script>
</head>
<body onload="getBranch();hiddenbrh();increcvcheck();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- Sidebar filters (Bug 2: no <table> wrapper, flex: 0 0 330px) -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <table class="filter-table">
                    <!--  <tr><td colspan="2" align="center"><label class="branch">Detail</label><input type="checkbox" id="det_chk"  name="det_chk" value="0"   onclick="funsetaval()" >
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>  -->
                    <tr>
                        <td class="label-cell">From</td>
                        <td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="checkbox" id="chckincrecv" name="chckincrecv" value="" onchange="increcvcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
                            <label class="branch">Including Received</label>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Readygrid kept in the sidebar exactly as in the source (subgrid.jsp results list
                 alongside the filters, not the main content grid) -->
            <div class="filter-card">
                <div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include></div>
            </div>

            <%--
             <div class="filter-card">
                <div id="posgrid"><jsp:include page="subposting.jsp"></jsp:include></div>
             </div>
            --%>

        </div>
    </div>

    <!-- Main content: heading.jsp moved to top toolbar (Bug 1) -->
    <div class="main-content-wrapper">
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
        <div class="scrollable-grid-area">
            <div id="fleetdiv"><jsp:include page="detailsgrid.jsp"></jsp:include></div>

            <!-- <table width="100%" id="chart">
                <tr>
                     <td width="50%">
                    <div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
                      <div id='sec1' style="width: 100%; height: 250px;"></div>
                       </td><td>  <div id='thr1' style="width: 100%; height: 250px;"></div>
                       <div id='four1' style="width: 100%; height: 250px;"></div></td></tr>
            </table> -->
        </div>
    </div>

</div>

<!-- Hidden fields pulled out of layout flow (Bug 6) -->
<div class="hidden-fields">
    <input type="hidden" id="hidchckincrecv" name="hidchckincrecv" value='<s:property value="hidchckincrecv"/>'/>
    <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
    <input type="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
    <input type="hidden" id="empname" value='<s:property value="chkdatails"/>'>
</div>

</div>
</div>

</body>
</html>
