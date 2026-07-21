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
            background-color: #ffffff !important;
            color: #333;
            border-color: #e1e8ed;
            cursor: pointer;
        }

        input::placeholder {
            color: #9aa4b2;
            opacity: 1;
        }

        /* Fieldsets */
        fieldset {
            border: 1px solid #ccd6e0;
            border-radius: 6px;
            padding: 10px;
            margin-bottom: 12px;
            background: #fff;
        }

        fieldset.violetClass {
            border-color: #c7a4ff;
            background-color: #f7f0ff;
        }

        fieldset.redClass {
            border-color: #ffa1a1;
            background-color: #fff2f2;
        }

        legend {
            font-size: 12px;
            font-weight: bold;
            color: #4e5e71;
            padding: 0 5px;
            text-transform: uppercase;
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
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        /* Misc */
        #vehsparediv, #vehmaintenancediv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            background: #fff;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
            
            $("body").prepend('<div id="overlays" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWaits' style='display: none;position:absolute; z-index: 1002;top:150px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
            $("body").prepend('<div id="overlaym" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWaitm' style='display: none;position:absolute; z-index: 1002;top:400px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        
            // Uniform 24px date inputs
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
            
            $('#flnames').dblclick(function(){
                 vehicleSearchContent("vehicleSearch.jsp");
            });
            
            $('#vehicleToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Equipment Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
            $('#vehicleToWindow').jqxWindow('close');
             
            $('#client').dblclick(function(){
                 clientSearchContent("clientSearch.jsp");
            });
            
            $('#clientToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
            $('#clientToWindow').jqxWindow('close');
        });

        function funreload(event)
        {   
            if($('#fldocno').val()!="" || $('#cldocno').val()!=""){
                var fromdate=$('#fromdate').jqxDateTimeInput('val');
                var todate=$('#todate').jqxDateTimeInput('val');
                var docnos=$('#fldocno').val();
                var cldocno=$('#cldocno').val();
                
                $("#overlays, #PleaseWaits").show(); 
                $("#vehsparediv").load("spareGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&docno="+docnos+"&cldocno="+cldocno+"&id=1"); 
                
                $("#overlaym, #PleaseWaitm").show(); 
                $("#vehmaintenancediv").load("maintenanceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&docno="+docnos+"&cldocno="+cldocno+"&id=1");
            } else {
                $.messager.alert('Message','Client/Equipment is mandatory');
            }       
        }
            
        function setValues(){
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
             }
        }
            
        function funExportBtn(){
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            var fleetname=$('#flnames').val();
            
            JSONToCSVCon(spareexceldata, 'Spare Details of '+fleetname+' on '+fromdate+' to '+todate, true);
            JSONToCSVCon(maintenanceexceldata, 'Maintenance Details of '+fleetname+' on '+fromdate+' to '+todate, true);
        }
            
        function funPrintData() {
        }

        function funNotify(){
            return 1;
        }
            
        function funClearData(){
            $('input[type=text],[type=hidden]').val('');
            $('select').find('option').prop("selected", false);
            $('#fromdate').jqxDateTimeInput('setDate',new Date());
            $('#todate').jqxDateTimeInput('setDate',new Date());
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
            $('input[type=radio]').prop("checked",false);
            $('input[type=checkbox]').prop("checked",false);
            disablegrid();
        }
            
        function getVehicleDetails(event){
            var x= event.keyCode;
            if(x==114){
                vehicleSearchContent("vehicleSearch.jsp");
            }
        }

        function vehicleSearchContent(url) {
            $('#vehicleToWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#vehicleToWindow').jqxWindow('setContent', data);
            }); 
        }
            
        function getClientDetails(event){
            var x= event.keyCode;
            if(x==114){
                clientSearchContent("clientSearch.jsp");
            }
        }
        
        function clientSearchContent(url) {
            $('#clientToWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#clientToWindow').jqxWindow('setContent', data);
            }); 
        }

        function disablegrid(){
            $("#vehrepairGrid").jqxGrid('clear');
            $("#vehrepairGrid").jqxGrid({ disabled: true});
            $("#maintenanceGrid").jqxGrid('clear');
            $("#maintenanceGrid").jqxGrid({ disabled: true});
        }
        </script>
    </head>
    
    <body onload="setValues();getBranch();">
        <form id="frmWorkQuotationApproval" method="post" style="height: 100%;">
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
                                        <td class="label-cell">Equipment</td>
                                        <td>
                                            <input type="text" name="flnames" id="flnames" placeholder="Press F3 to Search" onkeydown="getVehicleDetails(event)" readonly="readonly">
                                            <input type="hidden" name="fldocno" id="fldocno">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Client</td>
                                        <td>
                                            <input type="text" name="client" id="client" placeholder="Press F3 to Search" onkeydown="getClientDetails(event)" readonly="readonly">
                                            <input type="hidden" name="cldocno" id="cldocno">
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
                                <input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            
                            <fieldset class="violetClass">
                                <legend>Spare Details</legend>
                                <div id="vehsparediv">
                                    <jsp:include page="spareGrid.jsp"></jsp:include>
                                </div>
                            </fieldset>
                            
                            <fieldset class="redClass">
                                <legend>Maintenance Details</legend>
                                <div id="vehmaintenancediv">
                                    <jsp:include page="maintenanceGrid.jsp"></jsp:include>
                                </div>
                            </fieldset> 
                            
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="vehicleToWindow"><div></div></div>
            <div id="clientToWindow"><div></div></div>
            
        </form>
    </body>
</html>