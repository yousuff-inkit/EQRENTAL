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

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center;
        }
        
        .clear-icon-btn {
            border: none;
            background: transparent;
            cursor: pointer;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .clear-icon-btn img {
            width: 16px;
            height: 16px;
            opacity: 0.7;
            transition: opacity 0.2s;
        }

        .clear-icon-btn:hover img {
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
        }

        /* Misc */
        #Readygrid, #posgrid, #fleetdiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
                
             $('#ticketnowindow').jqxWindow({ width: '38%', height: '48%',  maxHeight: '48%' ,maxWidth: '38%' , title: 'Ticket Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
             $('#ticketnowindow').jqxWindow('close');  
             
             $('#regnowindow').jqxWindow({ width: '38%', height: '48%',  maxHeight: '48%' ,maxWidth: '38%' , title: 'Reg No. Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
             $('#regnowindow').jqxWindow('close');
             
             $("#cmbbranch").attr('hidden',true); 
             
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
             
             var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
             var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
            
             $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
             
             $('#todate').on('change', function (event) {
                   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
                   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
                  
                   if(fromdates>todates){
                       $.messager.alert('Message','To Date Less Than From Date  ','warning');   
                       return false;
                  }    
             });
            
             $('#ticketno').dblclick(function(){
                 ticketSearchContent('ticketSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')); 
            });
            
             $('#regno').dblclick(function(){
                 regnoSearchContent('regnoSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')); 
            });
        });

        function ticketSearchContent(url) {
            $('#ticketnowindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#ticketnowindow').jqxWindow('setContent', data);
                $('#ticketnowindow').jqxWindow('bringToFront');
            });
        }

        function getTicket(event){
            var x= event.keyCode;
            if(x==114){
                ticketSearchContent('ticketSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val'));
            }
        }

        function regnoSearchContent(url) {
            $('#regnowindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#regnowindow').jqxWindow('setContent', data);
                $('#regnowindow').jqxWindow('bringToFront');
            });
        }

        function getRegno(event){
            var x= event.keyCode;
            if(x==114){
                regnoSearchContent('regnoSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val'));
            }
        }

        function funreload(event)
        {
            var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
             var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
             
           if(fromdates>todates){
               $.messager.alert('Message','To Date Less Than From Date  ','warning');   
               return false;
          } 
           else {
                var fromdate= $("#fromdate").val();
                var todate= $("#todate").val(); 
                var regno= $("#regno").val();
                var test ="10"; 

                $("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&regno="+regno+"&to="+todate+"&ticketno="+$('#ticketno').val());
                $("#posgrid").load("subposting.jsp?test="+test+"&from="+fromdate+"&regno="+regno+"&to="+todate+"&ticketno="+$('#ticketno').val());
            }
        }
            
        function hiddenbrh(){
            $("#branchlabel").attr('hidden',true);
            $("#branchdiv").attr('hidden',true);
        }

        function funExportBtn()
        {
             $("#fleetdiv").excelexportjs({  
                    containerid: "fleetdiv", 
                    datatype: 'json', 
                    dataset: null, 
                    gridId: "jqxFleetGrid", 
                    columns: getColumns("jqxFleetGrid") , 
                    worksheetName:"Traffic Status"
                    }); 
        }
            
         function clearTicket(){
             $('#ticketno').val('');
             $('#ticketno').attr('placeholder','Press F3 to Search');
             $('#ticketno').attr('readonly',true);
             return false;
         }
         
         function clearRegno(){
             $('#regno').val('');
             $('#regno').attr('placeholder','Press F3 to Search');
             $('#regno').attr('readonly',true);
             return false;
         }
        </script>
    </head>
    
    <body onload="getBranch();hiddenbrh()">
        <div id="mainBG" class="homeContent">
            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Search Filters Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">From</td>
                                    <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Ticket No</td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 6px;">
                                            <input type="text" name="ticketno" id="ticketno" style="flex: 1;" placeholder="Press F3 to Search" onclick="getTicket(event)" readonly="readonly">
                                            <button type="button" class="clear-icon-btn" onclick="clearTicket();" title="Clear Ticket No">
                                                <img src="../../../../icons/cancel_new.png" alt="Clear">
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Reg No</td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 6px;">
                                            <input type="text" name="regno" id="regno" style="flex: 1;" placeholder="Press F3 to Search" onclick="getRegno(event)" readonly="readonly">
                                            <button type="button" class="clear-icon-btn" onclick="clearRegno();" title="Clear Reg No">
                                                <img src="../../../../icons/cancel_new.png" alt="Clear">
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <!-- Subgrids in Sidebar -->
                        <div class="filter-card" style="padding: 5px;">
                            <div id="Readygrid">
                                <jsp:include page="subgrid.jsp"></jsp:include>
                            </div>
                        </div>

                        <div class="filter-card" style="padding: 5px;">
                            <div id="posgrid">
                                <jsp:include page="subposting.jsp"></jsp:include>
                            </div>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
                            <input type="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
                            <input type="hidden" id="empname" value='<s:property value="chkdatails"/>'>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        
                        <div id="fleetdiv">
                            <jsp:include page="detailsgrid.jsp"></jsp:include>
                        </div>
                        
                    </div>
                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="ticketnowindow"><div></div><div></div></div>
            <div id="regnowindow"><div></div><div></div></div>

        </div>
    </body>
</html>