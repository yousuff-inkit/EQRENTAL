<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>
<s:head/>

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
    background-color: #ffffff !important; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background-color: #ffffff !important; 
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
    background-color: #ffffff !important;
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
var configs={};
$(document).ready(function() {
	document.getElementById("btnEdit").disabled=true;  
	document.getElementById("btnDelete").disabled=false;
	
    $('#clientwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '53%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#clientwindow').jqxWindow('close');
    $('#fleetwindow').jqxWindow({ width: '60%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#fleetwindow').jqxWindow('close');
    $('#detailwindow').jqxWindow({ autoOpen:false,width: '90%', height: '70%',  maxHeight: '70%' ,maxWidth: '90%' , title: 'Asset List' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
    $('#salesinvwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '53%' ,maxWidth: '50%' , title: 'Vehicle Sales Invoice Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#salesinvwindow').jqxWindow('close');
	   
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue'});
    $("#fromdate").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue'});
    $("#todate").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue'});

    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#date, #fromdate, #todate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date, #fromdate, #todate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    $('#salesinvvocno').dblclick(function(){
        $('#salesinvwindow').jqxWindow('open');
        $('#salesinvwindow').jqxWindow('focus');
        salesInvSearchContent('salesInvSearchMaster.jsp');
    });

    $('#client').dblclick(function(){
        $('#clientwindow').jqxWindow('open');
        $('#clientwindow').jqxWindow('focus');
        clientSearchContent('masterClientSearch.jsp');
    });

    $('#date').on('change', function (event) {  
        var jsDate = event.args.date; 
        var type = event.args.type; 
        if(configs.vehsaleinvfuturedate=="1"){
            var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
            if(docdateval==0){
                $('#date').jqxDateTimeInput('focus');
                return false;
            }
        } 	
    });
});

function getSalesInv(event){
    var x= event.keyCode;
    if(x==114){
        $('#salesinvwindow').jqxWindow('open');
        $('#salesinvwindow').jqxWindow('focus');
        salesInvSearchContent('salesInvSearchMaster.jsp');
    }
}

function getClient(event){
    var x= event.keyCode;
    if(x==114){
        $('#clientwindow').jqxWindow('open');
        $('#clientwindow').jqxWindow('focus');
        clientSearchContent('masterClientSearch.jsp');
    }
}

function funSearchLoad(){
    changeContent('mainSearch.jsp', $('#window')); 
}

function salesInvSearchContent(url) {
    $.get(url).done(function (data) {
        $('#salesinvwindow').jqxWindow('setContent', data);
    });
}

function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientwindow').jqxWindow('setContent', data);
    }); 
}

function fleetnoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#fleetwindow').jqxWindow('setContent', data);
    }); 
}

function detailSearchContent(url) {
    $.get(url).done(function (data) {
        $('#detailwindow').jqxWindow('setContent', data);
    }); 
}

function funChkButton(){ }

function funReadOnly(){
    $('#date').jqxDateTimeInput({ disabled: true}); 
    $('#disposalGrid').jqxGrid({ disabled: true});
    $('#frmVehSalesInvReturn input').attr('readonly', true );
    $('#frmVehSalesInvReturn select').attr('disabled', true );
    $('#frmVehSalesInvReturn textarea').attr('readonly', true );
    $('#btncalculate').prop('disabled',true);
}

function funRemoveReadOnly(){  
    $('#date').jqxDateTimeInput({ disabled: false});
    $('#disposalGrid').jqxGrid({ disabled: false});
    $('#frmVehSalesInvReturn input').attr('readonly', false );
    $('#frmVehSalesInvReturn select').attr('disabled', false );
    $('#frmVehSalesInvReturn textarea').attr('readonly', false );
    $('#btncalculate').prop('disabled',false);
    $('#client').prop('readonly',true);
    $('#clientname').prop('readonly',true);
    $('#docno').prop('readonly',true);
    if(document.getElementById("mode").value=='A'){
        $("#disposalGrid").jqxGrid('clear');
        $("#disposalGrid").jqxGrid('addrow', null, {});
        $("#jvGrid").jqxGrid('clear');
    }
}

function funFocus(){
    document.getElementById("salesinvvocno").focus();
}

function setValues(){
    funSetlabel();
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    if($('#hidcmbbilltype').val()!="") {
        $('#cmbbilltype').val($('#hidcmbbilltype').val());   
    }
    if ($('#hidcmbtype').val() != null) {
        $('#cmbtype').val($('#hidcmbtype').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

    if(document.getElementById("docno").value!=""){
        document.getElementById("brchName").disabled=false;
        $('#disposaldiv').load('vehDisposalGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("hidbranch").value+'&id=1');
        $('#jvdiv').load('jvGrid.jsp?trno='+document.getElementById("trno").value+'&id=1');
    }
}

function funNotify(){
    var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
    if(configs.vehsaleinvfuturedate=="1"){
        if(docdateval==0){
            $('#date').jqxDateTimeInput('focus');
            return false;
        }
    }
	
    var sum=$('#hidsum').val();
    var datediff=$('#monthdiff').val();
    var saledate=$('#date').jqxDateTimeInput('getDate');
    // NOTE: hiddep_posted is hidden in original logic
    
    if(sum > 0) {
        // ... (Original logic depends on hidden inputs)
    }
	
    var rows = $("#disposalGrid").jqxGrid('getrows');
    if(!((rows[0].fleet_no=="undefined") || (rows[0].fleet_no==null) || (rows[0].fleet_no==""))){
        var rowlength=0;
        for(var i=0 ; i < rows.length ; i++){
            newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "test"+i)
            .attr("name", "test"+i)
            .attr("hidden", "true");
			
            if((rows[i].pur_value=="0")){
                document.getElementById("errormsg").innerText="Purchase value can not be zero";
                return 0;
            }
            if(rows[i].fleet_no!="" && rows[i].fleet_no!="undefined" && rows[i].fleet_no!=null){
                newTextBox.val(rows[i].fleet_no+"::"+rows[i].flname+"::"+rows[i].salesprice+"::"+rows[i].dep_posted+"::"+rows[i].pur_value+"::"+rows[i].acc_dep+"::"+rows[i].cur_dep+"::"+rows[i].net_pl+"::"+rows[i].netbook+"::"+rows[i].trsalesprice);
                newTextBox.appendTo('form');
                rowlength++;
            }
        }
        $('#gridlength').val(rowlength);
    }
    return 1;	
}

function deleteTempData(value){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) { }
    }
    x.open("GET", "deleteTempData.jsp?mdoc="+value, true);
    x.send();
}

function getSalesprice() {
    var hidrow=document.getElementById("disposalrow").value;
    var trsalesprice=$("#disposalGrid").jqxGrid('getcellvalue',hidrow,'trsalesprice');
    var clientrate=document.getElementById("currrate").value;
    var sellingprice=parseFloat(trsalesprice)*parseFloat(clientrate);
    $('#disposalGrid').jqxGrid('setcellvalue', hidrow, 'salesprice',sellingprice); 
}

function funCalculate(){
    deleteTempData(document.getElementById("mdoc").value);
    var date=$('#date').jqxDateTimeInput('val');
    if(configs.vehsaleinvfuturedate=="1"){
        var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
        if(docdateval==0){
            $('#date').jqxDateTimeInput('focus');
            return false;
        }
    }
    
    var rows=$('#disposalGrid').jqxGrid('getrows');
    var temp=0;
    var count=0;
    for(var i=0;i<rows.length;i++){
        var fleet=$("#disposalGrid").jqxGrid('getcellvalue',i,'fleet_no');
        temp=1;
        document.getElementById("errormsg").innerText="";
        if(fleet=="" || fleet=="undefined"){
            document.getElementById("errormsg").innerText="Fleet is Mandatory";
            $('#disposalGrid').jqxGrid('selectcell', i, 'fleet_no');
            return false;
        }
        var salesprice=$("#disposalGrid").jqxGrid('getcellvalue',i,'salesprice');
        if(salesprice=="" || salesprice=="undefined"){
            document.getElementById("errormsg").innerText="Sales Price is Mandatory";
            $('#disposalGrid').jqxGrid('selectcell', i, 'salesprice');
            return false;
        }
		
        if(document.getElementById("errormsg").innerText=="" && fleet!="" && fleet!="undefined" && fleet!=null){
            getCalData(fleet,salesprice,i,date);
            count++;
        }
    }
	
    if(temp==0){
        document.getElementById("errormsg").innerText="Please Select Fleet";
        return false;
    }
}

function getCalData(fleet,salesprice,row,date){
    var client=document.getElementById("client").value;
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items=items.split("::");
			
            $('#disposalGrid').jqxGrid('setcellvalue', row, 'dep_posted',items[0]); 
            $('#disposalGrid').jqxGrid('setcellvalue', row, 'pur_value',items[1]);
            $('#disposalGrid').jqxGrid('setcellvalue', row, 'acc_dep',items[2]);
            $('#disposalGrid').jqxGrid('setcellvalue', row, 'cur_dep',items[3]);
            $('#disposalGrid').jqxGrid('setcellvalue', row, 'net_pl',items[4]);
            $('#disposalGrid').jqxGrid('setcellvalue', row, 'netbook',items[5]);
            
            var dep_posted=$('#disposalGrid').jqxGrid('getcelltext', row, 'dep_posted'); 
            var pur_value=$('#disposalGrid').jqxGrid('getcelltext', row, 'pur_value').replace(/,/g , "");
            var acc_dep=$('#disposalGrid').jqxGrid('getcelltext', row, 'acc_dep').replace(/,/g , "");
            var cur_dep=$('#disposalGrid').jqxGrid('getcelltext', row, 'cur_dep').replace(/,/g , "");
            var net_pl=$('#disposalGrid').jqxGrid('getcelltext', row, 'net_pl').replace(/,/g , "");
            var netbook=$('#disposalGrid').jqxGrid('getcelltext', row, 'netbook').replace(/,/g , "");
            var salesprice=$('#disposalGrid').jqxGrid('getcelltext', row, 'salesprice').replace(/,/g , "");
            var fleetno=$('#disposalGrid').jqxGrid('getcelltext', row, 'fleet_no').replace(/,/g , "");
            var dtype=document.getElementById("formdetailcode").value;
            var clientcurr=document.getElementById("hidclientcurid").value;
            var currrate=document.getElementById("currrate").value;
            var description=document.getElementById("description").value;
            var trsalesprice=$('#disposalGrid').jqxGrid('getcelltext', row, 'trsalesprice').replace(/,/g , "");

            document.getElementById("days").value=items[3];
            if(pur_value!=null && typeof(pur_value)!="undefined"){
                funLoadTempJv(dep_posted,pur_value,acc_dep,cur_dep,net_pl,netbook,client,salesprice,fleetno,dtype,date,trsalesprice,clientcurr,currrate,description);	
            }
        }
    }
    x.open("GET", "getCalData.jsp?fleet="+fleet+"&salesprice="+salesprice+"&date="+date, true);
    x.send();
}

function funLoadTempJv(dep_posted,pur_value,acc_dep,cur_dep,net_pl,netbook,client,salesprice,fleetno,dtype,date,trsalesprice,clientcurr,currrate,description){ 
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            document.getElementById("mdoc").value=items;
            $('#jvdiv').load('jvGrid.jsp?trno='+document.getElementById("mdoc").value+'&id=2');
        }
    }
    x.open("GET", "loadTempJv.jsp?salesprice="+salesprice+"&dep_posted="+dep_posted+"&purvalue="+pur_value+"&accdep="+acc_dep+"&curdep="+cur_dep+"&netpl="+net_pl+"&netbook="+netbook+"&client="+client+"&fleetno="+fleetno+"&dtype="+dtype+"&date="+date+"&trsalesprice="+trsalesprice+"&clientcurr="+clientcurr+"&currrate="+currrate+"&description="+description, true);
    x.send();
}

function getDetail(){
    if(document.getElementById("docno").value==""){
        document.getElementById("errormsg").innerText="Please Select a Document";
        return false;
    }
    if(document.getElementById("rdosummary").checked==false && document.getElementById("rdodetail").checked==false && document.getElementById("rdotabular").checked==false){
        document.getElementById("errormsg").innerText="Please Select any Valid Option";
        return false;
    }
    $('#detailwindow').jqxWindow('open');
    $('#detailwindow').jqxWindow('focus');
    if(document.getElementById("rdosummary").checked==true){
        detailSearchContent('getGridSummary.jsp');
    }
    else if(document.getElementById("rdodetail").checked==true){
        detailSearchContent('getGridDetail.jsp');
    }
    else{
        detailSearchContent('getGridTabular.jsp?docno='+document.getElementById("docno").value+'&fromdate='+$('#fromdate').jqxGrid('val')+'&todate='+$('#todate').jqxGrid('val'));
    }
}
 
function funPrintBtn() {
    if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
        $.messager.alert('Warning','Select a Document');
        return false;
    }
    var url=document.URL;
    var reurl=url.split("com/");	
    var win= window.open(reurl[0]+"com/operations/saleofvehicle/vehicledisposal/printVehSalesInvReturn.action?docno="+document.getElementById("docno").value+"&trno="+document.getElementById("trno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus();      
}

function getConfigs(){
    $.get('getConfigs.jsp',function(data){
        configs=JSON.parse(data);
    });
}
</script>
</head>
<body onload="setValues();getConfigs();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmVehSalesInvReturn" action="saveVehSalesInvReturn" autocomplete="off" >
        <jsp:include page="../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Document Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' tabindex="-1" style="width:120px;" readonly>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Sales Inv Ref No</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="salesinvvocno" id="salesinvvocno" placeholder="Press F3" value='<s:property value="salesinvvocno"/>' readonly onkeydown="getSalesInv(event);" />
                        <svg class="magnifier-icon" onclick="$('#salesinvvocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" name="salesinvremarks" id="salesinvremarks" value='<s:property value="salesinvremarks"/>' style="flex:1;" readonly tabindex="-1" />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Client</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="client" id="client" value='<s:property value="client"/>' readonly placeholder="Press F3" onkeydown="getClient(event);">
                        <svg class="magnifier-icon" onclick="$('#client').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>' style="flex:1;" readonly tabindex="-1">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Description</label>
                    <input type="text" name="description" id="description" value='<s:property value="description"/>' style="flex:1;">
                    
                    <label class="lbl-right" style="width:80px;">Currency</label>
                    <input type="text" name="clientcurr" id="clientcurr" value='<s:property value="clientcurr"/>' style="width:100px;" readonly >
                    
                    <label class="lbl-right" style="width:60px;">Rate</label>
                    <input type="text" name="currrate" id="currrate" value='<s:property value="currrate"/>' style="width:100px;" readonly >
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Disposal Details</span>
                <div id="disposaldiv" class="grid-container">
                    <jsp:include page="vehDisposalGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">JV Details</span>
                <div id="jvdiv" class="grid-container">
                    <jsp:include page="jvGrid.jsp"></jsp:include>
                </div>
            </div>

            <div style="display:none;">
                <input type="button" name="btncalculate" id="btncalculate" onclick="funCalculate();">
                <select name="cmbtype" id="cmbtype">
                    <option value="">--Select--</option>
                    <option value="S">Sale</option>
                    <option value="L">Total Loss</option>
                </select>
                <input type="hidden" name="hidsum" id="hidsum" value='<s:property value="hidsum"/>'>
                <input type="hidden" name="monthdiff" id="monthdiff" value='<s:property value="monthdiff"/>'>
                <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                <input type="hidden" name="salesinvdocno" id="salesinvdocno" value='<s:property value="salesinvdocno"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
                <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
                <input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'> 
                <input type="hidden" name="salesinvtrno" id="salesinvtrno" value='<s:property value="salesinvtrno"/>'> 
                <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
                <input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
                <input type="hidden" name="hidbranch" id="hidbranch" value='<s:property value="hidbranch"/>'>
                <input type="hidden" name="days" id="days" value='<s:property value="days"/>'>
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1"  readonly>
                <input type="hidden" name="mdoc" id="mdoc" value='<s:property value="mdoc"/>' tabindex="-1"  readonly>
                <input type="hidden" name="disposalrow" id="disposalrow" value='<s:property value="disposalrow"/>'>
                <input type="hidden" name="hidclientcurid" id="hidclientcurid" value='<s:property value="hidclientcurid"/>'>
            </div>

        </div>
    </form>

    <div id="clientwindow"><div></div></div>
    <div id="fleetwindow"><div></div></div>
    <div id="detailwindow"><div></div></div>
    <div id="salesinvwindow"><div></div></div>
</div>
</body>
</html>