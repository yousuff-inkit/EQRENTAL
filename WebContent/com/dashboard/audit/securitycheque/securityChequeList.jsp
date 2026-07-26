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

/* ===== UNIFORM INPUTS & SELECTS ===== */
input[type="text"], select, textarea,
.release-filter-table input[type="text"],
.release-filter-table select,
.release-filter-table textarea {
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

.release-filter-table textarea {
    height: auto;
    resize: none;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
textarea[readonly],
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="uptodate"],
.release-filter-table div[id^="date"],
.release-filter-table div[id^="chequeDate"] {
    width: 100% !important;
}

.checkbox-group {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    cursor: pointer;
}
.checkbox-group input[type="checkbox"] {
    width: auto;
    height: auto;
    margin: 0;
    cursor: pointer;
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
		 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#chequeDate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtremarks').attr('readonly', true);$('#btnupdate').attr("disabled",true);
		 
	});
	
	function funreload(event){
		 $('#txtremarks').val('');$('#txtdocno').val('');$('#txtbrhid').val('');
		 $('#btnupdate').attr("disabled",true);
			var cmbtype= document.getElementById("cmbtype").value;	

		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = "";
		 if(document.getElementById("chktest").checked){  
		  uptodate = $('#uptodate').val();
	     }
		 $("#overlay, #PleaseWait").show();
		 
		 $("#securityChequeListDiv").load("securityChequeListGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&cmbtype='+cmbtype+'&check=1');
		}
	
	function funUpdate(event){
		var docno = $('#txtdocno').val();
		var date = $('#date').val();
		var chequeno = $('#txtchequeno').val();
		var chequedate = $('#chequeDate').val();
		var branchid = $('#txtbrhid').val();
		var remarks = $('#txtremarks').val();
		var cmbtype= $('#cmbtype').val();	
		if(docno==''){
			 $.messager.alert('Message','Please Choose a Cheque.','warning');
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
		     		 saveGridData(docno,date,chequeno,chequedate,branchid,remarks);	
		     	}
		 });
	}
	
	function saveGridData(docno,date,chequeno,chequedate,branchid,remarks) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var docno = $('#txtdocno').val('');
				var date = $('#date').val(new Date());
				var chequeno = $('#txtchequeno').val('');
				var chequedate = $('#chequeDate').val(new Date()); 
				var branchid = $('#txtbrhid').val('');
				var remarks = $('#txtremarks').val('');
				var info = $('#txtinfo').val(' ');
				
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?docno="+docno+"&date="+date+"&chequeno="+chequeno+"&chequedate="+chequedate+"&branchid="+branchid+"&remarks="+remarks,true);
	x.send();
	}

	function funExportBtn(){
		// JSONToCSVCon(data, 'Security Cheque List', true);
		$("#securityChequeListDiv").excelexportjs({  
       		containerid: "securityChequeListDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "securityChequeList", 
       		columns: getColumns("securityChequeList") , 
       		worksheetName:"Security Cheque List"
       		});
	 }
	function disable(){
		 $('#uptodate').jqxDateTimeInput("disabled",true);
	}
	
	 function intro1check(){
		 if(document.getElementById("chktest").checked){  
			 $('#uptodate').jqxDateTimeInput({ disabled: false});  
		 }
		 else{
			 $('#uptodate').jqxDateTimeInput({ disabled: true});
		 }
	 }
	
</script>
</head>
<body onload="getBranch();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                                    <option value="all">All</option>
                                    <option value="open">Open</option>
                                    <option value="closed">Closed</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <label class="checkbox-group">
                                    <input type="checkbox" id="chktest" name="chktest" onchange="intro1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
                                    Enable Date
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea id="txtinfo" name="txtinfo" readonly="readonly" style="height:80px;"><s:property value="txtinfo" /></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td>
                                <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button class="btn-submit" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Close</button>
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" id="txtchequeno" name="txtchequeno" readonly="readonly" value='<s:property value="txtchequeno"/>'/>
                    <div hidden="true" id='chequeDate' name='chequeDate' value='<s:property value="chequeDate"/>'></div>
                    <div hidden="true" id='date' name='date' value='<s:property value="date"/>'></div>
                    <input type="hidden" name="txtbrhid" id="txtbrhid" value='<s:property value="txtbrhid"/>'>
                    <input type="hidden" id="txtdocno" name="txtdocno" readonly="readonly" value='<s:property value="txtdocno"/>'/>
                    <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="securityChequeListDiv"><jsp:include page="securityChequeListGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>
</div> 
</body>
</html>