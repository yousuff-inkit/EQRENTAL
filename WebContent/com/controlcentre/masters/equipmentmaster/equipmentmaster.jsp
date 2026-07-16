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

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color: red; font-weight: bold; }
</style>

<script type="text/javascript">
$(document).ready(function() {
    document.getElementById("lbllastsrvkm").style.display="none";
    document.getElementById("last_srvc_km").style.display="none";
    document.getElementById("fleetwarning").style.display="none";
    document.getElementById("releasesave").style.display="none";
    $("#releasefleet").attr("disabled", true); 
    $("#cmbrlsbranch").attr("disabled", true); 
    $("#cmbrlsloc").attr("disabled", true); 
    $("#cmbrentalstatus").attr("disabled", true); 

    /* Apply JQX Date Inputs with 24px Modern UI Constraints */
    var dateElements = [
        "jqxDate1", "tpiexpiry", "jqxPurchaseDate", "jqxFinRegDate", 
        "jqxFinRelDate", "jqxOtherRegExp", "jqxOtherInsExp", 
        "jqxWrntyFrmDate", "jqxWrntyToDate", "jqxLstSrvcDate", "releasedate"
    ];
    
    dateElements.forEach(function(el) {
        $("#" + el).jqxDateTimeInput({ width: '120px', height: 24, formatString: "dd.MM.yyyy", value: null, theme: 'energyblue' });
    });
    $("#releasetime").jqxDateTimeInput({ width: '80px', height: 24, formatString: 'HH:mm', showCalendarButton: false, theme: 'energyblue' });

    /* Force internal alignment AFTER render */
    setTimeout(function () {
        dateElements.push("releasetime");
        dateElements.forEach(function(el) {
            $("#" + el).find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#" + el).find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        });
    }, 0);

    $('#dealerWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#dealerWindow').jqxWindow('close');
    $('#financierWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#financierWindow').jqxWindow('close');
    $('#insuranceWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#insuranceWindow').jqxWindow('close');
    $('#specwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#specwindow').jqxWindow('close'); 
    
    if(document.getElementById("mode").value=="A"){
        changeDate();   
    }
    
    $('#jqxFinRegDate').on('change', function (event) { changeDate(); });
    
    $('#jqxPurchaseDate').on('change', function (event) {  
        var purdate= $('#jqxPurchaseDate').jqxDateTimeInput('getDate');
        $('#jqxWrntyFrmDate ').jqxDateTimeInput('setDate', new Date(purdate));
    });

    getTestPlateCode();
    getInitData();
    getTestModel();
    getTestLocation(); 

    $('#mortgaged').dblclick(function(){
        $('#financierWindow').jqxWindow('open');
        $('#financierWindow').jqxWindow('focus');
        financierSearchContent('mortgagedGrid.jsp?', $('#financierWindow'));
    });
});
	
function getSubCategory(catid){
    $.get('getInitData.jsp',{'catid':catid},function(data){
        data=JSON.parse(data);
        var htmldata='<option value="">--Select--</option>';
        $.each(data.subcatdata,function(index,value){
            htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
        });
        $('#cmbsubcategory').html($.parseHTML(htmldata));
        if($('#hidcmbsubcategory').val()!=''){
            $('#cmbsubcategory').val($('#hidcmbsubcategory').val());
        }
    });
}

function getInitData(){
    $.get('getInitData.jsp',function(data){
        data=JSON.parse(data);
        var htmldata='<option value="">--Select--</option>';
        $.each(data.catdata,function(index,value){
            htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
        });
        $('#cmbcategory').html($.parseHTML(htmldata));
        if($('#hidcmbcategory').val()!=''){
            $('#cmbcategory').val($('#hidcmbcategory').val());
            getSubCategory($('#cmbcategory').val());
        }
        htmldata='<option value="">--Select--</option>';
        $.each(data.sizedata,function(index,value){
            htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
        });
        $('#cmbsize').html($.parseHTML(htmldata));
        if($('#hidcmbsize').val()!=''){
            $('#cmbsize').val($('#hidcmbsize').val());
        }
    });
}

function getMortgaged(event){
    var x= event.keyCode;
    if(x==114){
        financierSearchContent('mortgagedGrid.jsp');
    }
}

function changeDate(){
    var finregdate= $('#jqxFinRegDate').jqxDateTimeInput('getDate');
    if(finregdate != null) {
        var finaldate=new Date(new Date(finregdate).setMonth(finregdate.getMonth()+12));
        var finaldate2=new Date(new Date(finaldate).setDate(finaldate.getDate()-1));
        $('#jqxOtherRegExp ').jqxDateTimeInput('setDate', new Date(finaldate2));
        var insexp1=new Date(new Date(new Date(finregdate).setMonth(finregdate.getMonth()+13)));
        var insexp2=new Date(new Date(insexp1).setDate(insexp1.getDate()-1));
        $('#jqxOtherInsExp ').jqxDateTimeInput('setDate', new Date(insexp2));
    }
}

function funSearchLoad(){
    changeContent('masterSearch.jsp', $('#window')); 
}

function dealerSearchContent(url) {
    $('#dealerWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#dealerWindow').jqxWindow('setContent', data);
    }); 
}
	
function funSearchdblclick(){
    var url=document.URL;
    var reurl=url.split("com/");
    dealerSearchContent(reurl[0]+'com/search/masterssearch/dealerMSearch.jsp');
}

function getDealer(event){
    var x= event.keyCode;
    if(x==114){
        var url=document.URL;
        var reurl=url.split("com/");
        dealerSearchContent(reurl[0]+'com/search/masterssearch/dealerMSearch.jsp');
    }
}

function financierSearchContent(url) {
    $('#financierWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#financierWindow').jqxWindow('setContent', data);
    }); 
}

function specSearchContent(url) {
    $('#specwindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#specwindow').jqxWindow('setContent', data);
    }); 
}

function funFinSearchdblclick(){
    var url=document.URL;
    var reurl=url.split("com/");
    financierSearchContent(reurl[0]+'com/search/masterssearch/financierMSearch.jsp');
}

function getFin(event){
    var x= event.keyCode;
    if(x==114){
        var url=document.URL;
        var reurl=url.split("com/");
        financierSearchContent(reurl[0]+'com/search/masterssearch/financierMSearch.jsp');
    }
}

function insuranceSearchContent(url) {
    $('#insuranceWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#insuranceWindow').jqxWindow('setContent', data);
    }); 
}

function funInsurSearchdblclick(){
    var url=document.URL;
    var reurl=url.split("com/");
    insuranceSearchContent(reurl[0]+'com/search/masterssearch/insuranceMSearch.jsp');
}

function getInsurance(event){
    var x= event.keyCode;
    if(x==114){
        var url=document.URL;
        var reurl=url.split("com/");
        insuranceSearchContent(reurl[0]+'com/search/masterssearch/insuranceMSearch.jsp');
    }
}

function funReadOnly() {
    $('#frmEquipmentMaster input').attr('readonly', true);
    $('#frmEquipmentMaster select').attr('disabled', true);
    $('#jqxDate1, #jqxPurchaseDate, #jqxFinRegDate, #jqxFinRelDate, #jqxOtherRegExp, #jqxOtherInsExp, #jqxWrntyFrmDate, #jqxWrntyToDate, #jqxLstSrvcDate, #releasedate, #releasetime, #tpiexpiry').jqxDateTimeInput({ disabled: true}); 
    getAuth(); getBrand(); getGroup(); getYOM(); getColor(); getFinancier(); getBrch(); showRelease(); getStatus();
}

function showRelease(){
    var temp=$("#aststatus").val();
    if(temp=="INDUCTED"){
        document.getElementById("btnrelease").value="To Be Released";
    } else if(temp=="LIVE"){
        document.getElementById("btnrelease").style.display="none";
        document.getElementById("releasesave").style.display="none";
    } else{
        document.getElementById("btnrelease").disabled=true;
    }
}

function funRelease(){
    $('#mode').val("R");
    $("#cmbrlsbranch").attr("disabled", false); 
    var testfleet=document.getElementById("releasefleet").value;
    var testbranch=document.getElementById("cmbrlsbranch").value;
    var testloc=document.getElementById("cmbrlsloc").value;
    var testkm=document.getElementById("releasekm").value;
    var testfuel=document.getElementById("releasefuel").value;
    
    if((testfleet=='')||(testbranch=='')||(testloc=='')||(testkm=='')||(testfuel=='')){
        document.getElementById("fleetwarning").style.display="block";
        return false;
    } else{
        document.getElementById("fleetwarning").style.display="none";
        $('#cmbfuel').attr('disabled', false); 
        if(document.getElementById("releasefleet").value<=0){ return false; }
        $('#jqxDate1, #jqxPurchaseDate, #jqxFinRegDate, #jqxFinRelDate, #jqxOtherRegExp, #jqxOtherInsExp, #jqxWrntyFrmDate, #jqxWrntyToDate, #jqxLstSrvcDate').jqxDateTimeInput({disabled:false});
        document.getElementById("frmEquipmentMaster").submit();
        $("#cmbrlsbranch").attr("disabled", true); 
        $('#cmbfuel').attr('disabled', true); 
    }
}

function funEnable(){
    document.getElementById("btnrelease").style.display="none";
    document.getElementById("releasesave").style.display="block";
    $("#releasefleet").attr("disabled", false); 
    $("#cmbrlsbranch").attr("disabled", false); 
    $("#cmbrlsloc").attr("disabled", false); 
    $("#cmbrentalstatus").attr("disabled", false); 
    $("#cmbrentalstatus").val("R");
    $('#releasedate').jqxDateTimeInput({ disabled: false});
    $('#releasetime').jqxDateTimeInput({ disabled: false});
    $("#releasekm").prop("readonly", true);
    $("#releasefuel").prop("readonly", true); 
    $("#cmbrlsbranch").attr("disabled", true); 
    if(document.getElementById("aststatus").value=='INDUCTED'){
        document.getElementById("releasekm").value=document.getElementById("current_km").value;
        document.getElementById("releasefuel").value=$("#cmbfuel option:selected").text();
        $('#cmbrlsbranch').val($('#cmbavail_br1').val());
        getLocation($('#cmbrlsbranch').val());
    }
}

function getTestPlateCode(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var plateItems = items[0].split(",");
            var plateIdItems = items[1].split(",");
            var optionsplate = '<option value="">--Select--</option>';
            for (var i = 0; i < plateItems.length; i++) {
                optionsplate += '<option value="' + plateIdItems[i] + '">' + plateItems[i] + '</option>';
            }
            $("select#cmbplate").html(optionsplate);
            if ($('#hidcmbplate').val() != null) {
                $('#cmbplate').val($('#hidcmbplate').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getTestPlateCode.jsp", true);
    x.send();
}

function funRemoveReadOnly() {
    $('#frmEquipmentMaster input').attr('readonly', false);
    $('#frmEquipmentMaster select').attr('disabled', false);
    $('#docno, #dealer, #financier, #insurance_comp, #mortgaged').attr('readonly', true);
    $('#jqxDate1, #jqxPurchaseDate, #jqxFinRegDate, #jqxFinRelDate, #jqxOtherRegExp, #jqxOtherInsExp, #jqxLstSrvcDate, #tpiexpiry').jqxDateTimeInput({ disabled: false}); 
    
    $("#releasefleet, #cmbrlsbranch, #cmbrlsloc, #cmbrentalstatus").attr("disabled", true); 
    $('#releasedate, #releasetime').jqxDateTimeInput({ disabled: true});
    $("#releasekm, #releasefuel").attr("readonly",true);

    if(document.getElementById("mode").value=='A'){
        $("#jqxFinRegDate,#jqxDate1, #jqxPurchaseDate, #jqxFinRelDate, #releasedate, #jqxWrntyFrmDate, #jqxWrntyToDate, #jqxLstSrvcDate, #releasetime").jqxDateTimeInput('setDate', new Date());
        changeDate(); 
        document.getElementById("accu_dep").value="0";
    }
    if(document.getElementById("cmbbrand").value!=""){
        getModel(document.getElementById("cmbbrand").value);
    }
    $('#fleetno').attr('readonly', true);
}

function getAuth() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var authItems = items[0].split(",");
            var authIdItems = items[1].split(",");
            var optionsauth = '<option value="">--Select--</option>';
            for (var i = 0; i < authItems.length; i++) {
                optionsauth += '<option value="' + authIdItems[i] + '">' + authItems[i] + '</option>';
            }
            $("select#cmbauthority").html(optionsauth);
            if ($('#hidcmbauthority').val() != null) {
                $('#cmbauthority').val($('#hidcmbauthority').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getAuthority.jsp", true);
    x.send();
}

function getColor() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var colorItems = items[0].split(",");
            var colorIdItems = items[1].split(",");
            var optionscolor = '<option value="">--Select--</option>';
            for (var i = 0; i < colorItems.length; i++) {
                optionscolor += '<option value="' + colorIdItems[i] + '">' + colorItems[i] + '</option>';
            }
            $("select#cmbveh_color").html(optionscolor);
            if ($('#hidcmbveh_color').val() != null) {
                $('#cmbveh_color').val($('#hidcmbveh_color').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getColor.jsp", true);
    x.send();
}

function getPlateCode(value) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var plateItems = items[0].split(",");
            var plateIdItems = items[1].split(",");
            var optionsplate = '<option value="">--Select--</option>';
            if(plateItems!=''){
                for (var i = 0; i < plateItems.length; i++) {
                    optionsplate += '<option value="' + plateIdItems[i] + '">' + plateItems[i] + '</option>';
                }
            }
            $("select#cmbplate").html(optionsplate);
        }
    }
    x.open("GET", "../vehiclemaster/getPlateCode.jsp?id="+value, true);
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
            $("select#cmbgroup").html(optionsgroup);
            if ($('#hidcmbgroup').val() != null) {
                $('#cmbgroup').val($('#hidcmbgroup').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getGroup.jsp", true);
    x.send();
}

function getLevel(value) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#group_name').val(items);
        }
    }
    x.open("GET", "../vehiclemaster/getLevel.jsp?id="+value, true);
    x.send();
}

function getBrand() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('***');
            var brandItems = items[0].split(",");
            var brandidItems = items[1].split(",");
            var optionsbrand = '<option value="">--Select--</option>';
            for (var i = 0; i < brandItems.length; i++) {
                optionsbrand += '<option value="' + brandidItems[i] + '">' + brandItems[i] + '</option>';
            }
            $("select#cmbbrand").html(optionsbrand);
            if ($('#hidcmbbrand').val() != null) {
                $('#cmbbrand').val($('#hidcmbbrand').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getBrand.jsp", true);
    x.send();
}

function getTestModel(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var modelItems = items[0].split(",");
            var modelidItems = items[1].split(",");
            var optionsmodel = '<option value="">--Select--</option>';
            for (var i = 0; i < modelItems.length; i++) {
                optionsmodel += '<option value="' + modelidItems[i] + '">' + modelItems[i] + '</option>';
            }
            $("select#cmbmodel").html(optionsmodel);
            if ($('#hidcmbmodel').val() != null) {
                $('#cmbmodel').val($('#hidcmbmodel').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getTestModel.jsp", true);
    x.send();
}

function getModel(value) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var modelItems = items[0].split(",");
            var modelidItems = items[1].split(",");
            var optionsmodel = '<option value="">--Select--</option>';
            if(modelItems!=''){
                for (var i = 0; i < modelItems.length; i++) {
                    optionsmodel += '<option value="' + modelidItems[i] + '">' + modelItems[i] + '</option>';
                }
            }
            $("select#cmbmodel").html(optionsmodel);
            if ($('#hidcmbmodel').val() != null) {
                $('#cmbmodel').val($('#hidcmbmodel').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getModel.jsp?id="+value, true);
    x.send();
}

function getYOM() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var yomItems = items[0].split(",");
            var yomidItems = items[1].split(",");
            var optionsyom = '<option value="">--Select--</option>';
            for (var i = 0; i < yomItems.length; i++) {
                optionsyom += '<option value="' + yomidItems[i] + '">' + yomItems[i] + '</option>';
            }
            $("select#cmbyom").html(optionsyom);
            if ($('#hidcmbyom').val() != null) {
                $('#cmbyom').val($('#hidcmbyom').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getYOM.jsp", true);
    x.send();
}

function getFinancier() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var finItems = items[0].split(",");
            var finidItems = items[1].split(",");
            var optionsfin = '<option value="">--Select--</option>';
            for (var i = 0; i < finItems.length; i++) {
                optionsfin += '<option value="' + finidItems[i] + '">' + finItems[i] + '</option>';
            }
            $("select#cmbfinancer").html(optionsfin);
            if ($('#hidcmbfinancer').val() != null) {
                $('#cmbfinancer').val($('#hidcmbfinancer').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getFinancier.jsp", true);
    x.send();
}

function getBrch() {
    var x = new XMLHttpRequest();
    var items, brchItems, currItems;
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            brchIdItems = items[0].split(",");
            brchItems = items[1].split(",");
            var optionsbrch = '<option value="">--Select--</option>';
            for (var i = 0; i < brchItems.length; i++) {
                optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
            }
            $("select#cmbavail_br1").html(optionsbrch);
            $("select#cmbrlsbranch").html(optionsbrch);
            if ($('#hidcmbavail_br1').val() != null) {
                $('#cmbavail_br1').val($('#hidcmbavail_br1').val());
            }
            if ($('#hidcmbrlsbranch').val() != null) {
                $('#cmbrlsbranch').val($('#hidcmbrlsbranch').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getBranch.jsp", true);
    x.send();
}

function getLocation(value) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var locationItems=items[0].split(",");
            var locationidItems=items[1].split(",");
            var optionslocation = '<option value="">--Select--</option>';
            for ( var i = 0; i < locationItems.length; i++) {
                optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
            }
            $("select#cmbrlsloc").html(optionslocation);
            if ($('#hidcmbrlsloc').val() != null) {
                $('#cmbrlsloc').val($('#hidcmbrlsloc').val());
            }
        }
    }
    x.open("GET","../vehiclemaster/getLocation.jsp?id="+value,true);
    x.send();
}

function getTestLocation(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var locationItems=items[0].split(",");
            var locationidItems=items[1].split(",");
            var optionslocation = '<option value="">--Select--</option>';
            for ( var i = 0; i < locationItems.length; i++) {
                optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
            }
            $("select#cmbrlsloc").html(optionslocation);
            if ($('#hidcmbrlsloc').val() != null) {
                $('#cmbrlsloc').val($('#hidcmbrlsloc').val());
            }
        }
    }
    x.open("GET","../vehiclemaster/getTestLocation.jsp",true);
    x.send();
}

function getStatus() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var status=items[0].split(",");
            var stdesc=items[1].split(",");
            var optionsstatus = '<option value="">--Select--</option>';
            for ( var i = 0; i < stdesc.length; i++) {
                optionsstatus += '<option value="' + status[i] + '">' + stdesc[i] + '</option>';
            }
            $("select#cmbstatus").html(optionsstatus);
            if ($('#hidcmbstatus').val() != null) {
                $('#cmbstatus').val($('#hidcmbstatus').val());
            }
        }
    }
    x.open("GET","../vehiclemaster/getStatus.jsp",true);
    x.send();
}

function setValues() {
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
    
    if($('#hidreleasetime').val()){ $("#releasetime").jqxDateTimeInput('val', $('#hidreleasetime').val()); }
    if ($('#hidcmbfueltype').val() != null) { $('#cmbfueltype').val($('#hidcmbfueltype').val()); }
    if ($('#hidpurchase').val() != null) { $('#purchase').val($('#hidpurchase').val()); }
    if ($('#hidcmbplate').val() != null) { $('#cmbplate').val($('#hidcmbplate').val()); } 
    if ($('#hidcmbinsurance_type').val() != null) { $('#cmbinsurance_type').val($('#hidcmbinsurance_type').val()); }
    if ($('#hidcmbfuel').val() != null) { $('#cmbfuel').val($('#hidcmbfuel').val()); }
    if ($('#hidcmbrentalstatus').val() != null) { $('#cmbrentalstatus').val($('#hidcmbrentalstatus').val()); } 
    if($('#msg').val()!=""){ $.messager.alert('Message',$('#msg').val()); }
    
    if(document.getElementById("docno").value!=''){
        var docno1=document.getElementById("docno").value.trim();
    }
}

function funFocus() {
    document.getElementById("cmbcategory").focus();
}

$(function(){
    $('#frmEquipmentMaster').validate({
        rules: {
            cmbauthority:"required", cmbplate:"required", cmbgroup:"required", regno:"required",
            cmbbrand:"required", cmbmodel:"required", cmbyom:"required", purchase_cost:"required",
            cmbavail_br1:"required", purchase:"required", cmbfueltype:"required", fuelcapacity:"required",
            cmbfuel:"required", purchase_cost:"number", additions:"number", current_km:"required", accu_dep:"required"
        }, 
        messages:{
            cmbauthority:" *", cmbplate:" *", cmbgroup:" *", regno:" *", cmbbrand:" *",
            cmbmodel:" *", cmbyom:" *", purchase_cost:" *", cmbavail_br1:" *", purchase:" *",
            cmbfueltype:" *", fuelcapacity:" *", cmbfuel:" *", purchase_cost:"Digits",
            additions:"Digits", current_km:"*", accu_dep:"*"
        }
    });
});

function funNotify(){
    document.getElementById("purchase_cost").value=0.0;
    if(document.getElementById("purchase_cost").value==""){
        document.getElementById("errormsg").innerText="Purchase Cost is Mandatory";
        $('#inductiontab').trigger('click');
        document.getElementById("purchase_cost").focus();
        return 0;
    }
    if(document.getElementById("cmbfueltype").value==""){
        document.getElementById("errormsg").innerText="Fuel Type is Mandatory";
        $('#servtab').trigger('click');
        document.getElementById("cmbfueltype").focus();
        return 0;
    }
    if(document.getElementById("fuelcapacity").value==""){
        $('#servtab').trigger('click');
        document.getElementById("errormsg").innerText="Fuel Capacity is Mandatory";
        document.getElementById("fuelcapacity").focus();
        return 0;
    }
    if(document.getElementById("cmbfuel").value==""){
        $('#servtab').trigger('click');
        document.getElementById("errormsg").innerText="Fuel is Mandatory";
        document.getElementById("cmbfuel").focus();
        return 0;
    }
    if(document.getElementById("cmbavail_br1").value==""){
        $('#servtab').trigger('click');
        document.getElementById("errormsg").innerText="Available Branch is Mandatory";
        document.getElementById("cmbavail_br1").focus();
        return 0;
    }

    $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: false});
    $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: false});
    checkRegNo();	
    if(document.getElementById("errormsg").innerText!=""){
        return 0;	
    } else {
        document.getElementById("errormsg").innerText="";
        return 1;
    }
    $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: true});
    $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: true});
} 

function getTotal(){
    var pcost = document.getElementById('purchase_cost').value;
    var addit = document.getElementById('additions').value;
    if (pcost == "") pcost = 0;
    if (addit == "") addit = 0;
    var result = parseFloat(pcost) + parseFloat(addit);
    if (!isNaN(result)) { document.getElementById('total').value = result; }	   
}

function getFleetName(){
    document.getElementById("fleetname").value="";
    var r=$("#cmbbrand option:selected").text();
    var r1=$("#cmbmodel option:selected").text();
}

function depr_percent(value){
    if(value>100){
        document.getElementById("errormsg").innerText="Depr.Percent Must be less than 100%";
        document.getElementById("depr_perc").focus();
    }else{
        document.getElementById("errormsg").innerText="";	
    }
}

function getWarrantyDate(value){
    if(value!=''){
        var fvalue=parseInt(value);
        var tempdate= $('#jqxWrntyFrmDate').jqxDateTimeInput('getDate');
        var finaldate=new Date(new Date(tempdate).setMonth(tempdate.getMonth()+fvalue));
        $('#jqxWrntyToDate ').jqxDateTimeInput('setDate', new Date(finaldate));
    }
}

function getservtab(){ $('#servtab').trigger('click'); }
function getspectab(){ $('#spectab').trigger('click'); }

function checkRegNo(){
    var mode=document.getElementById("mode").value;
    var docno=document.getElementById("docno").value;
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)>0){
                document.getElementById("errormsg").innerText="Asset id Already Exists";
                document.getElementById("regno").focus();
                return false;
            }
            document.getElementById("errormsg").innerText="";
        }
    }
    x.open("GET", "checkRegNo.jsp?regno="+document.getElementById("regno").value+"&plate="+document.getElementById("cmbplate").value+"&mode="+mode+"&docno="+docno, true);
    x.send();
}
</script>
</head>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmEquipmentMaster" action="saveEquipmentMaster" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>

        <!-- ================= PANEL 1: Equipment Details ================= -->
        <div class="middle-panel">
            <span class="middle-panel-title">Equipment Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Equip. No</label>
                <input type="text" name="fleetno" id="fleetno" readonly tabindex="-1" style="width:80px;" value='<s:property value="fleetno"/>'> 
                <input type="text" name="fleetname" id="fleetname" readonly tabindex="-1" style="flex:1;" value='<s:property value="fleetname"/>'>
                
                <label class="lbl-right" style="width:60px;">Sr. No</label>
                <input type="text" name="srno" id="srno" style="width:100px;" value='<s:property value="srno"/>'>
                
                <label class="lbl-right" style="width:50px;">Date</label>
                <div style="width: 125px;">
                    <div id='jqxDate1' name='jqxDate1' value='<s:property value="jqxDate1"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:60px;">Doc No</label>
                <input type="text" name="docno" id="docno" readonly tabindex="-1" style="width:100px;" value='<s:property value="docno"/>'>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Category</label>
                <select name="cmbcategory" id="cmbcategory" style="width:125px;" onchange="getSubCategory(this.value);">
                    <option value="">--Select--</option>
                </select>
                
                <label class="lbl-right" style="width:80px;">Sub Category</label>
                <select name="cmbsubcategory" id="cmbsubcategory" style="flex:1;">
                    <option>--Select--</option>
                </select>
                
                <label class="lbl-right" style="width:60px;">Asset ID</label>
                <input type="text" name="regno" id="regno" style="width:100px;" value='<s:property value="regno"/>' autocomplete="off" onblur="checkRegNo();"/>
                
                <label class="lbl-right" style="width:50px;">Group</label>
                <select name="cmbgroup" id="cmbgroup" style="width:120px;" onchange="getLevel(this.value);">
                    <option>--Select--</option>
                </select>
                
                <label class="lbl-right" style="width:50px;">Size</label>
                <select name="cmbsize" id="cmbsize" style="width:100px;">
                    <option value="">--Select--</option>
                </select>
                
                <label class="lbl-right" style="width:60px;">Authority</label>
                <select name="cmbauthority" id="cmbauthority" style="width:100px;">
                    <option value="">--Select--</option>
                </select>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Brand</label>
                <select name="cmbbrand" id="cmbbrand" style="width:125px;" onchange="getModel(this.value);">
                    <option>--Select--</option>
                </select>
                
                <label class="lbl-right" style="width:80px;">Model</label>
                <select name="cmbmodel" id="cmbmodel" style="flex:1;" onchange="getFleetName();">
                    <option>--Select--</option>
                </select>
                
                <label class="lbl-right" style="width:60px;">YoM</label>
                <select name="cmbyom" id="cmbyom" style="width:100px;">
                    <option>--Select--</option>
                </select>
                
                <label class="lbl-right" style="width:60px;">Salik Tag</label>
                <input type="text" id="salik_tag" name="salik_tag" style="width:100px;" value='<s:property value="salik_tag"/>' />
                
                <label class="lbl-right" style="width:50px;">TC No</label>
                <input type="text" id="tcno" name="tcno" style="width:100px;" value='<s:property value="tcno"/>' />
                
                <label class="lbl-right" style="width:70px;">Plate Code</label>
                <select name="cmbplate" id="cmbplate" style="width:90px;">
                    <option value="">--Select--</option>
                </select>
            </div>
        </div>

        <!-- ================= PANEL 2: Dates & Depreciation AND Vehicle Info ================= -->
        <div style="display: flex; gap: 15px;">
            <div class="middle-panel" style="flex: 1;">
                <span class="middle-panel-title">Dates & Depreciation</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Registration Expiry</label>
                    <div style="width: 125px;">
                        <div id='jqxOtherRegExp' name='jqxOtherRegExp' value='<s:property value="jqxOtherRegExp"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:120px; margin-left:auto;">Insurance Expiry</label>
                    <div style="width: 125px;">
                        <div id='jqxOtherInsExp' name='jqxOtherInsExp' value='<s:property value="jqxOtherInsExp"/>'></div>
                    </div>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:120px;">TPI Expiry</label>
                    <div style="width: 125px;">
                        <div id='tpiexpiry' name='tpiexpiry' value='<s:property value="tpiexpiry"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:120px; margin-left:auto;">Depreciation %</label>
                    <input type="text" id="depr_perc" name="depr_perc" value='<s:property value="depr_perc"/>' style="width:120px; text-align:right;" onblur="depr_percent(this.value);"/>
                </div>
            </div>

            <div class="middle-panel" style="flex: 1;">
                <span class="middle-panel-title">Vehicle Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Engine No</label>
                    <input type="text" id="engine_no" name="engine_no" style="flex:1; text-transform:uppercase;" value='<s:property value="engine_no"/>' />
                    
                    <label class="lbl-right" style="width:80px;">Chassis No</label>
                    <input type="text" id="chasis_no" name="chasis_no" style="flex:1; text-transform:uppercase;" value='<s:property value="chasis_no"/>' />
                    
                    <label class="lbl-right" style="width:50px;">VIN</label>
                    <input type="text" name="vin" id="vin" style="width:120px;" value='<s:property value="vin"/>' />
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Fuel Type</label>
                    <select name="cmbfueltype" id="cmbfueltype" style="flex:1;">
                        <option value="">--Select--</option>
                        <option value="P">Petrol</option>
                        <option value="D">Diesel</option>
                        <option value="E">Electric</option>
                    </select>
                    
                    <label class="lbl-right" style="width:120px;">Tank Capacity</label>
                    <input type="text" name="fuelcapacity" id="fuelcapacity" style="width:80px;" value='<s:property value="fuelcapacity"/>'/>
                    
                    <label class="lbl-right" style="width:50px;">Color</label>
                    <select name="cmbveh_color" id="cmbveh_color" style="width:120px;">
                        <option>--Select--</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- ================= PANEL 3: Warranty AND Service Info ================= -->
        <div style="display: flex; gap: 15px;">
            <div class="middle-panel" style="flex: 1;">
                <span class="middle-panel-title">Warranty Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Warranty Period</label>
                    <input type="text" id="warranty_period" name="warranty_period" style="width:120px;" value='<s:property value="warranty_period"/>' onblur="getWarrantyDate(this.value);"/>
                    
                    <label class="lbl-right" style="width:120px; margin-left:auto;">Warranty KM</label>
                    <input type="text" name="warranty_km" id="warranty_km" style="width:120px; text-align:right;" value='<s:property value="warranty_km"/>' />
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:120px;">From Date</label>
                    <div style="width: 125px;">
                        <div id='jqxWrntyFrmDate' name='jqxWrntyFrmDate' value='<s:property value="jqxWrntyFrmDate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:120px; margin-left:auto;">To Date</label>
                    <div style="width: 125px;">
                        <div id='jqxWrntyToDate' name='jqxWrntyToDate' value='<s:property value="jqxWrntyToDate"/>'></div>
                    </div>
                </div>
            </div>

            <div class="middle-panel" style="flex: 1;">
                <span class="middle-panel-title">Service Info</span>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:140px;">Service Duration (KM)</label>
                    <input type="text" id="service_km" name="service_km" style="width:100px; text-align:right;" value='<s:property value="service_km"/>' />
                    
                    <label class="lbl-right" style="width:120px; margin-left:auto;">Last Srvc. Date</label>
                    <div style="width: 125px;">
                        <div id='jqxLstSrvcDate' name='jqxLstSrvcDate' value='<s:property value="jqxLstSrvcDate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" id="lbllastsrvkm" style="width:120px; margin-left:auto;">Last Service KM</label>
                    <input type="text" id="last_srvc_km" name="last_srvc_km" style="width:100px; text-align:right;" value='<s:property value="last_srvc_km"/>' />
                </div>
            </div>
        </div>

        <!-- ================= PANEL 4: 3-Column Detailed Data ================= -->
        <div style="display: flex; gap: 15px;">
            
            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Financial Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Registered Date</label>
                    <div style="width: 125px;">
                        <div id='jqxFinRegDate' name='jqxFinRegDate' value='<s:property value="jqxFinRegDate"/>'></div>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Purchase Cost</label>
                    <input type="text" name="purchase_cost" id="purchase_cost" style="width:120px; text-align:right;" value='<s:property value="purchase_cost"/>' onblur="getTotal();" required/>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Additions</label>
                    <input type="text" id="additions" name="additions" style="width:120px; text-align:right;" value='<s:property value="additions"/>' onblur="getTotal();"/>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Total</label>
                    <input type="text" id="total" name="total" style="width:120px; text-align:right; font-weight:bold;" value='<s:property value="total"/>' readonly/>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Accu. Dep.</label>
                    <input type="text" id="accu_dep" name="accu_dep" style="width:120px; text-align:right;" value='<s:property value="accu_dep"/>' />
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">CostTran No</label>
                    <input type="text" id="tran_no" name="tran_no" style="width:120px;" value='<s:property value="tran_no"/>' readonly tabindex="-1"/>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Insur Membership</label>
                    <input type="text" name="insurmember" id="insurmember" style="width:120px;" value='<s:property value="insurmember"/>' />
                </div>
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:120px;">Tracking ID</label>
                    <input type="text" name="trackid" id="trackid" style="width:120px;" value='<s:property value="trackid"/>' />
                </div>
            </div>

            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Other Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Dealer</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" name="dealer" id="dealer" value='<s:property value="dealer"/>' onKeyDown="getDealer(event);" placeholder="Press F3">
                        <svg class="magnifier-icon" onclick="funSearchdblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">LPO No</label>
                    <input type="text" id="lpo_no" name="lpo_no" style="flex:1;" value='<s:property value="lpo_no"/>'/>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Purchase Invoice</label>
                    <input type="text" id="purchase_invoice" name="purchase_invoice" style="flex:1;" value='<s:property value="purchase_invoice"/>'/>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Purchase Date</label>
                    <div style="width: 125px;">
                        <div id='jqxPurchaseDate' name='jqxPurchaseDate' value='<s:property value="jqxPurchaseDate"/>'></div>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Financier</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" name="financier" id="financier" value='<s:property value="financier"/>' onkeydown="getFin(event);" placeholder="Press F3">
                        <svg class="magnifier-icon" onclick="funFinSearchdblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Release Date</label>
                    <div style="width: 125px;">
                        <div id='jqxFinRelDate' name='jqxFinRelDate' value='<s:property value="jqxFinRelDate"/>'></div>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Insurance Type</label>
                    <select name="cmbinsurance_type" id="cmbinsurance_type" style="flex:1;">
                        <option value="">--Select--</option>
                        <option value="Comprehensive">Comprehensive</option>
                        <option value="3rdParty">3rd Party</option>
                    </select>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Insurance Comp</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="insurance_comp" name="insurance_comp" placeholder="Press F3" value='<s:property value="insurance_comp"/>' onkeydown="getInsurance(event);"/>
                        <svg class="magnifier-icon" onclick="funInsurSearchdblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Policy No</label>
                    <input type="text" id="policy_no" name="policy_no" style="flex:1;" value='<s:property value="policy_no"/>' onblur="getservtab();" />
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">File No</label>
                    <input type="text" name="fileno" id="fileno" style="flex:1;" value='<s:property value="fileno"/>' />
                </div>
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Mortgaged To</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" name="mortgaged" id="mortgaged" value='<s:property value="mortgaged"/>' placeholder="Press F3" readonly onkeydown="getMortgaged(event);"/>
                        <svg class="magnifier-icon" onclick="$('#mortgaged').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
            </div>

            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Fleet Release Info</span>
                
                <div class="field-row" style="justify-content: center; gap: 10px; margin-bottom: 15px;">
                    <input type="button" name="releasesave" id="releasesave" class="myButton" value="Save" onClick="funRelease();">
                    <input type="button" name="btnrelease" id="btnrelease" class="myButton" value="Release" onClick="funEnable();">
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Fleet No</label>
                    <input type="text" name="releasefleet" id="releasefleet" style="flex:1;" value='<s:property value="releasefleet"/>'>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Branch</label>
                    <select name="cmbrlsbranch" id="cmbrlsbranch" onChange="getLocation(this.value);" style="flex:1;">
                        <option value="">--Select--</option>
                    </select>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Location</label>
                    <select name="cmbrlsloc" id="cmbrlsloc" style="flex:1;">
                        <option value="">--Select--</option>
                    </select>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Rental Status</label>
                    <select name="cmbrentalstatus" id="cmbrentalstatus" style="flex:1;">
                        <option value="R">Rental</option>
                        <option value="L">Lease</option>
                        <option value="LM">Limousine</option>
                        <option value="A">All</option>
                    </select>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="releasedate" name="releasedate" value='<s:property value="releasedate"/>'></div>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Time</label>
                    <div style="width: 80px;">
                        <div id="releasetime" name="releasetime" value='<s:property value="releasetime"/>'></div>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">KM</label>
                    <input type="text" name="releasekm" id="releasekm" style="flex:1; text-align:right;" value='<s:property value="releasekm"/>' tabindex="-1" readonly>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Fuel</label>
                    <input type="text" name="releasefuel" id="releasefuel" style="flex:1;" value='<s:property value="releasefuel"/>' tabindex="-1" readonly>
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Op. Status</label>
                    <input type="text" name="opstatus" id="opstatus" style="flex:1;" value='IN' tabindex="-1" disabled="true">
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Ast status</label>
                    <input type="text" name="aststatus" id="aststatus" style="flex:1;" value='<s:property value="aststatus"/>' tabindex="-1">
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Calibration Km</label>
                    <input type="text" name="calibrationkm" id="calibrationkm" style="flex:1; text-align:right;" value='<s:property value="calibrationkm"/>' onblur="getspectab();">
                </div>
                
                <div id="fleetwarning" style="color:red; font-weight:bold; text-align:center; margin-top:10px;">All fields are Mandatory</div>
            </div>
            
        </div>

        <!-- Hidden Core Logic Fields -->
        <div style="display:none;">
            <input type="hidden" id="hidjqxDate1" name="hidjqxDate1" value='<s:property value="hidjqxDate1"/>' />
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>' />
            <input type="hidden" id="hidcmbsubcategory" name="hidcmbsubcategory" value='<s:property value="hidcmbsubcategory"/>' />
            <input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>' />
            <input type="hidden" id="hidcmbsize" name="hidcmbsize" value='<s:property value="hidcmbsize"/>' />
            <input type="hidden" id="hidcmbauthority" name="hidcmbauthority" value='<s:property value="hidcmbauthority"/>' />
            <input type="hidden" id="hidcmbbrand" name="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'/>
            <input type="hidden" id="hidcmbmodel" name="hidcmbmodel" value='<s:property value="hidcmbmodel"/>' />
            <input type="hidden" id="hidcmbyom" name="hidcmbyom" value='<s:property value="hidcmbyom"/>' />
            <input type="hidden" id="hidcmbplate" name="hidcmbplate" value='<s:property value="hidcmbplate"/>' />
            
            <input type="hidden" id="hidjqxWrntyFrmDate" name="hidjqxWrntyFrmDate" value='<s:property value="hidjqxWrntyFrmDate"/>' />
            <input type="hidden" id="hidjqxWrntyToDate" name="hidjqxWrntyToDate" value='<s:property value="hidjqxWrntyToDate"/>' />
            <input type="hidden" id="hidjqxLstSrvcDate" name="hidjqxLstSrvcDate" value='<s:property value="hidjqxLstSrvcDate"/>' />
            <input type="hidden" id="hidcmbfuel" name="hidcmbfuel" value='<s:property value="hidcmbfuel"/>' />
            <input type="hidden" name="hidcmbfueltype" id="hidcmbfueltype" value='<s:property value="hidcmbfueltype"/>' />
            
            <input type="hidden" id="hidcmbavail_br1" name="hidcmbavail_br1" value='<s:property value="hidcmbavail_br1"/>' />
            <input type="hidden" id="tcno2" name="tcno2" value='<s:property value="tcno2"/>'/>
            <select name="branded" id="branded"><option value="Y" selected>Y</option><option value="N">N</option></select>
            <input type="hidden" id="hidbranded" name="hidbranded" value='<s:property value="hidbranded"/>' />
            <input type="hidden" name="hidreleasetime" id="hidreleasetime" value='<s:property value="hidreleasetime"/>'>
            
            <input type="text" id="deal_no" name="deal_no" value='<s:property value="deal_no"/>' />
            <input type="text" id="interest_amt" name="interest_amt" value='<s:property value="interest_amt"/>' />
            <input type="text" id="down_payment" name="down_payment" value='<s:property value="down_payment"/>' />
            <input type="text" id="no_installments" name="no_installments" value='<s:property value="no_installments"/>' />
            <input type="text" id="installment_amt" name="installment_amt" value='<s:property value="installment_amt"/>' />
            <input type="text" id="insured_amt" name="insured_amt" value='<s:property value="insured_amt"/>'/>
            <select name="purchase" id="purchase"><option value="Cash" selected>Cash</option><option value="Credit">Credit</option></select>
            <input type="text" id="premium_perc" name="premium_perc" value='<s:property value="premium_perc"/>' />
            <input type="text" id="premium_amt" name="premium_amt" value='<s:property value="premium_amt"/>' />
            
            <input type="hidden" name="hiddealer" id="hiddealer" value='<s:property value="hiddealer"/>'>
            <input type="hidden" name="hidpurchase" id="hidpurchase" value='<s:property value="hidpurchase"/>'>
            <input type="hidden" id="hidjqxPurchaseDate" name="hidjqxPurchaseDate" value='<s:property value="hidjqxPurchaseDate"/>' />
            <input type="hidden" id="hidfinancier" name="hidfinancier" value='<s:property value="hidfinancier"/>' />
            <input type="hidden" name="hidmortgaged" id="hidmortgaged" value='<s:property value="hidmortgaged"/>'/>
            
            <input type="hidden" name="hidinsurance_comp" id="hidinsurance_comp" value='<s:property value="hidinsurance_comp"/>'>
            <input type="hidden" id="hidjqxFinRelDate" name="hidjqxFinRelDate" value='<s:property value="hidjqxFinRelDate"/>' />
            <input type="hidden" id="hidcmbinsurance_type" name="hidcmbinsurance_type" value='<s:property value="hidcmbinsurance_type"/>' />
            <input type="hidden" id="hidjqxOtherRegExp" name="hidjqxOtherRegExp" value='<s:property value="hidjqxOtherRegExp"/>' />
            <input type="hidden" id="hidjqxOtherInsExp" name="hidjqxOtherInsExp" value='<s:property value="hidjqxOtherInsExp"/>' />
            <input type="hidden" id="hidjqxFinRegDate" name="hidjqxFinRegDate" value='<s:property value="hidjqxFinRegDate"/>' />
            
            <input type="hidden" name="hidcmbrlsbranch" id="hidcmbrlsbranch" value='<s:property value="hidcmbrlsbranch"/>' >
            <input type="hidden" name="hidcmbrlsloc" id="hidcmbrlsloc" value='<s:property value="hidcmbrlsloc"/>'>
            <input type="hidden" name="hidcmbrentalstatus" id="hidcmbrentalstatus" value='<s:property value="hidcmbrentalstatus"/>'>
            <input type="hidden" name="hidreleasedate" id="hidreleasedate" value='<s:property value="hidreleasedate"/>'>
            
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            
            <!-- Kept for backward compatibility with form scripts -->
            <select name="cmbfuel" id="cmbfuel"><option value=0.000>Level 0/8</option><option value=0.125 selected>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option></select>
        </div>
        
        <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px; text-align:center;"></div>

    </div>
</form>

<!-- Search Windows -->
<div id="dealerWindow"><div></div></div>
<div id="financierWindow"><div></div></div>
<div id="insuranceWindow"><div></div></div>
<div id="specwindow"><div></div></div>
<div id="releaseWindow"><div></div><div style="background-color:#E0ECF8;"></div></div>

</div>
</body>
</html>