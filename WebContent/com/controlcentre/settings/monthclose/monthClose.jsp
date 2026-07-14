<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i) - Month Close</title>
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
	    /* Formatted heights to match modern UI 24px standard */
	    $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", value: new Date()});
	    $("#dateupto").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", value: null});
	    $("#mclosedate").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", value: null });
	   
	    /* force internal alignment AFTER render */
		setTimeout(function () {
		     $("#date, #dateupto, #mclosedate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#date, #dateupto, #mclosedate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		}, 0);

	    $('#mclosedate').focusout(function(){
	    	checkDate(); 
	    	$('#mclosedate').jqxDateTimeInput('focus');
	    });
    });
	
	function getUptodate(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items != null && items !== ""){
					$('#dateupto').jqxDateTimeInput('val', new Date(items));
				} else {
					$('#dateupto').jqxDateTimeInput('val', null); 
				}
			}
		}
		x.open("GET", "getDateUpto.jsp?branch="+document.getElementById("brchName").value, true);
		x.send();
	}

	function funSearchLoad(){
		changeContent('monthCloseSearch.jsp?branch='+document.getElementById("brchName").value, $('#window')); 
	}

	function funReadOnly() {
		$('#frmMonthClose input').attr('readonly', true);
		$('#dateupto').jqxDateTimeInput({disabled:true});
		$('#date').jqxDateTimeInput({disabled:true});
		$('#mclosedate').jqxDateTimeInput({disabled:true});
	}

	function funRemoveReadOnly() {
		$('#frmMonthClose input').attr('readonly', false);
		$('#mclosedate').jqxDateTimeInput({disabled:false});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=="A"){
			$('#date').jqxDateTimeInput('setDate',new Date());
			$('#dateupto').jqxDateTimeInput('setDate',null);
			$('#mclosedate').jqxDateTimeInput('setDate',null);
			getUptodate();
		}
	}

	function setValues() {
		if($('#msg').val() != ""){
			$.messager.alert('Message',$('#msg').val());
		}
	}
	
	function funNotify(){
	    if($('#mclosedate').jqxDateTimeInput('getDate') == null){
	        document.getElementById("errormsg").innerText="Month Close Date is Mandatory";
	        return 0;
	    }
	    if($('#dateupto').jqxDateTimeInput('getDate') == null){
	        document.getElementById("errormsg").innerText="Month Close Date is Mandatory";
	        return 0;
	    }
	    if($('#mclosedate').jqxDateTimeInput('getDate') <= $('#dateupto').jqxDateTimeInput('getDate')){
	        document.getElementById("errormsg").innerText="Month Close Date Cannot be less than Upto Date";
	        return 0;
	    }
	    checkDate();
	    $('#dateupto').jqxDateTimeInput({disabled:false});
	    $('#date').jqxDateTimeInput({disabled:false});
	    return 1;
	} 

	function funFocus(){
	    $('#mclosedate').jqxDateTimeInput('focus');
	}

	function checkDate(){
		var closedate = new Date($('#mclosedate').jqxDateTimeInput('getDate'));
      	var lastday = new Date(closedate.getFullYear(), closedate.getMonth() + 1, 0).getDate();
      	var currentday = new Date($('#mclosedate').jqxDateTimeInput('getDate')).getDate();
      	
      	if(lastday != currentday){
      		document.getElementById("errormsg").innerText="Month Close Date must be at Month End";
      		$('#mclosedate').jqxDateTimeInput('focus');
      		return false;
      	} else {
      		document.getElementById("errormsg").innerText="";
      		return true;
      	}
	}
</script>  
 
</head>
<body onLoad="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMonthClose" action="saveMonthClose" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <div class="middle-panel">
            <span class="middle-panel-title">Month Close Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Date</label>
                <div style="width: 125px;">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:120px; margin-left:auto;">Doc No</label>
                <input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' style="width:125px;" />
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:120px;">Period Upto</label>
                <div style="width: 125px;">
                    <div id="dateupto" name="dateupto" value='<s:property value="dateupto"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:120px; margin-left:20px;">Month Close Date</label>
                <div style="width: 125px;">
                    <div id="mclosedate" name="mclosedate" value='<s:property value="mclosedate"/>'></div>
                </div>
            </div>
        </div>

        <div style="display:none;">
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
        </div>

    </div>
</form>
</div>
</body>
</html>