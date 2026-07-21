<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
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

        input[type="checkbox"] {
            margin: 0 4px 0 0;
            cursor: pointer;
            width: 14px;
            height: 14px;
            vertical-align: middle;
        }

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
        }

        /* Misc */
        #profitLossDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            flex: 1;
        }
        
        .analysis-inputs {
            display: flex;
            gap: 5px;
            margin-bottom: 10px;
        }
        
        .analysis-inputs select {
            width: 40%;
        }
        
        .analysis-inputs input {
            width: 60%;
        }
        </style>

        <script type="text/javascript">
        var selectedBox = null;

        $(document).ready(function() {
            getCurrency();
            
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString: "dd.MM.yyyy" });
            $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString: "dd.MM.yyyy" });

            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

            var year = window.parent.txtaccountperiodfrom.value;
            var newDate = year.split('-');
            year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
            $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));

            $(".chcklevels").click(function() {
                selectedBox = this.id;
                $(".chcklevels").each(function() {
                    if (this.id == selectedBox) {
                        this.checked = true;
                        if (this.id != "chcklevel4") {
                            $('#btnprint').attr("disabled", true);
                        } else {
                            $('#btnprint').attr("disabled", false);
                        }
                    } else {
                        this.checked = false;
                    }
                });
            });

            document.getElementById("hidchcklevel4").value = 1;
            document.getElementById("chcklevel4").checked = true;
            $('#btnprint').attr("disabled", true);
            getProfitAndLossPrintConfig();
        });

        function getProfitAndLossPrintConfig() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    if (parseInt(items) == 1) {
                        $("#btnprint").show();
                    } else {
                        $("#btnprint").hide();
                    }
                }
            }
            x.open("GET", "getProfitAndLossPrintConfig.jsp", true);
            x.send();
        }

        function isNumber(evt) {
            var iKeyCode = (evt.which) ? evt.which : evt.keyCode
            if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
                $.messager.alert('Message', ' Enter Numbers Only ', 'warning');
                return false;
            }
            return true;
        }

        function analysischeck() {
            if (document.getElementById("chckanalysis").checked) {
                document.getElementById("hidchckanalysis").value = 1;
                $('#txtnoofdays').val("0");
                $('#txtfrequency').val("0");
            } else {
                document.getElementById("hidchckanalysis").value = 0;
            }
            hidedata();
        }

        function checklevel1() {
            if (document.getElementById("chcklevel1").checked) {
                document.getElementById("hidchcklevel1").value = 1;
                document.getElementById("hidchcklevel2").value = 0;
                document.getElementById("hidchcklevel3").value = 0;
                document.getElementById("hidchcklevel4").value = 0;
            } else {
                document.getElementById("hidchcklevel1").value = 0;
            }
        }

        function checklevel2() {
            if (document.getElementById("chcklevel2").checked) {
                document.getElementById("hidchcklevel2").value = 1;
                document.getElementById("hidchcklevel1").value = 0;
                document.getElementById("hidchcklevel3").value = 0;
                document.getElementById("hidchcklevel4").value = 0;
            } else {
                document.getElementById("hidchcklevel2").value = 0;
            }
        }

        function checklevel3() {
            if (document.getElementById("chcklevel3").checked) {
                document.getElementById("hidchcklevel3").value = 1;
                document.getElementById("hidchcklevel1").value = 0;
                document.getElementById("hidchcklevel2").value = 0;
                document.getElementById("hidchcklevel4").value = 0;
            } else {
                document.getElementById("hidchcklevel3").value = 0;
            }
        }

        function checklevel4() {
            if (document.getElementById("chcklevel4").checked) {
                document.getElementById("hidchcklevel4").value = 1;
                document.getElementById("hidchcklevel1").value = 0;
                document.getElementById("hidchcklevel2").value = 0;
                document.getElementById("hidchcklevel3").value = 0;
            } else {
                document.getElementById("hidchcklevel4").value = 0;
            }
        }

        function hidedata() {
            var analysis = $('#hidchckanalysis').val();
            if (parseInt(analysis) == 1) {
                $("#analysisDiv").show();
                $("#viewDiv").hide();
            } else {
                $("#analysisDiv").hide();
                $("#viewDiv").show();
            }
        }

        function funreload(event) {
            var branchval = document.getElementById("cmbbranch").value;
            var fromdate = $('#fromdate').val();
            var todate = $('#todate').val();
            var level1 = $('#hidchcklevel1').val();
            var level2 = $('#hidchcklevel2').val();
            var level3 = $('#hidchcklevel3').val();
            var level4 = $('#hidchcklevel4').val();
            var check = 1;
            var rate = $('#txtrate').val();   
            
            $("#overlay, #PleaseWait").show();
            $('#btnprint').attr("disabled", true);
            
            var d = new Date();
            var entrydate = d.getTime();
            $("#entrydate").val(entrydate);
            d.setDate(d.getDate() - 1);
            var onedaylessdt = d.getTime();
            
            $("#profitLossDiv").load("profitLossGrid.jsp?branchval=" + branchval+ '&entrydate=' + entrydate + '&fromdate=' + fromdate + '&todate=' + todate + '&level1=' + level1 + '&level2=' + level2 + '&level3=' + level3 + '&level4=' + level4 + '&check=' + check+ '&rate=' + rate  +'&onedaylessdt=' + onedaylessdt);
        }

        function funExportBtn() {
            if (parseInt(window.parent.chkexportdata.value) == "1") {
                JSONToCSVCon(dataExcelExport, 'ProfitAndLoss', true);
            } else {
                $("#profitLossGrid").jqxTreeGrid('exportData', 'xls');
            }
        }

        function funPrint() {
            var branchval = document.getElementById("cmbbranch").value;
            var fromdate = $('#fromdate').val();
            var todate = $('#todate').val();
            var entrydate = $('#entrydate').val();   
            
            var url = document.URL;
            var reurl = url.split("com/");   
            var path = "v2profitlosslist.action?branchval=" + branchval + '&fromdate=' + fromdate + '&todate=' + todate + '&entrydate=' + entrydate;
            var win = window.open(reurl[0] + path, "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
            win.focus();
        }

        function getCurrency() {
            var x = new XMLHttpRequest();
            var items, currIdItems, mcloseItems, currCodeItems;
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    items = x.responseText;
                    items = items.split('####');
                    currIdItems = items[0].split(",");
                    currCodeItems = items[1].split(",");

                    var optionscurr = '<option value="">--Select--</option>';
                    for (var i = 0; i < currCodeItems.length; i++) {
                        optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
                    }
                    $("select#currencyid").html(optionscurr);
                    window.parent.monthclosed.value = mcloseItems;
                    getRates();
                }

                if ($('#hidcurid').val()) {
                    $("#currencyid").val($('#hidcurid').val());
                }
            }
            x.open("GET", "getCurrency.jsp", true);
            x.send();
        }

        function getRates() {
            var curid = $("#currencyid").val();
            if(!curid) return;
            
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $("#txtrate").val(items.trim());
                }
            }
            x.open("GET", "getRate.jsp?curid=" + curid, true);
            x.send();
        }
        </script>
    </head>
    
    <body onload="getBranch();">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Base Date -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Period</td>
                                    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                </tr>
                            </table>
                        </div>

                        <!-- View section (Level 1-4) -->
                        <div id="viewDiv">
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">To</td>
                                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Currency</td>
                                        <td>
                                            <select id="currencyid" name="currencyid" onchange="getRates();" value='<s:property value="currencyid"/>'>
                                                <option value="">--Select--</option>
                                            </select>
                                            <input type="hidden" id="hidcurid" name="hidcurid">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Rate</td>
                                        <td><input type="text" id="txtrate" name="txtrate"></td>
                                    </tr>
                                </table>
                            </div>

                            <div class="filter-card">
                                <fieldset>
                                    <legend>Levels</legend>
                                    <div style="display: flex; flex-direction: column; gap: 8px;">
                                        <label class="branch" for="chcklevel1">
                                            <input type="checkbox" id="chcklevel1" name="chcklevel1" class="chcklevels" value="" onchange="checklevel1();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Level 1
                                        </label>
                                        <input type="hidden" id="hidchcklevel1" name="hidchcklevel1" value='<s:property value="hidchcklevel1"/>'/>
                                        
                                        <label class="branch" for="chcklevel2">
                                            <input type="checkbox" id="chcklevel2" name="chcklevel2" class="chcklevels" value="" onchange="checklevel2();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Level 2
                                        </label>
                                        <input type="hidden" id="hidchcklevel2" name="hidchcklevel2" value='<s:property value="hidchcklevel2"/>'/>
                                        
                                        <label class="branch" for="chcklevel3">
                                            <input type="checkbox" id="chcklevel3" name="chcklevel3" class="chcklevels" value="" onchange="checklevel3();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Level 3
                                        </label>
                                        <input type="hidden" id="hidchcklevel3" name="hidchcklevel3" value='<s:property value="hidchcklevel3"/>'/>
                                        
                                        <label class="branch" for="chcklevel4">
                                            <input type="checkbox" id="chcklevel4" name="chcklevel4" class="chcklevels" value="" onchange="checklevel4();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Level 4
                                        </label>
                                        <input type="hidden" id="hidchcklevel4" name="hidchcklevel4" value='<s:property value="hidchcklevel4"/>'/>
                                    </div>
                                </fieldset>
                                
                                <div class="action-buttons">
                                    <button type="button" class="btn-submit" id="btnprint" onclick="funPrint();">Print</button>
                                </div>
                            </div>
                        </div>

                        <!-- Analysis section (Hidden by default) -->
                        <div id="analysisDiv" style="display:none;">
                            <div class="filter-card">
                                <div class="analysis-inputs">
                                    <select id="cmbchoose" name="cmbchoose" value='<s:property value="cmbchoose"/>'>
                                        <option value="1">Days</option>
                                        <option value="2">Monthly</option>
                                        <option value="3">Quarterly</option>
                                        <option value="4">Yearly</option>
                                    </select>
                                    <input type="text" id="txtnoofdays" name="txtnoofdays" value='<s:property value="txtnoofdays"/>'/>
                                </div>
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Frequency</td>
                                        <td><input type="text" id="txtfrequency" name="txtfrequency" value='<s:property value="txtfrequency"/>'/></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <div style="display:none;">
                            <input type="hidden" id="entrydate" name="entrydate"/>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="profitLossDiv">
                            <jsp:include page="profitLossGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </body>
</html>