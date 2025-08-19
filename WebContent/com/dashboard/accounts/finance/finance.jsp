<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
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
			} else {
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
        else{}
        }
		
	function funExportBtn(){
		 var dtype=$('#cmbdoctype').val();
		 if(dtype=='BPV'){
			 
			 $("#bankDiv").excelexportjs({
					containerid: "bankDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxBankVoucher",
					columns: getColumns("jqxBankVoucher"),
					worksheetName: "BankPaymentVoucher"
				});
		 }
       if(dtype=='BRV'){
			 
			 $("#bankDiv").excelexportjs({
					containerid: "bankDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxBankVoucher",
					columns: getColumns("jqxBankVoucher"),
					worksheetName: "BankReceiptVoucher"
				});
		 }
       if(dtype=='IBP'){
			 
			 $("#bankDiv").excelexportjs({
					containerid: "bankDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxBankVoucher",
					columns: getColumns("jqxBankVoucher"),
					worksheetName: "IBBankPaymentVoucher"
				});
		 }
       if(dtype=='IBR'){
			 
			 $("#bankDiv").excelexportjs({
					containerid: "bankDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxBankVoucher",
					columns: getColumns("jqxBankVoucher"),
					worksheetName: "IBBankReceiptVoucher"
				});
		 }
       if(dtype=='CPV'){
			 
			 $("#cashDiv").excelexportjs({
					containerid: "cashDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCashVoucher",
					columns: getColumns("jqxCashVoucher"),
					worksheetName: "CashPaymentVoucher"
				});
		 }
       if(dtype=='CRV'){
			 
			 $("#cashDiv").excelexportjs({
					containerid: "cashDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCashVoucher",
					columns: getColumns("jqxCashVoucher"),
					worksheetName: "CashReceiptVoucher"
				});
		 }
       if(dtype=='ICPV'){
			 
			 $("#cashDiv").excelexportjs({
					containerid: "cashDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCashVoucher",
					columns: getColumns("jqxCashVoucher"),
					worksheetName: "IBCashPaymentVoucher"
				});
		 }
       if(dtype=='ICRV'){
			 
			 $("#cashDiv").excelexportjs({
					containerid: "cashDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCashVoucher",
					columns: getColumns("jqxCashVoucher"),
					worksheetName: "IBCashReceiptVoucher"
				});
		 }
       if(dtype=='PC'){
			 
			 $("#cashDiv").excelexportjs({
					containerid: "cashDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCashVoucher",
					columns: getColumns("jqxCashVoucher"),
					worksheetName: "PettyCashVoucher"
				});
		 }
       if(dtype=='FCR'){
			 
			 $("#cashDiv").excelexportjs({
					containerid: "cashDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCashVoucher",
					columns: getColumns("jqxCashVoucher"),
					worksheetName: "FuelCardReimbursement"
				});
		 }
       if(dtype=='COT'){
			 
			 $("#contraDiv").excelexportjs({
					containerid: "contraDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxContraTransVoucher",
					columns: getColumns("jqxContraTransVoucher"),
					worksheetName: "ContraTransVoucher"
				});
		 }
       if(dtype=='CNO'){
			 
			 $("#creditDiv").excelexportjs({
					containerid: "creditDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCreditDebitVoucher",
					columns: getColumns("jqxCreditDebitVoucher"),
					worksheetName: "CreditVoucher"
				});
		 }
       if(dtype=='DNO'){
			 
			 $("#creditDiv").excelexportjs({
					containerid: "creditDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCreditDebitVoucher",
					columns: getColumns("jqxCreditDebitVoucher"),
					worksheetName: "DebitVoucher"
				});
		 }
       if(dtype=='TCN'){  
			 
			 $("#creditDiv").excelexportjs({
					containerid: "creditDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCreditDebitVoucher",
					columns: getColumns("jqxCreditDebitVoucher"),
					worksheetName: "Tax Credit Note"
				});
		 }
       if(dtype=='TDN'){
			 
			 $("#creditDiv").excelexportjs({
					containerid: "creditDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxCreditDebitVoucher",
					columns: getColumns("jqxCreditDebitVoucher"),
					worksheetName: "Tax Debit Note"
				});
		 }
       if(dtype=='JVT'){
			 
			 $("#journalDiv").excelexportjs({
					containerid: "journalDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxJournalVoucher",
					columns: getColumns("jqxJournalVoucher"),
					worksheetName: "JournalVoucher"
				});
		 }
       if(dtype=='IJV'){
			 
			 $("#journalDiv").excelexportjs({
					containerid: "journalDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxJournalVoucher",
					columns: getColumns("jqxJournalVoucher"),
					worksheetName: "IBJournalVoucher"
				});
		 }
       if(dtype=='PRIV'){
			 
			 $("#propertyDiv").excelexportjs({
					containerid: "propertyDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxPropertyInvoice",
					columns: getColumns("jqxPropertyInvoice"),
					worksheetName: "PropertyInvoice"
				});
		 }
       if(dtype=='SEC'){
			 
			 $("#securityChqDiv").excelexportjs({
					containerid: "securityChqDiv",
					datatype: 'json',
					dataset: null,
					gridId: "securityChequeList",
					columns: getColumns("securityChequeList"),
					worksheetName: "SecurityCheque"
				});
		 }
       if(dtype=='UCP'){
			 
			 $("#unclearedChqDiv").excelexportjs({
					containerid: "unclearedChqDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxUnclearedChequeVoucher",
					columns: getColumns("jqxUnclearedChequeVoucher"),
					worksheetName: "UnclearedChequePaymentVoucher"
				});
		 }
       if(dtype=='UCR'){
			 
			 $("#unclearedChqDiv").excelexportjs({
					containerid: "unclearedChqDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxUnclearedChequeVoucher",
					columns: getColumns("jqxUnclearedChequeVoucher"),
					worksheetName: "UnclearedChequeReceiptVoucher"
				});
		 }
       if(dtype=='MCP'){
			 $("#mcpDiv").excelexportjs({
					containerid: "mcpDiv",
					datatype: 'json',
					dataset: null,
					gridId: "jqxMCP",
					columns: getColumns("jqxMCP"),
					worksheetName: "MultipleCashPurchase"    
				});
		 }
		 /* if(dtype=='CRV'){JSONToCSVCon(dataExcelExport, 'CashReceiptVoucher', true);}if(dtype=='CPV'){JSONToCSVCon(dataExcelExport, 'CashPaymentVoucher', true);}
		 if(dtype=='BRV'){JSONToCSVCon(dataExcelExport1, 'BankReceiptVoucher', true);}if(dtype=='BPV'){JSONToCSVCon(dataExcelExport1, 'BankPaymentVoucher', true);}
		 if(dtype=='CNO'){JSONToCSVCon(dataExcelExport2, 'CreditVoucher', true);}if(dtype=='DNO'){JSONToCSVCon(dataExcelExport2, 'DebitVoucher', true);}
		 if(dtype=='JVT'){JSONToCSVCon(dataExcelExport3, 'JournalVoucher', true);}if(dtype=='IJV'){JSONToCSVCon(dataExcelExport3, 'IBJournalVoucher', true);}
		 if(dtype=='PC'){JSONToCSVCon(dataExcelExport, 'PettyCashVoucher', true);}if(dtype=='COT'){JSONToCSVCon(dataExcelExport4, 'ContraTransVoucher', true);}
		 if(dtype=='SEC'){JSONToCSVCon(dataExcelExport5, 'SecurityCheque', true);}if(dtype=='UCP'){JSONToCSVCon(dataExcelExport6, 'UnclearedChequePaymentVoucher', true);}
		 if(dtype=='UCR'){JSONToCSVCon(dataExcelExport6, 'UnclearedChequeReceiptVoucher', true);}if(dtype=='FCR'){JSONToCSVCon(dataExcelExport, 'FuelCardReimbursement', true);}
		 if(dtype=='ICRV'){JSONToCSVCon(dataExcelExport, 'IBCashReceiptVoucher', true);}if(dtype=='ICPV'){JSONToCSVCon(dataExcelExport, 'IBCashPaymentVoucher', true);}
		 if(dtype=='IBR'){JSONToCSVCon(dataExcelExport1, 'IBBankReceiptVoucher', true);}if(dtype=='IBP'){JSONToCSVCon(dataExcelExport1, 'IBBankPaymentVoucher', true);}
		 if(dtype=='PRIV'){JSONToCSVCon(dataExcelExport1, 'PropertyInvoice', true);}if(dtype=='PRIV'){JSONToCSVCon(dataExcelExport1, 'PropertyInvoice', true);}
	     */
	} 
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }

	function  funClearInfo(){
		
		$('#cmbbranch').val('a');
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
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
		 
		$("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);
		$("#securityChqDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true); $("#mcpDiv").prop("hidden", true);
		
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
			 
			$("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);
			$("#securityChqDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true); $("#mcpDiv").prop("hidden", true);
			
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
			 $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
				 $("#cashDiv").load("cashVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
						 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
		 } else if(dtype=='BRV' || dtype=='BPV' || dtype=='IBR' || dtype=='IBP'){
			 $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", false);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
			 $("#bankDiv").load("bankVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     } else if(dtype=='CNO' || dtype=='DNO' || dtype=='TCN' || dtype=='TDN'){   
	    	 $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
			 $("#creditDiv").load("creditVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     } else if(dtype=='COT'){
	    	 $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", false);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
			 $("#contraDiv").load("contraTransVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     } else if(dtype=='SEC'){
	    	 $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", false);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
			 $("#securityChqDiv").load("securityCheque.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     } else if(dtype=='UCP' || dtype=='UCR'){
	    	 $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", false);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
			 $("#unclearedChqDiv").load("unclearedVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     }else if(dtype=='JVT' || dtype=='IJV'){
	    	 $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#journalDiv").prop("hidden", false);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
			 $("#journalDiv").load("journalVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
		 }else if(dtype=='MCP'){    
			 $("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);$("#mcpDiv").prop("hidden", false);
			 $("#mcpDiv").load("multipleCashPurchaseGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
			 					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     }else {
	    	 $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", false);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);
			 $("#propertyDiv").load("propertyVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
		 }
		 
		}
	
</script>
</head>
<body onload="getBranch();getDocumentType();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">Period</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td align="right"><label class="branch">Dtype</label></td>
	<td align="left"><select id="cmbdoctype" name="cmbdoctype" style="width:90%;" onchange="docTypeInfo();" value='<s:property value="cmbdoctype"/>'>
    <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbdoctype" name="hidcmbdoctype" value='<s:property value="hidcmbdoctype"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Doc. Range</label></td>
	<td align="left"><input type="text" id="txtdocrangefrom" name="txtdocrangefrom" style="width:40%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdocrangefrom"/>'/>&nbsp;-&nbsp;
	<input type="text" id="txtdocrangeto" name="txtdocrangeto" style="width:40%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdocrangeto"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Amount Range</label></td>
	<td align="left"><input type="text" id="txtamtrangefrom" name="txtamtrangefrom" style="width:40%;height:20px;text-align: right;" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangefrom"/>'/>&nbsp;-&nbsp;
	<input type="text" id="txtamtrangeto" name="txtamtrangeto" style="width:40%;height:20px;text-align: right;" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangeto"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="AP">AP</option><option value="AR">AR</option><option value="GL">GL</option>
    <option value="HR">HR</option></select></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
	    <!-- <tr><td><label class="account">Document Type :&nbsp;</label>--> <tr><td><label class="accname" name="lbldoctype" id="lbldoctype"></label></td></tr> 
		<tr>
			 <td><div id="cashDiv"><jsp:include page="cashVoucher.jsp"></jsp:include></div>
			 <div id="bankDiv" hidden="true"><jsp:include page="bankVoucher.jsp"></jsp:include></div>
			 <div id="creditDiv" hidden="true"><jsp:include page="creditVoucher.jsp"></jsp:include></div>
			 <div id="journalDiv" hidden="true"><jsp:include page="journalVoucher.jsp"></jsp:include></div>
			 <div id="contraDiv" hidden="true"><jsp:include page="contraTransVoucher.jsp"></jsp:include></div>
			 <div id="securityChqDiv" hidden="true"><jsp:include page="securityCheque.jsp"></jsp:include></div>
			 <div id="propertyDiv" hidden="true"><jsp:include page="propertyVoucher.jsp"></jsp:include></div>
			 <div id="unclearedChqDiv" hidden="true"><jsp:include page="unclearedVoucher.jsp"></jsp:include></div>
			 <div id="mcpDiv" hidden="true"><jsp:include page="multipleCashPurchaseGrid.jsp"></jsp:include></div></td>  
		</tr>   
	</table>
</tr>
</table>
</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>