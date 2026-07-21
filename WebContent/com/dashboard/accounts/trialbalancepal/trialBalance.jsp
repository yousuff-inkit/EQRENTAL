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
            margin: 0;
            cursor: pointer;
            width: 14px;
            height: 14px;
            vertical-align: middle;
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
        #trialBalanceDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            flex: 1;
        }
        
        .net-amount-container {
            padding: 15px 0 0 0;
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }
        
        .net-amount-input {
            width: 150px !important;
            text-align: right;
            font-weight: bold;
            font-size: 14px !important;
            background-color: #f8fafc !important;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             // Uniform 24px date inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
             
             $("#trialDiv").hide();
             document.getElementById("hidchckincludingzero").value=0;
             getTrialBalancePrintConfig();
        });
        
        function getTrialBalancePrintConfig(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    
                    if(parseInt(items)==1){
                         $("#btnprint").show();
                     } else {
                         $("#btnprint").hide();
                     }
            }
            }
            x.open("GET", "getTrialBalancePrintConfig.jsp", true);
            x.send();
        }
        
        function funExportBtn(){
            $("#trialBalanceDiv").excelexportjs({
                containerid: "trialBalanceDiv",
                datatype: 'json',
                dataset: null,
                gridId: "trialBalance",
                columns: getColumns("trialBalance"),
                worksheetName:"Trial Balance"
            });
        } 
        
        function includingzerocheck(){
             if(document.getElementById("chckincludingzero").checked){
                 document.getElementById("hidchckincludingzero").value = 1;
             }
             else{
                 document.getElementById("hidchckincludingzero").value = 0;
             }
         }
        
        function funreload(event){
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var acctype = $('#cmbtype').val();
             var includingzero = $('#hidchckincludingzero').val(); 
            
             $("#overlay, #PleaseWait").show();
             $("#trialBalanceDiv").load("trialBalanceGrid.jsp?barchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&includingzero='+includingzero+'&check=1');
        }

        function funPrint(){
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var acctype = $('#cmbtype').val();
             var includingzero = $('#hidchckincludingzero').val(); 
             
             var url=document.URL;
             var reurl=url.split("com");
             var path= "com/dashboard/accounts/trialbalancepal/trialbalancelistpal.action?barchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&includingzero='+includingzero+'&check=1';
             var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");      
             win.focus();       
        }
        
        function disableprint() {
            $('#btnprint').attr("disabled",true);
        }
        </script>
    </head>
    
    <body onload="getBranch();disableprint();">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Date Range Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Period</td>
                                    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                                </tr>
                            </table>
                            <div style="display: flex; align-items: center; gap: 8px; margin-top: 10px; margin-bottom: 10px;">
                                <input type="checkbox" id="chckincludingzero" name="chckincludingzero" value="" onchange="includingzerocheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                <label class="branch" for="chckincludingzero">Including Zero</label>
                                <input type="hidden" id="hidchckincludingzero" name="hidchckincludingzero" readonly="readonly" value='<s:property value="hidchckincludingzero"/>'/>
                            </div>
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Type</td>
                                    <td>
                                        <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                                            <option value="">All</option>
                                            <option value="AP">AP</option>
                                            <option value="AR">AR</option>
                                            <option value="GL">GL</option>
                                            <option value="HR">HR</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="action-buttons">
                                <button type="button" class="btn-submit" id="btnprint" onclick="funPrint();">Print</button>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="trialBalanceDiv">
                            <jsp:include page="trialBalanceGrid.jsp"></jsp:include>
                        </div>
                        
                        <div id="trialDiv" class="net-amount-container" style="display:none;">
                            <input type="text" class="filter-table input[type='text'] net-amount-input" id="txtnetamount" name="txtnetamount" readonly="readonly" value='<s:property value="txtnetamount"/>'/>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </body>
</html>