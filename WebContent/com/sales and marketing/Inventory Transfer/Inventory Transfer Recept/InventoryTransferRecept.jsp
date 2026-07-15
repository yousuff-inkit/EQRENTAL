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
	//getfrmBranch(2);
	
	/* Formatted jqxDateTimeInput heights to match modern UI 24px */
	$("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	
	/* force internal alignment AFTER render */
    setTimeout(function () {
        $("#date").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

	$('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
	$('#sidesearchwndow').jqxWindow('close'); 
	$('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	$('#refnosearchwindow').jqxWindow('close'); 
	   
	$('#branchwindow').jqxWindow({
		width : '25%',
		height : '58%',
		maxHeight : '70%',
		maxWidth : '45%',
		title : 'Branch Search',
		position : { x : 420, y : 87 },
		theme : 'energyblue',
		showCloseButton : true,
		keyboardCloseKey : 27
	});
	$('#branchwindow').jqxWindow('close');
		
	$('#locationwindow').jqxWindow({
		width : '25%',
		height : '58%',
		maxHeight : '70%',
		maxWidth : '45%',
		title : 'Location Search',
		position : { x : 420, y : 87 },
		theme : 'energyblue',
		showCloseButton : true,
		keyboardCloseKey : 27
	});
	$('#locationwindow').jqxWindow('close');
		
	$("#brchName").change(function() {
		if(document.getElementById("mode").value=="A"){
			//getfrmBranch(1);
		}
	});
			
	$("#cmbreftype").change(function() {
		if(document.getElementById("mode").value=="A"){
			if(document.getElementById("cmbreftype").value=="ILT"){
				getfrmBranch(1);
			} else {
				document.getElementById("txtfrmbranch").value="";
				document.getElementById("branchfrmid").value="";
			}
		}
	});
			
	$('#txtfrmbranch').dblclick(function(){
		if ($("#mode").val() == "view") { return 0; }
		if($("#cmbreftype").val()==""){
			document.getElementById("errormsg").innerText="Select an inventory Receipt Type";
			return 0;
		} else {
			document.getElementById("errormsg").innerText="";
		}
		if(document.getElementById("cmbreftype").value=="IBT"){
			var branchfrmid=document.getElementById("branchfrmid").value;
			branchSearchContent('branchSearch.jsp?branchfrmid='+branchfrmid);
		}
	});
			
	$('#txtfrmlocation').dblclick(function(){
		if ($("#mode").val() == "view") { return 0; }
		if($("#cmbreftype").val()==""){
			document.getElementById("errormsg").innerText="Select an inventory Receipt Type";
			return 0;
		} else {
			document.getElementById("errormsg").innerText="";
		}
		var branchid=document.getElementById("branchfrmid").value;
		var searchtype="1";
		locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype);
	});
			
	$('#txttolocation').dblclick(function(){
		if ($("#mode").val() == "view") { return 0; }  
		if($("#cmbreftype").val()==""){
			document.getElementById("errormsg").innerText="Select an inventory Receipt Type";
			return 0;
		} else {
			document.getElementById("errormsg").innerText="";
		}
		var branchid=document.getElementById("branchtoid").value;
		var searchtype="2";
		locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype);
	});
			
	$('#rrefno').dblclick(function(){
		if ($("#mode").val() == "view") { return 0; }   
		if($("#cmbreftype").val()==""){
			document.getElementById("errormsg").innerText="Select an inventory Receipt Type";
			return 0;
		} else {
			document.getElementById("errormsg").innerText="";
		}
		$('#refnosearchwindow').jqxWindow('open');
		refsearchContent('refnosearch.jsp');
	});
});
	
function productSearchContent(url) {
	$.get(url).done(function (data) {
		$('#sidesearchwndow').jqxWindow('open');
		$('#sidesearchwndow').jqxWindow('setContent', data);
	}); 
} 
	
function getLocation(event,searchtype){
	if ($("#mode").val() == "view") { return 0; }
	if(searchtype=="1"){
		var branchid=document.getElementById("branchfrmid").value;
	}
	if(searchtype=="2"){
		var branchid=document.getElementById("branchtoid").value;
	}
	
	var x= event.keyCode;
	if(x==114){
		locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype);  	 
	}
}
   	 
function locationSearchContent(url) {
	$('#locationwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#locationwindow').jqxWindow('setContent', data);
		$('#locationwindow').jqxWindow('bringToFront');
	});
}

function getBranch(event,searchtype){
	if ($("#mode").val() == "view") { return 0; }
	if($("#cmbreftype").val()==""){
		document.getElementById("errormsg").innerText="Select an inventory Receipt Type";
		return 0;
	} else {
		document.getElementById("errormsg").innerText="";
	}
	
	if(document.getElementById("cmbreftype").value=="IBT"){
		var branchfrmid=document.getElementById("branchfrmid").value;
		var x= event.keyCode;
		if(x==114){
			branchSearchContent('branchSearch.jsp?branchfrmid='+branchfrmid);  	 
		}
	} else {
		getfrmBranch(1);
	}
}
  	 
function branchSearchContent(url) {
	$('#branchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#branchwindow').jqxWindow('setContent', data);
		$('#branchwindow').jqxWindow('bringToFront');
	});
}

function funReadOnly(){
	$('#frminventoryrecept input').attr('readonly', true );
	$('#frminventoryrecept select').attr('disabled', true );
	$('#date').jqxDateTimeInput({disabled: true});
	$("#jqxInvReceptGrid").jqxGrid({ disabled: true});
}

function funNotify(){	
	if($("#cmbreftype").val()==""){
		document.getElementById("errormsg").innerText="Select an inventory Receipt Type";
		document.getElementById("cmbreftype").focus();
		return 0;
	}
	
	if($("#txtfrmbranch").val()==""){
		document.getElementById("errormsg").innerText="  Branch Should not be Blank";
		document.getElementById("txtfrmbranch").focus();
		return 0;
	} else if($("#txtfrmlocation").val()==""){
		document.getElementById("errormsg").innerText="  Location Should not be Blank";
		document.getElementById("txtfrmlocation").focus();
		return 0;
	} else if($("#txttolocation").val()==""){
		document.getElementById("errormsg").innerText="  Location Should not be Blank";
		document.getElementById("txttolocation").focus();
		return 0;
	} else if($("#rrefno").val()==""){
		document.getElementById("errormsg").innerText="  select an issue number";
		return 0;
	} else {
		document.getElementById("errormsg").innerText="";
	}
	  
	var rows = $("#jqxInvReceptGrid").jqxGrid('getrows');
	$('#gridlength').val(rows.length);
	   
	for(var i=0 ; i < rows.length ; i++){ 
		newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "prodg"+i)
			.attr("name", "prodg"+i)
			.attr("hidden", "true");
		newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"
			+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+
			rows[i].oldqty+"::"+rows[i].foc+"::");
		newTextBox.appendTo('form');
	}
 	return 1;
}

function funRemoveReadOnly(){
	$('#frminventoryrecept select').attr('disabled', false );
	$('#date').jqxDateTimeInput({disabled: false});
	$("#jqxInvReceptGrid").jqxGrid({ disabled: false});
	$('#gridtext').attr('readonly', false );
	$('#gridtext1').attr('readonly', false );
	$('#txtremark').attr('readonly', false );
	$('#txtrefno').attr('readonly', false );
	if ($("#mode").val() == "E") {
		$("#roundOf").val("0.0");
		$("#jqxInvReceptGrid").jqxGrid({ disabled: false});
		$("#jqxInvReceptGrid").jqxGrid('addrow', null, {});
	}
	if ($("#mode").val() == "A") {
		$("#prodsearchtype").val("0");
		$("#orderValue").val("0.0");
		$("#nettotal").val("0.0");
		$("#roundOf").val("0.0");
		$("#orderValue").val("0.0");
		$('#date').val(new Date());
		$("#jqxInvReceptGrid").jqxGrid('clear'); 
		$("#jqxInvReceptGrid").jqxGrid('addrow', null, {});
	}
}

function getfrmBranch(type) {
	var brchid=$('#brchName').val();
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			var items= x.responseText.trim();
			var item = items.split('####');
			var branchid  = item[0];
			var branchname = item[2];
			document.getElementById("txtfrmbranch").value=branchname;
			document.getElementById("branchfrmid").value=branchid;
		}
	}
	x.open("GET","getFrmBranch.jsp?brchid="+brchid+"&type="+type,true);
	x.send();
}

function funChkButton(){}
function funFocus (){}
function funSearchLoad(){
	changeContent('Mastersearch.jsp'); 
}

function setValues() {
	if($('#hiddate').val()){
		$("#date").jqxDateTimeInput('val', $('#hiddate').val());
	}
	
	var masterdoc_no=$('#masterdoc_no').val().trim();
	var refmasterdocno=$('#refmasterdocno').val();
	
	if(masterdoc_no>0){
		if($('#msg').val()!=""){
			$.messager.alert('Message',$('#msg').val());
		}
		if ($('#hidcmbreftype').val() != "" || $('#hidcmbreftype').val() !=null) {
			$('#cmbreftype').val($('#hidcmbreftype').val());
		}
		$("#InvTransReceptGrid").load("InvTransReceptGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&cond=2");
	}
	funchkforedit();
}

function getrefno(event) {
	var x= event.keyCode;
	if(x==114){
		$('#refnosearchwindow').jqxWindow('open');
		refsearchContent('refnosearch.jsp');  
	}
}  
	
function refsearchContent(url) {
	$.get(url).done(function (data) {
		$('#refnosearchwindow').jqxWindow('setContent', data);
	}); 
}

function funPrintBtn(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		var url=document.URL;
		var reurl=url.split("savetransferRecept");
		var win= window.open(reurl[0]+"printtransissuerptAction?docno="+document.getElementById("masterdoc_no").value+"&issueno="+document.getElementById("rrefno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		win.focus();
	} else {
		$.messager.alert('Message','Select a Document....!','warning');
		return false;
	}
}
	 
function funchkforedit() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0) {
				$("#btnEdit").attr('disabled', true );
				$("#btnDelete").attr('disabled', true ); 
			}
		}
	}
	x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
	x.send();    
}

</script>
</head>

<body onload="setValues();"> 
<div id="mainBG" class="homeContent" data-type="background">
<form id="frminventoryrecept" action="savetransferRecept" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include> 

<div class='modern-ui hidden-scrollbar'>
    <!-- Hidden legacy grid text fields -->
    <input type="text" name="gridtext" id="gridtext" style="display:none;" value='<s:property value="gridtext"/>' />   
    <input type="text" name="gridtext1" id="gridtext1" style="display:none;" value='<s:property value="gridtext1"/>' />

    <!-- TOP SECTION: General Info -->
    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>' style="width:125px;" />
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' tabindex="-1" style="width:120px;" readonly />
        </div>
    </div>

    <!-- MIDDLE SECTION: Transfer Details -->
    <div style="display: flex; gap: 15px; margin-bottom: 15px;">
        
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Inventory Issue From</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Type</label>
                <select id="cmbreftype" name="cmbreftype" style="width:125px;" value='<s:property value="cmbreftype"/>'>
                    <option value="">-Select-</option>
                    <option value="IBT">Branch Transfer</option>
                    <option value="ILT">Location Transfer</option>
                </select>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Branch</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="txtfrmbranch" name="txtfrmbranch" placeholder="Press F3" onkeydown="getBranch(event,1);" value='<s:property value="txtfrmbranch"/>' />
                    <svg class="magnifier-icon" onclick="$('#txtfrmbranch').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Location</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="txtfrmlocation" name="txtfrmlocation" placeholder="Press F3" onkeydown="getLocation(event,1);" value='<s:property value="txtfrmlocation"/>' />
                    <svg class="magnifier-icon" onclick="$('#txtfrmlocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
        </div>

        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Inventory Receipt Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Location</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="txttolocation" name="txttolocation" placeholder="Press F3" onkeydown="getLocation(event,2);" value='<s:property value="txttolocation"/>' />
                    <svg class="magnifier-icon" onclick="$('#txttolocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Issue No</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="rrefno" name="rrefno" placeholder="Press F3" onkeydown="getrefno(event);" value='<s:property value="rrefno"/>' />
                    <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Remarks</label>
                <input type="text" id="txtremark" name="txtremark" style="flex:1;" value='<s:property value="txtremark"/>' />
            </div>
        </div>
        
    </div>

    <!-- BOTTOM SECTION: Transfer Grid -->
    <div class="middle-panel">
        <span class="middle-panel-title">Receipt Items</span>
        <div id="InvTransReceptGrid" class="grid-container">
            <jsp:include page="InvTransReceptGrid.jsp"></jsp:include>
        </div>
    </div> 

    <!-- Hidden Core Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
        <input type="hidden" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>'>
        <input type="hidden" name="txtnettotal" id="txtnettotal" value='<s:property value="txtnettotal"/>'>
        <input type="hidden" id="orderValue" name="orderValue" value='<s:property value="orderValue"/>'/>
        <input type="hidden" name="txtproductamt" id="txtproductamt" value='<s:property value="txtproductamt"/>'>
        <input type="hidden" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'>
        <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
        <input type="hidden" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>'>

        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="refmasterdocno" name="refmasterdocno" value='<s:property value="refmasterdocno"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="servgridlen" name="servgridlen" value='<s:property value="servgridlen"/>'/>
        <input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>

        <input type="hidden" id="branchfrmid" name="branchfrmid" value='<s:property value="branchfrmid"/>'/>
        <input type="hidden" id="locationfrmid" name="locationfrmid" value='<s:property value="locationfrmid"/>'/>
        <input type="hidden" id="branchtoid" name="branchtoid" value='<s:property value="branchtoid"/>'/>
        <input type="hidden" id="locationtoid" name="locationtoid" value='<s:property value="locationtoid"/>'/>
        <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
    </div>
    
    <div id="errormsg" style="color:red; font-weight:bold; margin-top:5px;"></div>

</div>
</form>
	
<!-- Search Windows -->
<div id="branchwindow"><div></div></div>	
<div id="locationwindow"><div></div></div>
<div id="sidesearchwndow"><div></div></div>
<div id="refnosearchwindow"><div></div></div> 
	
</div>
</body>
</html>