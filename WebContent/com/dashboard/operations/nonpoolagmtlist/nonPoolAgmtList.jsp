<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">
	$(document).ready(function () {
		$('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Vendor Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   	$('#clientwindow').jqxWindow('close');
	   	$('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   	$('#fleetwindow').jqxWindow('close');
	   	$('#groupwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   	$('#groupwindow').jqxWindow('close');
	   	$('#brandwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   	$('#brandwindow').jqxWindow('close');
	   	$('#modelwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   	$('#modelwindow').jqxWindow('close');
	   
	   	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	   	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	   	document.getElementById("chkoverdue").checked=true;
	   	setChkOverdue();
		
	   	$('#clientname').dblclick(function(){
	  		$('#clientwindow').jqxWindow('open');
	       	clientSearchContent('vendorSearchGrid.jsp?id=1', $('#clientwindow')); 
      	});
	   
	    $('#fleet').dblclick(function(){
	  		$('#fleetwindow').jqxWindow('open');
	    	fleetSearchContent('fleetsearch.jsp?id=1', $('#fleetwindow')); 
       	});
	    $('#group').dblclick(function(){
	  		$('#groupwindow').jqxWindow('open');
	    	groupSearchContent('groupsearch.jsp?id=1', $('#groupwindow')); 
       	});
	    $('#brand').dblclick(function(){
	  	    $('#brandwindow').jqxWindow('open');
	       	brandSearchContent('brandsearch.jsp?id=1', $('#brandwindow')); 
      	});
	   	$('#model').dblclick(function(){
	  	    $('#modelwindow').jqxWindow('open');
	  	  	modelSearchContent('modelsearch.jsp?id=1', $('#modelwindow')); 
       	}); 
	   
	 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	
	 	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 	var onemonthbackdate=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
	 	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbackdate));
	 
	 	$('#todate').on('change', function (event) {
			var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 	var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
		   	if(fromdate>todate){
				$.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   		return false;
		  	}   
	 	});
	});
	
	function funExportBtn(){
		JSONToCSVCon(agmtlistdataexcel, 'Non Pool Agreement List', true);
	}
	 
	function getbrand(event){
		var x= event.keyCode;
	 	if(x==114){
	  		$('#brandwindow').jqxWindow('open');
			brandSearchContent('brandsearch.jsp?id=1', $('#brandwindow'));
		}
	 	else{
		}
	} 
	 
	function modelSearchContent(url) {
		$.get(url).done(function (data) {
			$('#modelwindow').jqxWindow('open');
			$('#modelwindow').jqxWindow('setContent', data);
		}); 
	} 
	
	function getbrand(event){
		var x= event.keyCode;
	 	if(x==114){
	  		$('#brandwindow').jqxWindow('open');
			brandSearchContent('brandsearch.jsp?id=1', $('#brandwindow'));
		}
	 	else{
		}
	}
	 
	function brandSearchContent(url) {
		$.get(url).done(function (data) {
			$('#brandwindow').jqxWindow('open');
			$('#brandwindow').jqxWindow('setContent', data);
		}); 
	}
	 
	function getgroup(event){
		var x= event.keyCode;
	 	if(x==114){
	  		$('#groupwindow').jqxWindow('open');
			groupSearchContent('groupsearch.jsp?id=1', $('#groupwindow'));    
		}
	 	else{
		}
	}
	 
	function groupSearchContent(url) {
		$.get(url).done(function (data) {
			 $('#groupwindow').jqxWindow('open');
			$('#groupwindow').jqxWindow('setContent', data);
		}); 
	} 
	
	function getfleet(event){
		var x= event.keyCode;
	 	if(x==114){
	  		$('#fleetwindow').jqxWindow('open');
	 		fleetSearchContent('fleetsearch.jsp?id=1', $('#fleetwindow'));
	 	}
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
			clientSearchContent('vendorSearchGrid.jsp?id=1', $('#clientwindow'));    
		}
	 	else{
		}
	}
	 
	function clientSearchContent(url) {
 		$.get(url).done(function (data) {
 			 $('#clientwindow').jqxWindow('open');
 			$('#clientwindow').jqxWindow('setContent', data);
 		}); 
 	}
 	 
	function funreload(event)
	{
		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var todate=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   	if(fromdate>todate){
			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
	   		return false;
	  	} 
	   	else{
	 		var branch = document.getElementById("cmbbranch").value;
     		fromdate= $("#fromdate").val();
	 		todate= $("#todate").val(); 
	 		var cldocno=$('#cldocno').val();
	 		var group=document.getElementById("groupdoc").value;
	   		$("#overlay, #PleaseWait").show();
	   		var model=document.getElementById("modelid").value;
	   		var brand=document.getElementById("brandid").value;
	   		var fleet=document.getElementById("fleet").value;
	   		var status=document.getElementById("status").value;
	   		var chkoverdue=document.getElementById("hidchkoverdue").value;
	  		$("#detlist").load("detailsGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+cldocno+"&group="+group+"&model="+model+"&brand="+brand+"&fleet="+fleet+"&status="+status+"&id=1&chkoverdue="+chkoverdue);
		}
	}

function  funcleardata()
{
	$('input[type=text]').val('');
	$('#clientname,#model,#brand,#group,#fleet,#catname').attr('placeholder', 'Press F3 TO Search'); 
	$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbackdate=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbackdate));
}

function setChkOverdue(){
	if(document.getElementById("chkoverdue").checked==true){
		document.getElementById("hidchkoverdue").value="1";
	}
	else{
		document.getElementById("hidchkoverdue").value="0";	
	}
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
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<div class='hidden-scrollbar'>
			<table width="100%" >
				<tr>
					<td width="20%" >
    					<fieldset style="background: #ECF8E0;">
							<table width="100%" >
								<jsp:include page="../../heading.jsp"></jsp:include>
	 							<tr><td colspan="2">&nbsp;</td></tr>
	  							<tr>
	  								<td align="right" ><label class="branch">From</label></td>
	  								<td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
	  							</tr>
                     			<tr>
                     				<td align="right" ><label class="branch">To</label></td>
                     				<td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                     			</tr>
                     			<tr><td align="center" colspan="2"><input type="checkbox" name="chkoverdue" id="chkoverdue" onchange="setChkOverdue();">&nbsp;<label class="branch" for="chkoverdue">Overdue</label></td></tr>
	 							<tr>
	 								<td align="right"><label class="branch">Status</label></td>
	 								<td align="left">
	 									<select id="status" name="status" style="height:20px;width:70%;" value='<s:property value="status"/>'>
    										<option value="" selected>All</option>  
       										<option value=0>Open</option>
    										<option value=1>Close</option>  
	 									</select>
	 								</td>
	 							</tr> 
 								<tr>
 									<td align="right"><label class="branch">Vendor</label></td>
 									<td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="clientname"/>'></td>
 								</tr> 
  								<tr>
  									<td align="right"><label class="branch">Fleet</label></td>
  									<td align="left"><input type="text" name="fleet" id="fleet"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="getfleet(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="fleet"/>' ></td>
  								</tr> 
   								<tr>
   									<td align="right"><label class="branch">Group</label></td>
   									<td align="left"><input type="text" name="group" id="group" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getgroup(event)" onclick="this.placeholder='' " style="height:20px;width:70%;" value='<s:property value="group"/>' ></td>
   								</tr> 
    							<tr>
    								<td align="right"><label class="branch">Brand</label></td>
    								<td align="left"><input type="text" name="brand" id="brand" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getbrand(event)" onclick="this.placeholder='' " style="height:20px;width:70%;" value='<s:property value="brand"/>' ></td>
    							</tr> 
     							<tr>
     								<td align="right"><label class="branch">Model</label></td>
     								<td align="left"><input type="text" name="model" id="model" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getmodel(event)" onclick="this.placeholder='' " style="height:20px;width:70%;" value='<s:property value="model"/>' ></td>
     							</tr> 
      							<tr><td colspan="2"></td></tr>
	 							<tr>
	 								<td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td>
	 							</tr>
      							<tr><td colspan="2">&nbsp;</td></tr>
     							<tr><td colspan="2" >&nbsp;</td></tr>
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td colspan="2">&nbsp;</td></tr>
							</table>
						</fieldset>	
					</td>
					<td width="80%">
						<table width="100%">
							<tr>
		 						<td><div id="detlist"><jsp:include page="detailsGrid.jsp"></jsp:include></div></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2"></td></tr>
				<tr><td colspan="2"></td></tr>
			</table>
			<input type="hidden" name="cldocno" id="cldocno"  style="height:20px;width:70%;" value='<s:property value="cldocno"/>'>
			<input type="hidden" name="groupdoc" id="groupdoc"  style="height:20px;width:70%;" value='<s:property value="groupdoc"/>'>
			<input type="hidden" name="brandid" id="brandid"  style="height:20px;width:70%;" value='<s:property value="brandid"/>'>
			<input type="hidden" name="modelid" id="modelid"  style="height:20px;width:70%;" value='<s:property value="modelid"/>'>	
			<input type="hidden" name="hidchkoverdue" id="hidchkoverdue"  style="height:20px;width:70%;" value='<s:property value="hidchkoverdue"/>'>	
			
			<div id="catwindow">
  					<div></div>
			</div>
			<div id="clientwindow">
		   		<div ></div>
			</div>
			<div id="fleetwindow">
		   		<div ></div>
			</div>
			<div id="groupwindow">
		   		<div ></div>
			</div>
			<div id="brandwindow">
		   		<div ></div>
			</div>
			<div id="modelwindow">
		  		<div ></div>
			</div>
		</div>
	</div>
</body>
</html>
	 