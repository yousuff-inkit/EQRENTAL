<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
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

.modern-ui input[type="checkbox"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
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

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }

.status {
	color: #FD8725;
	font-family: 'Segoe UI', 'Roboto', sans-serif;
	font-size: 14px;
	font-weight: bold;
}

#lblclientstatus {
  animation-duration: 1s;
  animation-name: blink;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@keyframes blink {
  from { opacity: 1; }
  to { opacity: 0; }
}
</style>

<script type="text/javascript">
	$(document).ready(function () { 
		$('#btnClose').attr('disabled', true); $('#btnCreate').attr('disabled', true); $('#btnEdit').attr('disabled', true); $('#btnExcel').attr('disabled', true);
		$('#btnDelete').attr('disabled', true); $('#btnSearch').attr('disabled', true); $('#btnAttach').attr('disabled', true); $('#btnPrint').attr('disabled', true);
		 
		/* Formatted jqxDateTimeInput heights to match modern UI 24px */
		$("#jqxNonFinancialDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		$("#jqxClientReviewDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		
		/* force internal alignment AFTER render */
        setTimeout(function () {
            $("#jqxNonFinancialDate, #jqxClientReviewDate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#jqxNonFinancialDate, #jqxClientReviewDate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

		$('#clientWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Clients Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true });
		$('#clientWindow').jqxWindow('close');
		
		$('#nonFinancialWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '30%' ,maxWidth: '51%' , title: 'Non-Financial Comments',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true });
		$('#nonFinancialWindow').jqxWindow('close');
		
		document.getElementById("hidchckdetailed").value = 0;
		getIDPDetails();
		
		$('#txtclientname').dblclick(function(){
			clientSearchContent('clientDetailsSearch.jsp');
		});
	});
	
	function clientSearchContent(url) {
	    $('#clientWindow').jqxWindow('open');
		$.get(url).done(function (data) {
            $('#clientWindow').jqxWindow('setContent', data);
            $('#clientWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function nonFinancialCommentsContent(url) {
	    $('#nonFinancialWindow').jqxWindow('open');
		$.get(url).done(function (data) {
            $('#nonFinancialWindow').jqxWindow('setContent', data);
            $('#nonFinancialWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function getIDPDetails(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			    $('#idpdetailsallowed').val(items);
		    }
		}
		x.open("GET", "getIDPDetailsAllowed.jsp", true);
		x.send();
    }
	
	function getAccountBalance(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  			    $('#txtbalance').val(items[0]);
  			    $('#lblclientstatus').html(items[1]);
  		    }
  		}
  		x.open("GET", "getAccountBalance.jsp?accountno="+a+'&cldocno='+b, true);
  		x.send();
 	}
	
	function getAcc(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearch.jsp');
	    }
	}
	
	function funDetailed(){
        if(document.getElementById("chckdetailed").checked){
            $.messager.confirm('Confirm', 'Do you want to have detailed informations?', function(r){
                if (r){
                    document.getElementById("hidchckdetailed").value = 1;
                    var detailed=$('#hidchckdetailed').val();
                    var cldocno=$('#txtcldocno').val();
                    var accno=$('#txtaccno').val();
                    if(cldocno != ""){
                        $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
                        $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
                        $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
                        $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
                    }
                    if(accno != ""){
                        $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+cldocno+'&detailed='+detailed);
                    }
                } else{
                    document.getElementById("chckdetailed").checked = false;
                    document.getElementById("hidchckdetailed").value = 0;
                }
            });
        } else{
            document.getElementById("chckdetailed").checked = false;
            document.getElementById("hidchckdetailed").value = 0;
            var detailed=$('#hidchckdetailed').val();
            var cldocno=$('#txtcldocno').val();
            var accno=$('#txtaccno').val();
            if(cldocno != ""){
                $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
                $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
                $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
                $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
            }
            if(accno != ""){
                $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+cldocno+'&detailed='+detailed);
            }
        }
	}
	
	function funOutStandingStatement(){
		var accno = $('#txtaccno').val();
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client.','warning');
			 return 0;
		}
		
	    if ($("#txtaccno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("clientReview.jsp");
	        $("#txtaccno").prop("disabled", false);
	        var win= window.open(reurl[0]+"clientReviewOutstandingsStatement?atype=AR&acno="+document.getElementById("txtaccno").value+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("brchName").value+'&uptoDate='+$("#jqxClientReviewDate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	    } else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
	}
  
    function funSaveDetails(event){
		var mode = $("#mode").val("A");
		var cldocno = $('#txtcldocno').val();
		var description = $('#txtdescription').val();
		
		if(cldocno==''){
			 $.messager.alert('Message','Choose a Client.','warning');
			 return 0;
		}
			
        $.messager.confirm('Message', 'Do you want to save changes?', function(r){
            if(r==false) {
                return false; 
            } else{
                saveGridData(description,cldocno,mode);	
            }
        });
	}
    
    function funDeleteDocu(event){
		var mode = $("#mode").val("D");
		var cldocno = $('#txtcldocno').val();
		
		if(cldocno==''){
			 $.messager.alert('Message','Choose a Client.','warning');
			 return 0;
		}
			
        $.messager.confirm('Message', 'Do you want to delete?', function(r){
            if(r==false) {
                return false; 
            } else{
                $('#txtdescription').val('');
                $('#txtdescriptions').val('');
                var description = 0;
                saveGridData(description,cldocno,mode);	
            }
        });
	}
	
	function saveGridData(description,cldocno,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items=x.responseText;
                $.messager.alert('Message', 'Successfully Completed. ', function(r){});
                funreload(event); 
            }
		}
        x.open("GET","saveData.jsp?description="+description+"&cldocno="+cldocno+"&mode="+mode,true);
        x.send();
	}
	
	function funAttachButton(){
		if (($("#mode").val() == "view") && $("#txtcldocno").val()!="") {
			$("#windowattach").jqxWindow('setTitle',"CRM - "+document.getElementById("txtcldocno").value);
			changeAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=CRM&docno="+document.getElementById("txtcldocno").value);		
		} else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	}
	
	function funReadOnly(){
		$('#frmClientReview input').attr('readonly', true );
		$("#financialCommentsGridID").jqxGrid({ disabled: true});
		$("#operationGridID").jqxGrid({ disabled: true});
		$("#quotationGridID").jqxGrid({ disabled: true});
		$("#accidentDamageGridID").jqxGrid({ disabled: true});
		$("#driverGridID").jqxGrid({ disabled: true});
		$("#btnbalance").hide();
    }
	
 	function funRemoveReadOnly(){}
 	function funSearchLoad(){}
	function funChkButton() {}
 
 	function funFocus(){
    	document.getElementById("txtclientname").focus();	    		
    }
   
    function funNotify(){	
        return 1;
	} 
  
    function setValues(){
        $("#btnbalance").show();
        
        if(document.getElementById("hidchckdetailed").value==1){
            document.getElementById("chckdetailed").checked = true;
        } else if(document.getElementById("hidchckdetailed").value==0){
            document.getElementById("chckdetailed").checked = false;
        }
        
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();
        
        var detailed=$('#hidchckdetailed').val();
        var accno=$('#txtaccno').val();
        if(accno != ""){
            var indexVal = document.getElementById("txtcldocno").value;
            $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+indexVal+'&detailed='+detailed);
        }
        
        var cldocno=$('#txtcldocno').val();
        if(cldocno != ""){
            $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
            $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
            $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
            $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
        }
        
        $('#txtdescription').attr('readonly', false);
	}
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientReview" action="saveClientReview" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    
    <!-- TOP SECTION: General Info -->
    <div class="middle-panel">
        <span class="middle-panel-title">Client Info</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:60px;">Client</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtclientname" name="txtclientname" placeholder="Press F3" onkeydown="getAcc(event);" value='<s:property value="txtclientname"/>'/>
                <svg class="magnifier-icon" onclick="$('#txtclientname').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
            <input type="hidden" id="txtaccno" name="txtaccno" value='<s:property value="txtaccno"/>'/>
            
            <label class="lbl-right" style="width:120px;">Account Balance</label>
            <input type="text" id="txtbalance" name="txtbalance" style="width:100px; text-align:right; font-weight:bold;" value='<s:property value="txtbalance"/>'/>
            
            <div style="margin-left:15px; min-width:80px;">
                <label class="status" id="lblclientstatus" name="lblclientstatus"><s:property value="lblclientstatus"/></label>
            </div>
            
            <label style="margin-left:15px; display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                <input type="checkbox" id="chckdetailed" name="chckdetailed" value="" onchange="funDetailed();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                Detailed
            </label>
            <input type="hidden" id="hidchckdetailed" name="hidchckdetailed" value='<s:property value="hidchckdetailed"/>'/>
            
            <button class="myButton" type="button" id="btnbalance" name="btnbalance" onclick="funOutStandingStatement();" style="margin-left:15px;">Outstanding Statement</button>
            <button class="myButton" type="button" id="btnAttach" name="btnAttach" onclick="funAttachButton();" style="margin-left:10px;">Attach</button>
        </div>
    </div>


    <!-- MIDDLE SECTION: Operations & Payment Follow-Up -->
    <div class="middle-panel" style="background:#fcfdfa;">
        <span class="middle-panel-title">Operations</span>
        <div id="operationDiv" class="grid-container">
            <jsp:include page="operationGrid.jsp"></jsp:include>
        </div>
    </div>
	  
    <div style="display: flex; gap: 15px;">
        <div class="middle-panel" style="flex: 7; background:#faf5fa;">
            <span class="middle-panel-title">Payment Follow-Up</span>
            <div id="paymentFollowUpDiv" class="grid-container">
                <jsp:include page="paymentFollowUpGrid.jsp"></jsp:include>
            </div>
        </div>
        <div class="middle-panel" style="flex: 3;">
            <span class="middle-panel-title">Description</span>
            <jsp:include page="description.jsp"></jsp:include>
        </div>
    </div>

    <!-- BOTTOM SECTION: Driver, Accident, Quotation -->
    <div class="middle-panel" style="background:#fdfdff;">
        <span class="middle-panel-title">Driver Details</span>
        <div id="driverDiv" class="grid-container">
            <jsp:include page="driverDetailsGrid.jsp"></jsp:include>
        </div>
    </div>

    <div class="middle-panel" style="background:#fffafa;">
        <span class="middle-panel-title">Accident / Damage History</span>
        <div id="accidentDamageDiv" class="grid-container">
            <jsp:include page="accidentDamageHistoryGrid.jsp"></jsp:include>
        </div>
    </div>

    <div class="middle-panel" style="background:#fcfcff;">
        <span class="middle-panel-title">Quotation Details</span>
        <div id="quotationDiv" class="grid-container">
            <jsp:include page="quotationGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Core Logic Fields -->
    <div style="display:none;">
        <div id="jqxClientReviewDate" name="jqxClientReviewDate" value='<s:property value="jqxClientReviewDate"/>'></div>
        <div id="jqxNonFinancialDate" name="jqxNonFinancialDate" value='<s:property value="jqxNonFinancialDate"/>'></div>
        <input type="hidden" id="hidjqxNonFinancialDate" name="hidjqxNonFinancialDate" value='<s:property value="hidjqxNonFinancialDate"/>'/>
        <input type="hidden" id="txtnonfinancialcomment" name="txtnonfinancialcomment" value='<s:property value="txtnonfinancialcomment"/>'/>
        <input type="hidden" id="docno" name="txtnonfinancialdocno" value='<s:property value="txtnonfinancialdocno"/>'/>
        <input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed" value='<s:property value="idpdetailsallowed"/>'/>

        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>

</div>
</form>

<!-- Search Windows -->
<div id="clientWindow"><div></div></div>
<div id="nonFinancialWindow"><div></div></div>  

</div>
</body>
</html>