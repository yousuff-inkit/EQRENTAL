<%@page import="com.controlcentre.masters.vehiclemaster.subcategory.ClsSubcategoryAction" %>
<%ClsSubcategoryAction csa=new ClsSubcategoryAction(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
    background: #ffffff !important; 
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
    box-shadow: none; 
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
    $("#subcategorydate").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue' });  
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#subcategorydate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#subcategorydate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    document.getElementById("formdet").innerText="Sub category(SCT)";
    document.getElementById("formdetail").value="Sub category";
    document.getElementById("formdetailcode").value="SCT";
    window.parent.formCode.value="SCT";
    window.parent.formName.value="Sub category";
    
    var data= '<%=csa.searchDetails() %>';
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'int' },
            {name : 'name', type: 'String'  },
            {name : 'code', type: 'String'  },
            {name : 'date', type: 'date'  },
            {name : 'catname',type:'String'},
            {name : 'catid',type:'int'}
        ],
        localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
              
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);    
        }
    });
      
    $("#jqxSubcategorySearch1").jqxGrid({
        width: '100%',
        height: 350,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        sortable: true,
        altrows:true,
        columns: [
            { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
            { text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '10%',cellsformat:'dd.MM.yyyy'},
            { text: 'Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '30%' },
            { text: 'Subcategory',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
            { text: 'Category Id', filtertype: 'number', datafield: 'catid', width: '10%',hidden:true },
            { text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'catname', width: '20%' },
        ]
    });

    $('#jqxSubcategorySearch1').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxSubcategorySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("name").value = $("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "name");
        $('#frmSubcategory select').attr('disabled', false);
        $('#subcategorydate').jqxDateTimeInput({disabled: false});
        document.getElementById("code").value = $("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "code");
        $("#subcategorydate").jqxDateTimeInput('val',$("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
        $('#catname').val($("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "catid")) ;
        $('#frmSubcategory select').attr('disabled', true);
        $('#subcategorydate').jqxDateTimeInput({disabled: true});
    }); 
});
    
function funSearchLoad(){
    changeContent('subcategorySearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmSubcategory input').attr('readonly', true);
    $('#frmSubcategory select').attr('disabled', true);
    $('#subcategorydate').jqxDateTimeInput({disabled: true});
}

function funRemoveReadOnly() {
    $('#frmSubcategory input').attr('readonly', false);
    $('#frmSubcategory select').attr('disabled', false);
    $('#subcategorydate').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
}

function getCategory() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('***');
            var catnameItems = items[0].split(",");
            var catidItems = items[1].split(",");
            var optionscategory = '<option value="">--Select--</option>';
            for (var i = 0; i < catnameItems.length; i++) {
                optionscategory += '<option value="' + catidItems[i] + '">' + catnameItems[i] + '</option>';
            }
            $("select#catname").html(optionscategory);
            $('#catname').val($('#catid').val());
        } 
    }
    x.open("GET", "getCategory.jsp", true);
    x.send();
}
	
function funFocus(){}

$(function(){
    $('#frmSubcategory').validate({
        rules: {
            catname:{ "required":true },
            name:{ "required":true, maxlength:20 }
        },
        messages: {
            catname:{ required:" *" },
            name:{ required:" *", maxlength:"max 20 chars" }
        }
    });
});

function funNotify(){
    return 1;
} 
	     
function setValues() {
    if ($('#catid').val() != null) {
        $('#catname').val($('#catid').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
	
function funExcelBtn(){
    $("#jqxSubcategorySearch1").excelexportjs({
        containerid: "jqxSubcategorySearch1",
        datatype: 'json',
        dataset: null,
        gridId: "jqxSubcategorySearch",
        columns: getColumns("jqxSubcategorySearch") ,
        worksheetName:"Subategory Details"	
    });   
}
</script>
</head>
<body onLoad="getCategory();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmSubcategory" action="saveSubcategory" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Subcategory Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="subcategorydate" name="subcategorydate" value='<s:property value="subcategorydate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly" tabindex="-1" style="width:120px;">
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Category</label>
                    <select name="catname" id="catname" style="width:150px;"></select>
                    
                    <label class="lbl-right" style="width:80px;">Code</label>
                    <input type="text" name="code" id="code" value='<s:property value="code"/>' style="width:150px;">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Subcategory</label>
                    <input type="text" name="name" id="name" value='<s:property value="name"/>' style="flex:1;">
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Subcategory List</span>
                <div class="grid-container">
                    <div id="jqxSubcategorySearch1" style="border:none;"></div>
                </div>
            </div>

            <div style="display:none;">
                <input type="text" id="catid" name="catid" value='<s:property value="catid"/>'>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="mode" name="mode"/>
                <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>    
            </div>

        </div>
    </form>
</div>
</body>
</html>