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
            text-align: center;
        }

        .btn-submit:hover {
            background: #1d4ed8;
        }

        .btn-clear {
            background: #64748b !important;
        }
        
        .btn-clear:hover {
            background: #475569 !important;
        }

        .btn-submit:disabled {
            background: #9ca3af !important;
            cursor: not-allowed;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center;
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
        }

        /* Misc */
        #nrmdiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            height: 100%;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             document.getElementById("branchlabel").style.display="none";
             document.getElementById("branchdiv").style.display="none";
             
             $("#btnExcel").click(function() {
                 JSONToCSVCon(nrmexceldata, 'Movement List', true);
             });
             
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:210px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
             
             $('#fleetwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#fleetwindow').jqxWindow('close');
             
             $('#employeewindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Employee Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#employeewindow').jqxWindow('close');
             
             $('#garagewindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Garage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#garagewindow').jqxWindow('close');
             
             // Uniform 24px date inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             
             var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
             var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
             $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
            
             $('#fleet').dblclick(function(){
                  $('#fleetwindow').jqxWindow('open');
                  $('#fleetwindow').jqxWindow('focus');
                  fleetSearchContent('masterFleetSearch.jsp');
             });
             
             $('#employee').dblclick(function(){
                 if(document.getElementById("cmbemptype").value==""){
                     $.messager.alert('Warning','Please Select Employee Type');
                     return false;
                 }
                 $('#employeewindow').jqxWindow('open');
                 $('#employeewindow').jqxWindow('focus');
                 employeeSearchContent('employeeSearch.jsp?emptype='+document.getElementById("cmbemptype").value);
             });
             
             $('#garage').dblclick(function(){
                  $('#garagewindow').jqxWindow('open');
                  $('#garagewindow').jqxWindow('focus');
                  garageSearchContent('garageSearch.jsp');
             });
        });

        function getFleet(event){
            var x= event.keyCode;
            if(x==114){
                 $('#fleetwindow').jqxWindow('open');
                 $('#fleetwindow').jqxWindow('focus');
                 fleetSearchContent('masterFleetSearch.jsp');             
            }
        }
        
        function getEmployee(event){
            if(document.getElementById("cmbemptype").value==""){
                $.messager.alert('Warning','Please Select Employee Type');
                return false;
            }
            var x= event.keyCode;
            if(x==114){
                 $('#employeewindow').jqxWindow('open');
                 $('#employeewindow').jqxWindow('focus');
                 employeeSearchContent('employeeSearch.jsp?emptype='+document.getElementById("cmbemptype").value);               
            }
        }

        function getGarage(event){
            var x= event.keyCode;
            if(x==114){
                 $('#garagewindow').jqxWindow('open');
                 $('#garagewindow').jqxWindow('focus');
                 garageSearchContent('garageSearch.jsp');             
            }
        }

        function fleetSearchContent(url) {
            $.get(url).done(function (data) {
                $('#fleetwindow').jqxWindow('setContent', data);
            }); 
        }
        
        function employeeSearchContent(url) {
           $.get(url).done(function (data) {
                $('#employeewindow').jqxWindow('setContent', data);
            }); 
        }
        
        function garageSearchContent(url) {
            $.get(url).done(function (data) {
                $('#garagewindow').jqxWindow('setContent', data);
            }); 
        }
        
        function funreload(event)
        {
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            
            $("#overlay, #PleaseWait").show();
            
            var fleet=document.getElementById("fleet").value;
            var movtype=document.getElementById("cmbtype").value;
            var emptype=document.getElementById("cmbemptype").value;
            var employee=document.getElementById("hidemployee").value;
            var garage=document.getElementById("hidgarage").value;
            var status=document.getElementById("cmbstatus").value;
            
            $("#nrmdiv").load("nrmListGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&fleet="+fleet+"&movtype="+movtype+"&emptype="+emptype+"&employee="+employee+"&garage="+garage+"&status="+status+"&id=1");
        }
            
        function getCmbtype(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('***');
                    
                    var typeIdItems  = items[1].split(",");
                    var typeItems = items[0].split(",");
                    var optionsbranch = '<option value="">--Select--</option>';
                    for (var i = 0; i < typeItems.length;i++){
                        optionsbranch += '<option value="' + typeIdItems[i]+ '">'
                                + typeItems[i] + '</option>';
                    }
                    $("select#cmbtype").html(optionsbranch);
                }
            }
            x.open("GET","getCmbtype.jsp", true);
            x.send();
        }

        function setValues(){
             if($('#msg').val()!=""){
                 $.messager.alert('Message',$('#msg').val());
              }
            getCmbtype();
        }
        
        function funExportBtn(){
        }
            
        function funClearData(){
            $('input[type=text],[type=hidden]').val('');
            $('select').find('option').prop("selected", false);
            $('#fromdate').jqxDateTimeInput('setDate',new Date());
            $('#todate').jqxDateTimeInput('setDate',new Date());
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
        }
        </script>
    </head>
    
    <body onload="setValues();">
        <form id="frmNrmList" method="post" style="height: 100%;">
            <div id="mainBG" class="homeContent"> 

                <div class="master-container">

                    <!-- ================= LEFT SIDEBAR ================= -->
                    <div class="sidebar-filters">
                        
                        <div class="sidebar-scroll-content">
                            
                            <!-- Search Filters Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">From Date</td>
                                        <td><div id="fromdate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To Date</td>
                                        <td><div id="todate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Fleet</td>
                                        <td>
                                            <input type="text" name="fleet" id="fleet" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getFleet(event);">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Type</td>
                                        <td>
                                            <select name="cmbtype" id="cmbtype">
                                                <option value="">--Select--</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Emp Type</td>
                                        <td>
                                            <select name="cmbemptype" id="cmbemptype">
                                                <option value="">--Select--</option>
                                                <option value="stf">Staff</option>
                                                <option value="drv">Driver</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Employee</td>
                                        <td>
                                            <input type="text" name="employee" id="employee" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getEmployee(event);">
                                            <input type="hidden" name="hidemployee" id="hidemployee">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Garage</td>
                                        <td>
                                            <input type="text" name="garage" id="garage" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getGarage(event);">
                                            <input type="hidden" name="hidgarage" id="hidgarage">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Mov Status</td>
                                        <td>
                                            <select name="cmbstatus" id="cmbstatus">
                                                <option value="">--Select--</option>
                                                <option value="0">Open</option>
                                                <option value="1">Closed</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                
                                <div class="action-buttons">
                                    <button type="button" name="btnclear" id="btnclear" class="btn-submit btn-clear" onclick="funClearData();">Clear</button>
                                </div>
                            </div>

                            <!-- Hidden Data -->
                            <div style="display:none;">
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="nrmdiv">
                                <jsp:include page="nrmListGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="fleetwindow"><div></div></div>
            <div id="employeewindow"><div></div></div>
            <div id="garagewindow"><div></div></div>
            
        </form>
    </body>
