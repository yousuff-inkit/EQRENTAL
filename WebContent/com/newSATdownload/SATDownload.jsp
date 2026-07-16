<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.logging.Logger" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

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
.modern-ui select,
.modern-ui input[type="file"] { 
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

.modern-ui input[type="checkbox"],
.modern-ui input[type="radio"] {
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

.modern-ui .myButton:disabled {
    background: #cccccc;
    color: #888888;
    cursor: not-allowed;
    box-shadow: none;
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

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Progress Bar */
.gw-animate-opacity{ animation:opac 0.8s; }
@keyframes opac{ from{opacity:0;} to{opacity:1;} }
.gw-text-green{ color:#4CAF50; font-weight:bold; }
.gw-container:after, .gw-container-after{ content: ""; display: table; clear:both; }
.gw-container{ padding:0.01em 16px; width: 100%; box-sizing: border-box; }
.gw-green{ background-color:#4CAF50; height: 100%; transition: width 0.3s; }
.gw-light-grey{ background-color:#f1f1f1; border-radius:3px; overflow:hidden; border: 1px solid #ccc; height:24px; margin-bottom: 5px;}

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript" src="ajaxfileupload.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../icons/31load.gif'/></div>");
    
    funBlackPoints();
    
    /* Hide unneeded generic buttons from parent template scope */
    $("#btnClose, #status, #btnSave, #btnCancel, #btnApproval, #btnCreate, #btnEdit, #btnPrint, #btnExcel, #btnDelete, #btnSearch, #btnAttach, #btnGuideLine, #btnSendmail").hide();
    
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#jqxStartDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd MMM yyyy", theme: 'energyblue'});
    $("#jqxEndDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd MMM yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#jqxStartDate, #jqxEndDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#jqxStartDate, #jqxEndDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    /* Popup Windows */
    var windowConfig = { height: '40%', maxHeight: '70%', maxWidth: '51%', title: 'Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true };
    $('#unameWindow').jqxWindow($.extend({}, windowConfig, {width: '30%'})).jqxWindow('close');
    $('#filenameWindow').jqxWindow($.extend({}, windowConfig, {width: '30%'})).jqxWindow('close');
    $('#sourceWindow').jqxWindow($.extend({}, windowConfig, {width: '30%', height: '50%'})).jqxWindow('close');
    $('#colorWindow').jqxWindow($.extend({}, windowConfig, {width: '30%', height: '50%'})).jqxWindow('close');
    $('#platenoWindow').jqxWindow($.extend({}, windowConfig, {width: '30%', height: '50%'})).jqxWindow('close');
    $('#fleetWindow').jqxWindow($.extend({}, windowConfig, {width: '41%', height: '58%'})).jqxWindow('close');
    $('#vehinfowindow').jqxWindow($.extend({}, windowConfig, {width: '60%', height: '67%', maxWidth:'70%', title:'Fleet Search', position: { x: 250, y: 60 }, keyboardCloseKey: 27})).jqxWindow('close');

    $('#loadcaptcha').hide(); $('#loadsalikdata').hide(); $('#loadtrafficdata').hide();

    /* Events */
    $('#txtusername').dblclick(function(){
        var site=$('#cmbsaliksite').val();
        unameSearchContent('satUsernameSearch.jsp?site='+site);
    });
    $('#txttrafficplateno').dblclick(function(){
        var site=document.getElementById("cmbtrafficsite").value;
        filenameSearchContent('satfilenameSearch.jsp?site='+site);
    });
    $('#txttrafficpsource').dblclick(function(){
        var site=document.getElementById("cmbtrafficsite").value;
        filesourceSearchContent('satSourceSearch.jsp?site='+site);
    });
    $('#txttrafficpcolor').dblclick(function(){
        var site=document.getElementById("cmbtrafficsite").value;
        var source=document.getElementById("txttrafficpsource").value;
        filecolorSearchContent('satColorSearch.jsp?source='+source+'&site='+site);
    });
    $('#txtsaliktagno').dblclick(function(){
        plateNoSearchContent('satPlateNoSearch.jsp');
    });
    $('#txtsalikfleetno').dblclick(function(){
        vehinfoSearchContent('vehinfo.jsp');
    });

    /* Year population */
    var currentdate=new Date();
    var yearhtml='<option value="">--Select--</option>';
    for(var i=parseInt(currentdate.getFullYear());i>=parseInt(currentdate.getFullYear())-10;i--){
        yearhtml+='<option value="'+i+'">'+i+'</option>';
    }
    $('#cmbyear').html($.parseHTML(yearhtml));

    /* File Upload */
    $('#btnfileupload').click(function(e){
        if(document.getElementById("file").files.length > 0 ){
            $("#overlay, #PleaseWait").show();
            $.get('getExcelDoc.jsp',function(data){
                data=JSON.parse(data);
                var docno=data.exceldocno;
                var attachdesc='Excel attachment of SAT#'+docno;
                $.ajaxFileUpload({
                    url:'appAttachAction.action?formCode=SAT&doc_no='+docno+'&descpt='+attachdesc+'&reftypid=1',
                    secureuri:false,
                    fileElementId:'file',
                    dataType: 'json',
                    success: function (data, status){  
                        if(status=='success'){
                            moveProgressBar();
                            $.post('readExcel.jsp',{exceldocno:docno},function(salikdata,status){
                                salikdata=JSON.parse(salikdata);
                                $("#loadsalikdata").load("SATloadDetails.jsp?xdocs="+salikdata.salikdocno);
                                $('#loadsalikdata').show();	           						
                                $("#overlay, #PleaseWait").hide();
                                getFinalCount();
                            });
                        } else if(typeof(data.error) != 'undefined'){
                            $("#overlay, #PleaseWait").hide();
                            if(data.error != ''){ $.messager.alert('Warning',data.error); }
                            else { $.messager.alert('Warning',data.message); }  
                        }  
                    },  
                    error: function (data, status, e){
                        $("#overlay, #PleaseWait").hide(); 
                        $.messager.alert('Warning',e);
                    }  
                }); 	
            });
        }
    });

    /* Initial state */
    fundisable();
});

function unameSearchContent(url) { $('#unameWindow').jqxWindow('open'); $.get(url).done(function(data){ $('#unameWindow').jqxWindow('setContent', data); $('#unameWindow').jqxWindow('bringToFront'); }); }
function filenameSearchContent(url) { $('#filenameWindow').jqxWindow('open'); $.get(url).done(function(data){ $('#filenameWindow').jqxWindow('setContent', data); $('#filenameWindow').jqxWindow('bringToFront'); }); }
function filesourceSearchContent(url) { $('#sourceWindow').jqxWindow('open'); $.get(url).done(function(data){ $('#sourceWindow').jqxWindow('setContent', data); $('#sourceWindow').jqxWindow('bringToFront'); }); }
function filecolorSearchContent(url) { $('#colorWindow').jqxWindow('open'); $.get(url).done(function(data){ $('#colorWindow').jqxWindow('setContent', data); $('#colorWindow').jqxWindow('bringToFront'); }); }
function plateNoSearchContent(url) { $('#platenoWindow').jqxWindow('open'); $.get(url).done(function(data){ $('#platenoWindow').jqxWindow('setContent', data); $('#platenoWindow').jqxWindow('bringToFront'); }); }
function fleetSearchContent(url) { $('#fleetWindow').jqxWindow('open'); $.get(url).done(function(data){ $('#fleetWindow').jqxWindow('setContent', data); $('#fleetWindow').jqxWindow('bringToFront'); }); }
function vehinfoSearchContent(url) { $('#vehinfowindow').jqxWindow('open'); $.get(url).done(function(data){ $('#vehinfowindow').jqxWindow('setContent', data); $('#vehinfowindow').jqxWindow('bringToFront'); }); } 

function getCaptcha() {
    var x=new XMLHttpRequest();
    var uname=document.getElementById("txtusername").value;
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            var path=items.trim()+"/captcha.png";
            isfileexist(path);
        }
    }
    x.open("GET",'getCaptcha.jsp',true);
    x.send();
}

function getRemoveOldCaptchaImgOnLoad() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            var path=items.trim()+"/captcha.png";
            isfileexist(path);
        }
    }
    x.open("GET",'getRemoveOldCaptchaImgOnLoad.jsp',true);
    x.send();
}

function fundisable(){
    if (document.getElementById('radio_salik').checked) {
        getRemoveOldCaptchaImgOnLoad();
        
        $("#traffic-panel input, #traffic-panel select").prop("disabled", true);
        $('#radio_traffic').prop('disabled', false);
        
        $("#chck_salikautomatic").prop("disabled", false);
        $('#chck_salikautomatic').prop('checked', true);
        $('#chck_trafficautomatic').prop('checked', false);
        
        $("#salik-panel input, #salik-panel select").prop("disabled", false);
        $('#jqxStartDate, #jqxEndDate').jqxDateTimeInput({ disabled: true});
        
        document.getElementById("chck_trafficautomatic").checked = false;
        document.getElementById("chck_trafficfileno").checked = false;
        
        if(document.getElementById('chck_salikautomatic').checked) {
            $("#txtusername").prop("disabled", true);
            $("#salik-panel input.advanced-salik").prop("disabled", true); // disables tagno, fleetno, year, etc inside salik
            $("#cmbsaliksite").prop("disabled", false);
            $("#chck_salikautomatic").prop("disabled", false);
            $('#jqxStartDate, #jqxEndDate').jqxDateTimeInput({ disabled: true});
            $("#radio_salik").prop("disabled", false);
        }
        
        if ($("#cmbtype").val() == "customdates") {
            $('#jqxStartDate, #jqxEndDate').jqxDateTimeInput({ disabled: false});
        }
        
        $('#loadsalikdata').show();
        $('#loadtrafficdata').hide();
        
    } else if (document.getElementById('radio_traffic').checked) {
        getRemoveOldCaptchaImgOnLoad();
        
        $("#salik-panel input, #salik-panel select").prop("disabled", true);
        $("#chck_salikautomatic").prop("checked", false);
        
        $('#chck_trafficautomatic').prop('checked', true);
        $('#radio_salik').prop('disabled', false);
        
        $("#traffic-panel input, #traffic-panel select").prop("disabled", false);
        $('#jqxStartDate, #jqxEndDate').jqxDateTimeInput({ disabled: true}); 
        
        if ((document.getElementById('chck_trafficautomatic').checked)) {
            $("#traffic-panel input, #traffic-panel select").prop("disabled", true);
            $("#cmbtrafficsite").prop("disabled", false);
            $("#chck_trafficautomatic").prop("disabled", false);
            $("#radio_traffic").prop("disabled", false);
        }
        
        if (!(document.getElementById('chck_trafficautomatic').checked)) {
            document.getElementById("chck_trafficfileno").checked = true;
            $("#txttrafficpsource, #txttrafficpcolor, #txttrafficptype, #txttrafficpno").prop("disabled", true);
        }
        
        if ((document.getElementById('chck_trafficfileno').checked)) {
            $('#txttrafficplateno').prop('disabled', false); 
        }

        if ((document.getElementById('chck_trafficpdata').checked)) {
            $("#txttrafficpsource, #txttrafficpcolor, #txttrafficptype, #txttrafficpno").prop("disabled", false);
        }
        
        $('#loadsalikdata').hide();
        $('#loadtrafficdata').show();
    }
}

function funReadOnly(){ fundisable(); }
function funRemoveReadOnly(){}
function funSearchLoad(){}
function funChkButton() {}
function funFocus(){}
function funNotify(){ return 1; } 

function setValues(){
    if($('#hiddencategory').val()=='salik'){
        if($('#hidcmbsaliksite').val()){ $("#cmbsaliksite").val($('#hidcmbsaliksite').val()); }
        if($('#hidcmbtype').val()){ $("#cmbtype").val($('#hidcmbtype').val()); }
        if($('#hidjqxStartDate').val()){ $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val()); }
        if($('#hidjqxEndDate').val()){ $("#jqxEndDate").jqxDateTimeInput('val', $('#hidjqxEndDate').val()); }
        
        if ((document.getElementById('chck_trafficautomatic').checked)) {}
        
        $("#traffic-panel input, #traffic-panel select").prop("disabled", true);
        document.getElementById("radio_salik").checked = true;
        $('#loadtrafficdata').hide();
        
        var indexVal = document.getElementById("docs").value;
        $("#loadsalikdata").load("SATloadDetails.jsp?xdocs="+indexVal);
        $('#loadsalikdata').show();
    }
    
    if($('#hiddencategory').val()=='traffic'){
        if($('#hidcmbtrafficsite').val()){ $("#cmbtrafficsite").val($('#hidcmbtrafficsite').val()); }
        $("#salik-panel input, #salik-panel select").prop("disabled", true);
        document.getElementById("radio_traffic").checked = true;
        $('#loadsalikdata').hide();
        
        var indexVal = document.getElementById("docs").value;
        var plateno = document.getElementById("txttrafficplateno").value;
        var txttrafficpno = document.getElementById("txttrafficpno").value;
        if(plateno != ""){ document.getElementById("chck_trafficfileno").checked = true; }
        if(txttrafficpno != ""){ document.getElementById("chck_trafficpdata").checked = true; }
        
        $("#loadtrafficdata").load("SATTrafficloadDetails.jsp?trxdocs="+indexVal);
        $('#loadtrafficdata').show();
    }
    
    if($('#msg').val()!=""){ $.messager.alert('Message',$('#msg').val()); }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
    
    if(document.getElementById("itemcount").innerHTML==""){
        document.getElementById("itemcount").innerHTML="0";
        document.getElementById("itemtotalcount").innerHTML="0";
        document.getElementById("itemtype").innerHTML="Saliks";
        document.getElementById("gwProgressBar").style.width="0%";
    }
}

function getUname(event){ var x= event.keyCode; if(x==114){ var site=$('#cmbsaliksite').val(); unameSearchContent('satUsernameSearch.jsp?site='+site); } }
function getFilename(event){ var x= event.keyCode; if(x==114){ var site=$("#cmbtrafficsite").val(); filenameSearchContent('satfilenameSearch.jsp?site='+site); } }
function getSource(event){ var x= event.keyCode; if(x==114){ var site=$("#cmbtrafficsite").val(); filesourceSearchContent('satSourceSearch.jsp?site='+site); } }
function getColor(event){ var x= event.keyCode; if(x==114){ var site=$("#cmbtrafficsite").val(); var source=$("#txttrafficpsource").val(); filecolorSearchContent('satColorSearch.jsp?source='+source+'&site='+site); } }
function getPlateNo(event){ var x= event.keyCode; if(x==114){ plateNoSearchContent('satPlateNoSearch.jsp'); } }
function getFleet(event){ var x= event.keyCode; if(x==114){ fleetSearchContent('satFleetSearch.jsp'); } }
function getvehinfo(event){ var x= event.keyCode; if(x==114){ vehinfoSearchContent('vehinfo.jsp'); } }

window.setInterval(function(){ funDivload(); }, 5000000);

function funDivload(){
    var txtcaptcha=document.getElementById("txtcaptcha").value;
    if(txtcaptcha==""){ getCaptcha(); }
    if(!(txtcaptcha=="")){ document.getElementById("errormsg").innerHTML="Download under Progress...Please wait..."; }
}

function iscaptcha(){
    var iscaptcha=document.getElementById("iscaptcha").value;
    if(iscaptcha==1){
        document.getElementById("errormsg").innerHTML="Please Wait...Loading Captcha...";
        getCaptcha();
    } else{
        return false;
    }
}

function isfileexist(fileURL){
    var host = window.location.origin;
    var splt = fileURL.split("webapps"); 
    var repl = splt[1].replace( /\\/g, "/");
    fileURL=host+repl; 
    
    $.ajax({
        url: fileURL, 
        success: function(data){ captchaload(); },
        error: function(data){},
    })
}

function captchaload(){
    $('#loadcaptcha').show();
    $("#loadcaptcha").load("captcha.jsp");
    document.getElementById("errormsg").innerHTML="Please fill the captcha with in 60 seconds";
}

function getBrowser(){
    if (document.getElementById('radio_salik').checked) {
        if(!(document.getElementById('chck_salikautomatic').checked)) {
            if($('#txtusername').val()==''){
                document.getElementById("errormsg").innerHTML="Please select a User Name to continue!!";
                return 0;
            }
        }
        
        const today = new Date();
        if($('#cmbtype').val()=='lhrs'){
            var enddate=new Date(today);
            var startdate=new Date(today);
            startdate=new Date(startdate.setDate(enddate.getDate()-1));
            $('#hidjqxStartDate').val($.jqx.dataFormat.formatdate(startdate, 'dd/MM/yyyy'));
            $('#hidjqxEndDate').val($.jqx.dataFormat.formatdate(enddate, 'dd/MM/yyyy'));
        } else if($('#cmbtype').val()=='ldays'){
            var enddate=new Date(today);
            var startdate=new Date(today);
            startdate=new Date(startdate.setDate(enddate.getDate()-7));
            $('#hidjqxStartDate').val($.jqx.dataFormat.formatdate(startdate, 'dd/MM/yyyy'));
            $('#hidjqxEndDate').val($.jqx.dataFormat.formatdate(enddate, 'dd/MM/yyyy'));
        } else if($('#cmbtype').val()=='l30d'){
            var enddate=new Date(today);
            var startdate=new Date(today);
            startdate=new Date(startdate.setDate(enddate.getDate()-30));
            $('#hidjqxStartDate').val($.jqx.dataFormat.formatdate(startdate, 'dd/MM/yyyy'));
            $('#hidjqxEndDate').val($.jqx.dataFormat.formatdate(enddate, 'dd/MM/yyyy'));
        } else{
            $('#hidjqxStartDate').val($.jqx.dataFormat.formatdate($("#jqxStartDate").jqxDateTimeInput('getDate'), 'dd/MM/yyyy'));
            $('#hidjqxEndDate').val($.jqx.dataFormat.formatdate($("#jqxEndDate").jqxDateTimeInput('getDate'), 'dd/MM/yyyy'));
        }
        
        document.getElementById("frmnewSATdownload").submit();
        document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
        setTimeout(function() {iscaptcha(); $("#btnGo").attr("disabled", true);}, 500000);
        moveProgressBar();
    }
    
    if (document.getElementById('radio_traffic').checked) {
        if(!(document.getElementById('chck_trafficautomatic').checked)) {
            if($('#txttrafficplateno').val()==''){
                document.getElementById("errormsg").innerHTML="Please select a Traffic File No";
                return false;
            }
        }
        
        document.getElementById("frmnewSATdownload").submit();
        document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
        setTimeout(function() {iscaptcha(); $("#btnGo").attr("disabled", true);}, 500000);
        moveProgressBar();
    }
}

function getFinalCount(){
    var itemtype="";
    if(document.getElementById("radio_salik").checked==true){ itemtype="Salik"; }
    else if(document.getElementById("radio_traffic").checked==true){ itemtype="Traffic"; }
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items=JSON.parse(items);
            var elm=document.getElementById("gwProgressBar");
            var width=(parseInt(items.itemcount)/parseInt(items.totalitemcount))*100;
            width=width.toFixed(2);
            
            elm.style.width=100+'%';
            document.getElementById("gwprogresstext").className="gw-text-green gw-animate-opacity";
            document.getElementById("gwprogresstext").innerHTML="Successfully Downloaded "+items.itemcount+" "+itemtype+"s!";
        }
    }
    x.open("GET",'getItemCount.jsp?itemtype='+itemtype+'&finalcount=1',true);
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

function moveProgressBar(){
    var elm=document.getElementById("gwProgressBar");
    var width=0;
    var interval=setInterval(function() {frame();}, 2000);
    function frame(){
        var itemtype="";
        if(document.getElementById("radio_salik").checked==true){ itemtype="Salik"; }
        else if(document.getElementById("radio_traffic").checked==true){ itemtype="Traffic"; }
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items= x.responseText;
                items=JSON.parse(items);
                if(width>=100){
                    clearInterval(interval);
                    document.getElementById("gwprogresstext").className="gw-text-green gw-animate-opacity";
                    document.getElementById("gwprogresstext").innerHTML="Successfully downloaded "+items.totalitemcount+" "+itemtype+"s!";
                } else{
                    width=(parseInt(items.itemcount)/parseInt(items.totalitemcount))*100;
                    width=width.toFixed(2);
                    elm.style.width=width+'%';
                    document.getElementById("itemcount").innerHTML=items.itemcount;
                    document.getElementById("itemtotalcount").innerHTML=items.totalitemcount;
                    document.getElementById("itemtype").innerHTML=itemtype;
                }
            }
        }
        x.open("GET",'getItemCount.jsp?itemtype='+itemtype,true);
        x.send();
    }
}

function funBlackPoints(){
    if(document.getElementById("chkblackpoints").checked==true){
        document.getElementById("hidchkblackpoints").value=1;
    } else{
        document.getElementById("hidchkblackpoints").value=0;
    }
}
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmnewSATdownload" action="newSATdownload" method="post" autocomplete="off">
<jsp:include page="../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div style="display: flex; gap: 15px;">
        
        <!-- ======================= SALIK PANEL ======================= -->
        <div class="middle-panel" id="salik-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">
                <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                    <input type="radio" id="radio_salik" name="category" value="salik" onchange="fundisable();">
                    Salik
                </label>
            </span>
            <input type="hidden" id="hiddencategory" name="hiddencategory" value='<s:property value="hiddencategory"/>'>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Site</label>
                <select id="cmbsaliksite" name="cmbsaliksite" style="width:125px;" value='<s:property value="cmbsaliksite"/>'>
                    <option value="DXB">DXB</option>
                    <option value="AUH">AUH</option>
                </select>
                <input type="hidden" id="hidcmbsaliksite" name="hidcmbsaliksite" value='<s:property value="hidcmbsaliksite"/>'/>
                
                <label style="margin-left:auto; display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                    <input type="checkbox" id="chck_salikautomatic" name="chck_salikautomatic" value="salikautomatic" onchange="fundisable();">
                    Automatic
                </label>
            </div>
            
            <div class="middle-panel" style="margin-top: 20px; background-color:#f9fbfc;">
                <span class="middle-panel-title" style="background-color:#f9fbfc;">Time & User</span>
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Time-Period</label>
                    <select id="cmbtype" name="cmbtype" style="flex:1;" value='<s:property value="cmbtype"/>' onchange="fundisable();">
                        <option value="lhrs">Last 24 Hours</option>
                        <option value="ldays">Last 7 Days</option>
                        <option value="l30d">Last 30 Days</option>
                        <option value="customdates">Custom Dates</option>
                    </select>
                    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/> 
                </div>
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Start Date</label>
                    <div style="width: 125px;">
                        <div id="jqxStartDate" name="jqxStartDate" value='<s:property value="jqxStartDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidjqxStartDate" name="hidjqxStartDate" value='<s:property value="hidjqxStartDate"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">End Date</label>
                    <div style="width: 125px;">
                        <div id="jqxEndDate" name="jqxEndDate" value='<s:property value="jqxEndDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidjqxEndDate" name="hidjqxEndDate" value='<s:property value="hidjqxEndDate"/>'/>
                </div>
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Username</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txtusername" name="txtusername" class="advanced-salik" placeholder="Press F3" value='<s:property value="txtusername"/>' onkeydown="getUname(event);" readonly />
                        <svg class="magnifier-icon" onclick="$('#txtusername').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Fleet No.</label>
                <div class="input-search-container" style="width: 125px;">
                    <input type="text" id="txtsalikfleetno" name="txtsalikfleetno" class="advanced-salik" placeholder="Press F3" value='<s:property value="txtsalikfleetno"/>' onkeydown="getvehinfo(event);" readonly />
                    <svg class="magnifier-icon" onclick="$('#txtsalikfleetno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Reg No.</label>
                <input type="text" id="txtxslregno" name="txtxslregno" class="advanced-salik" style="flex:1;" readonly value='<s:property value="txtxslregno"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Fleet Name</label>
                <input type="text" id="txtsalfleetnme" name="txtsalfleetnme" class="advanced-salik" style="flex:1;" readonly value='<s:property value="txtsalfleetnme"/>'/>
                
                <label class="lbl-right" style="width:80px;">Plate Code</label>
                <input type="text" id="txtsalplcode" name="txtsalplcode" class="advanced-salik" style="width:100px;" readonly value='<s:property value="txtsalplcode"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Salik Tag</label>
                <div class="input-search-container" style="width: 125px;">
                    <input type="text" id="txtsaliktagno" name="txtsaliktagno" class="advanced-salik" readonly onkeydown="getPlateNo(event);" value='<s:property value="txtsaliktagno"/>'/>
                    <svg class="magnifier-icon" onclick="$('#txtsaliktagno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <div style="margin-left:auto; display:flex; align-items:center; gap:8px;">
                    <input type="file" name="file" id="file" class="advanced-salik" style="width: 180px;">
                    <button type="button" id="btnfileupload" name="btnfileupload" class="myButton">Upload</button>
                </div>
            </div>
            
            <div class="middle-panel" style="margin-top: 15px; margin-bottom: 0;">
                <span class="middle-panel-title">Advanced Options</span>
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Start Pos</label>
                    <input type="text" name="salikcounter" id="salikcounter" class="advanced-salik" style="width:80px;" value='<s:property value="salikcounter"/>' onKeyPress="javascript:return isNumber (event,id)">
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Month</label>
                    <select id="cmbmonthname" name="cmbmonthname" class="advanced-salik" style="flex:1;">
                        <option value="">--Select--</option>
                        <option value="January">January</option><option value="February">February</option>
                        <option value="March">March</option><option value="April">April</option>
                        <option value="May">May</option><option value="June">June</option>
                        <option value="July">July</option><option value="August">August</option>
                        <option value="September">September</option><option value="October">October</option>
                        <option value="November">November</option><option value="December">December</option>
                    </select>
                    <input type="hidden" name="hidcmbmonthname" id="hidcmbmonthname">
                </div>
            </div>
            
        </div>

        <!-- ======================= TRAFFIC PANEL ======================= -->
        <div class="middle-panel" id="traffic-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">
                <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                    <input type="radio" id="radio_traffic" name="category" value="traffic" onchange="fundisable();">
                    Traffic
                </label>
            </span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Site</label>
                <select id="cmbtrafficsite" name="cmbtrafficsite" style="width:125px;" onchange="fundisable();" value='<s:property value="cmbtrafficsite"/>'>
                    <option value="AUH">AUH</option>
                    <option value="DXB">DXB</option>
                </select>
                <input type="hidden" id="hidcmbtrafficsite" name="hidcmbtrafficsite" value='<s:property value="hidcmbtrafficsite"/>'/> 
                
                <label style="margin-left:auto; display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                    <input type="checkbox" id="chck_trafficautomatic" name="chck_trafficautomatic" value="trafficautomatic" onchange="fundisable();">
                    Automatic
                </label>
            </div>
            
            <div class="middle-panel" style="margin-top: 20px;">
                <div class="field-row">
                    <label style="display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                        <input type="checkbox" id="chck_trafficfileno" name="chck_trafficfileno" value="trafficfileno" onchange="fundisable();">
                        File No.
                    </label>
                    <input type="hidden" name="hidchkblackpoints" id="hidchkblackpoints" value='<s:property value="hidchkblackpoints"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">File No.</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txttrafficplateno" name="txttrafficplateno" placeholder="Press F3" onkeydown="getFilename(event);" readonly value='<s:property value="txttrafficplateno"/>'/>
                        <svg class="magnifier-icon" onclick="$('#txttrafficplateno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                <div class="field-row" style="margin-bottom:0;">
                    <label style="display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                        <input type="checkbox" name="chkblackpoints" id="chkblackpoints" onchange="funBlackPoints();">
                        Black Pts
                    </label>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Year</label>
                    <select name="cmbyear" id="cmbyear" style="width:100px;">
                        <option value="">--Select--</option>
                    </select>
                </div>
            </div>

            <div class="middle-panel" style="margin-bottom:0; padding-top:25px;">
                <span class="middle-panel-title">
                    <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                        <input type="checkbox" id="chck_trafficpdata" name="chck_trafficpdata" value="trafficpdata" onchange="fundisable();">
                        Inquiry by plate data
                    </label>
                </span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Plate No.</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txttrafficpno" name="txttrafficpno" placeholder="Press F3" onkeydown="getPlateNo(event);" value='<s:property value="txttrafficpno"/>'/>
                        <svg class="magnifier-icon" onclick="getPlateNo({keyCode:114});" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Source</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txttrafficpsource" name="txttrafficpsource" placeholder="Press F3" onkeydown="getSource(event);" readonly value='<s:property value="txttrafficpsource"/>'/>
                        <svg class="magnifier-icon" onclick="$('#txttrafficpsource').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Plate Color</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txttrafficpcolor" name="txttrafficpcolor" placeholder="Press F3" onkeydown="getColor(event);" readonly value='<s:property value="txttrafficpcolor"/>'/>
                        <svg class="magnifier-icon" onclick="$('#txttrafficpcolor').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Plate Type</label>
                    <input type="text" id="txttrafficptype" name="txttrafficptype" style="flex:1;" readonly value='<s:property value="txttrafficptype"/>'/>
                </div>
            </div>
            
        </div>
    </div>
    
    <!-- PROGRESS AND ACTIONS -->
    <div class="middle-panel" style="margin-top: 15px;">
        <div class="gw-container" style="margin-bottom:15px;">
            <div class="gw-light-grey">
                <div id="gwProgressBar" class="gw-container gw-green" style="width:0%;"></div>
            </div>
            <p id="gwprogresstext" style="margin:0; font-family:Arial; font-size:12px;">Added <span id="itemcount" name="itemcount"><s:property value="itemcount"/></span> of <span id="itemtotalcount" name="itemtotalcount"><s:property value="itemtotalcount"/></span> <span id="itemtype" name="itemtotalcount"><s:property value="itemtype"/></span></p>	
        </div>
        
        <div class="field-row" style="justify-content:center; margin-bottom:15px;">
            <button class="myButton" type="button" id="btnGo" name="btnGo" onClick="getBrowser();" style="padding: 0 24px;">Download Now !!!</button>
        </div>
        
        <div id="loadcaptcha" style="display:flex; justify-content:center; margin-bottom:15px;"><jsp:include page="captcha.jsp"></jsp:include></div> 
        <div id="loadsalikdata"><jsp:include page="SATloadDetails.jsp"></jsp:include></div>
        <div id="loadtrafficdata"><jsp:include page="SATTrafficloadDetails.jsp"></jsp:include></div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="docs" name="docs" value='<s:property value="docs"/>'/>
        <input type="hidden" id="captcha" name="captcha" value='<s:property value="captcha"/>'/>
        <input type="hidden" id="captchacount" name="captchacount" value='<s:property value="captchacount"/>'/>
        <input type="hidden" id="iscaptcha" name="iscaptcha" value='<s:property value="iscaptcha"/>'/>
        <input type="hidden" id="iscaptchaloaded" name="iscaptchaloaded" value='<s:property value="iscaptchaloaded"/>'/>
        <input type="hidden" id="captchapath" name="captchapath" value='<s:property value="captchapath"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="txtsalikregno" name="txtsalikregno" value='<s:property value="txtsalikregno"/>'/>
        <input type="hidden" id="txttrafficpsourceid" name="txttrafficpsourceid" value='<s:property value="txttrafficpsourceid"/>'/>
        <input type="hidden" id="txttrafficpcolorid" name="txttrafficpcolorid" value='<s:property value="txttrafficpcolorid"/>'/>
        <input type="hidden" id="txttrafficptypeid" name="txttrafficptypeid" value='<s:property value="txttrafficptypeid"/>'/>
    </div>
    
</div>
</form>

<!-- External Windows -->
<div id="flash"></div>
<div id="display"></div>
<div id="unameWindow"><div></div><div></div></div>
<div id="filenameWindow"><div></div><div></div></div> 
<div id="sourceWindow"><div></div><div></div></div>
<div id="colorWindow"><div></div><div></div></div> 				 				
<div id="fleetWindow"><div></div><div></div></div>
<div id="vehinfowindow"><div></div><div></div></div>
<div id="platenoWindow"><div></div><div></div></div>				
<div class="modal"></div>
	
</div>
</body>
</html>