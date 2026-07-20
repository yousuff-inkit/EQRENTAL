<%@page import="com.controlcentre.masters.vehiclemaster.category.ClsCategoryAction" %>
<%ClsCategoryAction cba=new ClsCategoryAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: #ffffff !important; /* Explicitly removed light blue background/gradient */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #ffffff !important;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: none; /* Removed shadow for a completely clean look */
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
.modern-ui select,
.modern-ui textarea { 
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

.modern-ui textarea {
    height: 48px !important; 
    resize: none;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus,
.modern-ui textarea:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled,
.modern-ui textarea[readonly] { 
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

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }
form label.error { color:red; font-weight:bold; }

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
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#date_category").jqxDateTimeInput({ width: '125px', height: 24 ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#date_category").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date_category").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    document.getElementById("formdet").innerText="Category(CAT)";
    document.getElementById("formdetail").value="Category";
    document.getElementById("formdetailcode").value="CAT";
    window.parent.formCode.value="CAT";
    window.parent.formName.value="Category";
    
    var data= '<%=cba.searchDetails() %>';
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'number' },
            {name : 'date', type: 'date'  },
            {name : 'name', type: 'String'  },
            {name : 'code', type: 'String'  },
        ],
        localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            // alert(error);    
        }
    });

    $("#jqxCategorySearch1").jqxGrid({
        width: '100%',
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        columns: [
            { text: 'Doc_No', datafield: 'doc_no', width: '10%' },
            { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
            { text: 'Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '40%' },
            { text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '40%' },
        ]
    });

    $('#jqxCategorySearch1').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxCategorySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("category").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "name");
        document.getElementById("txtcode").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "code");
        $("#date_category").jqxDateTimeInput('val', $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
    }); 
});

function funSearchLoad(){
    changeContent('categorySearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmCategory input').attr('readonly', true);
    $('#date_category').jqxDateTimeInput({readonly : true});
}

function funRemoveReadOnly() {
    $('#frmCategory input').attr('readonly', false);
    $('#date_category').jqxDateTimeInput({readonly : false});
    $('#docno').attr('readonly', true);
}

function setValues() {
    if($('#datehidden').val()){
        $("#date_category").jqxDateTimeInput('val', $('#datehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

$(function(){
    $('#frmCategory').validate({
        rules: {
            category: { required:true, maxlength:40}
        },
        messages: {
            category: {required:" *",maxlength:"max 40 only"}   
        }
    });
});

function funNotify() {
    return 1;
} 

function funFocus(){
    document.getElementById("txtcode").focus();
}

function funExcelBtn(){
    $("#jqxCategorySearch1").excelexportjs({
        containerid: "jqxCategorySearch1",
        datatype: 'json',
        dataset: null,
        gridId: "jqxCategorySearch",
        columns: getColumns("jqxCategorySearch") ,
        worksheetName:"Category Details"
    }); 
}
</script>  
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmCategory" action="saveCategory" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Category Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date_category" name="date_category"></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true" tabindex="-1" style="width:120px;">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Code</label>
                    <input type="text" name="txtcode" id="txtcode" value='<s:property value="txtcode"/>' style="width:150px;">
                    
                    <label class="lbl-right" style="width:80px;">Category</label>
                    <input type="text" name="category" id="category" value='<s:property value="category"/>' style="flex:1;">
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Category List</span>
                <div class="grid-container">
                    <div id="jqxCategorySearch1" style="border:none;"></div>  
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
            </div>

        </div>
    </form>
</div>
</body>
</html>