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

#frmPrePayment input[type="text"],
#frmPrePayment select,
.textbox { 
    height: 24px !important; 
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
    width: 100%;
}

#frmPrePayment input[type="text"]:focus,
#frmPrePayment select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmPrePayment input[readonly],
#frmPrePayment input:disabled,
#frmPrePayment select:disabled,
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

.icon {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

#jqxPrePaymentGrid, #jqxDistributionGrid1, #jqxJournalVoucherApplyingGrid {
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

/* Modern Layout Utilities */
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

.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: nowrap; /* Prevent wrapping */
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0; /* Prevents labels from squishing */
}

.modern-ui .input-search-container {
    position: relative;
    display: flex;
    flex-shrink: 0;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
    width: 100%;
    box-sizing: border-box;
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

.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnCalculate').attr('hidden', true );
		
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		 $('#btnSearch').attr('disabled', true );$('#btnExcel').attr('disabled', true );
		 $('#btnPrint').attr('disabled', true );
		 
		 $("#jqxFromDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxToDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxStartDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true });
		 $("#jqxEndDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true });
		 
		 $("#jqxDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value: null });
		 $("#chequedate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#checkchequedate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});

         setTimeout(function () {
             $("#jqxFromDate, #jqxToDate, #jqxStartDate, #jqxEndDate, #jqxDate, #chequedate, #checkchequedate, #maindate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#jqxFromDate, #jqxToDate, #jqxStartDate, #jqxEndDate, #jqxDate, #chequedate, #checkchequedate, #maindate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '45%' , title: 'Cost Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#txtdueafter').val(0);$('#txtinstnos').val('1');
		 
		 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
		 $('#jqxFromDate').on('change', function (event) {
				var fromdate = $('#jqxFromDate').jqxDateTimeInput('getDate');
				 //funDateInPeriod(fromdate);
			 });
		 
		 $('#jqxToDate').on('change', function (event) {
				var todate = $('#jqxToDate').jqxDateTimeInput('getDate');
				 //funDateInPeriod(todate);
			 });
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#maindate').jqxDateTimeInput('getDate');
			  accountSearchContent("accountsDetailsSearch.jsp?date="+date);
			  $('#txtforsearch').val(2);
			  });
		  
		  $('#txtdistributionaccid').dblclick(function(){
			  var date = $('#maindate').jqxDateTimeInput('getDate');
			  accountSearchContent("accountsDetailsSearch.jsp?date="+date);
			  $('#txtforsearch').val(1);
			  });
		  
		  $('#txtcostgroup').dblclick(function(){
			  costTypeSearchContent("costTypeSearchGrid.jsp");
			  });
		
		  $('#txtcostcode').dblclick(function(){
			  var costtype = $('#txtcosttype').val();
			  costTypeSearchContent("costCodeSearchGrid.jsp?costtype="+costtype);
			  });
		
	});
	
	function accountSearchContent(url){
		   $('#accountDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsWindow').jqxWindow('setContent', data);
			$('#accountDetailsWindow').jqxWindow('bringToFront');
		}); 
	}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function cardCommission(tranid,trno,dtype,acno,i,length){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 items= x.responseText;
				 items=items.split(":");
				 
				 var amount=items[0];
				 var commission=items[1];
				 var index=items[2];
				 
				  $("#postingCardGrid").jqxGrid('setcellvalue', index, "commission", commission);
				  $("#postingCardGrid").jqxGrid('setcellvalue', index, "amountcomm", amount);
				 
				}
			else
				{
				}
		}
		x.open("GET","getCommissionAmount.jsp?cardtype="+cardtype+"&netamt="+netamt+"&paytype="+paytype+"&comm="+comm+"&index="+i,true);
		x.send();
	}
	
	function getInstallmentNumbers(frequency,startdate,enddate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtinstnos').val(items.trim());
  		}
  		}
  		x.open("GET", "getInstallmentNumber.jsp?frequency="+frequency+'&startdate='+startdate+'&enddate='+enddate, true);
  		x.send();
    }
	
	function getInstallmentEndDate(frequency,installno,startdate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#jqxEndDate').val(items);
  		}
  		}
  		x.open("GET", "getInstallmentEndDate.jsp?frequency="+frequency+'&installno='+installno+'&startdate='+startdate, true);
  		x.send();
    }
	
    function funReadOnly(){
		$('#frmPrePayment input').attr('readonly', true );
		$('#frmPrePayment select').attr('disabled', true);
		$('#jqxFromDate').jqxDateTimeInput({disabled: true});
		$('#jqxToDate').jqxDateTimeInput({disabled: true});
		$('#jqxStartDate').jqxDateTimeInput({disabled: true});
		$('#jqxEndDate').jqxDateTimeInput({disabled: true});
	    $("#jqxPrePayment").jqxGrid({ disabled: true});
	    $("#jqxDistributionGrid").jqxGrid({ disabled: true});
	    $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
	    $("#btnSubmit").hide();$("#btnDistributionSubmit").hide();$("#btnUpdate").hide();
	    $("#btnPrintSummary").hide();
	}
	
    function funExportBtn(){
 	   //$("#jqxPrePayment").jqxGrid('exportdata', 'xls', 'PrePayment');
	   JSONToCSVCon(dataExcelExport, 'PrePayment', true);
 	 }
    
	function funRemoveReadOnly(){
	    $('#frmPrePayment input').attr('readonly', false );
		$('#frmPrePayment select').attr('disabled', false);
		$('#jqxFromDate').jqxDateTimeInput({disabled: false});
		$('#jqxToDate').jqxDateTimeInput({disabled: false});
		$('#jqxStartDate').jqxDateTimeInput({disabled: false});
		$('#jqxEndDate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true );
		$('#txtaccid').attr('readonly', true );
	    $('#txtaccname').attr('readonly', true );
	    $('#txtdueafter').val(0);
	    $('#txtdistributionaccid').attr('readonly', true );
	    $('#txtdistributionaccname').attr('readonly', true );
	    $('#txtcostgroup').attr('readonly', true ); 
	    $('#txtcostcode').attr('readonly', true ); 
		$("#jqxPrePayment").jqxGrid({ disabled: true});
		$("#jqxDistributionGrid").jqxGrid({ disabled: true});
		$("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		$("#btnSubmit").show();$("#btnPrintSummary").hide();
		$("#btnDistributionSubmit").hide();$("#btnUpdate").hide();
		
		 if ($("#mode").val() == "A") {
			 $('#jqxFromDate').val(new Date());
			 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
		     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
		     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
		     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		     $('#jqxToDate').val(new Date());
		     $('#jqxStartDate').val(new Date());
		     $('#jqxEndDate').val(new Date());
			 
			 $("#jqxPrePayment").jqxGrid('clear');
			 $("#jqxPrePayment").jqxGrid('addrow', null, {});
			 $("#jqxDistributionGrid").jqxGrid('clear');
			 $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
		}  
		
	}
	
	function funSearchLoad(){
	/* changeContent('cpvMainSearch.jsp', $('#window')); */ 
	}
	
	function funChkButton(){
		/* funReset(); */
	}
	
	function funFocus(){
		document.getElementById("txtaccid").focus(); 	    		
	}
	
	function funNotify(){	
		
		/* Validation */
	    var fromdate = $('#jqxFromDate').jqxDateTimeInput('getDate');
		/* var validdate=funDateInPeriod(fromdate);
		if(validdate==0){
		return 0;	
		}
		
		var todate = $('#jqxToDate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(todate);
		if(validdate==0){
		return 0;	
		}
    	 */
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
			 return 0;
		 }
		 
		 if(parseInt($('#cmbtype').val())==0){
			 document.getElementById("errormsg").innerText="Please Choose a Type.";
			 return 0;
		 }
		 
		 if(parseInt($('#cmbtype').val())==1){
			 var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
			 if(rows.length==0){
				 document.getElementById("errormsg").innerText="Please Distribute the Amount.";
				 return 0;
			 }
		 }
		 
		 if(parseInt($('#cmbtype').val())==3){
			 var rows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
			 if(rows.length==0){
				 document.getElementById("errormsg").innerText="Invalid Posting !!!";
				 return 0;
			 }
		 }
		 
		document.getElementById("errormsg").innerText="";
			
	/* Validation Ends*/
			
	/* Distribution Grid  Saving*/
	  var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
	  var length=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].amount;
			if(typeof(chk) != "undefined"){
				length=length+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
					.attr("hidden", "true");
				
				newTextBox.val(rows[i].sr_no+":: "+rows[i].date+":: "+rows[i].amount+":: "+rows[i].posted+":: "+rows[i].rowno);
				newTextBox.appendTo('form');
				}
			}
	 		 $('#gridlength').val(length);
			/*Distribution Grid  Saving Ends*/	 
			
	 		/* Posting Grid  Saving*/
	 		 var rows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
	    	 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var applychk=rows[i].doc_no;
					if(typeof(applychk) != "undefined" && 
						(((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)) || 
						 ((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)))){
				//if(typeof(applychk) != "undefined"){
					
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "txtapply"+length)
				    .attr("name", "txtapply"+length)
					.attr("hidden", "txtapply")
					.attr("hidden", "true");
					
					length=length+1;
					
				var amount,baseamount,id;
				if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
					 amount=rows[i].credit*-1;
					 baseamount=rows[i].rate*rows[i].credit*-1;
					 id=-1;
					
				}
				if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
					 amount=rows[i].debit;
					 baseamount=rows[i].rate*rows[i].debit;
					 id=1;
				}
				else{}
				
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+rows[i].sr_no+":: "+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
				newTextBox.appendTo('form');
				}
			 }
			 $('#applylength').val(length);
	 		/*Posting Grid  Saving Ends*/	
	 		 
	 		 $('#jqxFromDate').jqxDateTimeInput({disabled: false});
             $('#jqxToDate').jqxDateTimeInput({disabled: false});
             $('#jqxStartDate').jqxDateTimeInput({disabled: false});
			 $('#jqxEndDate').jqxDateTimeInput({disabled: false});
			 
			return 1;
	} 
	
	
	function setValues(){
		
		document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		
		if($('#hidjqxFromDate').val()){
			 $("#jqxFromDate").jqxDateTimeInput('val', $('#hidjqxFromDate').val());
		  }
		
		if($('#hidjqxToDate').val()){
			 $("#jqxToDate").jqxDateTimeInput('val', $('#hidjqxToDate').val());
		  }
		
		if($('#hidjqxStartDate').val()){
			 $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
		  }
		
		if($('#hidjqxEndDate').val()){
			 $("#jqxEndDate").jqxDateTimeInput('val', $('#hidjqxEndDate').val());
		  }
		  
		if($('#hidmaindate').val()){
			 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
		  }
	 
		 if($('#msg').val()!=""){
			 if($('#cmbtype').val()=='3'){
			     $.messager.alert('Message',$('#txtmsg').val());
			 } else {
				 $.messager.alert('Message',$('#msg').val()); 
			 }
	     }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		 $('#cmbtype').attr('disabled', false );
	     var indexVal = document.getElementById("cmbtype").value;
		 if(indexVal>0){
			 gridloading();
		 }
		 
		 if(indexVal==2){
			 distributiongridreloading();
		 }
		 
		 $('#cmbtype').attr('disabled', true );
		 
	}
	
	 $(function(){
	        $('#frmPrePayment').validate({
	                rules: {
	                cmbtype:"required",
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 cmbtype:" *",
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	
	function getAcc(event){
        var x= event.keyCode;
        if(x==114){
        	var date = $('#maindate').jqxDateTimeInput('getDate');
			accountSearchContent("accountsDetailsSearch.jsp?date="+date);
      		$('#txtforsearch').val(2);
        }
        else{}
        }
	
	function getcostType(event){
        var x= event.keyCode;
        if(x==114){
        	//var date = $('#maindate').jqxDateTimeInput('getDate');
			costTypeSearchContent("costTypeSearchGrid.jsp");
      		
        }
        else{}
        }
	
	
	function getcostNo(event){
        var x= event.keyCode;
        if(x==114){
        	var costtype = $('#txtcosttype').val();
			costTypeSearchContent("costCodeSearchGrid.jsp?costtype="+costtype);
      		
        }
        else{}
        }
	
	
	
	function getDistributionAcc(event){
        var x= event.keyCode;
        if(x==114){
        	var date = $('#maindate').jqxDateTimeInput('getDate');
			accountSearchContent("accountsDetailsSearch.jsp?date="+date);
        	$('#txtforsearch').val(1);
        }
        else{}
        }
		
	function gridloading(){
		  var type = document.getElementById("cmbtype").value;
		  var accId = document.getElementById("txtdocno").value;
		  var fromDate = document.getElementById("jqxFromDate").value;
		  var toDate = document.getElementById("jqxToDate").value;
		  $('#txtdueafter').val(0);
		  if(type!=0){
			  var check = 1;
			  $("#overlay, #PleaseWait").show();
		  	  $("#jqxPrePaymentGrid").load('prePaymentGrid.jsp?txttype='+type+'&accId='+accId+'&fromDate='+fromDate+'&toDate='+toDate+'&check='+check);
		  }
		 }
	
	function funloadgrid(){
		  $("#jqxPrePayment").jqxGrid('disabled', false);
		  var type = document.getElementById("cmbtype").value;
		  if(type!=2){
	      $("#btnUpdate").hide();
		  $("#btnDistributionSubmit").show();
		  $("#btnPrintSummary").hide();
		  }
		  
		  $('#txtaccountdocno').val('');$('#txtdistributiondocno').val('');$('#txtdistributionaccid').val('');$('#txtdistributionaccname').val('');
		  $('#txttrno').val('');$('#txtdtype').val('');$('#txttranid').val('');$('#txtcostgroup').val('');$('#txtcosttype').val('');$('#txtcostno').val('');
		  $('#txtamount').val('');$('#hidcmbfrequency').val('');$('#txtdueafter').val('');$('#txtinstnos').val('');$('#txtinstamt').val('');
		  $('#txtdescription').val('');$('#txtdebittotal').val('');$('#txtrowno').val('');
		  
		  if (document.getElementById("txtdistributionaccid").value == "") {
		        $('#txtdistributionaccid').attr('placeholder', 'Press F3 to Search'); 
		    }
		  
		  var type = document.getElementById("cmbtype").value;
		  
		  if(type==2){
			  $('#btnSave').attr('disabled', true );
		  }
		  else{
			  $('#btnSave').attr('disabled', false );
		  }
		  
		  if(type!=2){
			  $('#jqxStartDate').jqxDateTimeInput({disabled: false});$('#cmbfrequency').attr('disabled', false );$('#txtdueafter').attr('readonly', false );
			  $('#txtinstnos').attr('readonly', false );$('#txtdescription').attr('readonly', false );
			  $("#jqxStartDate").jqxDateTimeInput('val', new Date());$("#jqxEndDate").jqxDateTimeInput('val', new Date());
		  }
		  if(type==3){
			  var account=document.getElementById("txtdocno").value;
				 if(account==''){
					 document.getElementById("errormsg").innerText="Account is Mandatory.";
					 $("#jqxPrePayment").jqxGrid('disabled', true);
					 $('#btnCalculate').attr('hidden', true );
					 return 0;
				 }
				 
			  document.getElementById("errormsg").innerText="";
			  $('#btnCalculate').attr('hidden', false );
		  }
		  else{
			  $('#btnCalculate').attr('hidden', true );
		  }
		  
		  $("#jqxDistributionGrid").jqxGrid('clear');
		  $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
		  $("#jqxJournalVoucherApplying").jqxGrid('clear');
		  /*$("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});*/
		  
		  gridloading();
		  }
	
	function distributiongridloading(){
		  var startdate = $('#jqxStartDate').jqxDateTimeInput('getText');
		  var enddate = $('#jqxEndDate').jqxDateTimeInput('getText');
		  var cmbfrequency = document.getElementById("cmbfrequency").value;
		  var amount = document.getElementById("txtamount").value;
		  var instno = document.getElementById("txtinstnos").value;
		  var instamt = document.getElementById("txtinstamt").value;
		  var dueafter = document.getElementById("txtdueafter").value;
		  
		  if(dueafter==''){
		  		document.getElementById("errormsg").innerText="Due After is Mandatory.";
		  		return 0;
		  }
				  
		  document.getElementById("errormsg").innerText=""; 
		  
		  var check = 1;
		  $("#jqxDistributionGrid1").load('distributionGrid.jsp?cmbfrequency='+cmbfrequency+'&startdate='+startdate+'&enddate='+enddate+'&amount='+amount+'&instno='+instno+'&instamt='+instamt+'&dueafter='+dueafter+'&check='+check);
	  }
	
	
	function funloaddistributiongrid(){
		
 		var grtype=document.getElementById("hidgrtype").value;
    	 if((grtype==4) || (grtype==5)){
    		 document.getElementById("errormsg").innerText="";
    			
    			if(($('#txtcostgroup').val()==null) || ($('#txtcostgroup').val()=='undefined') || ($('#txtcostgroup').val()=='NA') || ($('#txtcostgroup').val()=="") || ($('#txtcostgroup').val()==0)){
    			
    			document.getElementById("errormsg").innerText="Cost Type is Mandatory for Income/Expence Accounts.";
    			return 0;
    		}
    	 }
    	 
		  $("#jqxDistributionGrid").jqxGrid({ disabled: false});
		  distributiongridloading();
    	 
	}
	
	function distributiongridreloading(){
		  var tranid = document.getElementById("txttranid").value;
		  var check = 1;
		  $("#jqxDistributionGrid1").load('distributionGrid.jsp?tranId='+tranid+'&check='+check);
	  }
	
	function funreloaddistributiongrid(){
		  $("#btnUpdate").show();$("#btnDistributionSubmit").hide();distributiongridreloading();
		  $('#txtamount').attr('readonly', true );$('#cmbfrequency').attr('disabled', true );
		  $('#txtdueafter').attr('readonly', true );$('#txtinstnos').attr('readonly', true );$('#txtdescription').attr('readonly', true );
		  
	}

	 function funUpdate(){
     
      if(document.getElementById("btnUpdate").value=="Edit")
       {    	  
    	 $("#jqxDistributionGrid").jqxGrid({ disabled: false});
         document.getElementById("btnUpdate").value="Update";
         return 0;
       }
      else if(document.getElementById("btnUpdate").value=="Update"){
    	    $('#btnSave').mousedown();
           }
       }
	 
	 function funPrintSummary() {
			
			if (($("#mode").val() == "A") && $("#cmbtype").val()=="2") {
				 var url=document.URL;
			     var reurl=url.split("prePayment.jsp");
				 var win= window.open(reurl[0]+"printPrePayment?tranid="+document.getElementById("txttranid").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			     win.focus();
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	 
	 function funPostingGrid(){
		 var posted=$('#cmbtype').val();
         if(posted==3){
        	 $("#jqxDistribution").prop("hidden", true); 
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", false);
			 $('#btnCalculate').attr('hidden', false );
         }
         else{
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", true);
        	 $("#jqxDistribution").prop("hidden", false);
			 $('#btnCalculate').attr('hidden', true );
         }
	 }
	 
	 function funInstAmount(){
		 
		 var amount=$('#txtamount').val();
		 var instno=$('#txtinstnos').val();
		 $("#jqxDistributionGrid").jqxGrid({ disabled: true});
		 $("#jqxDistributionGrid").jqxGrid('clear');
		 $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
		 
		 if(parseInt(instno)==0 || instno==""){
			 instno=1;
			 $('#txtinstnos').val("1");
		 }
		 if(!isNaN(amount)){
		     var result = amount / instno;
			 $('#txtinstamt').val(result);
			 }
			 else if(isNaN(amount)){
			 	 $('#txtinstamt').val(0.0);
			 }
	 }
	 
	 function clearDistributionInfo(){
		  $("#txtdueafter").val(0);$("#txtinstnos").val('');
		  $('#jqxStartDate').val(new Date());/* $('#jqxEndDate').val(new Date()); */
		  $("#jqxDistributionGrid").jqxGrid({ disabled: true});
		  $("#jqxDistributionGrid").jqxGrid('clear');
		  $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
	  }
	 
	 function clearDistributionsInfo(){
		  $("#txtinstnos").val('1');
		  $('#jqxStartDate').val(new Date());/* $('#jqxEndDate').val(new Date()); */
		  $("#jqxDistributionGrid").jqxGrid({ disabled: true});
		  $("#jqxDistributionGrid").jqxGrid('clear');
		  $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
	  }
	 
	 function funCalculate(){
		 	var rows=$("#jqxPrePayment").jqxGrid('getrows');
		 	var value = $('#cmbtype').val();
		 	var sdate=$('#jqxFromDate').val();
		 	var tdate=$('#jqxToDate').val();
		 	var startdate = $('#jqxStartDate').jqxDateTimeInput('getText');
			var enddate = $('#jqxEndDate').jqxDateTimeInput('getText');
			
			var selectedrows=$("#jqxPrePayment").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			if(selectedrows.length>0){
				$("#jqxJournalVoucherApplying").jqxGrid('clear');
				$("#jqxJournalVoucherApplying").jqxGrid({ disabled: false});
				
				for (var k = 0; k <= selectedrows.length; k++) {
					$("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
				}
			}
			
			var temp="";
			var drtotal=0;
			var rowno="";
			var postacno="";
		    
			var j=0;var k=0;
		    for (var i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						
						 document.getElementById("txttrno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "trno");
			           	 document.getElementById("txtdtype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "dtype");
			           	 document.getElementById("txttranid").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "tranid");
			           	 document.getElementById("txtaccountdocno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "acno");
			           	 document.getElementById("txtcostgroup").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costgroup");
			           	 document.getElementById("txtcosttype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costtype"); 
			           	 document.getElementById("txtcostno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costcode");
			           	 
			           	 drtotal=drtotal+rows[i].dramount;
			           	
						 if(i==0){
							temp=rows[i].trno;
						 }
						 else{
							temp=temp+","+rows[i].trno;
						 }
						
						if(k==0){ rowno=rows[i].rowno;postacno=rows[i].postacno;k=1;} else{ rowno=rowno+","+rows[i].rowno;postacno=postacno+","+rows[i].postacno;}
						
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "doc_no", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "postacno"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "atype", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "atype"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "account", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "paccount"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "accountname", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "paccountname"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "costtype", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costtype"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "costgroup", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costgroup"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "costcode", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costcode"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "costcde", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costcode"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "debit", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "dramount"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "credit", "");
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "description", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "desc1"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "currencyid", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "curid"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "rate", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "c_rate"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "ref_row", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "rowno"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "sr_no", j+1);
						
					   j++; 
				     }
					
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "doc_no", document.getElementById("txtdocno").value);
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "atype", "GL");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "account", document.getElementById("txtaccid").value);
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "accountname", document.getElementById("txtaccname").value);
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "costtype", "");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "costgroup", "");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "costcode", "0");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "costcde", "0");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "debit", "");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "credit", drtotal);
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "description", ("PREPAYMENT FOR PERIOD "+$('#jqxFromDate').val()+" "+$('#jqxToDate').val()));
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "currencyid", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "curid"));
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "rate", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "c_rate"));
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "ref_row", "");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "sr_no", 0);
					
					document.getElementById("txtrowno").value = rowno;
					document.getElementById("txtdistributiondocno").value = postacno;
	            }
		    
			//$("#jqxJournalVoucherApplyingGrid").load('journalVoucherApplyingGrid.jsp?temp='+temp+'&value='+value+'&sdate='+sdate+'&tdate='+tdate);
		    document.getElementById("txtdebittotal").value =drtotal;
	 }
		
		function funInsEndDate(){

		  	   var inststartday= $('#jqxStartDate').jqxDateTimeInput('getDate');
		  	   
		  	   if(inststartday==null){
				 	document.getElementById("errormsg").innerText="Start Date is Mandatory.";
				 	return 0;
			   }
		  	   
		  	   if(inststartday>($('#jqxEndDate').jqxDateTimeInput('getDate'))){
				 	document.getElementById("errormsg").innerText="Start Date Should be less than End Date.";
				 	return 0;
			   }
		  	 
		  	   document.getElementById("errormsg").innerText="";
			  	   
			   var startdate = $('#jqxStartDate').jqxDateTimeInput('getText');
			   var installno = document.getElementById("txtinstnos").value;
			   var frequency = document.getElementById("cmbfrequency").value;
			   getInstallmentEndDate(frequency,installno,startdate);
	 }
	 
	 function funInsNoFromEndDate(){
		 	 
			 var inststartday= $('#jqxStartDate').jqxDateTimeInput('getDate');
			 var instendday= $('#jqxEndDate').jqxDateTimeInput('getDate');

			 if(inststartday==null){
				 document.getElementById("errormsg").innerText="Start Date is Mandatory.";
				 return 0;
			 }
			 
			 if(instendday==null){
				 document.getElementById("errormsg").innerText="End Date is Mandatory.";
				 return 0;
			 }
			 
			 if(inststartday>instendday){
				 document.getElementById("errormsg").innerText="Start Date Should be less than End Date.";
				 return 0;
			 }
			 
			 document.getElementById("errormsg").innerText="";
			 
			 $('#cmbfrequency').attr('disabled', false);
			 
			 var startdate = $('#jqxStartDate').jqxDateTimeInput('getText');
			 var enddate = $('#jqxEndDate').jqxDateTimeInput('getText');
			 var frequency = document.getElementById("cmbfrequency").value;
			 
			 if($('#cmbtype').val()=='2') {
			 		$('#cmbfrequency').attr('disabled', true);
			 }
			 getInstallmentNumbers(frequency,startdate,enddate);
			 
	 }
	
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmPrePayment" action="savePrePayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">Search Criteria</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Account</label>
            <div class="input-search-container" style="width:120px; flex-shrink:0;">
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
                <svg class="magnifier-icon" onclick="var date = $('#maindate').jqxDateTimeInput('getDate'); accountSearchContent('accountsDetailsSearch.jsp?date='+date); $('#txtforsearch').val(2);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>' style="flex:1; min-width:0;" readonly/>
            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">From</label>
            <div style="width: 125px; flex-shrink:0;">
                <div id="jqxFromDate" name="jqxFromDate" value='<s:property value="jqxFromDate"/>'></div>
                <input type="hidden" id="hidjqxFromDate" name="hidjqxFromDate" value='<s:property value="hidjqxFromDate"/>'/>
            </div>

            <label class="lbl-right" style="width:40px; flex-shrink:0;">To</label>
            <div style="width: 125px; flex-shrink:0;">
                <div id="jqxToDate" name="jqxToDate" value='<s:property value="jqxToDate"/>'></div>
                <input type="hidden" id="hidjqxToDate" name="hidjqxToDate" value='<s:property value="hidjqxToDate"/>'/>
            </div>

            <label class="lbl-right" style="width:60px; flex-shrink:0;">Type</label>
            <select id="cmbtype" name="cmbtype" style="width:120px; flex-shrink:0;" onchange="funPostingGrid();" value='<s:property value="cmbtype"/>'>
                <option value="0">--Select--</option>
                <option value="1">For Distribution</option>
                <option value="2">Summary</option>
                <option value="3">To be Posted</option>
            </select>
            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>

            <button class="myButton" type="button" id="btnSubmit" name="btnSubmit" onclick="funloadgrid();" style="margin-left:auto; flex-shrink:0;">Submit</button>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="jqxPrePaymentGrid" class="grid-container"><jsp:include page="prePaymentGrid.jsp"></jsp:include></div>
    </div>

    <div id="jqxDistribution" style="display:flex; gap:15px; margin-bottom:15px;">
        <!-- Left Panel: Distribution Form -->
        <div class="middle-panel" style="flex:2; margin-bottom:0;">
            <span class="middle-panel-title">Distribution</span>

            <div class="field-row">
                <label class="lbl-right" style="width:130px; flex-shrink:0;">Account(To be Posted)</label>
                <div class="input-search-container" style="width: 120px; flex-shrink:0;">
                    <input type="text" id="txtdistributionaccid" name="txtdistributionaccid" tabindex="1" placeholder="Press F3" value='<s:property value="txtdistributionaccid"/>' onkeydown="getDistributionAcc(event);"/>
                    <svg class="magnifier-icon" onclick="var date = $('#maindate').jqxDateTimeInput('getDate'); accountSearchContent('accountsDetailsSearch.jsp?date='+date); $('#txtforsearch').val(1);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txtdistributionaccname" name="txtdistributionaccname" tabindex="-1" value='<s:property value="txtdistributionaccname"/>' style="flex:1; min-width:0;" readonly/>
                <input type="hidden" id="txtdistributiondocno" name="txtdistributiondocno" value='<s:property value="txtdistributiondocno"/>'/>
                <input type="hidden" id="txtaccountdocno" name="txtaccountdocno" value='<s:property value="txtaccountdocno"/>'/>
                <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
                <input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
                <input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:130px; flex-shrink:0;">Cost Type</label>
                <div class="input-search-container" style="width: 120px; flex-shrink:0;">
                    <input type="text" id="txtcostgroup" readonly name="txtcostgroup" placeholder="Press F3" tabindex="2" onkeydown="getcostType(event);" value='<s:property value="txtcostgroup"/>'/>
                    <svg class="magnifier-icon" onclick="costTypeSearchContent('costTypeSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="hidden" id="txtcosttype" name="txtcosttype" value='<s:property value="txtcosttype"/>'/>

                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left:15px;">Cost No</label>
                <div class="input-search-container" style="width: 120px; flex-shrink:0;">
                    <input type="text" id="txtcostcode" readonly name="txtcostcode" tabindex="3" onkeydown="getcostNo(event);" placeholder="Press F3" value='<s:property value="txtcostcode"/>'/>
                    <svg class="magnifier-icon" onclick="var costtype = $('#txtcosttype').val(); costTypeSearchContent('costCodeSearchGrid.jsp?costtype='+costtype);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="hidden" id="txtcostno" name="txtcostno" value='<s:property value="txtcostno"/>'/>

                <input type="button" name="btnPrintSummary" id="btnPrintSummary" class="myButton" value="Print" tabindex="13" onclick="funPrintSummary();" style="margin-left:auto; flex-shrink:0;">
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:130px; flex-shrink:0;">Amount</label>
                <input type="text" id="txtamount" name="txtamount" tabindex="4" value='<s:property value="txtamount"/>' style="width:120px; text-align:right; flex-shrink:0;"/>

                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left:15px;">Frequency</label>
                <select id="cmbfrequency" name="cmbfrequency" tabindex="5" onchange="clearDistributionInfo();" value='<s:property value="cmbfrequency"/>' style="width:120px; flex-shrink:0;">
                    <option value="2">Month</option>
                    <option value="3">Year</option>
                </select>
                <input type="hidden" id="hidcmbfrequency" name="hidcmbfrequency" value='<s:property value="hidcmbfrequency"/>'/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:130px; flex-shrink:0;">Due After</label>
                <input type="text" id="txtdueafter" name="txtdueafter" tabindex="6" onblur="clearDistributionsInfo();" value='<s:property value="txtdueafter"/>' style="width:120px; flex-shrink:0;"/>

                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left:15px;">Inst. Nos</label>
                <input type="text" id="txtinstnos" name="txtinstnos" tabindex="7" onblur="funInstAmount();funInsEndDate();" value='<s:property value="txtinstnos"/>' style="width:120px; flex-shrink:0;"/>
                <input type="hidden" id="txtinstamt" name="txtinstamt" value='<s:property value="txtinstamt"/>'/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:130px; flex-shrink:0;">Start Date</label>
                <div style="width: 120px; flex-shrink:0;">
                    <div id="jqxStartDate" name="jqxStartDate" tabindex="8" onchange="funInsNoFromEndDate();" value='<s:property value="jqxStartDate"/>'></div>
                    <input type="hidden" id="hidjqxStartDate" name="hidjqxStartDate" value='<s:property value="hidjqxStartDate"/>'/>
                </div>

                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left:15px;">End Date</label>
                <div style="width: 120px; flex-shrink:0;">
                    <div id="jqxEndDate" name="jqxEndDate" tabindex="9" onchange="funInsNoFromEndDate();" value='<s:property value="jqxEndDate"/>'></div>
                    <input type="hidden" id="hidjqxEndDate" name="hidjqxEndDate" value='<s:property value="hidjqxEndDate"/>'/>
                </div>

                <input type="button" name="btnUpdate" id="btnUpdate" class="myButton" value="Edit" tabindex="12" onclick="funUpdate();" style="margin-left:auto; flex-shrink:0;">
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:130px; flex-shrink:0;">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" tabindex="10" value='<s:property value="txtdescription"/>' style="flex:1; min-width:0;"/>

                <button class="myButton" type="button" id="btnDistributionSubmit" name="btnDistributionSubmit" tabindex="11" onclick="funloaddistributiongrid();" style="margin-left:15px; flex-shrink:0;">Submit</button>
            </div>
        </div>

        <!-- Right Panel: Distribution Grid -->
        <div class="middle-panel" style="flex:1; margin-bottom:0; padding:10px;">
            <div id="jqxDistributionGrid1" class="grid-container" style="height:100%;">
                <jsp:include page="distributionGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

    <!-- Toolbar buttons -->
    <div class="field-row" style="margin-bottom: 15px;">
        <button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funCalculate();">
            <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
        </button>
        <button type="button" class="icon" id="btnExcel" title="Export current Document to Excel" onclick="funExportBtn();">
            <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
        </button>
    </div>

    <div id="jqxJournalVoucherApplyingGrid" hidden="true" class="middle-panel">
        <span class="middle-panel-title">Applying Grid</span>
        <div class="grid-container">
            <jsp:include page="journalVoucherApplyingGrid.jsp"></jsp:include>
        </div>
    </div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtmsg" name="txtmsg"  value='<s:property value="txtmsg"/>'/>
<div hidden id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txtinstamttotal" name="txtinstamttotal" value='<s:property value="txtinstamttotal"/>'/>
<input type="hidden" id="txttranno" name="txttranno" value='<s:property value="txttranno"/>'/>
<input type="hidden" id="txtdebittotal" name="txtdebittotal" value='<s:property value="txtdebittotal"/>'/>
<input type="hidden" id="txtrowno" name="txtrowno" value='<s:property value="txtrowno"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="hidgrtype" name="hidgrtype"/>

</div>
</form> 

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 
 
</div>
</body>
</html>