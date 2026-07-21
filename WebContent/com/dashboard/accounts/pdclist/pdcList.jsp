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

        input[type="radio"], input[type="checkbox"] {
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
            
             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
             
             document.getElementById("rdpayment").checked=true;
             document.getElementById("rdall").checked=true;
             document.getElementById("chckunclrposted").checked = false;
             $('#chckunclrposted').attr('disabled', true);
             $('#hidchckunclrposted').val('0');
             
             $('#txtaccid').dblclick(function(){
                 if($('#cmbtype').val()==''){
                     $.messager.alert('Message','Please Choose Account Type.','warning');
                     return 0;
                 }
                 accountsSearchContent('accountsDetailsSearch.jsp');
             });
            
             document.getElementById('rdall').addEventListener('change', function (e) {
                 $('#cmbcriteria').attr('disabled', false);
                 document.getElementById("chckunclrposted").checked = false;
                 $('#hidchckunclrposted').val('0');
                 $('#chckunclrposted').attr('disabled', true);
             });
            
             document.getElementById('rdpdc').addEventListener('change', function (e) {
                 $('#cmbcriteria').attr('disabled', false);
                 document.getElementById("chckunclrposted").checked = false;
                 $('#hidchckunclrposted').val('0');
                 $('#chckunclrposted').attr('disabled', true);
             });
            
             document.getElementById('rduncleared').addEventListener('change', function (e) {
                 $('#cmbcriteria').attr('disabled', true);
                 $('#cmbcriteria').val('1');
                 document.getElementById("chckunclrposted").checked = false;
                 $('#hidchckunclrposted').val('0');
                 $('#chckunclrposted').attr('disabled', false);
             });
        });
        
        function accountsSearchContent(url) {
            $('#accountDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#accountDetailsWindow').jqxWindow('setContent', data);
                $('#accountDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        
        function getAccTypeFrom(event){
            var x= event.keyCode;
            if(x==114){
                if($('#cmbtype').val()==''){
                     $.messager.alert('Message','Please Choose Account Type.','warning');
                     return 0;
                 }
                accountsSearchContent('accountsDetailsSearch.jsp');
            }
        }
        
         function dateDisable(){
             var posted=$('#cmbcriteria').val();
             if(posted==2){
                 $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
             } else {
                 $('#jqxFromDate').jqxDateTimeInput({disabled: false});
             }
          }
        
        function clearAccountInfo(){
            $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
            
            if (document.getElementById("txtaccid").value == "") {
                $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
            }
        }
        
        function funClearInfo(){
            $('#fromdate').val(new Date());
            var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
            var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
            var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
            $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
             
            $('#todate').val(new Date());
            
            document.getElementById("rdpayment").checked=true;
            document.getElementById("rdall").checked=true;
            
            $('#cmbbranch').val('a');$('#cmbcriteria').val('1');$('#cmbcriteria').attr('disabled', false);
            $('#cmbdistribution').val('');$('#cmbgroup').val('');$('#cmbtype').val('0');
            $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
            $('#hidchckunclrposted').val('0');$('#chckunclrposted').attr('disabled', false);
            document.getElementById("chckunclrposted").checked = false;
            
            $("#jqxPdcList").jqxGrid('clear');
            $("#jqxPdcList").jqxGrid('addrow', null, {});
            $("#jqxPdcListGroup").jqxGrid('clear');
            $("#jqxDistributionGrid").jqxGrid('clear');
            
            if (document.getElementById("txtaccid").value == "") {
                $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
            }
            
            $("#pdcListDiv").show();
            $("#pdcListGroupDiv, #pdcListDistributionDiv").hide();
        }

        function funreload(event){
             funGroupDistributionGrid();
             
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var criteria = $('#cmbcriteria').val();
             var distribution = $('#cmbdistribution').val();
             var group = $('#cmbgroup').val();
             var acctype = $('#cmbtype').val();
             var accno = $('#txtdocno').val();
             var unclrposted = $('#hidchckunclrposted').val();
             var reporttype = "";
            
             if(document.getElementById("rdall").checked==true){
                 reporttype = $('#rdall').val();
             }else if(document.getElementById("rdpdc").checked==true){
                 reporttype = $('#rdpdc').val();
             }else if(document.getElementById("rduncleared").checked==true){
                 reporttype = $('#rduncleared').val();
             }
            
             $("#overlay, #PleaseWait").show();
            
             if(document.getElementById("rdreceipt").checked==true){
                 if(group=='' && distribution==''){
                      $("#pdcListDiv").load("pdcListGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1');                               
                 }else if(group!='' && distribution==''){
                     $("#pdcListGroupDiv").load("pdcListGroupingGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=3');
                 }else{
                     $("#pdcListDistributionDiv").load("pdcListDistributionGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=2');
                 }
             }else{
                 if(group=='' && distribution==''){
                      $("#pdcListDiv").load("pdcListGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1');                               
                 }else if(group!='' && distribution==''){
                     $("#pdcListGroupDiv").load("pdcListGroupingGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=3');
                 }else{
                     $("#pdcListDistributionDiv").load("pdcListDistributionGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=2');
                 }
             }
        }
        
        function funGroupDistributionGrid(){
            var group=$('#cmbgroup').val();
            var distribution=$('#cmbdistribution').val();
            
            if(group=='' && distribution==''){
                $("#pdcListDiv").show();
                $("#pdcListGroupDiv, #pdcListDistributionDiv").hide();
            } else if(group!='' && distribution==''){
                $("#pdcListDiv, #pdcListDistributionDiv").hide(); 
                $("#pdcListGroupDiv").show();
            } else {
                $("#pdcListDiv, #pdcListGroupDiv").hide(); 
                $("#pdcListDistributionDiv").show();
            }
        }
        
        function checkunclrposted() {
            if(document.getElementById("chckunclrposted").checked) {
                 document.getElementById("hidchckunclrposted").value = 1;
             } else {
                 document.getElementById("hidchckunclrposted").value = 0;
             }
         }
        
        function funExportBtn(){
             var distribute = $('#cmbdistribution').val();
             var grouping = $('#cmbgroup').val();
            
            if(grouping=='' && distribute==''){
                if(parseInt(window.parent.chkexportdata.value)=="1") {
                    JSONToCSVCon(data, 'PdcList', true);
                 } else {
                     $("#jqxPdcList").jqxGrid('exportdata', 'xls', 'PdcList');
                 }
            }

            if(grouping!='' && distribute==''){
                if(parseInt(window.parent.chkexportdata.value)=="1") {
                    JSONToCSVCon(data1, 'PdcList', true);
                 } else {
                     $("#jqxPdcListGroup").jqxGrid('exportdata', 'xls', 'PdcList');
                 }
            }
            
            if(!((grouping=='' && distribute=='') && (grouping!='' && distribute==''))){
                if(parseInt(window.parent.chkexportdata.value)=="1") {
                    JSONToCSVCon(data3, 'PdcList', true);
                 } else {
                     $("#jqxDistributionGrid").jqxGrid('exportdata', 'xls', 'PdcList');
                 }
            }
        }
        
        function funprint(){
             var url=document.URL;
             var reurl=url.split("com");
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var criteria = $('#cmbcriteria').val();
             var distribution = $('#cmbdistribution').val();
             var group = $('#cmbgroup').val();
             var acctype = $('#cmbtype').val();
             var accno = $('#txtdocno').val();
             var unclrposted = $('#hidchckunclrposted').val();
             var reporttype = "";
            
             if(document.getElementById("rdall").checked==true){
                 reporttype = $('#rdall').val();
             }else if(document.getElementById("rdpdc").checked==true){
                 reporttype = $('#rdpdc').val();
             }else if(document.getElementById("rduncleared").checked==true){
                 reporttype = $('#rduncleared').val();
             }
            
            if(document.getElementById("rdreceipt").checked==true){
                var win=window.open(reurl[0]+"com/dashboard/accounts/pdclist/"+"printpdcjasper?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1',"_blank","top=250,left=310,width=800,height=800,location=no,scrollbars=no,toolbar=yes");
             }else{
                 var win=window.open(reurl[0]+"com/dashboard/accounts/pdclist/"+"printpdcjasper?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1',"_blank","top=250,left=310,width=800,height=800,location=no,scrollbars=no,toolbar=yes");
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
                        
                        <!-- Date Range Card -->
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

                        <!-- Report Settings Card -->
                        <div class="filter-card">
                            <fieldset>
                                <legend>Report Type</legend>
                                <div style="display: flex; justify-content: space-around; padding: 5px 0;">
                                    <label for="rdpayment" class="branch">
                                        <input type="radio" id="rdpayment" name="rdo" value="FPP" checked> Payment
                                    </label>
                                    <label for="rdreceipt" class="branch">
                                        <input type="radio" id="rdreceipt" name="rdo" value="FRO"> Receipt
                                    </label>
                                </div>
                            </fieldset>
                            
                            <fieldset>
                                <legend>Type</legend>
                                <div style="display: flex; justify-content: space-around; padding: 5px 0;">
                                    <label for="rdall" class="branch">
                                        <input type="radio" id="rdall" name="rdos" value="rdall" checked> All
                                    </label>
                                    <label for="rdpdc" class="branch">
                                        <input type="radio" id="rdpdc" name="rdos" value="rdpdc"> PDC
                                    </label>
                                </div>
                                <div style="display: flex; flex-direction: column; gap: 8px; margin-top: 10px; align-items: center;">
                                    <label for="rduncleared" class="branch">
                                        <input type="radio" id="rduncleared" name="rdos" value="rduncleared"> Uncleared
                                    </label>
                                    <div style="display: flex; align-items: center; gap: 5px;">
                                        <input type="checkbox" id="chckunclrposted" name="chckunclrposted" value="" onchange="checkunclrposted();" onclick="$(this).attr('value', this.checked ? 1 : 0)" disabled>
                                        <label class="branch" for="chckunclrposted">Uncleared Posted</label>
                                        <input type="hidden" id="hidchckunclrposted" name="hidchckunclrposted" value='<s:property value="hidchckunclrposted"/>'/>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        
                        <!-- List Filters Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Criteria</td>
                                    <td>
                                        <select id="cmbcriteria" name="cmbcriteria" onchange="dateDisable();" value='<s:property value="cmbcriteria"/>'>
                                            <option value="1">All</option>
                                            <option value="2">To be Posted</option>
                                            <option value="3">Posted PDC</option>
                                            <option value="4">Returned PDC</option>
                                            <option value="5">Dishonoured PDC</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Distribution</td>
                                    <td>
                                        <select id="cmbdistribution" name="cmbdistribution" value='<s:property value="cmbdistribution"/>'>
                                            <option value="">--Select--</option>
                                            <option value="monthwise">Month-Wise</option>
                                            <option value="bankwise">Bank-Wise</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Grouping</td>
                                    <td>
                                        <select id="cmbgroup" name="cmbgroup" value='<s:property value="cmbgroup"/>'>
                                            <option value="">--Select--</option>
                                            <option value="date">Date</option>
                                            <option value="month">Month</option>
                                            <option value="bank">Bank</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Acc. Type</td>
                                    <td>
                                        <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
                                            <option value="0">--Select--</option>
                                            <option value="BANK">Bank</option>
                                            <option value="AP">AP</option>
                                            <option value="AR">AR</option>
                                        </select>
                                    </td>
                                </tr>
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
                            
                            <div class="action-buttons">
                                <button type="button" name="clear" id="clear" class="btn-submit btn-clear" onclick="funClearInfo();">Clear</button>
                                <button type="button" name="Print" id="print" class="btn-submit" onclick="funprint();">Print</button>
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
                        <div id="pdcListDiv" class="grid-wrapper">
                            <jsp:include page="pdcListGrid.jsp"></jsp:include>
                        </div>
                        <div id="pdcListGroupDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="pdcListGroupingGrid.jsp"></jsp:include>
                        </div>
                        <div id="pdcListDistributionDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="pdcListDistributionGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="accountDetailsWindow"><div></div><div></div></div>

        </div>
    </body>
</html>