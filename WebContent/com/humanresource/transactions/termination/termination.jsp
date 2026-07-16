<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i) - Termination</title>
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
.modern-ui label.error,
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; margin-left: 4px; }

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
		$('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		
        /* Formatted heights to match modern UI 24px standard */
		$("#terminationDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy"});
		$("#notifyDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy"});
		$("#joiningDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value:null});
		$("#appraisalDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value:null});
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#terminationDate, #notifyDate, #joiningDate, #appraisalDate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#terminationDate, #notifyDate, #joiningDate, #appraisalDate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

		$('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employees Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		$('#employeeDetailsWindow').jqxWindow('close');
 		 
 		$('#txtemployeeid').dblclick(function(){
 			employeeSearchContent("employeeDetailsSearch.jsp");
		});
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		    $('#employeeDetailsWindow').jqxWindow('setContent', data);
		    $('#employeeDetailsWindow').jqxWindow('bringToFront');
	    }); 
	}
  
    function getEmployeeDetails(event){
        var x= event.keyCode;
        if(x==114){
    	    employeeSearchContent("employeeDetailsSearch.jsp");
        }
    }
	
    function getLastTerminalBenefitsDone(date,type){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				 items = items.split('***');
			     $('#txtchkgridload').val(items[0]);
			     $('#txtchkdate').val(items[1]);
			     $('#txtchksalarypaid').val(items[3]);
			   
			     document.getElementById("errormsg").innerText="Terminal Benefits done till "+items[2]+".";
			     
			    if(parseInt($('#txtchkdate').val())==0){
				    if(parseInt($('#txtchkgridload').val())==1){
					    if(parseInt($('#txtchksalarypaid').val())==0){  
					        $("#overlay, #PleaseWait").show();
					        $("#terminationDiv").load("terminationGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value+"&empid="+$('#txtemployeedocno').val()+"&type="+type);
					        $('#txtchkgridload').val('');
					        $('#txtgridload').val(1);
					    } else {
						    $.messager.alert('Message','Payroll Processing Pending.','warning');
						    $("#terminationGridID").jqxGrid('clear'); 
			                $("#terminationGridID").jqxGrid('addrow', null, {});
			                $("#terminationAccountsGridID").jqxGrid('clear');
			                $("#terminationGridID").jqxGrid({ disabled: true});
						    $("#terminationAccountsGridID").jqxGrid({ disabled: true});
						    return;
					    }
				    } else if(parseInt($('#txtchkgridload').val())==0) {
						$.messager.alert('Message','Terminal Benefits Pending for Last-Month.','warning');
						$("#terminationGridID").jqxGrid('clear'); 
			            $("#terminationGridID").jqxGrid('addrow', null, {});
			            $("#terminationAccountsGridID").jqxGrid('clear');
			            $("#terminationGridID").jqxGrid({ disabled: true});
						$("#terminationAccountsGridID").jqxGrid({ disabled: true});
						return;
				    } else if(parseInt($('#txtchkgridload').val())==2) {
						if(parseInt($('#txtchksalarypaid').val())==0){  
							$('#notifyDate').val(items[4]);
						    $("#overlay, #PleaseWait").show();
						    $("#terminationDiv").load("terminationGrid.jsp?check=1&deprdate="+$('#notifyDate').val()+"&branch="+document.getElementById("brchName").value+"&empid="+$('#txtemployeedocno').val());
						    $('#txtchkgridload').val('');
						    $('#txtgridload').val(1);
						} else {
							$.messager.alert('Message','Payroll Processing Pending.','warning');
							$("#terminationGridID").jqxGrid('clear'); 
				            $("#terminationGridID").jqxGrid('addrow', null, {});
				            $("#terminationAccountsGridID").jqxGrid('clear');
				            $("#terminationGridID").jqxGrid({ disabled: true});
							$("#terminationAccountsGridID").jqxGrid({ disabled: true});
							return;
						}
					}
			    } else {
					$("#terminationGridID").jqxGrid('clear'); 
			        $("#terminationGridID").jqxGrid('addrow', null, {});
			        $("#terminationAccountsGridID").jqxGrid('clear');
					$("#terminationGridID").jqxGrid({ disabled: true});
					$("#terminationAccountsGridID").jqxGrid({ disabled: true});
				}
			}
		}
		x.open("GET", "getLastTerminalBenefitsDone.jsp?date="+date+"&branch="+document.getElementById("brchName").value+"&empid="+$('#txtemployeedocno').val(), true);
		x.send();
	}
  
    function funProcessBtn(){
        if($('#txtemployeedocno').val()==''){
            $.messager.alert('Message','Employee is Mandatory.','warning');
            return;
        }
		  
        var paydate = $('#notifyDate').jqxDateTimeInput('getDate');
        var validdate=funDateInPeriod(paydate);
        if(validdate==0){ return 0; }
        
        var type=$('#cmbtype').val();
        var date = $('#notifyDate').val();
        getLastTerminalBenefitsDone(date,type);
    }
	  
    function funCalculateBtn(){
        if($('#txtemployeedocno').val()==''){
            $.messager.alert('Message','Employee is Mandatory.','warning');
            return;
        }
		  
        if($('#txtgridload').val()=='1'){
            var length = 0;
            var rows = $("#terminationGridID").jqxGrid('getrows');
            length = rows.length;
            if(!(length=='0')){
                $("#overlay, #PleaseWait").show();
                $("#accountDiv").load("accountsDetailsGrid.jsp?check=2&empid="+$('#txtemployeedocno').val());
            }
        } else {
            $.messager.alert('Message','Process & Then Calculate.','warning');
            return;
        }
    }

    function funReadOnly(){
        $('#frmTermination input').attr('readonly', true );
        $('#cmbtype').attr('disabled', true );
        $('#terminationDate').jqxDateTimeInput({disabled: true});
        $('#notifyDate').jqxDateTimeInput({disabled: true});
        $('#joiningDate').jqxDateTimeInput({disabled: true});
        $('#appraisalDate').jqxDateTimeInput({disabled: true});
        $("#terminationGridID").jqxGrid({ disabled: true});
        $("#terminationAccountsGridID").jqxGrid({ disabled: true});
        $('#btnProcessing').hide();$('#btnCalculate').hide();
    }
	 
    function funRemoveReadOnly(){
        $('#frmTermination input').attr('readonly', false );
        $('#cmbtype').attr('disabled', false );
        $('#terminationDate').jqxDateTimeInput({disabled: false});
        $('#notifyDate').jqxDateTimeInput({disabled: false});
        $('#joiningDate').jqxDateTimeInput({disabled: true});
        $('#appraisalDate').jqxDateTimeInput({disabled: true});
        $("#terminationGridID").jqxGrid({ disabled: true});
        $("#terminationAccountsGridID").jqxGrid({ disabled: true});
        $('#btnProcessing').show();$('#btnCalculate').show();
        
        $('#docno').attr('readonly', true);
        $('#txtemployeeid').attr('readonly', true);
        $('#txtemployeename').attr('readonly', true);
        $('#txtemployeedepartment').attr('readonly', true);
        $('#txtemployeedesignation').attr('readonly', true);
        $('#txtemployeecategory').attr('readonly', true);
        $('#txtdrtotal').attr('readonly', true);
        $('#txtcrtotal').attr('readonly', true);
        
        if ($("#mode").val() == "E") {
            $("#terminationGridID").jqxGrid('addrow', null, {});
        }
        
        if ($("#mode").val() == "A") {
            $('#terminationDate').val(new Date());
            $('#notifyDate').val(new Date());
            $('#joiningDate').val(null);
            $('#appraisalDate').val(null);
            $("#terminationGridID").jqxGrid('clear'); 
            $("#terminationGridID").jqxGrid('addrow', null, {});
            $("#terminationAccountsGridID").jqxGrid('clear'); 
        }
    }
	 
    function funSearchLoad(){
        changeContent('htreMainSearch.jsp');  
    }
		
    function funChkButton() { /* funReset(); */ }
	 
    function funFocus(){
        $('#terminationDate').jqxDateTimeInput('focus'); 	    		
    }
	 
    $(function(){
        $('#frmTermination').validate({
            rules: { txtemployeeid:"required" },
            messages: { txtemployeeid:" *" }
        });
    }); 
	   
    function funNotify(){	
        document.getElementById("errormsg").innerText="";
	    		
        /* Termination Grid Saving */
        var rows = $("#terminationGridID").jqxGrid('getrows');
        var length=0;
        for(var i=0 ; i < rows.length ; i++){
            var chk=rows[i].terminations;
            if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "test"+length)
                .attr("name", "test"+length)
                .attr("hidden", "true");
                length=length+1;
                
                newTextBox.val(rows[i].terminations+":: "+rows[i].gratuity+":: "+rows[i].leavesalary+":: "+rows[i].travel);
                newTextBox.appendTo('form');
            }
        }
        $('#gridlength').val(length); 
	 	 
        /* Account Details Grid Saving */
        var accountsrows = $("#terminationAccountsGridID").jqxGrid('getrows');
        var journalslength=0;
        for(var j=0 ; j < accountsrows.length ; j++){
            var chked=accountsrows[j].acno;
            if(typeof(chked) != "undefined" && typeof(chked) != "NaN" && chked != ""){
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "journals"+journalslength)
                .attr("name", "journals"+journalslength)
                .attr("hidden", "true");
                journalslength=journalslength+1;
            
                newTextBox.val(accountsrows[j].acno+":: "+accountsrows[j].debit+":: "+accountsrows[j].credit);
                newTextBox.appendTo('form');
            }
        }
        $('#journalsgridlength').val(journalslength);
            
        var accountrows = $("#terminationAccountsGridID").jqxGrid('getrows');
        var journallength=0;
        for(var k=0 ; k < accountrows.length ; k++){
            var chks=accountrows[k].acno;
            if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "journal"+journallength)
                .attr("name", "journal"+journallength)
                .attr("hidden", "true");
                journallength=journallength+1;
                
                var amount=0,id=1;
                if((accountrows[k].credit!=null) && (accountrows[k].credit!='undefined') &&  (accountrows[k].credit!='NaN') && (accountrows[k].credit!="") && (accountrows[k].credit!=0)){
                    amount=accountrows[k].credit*-1;
                    id=-1;
                }
                
                if((accountrows[k].debit!=null) && (accountrows[k].debit!='undefined') && (accountrows[k].debit!='NaN') && (accountrows[k].debit!="") && (accountrows[k].debit!=0)){
                    amount=accountrows[k].debit;
                    id=1;
                }
                
                newTextBox.val(accountrows[k].acno+":: "+amount+":: "+id);
                newTextBox.appendTo('form');
            }
        }
        $('#journalgridlength').val(journallength);
        
        $('#joiningDate').jqxDateTimeInput({disabled: false});
        $('#appraisalDate').jqxDateTimeInput({disabled: false});
			
        return 1;
    } 
	  
    function setValues(){
        if($('#hidcmbtype').val()!=""){
            $('#cmbtype').val($('#hidcmbtype').val());
        }
        
        if($('#hidterminationDate').val()){
            $("#terminationDate").jqxDateTimeInput('val', $('#hidterminationDate').val());
        }
        
        if($('#hidnotifyDate').val()){
            $("#notifyDate").jqxDateTimeInput('val', $('#hidnotifyDate').val());
        }
        
        if($('#hidjoiningDate').val()){
            $("#joiningDate").jqxDateTimeInput('val', $('#hidjoiningDate').val());
        }
        
        if($('#hidappraisalDate').val()){
            $("#appraisalDate").jqxDateTimeInput('val', $('#hidappraisalDate').val());
        }

        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();
        
        var indexVal = document.getElementById("docno").value;
        if(indexVal>0){
            $("#terminationDiv").load("terminationGrid.jsp?docno="+indexVal+"&trno="+$('#txttrno').val()+"&empid="+$('#txtemployeedocno').val());
            $("#accountDiv").load("accountsDetailsGrid.jsp?docno="+indexVal+"&trno="+$('#txttrno').val()+"&empid="+$('#txtemployeedocno').val());
        }
    }
	   
    function funPrintBtn() {
        if (($("#mode").val() == "view") && $("#docno").val()!="") {
            var url=document.URL;
            reurl=url.split("transactions");
            $("#docno").prop("disabled", false);
            
            $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
                if (r){
                    var win= window.open(reurl[0]+"transactions/termination/printTermination?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                    win.focus();
                } else{
                    var win= window.open(reurl[0]+"transactions/termination/printTermination?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                    win.focus();
                }
            });
        } else {
            $.messager.alert('Message','Select a Document....!','warning');
            return;
        }
    }
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmTermination" action="saveTermination" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Termination Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 125px;">
                <div id="terminationDate" name="terminationDate" value='<s:property value="terminationDate"/>'></div>
                <input type="hidden" id="hidterminationDate" name="hidterminationDate" value='<s:property value="hidterminationDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Doc No.</label>
            <input type="text" id="docno" name="txtterminationdocno" style="width:125px;" value='<s:property value="txtterminationdocno"/>' tabindex="-1" readonly/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Type</label>
            <select id="cmbtype" name="cmbtype" style="width:125px;" value='<s:property value="cmbtype"/>'>
                <option value="TER">Termination</option>
                <option value="RES">Resignation</option>
            </select>
            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Notify. Date</label>
            <div style="width: 125px;">
                <div id="notifyDate" name="notifyDate" value='<s:property value="notifyDate"/>'></div>
                <input type="hidden" id="hidnotifyDate" name="hidnotifyDate" value='<s:property value="hidnotifyDate"/>'/>
            </div>
            
            <button class="myButton" type="button" id="btnProcessing" onclick="funProcessBtn();" style="margin-left: 10px;">Process</button>
            <button class="myButton" type="button" id="btnCalculate" onclick="funCalculateBtn();">Calculate</button>
        </div>
    </div>

    <div class="middle-panel" style="background-color: #fdfdfd;">
        <span class="middle-panel-title">Employee Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Employee ID</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Press F3" value='<s:property value="txtemployeeid"/>' onkeydown="getEmployeeDetails(event);"/>
                <svg class="magnifier-icon" onclick="employeeSearchContent('<%=contextPath%>/employeeDetailsSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Name</label>
            <input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="flex:1; max-width:300px;" value='<s:property value="txtemployeename"/>' tabindex="-1" readonly/>
            <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Category</label>
            <input type="text" id="txtemployeecategory" name="txtemployeecategory" placeholder="Category" style="flex:1; max-width:200px;" value='<s:property value="txtemployeecategory"/>' tabindex="-1" readonly/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Designation</label>
            <input type="text" id="txtemployeedesignation" name="txtemployeedesignation" placeholder="Designation" style="flex:1; max-width:300px;" value='<s:property value="txtemployeedesignation"/>' tabindex="-1" readonly/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Department</label>
            <input type="text" id="txtemployeedepartment" name="txtemployeedepartment" placeholder="Department" style="flex:1; max-width:300px;" value='<s:property value="txtemployeedepartment"/>' tabindex="-1" readonly/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Date of Join</label>
            <div style="width: 125px;">
                <div id="joiningDate" name="joiningDate" value='<s:property value="joiningDate"/>'></div>
                <input type="hidden" id="hidjoiningDate" name="hidjoiningDate" value='<s:property value="hidjoiningDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:100px; margin-left:15px;">Appraisal Dt.</label>
            <div style="width: 125px;">
                <div id="appraisalDate" name="appraisalDate" value='<s:property value="appraisalDate"/>'></div>
                <input type="hidden" id="hidappraisalDate" name="hidappraisalDate" value='<s:property value="hidappraisalDate"/>'/>
            </div>
        </div>
    </div>
    
    <div class="middle-panel" style="padding-bottom: 20px;">
        <span class="middle-panel-title">Terminal Benefits</span>
        <div id="terminationDiv" class="grid-container">
            <jsp:include page="terminationGrid.jsp"></jsp:include>
        </div>
    </div>
    
    <div class="middle-panel" style="padding-bottom: 20px;">
        <span class="middle-panel-title">Account Details</span>
        <div id="accountDiv" class="grid-container">
            <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:100px; text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:100px; text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="journalgridlength" name="journalgridlength"/>
        <input type="hidden" id="journalsgridlength" name="journalsgridlength"/>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtgridload" name="txtgridload" value='<s:property value="txtgridload"/>'/>
        <input type="hidden" id="txtchkgridload" name="txtchkgridload" value='<s:property value="txtchkgridload"/>'/>
        <input type="hidden" id="txtchksalarypaid" name="txtchksalarypaid" value='<s:property value="txtchksalarypaid"/>'/>
        <input type="hidden" id="txtchkdate" name="txtchkdate" value='<s:property value="txtchkdate"/>'/>
    </div>

</div>
</form>

<div id="employeeDetailsWindow"><div></div><div></div></div>	

</div>
</body>
</html>