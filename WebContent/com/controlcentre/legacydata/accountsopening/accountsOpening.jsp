<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i) - Accounts Opening</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Master UI Standard)
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

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		$('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountDetailsWindow').jqxWindow('close');
		
		$('#openingBalanceGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#openingBalanceGridWindow').jqxWindow('close');
		
		$('#txtaccid').dblclick(function(){
			 accountSearchContent("clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val());
	     });
	});
	
	function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function OpeningSearchContent(url) {
		$('#openingBalanceGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#openingBalanceGridWindow').jqxWindow('setContent', data);
		$('#openingBalanceGridWindow').jqxWindow('bringToFront');
	}); 
	} 

	function getAcc(event){
	    var x= event.keyCode;
	    if(x==114){
	    	accountSearchContent("clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val());
	    }
	}
	
	function funExcelBtn() {
		  if ($("#mode").val() == "view") {
		  	 if(parseInt(window.parent.chkexportdata.value)=="1") {
			 	JSONToCSVCon(data1, 'AccountsOpening', true);
			 } else {
				 $("#jqxAppliedAccounts").jqxGrid('exportdata', 'xls', 'AccountsOpening');
			 }
		  }
	  }
	  
	function funReadOnly(){
		$('#frmAccountsOpening input').attr('readonly', true );
		$('#frmAccountsOpening select').attr('disabled', true);
	 	$("#jqxAppliedAccounts").jqxGrid({ disabled: true});
	}

	function funRemoveReadOnly(){
	    $('#frmAccountsOpening input').attr('readonly', false );
		$('#frmAccountsOpening select').attr('disabled', false);
		$('#txtaccountcurrency').attr('readonly', true );
		$('#txtaccid').attr('readonly', true );
		$('#txtaccname').attr('readonly', true );
	    $('#txtdebittotal').attr('readonly', true );
	    $('#txtcredittotal').attr('readonly', true );
	    $('#txtnettotal').attr('readonly', true );
		$("#jqxAppliedAccounts").jqxGrid({ disabled: false});
		
		 if ($("#mode").val() == "A") {
			 $("#jqxAppliedAccounts").jqxGrid('clear');
			 $("#jqxAppliedAccounts").jqxGrid('addrow', null, {});
		}  
	}

	function funSearchLoad(){
	 	 changeContent('opnMainSearch.jsp', $('#window'));  
	}

	function funChkButton(){
		/* funReset(); */
	}

	function funFocus(){
		document.getElementById("cmbacctype").focus();
	}

	function funNotify(){	
	  
	   /* Validation */
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
			 return 0;
		 } 
		document.getElementById("errormsg").innerText="";
	  /* Validation Ends*/
			
	/* Accounts Invoice Grid Saving */
   	 var rows = $("#jqxAppliedAccounts").jqxGrid('getrows');
   	 var length=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].doc_no;
			var chks=rows[i].baseamount;
			if(typeof(chk) == "undefined" && (typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "")){
				document.getElementById("errormsg").innerText="Doc No is Mandatory.";
				return 0;
			}
			document.getElementById("errormsg").innerText="";
			
			if(typeof(chk) != "undefined"){
				length=length+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
				.attr("hidden", "true");
				
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
			
			newTextBox.val(rows[i].doc_no+"::"+rows[i].date+":: "+rows[i].description+":: "+amount+":: "+baseamount+":: "+id+":: "+rows[i].tr_no);
			newTextBox.appendTo('form');
			}
		 }
		 $('#gridlength').val(length);
		/* Accounts Invoice Grid Saving Ends */
			 
			return 1;
	} 


	function setValues(){
	  
	  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  funSetlabel(); 
		
	  var indexVal = document.getElementById("txttrno").value;
	  if(indexVal>0){
       $("#jqxAppliedAccountsGrid").load("accountsInvoiceGrid.jsp?txttrno2="+indexVal); 
		 }
	}
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');$('#txtaccountcurrency').val('');$('#txtaccountcurrencyid').val('');$('#txtrate').val('');
		$('#hidcurrencytype').val('');$('#txtdebittotal').val('');$('#txtcredittotal').val('');$('#txtnettotal').val('');$('#txtbaseamount').val('');$('#txtvalidation').val('');
		$("#jqxAppliedAccounts").jqxGrid('clear'); 
		$("#jqxAppliedAccounts").jqxGrid('addrow', null, {});
	} 
</script>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAccountsOpening" action="saveAccountsOpening" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">Account Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Account Type</label>
            <select id="cmbacctype" name="cmbacctype" style="width:120px;" onchange="clearAccountInfo();" value='<s:property value="cmbacctype"/>'>
                <option value="BANK">Bank</option>
                <option value="GL">GL</option>
                <option value="AR">AR</option>
                <option value="AP">AP</option>
                <option value="HR">HR</option>
            </select>
            <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/>

            <div class="input-search-container" style="width: 120px; margin-left: 10px;">
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
                <svg class="magnifier-icon" onclick="accountSearchContent('<%=contextPath%>/clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input type="text" id="txtaccname" name="txtaccname" style="flex:1; margin-left: 10px;" tabindex="-1" value='<s:property value="txtaccname"/>' readonly />
            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Currency</label>
            <input type="text" id="txtaccountcurrency" name="txtaccountcurrency" readonly style="width:120px;" value='<s:property value="txtaccountcurrency"/>' tabindex="-1" />
            <input type="hidden" id="txtaccountcurrencyid" name="txtaccountcurrencyid" value='<s:property value="txtaccountcurrencyid"/>'/>
            <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>

            <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
            <input type="text" id="txtrate" name="txtrate" style="width:120px; text-align: right;" value='<s:property value="txtrate"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Opening Invoice/Cheque/Other Details</span>
        <div id="jqxAppliedAccountsGrid" class="grid-container">
            <jsp:include page="accountsInvoiceGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Debit Total</label>
            <input type="text" id="txtdebittotal" name="txtdebittotal" style="width:100px; text-align: right;" value='<s:property value="txtdebittotal"/>' tabindex="-1" readonly />
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Credit Total</label>
            <input type="text" id="txtcredittotal" name="txtcredittotal" style="width:100px; text-align: right;" value='<s:property value="txtcredittotal"/>' tabindex="-1" readonly />
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Net Total</label>
            <input type="text" id="txtnettotal" name="txtnettotal" style="width:100px; text-align: right;" value='<s:property value="txtnettotal"/>' tabindex="-1" readonly />
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Base Amount</label>
            <input type="text" id="txtbaseamount" name="txtbaseamount" style="width:100px; text-align: right;" value='<s:property value="txtbaseamount"/>' tabindex="-1" readonly />
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="applylength" name="applylength"/>
        <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
    </div>

</div>
</form>
	
<div id="accountDetailsWindow"><div></div><div></div></div>  
<div id="openingBalanceGridWindow"><div></div><div></div></div> 	

</div>
</body>
</html>