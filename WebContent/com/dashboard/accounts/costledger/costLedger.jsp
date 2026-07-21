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

form {
    height: 100%;
    width: 100%;
    margin: 0;
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

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
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
    width: 100%;
}

.radio-group, .checkbox-group {
    display: flex;
    gap: 10px;
    align-items: center;
    font-size: 12px;
    color: #333;
    padding: 2px 0;
}

.radio-group label, .checkbox-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}
.radio-group input[type="radio"], .checkbox-group input[type="checkbox"] {
    margin-right: 4px;
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

.cost-center-banner {
    padding: 10px 15px;
    background: #f8fafc;
    border-bottom: 1px solid #e1e8ed;
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
}

.cost-center-banner span {
    color: #2563eb;
    font-weight: bold;
}

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}

.summary-footer {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 10px 15px;
    background: #f8fafc;
    border-top: 1px solid #e1e8ed;
    font-size: 13px;
    font-weight: 600;
    gap: 10px;
}

.summary-footer input {
    width: 150px;
    text-align: right;
    font-weight: bold;
    color: #1e293b;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#costCodeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Cost Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeDetailsWindow').jqxWindow('close');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
		 $('#hidchckuptodate').val(0);document.getElementById("rdsummary").checked=true;
		 
		 $('#txtcostcodeid').dblclick(function(){
			  if($('#cmbcosttype').val()==''){
    			 $.messager.alert('Message','Please Choose Cost Type.','warning');
    			 return 0;
    		  }
			  costCodeSearchContent('costCodeDetailsSearch.jsp');
			});
		 
	});
	
	function costCodeSearchContent(url) {
	    $('#costCodeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeDetailsWindow').jqxWindow('setContent', data);
		$('#costCodeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getCostType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbcosttype").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getCostType.jsp", true);
		x.send();
	}
	
	function funExportBtn(){
		//JSONToCSVCon(dataExcel, 'CostLedger', true);
		if(document.getElementById("rddetailed").checked==true){
		  $("#costLedgerDetailedDiv").excelexportjs({  
       		containerid: "costLedgerDetailedDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "costLedgerDetailGridID", 
       		columns: getColumns("costLedgerDetailGridID") , 
       		worksheetName:"Detail Cost Ledger"
       		}); 
		}
		else{
			 $("#costLedgerSummaryDiv").excelexportjs({  
       		containerid: "costLedgerSummaryDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "costLedgerSummaryGridID", 
       		columns: getColumns("costLedgerSummaryGridID") , 
       		worksheetName:"Summary Cost Ledger"
       		}); 
		}
	} 
	
	function getCostCode(event){
        var x= event.keyCode;
        if(x==114){
		    if($('#cmbcosttype').val()==''){
    			 $.messager.alert('Message','Please Choose Cost Type.','warning');
    			 return 0;
    		 }
		    costCodeSearchContent('costCodeDetailsSearch.jsp');
        }
        else{}
        }
	
	
	function clearCostCodeInfo(){
		$('#txtcostcode').val('');$('#txtcostcodeid').val('');$('#txtcostcodename').val('');
		
		if (document.getElementById("txtcostcodeid").value == "") {
	        $('#txtcostcodeid').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		$("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
		$("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
	}
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var costtype = $('#cmbcosttype').val();
		 var costcode = $('#txtcostcode').val();
		 var check = 1;
		 
		if(costtype==''){
			 $.messager.alert('Message','Please Choose Cost Type.','warning');
			 return 0;
		 }
		 
		 if(costcode==''){
			 $.messager.alert('Message','Cost Code is Mandatory.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 document.getElementById("lblaccountname").innerText=$("#cmbcosttype option:selected").text().trim()+" - "+$('#txtcostcodename').val();
		 if(document.getElementById("rddetailed").checked==true){
		 	$("#costLedgerDetailedDiv").load("costLedgerDetailGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&costtype='+costtype+'&costcode='+costcode+'&check='+check);
		 } else {
			$("#costLedgerSummaryDiv").load("costLedgerSummaryGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&costtype='+costtype+'&costcode='+costcode+'&check='+check);
		 }
		 
		}
	
	function checkuptodate(){
		 if(document.getElementById("chckuptodate").checked){
			 document.getElementById("hidchckuptodate").value = 1;
			 $('#fromdate').jqxDateTimeInput({disabled: true});
			 document.getElementById("rddetailed").checked=true;
			 $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			 $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			 $("#costLedgerSummaryDiv").prop("hidden", true);$("#costLedgerDetailedDiv").prop("hidden", false);			 
			 document.getElementById("lblaccountname").innerText="";
		 }
		 else{
			 document.getElementById("hidchckuptodate").value = 0;
			 $('#fromdate').jqxDateTimeInput({disabled: false});
			 document.getElementById("rdsummary").checked=true;
			 $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			 $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			 $("#costLedgerSummaryDiv").prop("hidden", false);$("#costLedgerDetailedDiv").prop("hidden", true);
			 document.getElementById("lblaccountname").innerText="";
		 }
	 }
	
	function funCheck(a){
		  if(document.getElementById("chckuptodate").checked != false){
		 	  $('#hidchckuptodate').val(1);$('#fromdate').jqxDateTimeInput({disabled: true});
		 	  document.getElementById("rddetailed").checked=true;
		 	  $("#costLedgerSummaryDiv").prop("hidden", true);$("#costLedgerDetailedDiv").prop("hidden", false); 
		 	 $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
		 	$("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
		 	 document.getElementById("lblaccountname").innerText="";
		  }
		  else{
			  $('#hidchckuptodate').val(0);$('#fromdate').jqxDateTimeInput({disabled: false});
			  document.getElementById("rdsummary").checked=true;
			  $("#costLedgerSummaryDiv").prop("hidden", false);$("#costLedgerDetailedDiv").prop("hidden", true); 
			  $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			  $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			  document.getElementById("lblaccountname").innerText="";
		  }
	  }
	
	function radioClick(){
		 if(document.getElementById("rdsummary").checked==true) {
			 $('#hidchckuptodate').val(0);$('#fromdate').jqxDateTimeInput({disabled: false});
			  document.getElementById("chckuptodate").checked=false;
			  $("#costLedgerSummaryDiv").prop("hidden", false);$("#costLedgerDetailedDiv").prop("hidden", true);
			  $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			  $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			  document.getElementById("lblaccountname").innerText="";
		 } else if(document.getElementById("rddetailed").checked==true) {
			 $('#hidchckuptodate').val(1);$('#fromdate').jqxDateTimeInput({disabled: true});
			 document.getElementById("chckuptodate").checked=true;
			 $("#costLedgerSummaryDiv").prop("hidden", true);$("#costLedgerDetailedDiv").prop("hidden", false);
			 $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			 $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			 document.getElementById("lblaccountname").innerText="";
		 }
	}
	
</script>
</head>
<body onload="getBranch();getCostType();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <form id="frmCostLedger" action="saveCostLedger" method="post" autocomplete="off">
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">
                        
                        <div class="checkbox-group" style="margin-bottom: 10px; justify-content: flex-end;">
                            <label>
                                <input type="checkbox" id="chckuptodate" name="chckuptodate" value="" onclick="funCheck();" onchange="checkuptodate();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
                                Up To Date
                            </label>
                            <input type="hidden" id="hidchckuptodate" name="hidchckuptodate" value='<s:property value="hidchckuptodate"/>'/>
                        </div>

                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">Period</td>
                                <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To</td>
                                <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">Cost Type</td>
                                <td>
                                    <select id="cmbcosttype" name="cmbcosttype" onchange="clearCostCodeInfo();" value='<s:property value="cmbcosttype"/>'></select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Cost Code</td>
                                <td>
                                    <input type="text" id="txtcostcodeid" name="txtcostcodeid" readonly placeholder="Press F3 to Search" value='<s:property value="txtcostcodeid"/>' onkeydown="getCostCode(event);"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell"></td>
                                <td>
                                    <input type="text" id="txtcostcodename" name="txtcostcodename" readonly value='<s:property value="txtcostcodename"/>' tabindex="-1"/>
                                    <input type="hidden" id="txtcostcode" name="txtcostcode" value='<s:property value="txtcostcode"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Report Type</td>
                                <td>
                                    <div class="radio-group">
                                        <label><input type="radio" id="rdsummary" name="rdo" onclick="radioClick();" value="rdsummary">Summary</label>
                                        <label><input type="radio" id="rddetailed" name="rdo" onclick="radioClick();" value="rddetailed">Detailed</label>
                                    </div>
                                </td>
                            </tr>
                        </table>

                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="cost-center-banner">
                    Cost Center : <span name="lblaccountname" id="lblaccountname"></span>
                </div>

                <div class="grid-content-container">
                    <div id="costLedgerSummaryDiv"><jsp:include page="costLedgerSummaryGrid.jsp"></jsp:include></div>
                    <div id="costLedgerDetailedDiv" hidden="true"><jsp:include page="costLedgerDetailGrid.jsp"></jsp:include></div>
                </div>
                
                <div class="summary-footer">
                    <label>Net Amount :</label>
                    <input type="text" id="txtnetamount" name="txtnetamount" value='<s:property value="txtnetamount"/>'/>
                </div>

            </div>

        </div> 
    </form>
    
    <!-- Modals -->
    <div id="costCodeDetailsWindow">
        <div></div><div></div>
    </div>
</div> 
</body>
</html>