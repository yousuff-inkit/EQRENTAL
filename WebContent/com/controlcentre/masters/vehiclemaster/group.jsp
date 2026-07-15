<%@page import="com.controlcentre.masters.vehiclemaster.group.ClsGroupAction" %>
<% ClsGroupAction cga = new ClsGroupAction(); %>

<%@ taglib prefix="s" uri="/struts-tags"%>
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
$(document).ready(function() {
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#groupdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#groupdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#groupdate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    var data = '<%=cga.searchDetails() %>';
    
    document.getElementById("formdet").innerText="Group(GRP)";
    document.getElementById("formdetail").value="Group";
    document.getElementById("formdetailcode").value="GRP";
    window.parent.formCode.value="GRP";
    window.parent.formName.value="Group";
    
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'number' },
            {name : 'gid', type: 'String'  },
            {name : 'gname', type: 'String'  },
            {name : 'date', type: 'date' },
            {name : 'utype', type: 'number' },
            {name : 'level', type: 'number' }
        ],
        localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);    
        }
    });

    $("#jqxGroupSearch1").jqxGrid({
        width: '100%',
        height: 315,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        sortable: true,
        altrows:true,
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '20%' },
            { text: 'Group Name', datafield: 'gname', width: '60%' },
            { text: 'Date', datafield:'date', width:'20%', cellsformat:'dd.MM.yyyy'}
        ]
    });
    
    $('#jqxGroupSearch1').on('rowdoubleclick', function (event) { 
        var rowindex1 = event.args.rowindex;
        document.getElementById("docno").value = $('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("group").value = $('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "gid");
        document.getElementById("name").value = $('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "gname");
        document.getElementById("level").value = $('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "level");
        $("#groupdate").jqxDateTimeInput('val',$("#jqxGroupSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
        $('#utype').val($("#jqxGroupSearch1").jqxGrid('getcellvalue', rowindex1, "utype")) ;
    });
});

function funSearchLoad(){
    changeContent('groupSearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmGroup input').attr('readonly', true);
    $('#frmGroup select').attr('disabled', true);
    $('#groupdate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly() {
    $('#frmGroup input').attr('readonly', false);
    $('#frmGroup select').attr('disabled', false);
    $('#groupdate').jqxDateTimeInput({ disabled: false}); 
    $('#docno').attr('readonly', true);
}

function setValues() {
    $('#utype').val($('#utypehidden').val()) ;
    if($('#groupdatehidden').val()){
        $("#groupdate").jqxDateTimeInput('val', $('#groupdatehidden').val());	
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus(){
    document.getElementById("group").focus();
}

$(function(){
    $('#frmGroup').validate({
        rules: {
            group:{ required:true, maxlength:10 },
            name:{ maxlength:40 },
            utype:{ required:true }
        },
        messages: {
            group:{ required:" *", maxlength:"max 10 chars" },
            name:{ maxlength:"max 40 chars" },
            utype:{ required:" *" }
        }
    });
});

function funNotify(){
    return 1;
} 

function funExcelBtn(){
    $("#jqxGroupSearch1").jqxGrid('exportdata', 'xls', 'Group');
}
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmGroup" action="saveActionGroup" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <div class="middle-panel">
            <span class="middle-panel-title">Group Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="groupdate" name="groupdate"></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:120px;" />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Group</label>
                <input type="text" name="group" id="group" value='<s:property value="group"/>' style="width:125px;" />
                
                <label class="lbl-right" style="width:80px;">Name</label>
                <input type="text" name="name" id="name" value='<s:property value="name"/>' style="flex:1;" />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Existing Groups</span>
            <div class="grid-container">
                <div id="jqxGroupSearch1"></div>
            </div>
        </div>

        <!-- Hidden Fields -->
        <div style="display:none;">
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="utypehidden" name="utypehidden" value='<s:property value="utypehidden"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="groupdatehidden" name="groupdatehidden" value='<s:property value="groupdatehidden"/>'/>
            
            <!-- Kept to fulfill existing JS validation bindings -->
            <input type="hidden" name="level" id="level" value='<s:property value="level"/>'>
            <input type="hidden" name="utype" id="utype" value='<s:property value="utype"/>'>
        </div>
        
        <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px;"></div>

    </div>
</form>
</div>
</body>
</html>