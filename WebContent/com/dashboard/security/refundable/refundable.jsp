<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <% String contextPath=request.getContextPath();%>
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
            width: 320px; /* Slightly wider for the extra inputs */
            flex: 0 0 320px; 
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
            width: 90px;
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
        .filter-table input:disabled,
        .filter-table select:disabled {
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

        .btn-small-icon {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0 4px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-small-icon img {
            width: 16px;
            height: 16px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .action-buttons .btn-submit {
            flex: 1;
            min-width: 80px;
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
        #refundableDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            flex: 1;
        }
        
        .net-balance-container {
            padding: 15px 0 0 0;
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }
        
        .net-balance-label {
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-right: 10px;
        }
        
        .net-balance-input {
            width: 120px !important;
            text-align: right;
            font-weight: bold;
            font-size: 14px !important;
            background-color: #f8fafc !important;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#chqdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
             $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#accountDetailsWindow').jqxWindow('close');
            
             $('#branchSearchWindow').jqxWindow({width: '20%', height: '58%',  maxHeight: '60%' ,maxWidth: '30%' , title: 'Branch Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#branchSearchWindow').jqxWindow('close');
            
             $('#cardDetailsWindow').jqxWindow({width: '30%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#cardDetailsWindow').jqxWindow('close');
            
              $('#agmtDetailsWindow').jqxWindow({width: '30%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Agreement Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#agmtDetailsWindow').jqxWindow('close');
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
             document.getElementById("hidchckibbranch").value=0;
             
             $('#txtclientaccount').dblclick(function(){
                  accountsSearchContent('clientDetailsSearch.jsp');
             });
              
             $('#txttypeaccid').dblclick(function(){
                  accountsSearchContent('accountsDetailsSearch.jsp');
             });
              
             $('#txtibbranch').dblclick(function(){
                  branchSearchContent('branchSearchGrid.jsp?check=1');
             });
              
             $('#cmbtype').attr('disabled', true );
             $('#txttypeaccid').attr('readonly', true );
             $('#txtchequeno').attr('readonly', true );
             $('#txtremarks').attr('readonly', true );
             $('#txtibbranch').attr('disabled', true );
             $('#btnRefund').attr('disabled', true );
             $('#btnRelease').attr('disabled', true );
             $('#date').jqxDateTimeInput({disabled: true});
             $('#chqdate').jqxDateTimeInput({disabled: true});
             $('#cmbcardtype').attr('disabled', true );
             $('#btnCardSearch').attr('disabled', true);
             
             $('#txtnetamount').val('0.00'); // Initial state based on code logic
        });
        
        function accountsSearchContent(url) {
            $('#accountDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#accountDetailsWindow').jqxWindow('setContent', data);
                $('#accountDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        
        function branchSearchContent(url) {
            $('#branchSearchWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#branchSearchWindow').jqxWindow('setContent', data);
                $('#branchSearchWindow').jqxWindow('bringToFront');
            }); 
        } 
        
        function cardSearchContent(url) {
            $('#cardDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#cardDetailsWindow').jqxWindow('setContent', data);
                $('#cardDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        function agmtSearchContent(url) {
            $('#agmtDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#agmtDetailsWindow').jqxWindow('setContent', data);
                $('#agmtDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        function funChangeAgreement(){
         var doc= $('#txtclientdocno').val();
            agmtSearchContent('agmtsearchGrid.jsp?cldoc='+doc);
        }
        
        function isNumber(evt) {
            var iKeyCode = (evt.which) ? evt.which : evt.keyCode
            if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
              $.messager.alert('Message',' Enter Numbers Only ','warning');   
                return false;
             }
            return true;
        }
        
        function getAccounts(a,b){
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
                    var payTypeItems = items[7];
                    
                 if(parseInt(payTypeItems)==1 || parseInt(payTypeItems)==3){
                    $('#txttypedocno').val(docNoItems); 
                    $('#txttypeaccid').val(accountIdItems);
                    $('#txttypeaccname').val(accountItems);
                    $('#txttypeatype').val(accountTypeItems);
                    $('#txttypecurid').val(accountCurIdItems);
                    $('#txttyperate').val(accountRateItems);
                    $('#txttypetype').val(accCurrTypeItems);
                 }
            }
            }
            x.open("GET", "getAccounts.jsp?paytype="+a+"&date="+b, true);
            x.send();
        }
        
        function getCardTypes() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var cardIdItems  = items[0].split(",");
                    var cardItems = items[1].split(",");
                    var optionscard = '<option value="">--Select--</option>';
                    for (var i = 0; i < cardItems.length; i++) {
                        optionscard += '<option value="' + cardIdItems[i].trim() + '">'
                                + cardItems[i] + '</option>';
                    }
                    $("select#cmbcardtype").html(optionscard);
                    if ($('#hidcmbcardtype').val() != null) {
                        $('#cmbcardtype').val($('#hidcmbcardtype').val());
                    }
                }
            }
            x.open("GET", "getCardTypes.jsp", true);
            x.send();
        }
        
        function getClient(event){
          var x= event.keyCode;
          if(x==114){
              accountsSearchContent('clientDetailsSearch.jsp');
          }
        }
        
        function getAccType(event){
            var x= event.keyCode;
            if(x==114){
              accountsSearchContent('accountsDetailsSearch.jsp');
            }
        }
        
        function getIbBranch(event){
            var x= event.keyCode;
            if(x==114){
                branchSearchContent('branchSearchGrid.jsp?check=1');
            }
        }
        
        function funCardSearch(){
            cardSearchContent('cardDetailsSearchGrid.jsp');
        }
        
        function ibbranchcheck(){
             if(document.getElementById("chckibbranch").checked){
                 document.getElementById("hidchckibbranch").value = 1;
                 $('#txtibbranch').attr('disabled', false );
             } else {
                 document.getElementById("hidchckibbranch").value = 0;
                 $('#txtibbranchid').val('0');$('#txtibbranch').val('');
                 $('#txtibbranch').attr('disabled', true );
                
                 if (document.getElementById("txtibbranch").value == "") {
                        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
                  }
             }
         }
        
        function funreload(event){
             var branchval = document.getElementById("cmbbranch").value;
             var uptodate = $('#uptodate').val();
             var agreementcloseddays = $('#txtagreementcloseddays').val();
             var clientAccount = $('#txtcldocno').val();
            
             $("#overlay, #PleaseWait").show();
             $("#refundableDiv").load("refundGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&agreementcloseddays='+agreementcloseddays.replace(/ /g, "%20")+'&chk=1&clientAccount='+clientAccount);
        }
        
        function funClearInfo(){
            $('#cmbbranch').val('a');
            $('#uptodate').val(new Date());$('#date').val(new Date());$('#chqdate').val(new Date());
        
            $('#txtagreementcloseddays').val('');$('#txtclientaccount').val('');$('#txtclientname').val('');$('#txtcldocno').val('');$('#clientinfo').val('');
            $('#txtnetamount').val('0.00');
            
            document.getElementById("hidchckibbranch").value = 0;
             if(document.getElementById("hidchckibbranch").value==0){
                 document.getElementById("chckibbranch").checked = false;
             }
             $('#txtibbranchid').val('0');$('#txtibbranch').val('');
             $('#cmbtype').val('');$('#hidcmbtype').val('');$('#txttypedocno').val('');$('#txttypeaccid').val('');
             $('#txttypeaccname').val('');$('#txttypeatype').val('');$('#txttypecurid').val('');$('#txttyperate').val('');
             $('#txttypetype').val('');$('#txtchequeno').val('');$('#txtremarks').val('');

             $('#cmbtype').attr('disabled', true );$('#txttypeaccid').attr('readonly', true );
             $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
             $('#txtchequeno').attr('readonly', true );$('#txtremarks').attr('readonly', true );$('#txtibbranch').attr('disabled', true );
             $('#btnRefund').attr('disabled', true );$('#btnRelease').attr('disabled', true );$('#date').jqxDateTimeInput({disabled: true});
             $('#chqdate').jqxDateTimeInput({disabled: true});$('#btnCardSearch').attr('disabled', true);
             $("#jqxRefund").jqxGrid('clear');$("#jqxRefund").jqxGrid('addrow', null, {});
            
            if (document.getElementById("txtagreementcloseddays").value == "") {
                    $('#txtagreementcloseddays').attr('placeholder', 'Agreement Closed Days'); 
            }
              
             if (document.getElementById("txtclientaccount").value == "") {
                    $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); 
             }
            
             if (document.getElementById("txtibbranch").value == "") {
                    $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
              }
        }
        
        function bankAccountSearch(){
             if(document.getElementById("cmbtype").value == 2){
                 $('#txttypedocno').val('');$('#txttypeaccid').val('');$('#txttypeaccname').val('');
                 $('#txttypeatype').val('');$('#txttypecurid').val('');$('#txttyperate').val('');
                 $('#txttypetype').val('');$('#txtchequeno').attr('readonly', false );
                 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
                 $('#btnCardSearch').attr('disabled', true);
                 $('#chqdate').jqxDateTimeInput({disabled: false});
                
                 if (document.getElementById("txttypeaccid").value == "") {
                        $('#txttypeaccid').attr('placeholder', 'Press F3 to Search'); 
                    }
                 $('#txttypeaccid').focus();
             } else if(document.getElementById("cmbtype").value == 3){
                 $('#txttypeaccid').attr('tabindex', '-1');
                 $('#txttypeaccname').attr('tabindex', '-1');
                 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', false );
                 $('#txtchequeno').attr('readonly', false );
                 $('#btnCardSearch').attr('disabled', false);
                 $('#chqdate').jqxDateTimeInput({disabled: false});
             } else {
                 $('#txttypeaccid').attr('tabindex', '-1');
                 $('#txttypeaccname').attr('tabindex', '-1');
                 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
                 $('#txtchequeno').attr('readonly', true );
                 $('#btnCardSearch').attr('disabled', true);
                 $('#chqdate').jqxDateTimeInput({disabled: true});
             }
         }
        
        function funRefund(event){
            var refunddate = $('#date').val();
            var ibbranch = $('#txtibbranchid').val();
            var chckibbranch = $('#hidchckibbranch').val();
            var type = $('#cmbtype').val();
            var typeaccount = $('#txttypedocno').val();
            var chequeno = $('#txtchequeno').val();
            var remarks = $('#txtremarks').val();
            var clientaccount = $('#txtclaccount').val();
            var clientdocno = $('#txtclientdocno').val();
            var clientname = $('#txtclname').val();
            var rano = $('#txtrano').val();
            var rtype = $('#txtrtype').val();
            var mainbrhid = $('#txtmainbrhid').val();
            var securityamount = $('#txtsecurityamount').val();
            var balanceamount = $('#txtbalanceamount').val();
            var cardtype = $('#cmbcardtype').val();
            var process="REFUNDED";
            
            if(type==''){
                 $.messager.alert('Message','Please Choose a Type.','warning');
                 return 0;
             }
            
            if(typeaccount==''){
                 $.messager.alert('Message','Please Choose an Account.','warning');
                 return 0;
             }
            
            if(securityamount.trim()==''){
                 $.messager.alert('Message','Security Amount Unavailable, Transaction Restricted.','warning');
                 return 0;
             }
            
            if(($('#hidchckibbranch').val()=='1') && ($('#txtibbranchid').val()=='0')){
                 $.messager.alert('Message','Please Choose Inter-Branch.','warning');
                 return 0;
            }
            
            ibvalid=document.getElementById("txtibvalidation").value;
              if(ibvalid==1){
                 $.messager.alert('Message','Closing Done For Inter-Branch,Transaction Restricted.','warning');
                 return 0;
              }
              
            if(remarks==''){
                $.messager.alert('Message','Please Enter Remarks.','warning');
                return 0;
            }
            
            var date = $('#date').jqxDateTimeInput('getDate');
            var validdate=funDateInPeriod(date);
            if(validdate==0){
                return 0;   
            }
            
            $.messager.confirm('Message', 'Do you want to Refund Security?', function(r){
                if(r==false) {
                    return false; 
                } else{
                     $('#chqdate').jqxDateTimeInput({disabled: false});
                     var chequedate = $('#chqdate').val();
                     saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process);   
                }
             });
        }
        
        function funRelease(event){
            var refunddate = $('#date').val();
            var ibbranch = $('#txtibbranchid').val();
            var chckibbranch = $('#hidchckibbranch').val();
            var type = $('#cmbtype').val();
            var typeaccount = $('#txttypedocno').val();
            var chequeno = $('#txtchequeno').val();
            var remarks = $('#txtremarks').val();
            var clientaccount = $('#txtclaccount').val();
            var clientdocno = $('#txtclientdocno').val();
            var clientname = $('#txtclname').val();
            var rano = $('#txtrano').val();
            var rtype = $('#txtrtype').val();
            var mainbrhid = $('#txtmainbrhid').val();
            var securityamount = $('#txtsecurityamount').val();
            var balanceamount = $('#txtbalanceamount').val();
            var cardtype = $('#cmbcardtype').val();
            var process="RELEASED";
            
            if(securityamount.trim()==''){
                 $.messager.alert('Message','Security Amount Unavailable, Transaction Restricted.','warning');
                 return 0;
             }
              
            if(remarks==''){
                $.messager.alert('Message','Please Enter Remarks.','warning');
                return 0;
            }
            
            var date = $('#date').jqxDateTimeInput('getDate');
            var validdate=funDateInPeriod(date);
            if(validdate==0){
                return 0;   
            }
            
            $.messager.confirm('Message', 'Do you want to Release Security?', function(r){
                if(r==false) {
                    return false; 
                } else {
                     $('#chqdate').jqxDateTimeInput({disabled: false});
                     var chequedate = $('#chqdate').val();
                     saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process);   
                }
             });
        }
        
        function saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                    var items=x.responseText;
                    items = items.split('***');
                    var val = items[0];
                    var rrpno = items[1];
                    var result = items[2];
                    
                    result = result.toLowerCase().replace(/\b[a-z]/g, function(letter) {
                        return letter.toUpperCase();
                    });
                    
                    $.messager.alert('Message', ''+result+' Successfully, Doc No. '+rrpno+'', function(r){});
                    
                  funClearInfo();
                  funreload(event); 
              }
            }
                
        x.open("GET","saveData.jsp?refunddate="+refunddate+"&ibbranch="+ibbranch+"&chckibbranch="+chckibbranch+"&type="+type+"&typeaccount="+typeaccount+"&chequeno="+chequeno+"&chequedate="+chequedate+"&remarks="+remarks+"&clientaccount="+clientaccount+"&clientdocno="+clientdocno+"&clientname="+clientname+"&rano="+rano+"&rtype="+rtype+"&mainbranch="+mainbrhid+"&securityamount="+securityamount+"&balanceamount="+balanceamount+"&cardtype="+cardtype+"&process="+process,true);
        x.send();
        }
        
        function funExportBtn(){
             if(parseInt(window.parent.chkexportdata.value)=="1") {
                JSONToCSVCon(data, 'SecurityRefund', true);
             } else {
                 $("#jqxRefund").jqxGrid('exportdata', 'xls', 'SecurityRefund');
             }
         }
        </script>
    </head>
    
    <body onload="getBranch();getCardTypes();">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Search Filters Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Up To</td>
                                    <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Closed Before</td>
                                    <td><input type="text" id="txtagreementcloseddays" name="txtagreementcloseddays" placeholder="Agreement Closed Days" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtagreementcloseddays"/>'/></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Client</td>
                                    <td>
                                        <div style="display: flex; gap: 5px;">
                                            <input type="text" id="txtclientaccount" name="txtclientaccount" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientaccount"/>' onkeydown="getClient(event);"/>
                                            <button type="button" class="btn-small-icon" id="btnchngagmt" title="Change Agreement" onclick="funChangeAgreement();">
                                                <img alt="Change Agreement" src="<%=contextPath%>/icons/add_new.png">
                                            </button>
                                        </div>
                                        <input type="hidden" id="hiddocno" name="hiddocno" readonly="readonly" value='<s:property value="hiddocno"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell"></td>
                                    <td>
                                        <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" value='<s:property value="txtclientname"/>' tabindex="-1"/>
                                        <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                                    </td>
                                </tr>
                            </table>
                            
                            <div style="margin-top: 10px;">
                                <textarea id="clientinfo" name="clientinfo" readonly="readonly" rows="3"><s:property value="clientinfo" ></s:property></textarea>
                            </div>
                        </div>

                        <!-- Payment Processing Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Date</td>
                                    <td>
                                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                                        <input type="hidden" id="hiddate" name="hiddate" readonly="readonly" value='<s:property value="hiddate"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Branch</td>
                                    <td>
                                        <div style="display: flex; gap: 5px; align-items: center;">
                                            <input type="text" id="txtibbranch" name="txtibbranch" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtibbranch"/>' onkeydown="getIbBranch(event);"/>
                                            <input type="checkbox" id="chckibbranch" name="chckibbranch" value="" onchange="ibbranchcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
                                        </div>
                                        <input type="hidden" id="txtibbranchid" name="txtibbranchid" readonly="readonly" value='<s:property value="txtibbranchid"/>'/>
                                        <input type="hidden" id="hidchckibbranch" name="hidchckibbranch" readonly="readonly" value='<s:property value="hidchckibbranch"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Type</td>
                                    <td>
                                        <select id="cmbtype" name="cmbtype" onchange="bankAccountSearch();getAccounts(this.value,$('#date').val());" value='<s:property value="cmbtype"/>'>
                                            <option value="">--Select--</option>
                                            <option value="1">Cash</option>
                                            <option value="2">Cheque/Online</option>
                                            <option value="3">Paid to Card</option>
                                        </select>
                                        <input type="hidden" id="hidcmbtype" name="hidcmbtype" readonly="readonly" value='<s:property value="hidcmbtype"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Account</td>
                                    <td>
                                        <input type="text" id="txttypeaccid" name="txttypeaccid" readonly="readonly" value='<s:property value="txttypeaccid"/>' onkeydown="getAccType(event);" tabindex="-1"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell"></td>
                                    <td>
                                        <input type="text" id="txttypeaccname" name="txttypeaccname" readonly="readonly" value='<s:property value="txttypeaccname"/>' tabindex="-1"/>
                                        <input type="hidden" id="txttypedocno" name="txttypedocno" readonly="readonly" value='<s:property value="txttypedocno"/>'/>
                                        <input type="hidden" id="txttypeatype" name="txttypeatype" readonly="readonly" value='<s:property value="txttypeatype"/>'/>
                                        <input type="hidden" id="txttypecurid" name="txttypecurid" readonly="readonly" value='<s:property value="txttypecurid"/>'/>
                                        <input type="hidden" id="txttyperate" name="txttyperate" readonly="readonly" value='<s:property value="txttyperate"/>'/>
                                        <input type="hidden" id="txttypetype" name="txttypetype" readonly="readonly" value='<s:property value="txttypetype"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Card Type</td>
                                    <td>
                                        <div style="display: flex; gap: 5px;">
                                            <select id="cmbcardtype" name="cmbcardtype" value='<s:property value="cmbcardtype"/>'>
                                                <option value="">--Select--</option>
                                            </select>
                                            <button type="button" class="btn-small-icon" id="btnCardSearch" title="Search Card" onclick="funCardSearch();">
                                                <img alt="Search Card" src="<%=contextPath%>/icons/cardsearch.png">
                                            </button>
                                        </div>
                                        <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" readonly="readonly" value='<s:property value="hidcmbcardtype"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Cheque/Card No.</td>
                                    <td>
                                        <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Cheque/Card Date</td>
                                    <td>
                                        <div id="chqdate" name="chqdate" value='<s:property value="chqdate"/>'></div>
                                        <input type="hidden" id="hidchqdate" name="hidchqdate" readonly="readonly" value='<s:property value="hidchqdate"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Remarks</td>
                                    <td>
                                        <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/>
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="action-buttons">
                                <button type="button" id="btnRefund" name="btnRefund" class="btn-submit btn-save" onclick="funRefund(event);">Refund</button>
                                <button type="button" id="btnRelease" name="btnRelease" class="btn-submit btn-save" onclick="funRelease(event);" style="background: #eab308 !important;">Release</button>
                                <button type="button" name="clear" id="clear" class="btn-submit btn-clear" onclick="funClearInfo();">Clear</button>
                            </div>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" id="txtclientdocno" name="txtclientdocno" value='<s:property value="txtclientdocno"/>'/>
                            <input type="hidden" id="txtclaccount" name="txtclaccount" value='<s:property value="txtclaccount"/>'/>
                            <input type="hidden" id="txtclname" name="txtclname" value='<s:property value="txtclname"/>'/>
                            <input type="hidden" id="txtrano" name="txtrano" value='<s:property value="txtrano"/>'/>
                            <input type="hidden" id="txtrtype" name="txtrtype" value='<s:property value="txtrtype"/>'/>
                            <input type="hidden" id="txtmainbrhid" name="txtmainbrhid" value='<s:property value="txtmainbrhid"/>'/>
                            <input type="hidden" id="txtsecurityamount" name="txtsecurityamount" value='<s:property value="txtsecurityamount"/>'/>
                            <input type="hidden" id="txtbalanceamount" name="txtbalanceamount" value='<s:property value="txtbalanceamount"/>'/>
                            <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
                            <input type="hidden" id="txthidtype" name="txthidtype" value='<s:property value="txthidtype"/>'/>
                            <input type="hidden" id="txthidtrno" name="txthidtrno" value='<s:property value="txthidtrno"/>'/>
                            <input type="hidden" id="txthidvoc" name="txthidvoc" value='<s:property value="txthidvoc"/>'/>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="refundableDiv">
                            <jsp:include page="refundGrid.jsp"></jsp:include>
                        </div>
                        
                        <div class="net-balance-container">
                            <span class="net-balance-label">Net Balance :</span>
                            <input type="text" class="filter-table input[type='text'] net-balance-input" id="txtnetamount" name="txtnetamount" readonly="readonly" value='<s:property value="txtnetamount"/>'/>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="accountDetailsWindow"><div></div><div></div></div>
            <div id="branchSearchWindow"><div></div><div></div></div>
            <div id="cardDetailsWindow"><div></div><div></div></div>
            <div id="agmtDetailsWindow"><div></div><div></div></div>

        </div>
    </body>
</html>