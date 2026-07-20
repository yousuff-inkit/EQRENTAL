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

        input[type="radio"] {
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
        #stockLedgerDiv, #stockLedgerDetDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            height: 100%;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $('#stockLedgerDiv').show();
             $('#stockLedgerDetDiv').hide();
             document.getElementById('rsumm').checked=true;
             
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

             $('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#productDetailsWindow').jqxWindow('close');
            
             $('#txtpartno').dblclick(function(){
                 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
             }); 
        });

        function funExportBtn(){
            if (document.getElementById('rsumm').checked) {
                JSONToCSVCon(datass, 'Strock List', true);
            } else if (document.getElementById('rdet').checked) {
                JSONToCSVCon(dat, 'Strock List', true);
            }
         }

        function productSearchContent(url) {
            $('#productDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#productDetailsWindow').jqxWindow('setContent', data);
                $('#productDetailsWindow').jqxWindow('bringToFront');
            }); 
        }

        function getProduct(event){
             var x= event.keyCode;
             if(x==114){
                 $('#productDetailsWindow').jqxWindow('open');
                 $('#productDetailsWindow').jqxWindow('focus');
                 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
             }
        }
        
        function funreload(event)
        {
             var barchval = document.getElementById("cmbbranch").value;
             var statusselect=$("#statusselect").val();
             var psrno=$("#psrno").val();
             
             if (document.getElementById('rsumm').checked) {
                  $("#overlay, #PleaseWait").show();
                  var load="yes";
                  $("#stockLedgerDiv").load("stockGridSummary.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&load="+load);
             } else if (document.getElementById('rdet').checked) {
                 $("#overlay, #PleaseWait").show();
                 var load="yes";
                 $("#stockLedgerDetDiv").load("stockGridDetail.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&load="+load);
             }  
        }

        function  funcleardata()
        {
             document.getElementById('txtpartno').value="";
             document.getElementById('txtproductname').value="";
             document.getElementById('psrno').value="";
             document.getElementById('rsumm').checked=true;
             document.getElementById("cmbbranch").value="a";
             $('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
        }
            
        function fundisable(){
            if (document.getElementById('rsumm').checked) {
                  $('#stockLedgerDiv').show();
                  $('#stockLedgerDetDiv').hide();
            } else if (document.getElementById('rdet').checked) {
                  $('#stockLedgerDiv').hide();
                  $('#stockLedgerDetDiv').show();
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
                        
                        <!-- Report Type Settings -->
                        <div class="filter-card">
                            <fieldset>
                                <legend>Report Type</legend>
                                <div style="display: flex; justify-content: space-around; padding: 5px 0;">
                                    <label for="rsumm" class="branch">
                                        <input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"> Summary
                                    </label>
                                    <label for="rdet" class="branch">
                                        <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"> Detail
                                    </label>
                                </div>
                            </fieldset>
                        </div>

                        <!-- Product Search Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Product</td>
                                    <td>
                                        <input type="text" id="txtpartno" name="txtpartno" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell"></td>
                                    <td>
                                        <input type="text" id="txtproductname" name="txtproductname" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/>
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="action-buttons">
                                <button type="button" class="btn-submit btn-clear" name="clear" id="clear" onclick="funcleardata()">Clear</button>
                            </div>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
                            <input type="hidden" id="statusselect" name="statusselect" value='<s:property value="statusselect"/>'>
                            <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                            <div id='paychaaaaa'></div>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="stockLedgerDiv">
                            <jsp:include page="stockGridSummary.jsp"></jsp:include>
                        </div>
                        <div id="stockLedgerDetDiv" style="display:none;">
                            <jsp:include page="stockGridDetail.jsp"></jsp:include> 
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="productDetailsWindow"><div></div><div></div></div>

        </div>
    </body>
</html>