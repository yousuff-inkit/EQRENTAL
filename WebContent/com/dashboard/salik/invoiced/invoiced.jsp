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

<style type="text/css">/* ===== MASTER LAYOUT ===== */
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
    width: 320px; 
    flex: 0 0 320px; 
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

/* Select specific styling */
select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Readonly fields override */
input[readonly],
input:disabled,
select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed !important;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit, .myButton, .myButtons {
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
    margin-bottom: 8px;
}

.btn-submit:hover, .myButton:hover, .myButtons:hover {
    background: #1d4ed8 !important;
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
}</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 
	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	 
	 
	   $("#btnExcel").click(function() {
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(exceldata, 'Salik-Invoiced', true);
		  }
		 else
		  {
			$("#jqxInvoiced").jqxGrid('exportdata', 'xls', 'Salik-Invoiced');
		  }
		
		
	});            
     
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
        var x= event.keyCode;
        if(x==114){
        	clientSearchContent('clientDetailsSearch.jsp');
        }
        else{}
        }
	
	function getAgreement(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#rentaltype').val()==""){
   	         $.messager.alert('Message','Choose a Type.','warning');   
   	         return false;
   	        }
        	var branchval = document.getElementById("cmbbranch").value; 
  		    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval);
        }
        else{}
        }
	
	function funSearchdblclick(){
		  $('#txtclientname').dblclick(function(){
			  clientSearchContent('clientDetailsSearch.jsp');
			});
		  
		  $('#txtagreementvoucherno').dblclick(function(){
			  if($('#rentaltype').val()==""){
			         $.messager.alert('Message','Choose a Type.','warning');   
			         return false;
			        }
			  var branchval = document.getElementById("cmbbranch").value; 
			  agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval); 
			});
	}

	function  funClearData(){
		 $('#txtclientname').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementvoucherno').val('');$('#txtagreementno').val('');$('#fromdate').val(new Date());$('#todate').val(new Date());
		
		 $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("txtagreementvoucherno").value == "") {
		        $('#txtagreementvoucherno').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function funSalikInvoicePrint(){
	        var url=document.URL;
	        var reurl=url.split("invoiced.jsp");
			var cldocno = $('#txtcldocno').val();
			 var rentaltype = $('#rentaltype').val();
			 var agmtno = $('#txtagreementno').val();
	        var win= window.open(reurl[0]+"printSalikInvoice?&branch="+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$("#todate").val()+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	   }
	
	function funreload(event){
			 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
			 var cldocno = $('#txtcldocno').val();
			 var rentaltype = $('#rentaltype').val();
			 var agmtno = $('#txtagreementno').val();
			 $("#overlay, #PleaseWait").show();
			 
			 $("#invoicedDiv").load("invoicedGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno);
	}
	
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr> 
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>
                                <option value="">--Select--</option>
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agreement</td>
                        <td>
                            <input type="text" id="txtagreementvoucherno" name="txtagreementvoucherno" readonly="readonly" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);" value='<s:property value="txtagreementvoucherno"/>'/>
                        </td>
                    </tr>
                </table>
                
                <div style="margin-top: 15px;">
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearData();">
                    <button class="btn-submit" type="button" id="btnSalikInvoicePrint" name="btnSalikInvoicePrint" onclick="funSalikInvoicePrint();">Print</button>
                </div>
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                <input type="hidden" id="txtagreementno" name="txtagreementno" value='<s:property value="txtagreementno"/>'/>
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
            <div id="invoicedDiv">
                <jsp:include page="invoicedGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout -->
<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>

</div> 
</div>
</body>
</html>