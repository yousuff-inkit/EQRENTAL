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
.release-filter-table div[id^="uptodate"] {
    width: 100%;
}

.checkbox-group {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    font-size: 12px;
    color: #333;
    padding-bottom: 10px;
}

.checkbox-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}
.checkbox-group input[type="checkbox"] {
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

.release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
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
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		  $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
		  });
		 
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccount(event){
        var x= event.keyCode;
        if(x==114){
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        } else{}
        }
	
	function funExportBtn(){

		  $("#prepaidDiv").excelexportjs({  
		       		containerid: "prepaidDiv", 
		       		datatype: 'json', 
		       		dataset: null, 
		       		gridId: "prepaidGridID", 
		       		columns: getColumns("prepaidGridID") , 
		       		worksheetName:"Prepaid "
		       		}); 

		// JSONToCSVCon(dataExcelExport, 'Prepaid', true);
	}
	
	function funClearInfo(){

   	 	 $('#cmbbranch').val('a');$('#fromdate').val(new Date());$('#uptodate').val(new Date());$('#cmbreporttype').val('summary');
   	 	 $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');$("#prepaidGridID").jqxGrid('clear');
   		 $("#prepaidGridID").jqxGrid("addrow", null, {});document.getElementById("chckfromdate").checked=false;fromdatecheck();
   	 
   		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		
	}
	
	function fromdatecheck(){
		 if(document.getElementById("chckfromdate").checked){
			 document.getElementById("hidchckfromdate").value = 1;
			 $('#fromdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfromdate").value = 0;
			 $('#fromdate').jqxDateTimeInput({ disabled: true});
		 }
	 }
	    
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var chkfromdate = $('#hidchckfromdate').val();
		 var fromdate = $('#fromdate').val();
		 var reporttype = $('#cmbreporttype').val();
		 var accdocno = $('#txtdocno').val();

		 if(reporttype==''){
			 $.messager.alert('Message','Please Choose Report Type.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#prepaidDiv").load("prepaidGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&chkfromdate='+chkfromdate+'&fromdate='+fromdate+'&accdocno='+accdocno+'&reporttype='+reporttype+'&check=1');
		 
	}
	
</script>
</head>
<body onload="getBranch();fromdatecheck();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">

                    <div class="checkbox-group">
                        <label>
                            <input type="checkbox" id="chckfromdate" name="chckfromdate" value="" onchange="fromdatecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                            Enable From Date
                        </label>
                        <input type="hidden" id="hidchckfromdate" name="hidchckfromdate" value='<s:property value="hidchckfromdate"/>'/>
                    </div>

                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Report</td>
                            <td>
                                <select id="cmbreporttype" name="cmbreporttype" value='<s:property value="cmbreporttype"/>'>
                                    <option value="">--Select--</option>
                                    <option value="summary" selected>Summary</option>
                                    <option value="detail">Detail</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccount(event);"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" name="clear" id="clear" onclick="funClearInfo();">Clear</button>
                    </div>

                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="prepaidDiv"><jsp:include page="prepaidGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="accountDetailsWindow">
        <div></div><div></div>
    </div>

</div> 
</body>
</html>