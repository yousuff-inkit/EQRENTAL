<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<jsp:include page="tab.css"/>
<%@ include file="tab.jsp" %> 

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
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#jqxClientDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#jqxContractDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy" , value:null, theme: 'energyblue'});
    $("#dateOfJoining").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy" , value:null, theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#jqxClientDate, #jqxContractDate, #dateOfJoining").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#jqxClientDate, #jqxContractDate, #dateOfJoining").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    	  
    /* Searching Windows */
    $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#nationalityWindow').jqxWindow('close');
 		 
    $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#stateWindow').jqxWindow('close');
 		 
    $('#activityinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#activityinfowindow').jqxWindow('close');
   	  
    $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#areainfowindow').jqxWindow('close');
 		
    getGroup();getSalesman();getCategory();getNationality();getSalutation();getContractDate();getContract();getIDPDetails();getCRMDriverDetailsVerify();getNonTaxableEntity();getTax();getSeparateServiceChargeAllowed();
}); 
      
function hidedata(){
    var contract=$('#txtforcontractdiv').val();
    if(parseInt(contract)==1){
        $("#contractDiv").prop("hidden", false);
        $("#sponsorDiv").attr("hidden", true);
    } else{
        $("#contractDiv").prop("hidden", true);
        $("#sponsorDiv").attr("hidden", false);
    }
}
      
function showSingleOrSeparateServiceCharges(){
    var separateservicechargeallowed=$('#separateservicechargeallowed').val();
    if(parseInt(separateservicechargeallowed)==1){
        $("#singleServiceChargeDiv").prop("hidden", true);
        $("#separateServiceChargeDiv").attr("hidden", false);
    } else{
        $("#singleServiceChargeDiv").prop("hidden", false);
        $("#separateServiceChargeDiv").attr("hidden", true);
    }
}
      
function getContract(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#txtforcontractdiv').val(items);
            hidedata();
        }
    }
    x.open("GET", "getContract.jsp", true);
    x.send();
}
	 
function getIDPDetails(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#idpdetailsallowed').val(items);
        }
    }
    x.open("GET", "getIDPDetailsAllowed.jsp", true);
    x.send();
}
	
function getCRMDriverDetailsVerify(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#driverdetailsverifyallowed').val(items);
        }
    }
    x.open("GET", "getCRMDriverDetailsVerifyAllowed.jsp", true);
    x.send();
}
	
function getSeparateServiceChargeAllowed(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#separateservicechargeallowed').val(items);
            showSingleOrSeparateServiceCharges();
            if(parseInt($('#separateservicechargeallowed').val())==1 && $('#mode').val()=='A'){
                $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=2&defaultsevicecharge="+$('#hidchckseparatesrvcdefault').val());
            }
        }
    }
    x.open("GET", "getSeparateServiceChargeAllowed.jsp", true);
    x.send();
}
	
function getCategoryWiseEditEnable(a){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#txtcategorywiseedit').val(items);
            if(parseInt($('#txtcategorywiseedit').val())==1){
                $('#btnEdit').attr('disabled', true );
            }
        }
    }
    x.open("GET", "getCategoryWiseEditEnable.jsp?category="+a, true);
    x.send();
}
      
function getSalutation() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var salutnItems = items[0].split(",");
            var salutnIdItems = items[1].split(",");
            var optionssalutn = '<option value="">--Select--</option>';
            for (var i = 0; i < salutnItems.length; i++) {
                optionssalutn += '<option value="' + salutnItems[i] + '">' + salutnItems[i] + '</option>';
            }
            $("select#cmbsalutation").html(optionssalutn);
            if ($('#hidcmbsalutation').val() != null) {
                $('#cmbsalutation').val($('#hidcmbsalutation').val());
            }
        }
    }
    x.open("GET", "getSalutation.jsp", true);
    x.send();
} 
     
function getGroup() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var groupItems = items[0].split(",");
            var groupIdItems = items[1].split(",");
            var optionsgroup = '<option value="">--Select--</option>';
            for (var i = 0; i < groupItems.length; i++) {
                optionsgroup += '<option value="' + groupIdItems[i] + '">' + groupItems[i] + '</option>';
            }
            $("select#cmbgroup1").html(optionsgroup);
            if ($('#hidcmbgroup1').val() != null) {
                $('#cmbgroup1').val($('#hidcmbgroup1').val());
            }
        }
    }
    x.open("GET", "getGroup.jsp", true);
    x.send();
} 
	
function getCategoryAccountGroup(a) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#hidcmbgroup1').val(items);
            if ($('#hidcmbgroup1').val() != null || $('#hidcmbgroup1').val() != "") {
                $('#cmbgroup1').val($('#hidcmbgroup1').val());
            }
        }
    }
    x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
    x.send();
} 
     
function getSalesman() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var salesagentItems = items[0].split(",");
            var salesagentIdItems = items[1].split(",");
            var linkItems = items[2].split(",");
            
            var optionssalesagent = '';
            for (var i = 0; i < salesagentItems.length; i++) {
                if(parseInt(linkItems[i])==1) {
                    optionssalesagent += '<option value="' + salesagentIdItems[i] + '">' + salesagentItems[i] + '</option>';
                } else {
                    if(i==0) {
                        optionssalesagent = '<option value="">--Select--</option>';
                        optionssalesagent += '<option value="' + salesagentIdItems[i] + '">' + salesagentItems[i] + '</option>';
                    } else {
                        optionssalesagent += '<option value="' + salesagentIdItems[i] + '">' + salesagentItems[i] + '</option>';
                    }
                }
            }
            $("select#cmbsalesman").html(optionssalesagent);
            if ($('#hidcmbsalesman').val() != null) {
                $('#cmbsalesman').val($('#hidcmbsalesman').val());
            }
        }
    }
    x.open("GET", "getSalesagent.jsp", true);
    x.send();
}
      
function getCategory() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var categoryItems = items[0].split(",");
            var categoryIdItems = items[1].split(",");
            var optionscategory = '<option value="">--Select--</option>';
            for (var i = 0; i < categoryItems.length; i++) {
                optionscategory += '<option value="' + categoryIdItems[i] + '">' + categoryItems[i] + '</option>';
            }
            $("select#cmbcategory").html(optionscategory);
            if ($('#hidcmbcategory').val() != null) {
                $('#cmbcategory').val($('#hidcmbcategory').val());
            }
        }
    }
    x.open("GET", "getCategory.jsp", true);
    x.send();
}
      
function getCurrencyIds(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var curidItems=items[0];
            var curcodeItems=items[1];
            var multiItems=items[2];
            var optionscurr = '';
            
            if(curcodeItems.indexOf(",")>=0){
                var currencyid=curidItems.split(",");
                var currencycode=curcodeItems.split(",");
                multiItems.split(",");
                for ( var i = 0; i < currencycode.length; i++) {
                    optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                }
                $("select#cmbcurrency").html(optionscurr);
                if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                    $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                } 
            } else{
                optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                $("select#cmbcurrency").html(optionscurr);
                if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                    $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                }
            }
        }
    }
    x.open("GET", "getCurrencyId.jsp",true);
    x.send();
}
     
function getNationality() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var nationItems = items[0].split(",");
            var nationIdItems = items[1].split(",");
            var optionsnation = '<option value="">--Select--</option>';
            for (var i = 0; i < nationItems.length; i++) {
                optionsnation += '<option value="' + nationIdItems[i] + '">' + nationItems[i] + '</option>';
            }
            $("select#cmbnationality").html(optionsnation);
            if ($('#hidcmbnationality').val() != null) {
                $('#cmbnationality').val($('#hidcmbnationality').val());
            }
        }
    }
    x.open("GET", "getNationality.jsp", true);
    x.send();
} 
      
function taxcheck() {
    if($('#cmbtax').val()=='1'){
        document.getElementById("chcknontaxableentity").checked=true;
        document.getElementById("hidchcknontaxableentity").value = 1;
    } else if($('#cmbtax').val()=='2'){
        document.getElementById("chcknontaxableentity").checked=false;
        document.getElementById("hidchcknontaxableentity").value = 0;
    } else{
        document.getElementById("chcknontaxableentity").checked=false;
        document.getElementById("hidchcknontaxableentity").value = 0;
    }
}
      
function getClientAlreadyExists(clientname,salutation,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                document.getElementById("errormsg").innerText="Client Already Exists.";
                return 0;
            } else {
                if(parseInt($('#driverdetailsverifyallowed').val())==1){
                    var driverdetails = new Array();
                    var rowsverify = $("#jqxDriver").jqxGrid('getrows');
                    for(var z=0 ; z < rowsverify.length ; z++){
                        var chkverify=rowsverify[z].name;
                        if(typeof(chkverify) != "undefined" && typeof(chkverify) != "NaN" && chkverify != ""){
                            driverdetails.push(rowsverify[z].name+" ::"+rowsverify[z].mobno+" ::"+rowsverify[z].dlno+" ::"+rowsverify[z].dr_id);
                        }
                    }
                    getDriverDetailsVerification(driverdetails,docno,mode);
                } else {
                    var rows = [];
                    var length=0;
                    for(var i=0 ; i < rows.length ; i++){
                        var chk=rows[i].name;
                        if(typeof(chk) != "undefined"){
                            length=length+1;
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "test"+i)
                            .attr("name", "test"+i)
                            .attr("hidden", "true");
                            newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id+":: "+rows[i].hcdlno+":: "+rows[i].hidhcissdate+":: "+rows[i].hidhcled);
                            newTextBox.appendTo('form');
                        }
                    }
                    $('#gridlength').val(length);
                    
                    var rowsRef = $("#jqxReferenceDetails").jqxGrid('getrows');
                    var referencelength=0;
                    for(var i=0 ; i < rowsRef.length ; i++){
                        var chkd=rowsRef[i].cperson;
                        if(typeof(chkd) != "undefined"){
                            referencelength=referencelength+1;
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "txtreference"+i)
                            .attr("name", "txtreference"+i)
                            .attr("hidden", "true");
                            newTextBox.val(rowsRef[i].cperson+" :: "+rowsRef[i].desig+" :: "+rowsRef[i].mob+" :: "+rowsRef[i].email+" ::");
                            newTextBox.appendTo('form');
                        }
                    }
                    $('#referencelength').val(referencelength);
                    
                    var rowsCard = $("#jqxCreditCardDetails").jqxGrid('getrows');
                    var creditcardlength=0;
                    for(var i=0 ; i < rowsCard.length ; i++){
                        var chkng=rowsCard[i].type;
                        if(typeof(chkng) != "undefined"){
                            creditcardlength=creditcardlength+1;
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "txtcard"+i)
                            .attr("name", "txtcard"+i)
                            .attr("hidden", "true");
                            newTextBox.val(rowsCard[i].type+" :: "+rowsCard[i].cardno+" :: "+rowsCard[i].hidexpdate+":: "+rowsCard[i].defaultcard+":: "+rowsCard[i].remarks);
                            newTextBox.appendTo('form');
                        }
                    }
                    $('#creditcardlength').val(creditcardlength);
                    
                    if(parseInt($('#separateservicechargeallowed').val())==1){
                        var rowsSrv = $("#separateServiceChargeGridId").jqxGrid('getrows');
                        var separateservicechargelength=0;
                        for(var i=0 ; i < rowsSrv.length ; i++){
                            var chked=rowsSrv[i].doc_no;
                            if(typeof(chked) != "undefined"){
                                separateservicechargelength=separateservicechargelength+1;
                                newTextBox = $(document.createElement("input"))
                                .attr("type", "dil")
                                .attr("id", "txtseparateservicecharge"+i)
                                .attr("name", "txtseparateservicecharge"+i)
                                .attr("hidden", "true");
                                newTextBox.val(rowsSrv[i].doc_no+" :: "+rowsSrv[i].salik+" :: "+rowsSrv[i].traffic);
                                newTextBox.appendTo('form');
                            }
                        }
                        $('#separateservicechargelength').val(separateservicechargelength);
                    }
                    
                    $('#cmbgroup1').attr('disabled', false);
                    $("#frmClientMaster").submit(); 
                }
            }
        }
    }
    x.open("GET", "getClientAlreadyExists.jsp?clientname="+clientname+"&salutation="+salutation+"&docno="+docno+"&mode="+mode, true);
    x.send();
}
      
function getDriverDetailsVerification(driverdetails,docno,mode) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('####');
        
            if(parseInt(items[0])==1){
                document.getElementById("errormsg").innerText="Driver Details is Mandatory.";
                return 0;
            } else if(parseInt(items[0])==2){
                document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Mobile Number Required.";
                return 0;
            } else if(parseInt(items[0])==3){
                document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Mobile Number Already Exists.";
                return 0;
            } else if(parseInt(items[0])==4){
                document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Licence Number Required.";
                return 0;
            } else if(parseInt(items[0])==5){
                document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Licence Number Already Exists.";
                return 0;
            } else {
                var rows = $("#jqxDriver").jqxGrid('getrows');
                var length=0;
                for(var i=0 ; i < rows.length ; i++){
                    var chk=rows[i].name;
                    if(typeof(chk) != "undefined"){
                        length=length+1;
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "dil")
                        .attr("id", "test"+i)
                        .attr("name", "test"+i)
                        .attr("hidden", "true");
                        newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id+":: "+rows[i].hcdlno+":: "+rows[i].hidhcissdate+":: "+rows[i].hidhcled);
                        newTextBox.appendTo('form');
                    }
                }
                $('#gridlength').val(length);
                
                var rowsRef = $("#jqxReferenceDetails").jqxGrid('getrows');
                var referencelength=0;
                for(var i=0 ; i < rowsRef.length ; i++){
                    var chkd=rowsRef[i].cperson;
                    if(typeof(chkd) != "undefined"){
                        referencelength=referencelength+1;
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "dil")
                        .attr("id", "txtreference"+i)
                        .attr("name", "txtreference"+i)
                        .attr("hidden", "true");
                        newTextBox.val(rowsRef[i].cperson+" :: "+rowsRef[i].desig+" :: "+rowsRef[i].mob+" :: "+rowsRef[i].email+" ::");
                        newTextBox.appendTo('form');
                    }
                }
                $('#referencelength').val(referencelength);
                
                var rowsCard = $("#jqxCreditCardDetails").jqxGrid('getrows');
                var creditcardlength=0;
                for(var i=0 ; i < rowsCard.length ; i++){
                    var chkng=rowsCard[i].type;
                    if(typeof(chkng) != "undefined"){
                        creditcardlength=creditcardlength+1;
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "dil")
                        .attr("id", "txtcard"+i)
                        .attr("name", "txtcard"+i)
                        .attr("hidden", "true");
                        newTextBox.val(rowsCard[i].type+" :: "+rowsCard[i].cardno+" :: "+rowsCard[i].hidexpdate+":: "+rowsCard[i].defaultcard+":: "+rowsCard[i].remarks);
                        newTextBox.appendTo('form');
                    }
                }
                $('#creditcardlength').val(creditcardlength);
                
                if(parseInt($('#separateservicechargeallowed').val())==1){
                    var rowsSrv = $("#separateServiceChargeGridId").jqxGrid('getrows');
                    var separateservicechargelength=0;
                    for(var i=0 ; i < rowsSrv.length ; i++){
                        var chked=rowsSrv[i].doc_no;
                        if(typeof(chked) != "undefined"){
                            separateservicechargelength=separateservicechargelength+1;
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "txtseparateservicecharge"+i)
                            .attr("name", "txtseparateservicecharge"+i)
                            .attr("hidden", "true");
                            newTextBox.val(rowsSrv[i].doc_no+" :: "+rowsSrv[i].salik+" :: "+rowsSrv[i].traffic);
                            newTextBox.appendTo('form');
                        }
                    }
                    $('#separateservicechargelength').val(separateservicechargelength);
                }
                
                $('#cmbgroup1').attr('disabled', false);
                $("#frmClientMaster").submit(); 
            }
        }
    }
    x.open("GET", "getDriverDetailsVerification.jsp?driverdetails="+driverdetails+"&docno="+docno+"&mode="+mode, true);
    x.send();
}
	 
function getMobileNoAlreadyExists(mobileno,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                $.messager.alert('Message','Personal Mobile No. Already Exists.','warning');
                return 0;
            }
        }
    }
    x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
    x.send();
}

function getDrivingLicenceNoAlreadyExists(licenceno,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                $.messager.alert('Message','Licence# Already Exists.','warning');
                return 0;
            }  			   
        }
    }
    x.open("GET", "getDrivingLicenceNoAlreadyExists.jsp?licenceno="+licenceno+"&docno="+docno+"&mode="+mode, true);
    x.send();
}

function getVisaNoAlreadyExists(visano,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                $.messager.alert('Message','ID# Already Exists.','warning');
                return 0;
            }
        }
    }
    x.open("GET", "getVisaNoAlreadyExists.jsp?visano="+visano+"&docno="+docno+"&mode="+mode, true);
    x.send();
}
  
function getPassportNoAlreadyExists(passportno,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                $.messager.alert('Message','Passport# Already Exists.','warning');
                return 0;
            }
        }
    }
    x.open("GET", "getPassportNoAlreadyExists.jsp?passportno="+passportno+"&docno="+docno+"&mode="+mode, true);
    x.send();
}

function getContractDate(){
    if ($("#mode").val() == "A") {
        var curdate= $('#jqxClientDate').jqxDateTimeInput('getDate');
        var oneyeardate=new Date(new Date(curdate).setMonth(curdate.getMonth()+36));
        var oneyearafterdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
        $('#jqxContractDate ').jqxDateTimeInput('setDate', new Date(oneyearafterdate));
    }
}
  
function getDefaultService() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var serviceItems = items[0].split(",");
            var serviceRateItems = items[1].split(",");
            $('#txtsalik').val("0");
            $('#txtsalikauh').val("0");
            $('#txttraffic').val("0");
            for (var i = 0; i < serviceItems.length; i++) {
                if(serviceItems[i]=='saliksrv'){
                    $('#txtsalik').val(serviceRateItems[i]);
                }else if(serviceItems[i]=='trafficsrv'){
                    $('#txttraffic').val(serviceRateItems[i]);
                } else if(serviceItems[i]=='saliksrvAUH'){
                    $('#txtsalikauh').val(serviceRateItems[i]);
                }
            }
        }
    }
    x.open("GET", "getDefaultServiceCharge.jsp", true);
    x.send();
}
	
function getDefaultInvoicingMethod(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#cmbinvoicing_method').val(items);
        }
    }
    x.open("GET", "getDefaultInvoicingMethod.jsp", true);
    x.send();
}
  
function getTax() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var taxItems = items[0].split(",");
            var taxIdItems = items[1].split(",");
            var optionstax = '';
            for (var i = 0; i < taxItems.length; i++) {
                optionstax += '<option value="' + taxIdItems[i] + '">' + taxItems[i] + '</option>';
            }
            $("select#cmbtax").html(optionstax);
            if ($('#hidcmbtax').val() != null) {
                $('#cmbtax').val($('#hidcmbtax').val());
            }
        }
    }
    x.open("GET", "getTax.jsp", true);
    x.send();
}
  
function getNonTaxableEntity(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1) {
                document.getElementById("lblnontaxableentity").style.display = 'none';
                $('#chcknontaxableentity').attr('hidden', false);
                document.getElementById("lbltaxableentity").style.display = 'inline-block';
                $('#cmbtax').attr('hidden', false);
                document.getElementById("lbltrnnoentity").style.display = 'inline-block';
                $('#txtregisteredtrnno').attr('hidden', false);
                if($('#mode').val()=='A') {
                    $('#hidchcknontaxableentity').val(1);
                    document.getElementById("chcknontaxableentity").checked = true;
                }
            } else {
                document.getElementById("lblnontaxableentity").style.display = 'none';
                $('#chcknontaxableentity').attr('hidden', true);
                document.getElementById("lbltaxableentity").style.display = 'none';
                $('#cmbtax').attr('hidden', true);
                document.getElementById("lbltrnnoentity").style.display = 'none';
                $('#txtregisteredtrnno').attr('hidden', true);
                if($('#mode').val()=='A') {
                    $('#hidchcknontaxableentity').val(0);
                    document.getElementById("chcknontaxableentity").checked = false;
                }
            }
        }
    }
    x.open("GET", "getNonTaxableEntity.jsp", true);
    x.send();
}
  
function nationalitySearchContent(url) {
    $('#nationalityWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#nationalityWindow').jqxWindow('setContent', data);
        $('#nationalityWindow').jqxWindow('bringToFront');
    }); 
}
  
function stateSearchContent(url) {
    $('#stateWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#stateWindow').jqxWindow('setContent', data);
        $('#stateWindow').jqxWindow('bringToFront');
    }); 
}
  
$(function(){
    $('#frmClientMaster').validate({
        rules: {
            txtclient_name:"required",
            cmbcategory:"required",
            cmbsalesman:"required"
        },
        messages: {
            txtclient_name:" *",
            cmbcategory:" *",
            cmbsalesman:" *"
        }
    });
});
  
function defaultcheck(){
    if(document.getElementById("chckdefault").checked){
        document.getElementById("hidchckdefault").value = 1;
        $('#txtsalik').attr('readonly', true );
        $('#txtsalikauh').attr('readonly', true );
        $('#txttraffic').attr('readonly', true );
        getDefaultService();
    } else {
        document.getElementById("hidchckdefault").value = 0;
        $('#txtsalik').attr('readonly', false );
        $('#txtsalik').val("0.0");
        $('#txtsalikauh').attr('readonly', false );
        $('#txtsalikauh').val("0.0");
        $('#txttraffic').attr('readonly', false );
        $('#txttraffic').val("0.0");
    }
}
 
function defaultseparateservicecheck(){
    if(document.getElementById("chckseparatesrvcdefault").checked){
        document.getElementById("hidchckseparatesrvcdefault").value = 1;
    } else {
        document.getElementById("hidchckseparatesrvcdefault").value = 0;
    }
    getDefaultSeparateService();
}
 
function getDefaultSeparateService(){
    if(parseInt($('#separateservicechargeallowed').val())==1){
        $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=2&defaultsevicecharge="+$('#hidchckseparatesrvcdefault').val());
    }
}
 
function advancecheck(){
    if(document.getElementById("chckadvance").checked){
        document.getElementById("hidchckadvance").value = 1;
    } else{
        document.getElementById("hidchckadvance").value = 0;
    }
}
 
function nontaxableentitycheck() {
    if(document.getElementById("chcknontaxableentity").checked){
        document.getElementById("hidchcknontaxableentity").value = 1;
    } else{
        document.getElementById("hidchcknontaxableentity").value = 0;
    }
}
 
function mobileValid(value){
    if(value!=""){ 
        var phoneno = /^\d{12}$/;  
        if(value.match(phoneno)){
            document.getElementById("errormsg").innerText="";
            $('#txtmobilevalidation').val(0);
            return true;
        } else {
            document.getElementById("errormsg").innerText="Invalid Mobile Number";
            $('#txtmobilevalidation').val(1);
            return false;
        }
    } 
    return true;
}
  
function funReadOnly(){
    $('#frmClientMaster input').attr('readonly', true );
    $('#frmClientMaster select').attr('disabled', true);
    $('#jqxClientDate').jqxDateTimeInput({disabled: true});
    $('#jqxContractDate').jqxDateTimeInput({disabled: true});
    $('#dateOfJoining').jqxDateTimeInput({disabled: true});
    $('#chcknontaxableentity').attr('disabled', true);
    $('#chckseparatesrvcdefault').attr('disabled', true);
    $("#separateServiceChargeGridId").jqxGrid({ disabled: true});
    $("#jqxReferenceDetails").jqxGrid({ disabled: true});
    $("#jqxCreditCardDetails").jqxGrid({ disabled: true});
    $('#cpDetailsGrid').jqxGrid({ disabled: true});
}
 
function funRemoveReadOnly(){
    getContract();getIDPDetails();getCRMDriverDetailsVerify();getSeparateServiceChargeAllowed();getNonTaxableEntity();
    $('#frmClientMaster input').attr('readonly', false );
    $('#frmClientMaster select').attr('disabled', false);
    $('#cpDetailsGrid').jqxGrid({ disabled: false});
    $('#chckdefault').attr('disabled', false);
    $('#chckseparatesrvcdefault').attr('disabled', false);
    $('#cmbgroup1').attr('disabled', true);
    $('#chcknontaxableentity').attr('disabled', false);
    $('#jqxClientDate').jqxDateTimeInput({disabled: false});
    $('#jqxContractDate').jqxDateTimeInput({disabled: false});
    $('#dateOfJoining').jqxDateTimeInput({disabled: false});
    $('#txtaccount').attr('readonly', true);
    $('#txtcode').attr('readonly', true);
    $('#docno').attr('readonly', true);
    $("#jqxReferenceDetails").jqxGrid({ disabled: false});
    $("#jqxCreditCardDetails").jqxGrid({ disabled: false});
    $("#separateServiceChargeGridId").jqxGrid({ disabled: false});
    
    if ($("#mode").val() == "A") {
        getDefaultService();getDefaultInvoicingMethod();
        $('#txtsalik').attr('readonly', true );
        $('#txtsalikauh').attr('readonly', true );
        $('#txttraffic').attr('readonly', true );
        $('#hidchckdefault').val(1);
        $('#hidchckseparatesrvcdefault').val(1);
        $('#hidchckadvance').val(0);
        document.getElementById("chckdefault").checked = true;
        document.getElementById("chckseparatesrvcdefault").checked = true;
        document.getElementById("chckadvance").checked = false;
        $('#cmbsalesman').prop('selectedIndex',0);
        $('#cmbtax').prop('selectedIndex',0);
        
        $('#jqxClientDate').val(new Date());
        $('#jqxContractDate').val(null);
        $('#dateOfJoining').val(null);
        
        $("#jqxCreditCardDetails").jqxGrid('clear'); 
        $("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
        $("#jqxReferenceDetails").jqxGrid('clear'); 
        $("#jqxReferenceDetails").jqxGrid('addrow', null, {});
        $("#separateServiceChargeGridId").jqxGrid('clear'); 
        
        $("#cpDetailsGrid").jqxGrid('clear');
        $("#cpDetailsGrid").jqxGrid("addrow", null, {});
    }
    
    if ($("#mode").val() == "E") {
        $("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
        $("#jqxReferenceDetails").jqxGrid('addrow', null, {});
        $("#cpDetailsGrid").jqxGrid("addrow", null, {});
    }
}

function funNotify(){	
    valid=document.getElementById("txtvalidation").value;
    if(valid==1){
        document.getElementById("errormsg").innerText="Invalid Values.";
        return 0;
    }
    
    accgroup=document.getElementById("txtcategoryvalidation").value;
    if(accgroup==1){
        document.getElementById("errormsg").innerText="Individual Client should have Retail Client A/C Group.";
        return 0;
    }
    
    chkcardvalid=document.getElementById("chkcardvalid").value;
    if(chkcardvalid==1){
        document.getElementById("errormsg").innerText="Invalid Credit Card.";
        return 0;
    }
    
    var tax=document.getElementById("cmbtax").value;
    if(tax.trim()=='' || tax.trim()=='0'){
        document.getElementById("errormsg").innerText="Tax is Mandatory.";
        return 0;
    }
    
    if($('#cmbtax').val()=='1'){
        var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
        if(registeredtrnno.trim()==''){
            document.getElementById("errormsg").innerText="TRN No. is Mandatory for VAT.";
            return 0;
        } 
    }
    
    var account=document.getElementById("cmbgroup1").value;
    if(account=="") {
        document.getElementById("errormsg").innerText=" Enter Account Group";
        document.getElementById("cmbgroup1").focus();  
        return 0;
    }
        
    var rows = $("#cpDetailsGrid").jqxGrid('getrows');
    var len=0;
    for(var i=0;i<rows.length;i++){
        var cpersion= $.trim(rows[i].cpersion);
        if(cpersion.trim()!="" && typeof(cpersion)!="undefined" && typeof(cpersion)!="NaN" ) {
            newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "test"+len)
                .attr("name", "test"+len)
                .attr("hidden", "true");
            newTextBox.val(rows[i].cpersion+"::"+rows[i].mobile+" :: "+rows[i].phone+" :: "+rows[i].extn+" :: "
                    +rows[i].email+" :: "+rows[i].area+" :: "+rows[i].areaid+" :: "+rows[i].activity_id+" :: "+rows[i].row_no+"");
            newTextBox.appendTo('form'); 
            len=len+1;
        }
    }
    $('#cpgridlength').val(len);
    
    document.getElementById("errormsg").innerText="";		 
    clientname=document.getElementById("txtclient_name").value;
    salutation=document.getElementById("cmbsalutation").value;
    docno=document.getElementById("docno").value;
    mode=document.getElementById("mode").value;
    getClientAlreadyExists(clientname,salutation,docno,mode);
} 
 
function setValues(){
    getSeparateServiceChargeAllowed();
    document.getElementById("formdetail").value="Client";
    document.getElementById("formdetailcode").value="CRM";
      
    if($('#hidjqxClientDate').val()){
        $("#jqxClientDate").jqxDateTimeInput('val', $('#hidjqxClientDate').val());
    }
    if($('#hidjqxContractDate').val()){
        $("#jqxContractDate").jqxDateTimeInput('val', $('#hidjqxContractDate').val());
    }
    if($('#hiddateOfJoining').val()){
        $("#dateOfJoining").jqxDateTimeInput('val', $('#hiddateOfJoining').val());
    }
    
    if(document.getElementById("hidchckdefault").value==1){
        document.getElementById("chckdefault").checked = true;
    } else if(document.getElementById("hidchckdefault").value==0){
        document.getElementById("chckdefault").checked = false;
    }
    
    if(document.getElementById("hidchckseparatesrvcdefault").value==1){
        document.getElementById("chckseparatesrvcdefault").checked = true;
    } else if(document.getElementById("hidchckseparatesrvcdefault").value==0){
        document.getElementById("chckseparatesrvcdefault").checked = false;
    }
    
    if(document.getElementById("hidchckadvance").value==1){
        document.getElementById("chckadvance").checked = true;
    } else if(document.getElementById("hidchckadvance").value==0){
        document.getElementById("chckadvance").checked = false;
    }
    
    if(document.getElementById("hidchcknontaxableentity").value==1){
        document.getElementById("chcknontaxableentity").checked = true;
    } else if(document.getElementById("hidchcknontaxableentity").value==0){
        document.getElementById("chcknontaxableentity").checked = false;
    }
    
    if($('#hidcmbcurrency').val()!=""){
        getCurrencyIds();
        $('#cmbcurrency').val($('#hidcmbcurrency').val());
    }
    
    document.getElementById("cmbinvoicing_method").value=document.getElementById("hidcmbinvoicing_method").value;
    $('#cmbdel_charges').val($('#hidcmbdel_charges').val());  
    
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
    
    var indexVal1 = document.getElementById("txtcode").value;
    if(indexVal1>0) {
        $("#cpGridDetails").load('cpGridDetails.jsp?cldocno='+indexVal1);
    }
  
    var indexVal = document.getElementById("docno").value;
    if(indexVal> 0){
        getCategoryWiseEditEnable($('#cmbcategory').val());
        var check = 1;
        $("#creditCardDetailsDiv").load("creditCardDetailsGrid.jsp?txtclientdocno2="+indexVal+"&check="+check);
        $("#jqxReferenceDetails1").load("referenceDetails.jsp?txtclientdocno3="+indexVal+"&check="+check);
        $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=1&txtclientdocno4="+indexVal);
    }
}
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientMaster" action="saveClientMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    
    <!-- TOP SECTION: Client Identification Info -->
    <div class="middle-panel">
        <span class="middle-panel-title">Client Identification</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxClientDate" name="jqxClientDate" onchange="getContractDate();" value='<s:property value="jqxClientDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxClientDate" name="hidjqxClientDate" value='<s:property value="hidjqxClientDate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Code</label>
            <input type="text" id="txtcode" name="txtcode" style="width:100px;" tabindex="-1" value='<s:property value="txtcode"/>'/>
            
            <label class="lbl-right" style="width:60px;">Name</label>
            <input type="text" id="txtclient_name" name="txtclient_name" onfocus="getCurrencyIds();" style="flex:1;" value='<s:property value="txtclient_name"/>'/>
            
            <label class="lbl-right" style="width:80px;">Salutation</label>
            <select id="cmbsalutation" name="cmbsalutation" style="width:100px;" value='<s:property value="cmbsalutation"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbsalutation" name="hidcmbsalutation" value='<s:property value="hidcmbsalutation"/>'/>
            
            <label class="lbl-right" style="width:80px;">Currency</label>
            <select id="cmbcurrency" name="cmbcurrency" style="width:100px;" value='<s:property value="cmbcurrency"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            
            <label class="lbl-right" style="width:80px;">Doc No</label>
            <input type="text" id="docno" name="txtclientdocno" tabindex="-1" value='<s:property value="txtclientdocno"/>' style="width:100px;" readonly />
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Category</label>
            <select id="cmbcategory" name="cmbcategory" style="width:125px;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
            
            <label class="lbl-right" style="width:80px;">Salesman</label>
            <select id="cmbsalesman" name="cmbsalesman" style="flex:1;" value='<s:property value="cmbsalesman"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'/>
            
            <label style="margin-left:20px; display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;" id="lblnontaxableentity">
                <input type="checkbox" id="chcknontaxableentity" name="chcknontaxableentity" style="display: none;" value="" onchange="nontaxableentitycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                Taxable Entity
            </label>
            <input type="hidden" id="hidchcknontaxableentity" name="hidchcknontaxableentity" value='<s:property value="hidchcknontaxableentity"/>'/>
            
            <label style="margin-left:20px; display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                <input type="checkbox" id="chckadvance" name="chckadvance" value="" onchange="advancecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                Advance
            </label>
            <input type="hidden" id="hidchckadvance" name="hidchckadvance" value='<s:property value="hidchckadvance"/>'/>
            
            <label class="lbl-right" style="width:120px;">Invoicing Method</label>
            <select id="cmbinvoicing_method" name="cmbinvoicing_method" style="width:120px;" value='<s:property value="cmbinvoicing_method"/>'>
                <option value="">--Select--</option>
                <option value="1">Month End</option>
                <option value="2">Period</option>
            </select>
            <input type="hidden" id="hidcmbinvoicing_method" name="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/>
            
            <label class="lbl-right" style="width:120px;">Knowledge Fee</label>
            <select id="cmbdel_charges" name="cmbdel_charges" style="width:100px;" value='<s:property value="cmbdel_charges"/>'>
                <option value="">--Select--</option>
                <option value=1>Yes</option>
                <option value=0>No</option>
            </select>
            <input type="hidden" id="hidcmbdel_charges" name="hidcmbdel_charges" value='<s:property value="hidcmbdel_charges"/>'/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" id="lbltaxableentity" style="width:80px;">Tax</label>
            <select id="cmbtax" name="cmbtax" style="width:125px;" onchange="taxcheck();" value='<s:property value="cmbtax"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbtax" name="hidcmbtax" value='<s:property value="hidcmbtax"/>'/>
            
            <label class="lbl-right" id="lbltrnnoentity" style="width:80px;">TRN No.</label>
            <input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" style="flex:1;" value='<s:property value="txtregisteredtrnno"/>'/>
        </div>
    </div>

    <!-- MIDDLE SECTION: Accounts & Service Charges -->
    <div style="display: flex; gap: 15px;">
        <div class="middle-panel" style="flex: 6; margin-bottom: 0;">
            <span class="middle-panel-title">Account Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Account Group</label>
                <select id="cmbgroup1" name="cmbgroup1" style="flex:1;" value='<s:property value="cmbgroup1"/>'>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbgroup1" name="hidcmbgroup1" value='<s:property value="hidcmbgroup1"/>'/>
                
                <label class="lbl-right" style="width:100px;">Account</label>
                <input type="text" id="txtaccount" name="txtaccount" style="width:150px;" tabindex="-1" value='<s:property value="txtaccount"/>' readonly />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:150px;">Credit Period-Min(Days)</label>
                <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:80px; text-align:right;" value='<s:property value="txtcredit_period_min"/>'/>
                
                <label class="lbl-right" style="width:80px;">Max(Days)</label>
                <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:80px; text-align:right;" value='<s:property value="txtcredit_period_max"/>'/>
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Credit Limit</label>
                <input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:100px; text-align:right;" value='<s:property value="txtcredit_limit"/>'/>
            </div>
        </div>
        
        <div class="middle-panel" style="flex: 4; margin-bottom: 0;">
            <span class="middle-panel-title">Service Charge</span>
            
            <div id="singleServiceChargeDiv">
                <div class="field-row">
                    <label style="display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                        <input type="checkbox" id="chckdefault" name="chckdefault" value="" onchange="defaultcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                        Default
                    </label>
                    <input type="hidden" id="hidchckdefault" name="hidchckdefault" value='<s:property value="hidchckdefault"/>'/>
                    
                    <label class="lbl-right" style="width:100px; margin-left:auto;">Salik DXB</label>
                    <input type="text" id="txtsalik" name="txtsalik" style="width:100px; text-align:right;" value='<s:property value="txtsalik"/>'/>
                    
                    <label class="lbl-right" style="width:80px;">Traffic</label>
                    <input type="text" id="txttraffic" name="txttraffic" style="width:80px; text-align:right;" value='<s:property value="txttraffic"/>'/>
                </div>
                <div class="field-row" style="margin-bottom:0; justify-content:flex-end;">
                    <label class="lbl-right" style="width:100px;">DARB</label>
                    <input type="text" id="txtsalikauh" name="txtsalikauh" style="width:100px; text-align:right;" value='<s:property value="txtsalikauh"/>'/>
                    <div style="width: 170px;"></div> <!-- spacer to align with above inputs -->
                </div>
            </div>

            <div id="separateServiceChargeDiv" style="display:none;">
                <div class="field-row">
                    <label style="display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                        <input type="checkbox" id="chckseparatesrvcdefault" name="chckseparatesrvcdefault" value="" onchange="defaultseparateservicecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                    </label>
                    <input type="hidden" id="hidchckseparatesrvcdefault" name="hidchckseparatesrvcdefault" value='<s:property value="hidchckseparatesrvcdefault"/>'/>
                    <div id="separateServiceChargeGridDiv" style="flex:1;">
                        <jsp:include page="separateServiceChargesGrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <br/>
    
    <!-- BOTTOM TABS (Re-purposed to modern style, but retaining identical markup logic for child views) -->
    <div style="border: 1px solid #c5d3e0; border-radius: 4px; background: #ffffff; padding-bottom: 5px;">
        <ul id="tabs">
            <li><a href="#" name="tab1">Contact Person</a></li>
            <li><a href="#" name="tab2">Know Your Customer</a></li>
            <li><a href="#" name="tab3">Banking Details</a></li>
            <li><a href="#" name="tab4">Others</a></li>
        </ul>
        
        <div id="content">
            <!-- TAB 1: Contact Person -->
            <div id="tab1">
                <div style="width:100%; padding:15px;">
                    <div id="cpGridDetails"> <jsp:include page="cpGridDetails.jsp"></jsp:include></div>
                </div>
            </div>

            <!-- TAB 2: Know Your Customer -->
            <div id="tab2">
                <div style="width:100%; padding:15px; overflow-x:auto;">
                    <table style="width:100%; border-collapse:collapse; text-align:left; font-size:12px;">
                        <thead>
                            <tr> 
                                <th></th>
                                <th style="background:#D1D1D1; padding:5px; border:1px solid #c5d3e0;">Communication Details</th>
                                <th style="padding:5px; border:1px solid #c5d3e0;">Office Details</th>
                                <th style="padding:5px; border:1px solid #c5d3e0;">Residence Details</th>
                                <th style="padding:5px; border:1px solid #c5d3e0;">Home Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th style="padding:5px; border:1px solid #c5d3e0; text-align:right;">Address 1</th>
                                <td style="background:#D5D5D5; padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtpersonal_add1" name="txtpersonal_add1" style="width:100%; border:none; background:transparent;" tabindex="3" value='<s:property value="txtpersonal_add1"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtoffice_add1" name="txtoffice_add1" style="width:100%; border:none;" tabindex="11" value='<s:property value="txtoffice_add1"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtresidence_add1" name="txtresidence_add1" style="width:100%; border:none;" tabindex="19" value='<s:property value="txtresidence_add1"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txthome_add1" name="txthome_add1" style="width:100%; border:none;" tabindex="27" value='<s:property value="txthome_add1"/>'/></td>
                            </tr>
                            <tr>
                                <th style="padding:5px; border:1px solid #c5d3e0; text-align:right;">Address 2</th>
                                <td style="background:#D5D5D5; padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtpersonal_add2" name="txtpersonal_add2" style="width:100%; border:none; background:transparent;" tabindex="4" value='<s:property value="txtpersonal_add2"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtoffice_add2" name="txtoffice_add2" style="width:100%; border:none;" tabindex="12" value='<s:property value="txtoffice_add2"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtresidence_add2" name="txtresidence_add2" style="width:100%; border:none;" tabindex="20" value='<s:property value="txtresidence_add2"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txthome_add2" name="txthome_add2" style="width:100%; border:none;" tabindex="28" value='<s:property value="txthome_add2"/>'/></td>
                            </tr>
                            <tr>
                                <th style="padding:5px; border:1px solid #c5d3e0; text-align:right;">Telephone</th>
                                <td style="background:#D5D5D5; padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtpersonal_tel1" name="txtpersonal_tel1" style="width:100%; border:none; background:transparent;" tabindex="5" value='<s:property value="txtpersonal_tel1"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtoffice_tel1" name="txtoffice_tel1" style="width:100%; border:none;" tabindex="13" value='<s:property value="txtoffice_tel1"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtresidence_tel1" name="txtresidence_tel1" style="width:100%; border:none;" tabindex="21" value='<s:property value="txtresidence_tel1"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txthome_tel1" name="txthome_tel1" style="width:100%; border:none;" tabindex="29" value='<s:property value="txthome_tel1"/>'/></td>
                            </tr>
                            <tr>
                                <th style="padding:5px; border:1px solid #c5d3e0; text-align:right;">Mobile</th>
                                <td style="background:#D5D5D5; padding:2px; border:1px solid #c5d3e0;"><input type="text" id="personal_tel2" name="personal_tel2" style="width:100%; border:none; background:transparent;" onblur="mobileValid(this.value);getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" tabindex="6" value='<s:property value="personal_tel2"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="office_tel2" name="office_tel2" style="width:100%; border:none;" onblur="mobileValid(this.value);" tabindex="14" value='<s:property value="office_tel2"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="residence_tel2" name="residence_tel2" style="width:100%; border:none;" onblur="mobileValid(this.value);" tabindex="22" value='<s:property value="residence_tel2"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="home_tel2" name="home_tel2" style="width:100%; border:none;" onblur="mobileValid(this.value);" tabindex="30" value='<s:property value="home_tel2"/>'/></td>
                            </tr>
                            <tr>
                                <th style="padding:5px; border:1px solid #c5d3e0; text-align:right;">Fax</th>
                                <td style="background:#D5D5D5; padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtpersonal_fax" name="txtpersonal_fax" style="width:100%; border:none; background:transparent;" tabindex="7" value='<s:property value="txtpersonal_fax"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtoffice_fax" name="txtoffice_fax" style="width:100%; border:none;" tabindex="15" value='<s:property value="txtoffice_fax"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtresidence_fax" name="txtresidence_fax" style="width:100%; border:none;" tabindex="23" value='<s:property value="txtresidence_fax"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txthome_fax" name="txthome_fax" style="width:100%; border:none;" tabindex="31" value='<s:property value="txthome_fax"/>'/></td>
                            </tr>
                            <tr>
                                <th style="padding:5px; border:1px solid #c5d3e0; text-align:right;">Email</th>
                                <td style="background:#D5D5D5; padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtpersonal_email" name="txtpersonal_email" placeholder="someone@example.com" style="width:100%; border:none; background:transparent;" tabindex="8" value='<s:property value="txtpersonal_email"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtoffice_email" name="txtoffice_email" placeholder="someone@example.com" style="width:100%; border:none;" tabindex="16" value='<s:property value="txtoffice_email"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtresidence_email" name="txtresidence_email" placeholder="someone@example.com" style="width:100%; border:none;" tabindex="24" value='<s:property value="txtresidence_email"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txthome_email" name="txthome_email" placeholder="someone@example.com" style="width:100%; border:none;" tabindex="32" value='<s:property value="txthome_email"/>'/></td>
                            </tr>
                            <tr>
                                <th style="padding:5px; border:1px solid #c5d3e0; text-align:right;">Contact</th>
                                <td style="background:#D5D5D5; padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtpersonal_contact" name="txtpersonal_contact" style="width:100%; border:none; background:transparent;" tabindex="9" value='<s:property value="txtpersonal_contact"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtoffice_contact" name="txtoffice_contact" style="width:100%; border:none;" tabindex="17" value='<s:property value="txtoffice_contact"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtresidence_contact" name="txtresidence_contact" style="width:100%; border:none;" tabindex="25" value='<s:property value="txtresidence_contact"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txthome_contact" name="txthome_contact" style="width:100%; border:none;" tabindex="33" value='<s:property value="txthome_contact"/>'/></td>
                            </tr>
                            <tr>
                                <th style="padding:5px; border:1px solid #c5d3e0; text-align:right;">Makani No.</th>
                                <td style="background:#D5D5D5; padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtpersonal_extn_no" name="txtpersonal_extn_no" style="width:100%; border:none; background:transparent;" tabindex="10" value='<s:property value="txtpersonal_extn_no"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtoffice_extn_no" name="txtoffice_extn_no" style="width:100%; border:none;" tabindex="18" value='<s:property value="txtoffice_extn_no"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txtresidence_extn_no" name="txtresidence_extn_no" style="width:100%; border:none;" tabindex="26" value='<s:property value="txtresidence_extn_no"/>'/></td>
                                <td style="padding:2px; border:1px solid #c5d3e0;"><input type="text" id="txthome_extn_no" name="txthome_extn_no" style="width:100%; border:none;" tabindex="34" value='<s:property value="txthome_extn_no"/>'/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- TAB 3: Banking Details -->
            <div id="tab3">
                <div style="padding:15px;">
                    <div class="middle-panel" style="margin-bottom:0;">
                        <span class="middle-panel-title">Credit Card Details</span>
                        <div id="creditCardDetailsDiv"> <jsp:include page="creditCardDetailsGrid.jsp"></jsp:include></div>
                    </div>
                </div>
            </div>

            <!-- TAB 4: Others -->
            <div id="tab4">
                <div style="display: flex; gap: 15px; padding:15px;">
                    <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                        <span class="middle-panel-title">Reference Details</span>
                        <div id="jqxReferenceDetails1"><jsp:include page="referenceDetails.jsp"></jsp:include></div>
                    </div>
                    
                    <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                        <span class="middle-panel-title">Sponsor/Company Details</span>
                        
                        <div class="field-row">
                            <label class="lbl-right" style="width:100px;">Name</label>
                            <input type="text" id="txtname" name="txtname" style="flex:1;" value='<s:property value="txtname"/>'/>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width:100px;">Address</label>
                            <input type="text" id="txtaddress" name="txtaddress" style="flex:1;" value='<s:property value="txtaddress"/>'/>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width:100px;">Telephone</label>
                            <input type="text" id="txttelephone" name="txttelephone" style="width:100px;" value='<s:property value="txttelephone"/>'/>
                            
                            <label class="lbl-right" style="width:50px; margin-left:auto;">ID.</label>
                            <input type="text" id="txtid" name="txtid" style="width:100px;" value='<s:property value="txtid"/>'/>
                            
                            <label class="lbl-right" style="width:80px; margin-left:auto;">Nationality</label>
                            <select id="cmbnationality" name="cmbnationality" style="flex:1;" value='<s:property value="cmbnationality"/>'>
                                <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbnationality" name="hidcmbnationality" value='<s:property value="hidcmbnationality"/>'/>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width:100px;">Security</label>
                            <input type="text" id="txtsecurity" name="txtsecurity" style="width:100px;" value='<s:property value="txtsecurity"/>'/>
                            <input type="text" id="txtsecurity1" name="txtsecurity1" style="flex:1; margin-left:8px;" value='<s:property value="txtsecurity1"/>'/>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width:100px;">Job Title</label>
                            <input type="text" id="txtjobtitle" name="txtjobtitle" style="flex:1;" value='<s:property value="txtjobtitle"/>'/>
                            
                            <label class="lbl-right" style="width:120px; margin-left:auto;">Date of Joining</label>
                            <div style="width: 125px;">
                                <div id="dateOfJoining" name="dateOfJoining" value='<s:property value="dateOfJoining"/>'></div>
                            </div>
                            <input type="hidden" id="hiddateOfJoining" name="hiddateOfJoining" value='<s:property value="hiddateOfJoining"/>'/>
                        </div>
                        <div class="field-row" style="margin-bottom:0;">
                            <label class="lbl-right" style="width:100px;">Bank Name</label>
                            <input type="text" id="txtbankname" name="txtbankname" style="flex:1;" value='<s:property value="txtbankname"/>'/>
                        </div>

                        <div id="sponsorDiv" style="height: 100px;"></div>
                        
                        <div id="contractDiv" style="display:none; margin-top: 20px;">
                            <div class="middle-panel" style="margin-bottom:0;">
                                <span class="middle-panel-title">Trade Licence Details</span>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">Trade Licence No.</label>
                                    <input type="text" id="txtcontractno" name="txtcontractno" style="flex:1;" value='<s:property value="txtcontractno"/>'/>
                                    
                                    <label class="lbl-right" style="width:140px;">Trade Licence Date</label>
                                    <div style="width: 125px;">
                                        <div id="jqxContractDate" name="jqxContractDate" value='<s:property value="jqxContractDate"/>'></div>
                                    </div>
                                    <input type="hidden" id="hidjqxContractDate" name="hidjqxContractDate" value='<s:property value="hidjqxContractDate"/>'/>
                                </div>
                                <div class="field-row" style="margin-bottom:0;">
                                    <label class="lbl-right" style="width:120px;">Remarks</label>
                                    <input type="text" id="txtcontractremarks" name="txtcontractremarks" style="flex:1;" value='<s:property value="txtcontractremarks"/>'/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="cpgridlength" name="cpgridlength"/>
        <input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed" value='<s:property value="idpdetailsallowed"/>'/>
        <input type="hidden" id="driverdetailsverifyallowed" name="driverdetailsverifyallowed" value='<s:property value="driverdetailsverifyallowed"/>'/>
        <input type="hidden" id="separateservicechargeallowed" name="separateservicechargeallowed" value='<s:property value="separateservicechargeallowed"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
        <input type="hidden" id="txtforcontractdiv" name="txtforcontractdiv"/>
        <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
        <input type="hidden" id="txtcategoryvalidation" name="txtcategoryvalidation" value='<s:property value="txtcategoryvalidation"/>'/>
        <input type="text" id="txtcategorywiseedit" name="txtcategorywiseedit" value='<s:property value="txtcategorywiseedit"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="referencelength" name="referencelength"/>
        <input type="hidden" id="attachlength" name="attachlength"/>
        <input type="hidden" id="creditcardlength" name="creditcardlength"/>
        <input type="hidden" id="separateservicechargelength" name="separateservicechargelength"/>
    </div>
    
    <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px; text-align:center;"></div>

</div>
</form>

<!-- Search Windows -->
<div id="nationalityWindow"><div></div></div>
<div id="stateWindow"><div></div></div>
<div id="activityinfowindow"><div></div></div>
<div id="areainfowindow"><div></div></div>

</div>
</body>
</html>