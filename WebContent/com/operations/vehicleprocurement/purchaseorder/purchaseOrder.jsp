<%@ taglib prefix="s" uri="/struts-tags"%>
 
<!DOCTYPE html>
<html>
<%-- <% String contextPath=request.getContextPath();%> --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
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

<%
String mod = request.getParameter("mod") == null ? "" : request.getParameter("mod").toString();
String  docno = request.getParameter("docno") == null? "0": request.getParameter("docno").toString() ;
String  vendocnos = request.getParameter("venddocno") == null? "0": request.getParameter("venddocno").toString() ;
String  vendnames = request.getParameter("vendname") == null? "0": request.getParameter("vendname").toString() ;
String  vendacounts = request.getParameter("vendaccount") == null? "0": request.getParameter("vendaccount").toString() ;
String  entrydate = request.getParameter("entrydate") == null? "0": request.getParameter("entrydate").toString() ;
%>

<script type="text/javascript">
var mod1='<%=mod%>';   			 
var tempdocno='<%=docno%>'; 
var tempdate='<%=entrydate%>';

$(document).ready(function() {
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#vehpurorderDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#vehpurorderdelDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});

    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#vehpurorderDate, #vehpurorderdelDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#vehpurorderDate, #vehpurorderdelDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#brandsearchwndow').jqxWindow('close'); 

    $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y:60 }, keyboardCloseKey: 27});
    $('#modelsearchwndow').jqxWindow('close');

    $('#colorsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 800, y:60 }, keyboardCloseKey: 27});
    $('#colorsearchwndow').jqxWindow('close');

    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
         
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close'); 
           
    $('#vehrefno').dblclick(function(){
        $('#refnosearchwindow').jqxWindow('open');
        refsearchContent('vehreqRefnoSearch.jsp?'); 
    }); 
           
    $('#accid').dblclick(function(){
        if($('#mode').val()=="A" || $('#mode').val()=="E" ) {
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsSearch.jsp');
        }
    }); 
    
    $('#vehpurorderDate').on('change', function (event) {
        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
        if ($("#mode").val() == "A" || $('#mode').val()=="E" ) {   
            funDateInPeriod(maindate);
        }
    });
});

function getrefDetails(event){
    var x= event.keyCode;
    if(x==114){
        $('#refnosearchwindow').jqxWindow('open');
        refsearchContent('vehreqRefnoSearch.jsp?');  
    }
}  

function refsearchContent(url) {
    $.get(url).done(function (data) {
        $('#refnosearchwindow').jqxWindow('setContent', data);
    }); 
}

function getaccountdetails(event){
    if($('#mode').val()=="A" || $('#mode').val()=="E" ) {
        var x= event.keyCode;
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsSearch.jsp');    
        }
    }
}  

function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}

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

function funReadOnly(){
    funtaxchk();
    $('#frmpurorder input').attr('readonly', true );
    $('#frmpurorder select').attr('disabled', true);
    
    $('#vehpurorderDate').jqxDateTimeInput({disabled: true});
    $('#vehpurorderdelDate').jqxDateTimeInput({disabled: true});
    $("#vehoredergrid").jqxGrid({ disabled: true});
    $('#vehrefno').attr('disabled', true);
    $('#nettotal').attr('readonly', true);
    $('#taxamount').attr('readonly', true); 
      
    if(mod1=="open") {
        document.getElementById("docno").value=tempdocno;
        document.getElementById("mode").value="view";
        document.getElementById("frmpurorder").submit();
        mod1="view";
    } 
}

function funRemoveReadOnly(){
    funtaxchk();
    $('#taxamount').attr('readonly', true); 
    $('#nettotal').attr('readonly', true);
    $('#frmpurorder input').attr('readonly', false );
    $('#frmpurorder select').attr('disabled', false);
    $("#vehoredergrid").jqxGrid({ disabled: false});
    $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
    $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
    $('#vehrefno').attr('disabled', true);
    $('#docno').attr('readonly', true);
    $('#vehpuraccname').attr('readonly', true);
    $('#accid').attr('readonly', true);
    $('#vehrefno').attr('readonly', true);
      
    if ($("#mode").val() == "A") {
        $('#vehpurorderdelDate').val(new Date());
        $('#vehpurorderDate').val(new Date());
        $("#vehoredergrid").jqxGrid('clear');
        $("#vehoredergrid").jqxGrid('addrow', null, {});
    }
    
    if ($("#mode").val() == "E") {
        if($('#vehtype').val()=="VPR") {
            $('#vehrefno').attr('disabled', false);
            $('#vehrefno').attr('readonly', true);
        }
    }
}

function funtaxchk() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();	
            if(parseInt(items)>0) {
                $("#taxtable").show();
            } else {
                $("#taxtable").hide();
            }
        }
    }
    x.open("GET", "chkconfig.jsp?", true);
    x.send();
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
    x.open("GET", "orderlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
    x.send();
}

function funrefdisslno() {
    if($('#vehtype').val()=="VPR") {
        $('#vehrefno').attr('disabled', false);
    } else {
        $('#vehrefno').val("");
        $('#vehrefno').attr('disabled', true);
    }
}

function funSearchLoad(){
    changeContent('vehOrederMastersearch.jsp'); 
}

function funChkButton() {
    /* funReset(); */
}

function funFocus() {
    $('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
}

function funNotify(){
    var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(maindate);
    if(validdate==0){
        return 0; 
    }

    if( document.getElementById("vehtype").value=="VPR") {
        var refno= document.getElementById('masterrefno').value;
        if(refno=="") {
            document.getElementById("errormsg").innerText=" Select Ref NO";	
            document.getElementById('vehrefno').focus();
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

    var refval= document.getElementById("nettotal").value;
    if(refval=="") {
        document.getElementById("errormsg").innerText="Total is Empty";
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }

    var rows = $("#vehoredergrid").jqxGrid('getrows');
    $('#vehoredergridlenght').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "vehodrtest"+i)
            .attr("name", "vehodrtest"+i)
            .attr("hidden", "true");   
     
        newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: " 
                +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].qty+" :: "+rows[i].price+" :: "+rows[i].total+" :: "+rows[i].saveqty+" :: "+rows[i].rowno+" :: "+rows[i].qutval+" :: ");
    
        newTextBox.appendTo('form');
    }   
    return 1;
} 

function changeval() {
    if($('#vehtypeval').val()!="") {
        $('#vehtype').val($('#vehtypeval').val());
    }
     
    if($('#vehtypeval').val()=="VPR") {
        $('#vehrefno').attr('disabled', false);
        $('#vehrefno').attr('readonly', true);
    }
}

function diserror() {
    document.getElementById("errormsg").innerText=""; 
}
  
function setValues(){
    if($('#hidvehpurorderDate').val()){
        $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
    }
      
    if($('#hidvehpurorderdelDate').val()){
        $("#vehpurorderdelDate").jqxDateTimeInput('val', $('#hidvehpurorderdelDate').val());
    }
    
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
        
    var indexVa5 = document.getElementById("masterdoc_no").value;
    if(indexVa5>0){
        funchkforedit();
        $("#vehorder").load("vehorderDetails.jsp?masterdoc="+indexVa5);  
    } 
     
    changeval();
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
}
  
$(function(){
    $('#frmpurorder').validate({
        rules: { 
            vehdesc:{maxlength:200}
        },
        messages: {
            vehdesc: {maxlength:"  Max 200 chars"}
        }
    });
});

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("savePurchaseorder");
        $("#docno").prop("disabled", false);                
        var win= window.open(reurl[0]+"printPurchorder?docno="+document.getElementById("masterdoc_no").value+"&termdocno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
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
    <form id="frmpurorder" action="savePurchaseorder" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include>

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Document Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/>
                    
                    <label class="lbl-right" style="width:80px;">Type</label>
                    <select id="vehtype" name="vehtype" style="width:120px;" value='<s:property value="vehtype"/>' onchange="funrefdisslno()">
                        <option value="DIR">DIR</option>
                        <option value="VPR">VPR</option>
                    </select>

                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' style="width:120px;" readonly />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Vendor</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="accid" name="accid" placeholder="Press F3" value='<s:property value="accid"/>' onkeydown="getaccountdetails(event)" onblur="diserror()" />
                        <svg class="magnifier-icon" onclick="$('#accid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="vehpuraccname" name="vehpuraccname" value='<s:property value="vehpuraccname"/>' style="flex:1;" tabindex="-1" readonly />
                    <input type="hidden" id="headdoc" name="headdoc" value='<s:property value="headdoc"/>'/>

                    <label class="lbl-right" style="width:80px;">Ref No</label>
                    <div class="input-search-container" style="width: 120px;">
                        <input type="text" id="vehrefno" name="vehrefno" placeholder="Press F3" value='<s:property value="vehrefno"/>' onkeydown="getrefDetails(event)" />
                        <svg class="magnifier-icon" onclick="$('#vehrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Exp. Delivery</label>
                    <div style="width: 125px;">
                        <div id="vehpurorderdelDate" name="vehpurorderdelDate" value='<s:property value="vehpurorderdelDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidvehpurorderdelDate" name="hidvehpurorderdelDate" value='<s:property value="hidvehpurorderdelDate"/>'/>

                    <label class="lbl-right" style="width:80px;">Description</label>
                    <input type="text" id="vehdesc" name="vehdesc" value='<s:property value="vehdesc"/>' style="flex:1;" />
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Purchase Details</span>
                <div id="vehorder" class="grid-container">
                    <jsp:include page="vehorderDetails.jsp"></jsp:include>
                </div>
                
                <div id="taxtable" style="display:none;">
                    <div class="field-row" style="margin-top:10px; justify-content: flex-end;">
                        <label class="lbl-right" style="width:100px;" id="taxlabel">Tax Amount</label>
                        <input type="text" id="taxamount" name="taxamount" style="width:120px; text-align:right;" value='<s:property value="taxamount"/>' />

                        <label class="lbl-right" style="width:100px;">Net Total</label>
                        <input type="text" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>' style="width:120px; text-align:right; font-weight:bold; color:#0b45a2;" />
                    </div>
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
                <input type="hidden" id="brandval" name="brandval" value='<s:property value="brandval"/>'/>
                <input type="hidden" id="headacccode" name="headacccode" value='<s:property value="headacccode"/>'/>
                <input type="hidden" id="vehoredergridlenght" name="vehoredergridlenght" value='<s:property value="vehoredergridlenght"/>'/>
                <input type="hidden" id="vehtypeval" name="vehtypeval" value='<s:property value="vehtypeval"/>'/>
                <input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity" value='<s:property value="txtnontaxableentity"/>'/>
                <input type="hidden" id="txttaxpercentage" name="txttaxpercentage" value='<s:property value="txttaxpercentage"/>'/>
            </div>

        </div>

        <div id="colorsearchwndow"><div></div></div>
        <div id="modelsearchwndow"><div></div></div>
        <div id="brandsearchwndow"><div></div></div>
        <div id="accountSearchwindow"><div></div></div>
        <div id="refnosearchwindow"><div></div></div>
        
    </form>
</div>
</body>
</html>