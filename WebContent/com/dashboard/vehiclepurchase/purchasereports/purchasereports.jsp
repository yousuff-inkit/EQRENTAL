<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
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

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="uptodate"] {
    width: 100%;
}

.radio-group {
    display: flex;
    gap: 10px;
    align-items: center;
    font-size: 12px;
    color: #333;
    padding: 2px 0;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
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

/* Action buttons layout */
.release-secondary-actions, .release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

.release-actions .btn-submit {
    min-width: 100px;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
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
	 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	
	 $('#fleetwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#fleetwindow').jqxWindow('close');
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	 $('#accountSearchwindow').jqxWindow('close');  
	 
	 $('#dealnowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Deal No Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#dealnowindow').jqxWindow('close');
	     
	 $('#fleetno').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
     });
	 
	 $('#dealno').dblclick(function(){
		  	    $('#dealnowindow').jqxWindow('open');
		  	  dealnoSearchContent('dealnoseach.jsp?', $('#dealnowindow')); 
	 });
		 
	 $('#txtaccid').dblclick(function(){
			  $('#accountSearchwindow').jqxWindow('open');
			 commenSearchContent('finaccountSearch.jsp?');
	 }); 
});


function  getdealNo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#dealnowindow').jqxWindow('open');
	  dealnoSearchContent('dealnoseach.jsp?');
     }
	 else{
	 }
}

function dealnoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 $('#dealnowindow').jqxWindow('open');
		$('#dealnowindow').jqxWindow('setContent', data);
	}); 
} 	
 
function  getAccTypeFrom(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#accountSearchwindow').jqxWindow('open');
	  commenSearchContent('finaccountSearch.jsp?');
     }
	 else{
	 }
}  

function commenSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 $('#accountSearchwindow').jqxWindow('open');
		$('#accountSearchwindow').jqxWindow('setContent', data);
	}); 
} 	

function funExportBtn(){
	 var fleetno = document.getElementById("fleetno").value;	
	 var type = document.getElementById("type").value;
	 
	 if(type=="summary" && fleetno=="")
	 {
		   $("#enqlistdiv").excelexportjs({  
	       		containerid: "enqlistdiv", 
	       		datatype: 'json', 
	       		dataset: null, 
	       		gridId: "vehicleAssetGrid", 
	       		columns: getColumns("vehicleAssetGrid") , 
	       		worksheetName:"Purchase Reports Summary"
	       		}); 
	 }
	    
	 if(fleetno!="")
	 {
		   $("#fleetdiv").excelexportjs({  
	       		containerid: "fleetdiv", 
	       		datatype: 'json', 
	       		dataset: null, 
	       		gridId: "fleeetgrid", 
	       		columns: getColumns("fleeetgrid") , 
	       		worksheetName:"Purchase Reports Detail"
	       		}); 
	 }
	    
	 if(type=="detail" && fleetno=="")
	 {
		   $("#detdivs").excelexportjs({  
	       		containerid: "detdivs", 
	       		datatype: 'json', 
	       		dataset: null, 
	       		gridId: "detailgeids", 
	       		columns: getColumns("detailgeids") , 
	       		worksheetName:"Purchase Reports Detail"
	       		}); 
	 }
}

function fleetSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);
	}); 
} 

function getfleetdata(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');
	  fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));     
	 }
	 else{
	 }
}

function funreload(event)
{
	var uptodate = $('#uptodate').val();
	var barchval = document.getElementById("cmbbranch").value;
	var fleetno = document.getElementById("fleetno").value;	
	var type = document.getElementById("type").value;
	var findoc = document.getElementById("txtdocno").value;	
	var dealnos = document.getElementById("dealno").value;
	var dealno = dealnos.replace(/ /g, "%20");
			 
	if(type=="summary" && fleetno=="")
	{
        var aa="chk";
	    $("#overlay, #PleaseWait").show();
	    $("#enqlistdiv").load("Gridfirst.jsp?barchval="+barchval+"&type="+type+"&val="+aa+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate);
	}
	
	if(fleetno!="")
	{
		$("#overlay, #PleaseWait").show();  
		var aa="fleet";
		$("#fleetdiv").load("fleetcalugrid.jsp?barchvals="+barchval+"&vals="+aa+"&fleetno="+fleetno+"&type="+type+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate);
	}
		   
	if(type=="detail" && fleetno=="")
	{
		$("#overlay, #PleaseWait").show();  
		var aa="fleets";
		$("#detdivs").load("detailgrid.jsp?barchval="+barchval+"&type="+type+"&val="+aa+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate);
	}
}

function changegrid()
{
	 var type = document.getElementById("type").value;
	if(type=="summary")
	{
		  $("#fleetdiv").hide();
		  $("#enqlistdiv").show(); 
		  $("#detdivs").hide(); 
		  
		  $("#detailgeids").jqxGrid('clear');
	      $("#detailgeids").jqxGrid('addrow', null, {});
	      
		  $("#fleeetgrid").jqxGrid('clear');
	      $("#fleeetgrid").jqxGrid('addrow', null, {});
	      
	      $("#vehicleAssetGrid").jqxGrid('clear');
	      $("#vehicleAssetGrid").jqxGrid('addrow', null, {});
	      
	      document.getElementById("fleetno").value="";
	 	  $('#fleetno').attr('placeholder', 'Press F3 TO Search'); 
	}
	else
	{
		  $("#fleetdiv").hide();
		  $("#enqlistdiv").hide(); 
		  $("#detdivs").show(); 
		  
		  $("#detailgeids").jqxGrid('clear');
	      $("#detailgeids").jqxGrid('addrow', null, {});
	      
		  $("#fleeetgrid").jqxGrid('clear');
	      $("#fleeetgrid").jqxGrid('addrow', null, {});
	      
	      $("#vehicleAssetGrid").jqxGrid('clear');
	      $("#vehicleAssetGrid").jqxGrid('addrow', null, {});
		  document.getElementById("fleetno").value="";
		  $('#fleetno').attr('placeholder', 'Press F3 TO Search'); 
	}
}

function funcleardata()
{
	  $("#fleetdiv").hide();
	  $("#enqlistdiv").show(); 
	  $("#detdivs").hide(); 
	  
	  $('#uptodate').val(new Date());
	  
	  $("#detailgeids").jqxGrid('clear');
      $("#detailgeids").jqxGrid('addrow', null, {});
      
	  $("#fleeetgrid").jqxGrid('clear');
      $("#fleeetgrid").jqxGrid('addrow', null, {});
      
      $("#vehicleAssetGrid").jqxGrid('clear');
      $("#vehicleAssetGrid").jqxGrid('addrow', null, {});
	  document.getElementById("fleetno").value="";
	
	  document.getElementById("type").value="summary";
	
	  document.getElementById("dealno").value="";
	  document.getElementById("txtaccid").value="";
	  document.getElementById("txtaccname").value="";
	  document.getElementById("txtdocno").value="";
	
	  $('#fleetno').attr('placeholder', 'Press F3 TO Search'); 
	  $('#txtaccid').attr('placeholder', 'Press F3 TO Search'); 
	  $('#dealno').attr('placeholder', 'Press F3 TO Search'); 
}

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
	 var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	    var CSV = '';    
	    CSV += ReportTitle + '\r\n\n';

	    if (ShowLabel) {
	        var row = "";
	        for (var index in arrData[0]) {
	            row += index + ',';
	        }
	        row = row.slice(0, -1);
	        CSV += row + '\r\n';
	    }
	    
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }
	        row.slice(0, row.length - 1);
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    var fileName = "";
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    var temp = CSV;
	    blob = new Blob([temp],{type: 'text/csv'});
	    var bigcsv= window.webkitURL.createObjectURL(blob);
	   
	    var link = document.createElement("a");    
	    link.href = bigcsv;
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="type" onchange="changegrid()">
                                    <option value="summary">Summary</option>
                                    <option value="detail">Detail</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text" id="fleetno" name="fleetno" readonly="readonly" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" value='<s:property value="fleetno"/>' onkeydown="getfleetdata(event);" >
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Deal No</td>
                            <td>
                                <input type="text" id="dealno" name="dealno" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="dealno"/>' onkeydown="getdealNo(event);" >
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" name="clear" id="clear" onclick="funcleardata()">Clear</button>
                    </div>

                    <!-- Hidden fields & Placeholder DIV -->
                    <input type="hidden" id="cldocno" name="cldocno">
                    <div id='paychaaaaa' style="width: 100%; height: 150px;"></div>
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="enqlistdiv"><jsp:include page="Gridfirst.jsp"></jsp:include></div>
                <div id="fleetdiv" hidden="true"><jsp:include page="fleetcalugrid.jsp"></jsp:include></div>
                <div id="detdivs" hidden="true"><jsp:include page="detailgrid.jsp"></jsp:include></div> 
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="fleetwindow">
       <div></div>
    </div> 
    <div id="accountSearchwindow">
       <div></div>
    </div>
    <div id="dealnowindow">
       <div></div>
    </div>
 
</div>
</body>
</html>