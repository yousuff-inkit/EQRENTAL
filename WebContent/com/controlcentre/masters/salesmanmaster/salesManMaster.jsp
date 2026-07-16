<%@page import="com.controlcentre.masters.salesmanmaster.salesman.ClsSalesmanDAO" %>
<%ClsSalesmanDAO csd=new ClsSalesmanDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Salesman</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
 
<style>
/* =========================================================
SCOPED UI: Modern Layout (Master UI Standard)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui input[type="email"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui input[type="email"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Validation Label */
.modern-ui label.error,
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; margin-left: 4px; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
$(document).ready(function () {     
    /* Formatted heights to match modern UI 24px standard */
    $("#salesmandate").jqxDateTimeInput({width : '125px', height : 24, formatString : "dd.MM.yyyy"});
    
    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $("#salesmandate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#salesmandate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
	
    $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#accountWindow').jqxWindow('close');
    
    document.getElementById("formdet").innerText="Sales Man(SLM)";
    document.getElementById("formdetail").value="Sales Man";
    document.getElementById("formdetailcode").value="SLM";
    window.parent.formCode.value="SLM";
    window.parent.formName.value="Sales Man";
    
    $('#txtaccno').dblclick(function(){
        openAccountSearch();
    }); 
      		
    var data='<%=csd.searchDetails()%>';
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'int' },
            {name : 'name', type: 'String'  },
            {name : 'mail', type: 'String'  },
            {name : 'acno',type:'string'},
            {name : 'description',type:'String'},
            {name : 'mobile',type:'string'},
            {name : 'code',type:'string'},
            {name :'date',type:'date'},
            {name : 'acdoc',type:'String'},
        ],
        localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
             
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {}
    }); 
    
    $("#jqxSalesmanSearch1").jqxGrid({
        width: '100%',
        height: 310,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'singlerow',
        sortable: true,
        altrows: true,
        columns: [
            { text: 'Doc No', filtertype: 'number', datafield: 'doc_no', width: '10%' },
            { text: 'Code', datafield: 'code', width: '10%', hidden: true },
            { text: 'Date', columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%', cellsformat: 'dd.MM.yyyy' },
            { text: 'Name', datafield: 'name', width: '20%' },
            { text: 'Account', columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '30%' },
            { text: 'Account No', columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '50%', hidden: true },
            { text: 'Email', columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
            { text: 'Mobile', columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
            { text: 'Ac Doc', columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%', hidden: true },
        ]
    });

    $('#jqxSalesmanSearch1').on('rowdoubleclick', function (event) { 
        var rowindex1 = event.args.rowindex;
        document.getElementById("docno").value = $('#jqxSalesmanSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("salesmanid").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "code");
        document.getElementById("salesmanname").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "name");
        document.getElementById("salesmanmail").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "mail");
        document.getElementById("telephone").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "mobile");
        $("#salesmandate").jqxDateTimeInput('val', $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
        document.getElementById("txtaccno").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "acno");
        document.getElementById("txtaccname").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "description");
        document.getElementById("hidacno").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
    }); 
});
		 
function getAcc(event){
    var x = event.keyCode;
    if(x == 114){
        openAccountSearch();
    }
}

function openAccountSearch(){
    $('#accountWindow').jqxWindow('open');
    var url = document.URL;
    var reurl = url.split("com/");
    accountSearchContent(reurl[0] + 'com/search/accountsearch/accountsEmployee.jsp?dtype=' + document.getElementById("formdetailcode").value);
}
	
function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountWindow').jqxWindow('setContent', data);
    }); 
}
	
function funFocus(){
    document.getElementById("salesmanid").focus();
}
	
function funReadOnly() {
    $('#frmSalesman input').attr('readonly', true);
    $('#salesmandate').jqxDateTimeInput({ disabled: true}); 
}
	
function funRemoveReadOnly() {
    $('#frmSalesman input').attr('readonly', false);
    $('#salesmandate').jqxDateTimeInput({ disabled: false}); 
    $('#docno').attr('readonly', true);
    $('#txtaccno').attr('readonly', true);
    $('#txtaccname').attr('readonly', true);
}
	
function setValues() {
    if($('#hidsalesmandate').val()){
        $("#salesmandate").jqxDateTimeInput('val', $('#hidsalesmandate').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
	
$(function(){
    $('#frmSalesman').validate({
        rules: {
            salesmanid: {required:true, maxlength:4},
            salesmanname: {required:true, maxlength:40},
            txtaccname: {required:true},
            telephone: {required:true, digits:true, minlength:12, maxlength:12},
            salesmanmail: {email:true}
        },
        messages: {
            salesmanid: {required:" *", maxlength:"Max 4 Chars."},
            salesmanname: {required:" *", maxlength:"Max 40 Chars."},
            txtaccname: {required:" *"},
            telephone: {required:" *", digits:"Digits only.", minlength:"Min 12 Chars.", maxlength:'Max 12 Chars.'},
            salesmanmail: {email:"Not a valid Email."}
        }
    });
});
	    
function funNotify(){
    if(document.getElementById("txtaccno").value == ''){
        document.getElementById("errormsg").innerText = "Account is Mandatory.";
        return false;
    }
    document.getElementById("errormsg").innerText = "";
    return 1;
}
	
function funChkButton() {
    /* funReset(); */
}
		  
function funSearchLoad(){
    changeContent('salesmanSearch.jsp'); 
}

function funExcelBtn(){
    $("#jqxSalesmanSearch1").jqxGrid('exportdata', 'xls', 'Salesman');
}
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSalesman" action="saveSalesman" method="post" autocomplete="off" >
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>

        <div class="middle-panel">
            <span class="middle-panel-title">Salesman Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Date</label>
                <div style="width: 125px;">
                    <div id="salesmandate" name="salesmandate" value='<s:property value="salesmandate"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No.</label>
                <input type="text" id="docno" name="docno" style="width:125px;" value='<s:property value="docno"/>' readonly tabindex="-1">
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Code</label>
                <input type="text" name="salesmanid" id="salesmanid" style="width:125px;" placeholder="Code" value='<s:property value="salesmanid"/>' >
                
                <label class="lbl-right" style="width:80px; margin-left:15px;">Name</label>
                <input type="text" name="salesmanname" id="salesmanname" style="flex:1; max-width:300px;" placeholder="Code Name" value='<s:property value="salesmanname"/>'>
                
                <label class="lbl-right" style="width:80px; margin-left:15px;">Email</label>
                <input type="email" name="salesmanmail" id="salesmanmail" style="width:200px;" placeholder="someone@example.com" value='<s:property value="salesmanmail"/>' >
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Account</label>
                <div class="input-search-container" style="width: 125px;">
                    <input type="text" name="txtaccno" id="txtaccno" placeholder="Press F3" value='<s:property value="txtaccno"/>' onKeyDown="getAcc(event);" readonly>
                    <svg class="magnifier-icon" onclick="openAccountSearch();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" name="txtaccname" id="txtaccname" style="flex:1; max-width:300px; margin-left:10px;" value='<s:property value="txtaccname"/>' readonly>
                
                <label class="lbl-right" style="width:80px; margin-left:15px;">Mobile</label>
                <input type="text" name="telephone" id="telephone" style="width:150px;" value='<s:property value="telephone"/>'>
            </div>
        </div>

        <div class="middle-panel" style="padding-bottom: 20px;">
            <span class="middle-panel-title">Salesman List</span>
            <div id="jqxSalesmanSearch1" class="grid-container"></div>
        </div>

        <div style="display:none;">
            <input type="hidden" name="hidsalesmandate" id="hidsalesmandate" value='<s:property value="hidsalesmandate"/>'/>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="hidacno" name="hidacno" value='<s:property value="hidacno"/>'/>
        </div>

    </div>
</form>
</div>

<div id="accountWindow"><div></div><div></div></div>  

</body>
</html>