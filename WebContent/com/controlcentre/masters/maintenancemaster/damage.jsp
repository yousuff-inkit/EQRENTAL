<%@page import="com.controlcentre.masters.maintenancemaster.damage.ClsDamageDAO" %>
<%ClsDamageDAO cdd=new ClsDamageDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: #ffffff; /* Removed the light blue gradient per request */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #ffffff; 
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
function funSearchLoad(){
    changeContent('damageSearch.jsp', $('#window')); 
}

$(document).ready(function() {
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#damagedate").jqxDateTimeInput({
        width : '125px',
        height : 24,
        formatString : "dd.MM.yyyy",
        theme: 'energyblue'
    });
	
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#damagedate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#damagedate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    document.getElementById("formdet").innerText="Damage(DAM)";
    document.getElementById("formdetail").value="Damage";
    document.getElementById("formdetailcode").value="DAM";
    window.parent.formCode.value="DAM";
    window.parent.formName.value="Damage";
    
    var data= '<%=cdd.getDamage()  %>';
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'number' },
            {name : 'type', type: 'String'  },
            {name : 'name', type: 'String'  },
            {name : 'date',type:'String'},
            {name : 'dmg_chg', type:'number'}
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
       
    $("#jqxDamageSearch1").jqxGrid({
        width: '100%',
        height: 358,
        source: dataAdapter,
        sortable: true,
        selectionmode: 'singlerow',
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '15%' },
            { text: 'Type', datafield: 'type', width: '25%' },
            { text: 'Name', datafield: 'name', width: '60%' },
            { text: 'Charge', datafield: 'dmg_chg', width: '30%' ,hidden:true},
            { text: 'Date',datafield:'date',width:'20%' ,hidden:true} 
        ]
    });
  
    $('#jqxDamageSearch1').on('rowselect', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxDamageSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("cmbtype").value=$('#jqxDamageSearch1').jqxGrid('getcellvalue', rowindex1, "type");
        document.getElementById("name1").value=$('#jqxDamageSearch1').jqxGrid('getcellvalue', rowindex1, "name");
        $("#damagedate").jqxDateTimeInput('val',$("#jqxDamageSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
    });
});
</script>

<script type="text/javascript">
function funReadOnly(){
    $('#frmDamage input').attr('readonly', true );
    $('#frmDamage select').attr('disabled', true );
    $('#damagedate').jqxDateTimeInput({ disabled: true});
}

function funRemoveReadOnly(){
    $('#frmDamage input').attr('readonly', false );
    $('#frmDamage select').attr('disabled', false );
    $('#damagedate').jqxDateTimeInput({ disabled: false});
    $('#docno').attr('readonly', true);
}

function funFocus(){
    document.getElementById("cmbtype").focus();
}

function setValues(){
    if($('#hiddamagedate').val()){
        $("#damagedate").jqxDateTimeInput('val', $('#hiddamagedate').val());
    }
    if ($('#hidcmbtype').val() != null) {
        $('#cmbtype').val($('#hidcmbtype').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funNotify(){
    return 1;
} 

$(function(){
    $('#frmDamage').validate({
        rules: {
            cmbtype: { required:true },
            name1:{ maxlength:45 },
            dmgcharge:{ required:true, number:true }
        },
        messages: {
            cmbtype:{ required:" *" },
            name1:{ maxlength:"Max 45 chars" },
            dmgcharge:{ required:" *", number:"Only numbers allowed" }
        }
    });
});
</script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmDamage" action="saveActionDamage" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Damage Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="damagedate" name="damagedate" value='<s:property value="damagedate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" id="docno" readonly tabindex="-1" value='<s:property value="docno"/>' style="width:120px;" />
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Type</label>
                    <select name="cmbtype" id="cmbtype" style="width:125px;">
                        <option value="">--Select--</option>
                        <option value="EXT">EXT</option>
                        <option value="INT">INT</option>
                        <option value="OTH">OTH</option>
                    </select>
                    <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>

                    <label class="lbl-right" style="width:80px;">Name</label>
                    <input type="text" name="name1" id="name1" value='<s:property value="name1"/>' style="flex:1;">
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Damage List</span>
                <div class="grid-container">
                    <div id="jqxDamageSearch1" style="border:none;"></div>
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" id="hiddamagedate" name="hiddamagedate" value='<s:property value="hiddamagedate"/>'>
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
            </div>

        </div>
    </form>
</div>
</body>
</html>