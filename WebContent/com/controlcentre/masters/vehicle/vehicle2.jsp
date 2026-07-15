<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="tab.css" />
<jsp:include page="tab.jsp" />

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

/* Original Custom Button Styles (Retained for specific element references if needed) */
.sep { border-bottom:1px solid black; }
.alignright{ text-align:right; }
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

        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
		$("#releasetime").jqxDateTimeInput({ width: '125px', height: 24, formatString: 'HH:mm', showCalendarButton: false, theme: 'energyblue' });
  	    $("#jqxDate1").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });  
		$("#jqxPurchaseDate").jqxDateTimeInput({width : '125px', height : 24, formatString : "dd.MM.yyyy", value:null, theme: 'energyblue'});
		$("#jqxFinRegDate").jqxDateTimeInput({width : '125px', height : 24, formatString : "dd.MM.yyyy", value:null, theme: 'energyblue'});
		$("#jqxFinRelDate").jqxDateTimeInput({width : '125px', height : 24, formatString : "dd.MM.yyyy", value:null, theme: 'energyblue'});
		$("#jqxOtherRegExp").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", value:null, theme: 'energyblue'});
		$("#jqxOtherInsExp").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy" , value:null, theme: 'energyblue'});
		$("#jqxWrntyFrmDate").jqxDateTimeInput({width : '125px', height : 24, formatString : "dd.MM.yyyy", value:null, theme: 'energyblue'});
		$("#jqxWrntyToDate").jqxDateTimeInput({width : '125px',	height : 24, formatString : "dd.MM.yyyy", value:null, theme: 'energyblue'});
		$("#jqxLstSrvcDate").jqxDateTimeInput({	width : '125px', height : 24, formatString : "dd.MM.yyyy", value:null, theme: 'energyblue'});
		$("#releasedate").jqxDateTimeInput({width : '125px', height : 24, formatString : "dd.MM.yyyy", value:null, theme: 'energyblue'});
		
        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#releasetime, #jqxDate1, #jqxPurchaseDate, #jqxFinRegDate, #jqxFinRelDate, #jqxOtherRegExp, #jqxOtherInsExp, #jqxWrntyFrmDate, #jqxWrntyToDate, #jqxLstSrvcDate, #releasedate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#releasetime, #jqxDate1, #jqxPurchaseDate, #jqxFinRegDate, #jqxFinRelDate, #jqxOtherRegExp, #jqxOtherInsExp, #jqxWrntyFrmDate, #jqxWrntyToDate, #jqxLstSrvcDate, #releasedate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
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
		   
		$('#jqxFinRegDate').on('change', function (event) {  
            changeDate();
        });
		
        $('#jqxPurchaseDate').on('change', function (event) {  
            var purdate= $('#jqxPurchaseDate').jqxDateTimeInput('getDate');
            $('#jqxWrntyFrmDate ').jqxDateTimeInput('setDate', new Date(purdate));
        });

		getTestPlateCode();
		getTestModel();
		getTestLocation(); 

		$('#mortgaged').dblclick(function(){
            $('#financierWindow').jqxWindow('open');
            $('#financierWindow').jqxWindow('focus');
            financierSearchContent('mortgagedGrid.jsp?', $('#financierWindow'));
        });
	});

	function getMortgaged(event){
        var x= event.keyCode;
        if(x==114){
            financierSearchContent('mortgagedGrid.jsp');
        }
    }

	function changeDate(){
        var finregdate= $('#jqxFinRegDate').jqxDateTimeInput('getDate');
        var finaldate=new Date(new Date(finregdate).setMonth(finregdate.getMonth()+12));
        var finaldate2=new Date(new Date(finaldate).setDate(finaldate.getDate()-1));
        $('#jqxOtherRegExp ').jqxDateTimeInput('setDate', new Date(finaldate2));
        var insexp1=new Date(new Date(new Date(finregdate).setMonth(finregdate.getMonth()+13)));
        var insexp2=new Date(new Date(insexp1).setDate(insexp1.getDate()-1));
        $('#jqxOtherInsExp ').jqxDateTimeInput('setDate', new Date(insexp2));
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
		$('#frmVehicle input').attr('readonly', true);
		$('#frmVehicle select').attr('disabled', true);
		$('#jqxDate1').jqxDateTimeInput({ disabled: true}); 
		$('#jqxPurchaseDate').jqxDateTimeInput({ disabled: true});
		$('#jqxFinRegDate').jqxDateTimeInput({ disabled: true});
		$('#jqxFinRelDate').jqxDateTimeInput({ disabled: true});
		$('#jqxOtherRegExp').jqxDateTimeInput({ disabled: true});
		$('#jqxOtherInsExp').jqxDateTimeInput({ disabled: true});
		$('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: true});
		$('#jqxWrntyToDate').jqxDateTimeInput({ disabled: true}); 
		$('#jqxLstSrvcDate').jqxDateTimeInput({ disabled: true}); 
		$('#releasedate').jqxDateTimeInput({ disabled: true}); 
		$('#releasetime').jqxDateTimeInput({ disabled: true}); 
		getAuth();
		getBrand();
		getGroup();
		getYOM();
		getColor();
		getFinancier();
		getBrch();
		showRelease(); 
		getStatus();
	}

	function showRelease(){
        var temp=$("#aststatus").val();
        if(temp=="INDUCTED"){
            document.getElementById("btnrelease").value="To Be Released";
        }
        else if(temp=="LIVE"){
            document.getElementById("btnrelease").style.display="none";
            document.getElementById("releasesave").style.display="none";
        }
        else{
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
		}
		else{
			document.getElementById("fleetwarning").style.display="none";
            $('#cmbfuel').attr('disabled', false); 
            if(document.getElementById("releasefleet").value<=0){
                return false;
            }
            $('#jqxDate1').jqxDateTimeInput({disabled:false});
            $('#jqxPurchaseDate').jqxDateTimeInput({disabled:false});
            $('#jqxFinRegDate').jqxDateTimeInput({disabled:false});
            $('#jqxFinRelDate').jqxDateTimeInput({disabled:false});
            $('#jqxOtherRegExp').jqxDateTimeInput({disabled:false});
            $('#jqxOtherInsExp').jqxDateTimeInput({disabled:false});
            $('#jqxWrntyFrmDate').jqxDateTimeInput({disabled:false});
            $('#jqxWrntyToDate').jqxDateTimeInput({disabled:false});
            $('#jqxLstSrvcDate').jqxDateTimeInput({disabled:false});
            document.getElementById("frmVehicle").submit();
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
		$('#frmVehicle input').attr('readonly', false);
		$('#frmVehicle select').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#dealer').attr('readonly', true);
		$('#financier').attr('readonly', true);
		$('#insurance_comp').attr('readonly', true);
		$('#mortgaged').attr('readonly', true);
        $('#jqxDate1').jqxDateTimeInput({ disabled: false}); 
        $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: false});
        $('#jqxFinRegDate').jqxDateTimeInput({ disabled: false});
        $('#jqxFinRelDate').jqxDateTimeInput({ disabled: false});
        $('#jqxOtherRegExp').jqxDateTimeInput({ disabled: false});
        $('#jqxOtherInsExp').jqxDateTimeInput({ disabled: false});
        $('#jqxLstSrvcDate').jqxDateTimeInput({ disabled: false}); 
        $("#releasefleet").attr("disabled", true); 
        $("#cmbrlsbranch").attr("disabled", true); 
        $("#cmbrlsloc").attr("disabled", true); 
        $("#cmbrentalstatus").attr("disabled", true); 
        $('#releasedate').jqxDateTimeInput({ disabled: true});
        $('#releasetime').jqxDateTimeInput({ disabled: true});
        $("#releasekm").attr("readonly",true);
        $("#releasefuel").attr("readonly", true);

        if(document.getElementById("mode").value=='A'){
            $("#jqxSpecification").jqxGrid("clear");
            $("#jqxSpecification").jqxGrid("addrow", null, {});
            $("#jqxFinRegDate,#jqxDate1").jqxDateTimeInput('setDate', new Date());
            $("#jqxPurchaseDate").jqxDateTimeInput('setDate', new Date());
            $("#jqxFinRelDate").jqxDateTimeInput('setDate', new Date());
            $("#releasedate").jqxDateTimeInput('setDate', new Date());
            $("#jqxWrntyFrmDate").jqxDateTimeInput('setDate', new Date());
            $("#jqxWrntyToDate").jqxDateTimeInput('setDate', new Date());
            $("#jqxLstSrvcDate").jqxDateTimeInput('setDate', new Date());
            $("#releasetime").jqxDateTimeInput('setDate', new Date());
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

		if($('#hidreleasetime').val()){
			$("#releasetime").jqxDateTimeInput('val', $('#hidreleasetime').val());
		}
		if ($('#hidcmbfueltype').val() != null) {
			$('#cmbfueltype').val($('#hidcmbfueltype').val());
		}
		if ($('#hidpurchase').val() != null) {
			$('#purchase').val($('#hidpurchase').val());
		}
	 	if ($('#hidcmbplate').val() != null) {
			$('#cmbplate').val($('#hidcmbplate').val());
		} 
		if ($('#hidcmbinsurance_type').val() != null) {
			$('#cmbinsurance_type').val($('#hidcmbinsurance_type').val());
		}
		if ($('#hidcmbfuel').val() != null) {
			$('#cmbfuel').val($('#hidcmbfuel').val());
		}
		if ($('#hidcmbrentalstatus').val() != null) {
			$('#cmbrentalstatus').val($('#hidcmbrentalstatus').val());
		} 
		
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
		 
        if(document.getElementById("docno").value!=''){
            var docno1=document.getElementById("docno").value.trim();
            $("#specdiv").load("specificationGrid.jsp?aaa=aaa&docno1="+docno1);
        }
	}

	function funFocus() {
        document.getElementById("cmbauthority").focus();
    }

    $(function(){
        $('#frmVehicle').validate({
            rules: {
                cmbauthority:"required",
                cmbplate:"required",
                cmbgroup:"required",
                regno:"required",
                cmbbrand:"required",
                cmbmodel:"required",
                cmbyom:"required",
                purchase_cost:"required",
                cmbavail_br1:"required",
                purchase:"required",
                cmbfueltype:"required",
                fuelcapacity:"required",
                cmbfuel:"required",
                purchase_cost:"number",
                additions:"number",
                current_km:"required",
                accu_dep:"required"
            }, 
            messages:{
                cmbauthority:" *",
                cmbplate:" *",
                cmbgroup:" *",
                regno:" *",
                cmbbrand:" *",
                cmbmodel:" *",
                cmbyom:" *",
                purchase_cost:" *",
                cmbavail_br1:" *",
                purchase:" *",
                cmbfueltype:" *",
                fuelcapacity:" *",
                cmbfuel:" *",
                purchase_cost:"Digits",
                additions:"Digits",
                current_km:"*",
                accu_dep:"*"
            }
        });
    });

    function funNotify(){
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
		 
        var rows = $("#jqxSpecification").jqxGrid('getrows');
        if(!((rows[0].doc_no=="undefined") || (rows[0].doc_no==null) || (rows[0].doc_no==""))){
            $('#gridlength').val(rows.length);
            for(var i=0 ; i < rows.length ; i++){
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "test"+i)
                .attr("name", "test"+i)
                .attr("hidden", "true");
                
                newTextBox.val(rows[i].doc_no+"::");
                newTextBox.appendTo('form');
            }
        }
        
        $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: false});
        $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: false});
        checkRegNo();	
        if(document.getElementById("errormsg").innerText!=""){
            return 0;	
        }else {
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
        if (!isNaN(result)) {
            document.getElementById('total').value = result;
        }	   
    }

    function getFleetName(){
        document.getElementById("fleetname").value="";
        var r=$("#cmbbrand option:selected").text();
        var r1=$("#cmbmodel option:selected").text();
        document.getElementById("fleetname").value = r+" "+r1;
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

    function getservtab(){
        $('#servtab').trigger('click');
    }

    function getspectab(){
        $('#spectab').trigger('click');
    }

    function checkRegNo(){
        var mode=document.getElementById("mode").value;
        var docno=document.getElementById("docno").value;
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                if(parseInt(items)>0){
                    document.getElementById("errormsg").innerText="Reg No Already Exists";
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

<link href="../../../../css/body.css" rel="stylesheet" type="text/css">
<jsp:include page="../../../../includes.jsp"></jsp:include>
</head>

<body onLoad="setValues();">
    
<div id="mainBG" class="homeContent" data-type="background"> 
    <form id="frmVehicle" action="saveVehicle" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Vehicle Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Fleet No</label>
                    <input type="text" name="fleetno" id="fleetno" readonly tabindex="-1" style="width: 80px;" value='<s:property value="fleetno"/>'> 
                    <input type="text" name="fleetname" id="fleetname" readonly tabindex="-1" style="width: 150px;" value='<s:property value="fleetname"/>'>

                    <label class="lbl-right" style="width:80px; margin-left:auto;">Date</label>
                    <div style="width: 125px;">
                        <div id="jqxDate1" name="jqxDate1" value='<s:property value="jqxDate1"/>'></div>
                    </div>
                    <input type="hidden" id="hidjqxDate1" name="hidjqxDate1" value='<s:property value="hidjqxDate1"/>' />

                    <label class="lbl-right" style="width:80px;">Doc No</label>
                    <input type="text" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1" style="width:120px;">
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Authority</label>
                    <select name="cmbauthority" id="cmbauthority" value='<s:property value="cmbauthority"/>' style="width:120px;" onchange="getPlateCode(this.value);">
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbauthority" name="hidcmbauthority" value='<s:property value="hidcmbauthority"/>' />

                    <label class="lbl-right" style="width:80px;">Plate Code</label>
                    <select name="cmbplate" id="cmbplate" value='<s:property value="cmbplate"/>' style="width:120px;">
                        <option>--select--</option>
                    </select>
                    <input type="hidden" id="hidcmbplate" name="hidcmbplate" value='<s:property value="hidcmbplate"/>' />

                    <label class="lbl-right" style="width:80px;">Reg No</label>
                    <input type="text" name="regno" id="regno" style="width:120px;" value='<s:property value="regno"/>' autocomplete="off" onblur="checkRegNo();">

                    <label class="lbl-right" style="width:80px;">Group</label>
                    <select name="cmbgroup" id="cmbgroup" value='<s:property value="cmbgroup"/>' style="width:120px;" onchange="getLevel(this.value);">
                        <option>--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>' />

                    <label class="lbl-right" style="width:80px;">Level</label>
                    <input type="text" name="group_name" id="group_name" value='<s:property value="group_name"/>' tabindex="-1" style="width:120px;">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Brand</label>
                    <select name="cmbbrand" id="cmbbrand" value='<s:property value="cmbbrand"/>' style="width:120px;" onchange="getModel(this.value);">
                        <option>--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbbrand" name="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'/>

                    <label class="lbl-right" style="width:80px;">Model</label>
                    <select name="cmbmodel" id="cmbmodel" value='<s:property value="cmbmodel"/>' style="width:120px;" onchange="getFleetName();">
                        <option>--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbmodel" name="hidcmbmodel" value='<s:property value="hidcmbmodel"/>' />

                    <label class="lbl-right" style="width:80px;">YoM</label>
                    <select name="cmbyom" id="cmbyom" value='<s:property value="cmbyom"/>' style="width:120px;">
                        <option>--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbyom" name="hidcmbyom" value='<s:property value="hidcmbyom"/>' />

                    <label class="lbl-right" style="width:80px;">Salik Tag</label>
                    <input type="text" id="salik_tag" name="salik_tag" value='<s:property value="salik_tag"/>' style="width:120px;" />

                    <label class="lbl-right" style="width:80px;">TC No</label>
                    <input type="text" id="tcno" name="tcno" value='<s:property value="tcno"/>' style="width:120px;" />
                </div>
                
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            </div>

            <ul id="tabs" style="margin-top: 15px;">
                <li><a href="#" name="tab1" id="inductiontab">Induction</a></li>
                <li><a href="#" name="tab2" id="servtab">Services And Other Details</a></li>
                <li><a href="#" name="tab3" id="spectab">Specifications</a>
                
                <div style="display:none;">
                    <input type="text" id="deal_no" name="deal_no" value='<s:property value="deal_no"/>'/>
                    <input type="text" id="interest_amt" name="interest_amt" value='<s:property value="interest_amt"/>'/>
                    <input type="text" id="down_payment" name="down_payment" value='<s:property value="down_payment"/>'/>
                    <input type="text" id="no_installments" name="no_installments" value='<s:property value="no_installments"/>'/>
                    <input type="text" id="installment_amt" name="installment_amt" value='<s:property value="installment_amt"/>'/>
                    <input type="text" id="insured_amt" name="insured_amt" value='<s:property value="insured_amt"/>'/>
                    <select name="purchase" id="purchase" value='<s:property value="purchase"/>'>
                        <option>--Select--</option>
                        <option value="Cash" selected>Cash</option>
                        <option value="Credit">Credit</option>
                    </select>
                    <input type="text" id="premium_perc" name="premium_perc" value='<s:property value="premium_perc"/>' />
                    <input type="text" id="premium_amt" name="premium_amt" value='<s:property value="premium_amt"/>' />
                </div>
                </li>
            </ul>

            <div id="content" style="padding-top: 15px;">
                <div id="tab1">
                    <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                        
                        <!-- Panel 1: Info -->
                        <div class="middle-panel" style="flex: 1; min-width: 300px; margin-top:0;">
                            <span class="middle-panel-title">Info</span>
                            
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Registered Date</label>
                                <div style="width: 125px;">
                                    <div id="jqxFinRegDate" name="jqxFinRegDate" value='<s:property value="jqxFinRegDate"/>'></div>
                                </div>
                                <input type="hidden" name="hiddealer" id="hiddealer" value='<s:property value="hiddealer"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Reg. Expiry</label>
                                <div style="width: 125px;">
                                    <div id="jqxOtherRegExp" name="jqxOtherRegExp" value='<s:property value="jqxOtherRegExp"/>'></div>
                                </div>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Insurance Expiry</label>
                                <div style="width: 125px;">
                                    <div id="jqxOtherInsExp" name="jqxOtherInsExp" value='<s:property value="jqxOtherInsExp"/>'></div>
                                </div>
                                <input type="hidden" name="hidpurchase" id="hidpurchase" value='<s:property value="hidpurchase"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Purchase Cost</label>
                                <input type="text" name="purchase_cost" id="purchase_cost" value='<s:property value="purchase_cost"/>' style="text-align:right; width:125px;" onblur="getTotal();" required/>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Additions</label>
                                <input type="text" id="additions" name="additions" value='<s:property value="additions"/>' style="text-align:right; width:125px;" onblur="getTotal();"/>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Total</label>
                                <input type="text" id="total" name="total" value='<s:property value="total"/>' style="text-align:right; width:125px; font-weight:bold; color:#0b45a2;" readonly/>
                                <input type="hidden" id="hidjqxPurchaseDate" name="hidjqxPurchaseDate" value='<s:property value="hidjqxPurchaseDate"/>' />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Depr %</label>
                                <input type="text" id="depr_perc" name="depr_perc" value='<s:property value="depr_perc"/>' style="text-align:right; width:125px;" onblur="depr_percent(this.value);"/>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Accu. Dep.</label>
                                <input type="text" id="accu_dep" name="accu_dep" value='<s:property value="accu_dep"/>' style="text-align:right; width:125px;" />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">CostTran No</label>
                                <input type="text" id="tran_no" readonly name="tran_no" value='<s:property value="tran_no"/>' tabindex="-1" style="width:125px;" />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Insur Membership</label>
                                <input type="text" name="insurmember" id="insurmember" value='<s:property value="insurmember"/>' style="width:125px;" />
                            </div>
                            <div class="field-row" style="margin-bottom:0;">
                                <label class="lbl-right" style="width:120px;">Tracking ID</label>
                                <input type="text" name="trackid" id="trackid" value='<s:property value="trackid"/>' style="width:125px;" />
                            </div>
                        </div>

                        <!-- Panel 2: Other Info -->
                        <div class="middle-panel" style="flex: 1; min-width: 300px; margin-top:0;">
                            <span class="middle-panel-title">Other Info</span>
                            
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Dealer</label>
                                <div class="input-search-container" style="width: 150px;">
                                    <input type="text" name="dealer" id="dealer" value='<s:property value="dealer"/>' onDblClick="funSearchdblclick();" onKeyDown="getDealer(event);" placeholder="Press F3" />
                                    <svg class="magnifier-icon" onclick="$('#dealer').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                </div>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">LPO No</label>
                                <input type="text" id="lpo_no" name="lpo_no" value='<s:property value="lpo_no"/>' style="width:150px;" />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Purchase Invoice</label>
                                <input type="text" id="purchase_invoice" name="purchase_invoice" value='<s:property value="purchase_invoice"/>' style="width:150px;" />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Purchase Date</label>
                                <div style="width: 125px;">
                                    <div id="jqxPurchaseDate" name="jqxPurchaseDate" value='<s:property value="jqxPurchaseDate"/>'></div>
                                </div>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Financer</label>
                                <div class="input-search-container" style="width: 150px;">
                                    <input type="text" name="financier" id="financier" value='<s:property value="financier"/>' ondblclick="funFinSearchdblclick();" onkeydown="getFin(event);" placeholder="Press F3" />
                                    <svg class="magnifier-icon" onclick="$('#financier').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                </div>
                                <input type="hidden" id="hidfinancier" name="hidfinancier" value='<s:property value="hidfinancier"/>' />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Release Date</label>
                                <div style="width: 125px;">
                                    <div id="jqxFinRelDate" name="jqxFinRelDate" value='<s:property value="jqxFinRelDate"/>'></div>
                                </div>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Insurance Type</label>
                                <select name="cmbinsurance_type" id="cmbinsurance_type" value='<s:property value="cmbinsurance_type"/>' style="width:150px;">
                                    <option value="">--Select--</option>
                                    <option value="Comprehensive">Comprehensive</option>
                                    <option value="3rdParty">3rd Party</option>
                                </select>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Insurance Comp</label>
                                <div class="input-search-container" style="width: 150px;">
                                    <input type="text" id="insurance_comp" name="insurance_comp" placeholder="Press F3" value='<s:property value="insurance_comp"/>' ondblclick="funInsurSearchdblclick();" onkeydown="getInsurance(event);" />
                                    <svg class="magnifier-icon" onclick="$('#insurance_comp').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                </div>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Policy No</label>
                                <input type="text" id="policy_no" name="policy_no" value='<s:property value="policy_no"/>' onblur="getservtab();" style="width:150px;" />
                                <input type="hidden" id="hidjqxFinRegDate" name="hidjqxFinRegDate" value='<s:property value="hidjqxFinRegDate"/>' />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">File No</label>
                                <input type="text" name="fileno" id="fileno" value='<s:property value="fileno"/>' style="width:150px;" />
                            </div>
                            <div class="field-row" style="margin-bottom:0;">
                                <label class="lbl-right" style="width:120px;">Mortgaged To</label>
                                <div class="input-search-container" style="width: 150px;">
                                    <input type="text" name="mortgaged" id="mortgaged" value='<s:property value="mortgaged"/>' placeholder="Press F3" readonly onkeydown="getMortgaged(event);" />
                                    <svg class="magnifier-icon" onclick="$('#mortgaged').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                </div>
                                <input type="hidden" name="hidmortgaged" id="hidmortgaged" value='<s:property value="hidmortgaged"/>'/>
                            </div>

                            <div style="display:none;">
                                <input type="hidden" name="hidinsurance_comp" id="hidinsurance_comp" value='<s:property value="hidinsurance_comp"/>'>
                                <input type="hidden" id="hidjqxFinRelDate" name="hidjqxFinRelDate" value='<s:property value="hidjqxFinRelDate"/>' />
                                <input type="hidden" id="hidcmbinsurance_type" name="hidcmbinsurance_type" value='<s:property value="hidcmbinsurance_type"/>' />
                                <input type="hidden" id="hidjqxOtherRegExp" name="hidjqxOtherRegExp" value='<s:property value="hidjqxOtherRegExp"/>' />
                                <input type="hidden" id="hidjqxOtherInsExp" name="hidjqxOtherInsExp" value='<s:property value="hidjqxOtherInsExp"/>' />
                            </div>
                        </div>

                        <!-- Panel 3: Fleet Release Info -->
                        <div class="middle-panel" id="releaseid" style="flex: 1; min-width: 300px; margin-top:0;">
                            <span class="middle-panel-title">Fleet Release Info</span>
                            
                            <div class="field-row" style="justify-content: center; margin-bottom: 15px;">
                                <button type="button" name="releasesave" id="releasesave" class="myButton" onClick="funRelease();">Save</button>
                                <button type="button" name="btnrelease" id="btnrelease" class="myButton" onClick="funEnable();">Release</button>
                            </div>

                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Fleet No</label>
                                <input type="text" name="releasefleet" id="releasefleet" value='<s:property value="releasefleet"/>' style="width:150px;" />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Branch</label>
                                <select name="cmbrlsbranch" id="cmbrlsbranch" value='<s:property value="cmbrlsbranch"/>' onChange="getLocation(this.value);" style="width:150px;">
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden" name="hidcmbrlsbranch" id="hidcmbrlsbranch" value='<s:property value="hidcmbrlsbranch"/>' >
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Location</label>
                                <select name="cmbrlsloc" id="cmbrlsloc" value='<s:property value="cmbrlsloc"/>' style="width:150px;">
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden" name="hidcmbrlsloc" id="hidcmbrlsloc" value='<s:property value="hidcmbrlsloc"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Rental Status</label>
                                <select name="cmbrentalstatus" id="cmbrentalstatus" value='<s:property value="cmbrentalstatus"/>' style="width:150px;">
                                    <option value="R">Rental</option>
                                    <option value="L">Lease</option>
                                    <option value="LM">Limousine</option>
                                    <option value="A">All</option>
                                </select>
                                <input type="hidden" name="hidcmbrentalstatus" id="hidcmbrentalstatus" value='<s:property value="hidcmbrentalstatus"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Date</label>
                                <div style="width: 125px;">
                                    <div id="releasedate" name="releasedate" value='<s:property value="releasedate"/>'></div>
                                </div>
                                <input type="hidden" name="hidreleasedate" id="hidreleasedate" value='<s:property value="hidreleasedate"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Time</label>
                                <div style="width: 125px;">
                                    <div id="releasetime" name="releasetime" value='<s:property value="releasetime"/>'></div>
                                </div>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">KM</label>
                                <input type="text" name="releasekm" id="releasekm" value='<s:property value="releasekm"/>' tabindex="-1" readonly style="width:150px;" />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Fuel</label>
                                <input type="text" name="releasefuel" id="releasefuel" value='<s:property value="releasefuel"/>' tabindex="-1" readonly style="width:150px;" />
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Op. Status</label>
                                <input type="text" name="opstatus" id="opstatus" value='IN' tabindex="-1" disabled="true" style="width:150px;" />
                            </div>
                            <div class="field-row" style="margin-bottom:0;">
                                <label class="lbl-right" style="width:120px;">Ast status</label>
                                <input type="text" name="aststatus" id="aststatus" value='<s:property value="aststatus"/>' tabindex="-1" style="width:150px;" />
                            </div>
                            
                            <div id="fleetwarning" style="color:red; font-weight:bold; text-align:center; margin-top:10px;">All fields are Mandatory</div>
                        </div>

                    </div>
                </div>

                <div id="tab2">
                    <div class="middle-panel">
                        <span class="middle-panel-title">Vehicle Info</span>
                        
                        <div class="field-row">
                            <label class="lbl-right" style="width:100px;">Engine No</label>
                            <input type="text" id="engine_no" name="engine_no" value='<s:property value="engine_no"/>' style="width:150px; text-transform:uppercase;" />
                            
                            <label class="lbl-right" style="width:80px;">Chasis No</label>
                            <input type="text" id="chasis_no" name="chasis_no" value='<s:property value="chasis_no"/>' style="width:150px; text-transform:uppercase;" />
                            
                            <label class="lbl-right" style="width:80px;">VIN</label>
                            <input type="text" name="vin" id="vin" value='<s:property value="vin"/>' style="width:150px;" />
                        </div>

                        <div class="field-row" style="margin-bottom:0;">
                            <label class="lbl-right" style="width:100px;">Fuel Type</label>
                            <select name="cmbfueltype" id="cmbfueltype" style="width:150px;">
                                <option value="">--Select--</option>
                                <option value="P">Petrol</option>
                                <option value="D">Diesel</option>
                            </select>
                            
                            <label class="lbl-right" style="width:80px;">Fuel Tank Cap.</label>
                            <input type="text" name="fuelcapacity" id="fuelcapacity" value='<s:property value="fuelcapacity"/>' style="width:150px;" />
                            
                            <label class="lbl-right" style="width:80px;">Color</label>
                            <select name="cmbveh_color" id="cmbveh_color" value='<s:property value="cmbveh_color"/>' style="width:150px;">
                                <option>--Select--</option>
                            </select>
                            <input type="hidden" name="hidcmbveh_color" id="hidcmbveh_color" value='<s:property value="hidcmbveh_color"/>'>
                        </div>
                    </div>

                    <div class="middle-panel">
                        <span class="middle-panel-title">Warranty Info</span>
                        
                        <div class="field-row" style="margin-bottom:0;">
                            <label class="lbl-right" style="width:100px;">Warranty Period</label>
                            <input type="text" id="warranty_period" name="warranty_period" value='<s:property value="warranty_period"/>' onblur="getWarrantyDate(this.value);" style="width:100px;" />
                            
                            <label class="lbl-right" style="width:80px;">From Date</label>
                            <div style="width: 125px;">
                                <div id="jqxWrntyFrmDate" name="jqxWrntyFrmDate" value='<s:property value="jqxWrntyFrmDate"/>'></div>
                            </div>
                            <input type="hidden" id="hidjqxWrntyFrmDate" name="hidjqxWrntyFrmDate" value='<s:property value="hidjqxWrntyFrmDate"/>' />
                            
                            <label class="lbl-right" style="width:80px;">To Date</label>
                            <div style="width: 125px;">
                                <div id="jqxWrntyToDate" name="jqxWrntyToDate" value='<s:property value="jqxWrntyToDate"/>'></div> 
                            </div>
                            <input type="hidden" id="hidjqxWrntyToDate" name="hidjqxWrntyToDate" value='<s:property value="hidjqxWrntyToDate"/>' />
                            
                            <label class="lbl-right" style="width:80px; margin-left:auto;">Warranty KM</label>
                            <input type="text" name="warranty_km" id="warranty_km" value='<s:property value="warranty_km"/>' style="width:120px; text-align:right;" />
                        </div>
                    </div>

                    <div class="middle-panel">
                        <span class="middle-panel-title">Service Info</span>
                        
                        <div class="field-row" style="margin-bottom:0;">
                            <label class="lbl-right" style="width:120px;">Service Duration (KM)</label>
                            <input type="text" id="service_km" name="service_km" value='<s:property value="service_km"/>' style="width:120px; text-align:right;" />
                            
                            <label class="lbl-right" style="width:100px;">Last Srvc. Date</label>
                            <div style="width: 125px;">
                                <div id="jqxLstSrvcDate" name="jqxLstSrvcDate" value='<s:property value="jqxLstSrvcDate"/>'></div> 
                            </div>
                            <input type="hidden" id="hidjqxLstSrvcDate" name="hidjqxLstSrvcDate" value='<s:property value="hidjqxLstSrvcDate"/>' />
                            
                            <label class="lbl-right" style="width:100px;" id="lbllastsrvkm">Last Service KM</label>
                            <input type="text" id="last_srvc_km" name="last_srvc_km" value='<s:property value="last_srvc_km"/>' style="width:120px; text-align:right;" />
                        </div>
                    </div>

                    <div class="middle-panel">
                        <span class="middle-panel-title">Release Info</span>
                        
                        <div class="field-row" style="margin-bottom:0;">
                            <label class="lbl-right" style="width:100px;">Current KM</label>
                            <input type="text" id="current_km" name="current_km" value='<s:property value="current_km"/>' style="width:120px; text-align:right;" />
                            
                            <label class="lbl-right" style="width:60px;">Fuel</label>
                            <select name="cmbfuel" id="cmbfuel" value='<s:property value="cmbfuel"/>' style="width:120px;">
                                <option value=0.000>Level 0/8</option>
                                <option value=0.125 selected>Level 1/8</option>
                                <option value=0.250>Level 2/8</option>
                                <option value=0.375>Level 3/8</option>
                                <option value=0.500>Level 4/8</option>
                                <option value=0.625>Level 5/8</option>
                                <option value=0.750>Level 6/8</option>
                                <option value=0.875>Level 7/8</option>
                                <option value=1.000>Level 8/8</option>
                            </select>
                            <input type="hidden" id="hidcmbfuel" name="hidcmbfuel" value='<s:property value="hidcmbfuel"/>' />
                            <input type="hidden" name="hidcmbfueltype" id="hidcmbfueltype" value='<s:property value="hidcmbfueltype"/>' />
                            
                            <label class="lbl-right" style="width:80px;">Avail. Br.</label>
                            <select name="cmbavail_br1" id="cmbavail_br1" value='<s:property value="cmbavail_br1"/>' style="width:150px;"></select>
                            <input type="hidden" id="hidcmbavail_br1" name="hidcmbavail_br1" value='<s:property value="hidcmbavail_br1"/>' />
                            <input type="hidden" id="tcno2" name="tcno2" value='<s:property value="tcno2"/>'/>
                            
                            <label class="lbl-right" style="width:100px;">Calibration Km</label>
                            <input type="text" name="calibrationkm" id="calibrationkm" value='<s:property value="calibrationkm"/>' style="width:120px; text-align:right;" onblur="getspectab();" />
                            
                            <select name="branded" id="branded" value='<s:property value="branded"/>' hidden="true">
                                <option value="Y" selected>Y</option>
                                <option value="N">N</option>
                            </select>
                            <input type="hidden" id="hidbranded" name="hidbranded" value='<s:property value="hidbranded"/>' />
                            <input type="hidden" name="hidreleasetime" id="hidreleasetime" value='<s:property value="hidreleasetime"/>'>
                        </div>
                    </div>
                </div>

                <div id="tab3">
                    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
                    <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
                    
                    <div class="middle-panel">
                        <div id="specdiv" class="grid-container">
                            <jsp:include page="specificationGrid.jsp"></jsp:include>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div id="dealerWindow"><div></div><div></div></div>
        <div id="financierWindow"><div></div><div></div></div>
        <div id="insuranceWindow"><div></div><div></div></div>
        <div id="specwindow"><div></div></div>
        <div id="releaseWindow"><div></div><div style="background-color:#FFFFFF;"></div></div>

    </form>
</div>
</body>
</html>