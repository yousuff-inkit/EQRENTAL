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

<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#cmbprocess').attr('disabled', true);$('#txtclientname').attr('readonly', true);$('#txtamount').attr('readonly', true);
		 $('#txtremarks').attr('readonly', true);$('#btnupdate').attr("disabled",true);
		 
	});
	
	function funreload(event){
		 $('#cmbprocess').attr('disabled', true); $('#date').val(new Date());$('#btnupdate').attr("disabled",true);
		 $('#cmbprocess').val('');$('#txtdocno').val('');$('#txtbrhid').val('');$('#txtcldocno').val('');$('#txtagreement').val('');
		 $('#txtremarks').val('');$('#txtamount').val('');$('#txtagreementno').val('');$('#txtrtype').val('');$('#txttypeid').val('');$('#txtclientname').val(''); 
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#clientRequestDiv").load("clientRequestGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&check=1');
		}
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	function funUpdate(event){
		var process = $('#cmbprocess').val();
		var docno = $('#txtdocno').val();
		var date =  $('#date').val();
		var branchid = $('#txtbrhid').val();
		var cldocno = $('#txtcldocno').val();
		var agreement = $('#txtagreement').val();
		var remarks = $('#txtremarks').val();
		var amount = $('#txtamount').val();
		var rdocno = $('#txtagreementno').val();
		var rtype = $('#txtrtype').val();
		var typeid = $('#txttypeid').val();
		
		if(process==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }
		
		if(docno==''){
			 $.messager.alert('Message','Doc No is Mandatory.','warning');
			 return 0;
		 }
		
		if(cldocno==''){
			 $.messager.alert('Message','Client is Mandatory.','warning');
			 return 0;
		 }
		
		if(amount==''){
			 $.messager.alert('Message','Amount is Mandatory.','warning');
			 return 0;
		 }
		
		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');
			 return 0;
		 }
		
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(docno,date,branchid,cldocno,agreement,remarks,amount,process,rdocno,rtype,typeid);	
		     	}
		 });
	}
	
	function saveGridData(docno,date,branchid,cldocno,agreement,remarks,amount,process,rdocno,rtype,typeid){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var process = $('#cmbprocess').val('');
				var docno = $('#txtdocno').val('');
				$('#date').val(new Date());
				var branchid = $('#txtbrhid').val('');
				var cldocno = $('#txtcldocno').val('');
				var agreement = $('#txtagreement').val('');
				var remarks = $('#txtremarks').val('');
				var amount = $('#txtamount').val('');
				var rdocno = $('#txtagreementno').val('');
				var rtype = $('#txtrtype').val('');
				var clientname = $('#txtclientname').val(''); 
				var typeid = $('#txttypeid').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?docno="+docno+"&date="+date+"&branchid="+branchid+"&cldocno="+cldocno+"&agreement="+agreement+"&remarks="+remarks+"&amount="+amount+"&process="+process+"&rdocno="+rdocno+"&rtype="+rtype+"&typeid="+typeid,true);
	x.send();
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data1, 'ClientRequest', true);
		 } else {
			 $("#clientRequest").jqxGrid('exportdata', 'xls', 'ClientRequest');
		 }
	}
	
</script>

<style>
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

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

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
    width: 70px;
}

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


.filter-table div[id^="uptodate"],
.filter-table div[id^="date"] {
    width: 100%;
}

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
    margin-top: 10px;
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}



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
<body onload="getBranch();getProcess();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td>
                            <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Process</td>
                        <td>
                            <select name="cmbprocess" id="cmbprocess" value='<s:property value="cmbprocess"/>'></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Doc No</td>
                        <td>
                            <input type="text" id="txtdocno" name="txtdocno" readonly="readonly" value='<s:property value="txtdocno"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td>
                            <div id="date" name="date" value='<s:property value="date"/>'></div>
                        </td>
                    </tr> 
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" value='<s:property value="txtclientname"/>'/>
                            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                        </td>
                    </tr> 
                    <tr>
                        <td class="label-cell">Amount</td>
                        <td>
                            <input type="text" id="txtamount" name="txtamount" style="text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamount"/>'/>
                        </td>
                    </tr> 
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td>
                            <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/>
                        </td>
                    </tr>
                </table>
                <button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button>
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="txtbrhid" id="txtbrhid" value='<s:property value="txtbrhid"/>'>
                <input type="hidden" name="txtrtype" id="txtrtype" value='<s:property value="txtrtype"/>'>
                <input type="hidden" name="txttypeid" id="txttypeid" value='<s:property value="txttypeid"/>'>
                <input type="hidden" name="txtagreement" id="txtagreement" value='<s:property value="txtagreement"/>'>
                <input type="hidden" name="txtagreementno" id="txtagreementno" value='<s:property value="txtagreementno"/>'>
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
            <div id="clientRequestDiv">
                <jsp:include page="clientRequestGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

</div> 
</div>
</body>
</html>