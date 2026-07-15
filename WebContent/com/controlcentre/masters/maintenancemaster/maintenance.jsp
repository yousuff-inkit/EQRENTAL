<%@page import="com.controlcentre.masters.maintenancemaster.maintenance.ClsMaintenanceDAO"%>
<% ClsMaintenanceDAO cmd=new ClsMaintenanceDAO();%>

<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:head/>
<% String contextPath=request.getContextPath();%>
 
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
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#miandate").jqxDateTimeInput({
        width : '125px',
        height : 24,
        formatString : "dd.MM.yyyy",
        theme: 'energyblue'
    });
	
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#miandate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#miandate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    document.getElementById("formdet").innerText="Maintenance(MAT)";
    document.getElementById("formdetail").value="Maintenance";
    document.getElementById("formdetailcode").value="MAT";
    window.parent.formCode.value="MAT";
    window.parent.formName.value="Maintenance";
    
    var datas= '<%=cmd.mainserch() %>';
    var num = 0; 
    var source = {                            
        datatype: "json",
        datafields: [  
            {name : 'docno' , type: 'number' },
            {name : 'mtype', type: 'String'  },
            {name : 'name', type: 'String'  },
            {name : 'date',type:'date'}
        ],
        localdata: datas,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
            
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            //  alert(error);    
        }
    });

    $("#maintearch1").jqxGrid({
        width: '100%',
        height: 325,
        source: dataAdapter,
        sortable: true,    
        selectionmode: 'singlerow',
        columns: [
            { text: 'Doc No', datafield: 'docno', width: '15%' },
            { text: ' Maintenance Type', datafield: 'mtype', width: '35%' },
            { text: 'Description',datafield:'name',width:'50%' },
            { text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy',hidden:true }
        ]
    });
      
    $('#maintearch1').on('rowselect', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#maintearch1').jqxGrid('getcellvalue', rowindex1, "docno");
        document.getElementById("maintenancetype").value=$('#maintearch1').jqxGrid('getcellvalue', rowindex1, "mtype");
        document.getElementById("desc").value=$('#maintearch1').jqxGrid('getcellvalue', rowindex1, "name");
        $("#miandate").jqxDateTimeInput('val',$("#maintearch1").jqxGrid('getcellvalue', rowindex1, "date"));
    }); 
});
</script>

<script type="text/javascript">
function funReadOnly(){
    $('#frmmaint input').attr('readonly', true );
    $('#miandate').jqxDateTimeInput({ disabled: true}); 
}
function funRemoveReadOnly(){
    $('#frmmaint input').attr('readonly', false );
    $('#miandate').jqxDateTimeInput({ disabled: false});
    $('#docno').attr('readonly', true);
}
function funFocus(){
    document.getElementById("maintenancetype").focus();
}
function funSearchLoad(){
    changeContent('mainmasterSearch.jsp'); 
}
function funNotify(){
    $('#miandate').jqxDateTimeInput({ disabled: false});
    return 1;
} 

$(function(){
    $('#frmmaint').validate({
        rules: {
            maintenancetype: { required:true, maxlength:20 },
            desc:{ required:true, maxlength:45 }
        },
        messages: {
            maintenancetype:{ required:" * required", maxlength:"  Max 20 chars" },
            desc:{ required:" *  required", maxlength:"  Max 45 chars" }
        }
    });
});

function setValues(){
    if($('#miandatehidden').val()){
        $("#miandate").jqxDateTimeInput('val', $('#miandatehidden').val());
    }
    //$('#prevdate').val($('#prevdatehidden').val()) ;
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmmaint" action="saveMain" autocomplete="off" method="post">
        <jsp:include page="../../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Maintenance Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Date</label>
                    <div style="width: 125px;">
                        <div id="miandate" name="miandate" value='<s:property value="miandate"/>'></div>
                    </div>
                    <input type="hidden" name="miandatehidden" id="miandatehidden" value='<s:property value="miandatehidden"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>' style="width:120px;">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:120px;">Maintenance Type</label>
                    <input type="text" name="maintenancetype" id="maintenancetype" value='<s:property value="maintenancetype"/>' style="width:200px;">
                    
                    <label class="lbl-right" style="width:80px;">Description</label>
                    <input type="text" name="desc" id="desc" value='<s:property value="desc"/>' style="flex:1;">
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Maintenance List</span>
                <div class="grid-container">
                    <div id="maintearch1" style="border:none;"></div>
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" id="mode" name="mode"/>
                <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
            </div>

        </div>

    </form>
</div>
</body>
</html>