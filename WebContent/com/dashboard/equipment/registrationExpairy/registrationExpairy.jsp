<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GatewayERP(i)</title>
        
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
        .filter-table {
            width: 100%;
            border-spacing: 0 10px;
        }

        .filter-table .label-cell {
            text-align: right;
            padding-right: 10px;
            font-size: 12px;
            color: #4e5e71;
            font-weight: 600;
            width: 80px;
        }

        /* ===== UNIFORM 24px INPUTS & SELECTS ===== */
        input[type="text"], select, textarea,
        .filter-table input[type="text"],
        .filter-table select {
            width: 100%;
            height: 24px;              
            padding: 2px 8px;         
            border: 1px solid #ccd6e0;
            border-radius: 4px;        
            font-size: 12px;          
            background-color: #ffffff;
            box-sizing: border-box;
            color: #333;
            outline: none;
        }

        /* Readonly / disabled look */
        input[readonly],
        input:disabled,
        .filter-table input[readonly],
        .filter-table input:disabled {
            background-color: #f3f6f9 !important;
            color: #555;
            border-color: #e1e8ed;
            cursor: pointer;
        }

        input::placeholder {
            color: #9aa4b2;
            opacity: 1;
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
            background: #fff;
            display: flex;
            flex-direction: column;
        }

        /* Misc */
        .grid-wrapper {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        #pieChart1 {
            border-radius: 8px;
            overflow: hidden;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:600px;'><img src='../../../../icons/31load.gif'/></div>");    

            // Uniform 24px date inputs
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#regexpdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
            var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
            
            $('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#clientwindow').jqxWindow('close'); 
            
            $('#client').dblclick(function(){
                $('#clientwindow').jqxWindow('open');
                $('#clientwindow').jqxWindow('focus');
                clientSearchContent('clientMasterSearch.jsp', $('#clientwindow'));
            });
        });

        function getClient(event){
            var x= event.keyCode;
            if(x==114){
                $('#clientwindow').jqxWindow('open');
                $('#clientwindow').jqxWindow('focus');
                clientSearchContent('clientMasterSearch.jsp', $('#clientwindow'));
           }
        }
        
        function clientSearchContent(url) {
            $.get(url).done(function (data) {
                $('#clientwindow').jqxWindow('setContent', data);
            }); 
        }

        function funreload(event) {
             var barchval = document.getElementById("cmbbranch").value;
             var exdate = $('#regexpdate').val();
             var fromdate = $('#fromdate').jqxDateTimeInput('val');
             var cldocno = $('#cldocno').val();
             
             $("#overlay, #PleaseWait").show(); 
             $("#explistdiv").load("registrationExpairyGrid.jsp?barchval="+barchval+'&exdate='+exdate+'&fromdate='+fromdate+'&id=1&cldocno='+cldocno, function() {
                 $("#overlay, #PleaseWait").hide();
             });
        }
            
        function changeAttachContent(url) {
            $.get(url).done(function (data) {
                $('#windowattach').jqxWindow('open');
                $('#windowattach').jqxWindow('setContent',data);
                $('#windowattach').jqxWindow('bringToFront');
            }); 
        }

        function funExportBtn(){
            $("#explistdiv").excelexportjs({     
                containerid: "explistdiv", 
                datatype: 'json', 
                dataset: null, 
                gridId: "regexpgrid",            
                columns: getColumns("regexpgrid") , 
                worksheetName:"Registration Expiry"     
            }); 
        }
        </script>
    </head>
    
    <body onload="getBranch();">
        <form id="frmRegExpList" style="height: 100%;">
            <div id="mainBG" class="homeContent"> 

                <div class="master-container">

                    <!-- ================= LEFT SIDEBAR ================= -->
                    <div class="sidebar-filters">
                        
                        <div class="sidebar-scroll-content">
                            
                            <!-- Date Range Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">From</td>
                                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To</td>
                                        <td><div id="regexpdate" name="regexpdate" value='<s:property value="regexpdate"/>'></div></td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Client Filter Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Client</td>
                                        <td>
                                            <input type="text" name="client" id="client" placeholder="Press F3 to Search" onkeydown="getClient(event);">
                                            <input type="hidden" name="cldocno" id="cldocno">
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                            <!-- Pie Chart Card -->
                            <div class="filter-card" style="padding: 10px;">
                                <div id='pieChart1' style="width: 100%; height: 170px;"></div>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="explistdiv" class="grid-wrapper">
                                <jsp:include page="registrationExpairyGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
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

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;
    padding: 2px 8px !important;
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="regexpdate"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit, .myButton {
    height: 30px !important;
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
    margin-top: 10px;
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-wrapper {
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

.scrollable-grid-area {
    flex: 1;
    padding: 15px 20px;
    overflow: auto;
    box-sizing: border-box;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#regexpdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	$("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	$('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close'); 
	$('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
	 	clientSearchContent('clientMasterSearch.jsp', $('#clientwindow'));
	});
});

function getClient(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('focus');
 		clientSearchContent('clientMasterSearch.jsp', $('#clientwindow'));
   }
   else{
   }
}
function clientSearchContent(url) {
	$.get(url).done(function (data) {
   		$('#clientwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var exdate = $('#regexpdate').val();
	 var fromdate = $('#fromdate').jqxDateTimeInput('val');
	 var cldocno=$('#cldocno').val();
	 $("#overlay, #PleaseWait").show(); 
	 $("#explistdiv").load("registrationExpairyGrid.jsp?barchval="+barchval+'&exdate='+exdate+'&fromdate='+fromdate+'&id=1&cldocno='+cldocno);
}
	
function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
		  
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}

function funExportBtn(){
	$("#clientwindow").excelexportjs({      
   		containerid: "clientwindow", 
   		datatype: 'json', 
   		dataset: null, 
   		gridId: "regexpgrid",            
   		columns: getColumns("regexpgrid") , 
   		worksheetName:"Registration Expiry"     
   		}); 
	   
	   
	   /*if(parseInt(window.parent.chkexportdata.value)=="1")
		 {
		 JSONToCSVCon(expdata, 'Registration Expiry', true);
		 }
	 else
		 {
		 $("#regexpgrid").jqxGrid('exportdata', 'xls', 'Registration Expiry');
		 }*/
		   
	   
	   
	   
	 }


</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

	<div class="sidebar-filters">
		<div class="sidebar-scroll-content">

			<div class="filter-card">
				<table class="filter-table">
					<tr>
						<td class="label-cell">From</td>
						<td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
					</tr>
					<tr>
						<td class="label-cell">To</td>
						<td><div id="regexpdate" name="regexpdate" value='<s:property value="regexpdate"/>'></div></td>
					</tr>
					<tr>
						<td class="label-cell">Client</td>
						<td><input type="text" name="client" id="client" placeholder="Press F3 to Search" onkeydown="getClient(event);"></td>
					</tr>
				</table>
			</div>

			<div class="filter-card">
				<div id='pieChart1' style="width: 100%; height: 170px;"></div>
			</div>

		</div>
	</div>

	<div class="main-content-wrapper">
		<div class="top-toolbar-container">
			<jsp:include page="../../heading.jsp"></jsp:include>
		</div>
		<div class="scrollable-grid-area">
			<div id="explistdiv"><jsp:include page="registrationExpairyGrid.jsp"></jsp:include></div>
		</div>
	</div>

</div>

<!-- Hidden Inputs Maintained Outside Layout Flow -->
<div style="display:none;">
	<input type="hidden" name="cldocno" id="cldocno">
</div>

</div>
<div id="clientwindow"><div></div></div>
</div>
</body>
</html>
