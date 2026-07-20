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

        textarea {
            width: 100%;
            padding: 6px 8px;         
            border: 1px solid #ccd6e0;
            border-radius: 4px;       
            font-size: 12px;          
            background-color: #ffffff;
            box-sizing: border-box;
            color: #333;
            outline: none;
            resize: none;
            font-family: inherit;
        }

        /* Readonly / disabled look */
        input[readonly],
        input:disabled,
        textarea[readonly],
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

        input[type="checkbox"] {
            margin: 0 4px 0 0;
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
        
        .mini-btn {
            height: 24px;
            width: 24px;
            padding: 0;
            line-height: 24px;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            font-size: 16px;
            border-radius: 4px;
            margin-left: 2px;
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
        #postingCashDiv, #JVTDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            flex-shrink: 0;
        }
        
        .totals-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 15px 0 0 0;
            gap: 15px;
        }
        
        .totals-bar label {
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
            font-size: 13px;
            font-weight: 600;
            color: #4e5e71;
        }
        
        .totals-bar input {
            width: 120px;
            text-align: right;
            font-weight: bold;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
             $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#accountDetailsWindow').jqxWindow('close');
             
             $('#multiSearchWindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Ticket  Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#multiSearchWindow').jqxWindow('close');
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
             
             $("#postingJV").jqxGrid({ disabled: true});
             
             $('#date').on('change', function (event) {
                 var maindate = $('#date').jqxDateTimeInput('getDate');
                 funDateInPeriod(maindate);
             });
             
             $('#txttypeaccid').dblclick(function(){
                 if(document.getElementById("cmbtype").value!=""){
                     $('#accountDetailsWindow').jqxWindow('open');
                     commenSearchContent('accountsDetailsSearch.jsp?cmbtype='+document.getElementById("cmbtype").value);
                 } else {
                     $.messager.alert('Message','Select Type.','warning');
                     return 0;
                 }
             }); 
             
             $('#btnticketadd').click(function(){
                 if(document.getElementById("chkticketno").checked==true){
                     var branch=$('#cmbbranch').val();
                     var fromdate=$('#fromdate').jqxDateTimeInput('val');
                     var todate=$('#todate').jqxDateTimeInput('val');
                     var type=$('#cmbtype').val();
                     var acno=$('#txtaccid').val();
                     $('#multiSearchWindow').jqxWindow('open');
                     $('#multiSearchWindow').jqxWindow('focus');
                     multiSearchContent('multiSearchMaster.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+'&acno='+acno);
                 }
             });
        });

        function commenSearchContent(url) {
            $.get(url).done(function (data) {
                $('#accountDetailsWindow').jqxWindow('open');
                $('#accountDetailsWindow').jqxWindow('setContent', data);
            }); 
        }   

        function multiSearchContent(url) {
            $.get(url).done(function (data) {
                $('#multiSearchWindow').jqxWindow('setContent', data);
            }); 
        }   

        function funExportBtn(){
            if(parseInt(window.parent.chkexportdata.value)=="1") {
                JSONToCSVCon(data1, 'Traffic-Posting', true);
            } else {
                $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Traffic-Posting');
            }
        }

        function  getacc(event){
            var x= event.keyCode;
            if(x==114){
                if(document.getElementById("cmbtype").value!=""){
                    $('#accountDetailsWindow').jqxWindow('open');
                    commenSearchContent('accountsDetailsSearch.jsp?cmbtype='+document.getElementById("cmbtype").value);
                } else {
                    $.messager.alert('Message','Select Type.','warning');
                    return 0;
                }
            }
        }   
            
        function funreload(event){
            var branchval = document.getElementById("cmbbranch").value;
            
            if(branchval=="a"){
                $.messager.alert('Message','Choose A Specific Branch.','warning');
                return 0;
            }
            
            var fromdate = $('#fromdate').val();
            var todate = $('#todate').val();
            var paytype = $('#cmbtype').val();
            var txttypeaccid = $('#txttypeaccid').val();
            
            var maindate = $('#date').jqxDateTimeInput('getDate');
            var validdate=funDateInPeriod(maindate);
            if(validdate==0){
                return 0; 
            }
            
            if(paytype==''){
                $.messager.alert('Message','Please Choose Type.','warning');
                return 0;
            }
            
            if(fromdate==''){
                $.messager.alert('Message','Please Enter From Date.','warning');
                return 0;
            }
            
            if(todate==''){
                $.messager.alert('Message','Please Enter To Date.','warning');
                return 0;
            }
            
            if(txttypeaccid==''){
                $.messager.alert('Message','Search Account.','warning');
                return 0;
            }
            
            $("#postingJV").jqxGrid('clear');
            $("#overlay, #PleaseWait").show();

            var ticketno=$('#hidticketno').val();
            $("#postingCashDiv").load("postingTrafficgrid.jsp?fromdate="+fromdate+'&todate='+todate+'&chk='+"GO&ticketno="+ticketno);
        }

        function funCalculate(){
            var branchval = document.getElementById("cmbbranch").value;
            var txttypeaccid = document.getElementById("txttypeaccid").value;
            
            if(branchval=="a"){
                $.messager.alert('Message','Choose A Specific Branch.','warning');
                return 0;
            }
            
            var maindate = $('#date').jqxDateTimeInput('getDate');
            var validdate=funDateInPeriod(maindate);
            if(validdate==0){
                return 0; 
            }
            
            if($('#cmbtype').val()==''){
                 $.messager.alert('Message','Please Choose Type.','warning');
                 return 0;
            }
            
            if(txttypeaccid==''){
                 $.messager.alert('Message','Search Account.','warning');
                 return 0;
            }
                
            document.getElementById("calcu").value=1;
            
            var rows = $('#postingJV').jqxGrid('getrows');
            var rowlength= rows.length;
            if(rowlength!=0){
                $.messager.alert('Message','Already calculated.Submit Again. ','warning');
                return 0;
            } else{
                $("#postingJV").jqxGrid('clear');
            }
            
            var temp1="";
                
            $("#overlay, #PleaseWait").show();
            var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
            
            if(selectedrows.length==0){
                $("#overlay, #PleaseWait").hide();
                $.messager.alert('Warning','Select Items to be Calculated.');
                return false;
            }
            
            var rows = $('#postingJV').jqxGrid('getrows');
            var rowlength= rows.length;
            if(rowlength==0){
                $("#postingJV").jqxGrid('addrow', null, {});
                $("#postingJV").jqxGrid('addrow', null, {});
            }
            $("#postingJV").jqxGrid({ disabled: false});
                
            var rows = $("#jqxFleetGrid").jqxGrid('getrows');
            
            if(rows.length==1 && (rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount=="")){
                return false;
            }
            
            var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
            selectedrows = selectedrows.sort(function(a,b){return a - b});
            if(selectedrows.length==0){
                $("#overlay, #PleaseWait").hide();
                $.messager.alert('Warning','Select Items to be Calculated.');
                return false;
            }
            
            var i=0;var temp="";
            $('#gridlength').val(selectedrows.length);
            var j=0;
            var k=0;
            for (i = 0; i < rows.length; i++) {
                if(selectedrows[j]==i){
                    $("#jqxFleetGrid").jqxGrid('setcellvalue', i, "totalamount", $('#jqxFleetGrid').jqxGrid('getcellvalue', i, "amount"));
                    if(k==0){
                        k=10;
                        temp=rows[i].ticket_no;
                    } else{
                        temp=temp+"::"+rows[i].ticket_no;
                    }
                    temp1=temp;
                    j++; 
                }
            }
            
            $('#txttrno').val(temp1);
            $("#overlay, #PleaseWait").hide();
        }

        function getAccounts(){
            document.getElementById("txttypeaccid").value="";
            document.getElementById("txttypeaccname").value="";
            
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var docNoItems = items[0];
                    var accountIdItems  = items[1];
                    var accountItems = items[2];
                    var accountTypeItems = items[3];
                    var accountCurIdItems  = items[4];
                    var accountRateItems = items[5];
                    var accCurrTypeItems = items[6];

                    $('#txtdocno').val(docNoItems); 
                    $('#txtaccid').val(accountIdItems);
                    $('#txtaccname').val(accountItems);
                    $('#txtatype').val(accountTypeItems);
                    $('#txtcurid').val(accountCurIdItems);
                    $('#txtrate').val(accountRateItems);
                    $('#txtcurtype').val(accCurrTypeItems);
                }
            }
            x.open("GET", "getAccounts.jsp?paytype="+$('#fromdate').val(), true);
            x.send();
        }
            
        function funNotify(){   
            var maindate = $('#todate').jqxDateTimeInput('getDate');
            var validdate=funDateInPeriod(maindate);
            if(validdate==0){
                return 0; 
            }
    
            if(document.getElementById("calcu").value==""){
                $.messager.alert('Warning','Calculate & then Generate.');
                return false;
            }
                
            var paytype = $('#cmbtype').val();
            
            if(paytype==""){
                var rows = $("#jqxFleetGrid").jqxGrid('getrows');                    
                if(rows.length>0 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
                    return false;
                }
                
                var branchval = document.getElementById("cmbbranch").value;
                var txttypeaccid = document.getElementById("txttypeaccid").value;
                
                if(branchval=="a"){
                    $.messager.alert('Message','Choose A Specific Branch.','warning');
                    return 0;
                }
                if(paytype==''){
                    $.messager.alert('Message','Please Choose Type.','warning');
                    return 0;
                }
                if(txttypeaccid==''){
                    $.messager.alert('Message','Search Account.','warning');
                    return 0;
                }
                
                var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
                if(selectedrows.length==0){
                    $.messager.alert('Warning','Select Items,Calculate & then Generate.');
                    return false;
                }
            }
            
            $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
                if (r){
                    var rows = $("#postingJV").jqxGrid('getrows');
                    var length=0;
                    for(var i=0 ; i < rows.length ; i++){
                        var chk=rows[i].docno;
                        if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "test"+length)
                            .attr("name", "test"+length)
                            .attr("hidden", "true");
                            length=length+1;
                            
                            var amount,baseamount,id;
                            if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
                                 amount=rows[i].credit*-1;
                                 baseamount=rows[i].baseamount*-1;
                                 id=-1;
                            }
                            
                            if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
                                 amount=rows[i].debit;
                                 baseamount=rows[i].baseamount;
                                 id=1;
                            }
                            
                            newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::0::"+id+":: :: ");
                            newTextBox.appendTo('form');
                        }
                    }
                    $('#jvgridlength').val(length);
                    
                    document.getElementById("mode").value='A';
                    $("#overlay, #PleaseWait").show();
                    document.getElementById("frmDashboardPostings").submit();
                }
            });
            return 1;
        } 

        function funClearInfo()
        {
            document.getElementById("txttypeaccid").value="";
            document.getElementById("txttypedocno").value="";
            document.getElementById("txttypeatype").value="";
            document.getElementById("txttypecurid").value="";
            document.getElementById("txttyperate").value ="";
            document.getElementById("txttypetype").value=""; 
            document.getElementById("txttrno").value="";
            document.getElementById("txtaccid").value=""; 
            document.getElementById("txtaccname").value="";
            document.getElementById("txtdocno").value=""; 
            document.getElementById("txtatype").value="";
            document.getElementById("txtcurid").value=""; 
            document.getElementById("txtrate").value="";
            document.getElementById("txtrate").value="";
            document.getElementById("txtcurtype").value="";
            document.getElementById("hidticketno").value="";
            document.getElementById("ticketdetails").value="";
        }
            
        function setValues(){
            document.getElementById("cmbtype").value="";
            
            if($('#hidfromdate').val()){
                 $("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
            }

            if($('#hidtodate').val()){
                 $("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
            }
            
            if($('#hiddate').val()){
                 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
            }

            if($('#msg').val()!=""){
                 $.messager.alert('Message',$('#msg').val());
                 var fromdate = $('#fromdate').val();
                 var todate = $('#todate').val();
                 $("#postingCashDiv").load("postingTrafficgrid.jsp?fromdate="+fromdate+'&todate='+todate+'&chk='+"GO");
            }
            $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
        }
        </script>
    </head>
    
    <body onload="getBranch();setValues();">
        <form id="frmDashboardPostings" action="saveDbTrafficPosting" method="post" style="height: 100%;">
            
            <div id="mainBG" class="homeContent"> 
                <div class="master-container">

                    <!-- ================= LEFT SIDEBAR ================= -->
                    <div class="sidebar-filters">
                        
                        <div class="sidebar-scroll-content">
                            
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">From</td>
                                        <td>
                                            <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                                            <input type="hidden" id="hidfromdate" name="hidfromdate" value='<s:property value="hidfromdate"/>'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To</td>
                                        <td>
                                            <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                            <input type="hidden" id="hidtodate" name="hidtodate" value='<s:property value="hidtodate"/>'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Type</td>
                                        <td>
                                            <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>' onchange="getAccounts();">
                                                <option value="">--Select--</option>
                                                <option value="1">Cash</option>
                                                <option value="2">Bank</option>
                                                <option value="3">GL</option>
                                            </select>
                                            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>' />
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Account</td>
                                        <td>
                                            <input type="text" id="txttypeaccid" name="txttypeaccid" placeholder="Press F3 To search" readonly value='<s:property value="txttypeaccid"/>' tabindex="-1" onkeydown="getacc(event);"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell"></td>
                                        <td>
                                            <input type="text" id="txttypeaccname" name="txttypeaccname" readonly value='<s:property value="txttypeaccname"/>' tabindex="-1"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="padding-top: 5px;">
                                            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 6px;">
                                                <input type="checkbox" name="chkticketno" id="chkticketno">
                                                <label for="chkticketno" class="label-cell" style="text-align: left; width: auto; padding: 0;">Ticket No</label>
                                                <button type="button" name="btnticketadd" id="btnticketadd" class="btn-submit mini-btn" style="background:#475569 !important;">+</button>
                                                <button type="button" name="btnticketremove" id="btnticketremove" class="btn-submit mini-btn" style="background:#ef4444 !important;" onClick="funTicketRemove();">-</button>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                
                                <div style="margin-top: 10px;">
                                    <textarea id="ticketdetails" style="height:100px;" placeholder="Ticket details..."></textarea>
                                </div>
                            </div>

                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Post Date</td>
                                        <td>
                                            <div id="date" name="date" value='<s:property value="date"/>'></div>
                                            <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
                                        </td>
                                    </tr>
                                </table>

                                <div class="action-buttons">
                                    <button type="button" class="btn-submit btn-clear" name="clear" id="clear" onclick="funClearInfo();">Clear</button>
                                    <button type="button" class="btn-submit" id="btnGenerate" name="btnGenerate" onclick="funNotify();">Post</button>
                                </div>
                            </div>

                            <!-- Hidden Fields -->
                            <div style="display:none;">
                                <input type="hidden" id="txttypedocno" name="txttypedocno" value='<s:property value="txttypedocno"/>'/>
                                <input type="hidden" id="txttypeatype" name="txttypeatype" value='<s:property value="txttypeatype"/>'/>
                                <input type="hidden" id="txttypecurid" name="txttypecurid" value='<s:property value="txttypecurid"/>'/>
                                <input type="hidden" id="txttyperate" name="txttyperate" value='<s:property value="txttyperate"/>'/>
                                <input type="hidden" id="txttypetype" name="txttypetype" value='<s:property value="txttypetype"/>'/>
                                <input type="hidden" name="txttrno" id="txttrno" value='<s:property value="txttrno"/>'>
                                <input type="hidden" id="txtaccid" name="txtaccid" value='<s:property value="txtaccid"/>' />      
                                <input type="hidden" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>'/>      
                                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>      
                                <input type="hidden" id="txtatype" name="txtatype" value='<s:property value="txtatype"/>'/> 
                                <input type="hidden" id="txtcurid" name="txtcurid" value='<s:property value="txtcurid"/>'/>      
                                <input type="hidden" id="txtrate" name="txtrate" value='<s:property value="txtrate"/>'/> 
                                <input type="hidden" id="txtcurtype" name="txtcurtype" value='<s:property value="txtcurtype"/>'/>
                                <input type="hidden" id="gridlength" name="gridlength"/>
                                <input type="hidden" id="jvgridlength" name="jvgridlength"/>
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="calcu" id="calcu" value='<s:property value="calcu"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                                <input type="hidden" name="hidticketno" id="hidticketno">
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="postingCashDiv" style="flex: 1; min-height: 250px; margin-bottom: 15px;">
                                <jsp:include page="postingTrafficgrid.jsp"></jsp:include>
                            </div>

                            <div id="JVTDiv" style="flex: 1; min-height: 250px;">
                                <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
                            </div>
                            
                            <div class="totals-bar">
                                <label>Dr. Total :</label>
                                <input type="text" id="txtdrtotal" name="txtdrtotal" readonly value='<s:property value="txtdrtotal"/>'/>
                                
                                <label>Cr. Total :</label>
                                <input type="text" id="txtcrtotal" name="txtcrtotal" readonly value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="accountDetailsWindow"><div></div><div></div></div>
            <div id="multiSearchWindow"><div></div><div></div></div>
            
        </form>
    </body>
</html>