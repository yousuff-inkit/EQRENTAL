<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifAction"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
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

.modern-ui input[type="checkbox"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
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

/* Tool Buttons (Edit/Save) */
.modern-ui .tool-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 28px;
    height: 24px;
    border: 1px solid #b8c6d8;
    background-color: #E0ECF8;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.2s;
}
.modern-ui .tool-btn:hover { background-color: #c5d3e0; }
.modern-ui .tool-btn img { max-height: 16px; max-width: 16px; }

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

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }

#grouplabel {
    color: red;
    font-weight: bold;
    display: block;
    text-align: center;
    margin-bottom: 10px;
}
</style>

<script type="text/javascript">
$(document).ready(function () { 
    getTariftype();
    getcheckbox();
    setCheck();
    
    document.getElementById("grouplabel").style.display="none";
    document.getElementById("txtclient").disabled=true;
    
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#jqxTariffDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#jqxTariffFromDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#jqxTariffToDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#jqxTariffDate, #jqxTariffFromDate, #jqxTariffToDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#jqxTariffDate, #jqxTariffFromDate, #jqxTariffToDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    document.getElementById("btnTarifEdit").style.display="none";

    $('#clienttarifwindow').jqxWindow({autoOpen:false, width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#clienttarifwindow').jqxWindow('close');

	selectTarif();
    
    $('#txtclient').dblclick(function(){
        $('#clienttarifwindow').jqxWindow('open');
        $('#clienttarifwindow').jqxWindow('focus');
        clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
    });
});
    
function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clienttarifwindow').jqxWindow('setContent', data);
  	}); 
}

function getClient(event){
    var x= event.keyCode;
    if(x==114){
        $('#clienttarifwindow').jqxWindow('open');
        $('#clienttarifwindow').jqxWindow('focus');
        clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
    }
}

function selectTarif(){
    $('#frmTariffManagement select').attr('disabled',false );
    var temp=document.getElementById("cmbtariftype").value;
  	
    if(temp=="Client"){
  		$('#txtclient').attr('disabled', false );
  		$("#jqxgridtarif").jqxGrid({ disabled: false});
  		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  		if(document.getElementById("mode").value=='A'){
  	  		$("#jqxgridtarif").jqxGrid({ disabled: true});
  		}
  	} else if(temp=="Corporate"){
  		$('#txtclient').attr('disabled', false );
  		$("#jqxgridtarif").jqxGrid({ disabled: false});
  		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  		if(document.getElementById("mode").value=='A'){
  	  		$("#jqxgridtarif").jqxGrid({ disabled: true});
  		}  			
  	} else if(temp=="Weekend"){
  		document.getElementById("fieldweekday").style.display="block";
  		document.getElementById("fieldfoc").style.display="none";
  		$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  		$("#jqxgridtarif").jqxGrid({ disabled: true});
  		if(document.getElementById("mode").value=='A'){
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  		}
  	} else if(temp=="FOC"){
  		document.getElementById("fieldweekday").style.display="none";
  		document.getElementById("fieldfoc").style.display="block";
  		$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  		$("#jqxgridtarif").jqxGrid({ disabled: true});
  		if(document.getElementById("mode").value=='A'){
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  		}
  	} else {
  		$('#txtclient').attr('disabled', true );
  		$("#jqxgridtarif").jqxGrid({ disabled: false});
  		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  		if(document.getElementById("mode").value=='A'){
  	  		$("#jqxgridtarif").jqxGrid({ disabled: true});
  		}
  	}
} 

function funReset(){}
		
function funReadOnly(){
    $('#frmTariffManagement input').attr('readonly', true );
    $('#frmTariffManagement select').attr('disabled', true );
    $('#frmTariffManagement textarea').attr('readonly', true );
    $('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
    $('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
    $('#jqxTariffDate').jqxDateTimeInput({ disabled: true});
    $("#jqxgridtarif").jqxGrid({ disabled: true});
    $("#jqxgridtariffuel").jqxGrid({ disabled: true});
    $("#jqxgridtariffoc").jqxGrid({ disabled: true});
    $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    $("#jqxgridtarifgrpfinish").jqxGrid({ disabled: true});
} 
    	
function funRemoveReadOnly(){
    $('#frmTariffManagement input').attr('readonly', false );
    $('#frmTariffManagement select').attr('disabled', false );
    $('#frmTariffManagement textarea').attr('readonly', false );
    $('#jqxTariffFromDate').jqxDateTimeInput({ disabled: false});
    $('#jqxTariffToDate').jqxDateTimeInput({ disabled: false});
    $('#jqxTariffDate').jqxDateTimeInput({ disabled: false});
    $("#jqxgridtarif").jqxGrid({ disabled: false});
    $("#jqxgridtariffuel").jqxGrid({ disabled: false});
    $("#jqxgridtariffoc").jqxGrid({ disabled: false});
    $("#jqxgridtarifweekday").jqxGrid({ disabled: false});
    $("#jqxgridtarifgrpfinish").jqxGrid({ disabled: false});
    if(document.getElementById("mode").value=='A'){
        $("#divRegularTarif").load("gridRegularTarif.jsp");
        $("#divfoc").load("gridFoc.jsp");
        $("#divweekday").load("gridWeekday.jsp");
        $("#divgroup1").load("gridgroup1.jsp");
        $("#divgroup2").load("gridgroup2.jsp");
        document.getElementById("grouplabel").style.display="none";
        document.getElementById("btnTarifEdit").style.display="none";
        document.getElementById("btnTarifSave").style.display="none";
        $("#jqxTariffFromDate").jqxDateTimeInput('setDate', new Date());
        $("#jqxTariffToDate").jqxDateTimeInput('setDate', new Date());
        $("#jqxTariffDate").jqxDateTimeInput('setDate', new Date());
    }
}
    	
function funNotify(){	
    if(document.getElementById("docno").value!=''){	
    	var rows = $("#jqxgridtarif").jqxGrid('getrows');
    	$('#gridlength').val(rows.length);
    	for(var i=0 ; i < rows.length ; i++){
			newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i);
			newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+rows[i].disclevel1+"::"+rows[i].disclevel2+"::"+rows[i].disclevel3+"::"+rows[i].kmrest+"::"+rows[i].exkmrte+"::"+rows[i].oinschg);
			newTextBox.appendTo('form');
		}
    	if(document.getElementById("cmbtariftype").value=='Weekend'){
    		var rowsweekday=$("#jqxgridtarifweekday").jqxGrid('getrows');
    		var j=0;
    		for(var i=0 ; i < rowsweekday.length ; i++){
    			newTextBoxweekday = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtweekday"+i)
    			    .attr("name", "txtweekday"+i);
    			var d=new Date(rowsweekday[i].cstime);
    			var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
    			var d1=new Date(rowsweekday[i].cetime);
    			var tempendtime=d1.getHours()+":"+(d1.getMinutes()<10?'0':'') + d1.getMinutes();
    			if(typeof(rowsweekday[i].cswkday)!="undefined" && rowsweekday[i].cswkday!="" && typeof(rowsweekday[i].cstime)!="undefined" && typeof(rowsweekday[i].cstime)!="" && 
    			   typeof(rowsweekday[i].cewkday)!="undefined" && typeof(rowsweekday[i].cewkday)!="" && typeof(rowsweekday[i].cetime)!="undefined" && typeof(rowsweekday[i].cetime)!=""){
    				newTextBoxweekday.val(rowsweekday[i].cswkday+"::"+tempstarttime+"::"+rowsweekday[i].cewkday+"::"+tempendtime+"::"+rowsweekday[i].rate+"::"+rowsweekday[i].cdw+"::"+rowsweekday[i].gps+"::"+rowsweekday[i].babyseater+"::"+rowsweekday[i].cooler+"::"+rowsweekday[i].kmrest+"::"+rowsweekday[i].exkmrte+"::"+rowsweekday[i].oinschg+"::"+rowsweekday[i].ulevel1+"::"+rowsweekday[i].ulevel2+"::"+rowsweekday[i].ulevel3+"::"+rowsweekday[i].exdaychg);
    				j++;
    				newTextBoxweekday.appendTo('form');
    			}
    		}
    		$('#weekdaylength').val(j);
    	}
    	if(document.getElementById("cmbtariftype").value=='FOC'){
    		var rowsfoc=$("#jqxgridtariffoc").jqxGrid('getrows');
    		$('#foclength').val(rowsfoc.length);
    		for(var i=0 ; i < rowsfoc.length ; i++){
    			newTextBoxfoc = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtfoc"+i)
    			    .attr("name", "txtfoc"+i);
    			newTextBoxfoc.val(rowsfoc[i].minday+"::"+rowsfoc[i].foc+"::"+rowsfoc[i].rate+"::"+rowsfoc[i].cdw+"::"+rowsfoc[i].gps+"::"+rowsfoc[i].babyseater+"::"+rowsfoc[i].cooler+"::"+rowsfoc[i].kmrest+"::"+rowsfoc[i].exkmrte+"::"+rowsfoc[i].oinschg);
    			newTextBoxfoc.appendTo('form');
    		}
    	}
    		
        var a=document.getElementById("gridlength").value;
        var b=document.getElementById("weekdaylength").value;
        var c=document.getElementById("foclength").value;
        var d=document.getElementById("fuellength").value;
    }
    $('#frmTariffManagement select').attr('disabled',false);
    $('#txtclient').attr('disabled',false);
    return 1;
} 

function funChkButton() {}

function funSearchLoad(){
    changeContent('tarifSearch.jsp', $('#window')); 
}
    		
function funFocus(){
    $('#jqxTariffDate').jqxDateTimeInput('focus'); 	    		
}

function setCheck(){
    if(document.getElementById("chckdeliverychg").checked==true){
        document.getElementById("hidcheck").value=1;
    } else {
        document.getElementById("hidcheck").value=0;
    }
}

function getcheckbox(){
    if(document.getElementById("hidcheck").value==1){
        document.getElementById("chckdeliverychg").checked=true;
    } else {
        document.getElementById("chckdeliverychg").checked=false;
    }
}

function setValues(){
    document.getElementById("cmbtariftype").disabled=false;
    if(document.getElementById("cmbtariftype").value=="Weekend"){
        document.getElementById("fieldweekday").style.display="block";
        document.getElementById("fieldfoc").style.display="none";
    }
    if(document.getElementById("cmbtariftype").value=="FOC"){
        document.getElementById("fieldweekday").style.display="none";
        document.getElementById("fieldfoc").style.display="block";
    }
    if(document.getElementById("docno").value!=''){
        var temp=document.getElementById("docno").value;
        $("#divgroup2").load("gridgroup2.jsp?id="+temp);
        $("#divgroup1").load("gridgroup1.jsp?id="+temp);
    }
    if ($('#hidcmbtariftype').val() != null) {
        $('#cmbtariftype').val($('#hidcmbtariftype').val());
    }
    if ($('#hidcmbtariffor').val() != null) {
        $('#cmbtariffor').val($('#hidcmbtariffor').val());
    }
    if($('#hidjqxTariffDate').val()){
        $("#jqxTariffDate").jqxDateTimeInput('val', $('#hidjqxTariffDate').val());
    }
    if($('#hidjqxTariffFromDate').val()){
        $("#jqxTariffFromDate").jqxDateTimeInput('val', $('#hidjqxTariffFromDate').val());
    }
    if($('#hidjqxTariffToDate').val()){
        $("#jqxTariffToDate").jqxDateTimeInput('val', $('#hidjqxTariffToDate').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    
    if(document.getElementById("docno").value==''){
        document.getElementById("btnTarifEdit").style.display="none";
    }
    document.getElementById("cmbtariftype").disabled=true;
}

function funTarifEdit(){
    document.getElementById("cmbtariftype").disabled=false;
    $("#jqxgridtarifgrp").jqxGrid({ disabled:false});
    document.getElementById("insurexcess").readOnly=false;
    document.getElementById("cdwexcess").readOnly=false;
    document.getElementById("scdwexcess").readOnly=false;
    document.getElementById("securityamt").readOnly=false;
    
    if(document.getElementById("cmbtariftype").value=="Weekend"){
        $("#jqxgridtarifweekday").jqxGrid({ disabled: false});
        $("#jqxgridtariffoc").jqxGrid({ disabled:true});
        $("#jqxgridtarif").jqxGrid({ disabled: true});
        document.getElementById("btnTarifEdit").style.display="none";
        document.getElementById("btnTarifSave").style.display="block";
    } else if(document.getElementById("cmbtariftype").value=="FOC"){
        $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
        $("#jqxgridtariffoc").jqxGrid({ disabled:false});
        $("#jqxgridtarif").jqxGrid({ disabled: true});
        document.getElementById("btnTarifEdit").style.display="none";
        document.getElementById("btnTarifSave").style.display="block";
    } else {
        $("#jqxgridtariffoc").jqxGrid({ disabled: true});
        $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
        $("#jqxgridtariffuel").jqxGrid({ disabled: false});
        document.getElementById("btnTarifEdit").style.display="none";
        document.getElementById("btnTarifSave").style.display="block";
        $("#jqxgridtarif").jqxGrid({ disabled: false});
    }
    document.getElementById("cmbtariftype").disabled=true;
}  

function funTarifSave(){
    document.getElementById("cmbtariftype").disabled=false;
    if(document.getElementById("cmbtariftype").value=="Weekend"){
        var rowsweekday=$('#jqxgridtarifweekday').jqxGrid('getrows');
        if(typeof(rowsweekday[0].cswkday)=="undefined" || rowsweekday[0].cswkday==""){
            document.getElementById("errormsg").innerText="Start day is Mandatory";
            return false;
        }
        if(typeof(rowsweekday[0].cstime)=="undefined" || rowsweekday[0].cstime==""){
            document.getElementById("errormsg").innerText="Start time is Mandatory";
            return false;
        }
        if(typeof(rowsweekday[0].cewkday)=="undefined" || rowsweekday[0].cewkday==""){
            document.getElementById("errormsg").innerText="End day is Mandatory";
            return false;
        }
        if(typeof(rowsweekday[0].cetime)=="undefined" || rowsweekday[0].cetime==""){
            document.getElementById("errormsg").innerText="End time is Mandatory";
            return false;
        }
        if(typeof(rowsweekday[0].rate)=="undefined" || rowsweekday[0].rate==""){
            document.getElementById("errormsg").innerText="Tariff is Mandatory";
            return false;
        }
    }
    if(document.getElementById("docno").value!=""){
        document.getElementById("mode").value="A";
        $('#btnSave').mousedown();	 
    } else{
        $.messager.alert('Warning','Please Select a Valid Document');
        return false;
    }
    document.getElementById("cmbtariftype").disabled=true;
}

function isNumber(evt,id) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        $.messager.alert('Warning','Enter Numbers Only');
        $("#"+id+"").focus();
        return false;
    }
    return true;
}

function funPrintBtn() {
    if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
        $.messager.alert('Warning','Select a Document');
        return false;
    }
    var url=document.URL;
    var reurl=url.split("com/");
    var win= window.open(reurl[0]+"com/controlcentre/masters/tarifmgmt/tarifPrint.action?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus();  
}
		
function getTariftype(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items=items.split("***");
            var tarifitems = items[0].split(",");
            var status=items[1];				
            var optionstarif = '<option value="">--Select--</option>';
            for (var i = 0; i < tarifitems.length; i++) {
                optionstarif += '<option value="' + tarifitems[i] + '">' + tarifitems[i] + '</option>';
            }
            $("select#cmbtariftype").html(optionstarif);
            if ($('#hidcmbtariftype').val() != null) {
                $('#cmbtariftype').val($('#hidcmbtariftype').val());
            }
            document.getElementById("fieldfoc").style.display="none";
            document.getElementById("fieldweekday").style.display="none";	
        }
    }
    x.open("GET", "getTariftype.jsp", true);
    x.send();
}
</script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmTariffManagement" action="saveTariffManagement" autocomplete="off">
<script>
    window.parent.formName.value="Tariff Management";
    window.parent.formCode.value="TFM";
</script>
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    
    <!-- TOP SECTION: Tariff Management Details -->
    <div class="middle-panel">
        <span class="middle-panel-title">Tariff Management</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id='jqxTariffDate' name='jqxTariffDate' value='<s:property value="jqxTariffDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxTariffDate" name="hidjqxTariffDate" value='<s:property value="hidjqxTariffDate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Tariff Type</label>
            <select id="cmbtariftype" name="cmbtariftype" style="width:125px;" value='<s:property value="cmbtariftype"/>' onchange="selectTarif();">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbtariftype" name="hidcmbtariftype" value='<s:property value="hidcmbtariftype"/>'/>
            
            <label class="lbl-right" style="width:60px;">Client</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onkeydown="getClient(event);" placeholder="Press F3">
                <svg class="magnifier-icon" onclick="$('#txtclient').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" name="hidtxtclient" id="hidtxtclient" value='<s:property value="hidtxtclient"/>'>
            
            <label class="lbl-right" style="width:80px;">Tariff For</label>
            <select id="cmbtariffor" name="cmbtariffor" style="width:100px;" value='<s:property value="cmbtariffor"/>'>
                <option value="">--Select--</option>
                <option value="Vehicle">Vehicle</option>
            </select>
            <input type="hidden" id="hidcmbtariffor" name="hidcmbtariffor" value='<s:property value="hidcmbtariffor"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Validity From</label>
            <div style="width: 125px;">
                <div id='jqxTariffFromDate' name='jqxTariffFromDate' value='<s:property value="jqxTariffFromDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxTariffFromDate" name="hidjqxTariffFromDate" value='<s:property value="hidjqxTariffFromDate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Validity To</label>
            <div style="width: 125px;">
                <div id='jqxTariffToDate' name='jqxTariffToDate' value='<s:property value="jqxTariffToDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxTariffToDate" name="hidjqxTariffToDate" value='<s:property value="hidjqxTariffToDate"/>'/>
            
            <label style="margin-left:20px; display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                <input type="checkbox" id="chckdeliverychg" name="chckdeliverychg" onchange="setCheck();">
                Delivery Charge
            </label>
            <input type="hidden" name="hidcheck" id="hidcheck" value='<s:property value="hidcheck"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" tabindex="-1" style="width:120px;" value='<s:property value="docno"/>'/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Notes</label>
            <input type="text" id="notes" name="notes" style="flex:1;" value='<s:property value="notes"/>' />
            
            <div style="display:flex; gap:8px; margin-left:15px;">
                <button type="button" class="tool-btn" id="btnTarifEdit" title="Tarif Edit" onclick="funTarifEdit();">
                    <img alt="Tarif Edit" src="<%=contextPath%>/icons/tarifedit.png">
                </button>
                <button type="button" class="tool-btn" id="btnTarifSave" title="Tarif Save" style="display:none;" onclick="funTarifSave();">
                    <img alt="Tarif Save" src="<%=contextPath%>/icons/tarifsave.png">
                </button>
            </div>
        </div>
    </div>
    
    <label id="grouplabel"></label>

    <!-- MIDDLE SECTION: Groups and Pricing -->
    <div style="display: flex; gap: 15px;">
        <div style="flex: 2; display: flex; flex-direction: column;">
            <div id="divgroup1" style="flex:1; height: 100%;"><jsp:include page="gridgroup1.jsp"></jsp:include></div>
        </div>
        
        <div style="flex: 8; display: flex; flex-direction: column;">
            <div class="middle-panel" style="margin-bottom:15px;">
                <span class="middle-panel-title">Regular Tariff</span>
                <div id="divRegularTarif" class="grid-container">
                    <jsp:include page="gridRegularTarif.jsp"></jsp:include>
                </div>
            </div>
            
            <div class="middle-panel" id="fieldextrainsur" style="margin-bottom:15px;">
                <span class="middle-panel-title">Excess Details</span>
                <div class="field-row" style="margin-bottom:0; justify-content: space-between;">
                    <div style="display:flex; align-items:center;">
                        <label class="lbl-right" style="width:100px;">Security Amount</label>
                        <input type="text" name="securityamt" id="securityamt" style="width:80px; text-align:right;" value='<s:property value="securityamt"/>' onkeypress="javascript:return isNumber (event,id)">
                    </div>
                    <div style="display:flex; align-items:center;">
                        <label class="lbl-right" style="width:100px;">Insurance Excess</label>
                        <input type="text" name="insurexcess" id="insurexcess" style="width:80px; text-align:right;" value='<s:property value="insurexcess"/>' onkeypress="javascript:return isNumber (event,id)">
                    </div>
                    <div style="display:flex; align-items:center;">
                        <label class="lbl-right" style="width:80px;">CDW Excess</label>
                        <input type="text" name="cdwexcess" id="cdwexcess" style="width:80px; text-align:right;" value='<s:property value="cdwexcess"/>' onkeypress="javascript:return isNumber (event,id)">
                    </div>
                    <div style="display:flex; align-items:center;">
                        <label class="lbl-right" style="width:100px;">Super CDW Ex.</label>
                        <input type="text" name="scdwexcess" id="scdwexcess" style="width:80px; text-align:right;" value='<s:property value="scdwexcess"/>' onkeypress="javascript:return isNumber (event,id)">
                    </div>
                </div>
            </div>

            <div class="middle-panel" id="fieldfoc" style="display:none; margin-bottom:15px;">
                <span class="middle-panel-title">FOC Tariff</span>
                <div id="divfoc" class="grid-container">
                    <jsp:include page="gridFoc.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel" id="fieldweekday" style="display:none; margin-bottom:15px;">
                <span class="middle-panel-title">Week Day Tariff</span>
                <div id="divweekday" class="grid-container">
                    <jsp:include page="gridWeekday.jsp"></jsp:include>
                </div>
            </div>
        </div>

        <div style="flex: 2; display: flex; flex-direction: column;">
            <div id="divgroup2" style="flex:1; height: 100%;"><jsp:include page="gridgroup2.jsp"></jsp:include></div>
        </div>
    </div>


    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="delete" id="delete" value='<s:property value="delete"/>' />
        <input type="hidden" name="tempgroup" id="tempgroup" value='<s:property value="tempgroup"/>'>
        <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
        <input type="hidden" name="weekdaylength" id="weekdaylength" value='<s:property value="weekdaylength"/>'>
        <input type="hidden" name="foclength" id="foclength" value='<s:property value="foclength"/>'>
        <input type="hidden" name="fuellength" id="fuellength" value='<s:property value="fuellength"/>'>
        <input type="hidden" name="tarifmode" id="tarifmode" value='<s:property value="tarifmode"/>'>
        <input type="hidden" name="temprowindex" id="temprowindex" value='<s:property value="temprowindex"/>'> 
        <input type="hidden" name="deliverylength" id="deliverylength" value='<s:property value="deliverylength"/>'>
        <input type="hidden" name="tempdocno" id="tempdocno" value='<s:property value="tempdocno"/>'>
        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        <input type="hidden" name="tempstatus" id="tempstatus" value='<s:property value="tempstatus"/>'>
        <input type="hidden" name="conditionstatus" id="conditionstatus" value='<s:property value="conditionstatus"/>'>
        <input type="hidden" name="hidgroupdoc" id="hidgroupdoc" value='<s:property value="hidgroupdoc"/>'>
        
        <!-- Fuel Info -->
        <div id="divfuel"><jsp:include page="gridfuel.jsp"></jsp:include></div>
    </div>
    
    <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px; text-align:center;"></div>

</div>

</form>
</div>

<!-- Search Windows -->
<div id="clienttarifwindow"><div></div></div>

</body>
</html>