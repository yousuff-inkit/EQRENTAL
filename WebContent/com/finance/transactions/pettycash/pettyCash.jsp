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

#frmPettyCash input[type="text"],
#frmPettyCash select,
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

#frmPettyCash input[type="text"]:focus,
#frmPettyCash select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmPettyCash input[readonly],
#frmPettyCash input:disabled,
#frmPettyCash select:disabled,
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

#frmPettyCash table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 8px; 
    table-layout: fixed; 
}

#frmPettyCash td {
    padding: 0 5px;
    vertical-align: middle;
    font-family: Arial, sans-serif; 
    font-size: 12px; 
    color: #333;
}

#frmPettyCash td[align="right"],
#frmPettyCash div[align="right"] {
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

#jqxPettyCashGrid {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
}

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

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
		 $("#jqxPettyCashDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 
         /* Force inner alignment for jqxDateTimeInput */
         setTimeout(function () {
             $("#jqxPettyCashDate, #maindate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#jqxPettyCashDate, #maindate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
         
		 $('#txtforsearch').val(2);
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');  
		 
		 $('#pettyCashGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#pettyCashGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxPettyCashDate').on('change', function (event) {
				var paydate = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
			    var validdate=funDateInPeriod(paydate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
	     });
		 
		 $('#txtaccid').dblclick(function(){
			  var date = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
        	  $('#txtforsearch').val(2);
		});
		 
	});
	
	function PettyCashSearchContent(url) {
		$('#pettyCashGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#pettyCashGridWindow').jqxWindow('setContent', data);
		$('#pettyCashGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountSearchContent(url) {
		    $('#accountDetailsFromWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsFromWindow').jqxWindow('setContent', data);
			$('#accountDetailsFromWindow').jqxWindow('bringToFront');
		}); 
		}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	

	
	 function funReadOnly(){
			$('#frmPettyCash input').attr('readonly', true );
			$('#frmPettyCash select').attr('disabled', true);
			$('#jqxPettyCashDate').jqxDateTimeInput({disabled: true});
			$("#jqxPettyCash").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmPettyCash input').attr('readonly', false );
			$('#frmPettyCash select').attr('disabled', false);
			
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtamount').attr('readonly', true );
			$('#txtbaseamount').attr('readonly', true );
			$('#jqxPettyCashDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxPettyCash").jqxGrid({ disabled: false});
			
			var date = $('#jqxPettyCashDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmPettyCash input').attr('readonly', true );
   			    $('#frmPettyCash select').attr('disabled', true);
			    $("#jqxPettyCash").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false);
   			    $("#jqxPettyCash").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxPettyCashDate').val(new Date());
				$("#jqxPettyCash").jqxGrid('clear'); 
				$("#jqxPettyCash").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('pcMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxPettyCashDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmPettyCash').validate({
	                rules: {
	                txtaccid:"required",
	                txtamount:{"required":true,number:true},
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtaccid:" *",
	                 txtamount:{required:" *",number:"Invalid"},
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){
			docno=document.getElementById("txtdocno").value;
		  if(docno==""){
				document.getElementById("errormsg").innerText="Select cash account.";
				return 0;	
			}
		  var summ= $("#jqxPettyCash").jqxGrid('getcolumnaggregateddata', 'amount1', ['sum'],true);
	   		 var sum1=summ.sum.replace(/,/g,'');
		  if(sum1==0){
			   document.getElementById("errormsg").innerText="Enter amount value.";
				return 0;
		  }
		  /* Validation */
		    var paydate = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(paydate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			currency=document.getElementById("cmbcurrency").value;
			 if(currency==""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
		  
		   	document.getElementById("errormsg").innerText=""; 
	    		
	    /* Validation Ends*/
	    		
	     /* Petty Cash Grid  Saving*/
			 var rows = $("#jqxPettyCash").jqxGrid('getrows');
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
						
			    newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::true::"+rows[i].amount1+"::"+rows[i].description+"::"+rows[i].baseamount1+"::0:: "+rows[i].costtype+":: "+rows[i].costcode);
				newTextBox.appendTo('form');
				 }
				}
				$('#gridlength').val(length);
	 		   /* Petty Cash Grid  Saving Ends*/	
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  $('#jqxPettyCashDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxPettyCashDate').val();
		  getCurrencyId(date);
		  $('#jqxPettyCashDate').jqxDateTimeInput({disabled: true});
		  
		  if($('#hidjqxPettyCashDate').val()){
				 $("#jqxPettyCashDate").jqxDateTimeInput('val', $('#hidjqxPettyCashDate').val());
			  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 var check = 1;
	             $("#jqxPettyCashGrid").load("pettyCashGrid.jsp?txtpettycashdocno2="+indexVal+"&check="+check);
			 }
			
			if(parseFloat($("#hidstatus").val())<3){
					$("#txtStatus").html("DRAFT");
			}else if(parseFloat($("#hidstatus").val())==4){
					$("#txtStatus").html("REJECTED");
			}else{
					$("#txtStatus").html("");
			}
		}
	  
	  function getDrTotal(){
		  var amount = $('#txtbaseamount').val();
		  if(!isNaN(amount)){
			  $('#txtdrtotal').val(amount);
		  }
		  else if(isNaN(amount)){
		  	$('#txtdrtotal').val(0.00);
		  	$('#txtamount').val(0.00);
		  }
	  }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
        	  $('#txtforsearch').val(2);
          }
          else{}
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("savePettyCash");
		        $("#docno").prop("disabled", false); 
		       
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printPettyCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printPettyCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function datechange(){
		  var date = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	
	  function funwarningopen(){
			 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
				    if (r){
				    	$("#mode").val("EDIT");
						 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);
						 $('#txtdescription').attr('readonly', false);$('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);
						 $('#frmPettyCash select').attr('disabled', false);$("#jqxPettyCash").jqxGrid({ disabled: false});  
				    }
				   });
		  }
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmPettyCash" action="savePettyCash" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='hidden-scrollbar'>

<fieldset>
<legend>General Info</legend>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="15%">
        <div id="jqxPettyCashDate" name="jqxPettyCashDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxPettyCashDate"/>'></div>
        <input type="hidden" id="hidjqxPettyCashDate" name="hidjqxPettyCashDate" value='<s:property value="hidjqxPettyCashDate"/>'/>
    </td>
    <td width="10%" align="right">Ref. No.</td>
    <td width="25%"><input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/></td>
    <td width="10%" align="right">Doc No.</td>
    <td width="32%">
        <div style="display: flex; align-items: center; gap: 8px;">
            <input type="text" id="docno" name="txtpettycashdocno" value='<s:property value="txtpettycashdocno"/>' tabindex="-1" readonly style="flex:1;"/>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
        </div>
    </td>
  </tr>
  <tr>
    <td colspan="5"></td>
    <td align="left"><span id="txtStatus" style="font-weight:bold; color:#e67e22;"></span></td>
  </tr>
</table>
</fieldset>

<fieldset>
<legend>Cash Info</legend>
<table width="100%">
  <tr>
    <td width="8%" align="right">Cash</td>
    <td width="16%"><input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>'  onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>' tabindex="-1" readonly/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td>
    <td width="8%" align="right">Currency</td>
    <td width="16%"><select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#jqxPettyCashDate').val());" onchange="getRatevalue(this.value,$('#jqxPettyCashDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
      <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/></td>
    <td width="8%" align="right">Rate</td>
    <td width="16%"><input type="text" id="txtrate" name="txtrate" style="text-align: right;" value='<s:property value="txtrate"/>' onblur="funRoundRate(this.value,this.id);" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtamount" name="txtamount" style="text-align: right;" value='<s:property value="txtamount"/>' readonly onblur="funRoundAmt(this.value,this.id);" tabindex="-1"/></td>
    <td width="12%" align="right">Base Amount</td>
    <td width="16%"><input type="text" id="txtbaseamount" name="txtbaseamount" style="text-align: right;" readonly value='<s:property value="txtbaseamount"/>' tabindex="-1"/></td>
    <td align="right">Description</td>
     <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset>

<br/>
<fieldset>
<legend>Petty Cash Allocation</legend>
<div id="jqxPettyCashGrid"><jsp:include page="pettyCashGrid.jsp"></jsp:include></div>
</fieldset>
<br/>

<div style="display:none;">
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="gridlength" name="gridlength"/>
    <div hidden id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
    <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
    <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
    <input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
    <input type="hidden" id="hidstatus" name="hidstatus" value='<s:property value="status"/>'/>
</div>
</div>
</form>
	
<div id="pettyCashGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsFromWindow">
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