<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include> 

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
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#vehpurreqDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});   
    $("#vehexpDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});   
   	 
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#vehpurreqDate, #vehexpDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#vehpurreqDate, #vehexpDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
    $('#brandsearchwndow').jqxWindow('close'); 

    $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#modelsearchwndow').jqxWindow('close');
    
    $('#colorsearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: {x: 600, y: 60  }, keyboardCloseKey: 27});
    $('#colorsearchwndow').jqxWindow('close');

});

function brandinfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#brandsearchwndow').jqxWindow('open');
        $('#brandsearchwndow').jqxWindow('setContent', data);
    }); 
} 

function modelinfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#modelsearchwndow').jqxWindow('open');
        $('#modelsearchwndow').jqxWindow('setContent', data);
    }); 
} 

function colorinfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#colorsearchwndow').jqxWindow('open');
        $('#colorsearchwndow').jqxWindow('setContent', data);
    }); 
}  
          
function funReset(){}

function funReadOnly(){
    $('#frmvehpurReq input').attr('readonly', true );
    $('#frmvehpurReq textarea').attr('readonly', true );
    $('#frmvehpurReq select').attr('disabled', true);
    $('#vehpurreqDate').jqxDateTimeInput({ disabled: true});
    $('#vehexpDate').jqxDateTimeInput({ disabled: true});
    $("#purchasedetails").jqxGrid({ disabled: true});
}

function funRemoveReadOnly(){
    $('#frmvehpurReq input').attr('readonly', false );
    $('#frmvehpurReq textarea').attr('readonly', false );
    $('#frmvehpurReq select').attr('disabled', false);
    $('#vehpurreqDate').jqxDateTimeInput({ disabled: false});
    $('#vehexpDate').jqxDateTimeInput({ disabled: false});
    $("#purchasedetails").jqxGrid({ disabled: false});
    $('#docno').attr('readonly', true);
    
    if ($("#mode").val() == "A") {
        $('#vehpurreqDate').val(new Date());
        $('#vehexpDate').val(new Date());
        $("#purchasedetails").jqxGrid('clear');
        $("#purchasedetails").jqxGrid('addrow', null, {});
    }
}
	 
function funchkforedit() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();	
            if(parseInt(items)>0) {
                $("#btnEdit").attr('disabled', true );
                $("#btnDelete").attr('disabled', true ); 
            } else {
                $("#btnEdit").attr('disabled', false);
                $("#btnDelete").attr('disabled', false);
            }
        }
    }
    x.open("GET", "reqlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
    x.send();
}
	
function funNotify(){	
    if ($("#mode").val() == "A") {
        var gridval= document.getElementById("gridvalidate").value;	
        if(gridval==""){
            document.getElementById("errormsg").innerText="Brand is empty";
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";
        }
    }
    
    var rows = $("#purchasedetails").jqxGrid('getrows');
    $('#vehreqgridlenght').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "vehreqtest"+i)
            .attr("name", "vehreqtest"+i)
            .attr("hidden", "true"); 
        
        newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
            +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].qty+" :: "+rows[i].remarks+" :: ");
        newTextBox.appendTo('form');
    }   
    return 1;
} 

function funChkButton() {
    frmvehpurReq.submit();
}

function funSearchLoad(){
    changeContent('vehreqMastersearch.jsp?'); 
}

$(function(){
    $('#frmvehpurReq').validate({
        rules: { purdesc:{maxlength:200} },
        messages: { purdesc: {maxlength:" Max 200 chars"} }
    });
});
    
function funFocus(){
    $('#vehpurreqDate').jqxDateTimeInput('focus'); 	    		
}

function combochange() {
    if($('#cmbreftypeval').val()!="") {
        $('#cmbreftype').val($('#cmbreftypeval').val());
    }
}
	 
function setValues() {
    if($('#hidvehpurreqDate').val()){
        $("#vehpurreqDate").jqxDateTimeInput('val', $('#hidvehpurreqDate').val());
    }
    if($('#hidvehexpDate').val()){
        $("#vehexpDate").jqxDateTimeInput('val', $('#hidvehexpDate').val());
    }
    
    var docVal1 = document.getElementById("masterdoc_no").value;
    if(docVal1>0) {
        funchkforedit();
        var indexVal2 = document.getElementById("masterdoc_no").value;
        $("#vehpurcgasereq").load("purreqDetails.jsp?vehreqdoc="+indexVal2);
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }

    combochange();  
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
}
	
function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveequippurreq");
        $("#docno").prop("disabled", false);                
        var win= window.open(reurl[0]+"printeqPurreq?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmvehpurReq" action="saveequippurreq" autocomplete="OFF" >
<jsp:include page="../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Equipment Purchase Request</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id='vehpurreqDate' name='vehpurreqDate' value='<s:property value="vehpurreqDate"/>'></div>
            </div>
            <input type="hidden" id="hidvehpurreqDate" name="hidvehpurreqDate" value='<s:property value="hidvehpurreqDate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Type</label>
            <select id="cmbreftype" name="cmbreftype" style="width:125px;" value='<s:property value="cmbreftype"/>' onchange="fundisrefno();">
                <option value="Fleet">Fleet</option>
                <option value="Lease">Lease</option>
            </select>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' style="width:120px;" readonly />
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Exp. Delivery</label>
            <div style="width: 125px;">
                <div id='vehexpDate' name='vehexpDate' value='<s:property value="vehexpDate"/>'></div>
            </div>
            <input type="hidden" id="hidvehexpDate" name="hidvehexpDate" value='<s:property value="hidvehexpDate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="purdesc" name="purdesc" style="flex:1;" value='<s:property value="purdesc"/>'/>
        </div>
    </div>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Request Details</span>
        <div id="vehpurcgasereq" class="grid-container">
            <jsp:include page="purreqDetails.jsp"></jsp:include>
        </div>
    </div>
 
    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="cmbreftypeval" name="cmbreftypeval" value='<s:property value="cmbreftypeval"/>'/>
        <input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  
        <input type="hidden" name="vehreqgridlenght" id="vehreqgridlenght" value='<s:property value="vehreqgridlenght"/>' />  
        <input type="hidden" name="gridvalidate" id="gridvalidate" value='<s:property value="gridvalidate"/>' />  
    </div>
    
    <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px; text-align:center;"></div>

</div>
</form>

<!-- Search Windows -->
<div id="colorsearchwndow"><div></div></div>
<div id="modelsearchwndow"><div></div></div>
<div id="brandsearchwndow"><div></div></div>

</div>
</body>
</html>