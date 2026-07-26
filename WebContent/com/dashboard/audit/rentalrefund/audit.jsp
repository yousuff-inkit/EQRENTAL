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
});
		
	function funreload(event){
		     $('#txtdocno').val('');$('#txtsrno').val('');
			 var branchval = document.getElementById("cmbbranch").value;
			 $("#overlay, #PleaseWait").show();
			 
			 $("#auditDiv").load("auditGrid.jsp?branchval="+branchval+"&check=1");
		}
	
	function funAudit(event){
		var docno = $('#txtdocno').val();
		var srno = $('#txtsrno').val();
		var branchid = $('#txtbranchid').val();
		
		if(docno==''){
			 $.messager.alert('Message','Choose a Document.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(branchid,docno,srno);	
		     	}
		 });
	}
	
	function saveGridData(branchid,docno,srno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var branchid = $('#txtbranchid').val('');
				var docno = $('#txtdocno').val('');
				var srno = $('#txtsrno').val(''); 
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?branchid="+branchid+"&docno="+docno+"&srno="+srno,true);
	x.send();
	}
	
	function getRentalRefund(){
		var srno = $('#txtsrno').val();
		var docno = $('#txtdocno').val();
		
		if(srno==''){
			 $.messager.alert('Message','Choose a Document.','warning');
			 return 0;
		 }
		
		var url=document.URL;
		var reurl=url.split("com/");
		
		window.parent.formName.value="Rental Refund";
		window.parent.formCode.value="RRP";
		
		var detName= "Rental Refund";
		var path= "com/operations/commtransactions/rentalrefund/rentalRefundDetails.action?mode=view&txtrentalrefunddocno="+docno+"&txtsrno="+srno;
		top.addTab( detName,reurl[0]+""+path);
	}	
	
	function funExportBtn(){
		 JSONToCSVCon(data1, 'Rental-Refund Audit List', true);
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
                            <td class="label-cell">Doc No</td>
                            <td>
                                <input type="text" id="txtdocno" name="txtdocno" readonly="readonly" value='<s:property value="txtdocno"/>'/>
                                <input type="hidden" id="txtsrno" name="txtsrno" readonly="readonly" value='<s:property value="txtsrno"/>'/>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button class="btn-submit" type="button" id="btnRRP" name="btnRRP" onclick="getRentalRefund(event);">Rental Refund</button>
                        <button class="btn-submit" type="button" id="btnaudit" name="btnaudit" onclick="funAudit(event);">Audit</button>
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" name="txtbranchid" id="txtbranchid" value='<s:property value="txtbranchid"/>'>
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="auditDiv"><jsp:include page="auditGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>
</div> 
</body>
</html>