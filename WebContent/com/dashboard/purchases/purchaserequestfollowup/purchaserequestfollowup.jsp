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

/* ===== UNIFORM INPUTS & SELECTS ===== */
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
.release-filter-table div[id^="date"] {
    width: 100% !important;
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
    display: flex;
    flex-direction: column;
    gap: 15px; /* Added spacing between stacked grids */
}
</style>

<script type="text/javascript">

$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

    $('#Searchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#Searchwindow').jqxWindow('close');

    $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 
    $('#docnosss').dblclick(function(){
        $('#Searchwindow').jqxWindow('open');
        SearchContent('mainsearch.jsp?');
    });  
});
 
function funcleardata()
{
	document.getElementById("reqdocno").value="";
	document.getElementById("docnosss").value="";
    $('#docnosss').attr('placeholder', 'Press F3 TO Search'); 
}
	  
function getdetails(event){
    var x= event.keyCode;
    if(x==114){
        $('#Searchwindow').jqxWindow('open');
        SearchContent('mainsearch.jsp?');    
    }
    else{
    }
}  

function SearchContent(url) {
    $.get(url).done(function (data) {
        $('#Searchwindow').jqxWindow('setContent', data);
	}); 
}
 
function funExportBtn(){
	JSONToCSVCon(datasex,'Purchase Request Followup Mater', true);
	JSONToCSVCon(datas11ex,'Purchase Request Followup Details', true);
}
 
function funreload(event)
{
    disitems(0);
    var barchval = document.getElementById("cmbbranch").value;
    var fromdate="";
    var todate="";
    var statusselect="";
    var reqdocno=$("#reqdocno").val();

    $("#ordersubgrid").jqxGrid('clear');
    $("#duedetailsgrid").jqxGrid('clear');
    $("#overlay, #PleaseWait").show();
    $("#listdiv").load("mainGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&reqdocno="+reqdocno);
}

function getinfo() {
    var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send(); 
}
 
function funupdate()
{
	var docno = document.getElementById("masterdocno").value;
	var branchids = document.getElementById("brhid").value;
	var remarks = document.getElementById("remarks").value;
	var cmbinfo = document.getElementById("cmbinfo").value;
	var folldate =$('#date').val();
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
        {
            var items=x.responseText;
            if(parseInt(items)>0)
            {
                $.messager.alert('Message', ' Successfully Updated');
                funreload(event);
                disitems(0);
            }
            else
            {
                $.messager.alert('Message', ' Not Updated '); 
            }
        }
	}
    x.open("GET","savedata.jsp?docno="+docno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate,true);
    x.send();
}

function disitems(val)
{
    if(val=="1")
    {
        $('#cmbinfo').attr("disabled",false);
        $('#remarks').attr("disabled",false);
        $('#remarks').attr("readonly",false);
        $('#Update').attr("disabled",false);
        
        document.getElementById("remarks").value="";
        
        $('#date').val(new Date());
        $('#date').jqxDateTimeInput({ disabled: false});
    }
    else
    {
        $('#cmbinfo').attr("disabled",true);
        $('#remarks').attr("disabled",true);
        $('#remarks').attr("readonly",true);
        $('#Update').attr("disabled",true);
        
        document.getElementById("remarks").value="";

        $('#date').val(new Date());
        $('#date').jqxDateTimeInput({ disabled: true});
    }
}
</script>
</head>
<body onload="getBranch();getinfo();disitems(0);">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <!-- Primary Search Filter -->
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Doc No</td>
                            <td>
                                <input type="text" name="docnosss" id="docnosss" value='<s:property value="docnosss"/>' readonly="readonly" placeholder="Press F3 To Search" onKeyDown="getdetails(event);" >
                            </td>
                        </tr>
                    </table>
                    <div class="release-actions">
                        <button type="button" class="btn-submit" name="clear" id="clear" onclick="funcleardata()">Clear</button>
                    </div>
                </div>

                <!-- Update Process Filter -->
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Process</td>
                            <td>
                                <select name="cmbinfo" id="cmbinfo" value='<s:property value="cmbinfo"/>'></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Date</td>
                            <td><div id='date' name='date' value='<s:property value="date"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td>
                                <input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'>
                            </td>
                        </tr>
                    </table>
                    <div class="release-actions">
                        <button type="button" name="Update" id="Update" class="btn-submit" onclick="funupdate()">Update</button>
                    </div>
                </div>

                <!-- Hidden Fields & Spacer -->
                <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
                <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>
                <input type="hidden" id="reqdocno" name="reqdocno" value='<s:property value="reqdocno"/>'>
                <input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>
                
                <div id='paychaaaaa' style="width: 100%; height:90px;"></div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="listdiv"><jsp:include page="mainGrid.jsp"></jsp:include></div>
                <div id="listdiv1"><jsp:include page="subGrid.jsp"></jsp:include></div>
                <div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="locationwindow">
        <div></div>
    </div>
    <div id="Searchwindow">
        <div></div>
    </div> 

</div>
</body>
</html>