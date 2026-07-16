<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: #ffffff; /* Explicitly removed light blue background/gradient */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #ffffff;
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

/* Existing image styles */
.big-image { float: left; margin-right: 15px; margin-bottom: 15px; border: 1px solid #999; background: #fff; padding: 3px; }
.small-image { border: 0px solid #ccc; padding: 3px; }
.content-container { padding: 15px; background: #fff; } /* Overwritten to white */
.important-text { font-size: 13px; color: #000; }
.more-text { color: #444; font-size: 11px; font-style: italic; }
input[type="button"]:disabled { opacity: 0; }
</style>

<script type="text/javascript">
$(document).ready(function () {  
	if(document.getElementById("approvalstatus").value=="1"){
		$('#btnpostdetails').show();
	} else {
		$('#btnpostdetails').hide();
	}
	
	$("#maintainceDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	$("#invDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#postDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});

    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#maintainceDate, #invDate, #postDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#maintainceDate, #invDate, #postDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

	$('#fleetsearchwindow').jqxWindow({  width: '62%', height: '67%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#fleetsearchwindow').jqxWindow('close');
	$('#typessearchswindow').jqxWindow({  width: '30%', height: '63%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Type Search' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#typessearchswindow').jqxWindow('close');
	$('#damagewindow').jqxWindow({  width: '30%', height: '63%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Search' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#damagewindow').jqxWindow('close');
	$('#postwindow').jqxWindow({  width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' ,title: 'Posting Details' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#postwindow').jqxWindow('close');
	$('#garragesearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '70%' ,maxWidth: '50%' ,title: 'Garrage Search' , position: { x: 700, y: 60 }, keyboardCloseKey: 27});
	$('#garragesearchwindow').jqxWindow('close');
    $('#typeservsearchwndow').jqxWindow({ width: '30%', height: '59%',  maxHeight: '65%' ,maxWidth: '65%' , title: 'Type Search' ,position: { x: 200, y:100 }, keyboardCloseKey: 27});
    $('#typeservsearchwndow').jqxWindow('close');
    $('#serdescsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Description Search' ,position: { x: 200, y:100 }, keyboardCloseKey: 27});
    $('#serdescsearchwndow').jqxWindow('close'); 
    $('#jqxTabs').jqxTabs({ width: '100%', selectionTracker: true, animationType: 'fade', theme: 'energyblue' });

    $('#postDate').on('change', function (event) { 
    	var postdate = $('#postDate').jqxDateTimeInput('getDate');
        var dateval=funDateInPeriod(postdate);
        if(dateval==0){
        	return false;
        }
    });

    $('#maintainceDate').on('change', function (event) {
        var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
        funDateInPeriod(receiptdate);
        fundatechange($('#maintainceDate').val(),$('#masterdoc_no').val(),$('#mode').val());
    });

	$('#garagemaster').dblclick(function(){
        $('#garragesearchwindow').jqxWindow('open');
        garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));
    });
	
	$('#mtfleetno').dblclick(function(){
        $('#fleetsearchwindow').jqxWindow('open');
        fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));
    });
}); 

function descservSearchContent(url) {
    $.get(url).done(function (data) {
        $('#serdescsearchwndow').jqxWindow('open');
        $('#serdescsearchwndow').jqxWindow('setContent', data);
    }); 
}  

function TypeservSearchContent(url) {
    $.get(url).done(function (data) {
        $('#typeservsearchwndow').jqxWindow('open');
        $('#typeservsearchwndow').jqxWindow('setContent', data);
    }); 
} 
  	
function uppertypeSearchContent(url) {
    $.get(url).done(function (data) {
        $('#typessearchswindow').jqxWindow('open');
        $('#typessearchswindow').jqxWindow('setContent', data);
    }); 
} 

function damageSearchContent(url) {
    $.get(url).done(function (data) {
        $('#damagewindow').jqxWindow('open');
        $('#damagewindow').jqxWindow('setContent', data);
    }); 
} 

function getgarrage(event){
    var x= event.keyCode;
    if(x==114){
        $('#garragesearchwindow').jqxWindow('open');
        garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));   
    }
}  

function garragechangeContent(url) {
    document.getElementById("errormsg").innerText="";   
    $.get(url).done(function (data) {
        $('#garragesearchwindow').jqxWindow('setContent', data);
    }); 
}

function getfleet(event){
    var x= event.keyCode;
    if(x==114){
        $('#fleetsearchwindow').jqxWindow('open');
        fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));   
    }
}  

function fleetchangeContent(url) {
    $.get(url).done(function (data) {
        $('#fleetsearchwindow').jqxWindow('setContent', data);
    }); 
}

function funFocus(){
	$('#maintainceDate').jqxDateTimeInput('focus'); 	    		
}

function funReset() {}

function funReadOnly() {
	$('#frmmaint input').attr('readonly', true);
	$('#frmmaint select').attr('disabled', true);
	
	$('#mtfleetno').attr('disabled', true);
	$('#garagemaster').attr('disabled', true);
	$('#garagemaster').attr('readonly', true);
	$("#maindowngrid").jqxGrid({ disabled: true});
	$("#mainuppergrid").jqxGrid({ disabled: true}); 
	$("#approvel").jqxGrid({ disabled: true});
	$("#apprsecgrid").jqxGrid({ disabled: true}); 
	   
	document.getElementById("mainwk").innerText="";

	$('#invDate').jqxDateTimeInput({ disabled: true}); 
	$('#postDate').jqxDateTimeInput({ disabled: true}); 
	$('#maintainceDate').jqxDateTimeInput({ disabled: true}); 

	$('#jqxTabs').jqxTabs('enableAt', 1);
	$('#jqxTabs').jqxTabs('enableAt', 2);
	$('#jqxTabs').jqxTabs('enableAt', 3);
		
	$('#first').hide();
	$('#worderdiv').show();
	$('#jobappdiv').hide();
	$('#postdiv').hide();
			
	$('#nextserdue').attr('readonly', true);
	$('#currkm').attr('readonly', true);
			
	$('#maintype').attr('disabled', true);
	$('#garagemaster').attr('disabled', true);
	$('#invno').attr('readonly', true);		
				 
	$("#second").hide();
	$("#third").hide();
	$("#last").hide();	 
}

function funRemoveReadOnly() {
	document.getElementById("mainwk").innerText="";
	$('#worderdiv').hide();
	$('#jobappdiv').hide();
	$('#postdiv').hide();
	
	$('#frmmaint input').attr('readonly', false);
	$('#frmmaint select').attr('disabled', false);
	$('#mtfleetno').attr('disabled', false);
	$('#garagemaster').attr('disabled', false);
	$('#nextserdue').attr('disabled', false);
	
	$('#maintainceDate').jqxDateTimeInput({ disabled: false}); 
	$('#invDate').jqxDateTimeInput({ disabled: false}); 
	$('#postDate').jqxDateTimeInput({ disabled: false}); 
	
	$('#mtfleetno').attr('readonly', true);
	$('#mtflname').attr('readonly', true);
	$('#garagemaster').attr('readonly', true);
	$('#docno').attr('readonly', true);
	$("#maindowngrid").jqxGrid({ disabled: false});
	$("#mainuppergrid").jqxGrid({ disabled: false}); 
	
    if($('#mode').val()=='A') {
        $('#first').hide();
        $('#nextserdue').attr('disabled', false);
        $('#maintainceDate').val(new Date());
        $('#invDate').val(new Date());
        $('#postDate').val(new Date());
        
        $("#maindowngrid").jqxGrid('clear');
        $("#maindowngrid").jqxGrid('addrow', null, {});
        $("#mainuppergrid").jqxGrid('clear');
        $("#mainuppergrid").jqxGrid('addrow', null, {});
        
        $("#approvel").jqxGrid('clear');
        $("#approvel").jqxGrid('addrow', null, {});
        
        $("#apprsecgrid").jqxGrid('clear');
        $("#apprsecgrid").jqxGrid('addrow', null, {});
        
        $("#postingss").load("posting.jsp");
           
        $('#jqxTabs').jqxTabs('select',0);
        $('#jqxTabs').jqxTabs('disableAt', 1);
        $('#jqxTabs').jqxTabs('disableAt', 2);
        $('#jqxTabs').jqxTabs('disableAt', 3);
	} 
	
    if($('#mode').val()=='E') {
        $("#mainuppergrid").jqxGrid('addrow', null, {});
        $('#first').hide();
        $('#jqxTabs').jqxTabs('select',0);
        $('#jqxTabs').jqxTabs('disableAt', 1);
        $('#jqxTabs').jqxTabs('disableAt', 2);
        $('#jqxTabs').jqxTabs('disableAt', 3);
	} 
}

function valchange() {
    if($('#maintypeval').val()!="") {
        $('#maintype').val($('#maintypeval').val());
    }
    if($('#maintypeval').val()=="service" || $('#maintypeval').val()=="both") {
        $('#nextserdue').attr('disabled', false);	 
    } else { 
        $('#nextserdue').attr('disabled', true);
    }
}

function changetype() {
	if($('#maintype').val()=="service" || $('#maintype').val()=="both") {
        $('#nextserdue').attr('disabled', false);
	} else {
        $('#nextserdue').attr('disabled', true);
    }
}

function setValues() {
    if($('#hidmaintainceDate').val()){
        $("#maintainceDate").jqxDateTimeInput('val', $('#hidmaintainceDate').val());
    }
    if($('#hidinvDate').val()){
        $("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
    }
    if($('#hidpostDate').val()){
        $("#postDate").jqxDateTimeInput('val', $('#hidpostDate').val());
    }
	 
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
        $('#jqxTabs').jqxTabs('select', 1);
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

    var docval=document.getElementById("masterdoc_no").value;
    if(docval>0) {
        document.getElementById("mainwk").innerText=document.getElementById("formstatus").value;
        var indexVal2 = document.getElementById("masterdoc_no").value;
        $("#maingrid").load("maintGrid.jsp?maindoc="+indexVal2);
        $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
        $("#jobapprovel").load("jobapprovel.jsp?maindoc1="+indexVal2);
        $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
        
        var trno = document.getElementById("maintTrno").value;
        if(trno>0) {
            $('#jqxTabs').jqxTabs('enableAt', 1);
            $('#jqxTabs').jqxTabs('enableAt', 2);
            $('#jqxTabs').jqxTabs('enableAt', 3);
            $("#postingss").load("posting.jsp?maindoc1="+trno);
        }

        if(parseInt(document.getElementById("postvals").value)==1) {
            $.messager.alert('Message','Posting Updated Successfully'); 
            document.getElementById("mainwk").innerText="";
            $('#invno').attr('readonly', true);   
            $('#invDate').jqxDateTimeInput({ disabled: true}); 
            $('#postDate').jqxDateTimeInput({ disabled: true}); 
            $('#jqxTabs').jqxTabs('select', 3); 
            document.getElementById("postvals").value="";
            $('#secondedit').attr('disabled', true);
            $('#second').attr('disabled', true); 
            $('#thirdedit').attr('disabled', true);
            $('#third').attr('disabled', true); 
            $('#lastedit').attr('disabled', true);
            $('#last').attr('disabled', true); 
        } else if(parseInt(document.getElementById("postvals").value)==2) {
            $('#jqxTabs').jqxTabs('select', 3); 
            $.messager.alert('Message','Posting Not Updated'); 
            document.getElementById("mainwk").innerText="";
            document.getElementById("postvals").value="";
        }
        if(parseInt(document.getElementById("selectgridtype").value)==10) {
            document.getElementById("selectgridtype").value="";
        } else if(parseInt(document.getElementById("selectgridtype").value)==11) {
            document.getElementById("selectgridtype").value="";
        }
	         
        if(parseInt(document.getElementById("workstatus").value)==1) {
            valchange();   
            $("#btnEdit").attr('disabled', true );
            var indexVal2 = document.getElementById("masterdoc_no").value; 
            $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
        } else {
            $("#btnEdit").attr('disabled', false );
        }
	         
        var formdetailcodes=document.getElementById("formdetailcode").value;
        if(formdetailcodes=="MAP"|| formdetailcodes=="MPO") {      
            if(parseInt(document.getElementById("apprstatus").value)==1) {
                $('#garagemaster').attr('disabled', true);
                $('#frmmaint select').attr('disabled', true); 
                $('#secondedit').attr('disabled', true);
                $('#second').attr('disabled', true); 
                $('#btnCreate').attr('disabled', true); 
                $("#btnEdit").attr('disabled', true );
            }
            if(parseInt(document.getElementById("postingstatus").value)==1) {
                $('#thirdedit').attr('disabled', true);
                $('#third').attr('disabled', true); 
                $('#lastedit').attr('disabled', true);
                $('#last').attr('disabled', true); 
                $('#btnCreate').attr('disabled', true); 
                $("#btnEdit").attr('disabled', true );   
            }
        }
	       
        if(formdetailcodes=="MPO") {
            if(parseInt(document.getElementById("postingstatus").value)==1) {
                $('#invno').attr('readonly', true);   
                $('#invDate').jqxDateTimeInput({ disabled: true}); 
                $('#postDate').jqxDateTimeInput({ disabled: true}); 
                $('#nextserdue').attr('readonly', true);
                $('#currkm').attr('readonly', true);
                $('#secondedit').attr('disabled', true);
                $('#second').attr('disabled', true); 
                $('#thirdedit').attr('disabled', true);
                $('#third').attr('disabled', true); 
                $('#lastedit').attr('disabled', true);
                $('#last').attr('disabled', true); 
                $('#btnCreate').attr('disabled', true); 
                $("#btnEdit").attr('disabled', true );
            }
        }
    }
	  
    $('#jobappdiv').show();
    $('#postdiv').show();

    var formdetailcodes=document.getElementById("formdetailcode").value;
    if(formdetailcodes=="MWO") {
        $('#jobappdiv').hide();
        $('#postdiv').hide();
    } else if(formdetailcodes=="MAP") {
        $('#postdiv').hide();
    }
      
    if(formdetailcodes=="MAP"|| formdetailcodes=="MPO") {  
        $('#btnCreate').attr('disabled', true); 
        $("#btnEdit").attr('disabled', true );
    }
}

function funNotify(){
    var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(receiptdate);
    if(validdate==0){
        return 0; 
    }
    fundatechange($('#maintainceDate').val(),$('#masterdoc_no').val(),$('#mode').val());
    var fleetval=document.getElementById("mtfleetno").value;
    if(fleetval=="") {
        document.getElementById("errormsg").innerText="Select Fleet No";  
        document.getElementById("mtfleetno").focus();
        return 0;
    }
	   
    if($("#mode").val() == "A" || $("#mode").val() == "E" ) {
        var rows = $("#mainuppergrid").jqxGrid('getrows');
        var aa=0;
        for(var i=0;i<rows.length;i++){
            if(rows[i].clears==true){
                aa=1;
                break;
            } else {
                aa=0;
            }
        }  
        if(aa==0){
            document.getElementById("errormsg").innerText="Select Maintenance Required ";  
            return 0;
        } 
			
        var rows = $("#mainuppergrid").jqxGrid('getrows');
        $('#maingridlength').val(rows.length);
        for(var i=0;i<rows.length;i++){
            newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "main"+i)                  
                .attr("name", "main"+i)        
                .attr("hidden", "true");  
            newTextBox.val(rows[i].hidrefdates+"::"+rows[i].clears+" :: "+rows[i].rem+" :: "+rows[i].refsrno+" :: "+rows[i].typedocno+" :: "+rows[i].damageid+" :: ");
            newTextBox.appendTo('form'); 
        }
    }
	   
    var postdate = $('#postDate').jqxDateTimeInput('getDate');
    var dateval=funDateInPeriod(postdate);
    if(dateval==0){
        return 0;
    }
    return 1;	
}

function funChkButton() {}
	  
function funSearchLoad(){
	changeContent('masterSearch.jsp'); 
}
 
function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveMaint");
        $("#docno").prop("disabled", false);
        var win= window.open(reurl[0]+"printmaintWork?docno="+document.getElementById("masterdoc_no").value+"&date="+$('#hidmaintainceDate').val(),"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}  

function firstnext() {}

function secnext() {
    var garrage=document.getElementById("garrageid").value;
    if(garrage=="") {
        document.getElementById("errormsg").innerText="Select Garrage";  
        document.getElementById("garagemaster").focus();
        return 0;
    }
	   
    var rows = $("#maindowngrid").jqxGrid('getrows');
    var aa=0;
    for(var i=0;i<rows.length;i++){
        var rateval=rows[i].type;
        if(!(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN")) {
            $('#jqxTabs').jqxTabs('enableAt', 2);
            aa=1;
            break;
        } else {
            aa=0;
        }
    }  

    if(aa==0){
        document.getElementById("errormsg").innerText="Work Order Details Required ";  
        return 0;
    } 
	   
    var rows = $("#maindowngrid").jqxGrid('getrows');
    var list = new Array();
    for(var i=0 ; i < rows.length-1 ; i++){
        list.push(rows[i].type.replace("&","%26")+"::"+rows[i].description.replace("&","%26")+"::"+rows[i].remarks.replace("&","%26")+"::"+rows[i].lbrcost+"::"+rows[i].partscost+"::"+rows[i].total);
    }
    ajaxcall(list);
}

function ajaxcall(list) {
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            var itemval=items.trim();
            var docval=document.getElementById("masterdoc_no").value;
            if(docval>0) {
                var indexVal2 = document.getElementById("masterdoc_no").value;
                document.getElementById("mainwk").innerText="";
                $("#second").hide();
                $("#secondedit").show();
                $("#third").hide();
                $("#thirdedit").show();
                
                $('#garagemaster').attr('disabled', true);
                $('#frmmaint select').attr('disabled', true); 
                
                $("#btnEdit").attr('disabled', true );
                $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
                $("#jobapprovel").load("jobapprovel.jsp?maindoc1="+indexVal2);
                $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
                $.messager.alert('Message','Successfully Saved');
            }
		}
	}
    x.open("GET","workordersavedata.jsp?list="+list+'&doc='+document.getElementById("masterdoc_no").value+'&garrageid='+document.getElementById("garrageid").value+'&maintype='+document.getElementById("maintype").value); 
	x.send();
}

function trdnext() {
    var cuurkmvals=document.getElementById("currkm").value;
    if(cuurkmvals=="") {
        document.getElementById("errormsg").innerText="Enter Current KM";  
        document.getElementById("currkm").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";  
    }
 
    if($('#maintype').val()=="service" || $('#maintype').val()=="both") {
        var cuurkmval=document.getElementById("currkm").value;
        var nextserkmval=document.getElementById("nextserdue").value;
        
        if(nextserkmval=="") {
            document.getElementById("errormsg").innerText="Enter Service Due KM ";  
            document.getElementById("nextserdue").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";  
        }
        if((parseFloat(nextserkmval)<parseFloat(cuurkmval))) {
            document.getElementById("errormsg").innerText="Service Due KM Less Than Current KM";  
            document.getElementById("nextserdue").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";  
        }
    }
    $('#jqxTabs').jqxTabs('enableAt', 3);
    $("#hidediv").show();
	var rows = $("#approvel").jqxGrid('getrows');
	var lists = new Array();
    for(var i=0 ; i < rows.length-1 ; i++){
        if(rows[i].clears==true) {
            lists.push(rows[i].type.replace("&","%26")+"::"+rows[i].description.replace("&","%26")+"::"+rows[i].remarks.replace("&","%26")+"::"+rows[i].lbrcost+"::"+rows[i].partscost+"::"+rows[i].total);  
        }  
    }
    ajaxcall1(lists);  
}

function ajaxcall1(lists){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
            apprsecgrid();
		}
	}
	x.open("GET","approvelsavedata.jsp?list="+lists+'&doc='+document.getElementById("masterdoc_no").value+'&currkm='+document.getElementById("currkm").value+'&nextserdue='+document.getElementById("nextserdue").value);   
	x.send();
}

function apprsecgrid() {
	var rows = $("#apprsecgrid").jqxGrid('getrows');
 	var listss = new Array();
    for(var i=0 ; i < rows.length-1 ; i++){
        if(rows[i].clears==true) { 
            listss.push(rows[i].hidrefdates+"::"+rows[i].rem.replace("&","%26")+"::"+rows[i].refsrno+"::"+rows[i].typedocno+"::"+rows[i].damageid+"::"+rows[i].hidcldate+"::"+rows[i].hidcltime);  
        }
    }
    ajaxcallsub(listss);
}

function ajaxcallsub(listss){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
            jurnsave();
		}
	}
    x.open("GET","apprsndsave.jsp?list="+listss+'&doc='+document.getElementById("masterdoc_no").value);
	x.send();
}

function jurnsave() {
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            var docval=document.getElementById("masterdoc_no").value;
            if(docval>0) {
                document.getElementById("maintTrno").value =items; 
                var indexVal2 = document.getElementById("masterdoc_no").value;
                
                $("#btnEdit").attr('disabled', true );
                $('#garagemaster').attr('disabled', true);
                $('#frmmaint select').attr('disabled', true); 
                $('#secondedit').attr('disabled', true);
                $('#second').attr('disabled', true); 
                
                $('#currkm').attr('readonly', true);
                $('#nextserdue').attr('readonly', true);
                
                $("#second").hide();
                $("#secondedit").show();
                $("#third").hide();
                $("#thirdedit").show();
                $("#last").hide();	
                $("#lastedit").show();	
                
                $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
                $("#jobapprovel").load("jobapprovel.jsp?maindoc1="+indexVal2);
                $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
                $("#postingss").load("posting.jsp?maindoc1="+items);
                
                document.getElementById("mainwk").innerText="";
                $.messager.alert('Message','Successfully Saved');
                document.getElementById("invno").value="";
                $("#hidediv").hide();
            }
		}
	}
	x.open("GET","jurnsave.jsp?docno="+document.getElementById("masterdoc_no").value+'&garragename='+document.getElementById("garagemaster").value+"&garrageid="+document.getElementById("garrageid").value);
	x.send();
}

function lastsave(){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            if(parseInt(items)==1) {
                $.messager.alert('Message','Posting Already Done ','warning');   
                return 0; 
            } else {
                checkposting();
            }
		}
	}
	x.open("GET","checkpostingstatus.jsp?doc="+document.getElementById("masterdoc_no").value);
	x.send();
}

function checkposting(){
    var date=$('#postDate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(date);
    if(validdate==0){
        return false; 
    } 
        
    $('#frmmaint input').attr('readonly', false);
    $('#frmmaint select').attr('disabled', false);
    $('#mtfleetno').attr('disabled', false);
    $('#garagemaster').attr('disabled', false);
    $('#nextserdue').attr('disabled', false);
    $('#maintainceDate').jqxDateTimeInput({ disabled: false}); 
    $('#invDate').jqxDateTimeInput({ disabled: false});  
    $('#postDate').jqxDateTimeInput({ disabled: false}); 
    
    $('#mtfleetno').attr('readonly', true);
    $('#mtflname').attr('readonly', true);
    $('#garagemaster').attr('readonly', true);
    $('#docno').attr('readonly', true);
    
    document.getElementById("mainwk").innerText="";   
    document.getElementById("mode").value="POS";
    document.getElementById("frmmaint").submit();
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}

function secondedits() {
	$('#maintype').attr('disabled', false);
	$('#garagemaster').attr('disabled', false);	
	$('#garagemaster').attr('readonly', true);
	$("#maindowngrid").jqxGrid({ disabled: false});
	$("#second").show();
	$("#secondedit").hide();
}

function thirdedits() {
    if(document.getElementById("currkm").value.trim()==""){
        $('#mtfleetno').attr('disabled', false);
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items= x.responseText.trim();
                if(parseInt(items)>0) {
                    document.getElementById("currkm").value=items;
                }
            }
        }
        x.open("GET","searchfleetkm.jsp?fleet_no="+document.getElementById("mtfleetno").value);
        x.send();
    }
	 
    $("#third").show();
    $("#thirdedit").hide();
    
    $('#mtfleetno').attr('disabled', true);
    $('#currkm').attr('readonly', false);
    $('#nextserdue').attr('readonly', false);
    
    $("#approvel").jqxGrid({ disabled: false});
    $("#approvel").jqxGrid('addrow', null, {}); 
    $("#apprsecgrid").jqxGrid({ disabled: false}); 
    $("#apprsecgrid").jqxGrid('addrow', null, {});
}

function lastedits() {
    $("#last").show();	
    $("#lastedit").hide();	
    $("#posting").jqxGrid({ disabled: false});
    $('#invDate').jqxDateTimeInput({ disabled: false}); 
    $('#postDate').jqxDateTimeInput({ disabled: false}); 
    $('#invno').attr('readonly', false);
}

function getPostDetails(){
	var docno=$('#masterdoc_no').val();
	$('#postwindow').jqxWindow('open');
	postDetailsSearchContent('postDetailsGrid.jsp?docno='+docno+'&id=1');
}

function postDetailsSearchContent(url) {
	$.get(url).done(function (data) {
		$('#postwindow').jqxWindow('setContent', data);
	}); 
} 

function fundatechange(date,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)>0 && $('#mode').val()=='A'){
                $('#maintainceDate').val(new Date());
                $.messager.alert('Message','Back Date Restricted. ','warning');
                return false;
            } else if(parseInt(items)>0 && $('#mode').val()=='E'){
                $("#maintainceDate").jqxDateTimeInput('val', $('#hidmaintainceDate').val());
                $.messager.alert('Message','Back Date Restricted. ','warning');   
                return false;
            } else {
                return true;
            }
        }
    }
    x.open("GET", "getBackDateRestriction.jsp?date="+date+"&docno="+docno+"&mode="+mode, true);
    x.send();
}
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmmaint" action="saveMaintworkorder" name="maintworkorder" method="post" autocomplete="OFF">
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <div class="middle-panel">
            <span class="middle-panel-title">Maintenance Work Order</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Date</label>
                <div style="width: 125px;">
                    <div id="maintainceDate" name="maintainceDate" onblur="fundatechange($('#maintainceDate').val(),$('#masterdoc_no').val(),$('#mode').val());" value='<s:property value="date_accountmaster"/>'></div>
                </div>
                <input type="hidden" id="hidmaintainceDate" name="hidmaintainceDate" value='<s:property value="hidmaintainceDate"/>'>

                <label class="lbl-right" style="width:80px;">Fleet No</label>
                <div class="input-search-container" style="width: 125px;">
                    <input type="text" id="mtfleetno" name="mtfleetno" placeholder="Press F3" value='<s:property value="mtfleetno"/>' onkeydown="getfleet(event)" />
                    <svg class="magnifier-icon" onclick="$('#mtfleetno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="lbl-right" style="width:80px;">Name</label>
                <input type="text" id="mtflname" tabindex="-1" name="mtflname" value='<s:property value="mtflname"/>' style="flex:1;" readonly>

                <label class="lbl-right" style="width:80px;">Doc No</label>
                <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' style="width:120px;" readonly>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Remarks</label>
                <input type="text" id="mtremark" name="mtremark" value='<s:property value="mtremark"/>' style="flex:1;">
                
                <label id="mainwk" name="mainwk" style="color:#b22222; font-weight:bold; margin-left:10px;"></label>
            </div>
        </div>

        <div id='jqxWidget' style="margin-top: 15px;">
            <div id='jqxTabs' class='jqx-rc-all' style="border:none; background:transparent;">
                <ul style="margin-left:1px;" id="unorderedList">
                    <li>
                        <div style="height: 30px;">
                            <img style='float: left;' width='24' height='24' src="<%=contextPath%>/icons/maintreq.png" alt="" class="small-image" /> 
                            <div style="float: left; margin-left: 6px; margin-top: 5px;">Maintenance Required</div>
                        </div>
                    </li>
                    <li>
                        <div style="height: 30px;" id="worderdiv">   
                            <img style='float: left;' width='24' height='24' src="<%=contextPath%>/icons/maintworkorder.png" alt="" class="small-image" /> 
                            <div style="float: left; margin-left: 6px; margin-top: 5px;">Work Order</div>
                        </div>
                    </li>
                    <li>
                        <div style="height: 30px;" id="jobappdiv">
                            <img style='float: left;' width='24' height='24' src="<%=contextPath%>/icons/maintapproval.png" alt="" class="small-image" /> 
                            <div style="float: left; margin-left: 6px; margin-top: 5px;">Job Approval</div>
                        </div>
                    </li>
                    <li>
                        <div style="height: 30px;" id="postdiv">
                            <img style='float: left;' width='24' height='24' src="<%=contextPath%>/icons/maintposting.png" alt="" class="small-image" />
                            <div style="float: left; margin-left: 6px; margin-top: 5px;">Posting</div>
                        </div>
                    </li>
                </ul>

                <!-- TAB 1: Maintenance Required -->
                <div class="content-container" style="background:#fff; padding:15px; border-top: 1px solid #c5d3e0;">
                    <div id="maingrid" class="grid-container">
                        <jsp:include page="maintGrid.jsp"></jsp:include>
                    </div>
                    <input type="hidden" hidden="true" id="first" onclick="firstnext();">
                </div>
      
                <!-- TAB 2: Work Order -->
                <div class="content-container" style="background:#fff; padding:15px; border-top: 1px solid #c5d3e0;">
                    <div class="field-row">
                        <label class="lbl-right" style="width:100px;">Type</label>
                        <select id="maintype" name="maintype" onchange="changetype()" value='<s:property value="maintype"/>' style="width:150px;">
                            <option value="service">Service</option>
                            <option value="repair">Repair</option>  
                            <option value="both">Both</option>  
                            <option value="accidentrepair">Accident Repair</option>    
                        </select>
                        
                        <label class="lbl-right" style="width:100px;">Garage</label>
                        <div class="input-search-container" style="width: 200px;">
                            <input type="text" id="garagemaster" name="garagemaster" placeholder="Press F3" value='<s:property value="garagemaster"/>' onkeydown="getgarrage(event)" />
                            <svg class="magnifier-icon" onclick="$('#garagemaster').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                    </div>
                    
                    <div id="servgrid" class="grid-container">
                        <jsp:include page="servicemaingrid.jsp"></jsp:include>
                    </div>
                    
                    <div class="field-row" style="justify-content: flex-end; margin-top: 15px;">
                        <button type="button" id="secondedit" onclick="secondedits();" class="myButton">EDIT</button>
                        <button type="button" id="second" hidden="true" onclick="secnext();" class="myButton" style="margin-left:10px;">SAVE</button>
                    </div>
                </div>

                <!-- TAB 3: Job Approval -->
                <div class="content-container" style="background:#fff; padding:15px; border-top: 1px solid #c5d3e0;">  
                    <div class="field-row">
                        <label class="lbl-right" style="width:100px;">Curr.KM</label>
                        <input type="text" id="currkm" name="currkm" onkeypress="javascript:return isNumber (event)" value='<s:property value="currkm"/>' style="width:150px;"> 
                        
                        <label class="lbl-right" style="width:120px;">Next Ser.Due KM</label>
                        <input type="text" id="nextserdue" name="nextserdue" onkeypress="javascript:return isNumber (event)" value='<s:property value="nextserdue"/>' style="width:150px;"> 
                    </div>

                    <div id="imgdiv">
                        <div hidden="true" style="position:absolute; z-index: 1; top:300px; right:400px; text-align:center;" id="hidediv">
                            <img alt="Search User" src="<%=contextPath%>/icons/31load.gif"> 
                        </div>
                    </div>     
                         
                    <div id="jobapprovel" class="grid-container"> 
                        <jsp:include page="jobapprovel.jsp"></jsp:include>
                    </div>
                    <div id="jobapprovelsec" class="grid-container" style="margin-top: 15px;">  
                        <jsp:include page="approvelsecondgrid.jsp"></jsp:include>
                    </div>
                             
                    <div class="field-row" style="justify-content: flex-end; margin-top: 15px;">
                        <button type="button" id="thirdedit" onclick="thirdedits();" class="myButton">EDIT</button>
                        <button type="button" hidden="true" id="third" onclick="trdnext();" class="myButton" style="margin-left:10px;">SAVE</button>
                    </div>
                </div>

                <!-- TAB 4: Posting -->
                <div class="content-container" style="background:#fff; padding:15px; border-top: 1px solid #c5d3e0;">
                    <div class="field-row">
                        <label class="lbl-right" style="width:100px;">Inv No</label>
                        <input type="text" id="invno" name="invno" value='<s:property value="invno"/>' style="width:150px;">
                        
                        <label class="lbl-right" style="width:80px;">Inv Date</label>
                        <div style="width: 125px;">
                            <div id="invDate" name="invDate" value='<s:property value="invDate"/>'></div>
                        </div>
                        <input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
                        
                        <label class="lbl-right" style="width:100px;">Posting Date</label>
                        <div style="width: 125px;">
                            <div id="postDate" name="postDate" value='<s:property value="postDate"/>'></div>
                        </div>
                        <input type="hidden" id="hidpostDate" name="hidpostDate" value='<s:property value="hidpostDate"/>'>

                        <button type="button" id="btnpostdetails" class="myButton" onclick="getPostDetails();" style="margin-left:auto;">Post Details</button>
                    </div>
                    
                    <div id="postingss" class="grid-container"> 
                        <jsp:include page="posting.jsp"></jsp:include>
                    </div>
                    
                    <div class="field-row" style="justify-content: flex-end; margin-top: 15px;">
                        <button type="button" id="lastedit" onclick="lastedits();" class="myButton">EDIT</button>
                        <button type="button" id="last" hidden="true" onclick="lastsave();" class="myButton" style="margin-left:10px;">SAVE</button>
                    </div>
                </div>
            </div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="formstatus" name="formstatus" value='<s:property value="formstatus"/>'>
            <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'>
            <input type="hidden" id="garrageid" name="garrageid" value='<s:property value="garrageid"/>'>
            <input type="hidden" id="mtypename" name="mtypename" value='<s:property value="mtypename"/>'>
            <input type="hidden" id="mtypename1" name="mtypename1" value='<s:property value="mtypename1"/>'>
            <input type="hidden" id="lbrtotalcost" name="lbrtotalcost" value='<s:property value="lbrtotalcost"/>'>  
            <input type="hidden" id="partstotalcost" name="partstotalcost" value='<s:property value="partstotalcost"/>'> 	
            <input type="hidden" id="totalcost" name="totalcost" value='<s:property value="totalcost"/>'>    
            <input type="hidden" id="maintypeval" name="maintypeval" value='<s:property value="maintypeval"/>'>    
            <input type="hidden" id="maintTrno" name="maintTrno" value='<s:property value="maintTrno"/>'>      
            <input type="hidden" id="jvmDovno" name="jvmDovno" value='<s:property value="jvmDovno"/>'>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
            <input type="hidden" id="maingridlength" name="maingridlength" value='<s:property value="maingridlength"/>'>
            <input type="hidden" id="servicegridlenght" name="servicegridlenght" value='<s:property value="servicegridlenght"/>'>
            <input type="hidden" id="postvals" name="postvals" value='<s:property value="postvals"/>'>
            <input type="hidden" id="selectgridtype" name="selectgridtype" value='<s:property value="selectgridtype"/>'>
            <input type="hidden" id="stop" name="stop" value='<s:property value="stop"/>'>
            <input type="hidden" id="stop1" name="stop1" value='<s:property value="stop1"/>'>
            <input type="hidden" id="workstatus" name="workstatus" value='<s:property value="workstatus"/>'>
            <input type="hidden" id="apprstatus" name="apprstatus" value='<s:property value="apprstatus"/>'>
            <input type="hidden" id="approvalstatus" name="approvalstatus" value='<s:property value="approvalstatus"/>'>              
            <input type="hidden" id="postingstatus" name="postingstatus" value='<s:property value="postingstatus"/>'>
        </div>  

    </div>
</form>

<div id="fleetsearchwindow"><div></div></div>
<div id="typeservsearchwndow"><div></div></div>
<div id="serdescsearchwndow"><div></div></div> 
<div id="garragesearchwindow"><div></div></div>
<div id="typessearchswindow"><div></div></div>
<div id="damagewindow"><div></div></div>
<div id="postwindow"><div></div></div>

</div>
</body>
</html>