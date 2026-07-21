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
            width: 300px; 
            flex: 0 0 300px; 
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
        
        .document-label-bar {
            padding: 10px 15px 0 15px;
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
            font-size: 15px;
        }

        .accname {
            color: #0284c7;
            font-weight: bold;
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
             
             $('#txtaccid').dblclick(function(){
                  if($('#cmbtype').val()==''){
                     $.messager.alert('Message','Account Type is Mandatory.','warning');
                     return 0;
                  }
                  if($('#cmbtype').val()==null){
                     $.messager.alert('Message','Account Search Not Available.','warning');
                     return 0;
                  }
                  accountsSearchContent('accountsDetailsSearch.jsp');
             });
        });
        
        function accountsSearchContent(url) {
            $('#accountDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#accountDetailsWindow').jqxWindow('setContent', data);
                $('#accountDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        
        function getDocumentType() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var dtypeItems = items[0].split(",");
                    var menuItems = items[1].split(",");
                    var optionssalutn = '<option value="">--Select--</option>';
                    for (var i = 0; i < menuItems.length; i++) {
                        optionssalutn += '<option value="' + dtypeItems[i] + '">'
                                + menuItems[i] + '</option>';
                    }
                    $("select#cmbdoctype").html(optionssalutn);
                    if ($('#hidcmbdoctype').val() != null) {
                        $('#cmbdoctype').val($('#hidcmbdoctype').val());
                    }
                }
            }
            x.open("GET", "getDocumentType.jsp", true);
            x.send();
        } 
        
        function getAccTypeFrom(event){
            var x= event.keyCode;
            if(x==114){
                if($('#cmbtype').val()==''){
                    $.messager.alert('Message','Account Type is Mandatory.','warning');
                    return 0;
                }
                if($('#cmbtype').val()==null){
                    $.messager.alert('Message','Account Search Not Available.','warning');
                    return 0;
                }
                accountsSearchContent('accountsDetailsSearch.jsp');
            }
        }
            
        function funExportBtn(){
             var dtype=$('#cmbdoctype').val();
             if(dtype=='BPV' || dtype=='BRV' || dtype=='IBP' || dtype=='IBR'){
                 $("#bankDiv").excelexportjs({
                        containerid: "bankDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxBankVoucher",
                        columns: getColumns("jqxBankVoucher"),
                        worksheetName: dtype+"Voucher"
                    });
             } else if(dtype=='CPV' || dtype=='CRV' || dtype=='ICPV' || dtype=='ICRV' || dtype=='PC' || dtype=='FCR'){
                 $("#cashDiv").excelexportjs({
                        containerid: "cashDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxCashVoucher",
                        columns: getColumns("jqxCashVoucher"),
                        worksheetName: dtype+"Voucher"
                    });
             } else if(dtype=='COT'){
                 $("#contraDiv").excelexportjs({
                        containerid: "contraDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxContraTransVoucher",
                        columns: getColumns("jqxContraTransVoucher"),
                        worksheetName: "ContraTransVoucher"
                    });
             } else if(dtype=='CNO' || dtype=='DNO' || dtype=='TCN' || dtype=='TDN'){
                 $("#creditDiv").excelexportjs({
                        containerid: "creditDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxCreditDebitVoucher",
                        columns: getColumns("jqxCreditDebitVoucher"),
                        worksheetName: dtype+"Voucher"
                    });
             } else if(dtype=='JVT' || dtype=='IJV'){
                 $("#journalDiv").excelexportjs({
                        containerid: "journalDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxJournalVoucher",
                        columns: getColumns("jqxJournalVoucher"),
                        worksheetName: dtype+"Voucher"
                    });
             } else if(dtype=='PRIV'){
                 $("#propertyDiv").excelexportjs({
                        containerid: "propertyDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxPropertyInvoice",
                        columns: getColumns("jqxPropertyInvoice"),
                        worksheetName: "PropertyInvoice"
                    });
             } else if(dtype=='SEC'){
                 $("#securityChqDiv").excelexportjs({
                        containerid: "securityChqDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "securityChequeList",
                        columns: getColumns("securityChequeList"),
                        worksheetName: "SecurityCheque"
                    });
             } else if(dtype=='UCP' || dtype=='UCR'){
                 $("#unclearedChqDiv").excelexportjs({
                        containerid: "unclearedChqDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxUnclearedChequeVoucher",
                        columns: getColumns("jqxUnclearedChequeVoucher"),
                        worksheetName: dtype+"Voucher"
                    });
             } else if(dtype=='MCP'){
                 $("#mcpDiv").excelexportjs({
                        containerid: "mcpDiv",
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxMCP",
                        columns: getColumns("jqxMCP"),
                        worksheetName: "MultipleCashPurchase"    
                    });
             }
        } 
        
        function isNumber(evt) {
            var iKeyCode = (evt.which) ? evt.which : evt.keyCode
            if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
              $.messager.alert('Message',' Enter Numbers Only ','warning');   
                return false;
             }
            return true;
        }

        function funClearInfo(){
            $('#cmbbranch').val('a');
            $('#fromdate').val(new Date());
            var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
            var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
            var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
            $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
             
            $('#todate').val(new Date());
            
            document.getElementById("lbldoctype").innerHTML="";
            document.getElementById("cmbdoctype").value="";
            document.getElementById("txtdocrangefrom").value="";
            document.getElementById("txtdocrangeto").value="";
            document.getElementById("txtamtrangefrom").value="";
            document.getElementById("txtamtrangeto").value="";
            document.getElementById("cmbtype").value="";
            document.getElementById("txtaccid").value="";
            document.getElementById("txtaccname").value="";
            document.getElementById("txtdocno").value="";
            
            $("#jqxMCP").jqxGrid('clear');$("#jqxCashVoucher").jqxGrid('clear');$("#jqxBankVoucher").jqxGrid('clear');$("#jqxCreditDebitVoucher").jqxGrid('clear');$("#jqxJournalVoucher").jqxGrid('clear');
            $("#jqxContraTransVoucher").jqxGrid('clear');$("#securityChequeList").jqxGrid('clear');$("#jqxUnclearedChequeVoucher").jqxGrid('clear');$("#jqxPropertyInvoice").jqxGrid('clear');
            
            $("#jqxMCP").jqxGrid('addrow', null, {});$("#jqxCashVoucher").jqxGrid('addrow', null, {});$("#jqxBankVoucher").jqxGrid('addrow', null, {});$("#jqxCreditDebitVoucher").jqxGrid('addrow', null, {});
            $("#jqxJournalVoucher").jqxGrid('addrow', null, {});$("#jqxContraTransVoucher").jqxGrid('addrow', null, {});$("#securityChequeList").jqxGrid('addrow', null, {});
            $("#jqxUnclearedChequeVoucher").jqxGrid('addrow', null, {});$("#jqxPropertyInvoice").jqxGrid('addrow', null, {});
             
            $("#cashDiv").show();
            $("#bankDiv, #creditDiv, #journalDiv, #contraDiv, #securityChqDiv, #unclearedChqDiv, #propertyDiv, #mcpDiv").hide();
            
            if (document.getElementById("txtaccid").value == "") {
                 $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
            }
        }

        function docTypeInfo(){
             document.getElementById("lbldoctype").innerHTML="";
             document.getElementById("txtdocrangefrom").value="";
             document.getElementById("txtdocrangeto").value="";
             document.getElementById("txtamtrangefrom").value="";
             document.getElementById("txtamtrangeto").value="";
             document.getElementById("cmbtype").value="";
             document.getElementById("txtaccid").value="";
             document.getElementById("txtaccname").value="";
             document.getElementById("txtdocno").value="";
             
             $("#jqxMCP").jqxGrid('clear');$("#jqxCashVoucher").jqxGrid('clear');$("#jqxBankVoucher").jqxGrid('clear');$("#jqxCreditDebitVoucher").jqxGrid('clear');$("#jqxJournalVoucher").jqxGrid('clear');
             $("#jqxContraTransVoucher").jqxGrid('clear');$("#securityChequeList").jqxGrid('clear');$("#jqxUnclearedChequeVoucher").jqxGrid('clear');$("#jqxPropertyInvoice").jqxGrid('clear');
             
             $("#jqxMCP").jqxGrid('addrow', null, {});$("#jqxCashVoucher").jqxGrid('addrow', null, {});$("#jqxBankVoucher").jqxGrid('addrow', null, {});$("#jqxCreditDebitVoucher").jqxGrid('addrow', null, {});
             $("#jqxJournalVoucher").jqxGrid('addrow', null, {});$("#jqxContraTransVoucher").jqxGrid('addrow', null, {});$("#securityChequeList").jqxGrid('addrow', null, {});
             $("#jqxUnclearedChequeVoucher").jqxGrid('addrow', null, {});$("#jqxPropertyInvoice").jqxGrid('addrow', null, {});
             
             $("#cashDiv").show();
             $("#bankDiv, #creditDiv, #journalDiv, #contraDiv, #securityChqDiv, #unclearedChqDiv, #propertyDiv, #mcpDiv").hide();
             
             if($('#cmbdoctype').val()=='FCR'){
                 $('#cmbtype').attr('disabled', true);
             }else{
                 $('#cmbtype').attr('disabled', false);
             }
             
             if (document.getElementById("txtaccid").value == "") {
                 $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
             }
        }
        
        function clearAccountInfo(){
            $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
            if (document.getElementById("txtaccid").value == "") {
                 $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
            }
        } 
        
        function funreload(event){
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var acctype = $('#cmbtype').val();
             var accdocno = $('#txtdocno').val();
             var dtype=$('#cmbdoctype').val();
             var docrangefrom=$('#txtdocrangefrom').val();
             var docrangeto=$('#txtdocrangeto').val();
             var amtrangefrom=$('#txtamtrangefrom').val();
             var amtrangeto=$('#txtamtrangeto').val();
             var chk=1;
            
             if(dtype==''){
                 $.messager.alert('Message','Please Choose Document Type.','warning');
                 return 0;
             }
            
             var documenttype='';
             if(dtype=='CRV'){documenttype='Listing of Cash Receipt Voucher (CRV)';}if(dtype=='CPV'){documenttype='Listing of Cash Payment Voucher (CPV)';}
             if(dtype=='BRV'){documenttype='Listing of Bank Receipt Voucher (BRV)';}if(dtype=='BPV'){documenttype='Listing of Bank Payment Voucher (BPV)';}
             if(dtype=='CNO'){documenttype='Listing of Credit Note (CNO)';}if(dtype=='DNO'){documenttype='Listing of Debit Note (DNO)';}
             if(dtype=='TCN'){documenttype='Listing of Tax Credit Note (TCN)';} if(dtype=='TDN'){documenttype='Listing of Tax Debit Note (TDN)';}   
             if(dtype=='JVT'){documenttype='Listing of Journal Voucher (JVT)';}if(dtype=='IJV'){documenttype='Listing of IB-Journal Voucher (IJV)';}
             if(dtype=='PC'){documenttype='Listing of Petty Cash (PC)';}if(dtype=='COT'){documenttype='Listing of Contra Trans (COT)';}
             if(dtype=='SEC'){documenttype='Listing of Security Cheque (SEC)';}if(dtype=='UCP'){documenttype='Listing of Uncleared Cheque Payment (UCP)';}
             if(dtype=='UCR'){documenttype='Listing of Uncleared Cheque Receipt (UCR)';}if(dtype=='FCR'){documenttype='Listing of Fuel Card Reimbursement (FCR)';}
             if(dtype=='ICRV'){documenttype='Listing of IB-Cash Receipt Voucher (ICRV)';}if(dtype=='ICPV'){documenttype='Listing of IB-Cash Payment Voucher (ICPV)';}
             if(dtype=='IBR'){documenttype='Listing of IB-Bank Receipt Voucher (IBR)';}if(dtype=='IBP'){documenttype='Listing of IB-Bank Payment Voucher (IBP)';}
             if(dtype=='PRIV'){documenttype='Listing of Property Invoice (PRIV)';}if(dtype=='PRIV'){documenttype='Listing of Property Invoice (PRIV)';}
             if(dtype=='MCP'){documenttype='Listing of Multiple Cash Purchase (MCP)';}  
            
             $("#overlay, #PleaseWait").show();  
            
             document.getElementById("lbldoctype").innerText=documenttype; 
             
             if(dtype=='CRV' || dtype=='CPV' || dtype=='ICRV' || dtype=='ICPV' || dtype=='PC' || dtype=='FCR'){
                 $("#cashDiv").show();
                 $("#mcpDiv, #unclearedChqDiv, #securityChqDiv, #contraDiv, #bankDiv, #creditDiv, #journalDiv, #propertyDiv").hide();
                 $("#cashDiv").load("cashVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             } else if(dtype=='BRV' || dtype=='BPV' || dtype=='IBR' || dtype=='IBP'){
                 $("#bankDiv").show();
                 $("#mcpDiv, #unclearedChqDiv, #securityChqDiv, #contraDiv, #creditDiv, #cashDiv, #journalDiv, #propertyDiv").hide();
                 $("#bankDiv").load("bankVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             } else if(dtype=='CNO' || dtype=='DNO' || dtype=='TCN' || dtype=='TDN'){   
                 $("#creditDiv").show();
                 $("#mcpDiv, #unclearedChqDiv, #securityChqDiv, #contraDiv, #bankDiv, #cashDiv, #journalDiv, #propertyDiv").hide();
                 $("#creditDiv").load("creditVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             } else if(dtype=='COT'){
                 $("#contraDiv").show();
                 $("#mcpDiv, #unclearedChqDiv, #securityChqDiv, #creditDiv, #bankDiv, #cashDiv, #journalDiv, #propertyDiv").hide();
                 $("#contraDiv").load("contraTransVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             } else if(dtype=='SEC'){
                 $("#securityChqDiv").show();
                 $("#mcpDiv, #unclearedChqDiv, #contraDiv, #creditDiv, #bankDiv, #cashDiv, #journalDiv, #propertyDiv").hide();
                 $("#securityChqDiv").load("securityCheque.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             } else if(dtype=='UCP' || dtype=='UCR'){
                 $("#unclearedChqDiv").show();
                 $("#mcpDiv, #securityChqDiv, #contraDiv, #creditDiv, #bankDiv, #cashDiv, #journalDiv, #propertyDiv").hide();
                 $("#unclearedChqDiv").load("unclearedVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             } else if(dtype=='JVT' || dtype=='IJV'){
                 $("#journalDiv").show();
                 $("#mcpDiv, #unclearedChqDiv, #securityChqDiv, #contraDiv, #creditDiv, #bankDiv, #cashDiv, #propertyDiv").hide();
                 $("#journalDiv").load("journalVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             } else if(dtype=='MCP'){    
                 $("#mcpDiv").show();
                 $("#unclearedChqDiv, #securityChqDiv, #contraDiv, #creditDiv, #bankDiv, #cashDiv, #journalDiv, #propertyDiv").hide();
                 $("#mcpDiv").load("multipleCashPurchaseGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                                     +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             } else {
                 $("#propertyDiv").show();
                 $("#mcpDiv, #unclearedChqDiv, #securityChqDiv, #contraDiv, #creditDiv, #bankDiv, #cashDiv, #journalDiv").hide();
                 $("#propertyDiv").load("propertyVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
             }
        }
        </script>
    </head>
    
    <body onload="getBranch();getDocumentType();">
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

                        <!-- Document Filter Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Dtype</td>
                                    <td>
                                        <select id="cmbdoctype" name="cmbdoctype" onchange="docTypeInfo();" value='<s:property value="cmbdoctype"/>'>
                                            <option value="">--Select--</option>
                                        </select>
                                        <input type="hidden" id="hidcmbdoctype" name="hidcmbdoctype" value='<s:property value="hidcmbdoctype"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Doc. Range</td>
                                    <td>
                                        <div style="display: flex; gap: 5px; align-items: center;">
                                            <input type="text" id="txtdocrangefrom" name="txtdocrangefrom" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdocrangefrom"/>'/>
                                            <span>-</span>
                                            <input type="text" id="txtdocrangeto" name="txtdocrangeto" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdocrangeto"/>'/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Amt. Range</td>
                                    <td>
                                        <div style="display: flex; gap: 5px; align-items: center;">
                                            <input type="text" id="txtamtrangefrom" name="txtamtrangefrom" style="text-align: right;" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangefrom"/>'/>
                                            <span>-</span>
                                            <input type="text" id="txtamtrangeto" name="txtamtrangeto" style="text-align: right;" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangeto"/>'/>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <!-- Account Settings Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Type</td>
                                    <td>
                                        <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
                                            <option value="">--Select--</option>
                                            <option value="AP">AP</option>
                                            <option value="AR">AR</option>
                                            <option value="GL">GL</option>
                                            <option value="HR">HR</option>
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
                            </div>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>
                    
                    <div class="document-label-bar">
                        <label class="accname" name="lbldoctype" id="lbldoctype"></label>
                    </div>

                    <div class="grid-content-container">
                        <div id="cashDiv" class="grid-wrapper">
                            <jsp:include page="cashVoucher.jsp"></jsp:include>
                        </div>
                        <div id="bankDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="bankVoucher.jsp"></jsp:include>
                        </div>
                        <div id="creditDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="creditVoucher.jsp"></jsp:include>
                        </div>
                        <div id="journalDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="journalVoucher.jsp"></jsp:include>
                        </div>
                        <div id="contraDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="contraTransVoucher.jsp"></jsp:include>
                        </div>
                        <div id="securityChqDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="securityCheque.jsp"></jsp:include>
                        </div>
                        <div id="propertyDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="propertyVoucher.jsp"></jsp:include>
                        </div>
                        <div id="unclearedChqDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="unclearedVoucher.jsp"></jsp:include>
                        </div>
                        <div id="mcpDiv" class="grid-wrapper" style="display:none;">
                            <jsp:include page="multipleCashPurchaseGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="accountDetailsWindow"><div></div><div></div></div>

        </div>
    </body>
</html>