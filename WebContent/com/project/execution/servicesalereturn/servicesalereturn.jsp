<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
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
    $("#cmbcurr").css("pointer-events","none");
    getAccountTypeEntity();
    
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#nipurchasedate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#deliverydate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#invDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#nipurchasedate, #deliverydate, #invDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#nipurchasedate, #deliverydate, #invDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    $('#nipurchasedate').on('change', function (event) {
        var maindate = $('#nipurchasedate').jqxDateTimeInput('getDate');
        if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
            funDateInPeriod(maindate);
        }
    });
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '75%',  maxHeight: '74%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
    $('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
    $('#accounttypeSearchwindow').jqxWindow('close');
    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, keyboardCloseKey: 27});
    $('#costtpesearchwndow').jqxWindow('close');   
    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, keyboardCloseKey: 27});
    $('#costcodesearchwndow').jqxWindow('close');  
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Ref No Search' ,position: { x: 450, y: 40 }, keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close');  
    $('#nipurchslnosearch').jqxWindow({ width: '50%', height: '59%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 200, y: 60}, keyboardCloseKey: 27});
    $('#nipurchslnosearch').jqxWindow('close');
    $('#printWindow').jqxWindow({width: '30%', height: '19%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#printWindow').jqxWindow('close');

    getCurrencyIds($("#nipurchasedate").val());
     
    $('#nipuraccid').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountDetailsFromSearch.jsp?type='+$('#cmbtype').val());
        } 
    });   
    
    $('#rrefno').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#refnosearchwindow').jqxWindow('open');
            refnoSearchContent('ordermainsearch.jsp?');
        }
    }); 
});

function getAccountTypeEntity(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(items==1){
                $("#typetd1").show();
                $("#typetd2").show();
            } else{
                $("#typetd1").hide();
                $("#typetd2").hide();
            }
        }
    }
    x.open("GET", "getAccountTypeEntity.jsp", true);
    x.send();
}
	
function getNonTaxableEntity(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#txtnontaxableentity').val(items);
            if(parseInt($('#txtnontaxableentity').val().trim())==1){
                getTaxper($("#nipurchasedate").jqxDateTimeInput('val'));
            }
        }
    }
    x.open("GET", "getNonTaxableEntity.jsp", true);
    x.send();
}

function refnoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#refnosearchwindow').jqxWindow('open');
        $('#refnosearchwindow').jqxWindow('setContent', data);
    }); 
} 

function getrefnosearch(event){
    var x= event.keyCode;
    if($('#mode').val()!= "view") {
        if(x==114){
            $('#refnosearchwindow').jqxWindow('open');
            refnoSearchContent('ordermainsearch.jsp?');   
        }
    }
}  
				
function getTaxper(date){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#taxperc').val(items);
        }
    }
    x.open("GET", "getTaxper.jsp?date="+date, true);
    x.send();
}

function costcodeSearchContent(url) {
    $.get(url).done(function (data) {
        $('#costcodesearchwndow').jqxWindow('open');
        $('#costcodesearchwndow').jqxWindow('setContent', data);
    }); 
}  
	
function costSearchContent(url) {
    $.get(url).done(function (data) {
        $('#costtpesearchwndow').jqxWindow('open');
        $('#costtpesearchwndow').jqxWindow('setContent', data);
    }); 
} 
							
function CashSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accounttypeSearchwindow').jqxWindow('open');
        $('#accounttypeSearchwindow').jqxWindow('setContent', data);
    }); 
} 

function getaccountdetails(event){
    var x= event.keyCode;
    if($('#mode').val()!= "view") {
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountDetailsFromSearch.jsp?type='+$('#cmbtype').val());  
        }
    } 
}  

function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}

function nipurhsaeslnocontent(url) {
    $.get(url).done(function (data) {
        $('#nipurchslnosearch').jqxWindow('open');
        $('#nipurchslnosearch').jqxWindow('setContent', data);
    }); 
} 
		  
function funFocus(){
    $('#nipurchasedate').jqxDateTimeInput('focus');  		
}
			
function funNotify(){	
    var maindate = $('#nipurchasedate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(maindate);
    if(validdate==0){ return 0; }  

    var val1=0;     
    var rows = $('#nidescdetailsGrid').jqxGrid('getrows');     
    for(var i=0;i<rows.length;i++){
        var netchk=rows[i].nettotal;  
        var accchk=rows[i].account;   
        if(typeof(netchk) != "undefined" && typeof(netchk) != "NaN" && netchk != "0.00" && netchk != "" && netchk != null) {        
            if(typeof(accchk) == "undefined" || typeof(accchk) == "NaN" || accchk == "" || accchk == null) {            
                val1=1;      
            }      
        }
    }
    if(val1==1){
        document.getElementById("errormsg").innerText=" Select an Account";
        return 0; 
    }else{
        document.getElementById("errormsg").innerText="";     
    }
    
    var refno= document.getElementById('refno').value;
    if(refno=="") {
        document.getElementById("errormsg").innerText=" Enter Ref NO";	
        document.getElementById('refno').focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }
    
    var purid= document.getElementById("nipuraccid").value;
    if(purid=="") {
        document.getElementById("errormsg").innerText=" Select An Account";
        document.getElementById("nipuraccid").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }
    
    var invno= document.getElementById("invno").value;
    if(invno=="") {
        document.getElementById("errormsg").innerText=" Enter PO NO";
        document.getElementById("invno").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    } 
    
    var refval= document.getElementById("nettotal").value;
    if(refval=="" || refval=="0" || refval==0) {
        document.getElementById("errormsg").innerText="Net Total Empty";
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }
    
    var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
    $('#nidescdetailslenght').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
        .attr("type", "dil")
        .attr("id", "desctest"+i)
        .attr("name", "desctest"+i)
        .attr("hidden", "true"); 
        var aa=0;
        newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
                +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "
                +rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].nuprice+" :: "
                +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+aa+" :: ");
        newTextBox.appendTo('form');
    }   
    
    var x =new XMLHttpRequest();
    x.onreadystatechange=function() {
        if(x.readyState==4 && x.status==200) {
            var items=x.responseText;
            var chk=items.trim();
            chk=0;
            if(parseInt(chk)==1) {
                document.getElementById("errormsg").innerText="";
                document.getElementById("frmNipurchase").submit();
            } else {
                document.getElementById("errormsg").innerText="";
                document.getElementById("frmNipurchase").submit();
            }
        }
    }
    x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
    x.send();	
} 

function funChkButton() {}

function funSearchLoad(){
    changeContent('nipurchaseMastersearch.jsp'); 
}

function funReset(){}

function funReadOnly(){
    $('#frmNipurchase input').attr('readonly', true );
    $('#frmNipurchase select').attr('disabled', true );
    $('#nipurchasedate').jqxDateTimeInput({ disabled: true});
    $('#deliverydate').jqxDateTimeInput({ disabled: true});
    $('#invDate').jqxDateTimeInput({ disabled: true});
    $('#interstate').attr('disabled', true);
    $('#cmbcurr').attr('disabled', true);
    $('#acctype').attr('disabled', true);
    $('#refslno').attr('disabled', true);
    $("#nidescdetailsGrid").jqxGrid({ disabled: true});
    combochange();
    funinterstate();
}
				   
function funRemoveReadOnly(){         
    funinterstate();
    fungetterms();
    getNonTaxableEntity();
    $('#frmNipurchase input').attr('readonly', false );
    $('#frmNipurchase select').attr('disabled', false );
    $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
    $('#deliverydate').jqxDateTimeInput({ disabled: false});
    $('#invDate').jqxDateTimeInput({ disabled: false});
    $('#interstate').attr('disabled', false);
    $('#cmbcurr').attr('disabled', false);
    $('#cmbcurr').attr('readonly', true);
    $('#acctype').attr('disabled', false);
    $('#docno').attr('readonly', true);
    $('#currate').attr('readonly', true);
    $('#nipuraccid').attr('readonly', true);
    $('#puraccname').attr('readonly', true);
    $('#refslno').attr('disabled', true);
    $('#refslno').attr('readonly', true);
    $("#nidescdetailsGrid").jqxGrid({ disabled: false});
        
    if ($("#mode").val() == "A") {  
        $('#nipurchasedate').val(new Date());
        $('#deliverydate').val(new Date());
        getCurrencyIds($("#nipurchasedate").val());
        $("#nidescdetailsGrid").jqxGrid('clear');
        $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
    }
    if ($("#mode").val() == "E") {
        if(document.getElementById("interstate").checked==true){
            document.getElementById("interstate").value='1';
        } else {
            document.getElementById("interstate").value='0';
        }
        if ($('#reftypeval').val()=="NPO"){    
            $('#refno').attr('disabled', false);
            $('#refslno').attr('disabled', false);
            $('#refno').attr('readonly', true);
            $('#refslno').attr('readonly', true);
        }        
    }
}
					        
function getCurrencyIds(a){  
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var curidItems=items[0];
            var curcodeItems=items[1];
            var currateItems=items[2];
            var multiItems=items[3];
            var optionscurr = '';
            
            if(curcodeItems.indexOf(",")>=0){
                var currencyid=curidItems.split(",");
                var currencycode=curcodeItems.split(",");
                multiItems.split(",");
                
                for ( var i = 0; i < currencycode.length; i++) {
                    optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                }
                $("select#cmbcurr").html(optionscurr);
                
                if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
                    $('#cmbcurr').val($('#hidcmbcurr').val()) ;
                } 
                if(document.getElementById("masterdoc_no").value=="") {
                    funRoundRate(currateItems,"currate");
                }
                $('#currate').attr('readonly', true);
            } else {
                optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                $("select#cmbcurr").html(optionscurr);
                
                if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
                    $('#cmbcurr').val($('#hidcmbcurr').val()) ;
                } 
                if(document.getElementById("masterdoc_no").value=="") {
                    funRoundRate(currateItems,"currate");
                }
                $('#currate').attr('readonly', true);
            }
        }
    }
    x.open("GET", "getCurrencyId.jsp?date="+a,true);
    x.send();
}				        

function getRatevalue(angel) {
    if(document.getElementById("masterdoc_no").value>0) {
        return 0;
    }
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            funRoundRate(items,"currate");  
        }
    }
    x.open("GET","getRateTo.jsp?curr="+a,true);
    x.send();
}

function funrefdisslno() {
    $("#nidescdetailsGrid").jqxGrid('clear');
    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
    
    if($('#nireftype').val()=="NPO") {
        $('#refno').attr('disabled', false);
        $('#refslno').attr('disabled', false);
    } else {
        $('#refno').val(" ");
        $('#refslno').val(" ");
        $('#refno').attr('disabled', true);
        $('#refslno').attr('disabled', true);
    }
}

function combochange() {
    if($('#cmbcurrval').val()!="") {
        $('#cmbcurr').val($('#cmbcurrval').val());
    }
    if($('#acctypeval').val()!="") {
        $('#acctype').val($('#acctypeval').val());
    }
    if($('#reftypeval').val()!="") {
        $('#nireftype').val($('#reftypeval').val());
        if($('#reftypeval').val()=="NPO") {
            $('#refno').attr('disabled', false);
            $('#refslno').attr('disabled', false);
            $('#refno').attr('readonly', true);
            $('#refslno').attr('readonly', true);
        }
    }
}

function fungetterms() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            if(parseInt(items)>0){
                $('#termsval').val(1);
            } else{
                $('#termsval').val(0);
            }
        }
    }
    x.open("GET","terms.jsp?",true);
    x.send();
}
					   
function funinterstate() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            if(parseInt(items)>0){
                $('#interdiv').hide();
            } else{
                $('#interdiv').hide();
            }
        }
    }
    x.open("GET","interstate.jsp?",true);
    x.send();
}
					   
function funbnkdetls() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            if(parseInt(items)>0){
                document.getElementById("hidbnk").value=1;
            } else{
                document.getElementById("hidbnk").value=0;
            }
        }
    }
    x.open("GET","shwbnkdetls.jsp?",true);
    x.send();
}

function setValues() {
    funinterstate();
    
    $('#nipurchasedate').jqxDateTimeInput({disabled: false});
    var date = $('#nipurchasedate').val();
    getCurrencyIds(date);  
    $('#nipurchasedate').jqxDateTimeInput({disabled: true});
    
    if($('#hidnipurchasedate').val()){
        $("#nipurchasedate").jqxDateTimeInput('val', $('#hidnipurchasedate').val());
    }
    if($('#hiddeliverydate').val()){
        $("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
    }
    if($('#hidinvDate').val()){
        $("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
    }
    
    var interstate=document.getElementById("hidinterstate").value;
    if(interstate>0){
        document.getElementById("interstate").checked=true;
    } else{
        document.getElementById("interstate").checked=false;
    }
    
    var dis=document.getElementById("masterdoc_no").value;
    if(dis>0) {     
        funchkforedit();
        var indexval1 = document.getElementById("masterdoc_no").value;   
        $("#nipurdetails").load("descgridDetails.jsp?nipurdoc="+indexval1);
    } 

    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    } 
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    combochange();
}

$(function(){
    $('#frmNipurchase').validate({
        rules: { 
            delterms:{maxlength:200},
            purdesc:{maxlength:200},
            payterms:{maxlength:200}
        },
        messages: {
            delterms: {maxlength:"  Max 200 chars"},
            purdesc: {maxlength:"  Max 200 chars"},
            payterms: {maxlength:"  Max 200 chars"}
        }
    });
});

function funPrintBtn(){
    var dtype=$('#formdetailcode').val();
    var brhid=$("#brchName").val();
    var bnk=$("#hidbnk").val();
    var url=document.URL;
    var reurl;
    if ($("#masterdoc_no").val()==""){
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
    if( url.indexOf('savesrvsale') >= 0){
        reurl=url.split("savesrvsale");
    }else {
        reurl=url.split("serviceSale.jsp");
    }
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="" && $("#hidbnk").val()==1) {
        PrintContent('printVoucherWindow.jsp');
    } else {
        var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header=1&bankdocno=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
        win.focus();
    }
}

function PrintContent(url) {
    $('#printWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#printWindow').jqxWindow('setContent', data);
        $('#printWindow').jqxWindow('bringToFront');
    }); 
}

function funchkforedit() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();	
            if(parseInt(items)>0) {
                $("#btnEdit").attr('disabled', true );
                $("#btnDelete").attr('disabled', true ); 
            }
        }
    }
    x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
    x.send();    
}
</script>
</head>
<body onload="setValues();funinterstate();funbnkdetls();" >

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNipurchase" action="savesrvsale" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />    

<div class='modern-ui hidden-scrollbar'>
    
    <!-- TOP SECTION -->
    <div class="middle-panel">
        <span class="middle-panel-title">Service Sale Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
            </div>
            <input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
            
            <label class="lbl-right" style="width:80px;">Ref No</label>
            <input type="text" name="refno" id="refno" style="width: 125px;" value='<s:property value="refno"/>' >
            <input type="hidden" name="refslno" id="refslno" value='<s:property value="refslno"/>' > 
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" tabindex="-1" style="width: 120px;" value='<s:property value="docno"/>' readonly="readonly">
        </div>
        
        <div class="field-row">
            <label class="lbl-right" id="typetd1" style="display:none; width:80px;">Type</label>
            <div id="typetd2" style="display:none; width: 80px;">
                <select name="cmbtype" id="cmbtype" style="width:100%;" value='<s:property value="cmbtype"/>'>
                    <option value="AR">AR</option>
                    <option value="AP">AP</option>
                    <option value="GL">GL</option>
                </select>
            </div>
            
            <label class="lbl-right" style="width:80px;">Client</label>
            <div class="input-search-container" style="width:125px;">
                <input type="text" name="nipuraccid" id="nipuraccid" placeholder="Press F3" value='<s:property value="nipuraccid"/>' onKeyDown="getaccountdetails(event);">
                <svg class="magnifier-icon" onclick="$('#nipuraccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="flex:1;">
            <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
            
            <label class="lbl-right" style="width:50px;">Curr</label>
            <select name="cmbcurr" id="cmbcurr" style="width: 80px;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                <option value="-1">--Select--</option>
            </select>  
            <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/>    
            
            <label class="lbl-right" style="width:50px;">Rate</label>
            <input type="text" name="currate" id="currate" style="width: 60px;" value='<s:property value="currate"/>'>
            
            <label class="lbl-right" style="width:60px;">PO NO</label>
            <input type="text" id="invno" name="invno" style="width: 100px;" value='<s:property value="invno"/>'>
            
            <label class="lbl-right" style="width:60px;">PO Date</label>
            <div style="width: 125px;">
                <div id="invDate" name="invDate" value='<s:property value="invDate"/>'></div>
            </div>
            <input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Del Date</label>
            <div style="width: 125px;">
                <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
            </div>
            <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
            
            <div id="interdiv" style="display:none; margin-left: 10px; align-items:center;">
                <input type="checkbox" name="interstate" id="interstate" value="interstate" value='<s:property value="interstate"/>' onclick="$(this).attr('value', this.checked ? 1 : 0);" >
                <label style="margin-left:5px; font-size:12px; font-weight:bold; color:#444;">Interstate</label>
            </div>
            
            <label class="lbl-right" style="width:80px;">Del Terms</label>
            <input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="flex:1;">
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Pay Terms</label>
            <input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="flex:1;">
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="flex:1;">
        </div>
    </div>
    
    <!-- GRID SECTION -->
    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="nipurdetails" class="grid-container">
            <jsp:include page="descgridDetails.jsp"></jsp:include>
        </div>
    </div>
    
    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="termsval" name="termsval" value='<s:property value="termsval"/>'/>
        <input type="hidden" id="ordermasterdoc_no" name="ordermasterdoc_no" value='<s:property value="ordermasterdoc_no"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
        <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
        <input type="hidden" id="rowval" name="rowval" value='<s:property value="rowval"/>'/>
        <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>  
        <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>  
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="acctypegrid" name="acctypegrid" value='<s:property value="acctypegrid"/>'/>
        <input type="hidden" id="nidescdetailslenght" name="nidescdetailslenght" value='<s:property value="nidescdetailslenght"/>'/>  
        <input type="hidden" id="costgropename" name="costgropename" value='<s:property value="costgropename"/>'/>
        <input type="hidden" id="tarannumber" name="tarannumber" value='<s:property value="tarannumber"/>'/>
        <input type="hidden" id="hidinterstate" name="hidinterstate" value='<s:property value="hidinterstate"/>'/>
        <input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity" value='<s:property value="txtnontaxableentity"/>'/>
        <input type="hidden" id="taxpers" name="taxpers" value='<s:property value="taxpers"/>'/>
        <input type="hidden" id="taxperc" name="taxperc" value='<s:property value="taxperc"/>'/>
        <input type="hidden" id="hidbnk" name="hidbnk" value='<s:property value="hidbnk"/>'/>
    </div>
    
    <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px; text-align:center;"></div>
    
</div>
</form>

<!-- Search Windows -->
<div id="accountSearchwindow"><div></div></div>
<div id="accounttypeSearchwindow"><div></div></div>
<div id="costtpesearchwndow"><div></div></div>
<div id="costcodesearchwndow"><div></div></div> 
<div id="refnosearchwindow"><div></div></div> 
<div id="nipurchslnosearch"><div></div></div> 
<div id="printWindow"><div></div></div>

</div>
</body>
</html>