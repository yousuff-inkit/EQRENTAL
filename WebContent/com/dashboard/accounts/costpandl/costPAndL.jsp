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
        
        .account-label-bar {
            padding: 10px 15px 0 15px;
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
            font-size: 14px;
        }
        
        .account {
            font-weight: bold;
            color: #333;
        }
        
        .accname {
            color: #0284c7;
            font-weight: 600;
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
        #costPAndLDiv {
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
        
        .net-amount-label {
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-right: 10px;
        }
        
        .net-amount-input {
            width: 120px !important;
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
            
             $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#accountDetailsWindow').jqxWindow('close');
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
             
             $('#costCodeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Cost Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#costCodeDetailsWindow').jqxWindow('close');
            
             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
            
             $('#txtcostcodeid').dblclick(function(){
                  if($('#cmbcosttype').val()==''){
                     $.messager.alert('Message','Please Choose Cost Type.','warning');
                     return 0;
                  }
                  costCodeSearchContent('costCodeDetailsSearch.jsp');
             });
            
             $('#txtaccid').dblclick(function(){
                  accountsSearchContent('accountsDetailsSearch.jsp');
             });
        });
        
        function getAccTypeFrom(event){
            var x= event.keyCode;
            if(x==114){
                accountsSearchContent('accountsDetailsSearch.jsp');
            }
        }
        
        function accountsSearchContent(url) {
            $('#accountDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#accountDetailsWindow').jqxWindow('setContent', data);
                $('#accountDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        
        function costCodeSearchContent(url) {
            $('#costCodeDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#costCodeDetailsWindow').jqxWindow('setContent', data);
                $('#costCodeDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        
        function getCostType() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    
                    var srno  = items[0].split(",");
                    var process = items[1].split(",");
                    var optionsbranch = '<option value="" selected>-- Select -- </option>';
                    for (var i = 0; i < process.length; i++) {
                        optionsbranch += '<option value="' + srno[i].trim() + '">'
                                + process[i] + '</option>';
                    }
                    $("select#cmbcosttype").html(optionsbranch);
                    
                }
            }
            x.open("GET","getCostType.jsp", true);
            x.send();
        }
        
        function funExportBtn(){
            $("#costPAndLGridID").excelexportjs({
                containerid: "costPAndLGridID",
                datatype: 'json',
                dataset: null,
                gridId: "costPAndLGridID",
                columns: getColumns("costPAndLGridID"),
                worksheetName: "CostProfitAndLoss"
            });
        } 
        
        function getCostCode(event){
            var x= event.keyCode;
            if(x==114){
                 if($('#cmbcosttype').val()==''){
                     $.messager.alert('Message','Please Choose Cost Type.','warning');
                     return 0;
                 }
                 costCodeSearchContent('costCodeDetailsSearch.jsp');
            }
        }
        
        function clearCostCodeInfo(){
            $('#txtcostcode').val('');$('#txtcostcodeid').val('');$('#txtcostcodename').val('');
            
            if (document.getElementById("txtcostcodeid").value == "") {
                $('#txtcostcodeid').attr('placeholder', 'Press F3 to Search'); 
            }
            
            $("#costPAndLGridID").jqxGrid('clear');
            $("#costPAndLGridID").jqxGrid("addrow", null, {});
        }
        
        function funreload(event){
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var costtype = $('#cmbcosttype').val();
             var costcode = $('#txtcostcode').val();
             var accdocno = $('#txtdocno').val();
             var check = 1;
            
             $("#overlay, #PleaseWait").show();
            
             if($('#cmbcosttype').val().trim()!=''){
                document.getElementById("lblaccountname").innerText=$("#cmbcosttype option:selected").text().trim()+" - "+$('#txtcostcodename').val();
             } else {
                document.getElementById("lblaccountname").innerText='ALL';
             }
             $("#costPAndLDiv").load("costPAndLGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&costtype='+costtype+'&costcode='+costcode+'&accdocno='+accdocno+'&check='+check);
        }
        </script>
    </head>
    
    <body onload="getBranch();getCostType();">
        <form id="frmCostLedger" action="saveCostLedger" method="post" autocomplete="off" style="height: 100%;">
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
                            </div>

                            <!-- Cost Settings Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Cost Type</td>
                                        <td>
                                            <select id="cmbcosttype" name="cmbcosttype" onchange="clearCostCodeInfo();" value='<s:property value="cmbcosttype"/>'></select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Cost Code</td>
                                        <td>
                                            <input type="text" id="txtcostcodeid" name="txtcostcodeid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtcostcodeid"/>' onkeydown="getCostCode(event);"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell"></td>
                                        <td>
                                            <input type="text" id="txtcostcodename" name="txtcostcodename" readonly="readonly" value='<s:property value="txtcostcodename"/>' tabindex="-1"/>
                                            <input type="hidden" id="txtcostcode" name="txtcostcode" value='<s:property value="txtcostcode"/>'/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                            <!-- Account Settings Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Account</td>
                                        <td>
                                            <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell"></td>
                                        <td>
                                            <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>
                        
                        <div class="account-label-bar">
                            <label class="account">Cost Center : </label><label class="accname" name="lblaccountname" id="lblaccountname"></label>
                        </div>

                        <div class="grid-content-container">
                            <div id="costPAndLDiv">
                                <jsp:include page="costPAndLGrid.jsp"></jsp:include>
                            </div>
                            
                            <div class="net-amount-container">
                                <span class="net-amount-label">Net Amount :</span>
                                <input type="text" class="filter-table input[type='text'] net-amount-input" id="txtnetamount" name="txtnetamount" readonly="readonly" value='<s:property value="txtnetamount"/>'/>
                            </div>
                        </div>

                    </div>

                </div>
                
                <!-- POPUPS -->
                <div id="costCodeDetailsWindow"><div></div><div></div></div>
                <div id="accountDetailsWindow"><div></div><div></div></div>

            </div>
        </form>
    </body>
</html>