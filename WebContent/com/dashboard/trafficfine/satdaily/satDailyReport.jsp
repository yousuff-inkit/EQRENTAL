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

        /* Fieldsets & Radios */
        fieldset {
            border: 1px solid #ccd6e0;
            border-radius: 6px;
            padding: 10px;
            margin-bottom: 12px;
            background: #fff;
        }

        legend {
            font-size: 11px;
            font-weight: bold;
            color: #4e5e71;
            padding: 0 5px;
            text-transform: uppercase;
        }

        input[type="radio"], input[type="checkbox"] {
            margin: 0 4px 0 0;
            cursor: pointer;
            width: 14px;
            height: 14px;
            vertical-align: middle;
        }

        .branch {
            font-size: 12px;
            font-weight: 600;
            color: #4e5e71;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
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
        #satSalikDiv, #satTrafficDiv, #satCountDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             // Uniform 24px date inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
             var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
             
             document.getElementById("rdticketdate").checked=true;
             document.getElementById("rdsalik").checked=true;
             fundisable();
        });

        function getDailyCount(fromdate,todate,satcateg) {
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200) {
                       items= x.responseText;
                       document.getElementById("searchdetails").value=items;
                }
            }
            x.open("GET",'getDailyCount.jsp?fromdate='+fromdate+'&todate='+todate+'&satcateg='+satcateg,true);
            x.send();
        }

        function funreload(event){
             var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
             var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
            
             if(fromdates>todates){
                $.messager.alert('Message','To Date Less Than From Date  ','warning');   
                return false;
             }
            
            if (!(document.getElementById('rdsalik').checked || document.getElementById('rdtraffic').checked)) {
                $.messager.alert('Message','Select Salik / Traffic','warning');
                return false;
            } else {
                 var barchval = document.getElementById("cmbbranch").value;
                 var fromdate= $("#fromdate").val();
                 var todate= $("#todate").val();
                 var check=1;
                 var satcateg="";
                 var datefilter="";
                 
                 if (document.getElementById('rdticketdate').checked) {
                     datefilter="1";
                 } else if (document.getElementById('rddownloaddate').checked) {
                     datefilter="2";
                 }
                 
                 if (document.getElementById('rdsalik').checked) {
                    satcateg="salik";
                    $("#overlay, #PleaseWait").show();
                    $("#satSalikDiv").load("satSalikGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg=salik&datefilter="+datefilter+"&check="+check);
                } else if (document.getElementById('rdtraffic').checked) {
                    satcateg="traffic";
                    $("#overlay, #PleaseWait").show();
                    $("#satTrafficDiv").load("satTrafficGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg=traffic&datefilter="+datefilter+"&check="+check);
                }
        
                $("#satCountDiv").load("satCountGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg+"&datefilter="+datefilter+"&check="+check);
            }
        }

        function funExportBtn(){
             if(parseInt(window.parent.chkexportdata.value)=="1") {
                if (document.getElementById('rdsalik').checked) {
                    JSONToCSVCon(salikdailyexceldata, 'Salik Daily List', true);
                } 
                if (document.getElementById('rdtraffic').checked) {
                    JSONToCSVCon(trafficdailyexceldata, 'Traffic Daily List', true);
                }
             }
         }
            
        function fundisable(){
            if (document.getElementById('rdsalik').checked) {
                $('#satSalikDiv').show();
                $('#satTrafficDiv').hide();
            } else if (document.getElementById('rdtraffic').checked) {
                $('#satSalikDiv').hide();
                $('#satTrafficDiv').show();
            }
        }
        </script>
    </head>
    
    <body onload="getBranch();">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Filter Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">From</td>
                                    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                                </tr>
                            </table>
                        </div>

                        <!-- Report Type Selection -->
                        <div class="filter-card">
                            <fieldset>
                                <legend>Report Type</legend>
                                <div style="display: flex; flex-direction: column; gap: 12px; padding: 5px 0;">
                                    <div style="display: flex; justify-content: space-between;">
                                        <label for="rdticketdate" class="branch">
                                            <input type="radio" id="rdticketdate" name="rddatefilter" value="rdticketdate"> Ticket Date
                                        </label>
                                        <label for="rddownloaddate" class="branch">
                                            <input type="radio" id="rddownloaddate" name="rddatefilter" value="rddownloaddate"> Download Date
                                        </label>
                                    </div>
                                    <div style="display: flex; justify-content: space-between;">
                                        <label for="rdsalik" class="branch">
                                            <input type="radio" id="rdsalik" name="rdcategory" onchange="fundisable();" value="rdsalik"> Salik
                                        </label>
                                        <label for="rdtraffic" class="branch">
                                            <input type="radio" id="rdtraffic" name="rdcategory" onchange="fundisable();" value="rdtraffic"> Traffic
                                        </label>
                                    </div>
                                </div>
                            </fieldset>
                        </div>

                        <!-- Small count grid -->
                        <div class="filter-card" style="padding: 5px;">
                            <div id="satCountDiv">
                                <jsp:include page="satCountGrid.jsp"></jsp:include>
                            </div>
                        </div>

                        <!-- Hidden Textarea -->
                        <textarea id="searchdetails" hidden="true" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="10" readonly></textarea>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        
                        <div id="satSalikDiv">
                            <jsp:include page="satSalikGrid.jsp"></jsp:include>
                        </div>
                        
                        <div id="satTrafficDiv" style="display:none;">
                            <jsp:include page="satTrafficGrid.jsp"></jsp:include>
                        </div>

                    </div>
                </div>

            </div>
        </div>

    </body>
</html>