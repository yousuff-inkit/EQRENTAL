
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
/* 	 $("#jqxDateOut").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#jqxDaterentalout").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"}); */
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	
	   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#agmtwindow').jqxWindow({ width: '60%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#agmtwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   $('#clientcatwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientcatwindow').jqxWindow('close');
		$('#agmtno').dblclick(function(){
	  		$('#agmtwindow').jqxWindow('open');
	    	agmtSearchContent('agmtMasterSearch.jsp', $('#agmtwindow')); 
      	});
      	$('#clientcat').dblclick(function(){
	  		$('#clientcatwindow').jqxWindow('open');
	  		$("#overlay, #PleaseWait").show();
	    	clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow')); 
      	});
	   	$('#clientname').dblclick(function(){
	  		$('#clientwindow').jqxWindow('open');
	       	clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
      	});
	    $('#fleet').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
		    fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
       	});
	 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 	var onemonth=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
     	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonth));
	 	$('#todate').on('change', function (event) {
			var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 	var todate=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		   	if(fromdates>todates){
				$.messager.alert('Message','To Date Less Than From Date  ','warning');   
			   	return false;
		  	}   
	 	});
}); 
function getAgmtno(event){
	var x= event.keyCode;
	if(x==114){
		$('#agmtwindow').jqxWindow('open');
	    agmtSearchContent('agmtMasterSearch.jsp', $('#agmtwindow'));
	}
	else{
	}
} 
function getClientCat(event){
	var x= event.keyCode;
	if(x==114){
		$('#clientcatwindow').jqxWindow('open');
		$("#overlay, #PleaseWait").show();
	    clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow')); 
	}
	else{
	}
}
function agmtSearchContent(url) {
	$.get(url).done(function (data) {
		$('#agmtwindow').jqxWindow('open');
		$('#agmtwindow').jqxWindow('setContent', data);
	}); 
} 
function clientCatSearchContent(url) {
	$.get(url).done(function (data) {
		$('#clientcatwindow').jqxWindow('open');
		$('#clientcatwindow').jqxWindow('setContent', data);
	}); 
}

function getfleet(event){
	var x= event.keyCode;
	if(x==114){
		$('#fleetwindow').jqxWindow('open');
	 	fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
	else{
	}
} 
function fleetSearchContent(url) {
	$.get(url).done(function (data) {
		$('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);
	}); 
} 
function getclinfo(event){
	var x= event.keyCode;
	if(x==114){
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }
	else{
	}
} 
function clientSearchContent(url) {
	$.get(url).done(function (data) {
 		$('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 	}); 
} 
function funreload(event){
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var todate=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	var agmtno=$('#hidagmtno').val();
	var clientcat=$('#hidclientcat').val();
	var cldocno=$('#cldocno').val();
/*	if(agmtno=="" || clientcat=="" || cldocno==""){
		$.messager.alert('Warning','Please select a filter');
		return false;
 	}  */
	if(fromdate>todate){
		$.messager.alert('Message','To Date Less Than From Date  ','warning');   
	   	return false;
	} 
	else{
		var branch = document.getElementById("cmbbranch").value;
     	var fromdate= $("#fromdate").val();
	 	var todate= $("#todate").val(); 
	 	
	  	$("#detlist").load("detailsGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+"&clientcat="+clientcat+"&agmtno="+agmtno+"&id=1");
	}
	disiem(); 
}
function  funcleardata()
{
	document.getElementById("cldocno").value="";
	document.getElementById("fleet").value="";
	document.getElementById("clientname").value="";
	//document.getElementById("rentaltype").value="Daily";
	document.getElementById("status").value="0";
	/* 
	$('#jqxDateOut').val(new Date());
	$('#jqxDaterentalout').val(new Date()); */
	$('#agmtno,#hidagmtno,#clientcat,#hidclientcat').val('');
	document.getElementById("docnos").value="";
 	document.getElementById("excessinsur").value="";
	document.getElementById("normalinsu").value="";
	document.getElementById("cdwinsu").value="";
	document.getElementById("supercdwinsu").value=""; 
	
	document.getElementById("gridlength").value="";
	document.getElementById("branchid").value="";
	
	if (document.getElementById("clientname").value == "") {
		$('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	}
	if (document.getElementById("fleet").value == "") {
		$('#fleet').attr('placeholder', 'Press F3 TO Search'); 
	}
}
	
function funExportBtn(){
	if(parseInt(window.parent.chkexportdata.value)=="1"){
		JSONToCSVCon(shotterm, 'RAG-Payment', true);
	}
	else{
	    $("#detailsgrid").jqxGrid('exportdata', 'xls', 'RAG-Payment');
	}
}
	
function disiem()
{
	// $("#jqxgridpayment").jqxGrid({ disabled: true});

	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "mode","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "amount","");
	$('#jqxgridpayment').jqxGrid('setcellvalue', 0, "acode","");
	$('#jqxgridpayment').jqxGrid('setcellvalue', 0, "cardno","");
	$('#jqxgridpayment').jqxGrid('setcellvalue', 0, "expdate","");
	$('#jqxgridpayment').jqxGrid('setcellvalue', 0, "hidexpdate","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "card","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "cardtype","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "paytype","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "rano","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "odate","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "brhid","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "vocno","");
	
}
</script>
<style>
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

     
      

</style>
</head>
<body onload="getBranch();disiem()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
     
	
	 <tr><td align="right"><label class="branch">Status</label></td><td align="left"><select id="status" name="status" style="height:20px;width:70%;" value='<s:property value="status"/>'>
        <option value=0>Open</option> <option value="1">Close</option> <option value="">All</option>
   	 </select></td></tr> 
 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="clientname"/>'></td></tr> 
  <tr><td align="right"><label class="branch">Fleet</label></td><td align="left"><input type="text" name="fleet" id="fleet"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="getfleet(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="fleet"/>' ></td></tr>
  <tr><td align="right"><label class="branch">Agreement</label></td><td align="left"><input type="text" name="agmtno" id="agmtno"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="getAgmtno(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="agmtno"/>' ></td></tr>
  <tr><td align="right"><label class="branch">Client Category</label></td><td align="left"><input type="text" name="clientcat" id="clientcat"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="getClientCat(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="clientcat"/>' ></td></tr> 
   <%-- <tr><td align="right"><label class="branch">Group</label></td><td align="left"><input type="text" name="group" id="group" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getgroup(event)" onclick="this.placeholder='' " style="height:20px;width:70%;" value='<s:property value="group"/>' ></td></tr> 
    <tr><td align="right"><label class="branch">Brand</label></td><td align="left"><input type="text" name="brand" id="brand" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getbrand(event)" onclick="this.placeholder='' " style="height:20px;width:70%;" value='<s:property value="brand"/>' ></td></tr> 
     <tr><td align="right"><label class="branch">Model</label></td><td align="left"><input type="text" name="model" id="model" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getmodel(event)" onclick="this.placeholder='' " style="height:20px;width:70%;" value='<s:property value="model"/>' ></td></tr> 
 --%>      <tr hidden="true"><td align="right"><label class="branch">Type</label></td><td align="left">
       <select id="rentaltype" name="rentaltype" style="height:20px;width:70%;" value='<s:property value="rentaltype"/>'>
    <option value=""></option>
     <option value=""></option>
     
	 </select> </td></tr> 
	 <tr><td colspan="2"></td></tr>
	 <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"><!-- <input type="button" class="myButton" name="update" id="update"  value="Update" onclick="funupdatera()"> --></td></tr>
	  <tr><td colspan="2"></td></tr>
	   <tr><td colspan="2"></td></tr>
     <%-- <tr><td colspan="2" align="center">
					<button type="button"  title="Search User"  class="icon" id="searchuser"  onclick="getuserchange()" value='<s:property value="searchuser"/>'>
					 <img alt="Search User" src="<%=contextPath%>/icons/searchusers.png"> 
					</button></td></tr>--%>
	<tr> 
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 80px;"></div></td> 
	</tr>	
	</table>
	</fieldset>
	
<%-- 	  <div hidden="true" id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div> <!-- //dudate --> 
	   <div hidden="true" id='jqxDaterentalout' name='jqxDaterentalout' value='<s:property value="jqxDaterentalout"/>'></div>  --%>
	<input type="hidden" name="hidagmtno" id="hidagmtno"  style="height:20px;width:70%;" value='<s:property value="hidagmtno"/>'>  
	<input type="hidden" name="hidclientcat" id="hidclientcat"  style="height:20px;width:70%;" value='<s:property value="hidclientcat"/>'>
	<input type="hidden" name="cldocno" id="cldocno"  style="height:20px;width:70%;" value='<s:property value="cldocno"/>'>
	<input type="hidden" name="groupdoc" id="groupdoc"  style="height:20px;width:70%;" value='<s:property value="groupdoc"/>'>
	<input type="hidden" name="brandid" id="brandid"  style="height:20px;width:70%;" value='<s:property value="brandid"/>'>
	<input type="hidden" name="modelid" id="modelid"  style="height:20px;width:70%;" value='<s:property value="modelid"/>'> 
	 
	<input type="hidden" name="docnos" id="docnos"  style="height:20px;width:70%;" value='<s:property value="docnos"/>'>
	
	<input type="hidden" id="excessinsur"  name="excessinsur" style="text-align: right;"  value='<s:property value="excessinsur"/>' >
	
	   <input type="hidden" name="normalinsu" id="normalinsu" value='<s:property value="normalinsu"/>'  />
      <input type="hidden" name="cdwinsu" id="cdwinsu" value='<s:property value="cdwinsu"/>'  /> 
      <input type="hidden" name="supercdwinsu" id="supercdwinsu" value='<s:property value="supercdwinsu"/>'  />
	<input type="hidden" id="gridlength" name="gridlength">
	
	
	<input type="hidden" id="branchid"  name="branchid" style="text-align: right;"  value='<s:property value="branchid"/>' >
	
	
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="detlist"><jsp:include page="detailsGrid.jsp"></jsp:include></div></td></tr>
	 	<tr><td>&nbsp;</td></tr>
		<tr><td><div id="rtariff"><jsp:include page="paymentgrid.jsp"></jsp:include></div></td></tr>
		<tr><td>&nbsp;</td></tr>
	</table>
</td>
</tr>
</table>

</div>
<div id="clientwindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="agmtwindow">
   <div ></div>
</div>
<div id="clientcatwindow">
   <div ></div>
</div>
<div id="usersearchwindow">
   <div ></div>
</div>
</div>
</body>
</html>
	 