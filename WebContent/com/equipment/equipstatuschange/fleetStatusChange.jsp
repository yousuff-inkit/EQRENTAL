<%@ taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body, html, #mainBG, .homeContent, form {
    background-color: #ffffff !important; 
    background-image: none !important; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: none !important; 
    border: none !important;
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
    background-color: #ffffff !important;
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
$(document).ready(function() {
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
	$("#fleetstatusdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
	$("#hiddate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
	$("#fleetstatustime").jqxDateTimeInput({ width: '100px', height: 24, formatString: 'HH:mm', showCalendarButton: false, value:new Date(), theme: 'energyblue' });
	$("#hidtime").jqxDateTimeInput({ width: '100px', height: 24, formatString: 'HH:mm', showCalendarButton: false, value:new Date(), theme: 'energyblue' });

    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#fleetstatusdate, #hiddate, #fleetstatustime, #hidtime").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#fleetstatusdate, #hiddate, #fleetstatustime, #hidtime").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

	getStatus();
	$('#btnEdit').attr('disabled',true);
	$('#fleetwindow').jqxWindow({ width: '60%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#fleetwindow').jqxWindow('close');
	
    $('#fleetno').dblclick(function(){
        if(document.getElementById("mode").value=="view"){
            return false;
        }
        datereset();
        $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		fleetnoSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
    });
});

function fleetnoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#fleetwindow').jqxWindow('setContent', data);
    }); 
}

function getFleet(event){
    var x= event.keyCode;
    if(x==114){
        if(document.getElementById("mode").value=="view"){
            return false;
        }
        datereset();
        $('#fleetwindow').jqxWindow('open');
        $('#fleetwindow').jqxWindow('focus');
        fleetnoSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
    }
}

function funReset(){}

function datereset(){
	$('#fleetstatusdate').jqxDateTimeInput('setDate', new Date());
    $('#fleetstatustime').jqxDateTimeInput('setDate', new Date());
}

function funFocus(){
	document.getElementById("fleetno").focus();
}

function funReadOnly(){
	$('#frmEquipStatusChange input').attr('readonly', true );
    $('#fleetstatusdate').jqxDateTimeInput({ disabled: true}); 
    $('#fleetstatustime').jqxDateTimeInput({ disabled: true}); 
    $('#frmEquipStatusChange select').attr('disabled', true );
    $('#frmEquipStatusChange textarea').attr('readonly', true );
}

function funRemoveReadOnly(){
	$('#frmEquipStatusChange input').attr('readonly', false );
    $('#fleetstatusdate').jqxDateTimeInput({ disabled: false}); 
    $('#fleetstatustime').jqxDateTimeInput({ disabled: false}); 
    $('#frmEquipStatusChange select').attr('disabled', false );
    $('#frmEquipStatusChange textarea').attr('readonly', false );
	$('#docno').attr('readonly', true);
	$('#fleetno').attr('readonly', true);
	$('#fleetname').attr('readonly', true);
	$('#currentstatus').attr('readonly', true);
	if(document.getElementById("mode").value=="A"){
		datereset();
	}
}

function getStatus() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var status = items[0].split(",");
			var statusid = items[1].split(",");
			var optionsstatus = '<option value="">--Select--</option>';
			for (var i = 0; i < status.length; i++) {
				optionsstatus += '<option value="' + statusid[i] + '">' + status[i] + '</option>';
			}
			$("select#cmbchangestatus").html(optionsstatus);
			if ($('#hidcmbchangestatus').val() != null) {
				$('#cmbchangestatus').val($('#hidcmbchangestatus').val());
			}
		}
	}
	x.open("GET", "getStatus.jsp", true);
	x.send();
}

function setValues() {
	funSetlabel();
	if($('#hidfleetstatustime').val()){
		$("#fleetstatustime").jqxDateTimeInput('val', $('#hidfleetstatustime').val());
	}
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    if ($('#hidcmbchangestatus').val() != null) {
        $('#cmbchangestatus').val($('#hidcmbchangestatus').val());
    }
}

function funNotify(){
    var temp=document.getElementById("cmbchangestatus").value;
    var statusdate= new Date($('#fleetstatusdate').jqxDateTimeInput('getDate'));
    var statustime= new Date($('#fleetstatustime').jqxDateTimeInput('getDate'));
    var hiddate=$('#hiddate').jqxDateTimeInput('getDate');
    var hidtime=$('#hidtime').jqxDateTimeInput('getDate');
    statusdate.setHours(0,0,0,0);
    hiddate.setHours(0,0,0,0);
    if(document.getElementById("cmbchangestatus").value==""){
        document.getElementById("errormsg").innerText="Select a Status";
        return 0;
    }
    if(document.getElementById("hidcurrentstatus").value==temp){
        document.getElementById("errormsg").innerText="Cannot Select Same Status";
        return 0;
    }
    if(statusdate<hiddate){
        document.getElementById("errormsg").innerText="Change Date Cannot be less than Last In Date";
        return 0;
    }
    if(statusdate-hiddate==0){
        if(statustime.getHours()<hidtime.getHours()){
            document.getElementById("errormsg").innerText="Change Time Cannot be less than Last In Time";
            return 0;	
        }
        if(statustime.getHours()==hidtime.getHours()){
            if(statustime.getMinutes()<hidtime.getMinutes()){
                document.getElementById("errormsg").innerText="Change Time Cannot be less than Last In Time";
                return 0;		
            }
        }
    }
    document.getElementById("errormsg").innerText="";
    return 1;
}

function funSearchLoad(){
    changeContent('fleetStatusSearch.jsp', $('#window')); 
}
</script>
</head>
<body onload="funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmEquipStatusChange" action="saveActionEquipStatusChange" autocomplete="off">
        <jsp:include page="../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Equipment Status Change Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="fleetstatusdate" name="fleetstatusdate" value='<s:property value="fleetstatusdate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px;">Time</label>
                    <div style="width: 100px;">
                        <div id="fleetstatustime" name="fleetstatustime" value='<s:property value="fleetstatustime"/>'></div>
                    </div>

                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:120px;" />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Equipment</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' readonly onkeydown="getFleet(event);" placeholder="Press F3">
                        <svg class="magnifier-icon" onclick="$('#fleetno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' style="flex:1;" readonly tabindex="-1" />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Current Status</label>
                    <input type="text" name="currentstatus" id="currentstatus" value='<s:property value="currentstatus"/>' style="width:150px;" readonly tabindex="-1" />
                    
                    <label class="lbl-right" style="width:120px;">Change to Status</label>
                    <select name="cmbchangestatus" id="cmbchangestatus" style="width:150px;">
                        <option value="">--Select--</option>
                    </select>
                </div>

                <div class="field-row" style="margin-bottom:0; align-items:flex-start;">
                    <label class="lbl-right" style="width:100px;">Reason</label>
                    <textarea id="reason" name="reason" style="flex:1;"><s:property value="reason"/></textarea>
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" name="hidcmbsalesman" id="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'>
                <input type="hidden" name="hidfleetstatusdate" id="hidfleetstatusdate" value='<s:property value="hidfleetstatusdate"/>'>
                <input type="hidden" name="hidfleetstatustime" id="hidfleetstatustime" value='<s:property value="hidfleetstatustime"/>'>
                <input type="hidden" name="hidcmbchangestatus" id="hidcmbchangestatus" value='<s:property value="hidcmbchangestatus"/>'>
                <input type="hidden" name="hidcurrentstatus" id="hidcurrentstatus" value='<s:property value="hidcurrentstatus"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
                <div id="hiddate" name="hiddate"></div>
                <div id="hidtime" name="hidtime"></div>
            </div>

        </div>
    </form>

    <div id="fleetwindow"><div></div></div>
</div>
</body>
</html>