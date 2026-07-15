<%@page import="com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityAction" %>
<% ClsAuthorityAction ca=new ClsAuthorityAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
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

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error {
    color: red;
    font-weight: bold;
}
</style>

<script type="text/javascript">
var data= '<%=ca.searchDetails() %>';

$(document).ready(function (){   
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#authdate").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue' }); 
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#authdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#authdate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    document.getElementById("formdet").innerText="Authority(AUT)";
    document.getElementById("formdetail").value="Authority";
    document.getElementById("formdetailcode").value="AUT";
    window.parent.formName.value="Authority";
    window.parent.formCode.value="AUT";    	  
    
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'DOC_NO' , type: 'number' },
            {name : 'authname', type: 'String'  },
            {name : 'date', type: 'date'  },
            {name : 'authid',type:'String'}
        ],
        localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
          
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {}
    }); 
    
    $("#jqxAuthoritySearch1").jqxGrid({
        width: '100%',
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        sortable: true,
        altrows:true,
        columns: [
            { text: 'Doc No', filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
            { text: 'Auth Id', datafield: 'authid', width: '20%' },
            { text: 'Authority', columntype: 'textbox', filtertype: 'input', datafield: 'authname', width: '50%' },
            { text: 'Date', columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%', cellsformat:'dd.MM.yyyy' }
        ]
    });
     
    $('#jqxAuthoritySearch1').on('rowdoubleclick', function (event) { 
        var rowindex1 = event.args.rowindex;
        document.getElementById("docno").value = $('#jqxAuthoritySearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
        document.getElementById("authname").value = $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "authname");
        
        $('#authdate').jqxDateTimeInput({ disabled: false });
        $("#authdate").jqxDateTimeInput('val', $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
        document.getElementById("auth").value = $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "authid");
        $('#authdate').jqxDateTimeInput({ disabled: true });
    }); 
});
     
function funSearchLoad(){
    changeContent('authoritySearch.jsp', $('#window')); 
}

function funReadOnly(){
    $('#frmAuthority input').attr('readonly', true );
    $('#authdate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly(){
    $('#frmAuthority input').attr('readonly', false );
    $('#authdate').jqxDateTimeInput({ disabled: false});
    $('#docno').attr('readonly', true);
}

function setValues() {
    if($('#authdatehidden').val()){
        $("#authdate").jqxDateTimeInput('val', $('#authdatehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus(){
    document.getElementById("auth").focus();
}

function funNotify(){
    return 1;
}

$(function(){
    $('#frmAuthority').validate({
        rules: {
            auth: { required:true, maxlength:8 },
            authname: { required:true, maxlength:25 }
        },
        messages: {
            auth: { required:" *", maxlength:"max 8 chars" },
            authname: { required:" *", maxlength:"max 25 chars" }
        }
    });
});

function funExcelBtn(){
    $("#jqxAuthoritySearch1").jqxGrid('exportdata', 'xls', 'Authority');
}
</script>

</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAuthority" action="saveActionAuthority" autocomplete="off">     
	<jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <div class="middle-panel">
            <span class="middle-panel-title">Authority Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="authdate" name="authdate"></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <input type="text" name="docno" id="docno" readonly tabindex="-1" value='<s:property value="docno"/>' style="width:120px;" />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Authority</label>
                <input type="text" name="auth" id="auth" value='<s:property value="auth"/>' style="width: 125px;" />
                
                <label class="lbl-right" style="width:80px;">Name</label>
                <input type="text" name="authname" id="authname" value='<s:property value="authname"/>' style="flex:1;" />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Existing Authorities</span>
            <div class="grid-container">
                <div id="jqxAuthoritySearch1"></div>
            </div>
        </div>

        <!-- Hidden Fields -->
        <div style="display:none;">
            <input type="hidden" id="authdatehidden" name="authdatehidden" value='<s:property value="authdatehidden"/>'/>					
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="mode" name="mode"/>
        </div>

    </div>

</form>
</div>
</body>
</html>