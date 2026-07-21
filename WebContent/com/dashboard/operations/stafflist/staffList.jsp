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

        /* Legend List */
        .legend-title {
            font-size: 11px;
            font-weight: bold;
            color: #4e5e71;
            text-transform: uppercase;
            margin-bottom: 10px;
            border-bottom: 1px solid #e3e8ee;
            padding-bottom: 5px;
        }

        .legend-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .legend-item {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
            font-size: 12px;
            color: #4e5e71;
            font-weight: 600;
        }

        .legend-color {
            width: 16px;
            height: 16px;
            border-radius: 4px;
            margin-right: 10px;
            border: 1px solid #ccd6e0;
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
        #staffListDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            height: 100%;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        });

        function funreload(event){
            var branchval = document.getElementById("cmbbranch").value;
            var type = document.getElementById("cmbtype").value;
            var check=1;
            
            $("#overlay, #PleaseWait").show();
            $("#staffListDiv").load("staffListGrid.jsp?branchval="+branchval+'&type='+type+'&check='+check);
        }
        
        function funExportBtn(){
             if(parseInt(window.parent.chkexportdata.value)=="1") {
                JSONToCSVCon(data1, 'StaffList', true);
             } else {
                 $("#staffList").jqxGrid('exportdata', 'xls', 'StaffList');
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
                        
                        <!-- Search Filters Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Type</td>
                                    <td>
                                        <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>' onchange="funreload(event);">
                                            <option value="">--Select--</option>
                                            <option value="SLM">Sales Man</option>
                                            <option value="SLA">Sales Agent</option>
                                            <option value="RLA">Rental Agent</option>
                                            <option value="DRV">Driver</option>
                                            <option value="CHK">Check In</option>
                                            <option value="STF">Staff</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <!-- Legend Card -->
                        <div class="filter-card">
                            <div class="legend-title">Color Legend</div>
                            <ul class="legend-list">
                                <li class="legend-item">
                                    <div class="legend-color" style="background-color: #FFEBEB;"></div> Sales Man
                                </li>
                                <li class="legend-item">
                                    <div class="legend-color" style="background-color: #FFFFD1;"></div> Sales Agent
                                </li>
                                <li class="legend-item">
                                    <div class="legend-color" style="background-color: #FFFAFA;"></div> Rental Agent
                                </li>
                                <li class="legend-item">
                                    <div class="legend-color" style="background-color: #F0FFFF;"></div> Driver
                                </li>
                                <li class="legend-item">
                                    <div class="legend-color" style="background-color: #F8E0F7;"></div> Staff
                                </li>
                                <li class="legend-item">
                                    <div class="legend-color" style="background-color: #F7F2E0;"></div> Check In
                                </li>
                            </ul>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="staffListDiv">
                            <jsp:include page="staffListGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </body>
</html>