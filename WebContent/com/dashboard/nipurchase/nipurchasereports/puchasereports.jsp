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

/* Range Inputs */
.range-group {
    display: flex;
    align-items: center;
    gap: 4px;
}
.range-group input {
    width: 50%;
}
.range-group span {
    font-weight: bold;
    color: #4e5e71;
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
	
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

      $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#accountDetailsWindow').jqxWindow('close');
		 
	 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
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
	 
	 
     $('#acno').dblclick(function(){
		  $('#accountDetailsWindow').jqxWindow('open');
		  commenSearchContent('accountsDetailsSearch.jsp?');
	  }); 
	  
});

function getacc(event){
	 var x= event.keyCode;
	 if(x==114){
	
	  $('#accountDetailsWindow').jqxWindow('open');
	  commenSearchContent('accountsDetailsSearch.jsp?');
	 }
}   

function commenSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('open');
        $('#accountDetailsWindow').jqxWindow('setContent', data);
    }); 
} 	

function funExportBtn(){
	$("#orderlist").excelexportjs({
		containerid: "orderlist",
		datatype: 'json',
		dataset: null,
		gridId: "orderlist",
		columns: getColumns("orderlist"),
		worksheetName: "NI Purchase Report"
	});
}

function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	// out date
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	if(fromdates>todates){
        $.messager.alert('Message','To Date Less Than From Date  ','warning');   
        return false;
    } 
    else {
        var fromdocno=$("#fromdocno").val();
        var todocno=$("#todocno").val();   
        var fromamount=$("#fromamount").val();  
        var toamount=$("#toamount").val(); 
		   
        if(fromdocno!="") {
            if(todocno=="") {
                $.messager.alert('Message','Enter To Doc No ','warning');   
                return false;
            }
            else if(parseInt(todocno)<parseInt(fromdocno)) {
                $.messager.alert('Message','To Doc No Less Than From Doc No','warning');   
                return false;
            }
        }
		   
        if(fromamount!="") {
            if(toamount=="") {
                $.messager.alert('Message','Enter To Amount ','warning');   
                return false;
            }
            else if(parseFloat(toamount)<parseFloat(fromamount)) {
                $.messager.alert('Message','To Amount Less Than From Amount  ','warning');   
                return false;
            }
        }
	   
        var barchval = document.getElementById("cmbbranch").value;
        var fromdate= $("#fromdate").val();
        var todate= $("#todate").val();
        var accdocno=$("#accdocno").val(); 

        $("#overlay, #PleaseWait").show();
        $("#listdiv").load("puchasereportGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&fromdocno="
			  +fromdocno+"&todocno="+todocno+"&fromamount="+fromamount+"&toamount="+toamount+"&accdocno="+accdocno);
    }
}
	
function funClearInfo()
{
    $("#fromdocno").val('');
    $("#todocno").val('');   
    $("#fromamount").val('');  
    $("#toamount").val(''); 
    $("#accdocno").val(''); 
    $("#acno").val(''); 
    $("#accname").val(''); 
	 
    $("#fromdocno").attr('placeholder', 'From');
    $("#todocno").attr('placeholder', 'To');
    $("#fromamount").attr('placeholder', 'From');
    $("#toamount").attr('placeholder', 'To');
}
	   
function funPrint()
{
	if($('#gridindex').val()==''){
		$.messager.alert('Message','Please Select a Document','warning');
		return false;
	}
	var url=document.URL;
	var reurl=url.split("com/");
	var doc_no=$('#orderlist').jqxGrid('getcellvalue',$('#gridindex').val(),'doc_no');
	var brhid=$('#orderlist').jqxGrid('getcellvalue',$('#gridindex').val(),'brhid');
	var win= window.open(reurl[0]+"printniphs?docno="+doc_no+"&dtype=CPU&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	win.focus();
};
	
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    {
 	   $.messager.alert('Message',' Enter Numbers Only  ','warning');   
        return false;
    }
    return true;
}	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">  
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">DOC NO</td>
                            <td>
                                <div class="range-group">
                                    <input type="text" id="fromdocno" name="fromdocno" placeholder="From" value='<s:property value="fromdocno"/>' onkeypress="javascript:return isNumber (event);" />
                                    <span>-</span>
                                    <input type="text" id="todocno" name="todocno" placeholder="To" value='<s:property value="todocno"/>' onkeypress="javascript:return isNumber (event);"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Amount</td>
                            <td>
                                <div class="range-group">
                                    <input type="text" id="fromamount" name="fromamount" placeholder="From" style="text-align:right;" value='<s:property value="fromamount"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" />
                                    <span>-</span>
                                    <input type="text" id="toamount" name="toamount" placeholder="To" style="text-align:right;" value='<s:property value="toamount"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Vendor</td>
                            <td>
                                <input type="text" id="acno" name="acno" placeholder="Press F3 To search" readonly="readonly" value='<s:property value="acno"/>' tabindex="-1" onkeydown="getacc(event);"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="accname" name="accname" readonly="readonly" value='<s:property value="accname"/>' tabindex="-1"/>
                            </td>
                        </tr>
                    </table>
                    
                    <div class="release-actions">
                        <button type="button" class="btn-submit" name="nipurchaseprint" id="nipurchaseprint" onclick="funPrint();">Print</button>
                        <button type="button" class="btn-submit" name="clear" id="clear" onclick="funClearInfo();">Clear</button>
                    </div>

                    <!-- Hidden Spacers / Fields -->
                    <div id='paychaaaaa' style="width: 100%; height: 100px;"></div>
                    <input type="hidden" id="accdocno" name="accdocno" readonly="readonly" value='<s:property value="accdocno"/>' tabindex="-1"/>
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="listdiv"><jsp:include page="puchasereportGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="accountDetailsWindow">
        <div></div> 
    </div>

</div>
</body>
</html>