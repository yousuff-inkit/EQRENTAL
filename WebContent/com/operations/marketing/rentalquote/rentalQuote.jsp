<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includesn.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

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

.modern-ui input[type="checkbox"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
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
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
$(document).ready(function(){
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#date").jqxDateTimeInput({  width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#date").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    $('#equipwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#equipwindow').jqxWindow('close');
    $('#tariffwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Tariff Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#tariffwindow').jqxWindow('close');
    $('#clientwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#clientwindow').jqxWindow('close');
    $('#cpinfowindow').jqxWindow({ width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#cpinfowindow').jqxWindow('close');
 	     	
    $('#date').on('change', function (event) {
        var maindate = $('#date').jqxDateTimeInput('getDate');
        if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
            funDateInPeriod(maindate);
            getTaxper($("#date").jqxDateTimeInput('val'));
        }
    });
    
    $('#cldocno,#clientdetails').dblclick(function(){
        if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
            $('#clientwindow').jqxWindow('open');
            innerWindowSearchContent('clientMasterSearch.jsp','clientwindow');
        }				
    });
			
    $('#contactperson').dblclick(function(){
        var cldocno=document.getElementById("cldocno").value;
        if(cldocno==""){
            document.getElementById("errormsg").innerText="Client is Mandatory.";
            if (document.getElementById("contactperson").value == "") {
                $('#contactperson').attr('placeholder', 'Press F3 to Search'); 
            }
            return 0;
        }
        document.getElementById("errormsg").innerText=" ";
        cpSearchContent('contactPersonDetailsSearch.jsp?clientdocno='+cldocno);  
    });
});
		
function getcontactperson(event){
    var x= event.keyCode;
    if(x==114){
        var cldocno=document.getElementById("cldocno").value;
        if(cldocno==""){
            document.getElementById("errormsg").innerText="Client is Mandatory.";
            if (document.getElementById("contactperson").value == "") {
                $('#contactperson').attr('placeholder', 'Press F3 to Search'); 
            }
            return 0;
        }
        document.getElementById("errormsg").innerText="";
        cpSearchContent('contactPersonDetailsSearch.jsp?clientdocno='+cldocno);
    }
}
		
function cpSearchContent(url) {
    $('#cpinfowindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#cpinfowindow').jqxWindow('setContent', data);
        $('#cpinfowindow').jqxWindow('bringToFront');
    }); 
}
		
function getTaxper(date){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#hidtaxperc').val(items);
        }
    }
    x.open("GET", "getTaxper.jsp?date="+date, true);
    x.send();
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

function getClient(event){
    if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
        var x= event.keyCode;
        if(x==114){
            $('#clientwindow').jqxWindow('open');
            innerWindowSearchContent('clientMasterSearch.jsp','clientwindow');
        }
    }
}
		
function funCalTotal(){
    if($('#mode').val()=='A' || $('#mode').val()=='E'){
        var delcharges=$.isNumeric($("#delcharges").val())?parseFloat($("#delcharges").val()):0;
        var collcharges=$.isNumeric($("#collcharges").val())?parseFloat($("#collcharges").val()):0;
        var srvcharges=$.isNumeric($("#srvcharges").val())?parseFloat($("#srvcharges").val()):0;
        var vatperc=parseFloat($('#hidtaxperc').val());		    	
        
        var tot=(delcharges+collcharges+srvcharges).toFixed(2);
        var vatamt = (parseFloat(tot)*(vatperc/100)).toFixed(2);
        var totalamt = (parseFloat(tot) + parseFloat(vatamt)).toFixed(2);
        $("#vatamt").val(vatamt)
        $("#totalamt").val(totalamt)
    }
}
		
function innerWindowSearchContent(url,windowid){
    $.get(url).done(function (data) {
        $('#'+windowid).jqxWindow('setContent', data);
    });
}

function funReadOnly(){
    $('#frmRentalQuote input').attr('readonly', true);
    $('#date').jqxDateTimeInput({'disabled':true});
}

function funRemoveReadOnly(){
    $('#frmRentalQuote input').attr('readonly', false);
    $('#docno,#vocno,#cldocno,#clientdetails,#vatamt,#totalamt').attr('readonly', true);
    if($('#mode').val()=='A' || $('#mode').val()=='E'){
        $('#date').jqxDateTimeInput({'disabled':false});
        $('#rentalQuoteGrid').jqxGrid('addrow',null,{});
    }
    if($('#mode').val()=='A'){
        $('#date').jqxDateTimeInput('setDate',new Date());
        $('#rentalQuoteGrid').jqxGrid('clear');
        $('#rentalQuoteGrid').jqxGrid('addrow',null,{});
    }
    if($('#mode').val()=='D'){
        $('#date').jqxDateTimeInput({'disabled':false});
    }
    getTaxper($("#date").jqxDateTimeInput('val'));
}

function funNotify(){
    if($('#cldocno').val()==''){
        document.getElementById("errormsg").innerText="Client is mandatory";
        return 0;
    }
    if($('#cmbrentaltype').val()==''){
        document.getElementById("errormsg").innerText="Rental Type is mandatory";
        return 0;
    }
    
    var rows = $("#rentalQuoteGrid").jqxGrid('getrows');
    var gridlength=0;
    for(var i=0 ; i < rows.length ; i++){
        if(rows[i].code!=null && rows[i].code!="" && rows[i].code!="undefined" && typeof(rows[i].code)!="undefined"){
            newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "quottest"+i)
                .attr("name", "quottest"+i)
                .attr("hidden", "true"); 
 
            newTextBox.val(rows[i].subcatid+" :: "+rows[i].grpid+" :: "+rows[i].tarifdocno+" :: "+rows[i].qty+" :: "+rows[i].hiremode+" :: "+rows[i].subtotal+" :: "+rows[i].maxdiscount+" :: "+rows[i].discount+" :: "+rows[i].total+" :: "+rows[i].vatperc+" :: "+rows[i].vatamt+" :: "+rows[i].nettotal+" :: "+rows[i].flname);
            newTextBox.appendTo('form'); 
            gridlength++;	
        }
    }
    $('#gridlength').val(gridlength);
    return 1;
}

function funChkButton() {}

function funSearchLoad(){
    changeContent('masterSearch.jsp'); 
}
		
function funFocus(){
    $('#date').jqxDateTimeInput('focus'); 	    		
}

function setValues() {
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    if($('#hidcmbrentaltype').val()!=''){
        $('#cmbrentaltype').val($('#hidcmbrentaltype').val());
    }
    if($('#docno').val()!=''){
        var docno=$('#docno').val();
        $('#rentalquotegriddiv').load('rentalQuoteGrid.jsp?docno='+docno+'&id=1');
        funCheckEditStatus();
    }
}

function funCheckEditStatus(){
    var docno=$('#docno').val();
    $.get('checkEditStatus.jsp',{'docno':docno},function(data){
        data=JSON.parse(data);
        if(parseInt(data.itemcount)>0){
            $('#btnEdit').attr('disabled',true);
            document.getElementById("errormsg").innerText="Cannot edit,Quote approved";
        } else{
            $('#btnEdit').attr('disabled',false);
            document.getElementById("errormsg").innerText="";
        }
    });
}

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#docno").val()!="") {
        var url=document.URL;
        var reurl=url.split("com/");
        var win= window.open(reurl[0]+"printRentalQuote?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else{
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form action="saveRentalQuote" id="frmRentalQuote" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Rental Quote Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No</label>
            <input type="text" name="vocno" id="vocno" style="width:100px;" value='<s:property value="vocno"/>' readonly tabindex="-1">
            <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Client</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="cldocno" name="cldocno" placeholder="Press F3" value='<s:property value="cldocno"/>' onkeydown="getClient(event);">
                <svg class="magnifier-icon" onclick="$('#cldocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="clientdetails" name="clientdetails" style="flex:1;" value='<s:property value="clientdetails"/>' onkeydown="getClient(event);" readonly>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Contact Person</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="contactperson" name="contactperson" placeholder="Press F3" onkeydown="getcontactperson(event);" value='<s:property value="contactperson"/>'>
                <svg class="magnifier-icon" onclick="$('#contactperson').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="cptrno" name="cptrno" value='<s:property value="cptrno"/>'/>
            
            <label class="lbl-right" style="width:100px;">Contact Number</label>
            <input type="text" id="contactnumber" name="contactnumber" style="flex:1;" value='<s:property value="contactnumber"/>'>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Attention</label>
            <input type="text" id="attention" name="attention" style="flex:1;" value='<s:property value="attention"/>'>
        </div>
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Subject</label>
            <input type="text" id="subject" name="subject" style="flex:1;" value='<s:property value="subject"/>'>
        </div>
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Description</label>
            <input type="text" id="desc" name="desc" style="flex:1;" value='<s:property value="desc"/>'>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Delivery Charges</label>
            <input type="text" id="delcharges" name="delcharges" style="width:100px; text-align:right;" value='<s:property value="delcharges"/>' onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id); funCalTotal();">
            
            <label class="lbl-right" style="width:120px;">Collection Charges</label>
            <input type="text" id="collcharges" name="collcharges" style="width:100px; text-align:right;" value='<s:property value="collcharges"/>' onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id); funCalTotal();">
            
            <label class="lbl-right" style="width:120px;">Service Charges</label>
            <input type="text" id="srvcharges" name="srvcharges" style="width:100px; text-align:right;" value='<s:property value="srvcharges"/>' onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id); funCalTotal();">
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">VAT Amount</label>
            <input type="text" id="vatamt" name="vatamt" style="width:100px; text-align:right;" value='<s:property value="vatamt"/>' readonly>
            
            <label class="lbl-right" style="width:60px;">Total</label>
            <input type="text" id="totalamt" name="totalamt" style="width:100px; text-align:right; font-weight:bold;" value='<s:property value="totalamt"/>' readonly>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Delivery Remark</label>
            <input type="text" id="delremark" name="delremark" style="flex:1;" value='<s:property value="delremark"/>'>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Service Description</label>
            <input type="text" id="srvdesc" name="srvdesc" style="flex:1;" value='<s:property value="srvdesc"/>'>
        </div>
    </div>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Rental Quote Items</span>
        <div id="rentalquotegriddiv" class="grid-container">
            <jsp:include page="rentalQuoteGrid.jsp"></jsp:include>
        </div>
    </div>
    
    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="hidtaxperc"/>
    </div>
    
</div>

<!-- Search Windows -->
<div id="equipwindow"><div></div></div>
<div id="tariffwindow"><div></div></div>
<div id="clientwindow"><div></div></div>
<div id="cpinfowindow"><div></div></div>

</form>	
</div>	
</body>
</html>