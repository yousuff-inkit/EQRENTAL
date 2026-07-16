<%@page import="com.controlcentre.masters.maintenancemaster.garage.ClsGarageDAO" %>
<%ClsGarageDAO cgd=new ClsGarageDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: #f5f7fa; /* Light blue gradient removed per request */
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
$(document).ready(function() {
    $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#accountWindow').jqxWindow('close');
    
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#garagedate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });  

    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#garagedate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#garagedate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    document.getElementById("formdet").innerText="Garage(GRG)";
    document.getElementById("formdetail").value="Garage";
    document.getElementById("formdetailcode").value="GRG";
    window.parent.formCode.value="GRG";
    window.parent.formName.value="Garage";
    
    var data2= '<%=cgd.getGarage()%>';
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'number'},
            {name : 'code', type: 'String'},
            {name : 'name', type: 'String'},
            {name : 'date',type:'date'},
            {name : 'type', type:'String'},
            {name : 'branch', type:'String'},
            {name : 'location', type:'String'},
            {name : 'acc_no', type:'number'},
            {name : 'description', type:'String'}
        ],
        localdata: data2,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
            
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            //alert(error);    
        }
    });

    $("#jqxGarageSearch1").jqxGrid({
        width: '100%',
        height: 310,
        source: dataAdapter,
        sortable: true,
        selectionmode: 'singlerow',
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '10%' },
            { text: 'Code', datafield: 'code', width: '50%',hidden:true },
            { text: 'Name',datafield:'name',width:'40%'},
            { text: 'Branch', datafield: 'branch', width: '20%' ,hidden:true},
            { text: 'Location', datafield: 'location', width: '20%' ,hidden:true},
            { text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
            { text: 'Acc No', datafield: 'acc_no', width: '20%' ,hidden:true},
            { text: 'Type', datafield: 'type', width: '20%' ,hidden:true},
            { text: 'Description', datafield: 'description', width:'30%'}
        ]
    });

    $('#jqxGarageSearch1').on('rowselect', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("garagecode").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "code");
        document.getElementById("garagename").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "name");
        $('#location').val($("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "location")) ;
        $('#type').val($("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "type")) ;
        document.getElementById("txtaccname").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "description");
        document.getElementById("txtaccno").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "acc_no");
        $("#garagedate").jqxDateTimeInput('val',$("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
    }); 
});

function accountSearchContent(url) {
    $('#accountWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#accountWindow').jqxWindow('setContent', data);
    }); 
}

function funSearchdblclick(){
    var url=document.URL;
    var reurl=url.split("com/");
    accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
}

function funSearchLoad(){
    changeContent('garageSearch.jsp', $('#window')); 
}

function getAcc(event){
    var x= event.keyCode;
    if(x==114){
        var url=document.URL;
        var reurl=url.split("com/");
        accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
    }
}
</script>

<script>
function getLocation() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var locItems=items[0].split(",");
            var locnoItems=items[1].split(",");
            var optionsloc = '<option value="">--Select--</option>';
            for ( var i = 0; i < locItems.length; i++) {
                optionsloc += '<option value="' + locnoItems[i] + '">' + locItems[i] + '</option>';
            }
            $("select#location").html(optionsloc);
            $('#location').val($('#hidlocation').val()) ;
        }
    }
    x.open("GET","getLocation.jsp",true);
    x.send();
}
</script>

<script type="text/javascript">
function funReadOnly(){
    $('#frmGarage input').attr('readonly', true );
    $('#frmGarage select').attr('disabled', true );
    $('#garagedate').jqxDateTimeInput({ disabled: true});
}

function funRemoveReadOnly(){
    $('#frmGarage input').attr('readonly', false );
    $('#frmGarage select').attr('disabled', false );
    $('#garagedate').jqxDateTimeInput({ disabled: false});
    $('#docno').attr('readonly', true);
    $('#txtaccname').attr('readonly', true);
}

function funFocus(){
    document.getElementById("garagecode").focus();
}

function funNotify(){
    return 1;
} 

$(function(){
    $('#frmGarage').validate({
        rules: {
            garagecode: { required:true, maxlength:2 },
            garagename:{ required:true, maxlength:25 }    	
        },
        messages: {
            garagecode:{ required:" *", maxlength:"Max 2 chars" },
            garagename:{ required:" *", maxlength:"Max 25 chars" }
        }
    });
});

function setValues() {
    $('#location').val($('#hidlocation').val()) ;
    $('#type').val($('#hidtype').val()) ;
    if($('#garagedatehidden').val()){
        $("#garagedate").jqxDateTimeInput('val', $('#garagedatehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
</script>
</head>

<body onLoad="getLocation();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmGarage" action="saveActionGarage" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Garage Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="garagedate" name="garagedate" value='<s:property value="garagedate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:120px;" />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Code</label>
                    <input type="text" name="garagecode" id="garagecode" value='<s:property value="garagecode"/>' style="width:125px;">
                    
                    <label class="lbl-right" style="width:80px;">Name</label>
                    <input type="text" name="garagename" id="garagename" value='<s:property value="garagename"/>' style="flex:1;">
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Type</label>
                    <select name="type" id="type" value='<s:property value="type"/>' style="width:125px;">
                        <option value="">--Select--</option>
                        <option value="E">External</option>
                        <option value="O">Own</option>
                    </select>
                    
                    <label class="lbl-right" style="width:80px;">Location</label>
                    <select name="location" id="location" value='<s:property value="location"/>' style="width:200px;">
                        <option>----</option>
                    </select>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Account</label>
                    <div class="input-search-container" style="width: 250px;">
                        <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" placeholder="Press F3 to Search" readonly="readonly" />
                        <svg class="magnifier-icon" onclick="$('#txtaccname').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Garage List</span>
                <div class="grid-container">
                    <div id="jqxGarageSearch1" style="border:none;"></div>
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
                <input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>'>
                <input type="hidden" name="hidlocation" id="hidlocation" value='<s:property value="hidlocation"/>'>
                <input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'>
                <input type="hidden" name="hidgaragedate" id="hidgaragedate" value='<s:property value="hidgaragedate"/>'>
            </div>

        </div>
    </form>

    <div id="accountWindow"><div></div><div></div></div>
</div>
</body>
</html>