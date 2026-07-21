<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="com.dashboard.analysis.utilization.*" %>
<%ClsVehUtilizationDAO utilizedao=new ClsVehUtilizationDAO(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

form {
    height: 100%;
    width: 100%;
    margin: 0;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.release-filter-table input[type="text"],
.release-filter-table select {
    width: 100%;
    height: 24px;             
    padding: 2px 8px;         
    border: 1px solid #ccd6e0;
    border-radius: 4px;       
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

/* Textarea styling */
.search-textarea {
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    padding: 6px;
    font-size: 11px;
    background-color: #f3f6f9;
    resize: none;
    margin-top: 10px;
    font-family: 'Segoe UI', Tahoma, sans-serif;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled,
select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100%;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    font-size: 12px;
    color: #333;
    padding: 5px 0 10px 0;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-weight: 600;
}
.radio-group input[type="radio"] {
    margin-right: 4px;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

.release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

/* Inline action flex */
.inline-action-row {
    display: flex;
    gap: 5px;
}
.inline-action-row select {
    flex: 1;
}
.btn-icon {
    width: 30px;
    height: 24px;
    line-height: 24px;
    padding: 0;
    text-align: center;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vehdetaildiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 $('#brandwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#yomwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#yomwindow').jqxWindow('close');
	   
	 
	   $('#fleetwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
});

function getFleet(){

	 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		fleetSearchContent('fleetSearch.jsp?id=1', $('#fleetwindow'));
	
}

function getBrand(){
	 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));

}


function getModel(){
	
	 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 modelSearchContent('modelSearch.jsp?id=1', $('#brandwindow'));

}

function getGroup(event){

	$('#groupwindow').jqxWindow('open');
	$('#groupwindow').jqxWindow('focus');
	 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
	 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));

}
function getYom(event){

	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}


function brandSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#brandwindow').jqxWindow('setContent', data);

}); 
}

function modelSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#modelwindow').jqxWindow('setContent', data);

}); 
}

function groupSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#groupwindow').jqxWindow('setContent', data);

}); 
}

function yomSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#yomwindow').jqxWindow('setContent', data);

}); 
}

function fleetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	     var hidbrand=document.getElementById("hidbrand").value;
	     var hidmodel=document.getElementById("hidmodel").value;
	     var hidgroup=document.getElementById("hidgroup").value;
	     var hidyom=document.getElementById("hidyom").value;
	     var grpby1=document.getElementById("grpby1").value;
		 var hidfleet=document.getElementById("hidfleet").value;
	     var hidduration;
	     if(document.getElementById("rdohours").checked==true){
		  hidduration="hours";
	  }
	     else if(document.getElementById("rdodays").checked==true){
	    	 hidduration="days";
	     }
	    	
	     $("#overlay, #PleaseWait").show();
	    $("#vehutilizediv").load("vehUtilizeGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&fleet="+hidfleet+"&id=1&duration="+hidduration+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom);   	 
	
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	document.getElementById("rdohours").checked=true;
	
		 
	}
	function funExportBtn(){
		 /* $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization'); */
			 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(utilizedataexcel, 'Vehicle Utilization', true);
		  }
		 else
		  {
			 $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization');
		  }
		
	}

	
	function funClearData(){
		$('input[type=text],[type=hidden], textarea').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		   
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    $('input:checkbox').removeAttr('checked');
	    $('input[type=radio]').prop("checked", false);
	    document.getElementById("rdohours").checked=true;
	    $('#cmbbranch').val('a');
	}
	function setSearch(){
		var value=$('#searchby').val().trim();
		
		if(value=="brand"){
			getBrand();
		}
		else if(value=="model"){
			getModel();
		}
		else if(value=="group"){
			getGroup();
		}
		else if(value=="yom"){
			getYom();
		}
		else if(value=="fleet"){
			getFleet();
		}
		else{
			
		}



	}
	
	
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		 if(value=="brand"){
			document.getElementById("searchdetails").value="";
			document.getElementById("brand").value="";
			document.getElementById("hidbrand").value="";
			document.getElementById("searchdetails").value=document.getElementById("model").value;	
		
					if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="model"){
			document.getElementById("searchdetails").value="";
			document.getElementById("model").value="";
			document.getElementById("hidmodel").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="group"){
			document.getElementById("searchdetails").value="";
			document.getElementById("group").value="";
			document.getElementById("hidgroup").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
		
		
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="yom"){
			document.getElementById("searchdetails").value="";
			document.getElementById("yom").value="";
			document.getElementById("hidyom").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="fleet"){
			document.getElementById("searchdetails").value="";
			document.getElementById("fleet").value="";
			document.getElementById("hidfleet").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
	}
	function setDetail(){
		if(document.getElementById("chkdetail").checked==true){
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','transfer','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','delivery','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','others','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','custody','hidden',false);
		}
		else if(document.getElementById("chkdetail").checked==false){
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','transfer','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','delivery','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','others','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','custody','hidden',true);
		}
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" method="post" style="height: 100%;">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">

                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">From Date</td>
                                <td><div id="fromdate"></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To Date</td>
                                <td><div id="todate"></div></td>
                            </tr>
                        </table>

                        <div class="radio-group">
                            <label for="rdohours">
                                <input type="radio" name="duration" id="rdohours" value="days">
                                Hours
                            </label>
                            <label for="rdodays">
                                <input type="radio" name="duration" id="rdodays" value="days">
                                Days
                            </label>
                        </div>

                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">Grouping 1</td>
                                <td>
                                    <select name="grpby1" id="grpby1">
                                        <option value="">--Select--</option>
                                        <option value="brand">Brand</option>
                                        <option value="model">Model</option>
                                        <option value="group">Group</option>
                                        <option value="yom">YOM</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Search By</td>
                                <td>
                                    <div class="inline-action-row">
                                        <select name="searchby" id="searchby">
                                            <option value="">--Select--</option>
                                            <option value="brand">Brand</option>
                                            <option value="model">Model</option>
                                            <option value="group">Group</option>
                                            <option value="yom">YOM</option>
                                            <option value="fleet">Fleet</option>
                                        </select>
                                        <button type="button" name="btnadditem" id="additem" class="btn-submit btn-icon" onClick="setSearch();">+</button>
                                        <button type="button" name="btnremoveitem" id="btnremoveitem" class="btn-submit btn-icon" onclick="setRemove();">-</button>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <textarea id="searchdetails" name="searchdetails" rows="8" readonly class="search-textarea"></textarea>

                        <div class="release-actions">
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div id="vehutilizediv"> <jsp:include page="vehUtilizeGrid.jsp"></jsp:include> </div>       
                    
                    <!-- Hidden fields for submission -->
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" name="hidgroup" id="hidgroup">
                    <input type="hidden" name="hidmodel" id="hidmodel">
                    <input type="hidden" name="hidyom" id="hidyom">
                    <input type="hidden" name="hidbrand" id="hidbrand">
                    <input type="hidden" name="group" id="group">
                    <input type="hidden" name="model" id="model">
                    <input type="hidden" name="yom" id="yom">
                    <input type="hidden" name="brand" id="brand">
                    <input type="hidden" name="hidfleet" id="hidfleet">
                    <input type="hidden" name="fleet" id="fleet">
                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="fleetwindow">
            <div><img id="loadingImageFleet" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
        </div>
        <div id="brandwindow">
            <div><img id="loadingImageBrand" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
        </div>
        <div id="modelwindow">
            <div><img id="loadingImageModel" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
        </div>
        <div id="groupwindow">
            <div><img id="loadingImageGroup" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
        </div>
        <div id="yomwindow">
            <div><img id="loadingImageYom" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
        </div>

    </div>
</form>
</body>
</html>