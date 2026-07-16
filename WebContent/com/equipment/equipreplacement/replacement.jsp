<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

form label.error { color:red; font-weight:bold; }
</style> 

<script type="text/javascript">
$(document).ready(function () { 
	document.getElementById("btnEdit").disabled=true;
	$('#btnDelete').attr('disabled',true);
	document.getElementById("btnUpdate").style.display="none";
	document.getElementById("btnUpdateSave").style.display="none";

    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    var dateFields = ["date", "refdate", "dateout", "dateouthidden", "atbranchdatein", "atbranchoutdate", "coloutdate", "colcollectdate", "coldeldate", "colindate"];
    dateFields.forEach(function(el) {
        $("#" + el).jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true, theme: 'energyblue'});
    });
    // Set specific values to null initially
    $("#refdate, #dateout, #atbranchdatein, #atbranchoutdate, #coloutdate, #colcollectdate, #coldeldate, #colindate").jqxDateTimeInput('setDate', null);

    var timeFields = ["timeout", "timeouthidden", "atbranchtimein", "atbranchouttime", "colouttime", "colcollecttime", "coldeltime", "colintime"];
    timeFields.forEach(function(el) {
        $("#" + el).jqxDateTimeInput({ width: '80px', height: 24, formatString: 'HH:mm', showCalendarButton: false, theme: 'energyblue'});
    });
    // Set specific values to null/now initially
    $("#timeout, #atbranchtimein, #atbranchouttime, #colouttime, #colcollecttime, #coldeltime, #colintime").jqxDateTimeInput('setDate', null);
    $("#timeouthidden").jqxDateTimeInput('setDate', new Date());

    /* Force internal alignment AFTER render */
    setTimeout(function () {
        dateFields.concat(timeFields).forEach(function(el) {
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

    changeAtbranch();
    getBranch();
    getReason();
    getTestLocation();

    $('#agmtnowindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Contract Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#agmtnowindow').jqxWindow('close');
    $('#collectionwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	$('#collectionwindow').jqxWindow('close');
 	$('#vehiclewindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#vehiclewindow').jqxWindow('close');
		   
    $('#refvocno').dblclick(function(){
        if(document.getElementById("mode").value=="view"){ return false; }
        if(document.getElementById("cmbrentaltype").value==''){
            document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
            document.getElementById("cmbrentaltype").focus();
            return false;  
        }
        if(document.getElementById("cmbagmtbranch").value==''){
            document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
            return false;
        }
		
        document.getElementById("errormsg").innerText="";
        $('#agmtnowindow').jqxWindow('open');
        agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
    });
	
	$('#colcollectdriver').dblclick(function(){
	    $('#collectionwindow').jqxWindow('open');
	    $('#collectionwindow').jqxWindow('focus');
	    collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
	});
	
    $('#coldeldriver').dblclick(function(){
        $('#collectionwindow').jqxWindow('open');
        $('#collectionwindow').jqxWindow('focus');
        collectionSearchContent('driverSearchGrid.jsp?id=2',  $('#collectionwindow'));
    });

    $('#atbranchoutfleetno').dblclick(function(){
        if(document.getElementById("mode").value=="view"){ return false; }
        $('#vehiclewindow').jqxWindow('open');
        $('#vehiclewindow').jqxWindow('focus');
        vehicleSearchContent('masterFleetSearch.jsp?id=1', $('#vehiclewindow'));
    });
	 
    $('#coloutfleetno').dblclick(function(){
        if(document.getElementById("mode").value=="view"){ return false; }
        $('#vehiclewindow').jqxWindow('open');
        $('#vehiclewindow').jqxWindow('focus');
        vehicleSearchContent('masterFleetSearch.jsp?id=2', $('#vehiclewindow'));
    });
});

function getAgmtno(event){
    if(document.getElementById("mode").value=="view"){ return false; }
    if(document.getElementById("cmbrentaltype").value==''){
        document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
        document.getElementById("cmbrentaltype").focus();
        return false;  
    }
    document.getElementById("errormsg").innerText="";
    var x= event.keyCode;
    if(x==114){
        $('#agmtnowindow').jqxWindow('open');
        agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
    }
}

function getAtbranchOutFleet(event){
    if(document.getElementById("mode").value=="view"){ return false; }
    var x= event.keyCode;
    if(x==114){
        $('#vehiclewindow').jqxWindow('open');
        $('#vehiclewindow').jqxWindow('focus');
        vehicleSearchContent('masterFleetSearch.jsp?id=1', $('#vehiclewindow'));
    }
}

function getColOutFleet(event){
    if(document.getElementById("mode").value=="view"){ return false; }
    var x= event.keyCode;
    if(x==114){
        $('#vehiclewindow').jqxWindow('open');
        $('#vehiclewindow').jqxWindow('focus');
        vehicleSearchContent('masterFleetSearch.jsp?id=2', $('#vehiclewindow'));
    }
}

function getDriver(event,id){
    var x= event.keyCode;
    if(x==114){
        $('#collectionwindow').jqxWindow('open');
        $('#collectionwindow').jqxWindow('focus');
        collectionSearchContent('driverSearchGrid.jsp?id='+id,  $('#collectionwindow'));
    }
}

function agmtnoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#agmtnowindow').jqxWindow('setContent', data);
    }); 
}

function vehicleSearchContent(url) {
    $.get(url).done(function (data) {
        $('#vehiclewindow').jqxWindow('setContent', data);
    }); 
}

function collectionSearchContent(url) {
    $.get(url).done(function (data) {
        $('#collectionwindow').jqxWindow('setContent', data);
    }); 
}

function checkfuturedate(){
    var date1=new Date($('#dateout').jqxDateTimeInput('getDate')); 
    var futuredate=new Date();
    date1.setHours(0,0,0,0);
    futuredate.setHours(0,0,0,0);

    if(date1>futuredate){
        document.getElementById("errormsg").innerText="Future Date Cannot be applied";
        $('#dateout').jqxDateTimeInput('focus'); 
        return false;
    }
    document.getElementById("errormsg").innerText="";
    return true;
}

function getBranch() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var branchItems = items[0].split(",");
			var branchIdItems = items[1].split(",");
			var optionsbranch = '<option value="">--Select--</option>';
			for (var i = 0; i < branchItems.length; i++) {
				optionsbranch += '<option value="' + branchIdItems[i] + '">' + branchItems[i] + '</option>';
			}
			$("select#cmbinbranch").html(optionsbranch);
			$("select#cmbcolinbranch").html(optionsbranch);
			$("select#cmbagmtbranch").html(optionsbranch);
			if ($('#hidcmbinbranch').val() != null) {
				$('#cmbinbranch').val($('#hidcmbinbranch').val());
			}
			if ($('#hidcmbcolinbranch').val() != null) {
				$('#cmbcolinbranch').val($('#hidcmbcolinbranch').val());
			}
			if ($('#hidcmbagmtbranch').val() != null) {
				$('#cmbagmtbranch').val($('#hidcmbagmtbranch').val());
			}
		}
	}
	x.open("GET", "getBranch.jsp", true);
	x.send();
}

function getLoc(value) {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var locationItems = items[0].split(",");
			var locationIdItems = items[1].split(",");
			var optionslocation = '<option value="">--Select--</option>';
			for (var i = 0; i < locationItems.length; i++) {
				optionslocation += '<option value="' + locationIdItems[i] + '">' + locationItems[i] + '</option>';
			}
			$("select#cmbinlocation").html(optionslocation);
			$("select#cmbcolinlocation").html(optionslocation);
			if ($('#hidcmbinlocation').val() != null) {
				$('#cmbinlocation').val($('#hidcmbinlocation').val());
			}
			if ($('#hidcmbcolinlocation').val() != null) {
				$('#cmbcolinlocation').val($('#hidcmbcolinlocation').val());
			}
		}
	}
	x.open("GET", "getLoc.jsp?id="+value, true);
	x.send();
}
	
function getReason() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('***');
            var statusItems = items[0].split(",");
            var statusIdItems = items[1].split(",");
            var optionsstatus = '<option value="">--Select--</option>';
            for (var i = 0; i < statusItems.length; i++) {
                optionsstatus += '<option value="' + statusIdItems[i] + '">' + statusItems[i] + '</option>';
            }
            $("select#cmbtrreason").html(optionsstatus);
            if ($('#hidcmbtrreason').val() != null) {
                $('#cmbtrreason').val($('#hidcmbtrreason').val());
            }
        }
    }
    x.open("GET", "getReason.jsp", true);
    x.send();
}

function getTestLocation(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('***');
            var locItems = items[0].split(",");
            var locIdItems = items[1].split(",");
            var optionsloc = '<option value="">--Select--</option>';
            for (var i = 0; i < locItems.length; i++) {
                optionsloc += '<option value="' + locIdItems[i] + '">' + locItems[i] + '</option>';
            }
            $("select#cmbcolinlocation").html(optionsloc);
            $("select#cmbinlocation").html(optionsloc);
            if ($('#hidcmbinlocation').val() != null) {
                $('#cmbinlocation').val($('#hidcmbinlocation').val());
            }
            if ($('#hidcmbcolinlocation').val() != null) {
                $('#cmbcolinlocation').val($('#hidcmbcolinlocation').val());
            }
        }
    }
    x.open("GET", "getTestLocation.jsp", true);
    x.send();
}  

function funReadOnly(){
    $('#frmEquipReplacement input').attr('readonly', true );
    $('#frmEquipReplacement select').attr('disabled', true);
    var dateFields = ["date", "refdate", "dateout", "timeout", "atbranchdatein", "atbranchtimein", "atbranchoutdate", "atbranchouttime", "coloutdate", "colouttime", "colcollectdate", "colcollecttime", "coldeldate", "coldeltime", "colindate", "colintime"];
    dateFields.forEach(function(el) { $('#' + el).jqxDateTimeInput({ disabled: true}); });
}

function funRemoveReadOnly(){
    $('#frmEquipReplacement input').attr('readonly', false );
    $('#frmEquipReplacement select').attr('disabled', false);
    var dateFields = ["date", "refdate", "dateout", "timeout", "atbranchdatein", "atbranchtimein", "atbranchoutdate", "atbranchouttime", "coloutdate", "colouttime", "colcollectdate", "colcollecttime", "coldeldate", "coldeltime", "colindate", "colintime"];
    dateFields.forEach(function(el) { $('#' + el).jqxDateTimeInput({ disabled: false}); });
    
    if(document.getElementById("mode").value=="A"){
        $('#atbranchfield').prop('disabled',true);
        $('#collectionfield').prop('disabled',true);
        $('#date').jqxDateTimeInput('setDate',new Date());
        var nullDates = ["refdate", "dateout", "timeout", "atbranchdatein", "atbranchtimein", "atbranchoutdate", "atbranchouttime", "coloutdate", "colouttime", "colcollectdate", "colcollecttime", "coldeldate", "coldeltime", "colindate", "colintime"];
        nullDates.forEach(function(el) { $('#' + el).jqxDateTimeInput('setDate', null); });
    }
    var readOnlyFields = ["inuser", "atbranchoutfleetno", "atbranchoutfleetname", "atbranchoutbranch", "atbranchoutlocation", "atbranchoutuser", "coloutfleetno", "coloutfleetname", "coloutbranch", "coloutlocation", "coloutuser"];
    readOnlyFields.forEach(function(el) { $('#' + el).prop('readonly',true); });
}

function setValues(){
    funSetlabel();
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    
    //Time Setting
    var timeFields = ["timeout", "atbranchtimein", "atbranchouttime", "colouttime", "colcollecttime", "coldeltime", "colintime"];
    timeFields.forEach(function(el) {
        if($('#hid' + el).val()){ $("#" + el).jqxDateTimeInput('val', $('#hid' + el).val()); }
    });
    
    //Combo box setting
    var comboFields = ["cmbrentaltype", "cmbtrreason", "cmbreplacetype", "cmbfuel", "cmbinbranch", "cmbatbranchinfuel", "cmbatbranchoutfuel", "cmbcoloutfuel", "cmbcolcollectfuel", "cmbcoldelfuel", "cmbcolinfuel", "cmbcolinbranch"];
    comboFields.forEach(function(el) {
        if ($('#hid' + el).val() != null) { $('#' + el).val($('#hid' + el).val()); }
    });
	
    if(document.getElementById("cmbreplacetype").value=="atbranch"){
        document.getElementById("chkatbranch").checked=true;
        document.getElementById("chkcollection").checked=false;
    } else if(document.getElementById("cmbreplacetype").value=="collection"){
        document.getElementById("chkatbranch").checked=false;
        document.getElementById("chkcollection").checked=true;
    }
    
    if(document.getElementById("chkcollection").checked==true){
        document.getElementById("chkcollect").checked = (document.getElementById("hidchkcollect").value=="1");
        document.getElementById("chkdelivery").checked = (document.getElementById("hidchkdelivery").value=="1");
    }
	
    if(document.getElementById("docno").value!="" && document.getElementById("chkcollection").checked==true){
        document.getElementById("btnUpdate").style.display="block";
    }
    if(document.getElementById("colinkm").value!="" && parseFloat(document.getElementById("colinkm").value)>0){
        document.getElementById("btnUpdate").style.display="none";
    }
    
    if(document.getElementById("docno").value!=""){
        getCancelStatus(document.getElementById("docno").value);
    }
}

function getCancelStatus(value) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(items=="1"){
                document.getElementById("lblcancelstatus").innerText="CANCELLED";
            } else{
                document.getElementById("lblcancelstatus").innerText="";
            }
        }
    }
    x.open("GET", "../replacement/getCancelStatus.jsp?id="+value, true);
    x.send();
}

function funNotify(){
    var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
    if(docdateval==0){
        $('#date').jqxDateTimeInput('focus');
        return false;
    } else{
        document.getElementById("errormsg").innerText="";
    }
    
    var x=checkfuturedate();
    if(x==false){ return 0; }
    
    if(document.getElementById("refno").value==''){
        document.getElementById("errormsg").innerText="Ref No Should Not be Empty";
        document.getElementById("refno").focus();
        return 0;
    }
    if(document.getElementById("chkatbranch").checked==false && document.getElementById("chkcollection").checked==false){
        document.getElementById("errormsg").innerText="Please Select At Branch or Collection";
        document.getElementById("chkatbranch").focus();
        return 0;
    }
    if(document.getElementById("cmbtrreason").value==""){
        document.getElementById("errormsg").innerText="Please Select Replacement Reason";
        document.getElementById("cmbtrreason").focus();
        return 0;
    }

    $('#dateout').jqxDateTimeInput({ disabled: false});
    $('#timeout').jqxDateTimeInput({ disabled: false});
    var dateout=$('#dateout').jqxDateTimeInput('getDate');
    var timeout=$('#timeout').jqxDateTimeInput('getDate');
    var kmout=parseFloat(document.getElementById("outkm").value);
    $('#dateout').jqxDateTimeInput({ disabled: true});
    $('#timeout').jqxDateTimeInput({ disabled: true});
    dateout.setHours(0,0,0,0);
    
    if(document.getElementById("chkatbranch").checked==true){
        var atbranchindate=$('#atbranchdatein').jqxDateTimeInput('getDate');
        var atbranchintime=$('#atbranchtimein').jqxDateTimeInput('getDate');
        var atbranchoutdate=$('#atbranchoutdate').jqxDateTimeInput('getDate');
        var atbranchouttime=$('#atbranchouttime').jqxDateTimeInput('getDate');
        var atbranchoutkm=parseFloat(document.getElementById("atbranchoutkm").value);
        var atbranchinkm=parseFloat(document.getElementById("atbranchkmin").value);
        
        if(document.getElementById("cmbinbranch").value==""){
            document.getElementById("errormsg").innerText="In Branch is Mandatory";
            document.getElementById("cmbinbranch").focus();
            return 0;
        }
        if(document.getElementById("cmbinlocation").value==""){
            document.getElementById("errormsg").innerText="In Location is Mandatory";
            document.getElementById("cmbinlocation").focus();
            return 0;
        }
        if(atbranchindate==null){
            document.getElementById("errormsg").innerText="In Date is Mandatory";
            $('#atbranchdatein').jqxDateTimeInput('focus');
            return 0;
        }
        var atbranchindateval=funDateInPeriod($('#atbranchdatein').jqxDateTimeInput('getDate'));
        if(atbranchindateval==0){
            $('#atbranchdatein').jqxDateTimeInput('focus');
            return false;
        }
        if(atbranchintime==null){
            document.getElementById("errormsg").innerText="In Time is Mandatory";
            $('#atbranchtimein').jqxDateTimeInput('focus');
            return 0;
        }
        atbranchindate.setHours(0,0,0,0);
        if(atbranchindate<dateout){
            document.getElementById("errormsg").innerText="In Date Cannot be less than Agreement Date";
            $('#atbranchdatein').jqxDateTimeInput('focus');
            return 0;
        }
        if(atbranchindate-dateout==0){
            if(atbranchintime.getHours()<timeout.getHours()){
                document.getElementById("errormsg").innerText="In Time Cannot be less than Agreement Time";
                $('#atbranchtimein').jqxDateTimeInput('focus');
                return 0;
            } else if(atbranchintime.getHours()==timeout.getHours()){
                if(atbranchintime.getMinutes()<timeout.getMinutes()){
                    document.getElementById("errormsg").innerText="In Time Cannot be less than Agreement Time";
                    $('#atbranchtimein').jqxDateTimeInput('focus');
                    return 0;	 
                }
            }
        }
        
        if(atbranchoutdate==null){
            document.getElementById("errormsg").innerText="Out Date is Mandatory";
            $('#atbranchoutdate').jqxDateTimeInput('focus');
            return 0;
        }
        var atbranchoutdateval=funDateInPeriod($('#atbranchoutdate').jqxDateTimeInput('getDate'));
        if(atbranchoutdateval==0){
            $('#atbranchoutdate').jqxDateTimeInput('focus');
            return false;
        }
        if(atbranchouttime==null){
            document.getElementById("errormsg").innerText="Out Time is Mandatory";
            document.getElementById("atbranchouttime").focus();
            return 0;
        }
        atbranchoutdate.setHours(0,0,0,0);
        if(atbranchinkm<outkm){
            document.getElementById("errormsg").innerText="In Km cannot be less than Agreement km";
            document.getElementById("atbranchkmin").focus();
            return 0;
        }
        if(document.getElementById("cmbatbranchinfuel").value==""){
            document.getElementById("errormsg").innerText="Please Select In Fuel";
            document.getElementById("cmbatbranchinfuel").focus();
            return 0;
        }
        
        if(document.getElementById("atbranchoutfleetno").value==""){
            document.getElementById("errormsg").innerText="Out Fleet is Mandatory";
            document.getElementById("cmbatbranchinfuel").focus();
            return 0;
        }
        
        if(atbranchoutdate<atbranchindate){
            document.getElementById("errormsg").innerText="New Equipment Out Date Cannot be less than Equipment In Date";
            $('#atbranchoutdate').jqxDateTimeInput('focus');
            return 0;
        } 
        if(atbranchoutdate-atbranchindate==0){
            if(atbranchouttime.getHours()<atbranchintime.getHours()){
                document.getElementById("errormsg").innerText="New Equipment Out Time Cannot be less than Equipment In Time";
                $('#atbranchouttime').jqxDateTimeInput('focus');
                return 0;
            } else if(atbranchouttime.getHours()==atbranchintime.getHours()){
                if(atbranchouttime.getMinutes()<atbranchintime.getMinutes()){
                    document.getElementById("errormsg").innerText="New Equipment Out Time Cannot be less than Equipment In Time";
                    $('#atbranchouttime').jqxDateTimeInput('focus');
                    return 0;
                }
            }
        }
    } else if(document.getElementById("chkcollection").checked==true){
        if(document.getElementById("coloutfleetno").value==""){
            document.getElementById("errormsg").innerText="Out Fleet is Mandatory";
            document.getElementById("coloutfleetno").focus();
            return 0;
        }
        var coloutdate=$('#coloutdate').jqxDateTimeInput('getDate');
        var colouttime=$('#colouttime').jqxDateTimeInput('getDate');
        var coloutkm=parseFloat(document.getElementById("coloutkm").value);
        if(coloutdate==null){
            document.getElementById("errormsg").innerText="Equipment Out Date is Mandatory";
            $('#coloutdate').jqxDateTimeInput('focus');
            return 0;
        }
        
        var coloutdateval=funDateInPeriod($('#coloutdate').jqxDateTimeInput('getDate'));
        if(coloutdateval==0){
            $('#coloutdate').jqxDateTimeInput('focus');
            return false;
        }
        coloutdate.setHours(0,0,0,0);
        if(colouttime==null){
            document.getElementById("errormsg").innerText="Equipment Out Time is Mandatory";
            $('#colouttime').jqxDateTimeInput('focus');
            return 0;
        }
        if(coloutdate<dateout){
            document.getElementById("errormsg").innerText="Equipment Out Date cannot be less than Agreement Date";
            $('#coloutdate').jqxDateTimeInput('focus');
            return 0;
        }
        if(coloutdate-dateout==0){
            if(colouttime.getHours()<timeout.getHours()){
                document.getElementById("errormsg").innerText="Equipment Out Time cannot be less than Agreement Time";
                $('#colouttime').jqxDateTimeInput('focus');
                return 0;
            } else if(colouttime.getHours()==timeout.getHours()){
                if(colouttime.getMinutes()<timeout.getMinutes()){
                    document.getElementById("errormsg").innerText="Equipment Out Time cannot be less than Agreement Time";
                    $('#colouttime').jqxDateTimeInput('focus');
                    return 0;
                }
            }
        }
    }
	
    if(document.getElementById("chkatbranch").checked==true){
        $('#cmbreplacetype').val('atbranch');
    } else if(document.getElementById("chkcollection").checked==true){
        $('#cmbreplacetype').val('collection');
    }

    $('#dateout').jqxDateTimeInput({ disabled: false});
    $('#timeout').jqxDateTimeInput({ disabled: false});
    $('#cmbfuel').prop('disabled',false);
    if(document.getElementById("chkatbranch").checked==true){
        $('#atbranchoutkm').prop('disabled',false);
        $('#cmbatbranchoutfuel').prop('disabled',false);	
    }
    if(document.getElementById("chkcollection").checked==true){
        document.getElementById("coloutkm").disabled=false;
        $('#cmbcoloutfuel').prop('disabled',false);	
    }
    return 1;
}

function funFocus(){
	$('#date').jqxDateTimeInput('focus'); 
}

function funChkButton(){}

function changeAtbranch(){
	if(document.getElementById("chkatbranch").checked==true){
		$('#collectionfield').prop('disabled',true);
		if($('#atbranchfield').prop('disabled')==true){
			$('#atbranchfield').prop('disabled',false);
		}
		if(document.getElementById("chkcollection").checked==true){
			document.getElementById("chkcollection").checked=false;
		}
	}
	if(document.getElementById("chkatbranch").checked==false){
		$('#collectionfield').prop('disabled',false);
	}
}

function changeCollection(){
	if(document.getElementById("chkcollection").checked==true){
		$('#atbranchfield').prop('disabled',true);
		if($('#collectionfield').prop('disabled')==true){
			$('#collectionfield').prop('disabled',false);
		}
		if(document.getElementById("chkatbranch").checked==true){
			document.getElementById("chkatbranch").checked=false;
		}
		checkCollect();
		checkDelivery();
		if(document.getElementById("mode").value=="A"){
			document.getElementById("chkcollect").disabled=true;
			document.getElementById("chkdelivery").disabled=true;
			document.getElementById("cmbcolinbranch").disabled=true;
			document.getElementById("cmbcolinlocation").disabled=true;
			document.getElementById("colinkm").disabled=true;
			document.getElementById("cmbcolinfuel").disabled=true;
			$('#colindate').jqxDateTimeInput({ disabled: true});
			$('#colintime').jqxDateTimeInput({ disabled: true});
		}
	}
	if(document.getElementById("chkcollection").checked==false){
		$('#atbranchfield').prop('disabled',false);
	}
}

function funSearchLoad(){
    changeContent('mainSearch.jsp'); 
}
	
function funUpdate(){
    document.getElementById("btnUpdate").style.display="none";
    document.getElementById("btnUpdateSave").style.display="block";
    funReadOnly();
    $('#colcollectdriver').prop('disabled',true);
    $('#colcollectkm').prop('disabled',true);
    $('#cmbcolcollectfuel').prop('disabled',true);
    $('#colcollectdate').jqxDateTimeInput({ disabled: true});
    $('#colcollecttime').jqxDateTimeInput({ disabled: true});
    
    $('#deliveryfield').prop('disabled',true);
    $('#colindate').jqxDateTimeInput({ disabled: false});
    $('#colintime').jqxDateTimeInput({ disabled: false});
    document.getElementById("chkcollect").checked=true;
    document.getElementById("chkdelivery").checked=true;
    checkCollect();
    checkDelivery();
    $('#cmbcolinbranch').prop('disabled',false);
    $('#cmbcolinlocation').prop('disabled',false);
    $('#colinkm').prop('disabled',false);
    $('#cmbcolinfuel').prop('disabled',false);
    $('#colinkm').prop('readonly',false);
    $('#cmbreplacetype').prop('disabled',false);
}

function funUpdateSave(){
    if(document.getElementById("chkcollect").checked==true){
        document.getElementById("hidchkcollect").value="1";
    } else{
        document.getElementById("hidchkcollect").value="0";
    }
    if(document.getElementById("chkdelivery").checked==true){
        document.getElementById("hidchkdelivery").value="1";
    } else{
        document.getElementById("hidchkdelivery").value="0";
    }
    var outdate=$('#dateout').jqxDateTimeInput('getDate');
    var outtime=$('#timeout').jqxDateTimeInput('getDate');
    outdate.setHours(0,0,0,0);
    var outkm=parseFloat(document.getElementById("outkm").value);
    var colindate=$('#colindate').jqxDateTimeInput('getDate');
    var colintime=$('#colintime').jqxDateTimeInput('getDate');
    var colinkm=parseFloat(document.getElementById("colinkm").value);
    
    if(colindate==null){
        document.getElementById("errormsg").innerText="In Date is Mandatory";
        $('#colindate').jqxDateTimeInput('focus');
        return false;
    }
    
    var colindateval=funDateInPeriod($('#colindate').jqxDateTimeInput('getDate'));
    if(colindateval==0){
        $('#colindate').jqxDateTimeInput('focus');
        return false;
    }
    
    if(colintime==null){
        document.getElementById("errormsg").innerText="In Date is Mandatory";
        $('#colintime').jqxDateTimeInput('focus');
        return false;
    }
    
    if(colindate<outdate){
        document.getElementById("errormsg").innerText="In Date cannot be less than Agreement Date";
        $('#colindate').jqxDateTimeInput('focus');
        return false;
    }
    if(colindate-outdate==0){
        if(colintime.getHours()<outtime.getHours()){
            document.getElementById("errormsg").innerText="In Time cannot be less than Agreement Time";
            $('#colintime').jqxDateTimeInput('focus');
            return false;
        } else if(colintime.getHours()==outtime.getHours()){
            if(colintime.getMinutes()<outtime.getMinutes()){
                document.getElementById("errormsg").innerText="In Time cannot be less than Agreement Time";
                $('#colintime').jqxDateTimeInput('focus');
                return false;
            }
        }
    }
    if(colinkm==""){
        document.getElementById("errormsg").innerText="In Km cannot be Empty";
        document.getElementById("colinkm").focus();
        return false;
    }
    if(colinkm<outkm){
        document.getElementById("errormsg").innerText="In Km cannot be less than Agreement Km";
        document.getElementById("colinkm").focus();
        return false;
    }
    if(document.getElementById("cmbcolinfuel").value==""){
        document.getElementById("errormsg").innerText="Please Select In Fuel";
        document.getElementById("cmbcolinfuel").focus();
        return false;
    }
    
    if(document.getElementById("chkcollect").checked==true){
        if(document.getElementById("colcollectdriver").value==""){
            document.getElementById("errormsg").innerText="Collection Driver is Mandatory";
            document.getElementById("colcollectdriver").focus();
            return false;
        }
        var colcollectdate=$('#colcollectdate').jqxDateTimeInput('getDate');
        var colcollecttime=$('#colcollecttime').jqxDateTimeInput('getDate');
        var colcollectkm=parseFloat(document.getElementById("colcollectkm").value);
        if(colcollectdate==null){
            document.getElementById("errormsg").innerText="Collection Date is Mandatory";
            $('colcollectdate').jqxDateTimeInput('focus');
            return false;
        }
        
        var colcollectdateval=funDateInPeriod($('#colcollectdate').jqxDateTimeInput('getDate'));
        if(colcollectdateval==0){
            $('#colcollectdate').jqxDateTimeInput('focus');
            return false;
        }
        
        if(colcollecttime==null){
            document.getElementById("errormsg").innerText="Collection Time is Mandatory";
            $('colcollecttime').jqxDateTimeInput('focus');
            return false;
        }
        colcollectdate.setHours(0,0,0,0);
        if(colindate<colcollectdate){
            document.getElementById("errormsg").innerText="In Date  cannot be less than Collection Date";
            $('colindate').jqxDateTimeInput('focus');
            return false;
        }
        if(colindate-colcollectdate==0){
            if(colintime.getHours()<colcollecttime.getHours()){
                document.getElementById("errormsg").innerText="In Time  cannot be less than Collection Time";
                $('colintime').jqxDateTimeInput('focus');
                return false;
            }
            if(colintime.getHours()==colcollecttime.getHours()){
                if(colintime.getMinutes()<colcollecttime.getMinutes()){
                    document.getElementById("errormsg").innerText="In Time  cannot be less than Collection Time";
                    $('colintime').jqxDateTimeInput('focus');
                    return false;
                }
                if(colintime.getMinutes()==colcollecttime.getMinutes()){
                    document.getElementById("errormsg").innerText="In Time  cannot be same as Collection Time";
                    $('#colintime').jqxDateTimeInput('focus');
                    return false;	
                }
            }
        }
        if(colinkm<colcollectkm){
            document.getElementById("errormsg").innerText="In Km cannot be less than Collection Km";
            document.getElementById("colinkm").focus();
            return false;
        }
        if(document.getElementById("cmbcolinfuel").value==""){
            document.getElementById("errormsg").innerText="Please Select Collection Fuel";
            document.getElementById("cmbcolcollectfuel").focus();
            return false;
        }
    }
    if(document.getElementById("chkdelivery").checked==true){
        var coldeldate=$('#coldeldate').jqxDateTimeInput('getDate');
        var coldeltime=$('#coldeltime').jqxDateTimeInput('getDate');
        var coloutdate=$('#coloutdate').jqxDateTimeInput('getDate');
        var colouttime=$('#colouttime').jqxDateTimeInput('getDate');
        var coldelkm=parseFloat(document.getElementById("coldelkm").value);
        var coloutkm=parseFloat(document.getElementById("coloutkm").value);
        coloutdate.setHours(0,0,0,0);
        if(document.getElementById("coldeldriver").value==""){
            document.getElementById("errormsg").innerText="Delivery Driver is Mandatory";
            document.getElementById("coldeldriver").focus();
            return false;
        }
        if(coldeldate==null){
            document.getElementById("errormsg").innerText="Delivery Date is Mandatory";
            $('#coldeldate').jqxDateTimeInput('focus');
            return false;
        }
        
        var coldeldateval=funDateInPeriod($('#coldeldate').jqxDateTimeInput('getDate'));
        if(coldeldateval==0){
            $('#coldeldate').jqxDateTimeInput('focus');
            return false;
        }
        if(coldeltime==null){
            document.getElementById("errormsg").innerText="Delivery Time is Mandatory";
            $('#coldeltime').jqxDateTimeInput('focus');
            return false;
        }
        coldeldate.setHours(0,0,0,0);
        if(coldeldate<coloutdate){
            document.getElementById("errormsg").innerText="Delivery Date cannot be less than Equipment Out Date";
            $('#coldeldate').jqxDateTimeInput('focus');
            return false;
        }
        if(coldeldate-coloutdate==0){
            if(coldeltime.getHours()<colouttime.getHours()){
                document.getElementById("errormsg").innerText="Delivery Time cannot be less than Equipment Out Time";
                $('#coldeltime').jqxDateTimeInput('focus');
                return false;	
            } else if(coldeltime.getHours()==colouttime.getHours()){
                if(coldeltime.getMinutes()<colouttime.getMinutes()){
                    document.getElementById("errormsg").innerText="Delivery Time cannot be less than Equipment Out Time";
                    $('#coldeltime').jqxDateTimeInput('focus');
                    return false;	
                }
                if(coldeltime.getMinutes()==colouttime.getMinutes()){
                    document.getElementById("errormsg").innerText="Delivery Time cannot be same as Equipment Out Time";
                    $('#coldeltime').jqxDateTimeInput('focus');
                    return false;	
                }
            }
        }
        if(coldelkm==""){
            document.getElementById("errormsg").innerText="Delivery Km is Mandatory";
            document.getElementById("coldelkm").focus();
            return false;	
        }
        if(coldelkm<coloutkm){
            document.getElementById("errormsg").innerText="Delivery Km cannot be less than Equipment Out Km";
            document.getElementById("coldelkm").focus();
            return false;	
        }
        if(document.getElementById("cmbcoldelfuel").value==""){
            document.getElementById("errormsg").innerText="Please Select Delivery Fuel";
            document.getElementById("cmbcoldelfuel").focus();
            return false;
        }
    }

    $('#coloutdate').jqxDateTimeInput({ disabled: false});
    $('#colouttime').jqxDateTimeInput({ disabled: false});
    $('#refdate').jqxDateTimeInput({ disabled: false});
    $('#cmbrentaltype').prop('disabled',false);
    $('#cmbtrreason').prop('disabled',false);
    document.getElementById("mode").value="E";
    $('#btnSave').mousedown(); 
    document.getElementById("btnUpdate").disabled=true;
}

function checkCollect(){
    if(document.getElementById("chkcollect").checked==true){
        $('#colcollectdriver').prop('disabled',false);
        $('#colcollectkm').prop('disabled',false);
        $('#cmbcolcollectfuel').prop('disabled',false);
        $('#colcollectdate').jqxDateTimeInput({ disabled: false});
        $('#colcollecttime').jqxDateTimeInput({ disabled: false});
        $('#colcollectkm').prop('readonly',false);
    } else{
        $('#colcollectdriver').prop('disabled',true);
        $('#colcollectkm').prop('disabled',true);
        $('#cmbcolcollectfuel').prop('disabled',true);
        $('#colcollectdate').jqxDateTimeInput({ disabled: true});
        $('#colcollecttime').jqxDateTimeInput({ disabled: true});
    }
}

function checkDelivery(){
    if(document.getElementById("chkdelivery").checked==true){
        $('#deliveryfield').prop('disabled',false);
        $('#cmbcoldelfuel').prop('disabled',false);
        $('#coldeldate').jqxDateTimeInput({ disabled: false});
        $('#coldeltime').jqxDateTimeInput({ disabled: false});
        $('#coldelkm').prop('readonly',false);
        $('#coldeliveryto').prop('readonly',false);
    } else{
        $('#deliveryfield').prop('disabled',true);
        $('#coldeldate').jqxDateTimeInput({ disabled: true});
        $('#coldeltime').jqxDateTimeInput({ disabled: true});
    }
}

function funResetValues(){
    $('#refdate, #dateout, #timeout, #atbranchdatein, #atbranchtimein, #atbranchoutdate, #atbranchouttime, #coloutdate, #colouttime, #colcollectdate, #colcollecttime, #coldeldate, #coldeltime, #colindate, #colintime').jqxDateTimeInput('setDate', null);
    $('#refno').val('');
    $('#hidtimeout, #hiddateout, #hidatbranchdatein, #hidatbranchtimein, #hidatbranchoutdate, #atbranchouttime, #hidcoloutdate, #hidcolouttime, #hidcolcollectdate, #hidcolcollecttime, #hidcoldeldate, #hidcoldeltime, #hidcolindate, #hidcolintime').val('');

    $('#refname, #txtfleetno, #txtfleetname, #outkm, #txtbranch, #txtlocation, #user, #atbranchoutuser, #cmbinbranch, #hidcmbinbranch, #cmbinlocation, #hidcmbinlocation, #atbranchinkm, #cmbatbranchinfuel, #hidcmbatbranchinfuel, #atbranchoutfleetno, #atbranchoutfleetname, #atbranchoutbranch, #hidatbranchoutbranch, #atbranchoutlocation, #hidatbranchoutlocation, #atbranchoutkm, #cmbatbranchoutfuel, #hidcmbatbranchoutfuel, #coloutfleetno, #coloutfleetname, #coloutbranch, #coloutlocation, #coloutuser, #coloutkm, #cmbcoloutfuel, #hidcmbcoloutfuel, #colcollectdriver, #colcollectkm, #cmbcolcollectfuel, #hidcmbcolcollectfuel, #coldeldriver, #coldelkm, #cmbcoldelfuel, #hidcmbcoldelfuel, #cmbcolinbranch, #hidcmbcolinbranch, #cmbcolinlocation, #hidcmbcolinlocation, #colinkm, #cmbcolinfuel, #hidcmbcolinfuel, #coldeliveryto').val('');
}

function funPrintBtn(){
    var url=document.URL;
    var reurl=url.split("saveEquipReplacement");
    var win= window.open(reurl[0]+"printEquipReplacement?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus(); 
} 

$(function(){
    $('#frmEquipReplacement').validate({
        rules: {
            cmbtrreason:"required", cmbreplacetype:"required", refno:"required", txtoutfleetno:"required", cmbrentaltype:"required", description:{ maxlength:250 }
        },
        messages: {
            cmbtrreason:" *", cmbreplacetype:" *", refno:" *", txtoutfleetno:" *", cmbrentaltype:" *", description:{ maxlength:"max 250 chars" }
        }
    });
});
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEquipReplacement" action="saveEquipReplacement" autocomplete="off">
    <jsp:include page="../../../header.jsp" />
    
<div class='modern-ui hidden-scrollbar'>
    
    <!-- TOP SECTION: Equipment Info As In Agreement -->
    <div class="middle-panel">
        <span class="middle-panel-title">Equipment Info As In Agreement</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            <input type="hidden" id="hidddate" name="hidddate" value='<s:property value="hidddate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Type</label>
            <select id="cmbrentaltype" name="cmbrentaltype" style="width:125px;" value='<s:property value="cmbrentaltype"/>'>
                <option value="">--Select--</option>
                <option value="ERC">Rental Contract</option>
            </select>
            <input type="hidden" id="hidcmbrentaltype" name="hidcmbrentaltype" value='<s:property value="hidcmbrentaltype"/>'/>
            
            <label class="lbl-right" style="width:80px;">Branch</label>
            <select name="cmbagmtbranch" id="cmbagmtbranch" style="width:125px;" value='<s:property value="cmbagmtbranch" />'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbagmtbranch" id="hidcmbagmtbranch" value='<s:property value="hidcmbagmtbranch" />' >
            
            <label class="lbl-right" style="width:80px;">Ref No</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="refvocno" name="refvocno" value='<s:property value="refvocno"/>' placeholder="Press F3" readonly onKeyDown="getAgmtno(event);"/>
                <svg class="magnifier-icon" onclick="$('#refvocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
        </div>
        
        <div class="field-row">
            <input type="text" id="refname" name="refname" style="width:100%;" value='<s:property value="refname"/>' readonly/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Ref Date</label>
            <div style="width: 125px;">
                <div id='refdate' name='refdate' value='<s:property value="refdate"/>'></div>
            </div>
            <input type="hidden" id="hidrefdate" name="hidrefdate" value='<s:property value="hidrefdate"/>'/>
            <input type="hidden" id="hidreftime" name="hidreftime" value='<s:property value="hidreftime"/>'/>
            
            <label class="lbl-right" style="width:80px;">Doc No</label>
            <input type="text" id="docno" name="docno" style="width:125px;" tabindex="-1" readonly value='<s:property value="docno"/>'/>
            
            <label class="lbl-right" style="width:80px;">Equip No</label>
            <input type="text" id="txtfleetno" name="txtfleetno" style="width:80px;" value='<s:property value="txtfleetno"/>' readonly />
            <input type="text" id="txtfleetname" name="txtfleetname" style="flex:1;" value='<s:property value="txtfleetname"/>' readonly/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date Out</label>
            <div style="width: 125px;">
                <div id="dateout" name="dateout" value='<s:property value="dateout"/>'></div>
            </div>
            <input type="hidden" name="hiddateout" id="hiddateout" value='<s:property value="hiddateout"/>'/>
            
            <label class="lbl-right" style="width:80px;">Time Out</label>
            <div style="width: 80px;">
                <div id="timeout" name="timeout" value='<s:property value="timeout"/>'></div>
            </div>
            <input type="hidden" id="hidtimeout" name="hidtimeout" value='<s:property value="hidtimeout"/>'/>
            
            <label class="lbl-right" style="width:80px;">Km Out</label>
            <input type="text" id="outkm" name="outkm" style="width:100px; text-align:right;" value='<s:property value="outkm"/>' readonly onkeypress="javascript:return isNumber (event,id)"/>
            
            <label class="lbl-right" style="width:80px;">Fuel</label>
            <select id="cmbfuel" name="cmbfuel" style="width:125px;" value='<s:property value="cmbfuel"/>'>
                <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
            </select>
            <input type="hidden" id="hidcmbfuel" name="hidcmbfuel" value='<s:property value="hidcmbfuel"/>'/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Branch</label>
            <input type="text" name="txtbranch" id="txtbranch" style="width:125px;" readonly value='<s:property value="txtbranch"/>'/>
            <input type="hidden" id="hidtxtbranch" name="hidtxtbranch" value='<s:property value="hidtxtbranch"/>'/>
            
            <label class="lbl-right" style="width:80px;">Location</label>
            <input type="text" name="txtlocation" id="txtlocation" style="width:125px;" readonly value='<s:property value="txtlocation"/>'/>
            <input type="hidden" name="hidtxtlocation" id="hidtxtlocation" value='<s:property value="hidtxtlocation"/>'/>
            
            <label class="lbl-right" style="width:80px;">Tr. Reason</label>
            <select id="cmbtrreason" name="cmbtrreason" style="width:125px;" value='<s:property value="cmbtrreason"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbtrreason" name="hidcmbtrreason" value='<s:property value="hidcmbtrreason"/>'/>
            
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" name="description" id="description" style="flex:1;" value='<s:property value="description"/>' />   
            
            <label id="lblcancelstatus" name="lblcancelstatus" style="margin-left: 15px; font-size: 13px; font-family: Tahoma; color:#6000FC; font-weight:bold; font-style:italic;"></label>
            
            <input type="hidden" name="hiduser" id="hiduser" value='<s:property value="hiduser"/>'/>
            <input type="hidden" name="hidcmbreplacetype" id="hidcmbreplacetype" value='<s:property value="hidcmbreplacetype"/>' />
        </div>
    </div>


    <!-- MIDDLE SECTION: At Branch OR Collection -->
    <div style="display: flex; gap: 15px;">
        
        <!-- LEFT: At Branch -->
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">
                <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                    <input type="checkbox" name="chkatbranch" id="chkatbranch" onchange="changeAtbranch();">
                    At Branch
                </label>
            </span>
            
            <fieldset id="atbranchfield" style="border:none; padding:0; margin:0;">
                <div class="middle-panel" style="background-color:#f8fcf5; margin-bottom: 15px;">
                    <span class="middle-panel-title" style="background-color:#f8fcf5;">In Info</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">Branch</label>
                        <select name="cmbinbranch" id="cmbinbranch" style="flex:1;" value='<s:property value="cmbinbranch"/>' onchange="getLoc(this.value);">
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" name="hidcmbinbranch" id="hidcmbinbranch" value='<s:property value="hidcmbinbranch"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Location</label>
                        <select name="cmbinlocation" id="cmbinlocation" style="flex:1;" value='<s:property value="cmbinlocation"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" name="hidcmbinlocation" id="hidcmbinlocation" value='<s:property value="hidcmbinlocation"/>'>
                        
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" name="inuser" id="inuser" style="flex:1; text-transform:uppercase;" value='<s:property value="inuser"/>'>
                        <input type="hidden" name="hidinuser" id="hidinuser" value='<s:property value="hidinuser"/>'>
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:60px;">Date</label>
                        <div style="width: 125px;">
                            <div id="atbranchdatein" name="atbranchdatein" value='<s:property value="atbranchdatein"/>'></div>
                        </div>
                        <input type="hidden" name="hidatbranchdatein" id="atbranchdatein_hid" value='<s:property value="hidatbranchdatein"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Time</label>
                        <div style="width: 80px;">
                            <div id="atbranchtimein" name="atbranchtimein" value='<s:property value="atbranchtimein"/>'></div>
                        </div>
                        <input type="hidden" name="hidatbranchtimein" id="hidatbranchtimein" value='<s:property value="hidatbranchtimein"/>'>
                        
                        <label class="lbl-right" style="width:60px;">KM</label>
                        <input type="text" name="atbranchkmin" id="atbranchkmin" style="flex:1; text-align:right;" value='<s:property value="atbranchkmin"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Fuel</label>
                        <select name="cmbatbranchinfuel" id="cmbatbranchinfuel" style="flex:1;" value='<s:property value="cmbatbranchinfuel"/>'>
                            <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                        </select>
                        <input type="hidden" name="hidcmbatbranchinfuel" id="hidcmbatbranchinfuel" value='<s:property value="hidcmbatbranchinfuel"/>'>
                    </div>
                </div>

                <div class="middle-panel" style="background-color:#fcfaf5; margin-bottom: 0;">
                    <span class="middle-panel-title" style="background-color:#fcfaf5;">Out Info</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">Fleet</label>
                        <div class="input-search-container" style="width: 125px;">
                            <input type="text" name="atbranchoutfleetno" id="atbranchoutfleetno" value='<s:property value="atbranchoutfleetno"/>' placeholder="Press F3" readonly onkeydown="getAtbranchOutFleet(event);">
                            <svg class="magnifier-icon" onclick="$('#atbranchoutfleetno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" name="atbranchoutfleetname" id="atbranchoutfleetname" style="flex:1;" value='<s:property value="atbranchoutfleetname"/>' readonly tabindex="-1">
                        <input type="hidden" name="hidatbranchoutbranch" id="hidatbranchoutbranch" value='<s:property value="hidatbranchoutbranch"/>'>
                        <input type="hidden" name="hidatbranchoutuser" id="hidatbranchoutuser" value='<s:property value="hidatbranchoutuser"/>'>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">Branch</label>
                        <input type="text" name="atbranchoutbranch" id="atbranchoutbranch" style="flex:1;" value='<s:property value="atbranchoutbranch"/>' readonly tabindex="-1">
                        
                        <label class="lbl-right" style="width:60px;">Location</label>
                        <input type="text" name="atbranchoutlocation" id="atbranchoutlocation" style="flex:1;" value='<s:property value="atbranchoutlocation"/>' readonly tabindex="-1">
                        <input type="hidden" name="hidatbranchoutlocation" id="hidatbranchoutlocation" value='<s:property value="hidatbranchoutlocation"/>'>
                        
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" name="atbranchoutuser" id="atbranchoutuser" style="flex:1; text-transform:uppercase;" value='<s:property value="atbranchoutuser"/>' readonly tabindex="-1">
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:60px;">Date</label>
                        <div style="width: 125px;">
                            <div id="atbranchoutdate" name="atbranchoutdate" value='<s:property value="atbranchoutdate"/>'></div>
                        </div>
                        <input type="hidden" name="hidatbranchoutdate" id="hidatbranchoutdate" value='<s:property value="hidatbranchoutdate"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Time</label>
                        <div style="width: 80px;">
                            <div id="atbranchouttime" name="atbranchouttime" value='<s:property value="atbranchouttime"/>'></div>
                        </div>
                        <input type="hidden" name="hidatbranchouttime" id="hidatbranchouttime" value='<s:property value="hidatbranchouttime"/>'>
                        
                        <label class="lbl-right" style="width:60px;">KM</label>
                        <input type="text" name="atbranchoutkm" id="atbranchoutkm" style="flex:1; text-align:right;" value='<s:property value="atbranchoutkm"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Fuel</label>
                        <select name="cmbatbranchoutfuel" id="cmbatbranchoutfuel" style="flex:1;" value='<s:property value="cmbatbranchoutfuel"/>'>
                            <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                        </select>
                        <input type="hidden" name="hidcmbatbranchoutfuel" id="hidcmbatbranchoutfuel" value='<s:property value="hidcmbatbranchoutfuel"/>'>
                    </div>
                </div>
            </fieldset>
        </div>

        <!-- RIGHT: Collection -->
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">
                <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                    <input type="checkbox" name="chkcollection" id="chkcollection" onchange="changeCollection();">
                    Collection
                </label>
            </span>
            
            <fieldset id="collectionfield" style="border:none; padding:0; margin:0;">
                <input type="hidden" name="hidchkcollection" id="hidchkcollection" >
                
                <div class="middle-panel" style="background-color:#fcfaf5; margin-bottom: 15px;">
                    <span class="middle-panel-title" style="background-color:#fcfaf5;">New Equip. going for Delivery</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">Fleet</label>
                        <div class="input-search-container" style="width: 125px;">
                            <input type="text" name="coloutfleetno" id="coloutfleetno" value='<s:property value="coloutfleetno"/>' placeholder="Press F3" readonly onkeydown="getColOutFleet(event);">
                            <svg class="magnifier-icon" onclick="$('#coloutfleetno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" name="coloutfleetname" id="coloutfleetname" style="flex:1;" value='<s:property value="coloutfleetname"/>' readonly tabindex="-1">
                        <input type="hidden" name="hidcoloutbranch" id="hidcoloutbranch" value='<s:property value="hidcoloutbranch"/>'>
                        <input type="hidden" name="hidcoloutlocation" id="hidcoloutlocation" value='<s:property value="hidcoloutlocation"/>'>
                        <input type="hidden" name="hidcoloutuser" id="hidcoloutuser" value='<s:property value="hidcoloutuser"/>'>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">Branch</label>
                        <input type="text" name="coloutbranch" id="coloutbranch" style="flex:1;" value='<s:property value="coloutbranch"/>' readonly tabindex="-1">
                        
                        <label class="lbl-right" style="width:60px;">Location</label>
                        <input type="text" name="coloutlocation" id="coloutlocation" style="flex:1;" value='<s:property value="coloutlocation"/>' readonly tabindex="-1">
                        
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" name="coloutuser" id="coloutuser" style="flex:1; text-transform:uppercase;" value='<s:property value="coloutuser"/>' readonly tabindex="-1">
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:60px;">Date</label>
                        <div style="width: 125px;">
                            <div id="coloutdate" name="coloutdate" value='<s:property value="coloutdate"/>'></div>
                        </div>
                        <input type="hidden" name="hidcoloutdate" id="hidcoloutdate" value='<s:property value="hidcoloutdate"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Time</label>
                        <div style="width: 80px;">
                            <div id="colouttime" name="colouttime" value='<s:property value="colouttime"/>'></div>
                        </div>
                        <input type="hidden" name="hidcolouttime" id="hidcolouttime" value='<s:property value="hidcolouttime"/>'>
                        
                        <label class="lbl-right" style="width:60px;">KM</label>
                        <input type="text" name="coloutkm" id="coloutkm" style="flex:1; text-align:right;" value='<s:property value="coloutkm"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Fuel</label>
                        <select name="cmbcoloutfuel" id="cmbcoloutfuel" style="flex:1;" value='<s:property value="cmbcoloutfuel"/>'>
                            <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                        </select>
                        <input type="hidden" name="hidcmbcoloutfuel" id="hidcmbcoloutfuel" value='<s:property value="hidcmbcoloutfuel"/>'>
                    </div>
                </div>

                <div class="middle-panel" id="collectfield" style="background-color:#fffafa; margin-bottom: 15px;">
                    <span class="middle-panel-title" style="background-color:#fffafa;">
                        <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                            <input type="checkbox" name="chkcollect" id="chkcollect" onchange="checkCollect();">
                            Equipment Received from Client
                        </label>
                    </span>
                    <input type="hidden" name="hidchkcollect" id="hidchkcollect" value='<s:property value="hidchkcollect"/>'>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">Driver</label>
                        <div class="input-search-container" style="flex:1;">
                            <input type="text" name="colcollectdriver" id="colcollectdriver" value='<s:property value="colcollectdriver"/>' placeholder="Press F3" readonly onkeydown="getDriver(event,1);">
                            <svg class="magnifier-icon" onclick="$('#colcollectdriver').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="hidden" name="hidcolcollectdriver" id="hidcolcollectdriver" value='<s:property value="hidcolcollectdriver"/>'>
                        
                        <div style="display:flex; gap:8px; margin-left:auto;">
                            <input type="button" name="btnUpdate" id="btnUpdate" value="Update" class="myButton" onclick="funUpdate();">
                            <input type="button" name="btnUpdateSave" id="btnUpdateSave" value="Save" class="myButton" onclick="funUpdateSave();">
                        </div>
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:60px;">Date</label>
                        <div style="width: 125px;">
                            <div id="colcollectdate" name="colcollectdate" value='<s:property value="colcollectdate"/>'></div>
                        </div>
                        <input type="hidden" name="hidcolcollectdate" id="hidcolcollectdate" value='<s:property value="hidcolcollectdate"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Time</label>
                        <div style="width: 80px;">
                            <div id="colcollecttime" name="colcollecttime" value='<s:property value="colcollecttime"/>'></div>
                        </div>
                        <input type="hidden" name="hidcolcollecttime" id="hidcolcollecttime" value='<s:property value="hidcolcollecttime"/>'>
                        
                        <label class="lbl-right" style="width:60px;">KM</label>
                        <input type="text" name="colcollectkm" id="colcollectkm" style="flex:1; text-align:right;" value='<s:property value="colcollectkm"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Fuel</label>
                        <select name="cmbcolcollectfuel" id="cmbcolcollectfuel" style="flex:1;" value='<s:property value="cmbcolcollectfuel"/>'>
                            <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                        </select>
                        <input type="hidden" name="hidcmbcolcollectfuel" id="hidcmbcolcollectfuel" value='<s:property value="hidcmbcolcollectfuel"/>'>
                    </div>
                </div>

                <div class="middle-panel" id="deliveryfield" style="background-color:#f5f5ff; margin-bottom: 15px;">
                    <span class="middle-panel-title" style="background-color:#f5f5ff;">
                        <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                            <input type="checkbox" name="chkdelivery" id="chkdelivery" onchange="checkDelivery();">
                            New Equ. handed over to Client
                        </label>
                    </span>
                    <input type="hidden" name="hidchkdelivery" id="hidchkdelivery" value='<s:property value="hidchkdelivery"/>'>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">Driver</label>
                        <div class="input-search-container" style="width: 125px;">
                            <input type="text" name="coldeldriver" id="coldeldriver" value='<s:property value="coldeldriver"/>' placeholder="Press F3" onkeydown="getDriver(event,2);">
                            <svg class="magnifier-icon" onclick="$('#coldeldriver').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="hidden" name="hidcoldeldriver" id="hidcoldeldriver" value='<s:property value="hidcoldeldriver"/>'>
                        
                        <label class="lbl-right" style="width:80px;">Deliver To</label>
                        <input type="text" name="coldeliveryto" id="coldeliveryto" style="flex:1;" value='<s:property value="coldeliveryto"/>'>
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:60px;">Date</label>
                        <div style="width: 125px;">
                            <div id="coldeldate" name="coldeldate" value='<s:property value="coldeldate"/>'></div>
                        </div>
                        <input type="hidden" name="hidcoldeldate" id="hidcoldeldate" value='<s:property value="hidcoldeldate"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Time</label>
                        <div style="width: 80px;">
                            <div id="coldeltime" name="coldeltime" value='<s:property value="coldeltime"/>'></div>
                        </div>
                        <input type="hidden" name="hidcoldeltime" id="hidcoldeltime" value='<s:property value="hidcoldeltime"/>'>
                        
                        <label class="lbl-right" style="width:60px;">KM</label>
                        <input type="text" name="coldelkm" id="coldelkm" style="flex:1; text-align:right;" value='<s:property value="coldelkm"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Fuel</label>
                        <select name="cmbcoldelfuel" id="cmbcoldelfuel" style="flex:1;" value='<s:property value="cmbcoldelfuel"/>'>
                            <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                        </select>
                        <input type="hidden" name="hidcmbcoldelfuel" id="hidcmbcoldelfuel" value='<s:property value="hidcmbcoldelfuel"/>'>
                    </div>
                </div>

                <div class="middle-panel" style="background-color:#f8fcf5; margin-bottom: 0;">
                    <span class="middle-panel-title" style="background-color:#f8fcf5;">Collected Equip. Closing At Branch</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">Branch</label>
                        <select name="cmbcolinbranch" id="cmbcolinbranch" style="flex:1;" value='<s:property value="cmbcolinbranch"/>' onchange="getLoc(this.value);">
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" name="hidcmbcolinbranch" id="hidcmbcolinbranch" value='<s:property value="hidcmbcolinbranch"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Location</label>
                        <select name="cmbcolinlocation" id="cmbcolinlocation" style="flex:1;" value='<s:property value="cmbcolinlocation"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" name="hidcmbcolinlocation" id="hidcmbcolinlocation" value='<s:property value="hidcmbcolinlocation"/>'>
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:60px;">Date</label>
                        <div style="width: 125px;">
                            <div id="colindate" name="colindate" value='<s:property value="colindate"/>'></div>
                        </div>
                        <input type="hidden" name="hidcolindate" id="hidcolindate" value='<s:property value="hidcolindate"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Time</label>
                        <div style="width: 80px;">
                            <div id="colintime" name="colintime" value='<s:property value="colintime"/>'></div>
                        </div>
                        <input type="hidden" name="hidcolintime" id="hidcolintime" value='<s:property value="hidcolintime"/>'>
                        
                        <label class="lbl-right" style="width:60px;">KM</label>
                        <input type="text" name="colinkm" id="colinkm" style="flex:1; text-align:right;" value='<s:property value="colinkm"/>'>
                        
                        <label class="lbl-right" style="width:60px;">Fuel</label>
                        <select name="cmbcolinfuel" id="cmbcolinfuel" style="flex:1;" value='<s:property value="cmbcolinfuel"/>'>
                            <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                        </select>
                        <input type="hidden" name="hidcmbcolinfuel" id="hidcmbcolinfuel" value='<s:property value="hidcmbcolinfuel"/>'>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    
    <!-- Hidden System Fields -->
    <div style="display:none;">
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
        <div id="dateouthidden" name="dateouthidden" hidden="true"></div>
        <div id="timeouthidden" name="timeouthidden" hidden="true"></div>
        <input type="hidden" id="status" name="status" value='<s:property value="status"/>'/>
        <input type="hidden" id="infleettrancode" name="infleettrancode" value='<s:property value="infleettrancode"/>'/>
        <input type="hidden" id="calcdocno" name="calcdocno" value='<s:property value="calcdocno"/>'/>
        <select name="cmbreplacetype" id="cmbreplacetype" style="width:95%;" onchange="checkReplace();" hidden="true">
            <option value="">--Select--</option>
            <option value="atbranch">At Branch</option>
            <option value="collection">Collection</option>
        </select>
        <input type="hidden" id="refno" name="refno" value='<s:property value="refno"/>' placeholder="Press F3 to Search" readonly onKeyDown="getAgmtno(event);"/>
    </div>
    
    <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px; text-align:center;"></div>
    
</div>
</form>

<!-- Search Windows -->
<div id="agmtnowindow"><div></div></div>
<div id="collectionwindow"><div></div></div>
<div id="vehiclewindow"><div></div></div>

</div>
</body>
</html>