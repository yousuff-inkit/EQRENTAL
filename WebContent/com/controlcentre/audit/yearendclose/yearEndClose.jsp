<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i) - Year End Close</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
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
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

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
	$(document).ready(function () {    
		$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );$('#btnExcel').attr('disabled', true );
		$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
	    /* Formatted heights to match modern UI 24px standard */
	    $("#yearEndDate").jqxDateTimeInput({ width: '125px', height: 24, formatString : "dd.MM.yyyy" ,value:new Date()});
	    $("#accountingYearFrom").jqxDateTimeInput({ width: '125px', height: 24, formatString : "dd.MM.yyyy",value:null });
	    $("#accountingYearTo").jqxDateTimeInput({ width: '125px', height: 24, formatString : "dd.MM.yyyy",value:null});
	    $("#ycloseDateFrom").jqxDateTimeInput({ width: '125px', height: 24, formatString : "dd.MM.yyyy",value:null });
	    $("#ycloseDateTo").jqxDateTimeInput({ width: '125px', height: 24, formatString : "dd.MM.yyyy",value:null });
	    
	    /* force internal alignment AFTER render */
		setTimeout(function () {
		     $("#yearEndDate, #accountingYearFrom, #accountingYearTo, #ycloseDateFrom, #ycloseDateTo").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#yearEndDate, #accountingYearFrom, #accountingYearTo, #ycloseDateFrom, #ycloseDateTo").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		}, 0);

		$('#ycloseDateTo').focusout(function(){
	        if($('#ycloseDateTo').jqxDateTimeInput('getDate') <= $('#ycloseDateFrom').jqxDateTimeInput('getDate')){
    		    document.getElementById("errormsg").innerText="Next Accounting Year Close Date Cannot be less than From Date";
    		    return 0;
    	    } else {
	    	    document.getElementById("errormsg").innerText="";
	    	}
		});
		
		$('#accountingYearTo').focusout(function(){
			 var accountingtodate = $('#accountingYearTo').val();
			 getNextAccountingPeriods(accountingtodate);
			 $("#yearEndCloseGridID").jqxGrid('clear');
			 $("#yearEndCloseGridID").jqxGrid('addrow', null, {});
			 $("#yearEndCloseGroupGridID").jqxGrid('clear');
		});
    });
	
	function getNextAccountingPeriods(accountingtodate){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items= x.responseText.trim();
		        items=items.split('####');
		        
				if(items != null && items[0] && items[1]){
					$('#ycloseDateFrom').jqxDateTimeInput('val',new Date(items[0]));
					$('#ycloseDateTo').jqxDateTimeInput('val',new Date(items[1]));
				} else {
					$('#ycloseDateFrom').jqxDateTimeInput('val',null);
					$('#ycloseDateTo').jqxDateTimeInput('val',null);
				}
			}
		}
		x.open("GET", "getNextAccountingPeriods.jsp?accountingtodate="+accountingtodate, true);
		x.send();  
	}
	
	function getAccountingPeriods(){
 		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items= x.responseText.trim();
		        items=items.split('####');
		        
				if(items != null && items.length > 3){
					$('#accountingYearFrom').jqxDateTimeInput('val',new Date(items[0])); 
					$('#accountingYearTo').jqxDateTimeInput('val',new Date(items[1]));
					$('#ycloseDateFrom').jqxDateTimeInput('val',new Date(items[2]));
					$('#ycloseDateTo').jqxDateTimeInput('val',new Date(items[3]));
				} else {
					$('#accountingYearFrom').jqxDateTimeInput('val',null); 
					$('#accountingYearTo').jqxDateTimeInput('val',null);
					$('#ycloseDateFrom').jqxDateTimeInput('val',null);
					$('#ycloseDateTo').jqxDateTimeInput('val',null);
				}
			}
		}
		x.open("GET", "getAccountingPeriods.jsp", true);
		x.send();  
	}
	
	function funSearchLoad(){
		changeContent('yrcMainSearch.jsp');  
	}

	function funReadOnly() {
		$('#frmYearEndClose input').attr('readonly', true);
		$('#yearEndDate').jqxDateTimeInput({disabled:true});
		$('#accountingYearFrom').jqxDateTimeInput({disabled:true});
		$('#accountingYearTo').jqxDateTimeInput({disabled:true});
		$('#ycloseDateFrom').jqxDateTimeInput({disabled:true});
		$('#ycloseDateTo').jqxDateTimeInput({disabled:true});
		$("#yearEndCloseGridID").jqxGrid({ disabled: true});
		$("#btnview").hide();
	}
	
	function funRemoveReadOnly() {
		$('#frmYearEndClose input').attr('readonly', false);
		$('#yearEndDate').jqxDateTimeInput({disabled:false});
		$('#accountingYearTo').jqxDateTimeInput({disabled:false});
		$('#ycloseDateTo').jqxDateTimeInput({disabled:false});
		$("#yearEndCloseGridID").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		$("#btnview").show();
		
		if(document.getElementById("mode").value=="A"){
			$('#yearEndDate').jqxDateTimeInput('setDate',new Date());
			$('#ycloseDateTo').jqxDateTimeInput('setDate',null);
			$("#yearEndCloseGridID").jqxGrid('clear');
			$("#yearEndCloseGridID").jqxGrid('addrow', null, {});
			$("#yearEndCloseGroupGridID").jqxGrid('clear');
			getAccountingPeriods();
		}
		
		if(document.getElementById("mode").value=="D"){
			$('#yearEndDate').jqxDateTimeInput({disabled:false});
			$('#ycloseDateFrom').jqxDateTimeInput({disabled:false});
			$('#ycloseDateTo').jqxDateTimeInput({disabled:false});
		}
	}

	function setValues() {
		if($('#hidyearEndDate').val()){
			$("#yearEndDate").jqxDateTimeInput('val', $('#hidyearEndDate').val());
		}
		if($('#hidycloseDateFrom').val()){
			$("#ycloseDateFrom").jqxDateTimeInput('val', $('#hidycloseDateFrom').val());
		}
		if($('#hidycloseDateTo').val()){
			$("#ycloseDateTo").jqxDateTimeInput('val', $('#hidycloseDateTo').val());
		}
		if($('#hidaccountingYearFrom').val()){
			$("#accountingYearFrom").jqxDateTimeInput('val', $('#hidaccountingYearFrom').val());
		}
		if($('#hidaccountingYearTo').val()){
			$("#accountingYearTo").jqxDateTimeInput('val', $('#hidaccountingYearTo').val());
		}
		
		if($('#msg').val()!=""){
			$.messager.alert('Message',$('#msg').val());
		}
		
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
			
		var indexVal = document.getElementById("docno").value;
		var indexVal1 = document.getElementById("txttrno").value;
		if(indexVal>0){
         	$("#yearEndCloseDiv").load("yearEndCloseGrid.jsp?docno="+indexVal+"&trno="+indexVal1); 
         	$("#yearEndCloseGroupDiv").load("yearEndCloseGroupGrid.jsp?docno="+indexVal+"&trno="+indexVal1);
		}
	}
	        
	function funNotify(){
	    if($('#accountingYearTo').jqxDateTimeInput('getDate')==null){
	        document.getElementById("errormsg").innerText="Accounting Year To Close Date is Mandatory.";
	        return 0;
	    }
	    if($('#ycloseDateTo').jqxDateTimeInput('getDate')==null){
	        document.getElementById("errormsg").innerText="Next Accounting Year Close Date is Mandatory.";
	        return 0;
	    }
	    if($('#accountingYearTo').jqxDateTimeInput('getDate') <= $('#accountingYearFrom').jqxDateTimeInput('getDate')){
	        document.getElementById("errormsg").innerText="Accounting Year To Close Date Cannot be less than From Date.";
	        return 0;
	    }
	    if($('#ycloseDateTo').jqxDateTimeInput('getDate') <= $('#ycloseDateFrom').jqxDateTimeInput('getDate')){
	        document.getElementById("errormsg").innerText="Next Accounting Year Close Date Cannot be less than From Date.";
	        return 0;
	    }
	        	
	    /* Year End Close Grid Saving*/
		var rows = $("#yearEndCloseGridID").jqxGrid('getrows');
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
				amount = parseFloat(rows[i].amount) * parseFloat(-1);
				baseamount = parseFloat(rows[i].amount) * parseFloat(rows[i].rate) * parseFloat(-1);
						    
				if(amount < 0){ id = -1; } else { id = 1; }
							
			    newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+id+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::"+rows[i].brhid);
				newTextBox.appendTo('form');
			}
		}
		$('#gridlength').val(length);
	 	
	 	/* Year End Close Group Grid Saving*/
		var rowsGroup = $("#yearEndCloseGroupGridID").jqxGrid('getrows');
		var grouplength=0;
		for(var i=0 ; i < rowsGroup.length ; i++){
			var chk=rowsGroup[i].docno;
			if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "txttest"+grouplength)
				    .attr("name", "txttest"+grouplength)
					.attr("hidden", "false");
				grouplength=grouplength+1;
							
				var amount,baseamount,id;
				amount = rowsGroup[i].amount;
				baseamount = parseFloat(rowsGroup[i].amount) * parseFloat(rowsGroup[i].rate);
						    
				if(amount < 0){ id = -1; } else { id = 1; }
							
			    newTextBox.val(rowsGroup[i].docno+"::"+rowsGroup[i].currencyid+"::"+rowsGroup[i].rate+"::"+id+"::"+amount+"::"+rowsGroup[i].description+"::"+baseamount+"::"+rowsGroup[i].brhid);
				newTextBox.appendTo('form');
			}
		}
		$('#yearendclosegroupgridlength').val(grouplength);

	 	$('#yearEndDate').jqxDateTimeInput({disabled:false});
	    $('#ycloseDateFrom').jqxDateTimeInput({disabled:false});
	    $('#ycloseDateTo').jqxDateTimeInput({disabled:false});
	    $('#accountingYearFrom').jqxDateTimeInput({disabled:false});
	    $('#accountingYearTo').jqxDateTimeInput({disabled:false});
	    		
	    return 1;
	} 
	        
	function funFocus(){
	    $('#yearEndDate').jqxDateTimeInput('focus');
	}
	  
	function funloadgrid(){
		if($('#accountingYearTo').jqxDateTimeInput('getDate')==null){
      		document.getElementById("errormsg").innerText="Accounting Year To Close Date is Mandatory.";
      		return 0;
      	}
      	if($('#ycloseDateTo').jqxDateTimeInput('getDate')==null){
      		document.getElementById("errormsg").innerText="Next Accounting Year Close Date is Mandatory.";
      		return 0;
      	}
      	if($('#accountingYearTo').jqxDateTimeInput('getDate') <= $('#accountingYearFrom').jqxDateTimeInput('getDate')){
      		document.getElementById("errormsg").innerText="Accounting Year To Close Date Cannot be less than From Date.";
      		return 0;
      	}
      	if($('#ycloseDateTo').jqxDateTimeInput('getDate') <= $('#ycloseDateFrom').jqxDateTimeInput('getDate')){
      		document.getElementById("errormsg").innerText="Next Accounting Year Close Date Cannot be less than From Date.";
      		return 0;
      	} 
      	
	    var accountingYearFrom = document.getElementById("accountingYearFrom").value;
		var ycloseDateFrom = document.getElementById("ycloseDateFrom").value;
		var yearEndDate = document.getElementById("yearEndDate").value;
        
        if(accountingYearFrom != null && ycloseDateFrom != null){
         	$("#yearEndCloseDiv").load("yearEndCloseGrid.jsp?accountingYearFrom="+accountingYearFrom+"&ycloseDateFrom="+ycloseDateFrom+"&yearEndDate="+yearEndDate); 
         	$("#yearEndCloseGroupDiv").load("yearEndCloseGroupGrid.jsp?accountingYearFrom="+accountingYearFrom+"&ycloseDateFrom="+ycloseDateFrom+"&yearEndDate="+yearEndDate);
        }
	}
</script>  
 
</head>
<body onLoad="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmYearEndClose" action="saveYearEndClose" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Year Close Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:140px;">Date</label>
            <div style="width: 125px;">
                <div id="yearEndDate" name="yearEndDate" value='<s:property value="yearEndDate"/>'></div>
                <input type="hidden" name="hidyearEndDate" id="hidyearEndDate" value='<s:property value="hidyearEndDate"/>'>
            </div>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="txtyearendclosedocno" value='<s:property value="txtyearendclosedocno"/>' style="width:125px;" tabindex="-1" readonly>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:140px;">Year To Close</label>
            <div style="width: 125px;">
                <div id="accountingYearFrom" name="accountingYearFrom" value='<s:property value="accountingYearFrom"/>'></div>
                <input type="hidden" name="hidaccountingYearFrom" id="hidaccountingYearFrom" value='<s:property value="hidaccountingYearFrom"/>'>
            </div>
            
            <label class="lbl-right" style="width:30px; text-align: center;">To</label>
            <div style="width: 125px;">
                <div id="accountingYearTo" name="accountingYearTo" value='<s:property value="accountingYearTo"/>'></div>
                <input type="hidden" name="hidaccountingYearTo" id="hidaccountingYearTo" value='<s:property value="hidaccountingYearTo"/>'>
            </div>

            <button class="myButton" type="button" id="btnview" name="btnview" style="margin-left: 15px;" onclick="funloadgrid();">Submit</button>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:140px;">Next Accounting Year</label>
            <div style="width: 125px;">
                <div id="ycloseDateFrom" name="ycloseDateFrom" value='<s:property value="ycloseDateFrom"/>'></div>
                <input type="hidden" name="hidycloseDateFrom" id="hidycloseDateFrom" value='<s:property value="hidycloseDateFrom"/>'>
            </div>
            
            <label class="lbl-right" style="width:30px; text-align: center;">To</label>
            <div style="width: 125px;">
                <div id="ycloseDateTo" name="ycloseDateTo" value='<s:property value="ycloseDateTo"/>'></div>
                <input type="hidden" name="hidycloseDateTo" id="hidycloseDateTo" value='<s:property value="hidycloseDateTo"/>'>
            </div>
        </div>
    </div>

    <div class="middle-panel" style="padding-bottom: 20px;">
        <span class="middle-panel-title">Year End Close Allocations</span>
        <div id="yearEndCloseDiv" class="grid-container">
            <jsp:include page="yearEndCloseGrid.jsp"></jsp:include>
        </div>
        <div id="yearEndCloseGroupDiv" style="display:none;">
            <jsp:include page="yearEndCloseGroupGrid.jsp"></jsp:include>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
        <input type="hidden" name="txttrno" id="txttrno" value='<s:property value="txttrno"/>'>
        <input type="hidden" name="txtnettotal" id="txtnettotal" value='<s:property value="txtnettotal"/>'>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="yearendclosegroupgridlength" name="yearendclosegroupgridlength"/>
    </div>

</div>
</form>
</body>
</html>