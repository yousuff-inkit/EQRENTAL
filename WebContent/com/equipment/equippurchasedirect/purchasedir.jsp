<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.equipment.equippurchasedirect.ClsEquipPurchaseDirectDAO" %>
<% 
    String contextPath=request.getContextPath();
    ClsEquipPurchaseDirectDAO pdao=new ClsEquipPurchaseDirectDAO();
    int method=pdao.getTaxMethod();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
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
.amtclass { text-align:right; }
</style>

<script type="text/javascript">
$(document).ready(function() {
    var meth='<%=method%>'
    if(meth==0){
        document.getElementById("txttaxamount").style.display="none";
        document.getElementById("lbltax").style.display="none";
    }
    
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#vehpurorderDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#vehpurinvDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#vehpurorderDate, #vehpurinvDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#vehpurorderDate, #vehpurinvDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
    $('#fleetwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' ,title: 'Fleet Search' , position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#fleetwindow').jqxWindow('close');
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close');  		     
        
    $('#accid').dblclick(function(){
        if($('#mode').val()!="view") {
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsSearch.jsp?');
        }
    }); 
    
    $('#refno').dblclick(function(){
        $('#refnosearchwindow').jqxWindow('open');
        refsearchContent('vehreqRefnoSearch.jsp?');   
    });

    $('#vehpurorderDate').on('change', function (event) {
        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
        if ($("#mode").val() != "view"  ) {   
            funDateInPeriod(maindate);
        }
    });  
});

function getrefDetails(event){
    var x= event.keyCode;
    if(x==114){
        $('#refno').dblclick();
    }
}  

function refsearchContent(url) {
    $.get(url).done(function (data) {
        $('#refnosearchwindow').jqxWindow('setContent', data);
    });	
}          

function commenSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('open');
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
} 	

function getfinacc(event){
    var x= event.keyCode;
    if(x==114){
        $('#accountSearchwindow').jqxWindow('open');
        commenSearchContent('finaccountSearch.jsp?');
    }
}     
        
function fleetSearchContent(url) {
    $.get(url).done(function (data) {
        $('#fleetwindow').jqxWindow('open');
        $('#fleetwindow').jqxWindow('setContent', data);
    }); 
} 

function getaccountdetails(event){
    var x= event.keyCode;
    if(x==114){
        if($('#mode').val()!="view") {
            $('#accid').dblclick();
        }
    }
}  

function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}

function funReadOnly(){
    $('#frmpurchasedir input').attr('readonly', true );
    $('#frmpurchasedir select').attr('disabled', true);
    $('#vehpurorderDate').jqxDateTimeInput({disabled: true});
    $('#vehpurinvDate').jqxDateTimeInput({disabled: true});
    $('#epocmbcurr').attr('disabled', true);  
    $('#refno').attr('disabled', true);  
}

function funRemoveReadOnly(){
    $('#frmpurchasedir input').attr('readonly', false );
    $('#frmpurchasedir select').attr('disabled', false);
    $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
    $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
    $('#accid').attr('readonly', true);
    $('#refno').attr('disabled', true);
    $('#refno').attr('readonly', true);  
    $('#txttaxamount').attr('readonly', true);  
    $('#txtnetotal').attr('readonly', true);  
    if ($("#mode").val() == "A") {
        tax();
        $('#vehpurorderDate').val(new Date());
        $('#vehpurinvDate').val(new Date());
        $("#vehpurchasedirgrid").jqxGrid('clear');
        $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
    }
    $('#epocurrate').attr('readonly', true);
    $('#epocmbcurr').attr('disabled', false);  
    
    if ($("#mode").val() == "E") {     
        tax();
        if($('#reftype').val()=="EPO") {
            $('#refno').attr('disabled', false);
            $('#refno').attr('readonly', true);
        }
        $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
    }  
    
    if($('#mode').val()=='D') {
        $('#frmpurchasedir input').attr('readonly',false);  
        $('#frmpurchasedir select').attr('disabled',false); 
        $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
        $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
        funchkfordel(document.getElementById("masterdoc_no").value);	
        funReadOnly();
        exit();
    }
    var date = $('#vehpurorderDate').val();  
    getEPOCurrencyId(date);
}
	 
function funchkfordel(masterdoc_no) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();	
            if(parseInt(items)>0) {
                $.messager.alert('Message',' Transaction Already Exists','warning');  
                return 0;
            } else {
                $('#frmpurchasedir input').attr('readonly',false);  
                $('#frmpurchasedir select').attr('disabled',false); 
                $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                $('#frmpurchasedir').submit(); 
            }
        }
    }
    x.open("GET", "deletechk.jsp?srno="+document.getElementById("masterdoc_no").value, true);
    x.send();
}

function funSearchLoad(){
    changeContent('mastersearch.jsp'); 
}
    
function funChkButton() {}
    
function funFocus() {
    $('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
}

function getTaxPer(date, accid){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#txttaxpercentage').val(items);
        }
    }
    x.open("GET", "getTaxper.jsp?date="+date+"&accid="+accid, true);
    x.send();
}

function tax(){
    var date=$('#vehpurorderDate').val();
    var accid=$('#accid').val();
    getTaxPer(date, accid);
}

function getBill(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var pgid=items[0].split(",");
            var pgcode=items[1].split(",");
            var optionspg = '';
            for ( var i = 0; i < pgcode.length; i++) {
                optionspg += '<option value="' + pgid[i] + '">' + pgcode[i] + '</option>';
            }
            $("select#cmbbilltype").html(optionspg);
            if($('#hidcmbbilltype').val()!=""){
                $('#cmbbilltype').val($('#hidcmbbilltype').val());   
            }
        }
    }
    x.open("GET","getBillType.jsp",true);
    x.send();
}
   
function funNotify(){
    var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(maindate);
    if(validdate==0){ return 0; }
    
    if( document.getElementById("reftype").value=="EPO") { 
        var refno= document.getElementById('masterrefno').value; 
        if(refno=="") {
            document.getElementById("errormsg").innerText=" Select Ref NO";	
            document.getElementById('refno').focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";
        }
    }
    
    var purid= document.getElementById("accid").value;
    if(purid=="") {
        document.getElementById("errormsg").innerText=" Select An Account";
        document.getElementById("accid").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    } 
    
    var invno= document.getElementById("invno").value;
    if(invno=="") {
        document.getElementById("errormsg").innerText=" Enter Invoice No";
        document.getElementById("invno").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    } 
    
    var cmbbilltype= $("#cmbbilltype").val();
    if(cmbbilltype=="") {
        document.getElementById("errormsg").innerText=" Select Billtype";
        document.getElementById("cmbbilltype").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    } 

    var rows = $("#vehpurchasedirgrid").jqxGrid('getrows');
    $('#vehpurchasegridlenght').val(rows.length);
    var fleet_sel=0;
    var tax_total=0;
    var net_total=0;
        
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "vehpurchasetest"+i)
            .attr("name", "vehpurchasetest"+i) 
            .attr("hidden", "true"); 
        
        newTextBox.val(rows[i].fleet_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
            +rows[i].clrid+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].prch_cost+" :: "+rows[i].addicost+" :: "
            +rows[i].price+" :: "+rows[i].taxperc+" :: "+rows[i].taxamt+" :: "+rows[i].nettotal+" :: ");
        newTextBox.appendTo('form');
        
        if(rows[i].fleet_no!="" && rows[i].fleet_no!=null && rows[i].fleet_no!="null" && rows[i].fleet_no!="undefined"){
            fleet_sel=1;
            tax_total+= $.isNumeric(rows[i].taxamt)?rows[i].taxamt:0;
            net_total+= $.isNumeric(rows[i].nettotal)?rows[i].nettotal:0;
        }
    }   
    
    $("#txttaxamount").val(tax_total);
    $("#txtnetotal").val(net_total);
        
    if(fleet_sel==0) {
        document.getElementById("errormsg").innerText=" Select atleast one fleet";
        document.getElementById("invno").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    } 
    return 1;
} 
	  
$(function(){
    $('#frmpurchasedir').validate({
        rules: { vehdesc:{maxlength:200} },
        messages: { vehdesc: {maxlength:"  Max 250 chars"} }
    });
});
 	  
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}  
	
function setValues() {
    if($('#hidvehpurorderDate').val()){
        $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
    }
    if($('#hidcmbbilltype').val()!=""){
        $('#cmbbilltype').val($('#hidcmbbilltype').val());   
    }
    if($('#hidreftype').val()!=""){
        $("#reftype").val($('#hidreftype').val());
    }
    
    $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
    var date = $('#vehpurorderDate').val();
    getEPOCurrencyId(date)
    $('#vehpurorderDate').jqxDateTimeInput({disabled: true});

    if($('#hidvehpurinvDate').val()){
        $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
    }
    
    var indexVa5 = document.getElementById("masterdoc_no").value;
    if(parseInt(indexVa5)>0){
        $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);  
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    document.getElementById("formdetailcode").value=$('#formdetailcode').val();
}
	
function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveeqPurchaseDir");
        $("#docno").prop("disabled", false);                
        var win= window.open(reurl[0]+"printeqPurchaseDir?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus(); 
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
} 

function getEPOCurrencyId(date){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var curidItems=items[0];
            var curcodeItems=items[1];
            var currateItems=items[2];
            var curtypeItems=items[3];
            var multiItems=items[4];
            var optionscurr = '';
            
            if(curcodeItems.indexOf(",")>=0){
                var currencyid=curidItems.split(",");
                var currencycode=curcodeItems.split(",");
                var currencyrate=currateItems.split(",");
                var currencytype=curtypeItems.split(",");
                multiItems.split(",");
                for ( var i = 0; i < currencycode.length; i++) {
                    optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                }
                $("select#epocmbcurr").html(optionscurr);
                if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
                    $('#epocmbcurr').val($('#hidcmbcurr').val()) ;
                    getEPORatevalue($('#hidcmbcurr').val(),$('#vehpurorderDate').val());
                } 
                if($('#mode').val()=="A"){
                    funRoundRate(currencyrate[0],"epocurrate");
                }
            } else {
                optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                $("select#epocmbcurr").html(optionscurr);
                if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
                    $('#epocmbcurr').val($('#hidcmbcurr').val()) ;
                    getEPORatevalue($('#hidcmbcurr').val(),$('#vehpurorderDate').val());
                } 
                if($('#mode').val()=="A"){
                    funRoundRate(currateItems,"epocurrate");
                }
            }
        }
    }
    x.open("GET", "<%=contextPath+"/"%>"+"getCurrencyId.jsp?date="+date,true); 
    x.send();
}

function getEPORatevalue(a,date){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items = items.split('####');
            var ratesItems  = items[0].split(",");
            var typesItems = items[1].split(",");
            funRoundRate(ratesItems,"epocurrate");  
        }
    }
    x.open("GET", "<%=contextPath+"/"%>"+"getRateTo.jsp?currs="+a+"&date="+date,true);
    x.send();
} 

function funrefdisslno(){
    if($('#reftype').val()=="EPO"){
        $('#refno').attr('disabled', false);  
    }else{
        $('#refno').val("");
        $('#refno').attr('disabled', true);
    }
}  
</script>

</head>
<body onload="setValues();getBill();">
<div id="mainBG" class="homeContent" data-type="background" >
<jsp:include page="../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
<form id="frmpurchasedir" action="saveeqPurchaseDir" method="post" autocomplete="off">

    <div class="middle-panel">
        <span class="middle-panel-title">Equipment Purchase Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>' onblur="tax()" onchange="tax()"></div>
            </div>
            <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/>
            
            <label class="lbl-right" id="billname" style="width:80px;">Bill Type</label>
            <select id="cmbbilltype" name="cmbbilltype" style="width:120px;" value='<s:property value="cmbbilltype"/>'></select>
            <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
            
            <label class="lbl-right" style="width:80px;">Type</label>
            <select id="reftype" name="reftype" style="width:100px;" value='<s:property value="reftype"/>' onchange="funrefdisslno()">
                <option value="DIR">DIR</option>
                <option value="EPO">EPO</option>
            </select>
            <input type="hidden" id="hidreftype" name="hidreftype" value='<s:property value="hidreftype"/>'/>     
            
            <label class="lbl-right" style="width:80px;">Ref No</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="refno" name="refno" placeholder="Press F3" value='<s:property value="refno"/>' onkeydown="getrefDetails(event)"/>
                <svg class="magnifier-icon" onclick="$('#refno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:60px;">Inv No</label>
            <input type="text" id="invno" name="invno" style="width:100px;" value='<s:property value="invno"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" style="width:100px;" readonly value='<s:property value="docno"/>' tabindex="-1"/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Vendor</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="accid" name="accid" placeholder="Press F3" value='<s:property value="accid"/>' onkeydown="getaccountdetails(event)"/>
                <svg class="magnifier-icon" onclick="$('#accid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="vehpuraccname" name="vehpuraccname" style="flex:1;" value='<s:property value="vehpuraccname"/>'/>
            
            <label class="lbl-right" style="width:100px;">Purchase Date</label>
            <div style="width: 125px;">
                <div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
            </div>
            <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
            
            <label class="lbl-right" style="width:60px;">Curr</label>
            <select name="epocmbcurr" id="epocmbcurr" style="width:100px;" value='<s:property value="epocmbcurr"/>' onchange="getEPORatevalue(this.value,$('#vehpurorderDate').val());"></select>    
            <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/>
            
            <label class="lbl-right" style="width:60px;">Rate</label>
            <input type="text" class="amtclass" name="epocurrate" id="epocurrate" style="width:100px;" value='<s:property value="epocurrate"/>' onblur="funRoundAmt(this.value,this.id);" tabindex="-1">
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="vehdesc" name="vehdesc" style="flex:1;" value='<s:property value="vehdesc"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Fleet / Items Details</span>
        <div id="vehpuchase" class="grid-container">
            <jsp:include page="vehpurchaseDetails.jsp"></jsp:include>
        </div> 
    </div>

    <!-- Hidden calculation fields -->
    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        <input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>
        <input type="hidden" id="headacccode" name="headacccode" value='<s:property value="headacccode"/>'/>
        <input type="hidden" id="txttaxpercentage" name="txttaxpercentage" value='<s:property value="txttaxpercentage"/>'/>
        <input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght" value='<s:property value="vehpurchasegridlenght"/>'/>

        <!-- Kept hidden to satisfy logic if meth != 0 -->
        <label id="lbltax">Tax Amount</label>
        <input type="text" name="txttaxamount" class="amtclass" id="txttaxamount" value='<s:property value="txttaxamount"/>'>
        <input type="text" name="txtnetotal" class="amtclass" id="txtnetotal" value='<s:property value="txtnetotal"/>'>
    </div>

</form>

<!-- Search Windows -->
<div id="accountSearchwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="refnosearchwindow"><div></div></div>

</div>
</div>
</body>
</html>