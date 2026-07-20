<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 $("#jqxContraTransDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailWindow').jqxWindow('close');
		 
		 $('#jqxContraTransDate').on('change', function (event) {
			 var contradate = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			 var validdate=funDateInPeriod(contradate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			    return 0;	
		     }
		 });
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtype').val()+"&date="+date);
			  $('#txtfromorto').val(2);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtotype').val()+"&date="+date);
			  $('#txtfromorto').val(3);
			  });  
		 
	});
	
	function AccountSearchContent(url) {
		$('#accountDetailWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailWindow').jqxWindow('setContent', data);
		$('#accountDetailWindow').jqxWindow('bringToFront');
	}); 
	} 
  
	  function getBranch() {
		  var branch=$('#brchName').val();
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var branchIdItems  = items[0].split(",");
					var branchItems = items[1].split(",");
					var optionsbranch = '<option value="">--Select--</option>';
					for (var i = 0; i < branchItems.length; i++) {
						if(parseInt(branch)!=parseInt(branchIdItems[i].trim())){
						optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
								+ branchItems[i] + '</option>';
								}
					}
					$("select#cmbbranch").html(optionsbranch);
					if ($('#hidcmbbranch').val() != null) {
						$('#cmbbranch').val($('#hidcmbbranch').val());
					}
				} else {
				}
			}
			x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
			x.send();
		}
	  
		  function getAccounts(){
		  		var x = new XMLHttpRequest();
		  		x.onreadystatechange = function() {
		  			if (x.readyState == 4 && x.status == 200) {
		  				var items = x.responseText;
		  			    $('#txtpdcacno').val(items);
		  		}
		  		}
		  		x.open("GET", "getAccounts.jsp", true);
		  		x.send();
		 }
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
			    	 $('#frmContraTrans input').attr('readonly', false );$('#frmContraTrans select').attr('disabled', false);$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
					 $('#txtrefno').attr('readonly', false );$('#txtdescription').attr('readonly', false );$('#txtfromaccid').attr('readonly', true );
					 $('#txtfromaccname').attr('readonly', true );$('#txttoaccid').attr('readonly', true );$('#txttoaccname').attr('readonly', true );
					 $('#docno').attr('readonly', true);$('#chckpdc').attr('disabled', false);$('#chckib').attr('disabled', false);  
			    }
			   });
	  }
	
	 function funReadOnly(){
		    $("#btnvaluechange").hide();
			$('#frmContraTrans input').attr('readonly', true );
			$('#frmContraTrans select').attr('disabled', true);
			$('#chckpdc').attr('disabled', true);
			$('#jqxContraTransDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    getBranch();checkIb();checkpdc();
		    
			$('#frmContraTrans input').attr('readonly', false );
			$('#frmContraTrans select').attr('disabled', false);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#jqxContraTransDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#cmbbranch').attr('disabled', true);
			$('#docno').attr('readonly', true);
			
			var date = $('#jqxContraTransDate').val();
		    getCurrencyId(date);
			
			if($('#cmbtype').val()=="CASH"){
	    		  $('#txtchequeno').attr('readonly', true);
	    		  $('#chckpdc').attr('disabled', true);
	    	  }
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmContraTrans input').attr('readonly', true );
         	   	$('#frmContraTrans select').attr('disabled', true);
         	    $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			 	$('#chckpdc').attr('disabled', true);
   			 	$('#chckib').attr('disabled', true);
			  }
			 else{
				$("#btnvaluechange").hide();
				$('#chckpdc').attr('disabled', false);
			}
			
	 }
	 
	 function funSearchLoad(){
		    changeContent('cotMainSearch.jsp');   
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxContraTransDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	   $(function(){
	        $('#frmContraTrans').validate({
	                rules: {
	                	txtfromaccid:"required",
		                txtfromamount:{number:true},
		                txttoamount:{number:true},
		                txttoaccid:"required",
	                    txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                	 txtfromaccid:" *",
		                 txtfromamount:{number:"Invalid"},
		                 txttoamount:{number:"Invalid"},
		                 txttoaccid:" *",
	                     txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
		  
		  	/* Validation */
		    var contradate = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(contradate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			    return 0;	
		    }
			
			ibvalid=document.getElementById("txtibvalidation").value;
			 if(ibvalid==1){
				 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
				 return 0;
			 }
			 
			pdcchequevalid=document.getElementById("txtpdcdatevalidation").value;
			 if(pdcchequevalid==1){
				 document.getElementById("errormsg").innerText="Invalid Cheque Date !!!";
				 return 0;
			 }
			 
		    var drtot = parseFloat(document.getElementById("txtfrombaseamount").value);
	 		var crtot = parseFloat(document.getElementById("txttobaseamount").value);
	 		
	 		if(drtot>crtot || drtot<crtot){
	 			document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
            return 0;
	 		}
	 		
	 		if(drtot=="" || crtot=="" ){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	              return 0;
		 		}

	 		if(isNaN(drtot) || isNaN(crtot)){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	              return 0;
		 		}
	 		
	 		if(drtot==0 || crtot==0){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	              return 0;
		 		}
	 		
	 		if(drtot==0.0 || crtot==0.0){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	              return 0;
		 		}
	 		
	 		if(drtot==0.00 || crtot==0.00){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	              return 0;
		 		}
	 		
	 		document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/
		  $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
		  $('#frmContraTrans select').attr('disabled', false);
		    	
	    	return 1;
		} 
	  
	  
	  function setValues(){
		  getBranch();checkIb();checkpdc();
		  
		  $('#jqxContraTransDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxContraTransDate').val();
		  getCurrencyId(date);
		  $('#jqxContraTransDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxContraTransDate').val()){
			 $("#jqxContraTransDate").jqxDateTimeInput('val', $('#hidjqxContraTransDate').val());
		  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  getBankReconciled($("#docno").val(), "COT"); 
		  
		     funRoundRate($('#txtfromamount').val(),"txtfromamount");
	         funRoundRate($('#txtfrombaseamount').val(),"txtfrombaseamount");
	         funRoundAmt($('#txttorate').val(),"txttorate");
	         funRoundAmt($('#txttoamount').val(),"txttoamount");
		     funRoundAmt($('#txtfromrate').val(),"txtfromrate");
		     funRoundAmt($('#txttobaseamount').val(),"txttobaseamount");
		}
	  
	  function funchequedate(){
		  if($('#cmbtype').val()=="BANK"){
			  $('#txtchequeno').attr('readonly', false);
			  $('#chckpdc').attr('disabled', false);
		  }
		  else if($('#cmbtype').val()=="CASH"){
    		  $('#txtchequeno').attr('readonly', true);
    		  $('#chckpdc').attr('disabled', true);
    		  $('#txtchequeno').val('');
    	  }
      }
	  
	  function funCheckIb(a){
		  if(document.getElementById("chckib").checked != false){
		 		 $('#hidchckib').val(1);
		 		 $('#cmbbranch').attr('disabled', false );
		  }
		  else{
			  $('#hidchckib').val(0); 
			  $('#cmbbranch').attr('disabled', true );
		  }
	  }
	  
	  function funCheck(a){
		  if(document.getElementById("chckpdc").checked != false){
		 		 $('#hidchckpdc').val(1);getAccounts();
		  }
		  else{
			  $('#hidchckpdc').val(0);  
		  }
	  }
	  
	  function checkIb(){
			 if(document.getElementById("hidchckib").value==1){
				 document.getElementById("chckib").checked = true;
			 }
			 else if(document.getElementById("hidchckib").value==0){
				document.getElementById("chckib").checked = false;
			  }
			 }
	  
	  function checkpdc(){
			 if(document.getElementById("hidchckpdc").value==1){
				 document.getElementById("chckpdc").checked = true;
			 }
			 else if(document.getElementById("hidchckpdc").value==0){
				document.getElementById("chckpdc").checked = false;
			  }
			 }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtype').val()+"&date="+date);
        	  $('#txtfromorto').val(2);  
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtotype').val()+"&date="+date);
        	  $('#txtfromorto').val(3);
          }
          else{
           }
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveContraTrans");
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printContraTrans?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printContraTrans?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function clearClientInfoFrom(){
		  $("#txtfromdocno").val('');$("#txtfromaccid").val('');$("#txtfromaccname").val('');
	  }
	  
	  function clearClientInfoTo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
	  }
	  
	  function datechange(){
		  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
			
			if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!=null){
		  	   var validibdate=funIBDateInPeriod($('#jqxContraTransDate').val(),$('#cmbbranch').val());
			   if(parseInt(validibdate)==0){
					document.getElementById("errormsg").innerText="Closing Done, Transaction Restricted.";
					return 0;	
		       }
		    }
		  
		  $("#maindate").jqxDateTimeInput('val', date);
		  funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));
	  }
	  
</script>

<style>
/* =========================================================
   SCOPED UI: Modern Layout Adapted for Table Structure
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

#frmContraTrans input[type="text"],
#frmContraTrans select,
.textbox { 
    height: 24px !important; 
    width: 100% !important;
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    box-shadow: none !important;
    outline: none;
}

#frmContraTrans input[type="text"]:focus,
#frmContraTrans select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmContraTrans input[readonly],
#frmContraTrans input:disabled,
#frmContraTrans select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

fieldset {
    border: 1px solid #c5d3e0; 
    padding: 8px 10px 8px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 10px;
    height: 100%; 
    box-sizing: border-box;
}

legend {
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    font-family: Arial, sans-serif;
    border-left: 3px solid #0056b3;
    line-height: normal; 
    margin-left: -2px; 
}

#frmContraTrans table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 8px; 
    table-layout: fixed; 
}

#frmContraTrans td {
    padding: 0 5px;
    vertical-align: middle;
    font-family: Arial, sans-serif; 
    font-size: 12px; 
    color: #333;
}

#frmContraTrans td[align="right"],
#frmContraTrans div[align="right"] {
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 10px;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.myButton, .myButtons {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
    display: inline-block;
    box-sizing: border-box;
}

.myButton:hover, .myButtons:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* JQX Widget Overrides for 24px Alignment */
.jqx-datetimeinput-input { 
    height: 24px !important; 
    line-height: 24px !important; 
    margin-top: 0px !important; 
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
}
.jqx-action-button {
    height: 24px !important;
}
</style>

</head>
<body onload="setValues();getBranch();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmContraTrans" action="saveContraTrans" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>

<fieldset>
    <legend>General Info</legend>
    <table width="100%">
      <tr>
        <td width="8%" align="right">Date</td>
        <td width="15%">
            <div id="jqxContraTransDate" name="jqxContraTransDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxContraTransDate"/>'></div>
            <input type="hidden" id="hidjqxContraTransDate" name="hidjqxContraTransDate" value='<s:property value="hidjqxContraTransDate"/>'/>
        </td>
        <td width="10%" align="right">Ref. No.</td>
        <td width="25%"><input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/></td>
        <td width="10%" align="right">Doc No.</td>
        <td width="32%">
            <div style="display: flex; align-items: center; gap: 8px;">
                <input type="text" id="docno" name="txtcontratransdocno" value='<s:property value="txtcontratransdocno"/>' tabindex="-1" readonly style="flex:1;"/>
                <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
            </div>
        </td>
      </tr>
      <tr>
        <td align="right">Description</td>
        <td colspan="5"><input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/></td>
      </tr>
    </table>
</fieldset>

<table width="100%">
<tr>
<td width="50%" style="vertical-align: top;">
<fieldset>
<legend>Payment From</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Type</td>
    <td width="16%"><select id="cmbtype" name="cmbtype" onchange="clearClientInfoFrom();funchequedate();" value='<s:property value="cmbtype"/>'>
    <option value="CASH">Cash</option><option value="BANK">Bank</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
    <td><input type="text" id="txtfromaccid" name="txtfromaccid" readonly placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtfromaccname" name="txtfromaccname" readonly value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td width="16%"><select id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxContraTransDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
      <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/></td>
    <td colspan="2" align="right">Rate</td>
    <td width="39%"><input type="text" id="txtfromrate" name="txtfromrate" style="text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();" tabindex="-1"/></td>
  </tr>
  <tr>
   <td align="right" style="white-space:nowrap;">
       <input type="checkbox" id="chckpdc" name="chckpdc" style="vertical-align: middle; margin-right: 4px; height:auto !important; width:auto !important;" onclick="funCheck();funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));"> PDC
   <input type="hidden" id="hidchckpdc" name="hidchckpdc" value='<s:property value="hidchckpdc"/>'/>
   <input type="hidden" id="txtpdcacno" name="txtpdcacno" value='<s:property value="txtpdcacno"/>'/></td>
   <td align="right">Cheque No.</td>
   <td width="17%"><input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>' /></td>
   <td width="21%" align="right">Cheque Date</td>
   <td align="left">
       <div id="jqxChequeDate" name="jqxChequeDate" onchange="funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));" value='<s:property value="jqxChequeDate"/>'></div>
       <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
   </td>
   </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtfromamount" name="txtfromamount" style="text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();" /></td>
    <td colspan="2"  align="right">Base Amount</td>
    <td><input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1" readonly/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%" style="vertical-align: top;">
<fieldset>
<legend>Payment To</legend>
<table width="100%">
<tr>
    <td colspan="2" align="center" style="white-space:nowrap;">
        <input type="checkbox" id="chckib" name="chckib" style="vertical-align: middle; margin-right: 4px; height:auto !important; width:auto !important;" onclick="funCheckIb();"> Inter-Branch
        <input type="hidden" id="hidchckib" name="hidchckib" value='<s:property value="hidchckib"/>'/>
    </td>
    <td width="20%" align="right">Branch</td>
    <td colspan="2"><select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>'>
      <option value=""></option></select>
    <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
  </tr>
  <tr>
    <td width="6%" align="right">Type</td>
    <td width="10%"><select id="cmbtotype" name="cmbtotype" onchange="clearClientInfoTo();" value='<s:property value="cmbtotype"/>'>
    <option value="CASH">Cash</option><option value="BANK">Bank</option></select>
    <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/></td>
    <td width="20%"><input type="text" id="txttoaccid" name="txttoaccid" readonly placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/></td>
    <td colspan="2"><input type="text" id="txttoaccname" name="txttoaccname" readonly value='<s:property value="txttoaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
    <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
    <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td colspan="2"><select id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxContraTransDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
      <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/></td>
    <td width="20%" align="right">Rate</td>
    <td width="57%"><input type="text" id="txttorate" name="txttorate" style="text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td colspan="2"><input type="text" id="txttoamount" name="txttoamount" style="text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" /></td>
    <td align="right">Base Amount</td>
    <td><input type="text" id="txttobaseamount" name="txttobaseamount" style="text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1" readonly/></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>

<div style="display:none;">
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtfromorto" id="txtfromorto" value='<s:property value="txtfromorto"/>'>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
<input type="hidden" id="txtpdcdatevalidation" name="txtpdcdatevalidation" value='<s:property value="txtpdcdatevalidation"/>'/>
</div>
</div>
</form>

<div id="accountDetailWindow">
	<div></div><div></div>
</div>

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 

</div>
</body>
</html>