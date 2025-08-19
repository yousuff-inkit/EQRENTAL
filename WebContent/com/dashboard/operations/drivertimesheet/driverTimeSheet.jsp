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

<style type="text/css">
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

.mySaveButton {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #77d42a), color-stop(1, #5cb811));
	background:-moz-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-webkit-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-o-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-ms-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:linear-gradient(to bottom, #77d42a 5%, #5cb811 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#77d42a', endColorstr='#5cb811',GradientType=0);
	background-color:#77d42a;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #268a16;
	display:inline-block;
	cursor:pointer;
	font-family:Verdana;
	font-size:10px;
	font-weight:bold;
	padding:4px 8px;
	text-decoration:none;
	text-shadow:0px -1px 0px #aade7c;
}
.mySaveButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cb811), color-stop(1, #77d42a));
	background:-moz-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-webkit-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-o-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-ms-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:linear-gradient(to bottom, #5cb811 5%, #77d42a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cb811', endColorstr='#77d42a',GradientType=0);
	background-color:#5cb811;
}
.mySaveButton:active {
	position:relative;
	top:1px;
}

.myConfirmButton {
	-moz-box-shadow: 0px 1px 0px 0px #fff6af;
	-webkit-box-shadow: 0px 1px 0px 0px #fff6af;
	box-shadow: 0px 1px 0px 0px #fff6af;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffec64), color-stop(1, #ffab23));
	background:-moz-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-webkit-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-o-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-ms-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:linear-gradient(to bottom, #ffec64 5%, #ffab23 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffec64', endColorstr='#ffab23',GradientType=0);
	background-color:#ffec64;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #ffaa22;
	display:inline-block;
	cursor:pointer;
	font-family:Verdana;
	font-size:10px;
	font-weight:bold;
	padding:4px 8px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffee66;
}
.myConfirmButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffab23), color-stop(1, #ffec64));
	background:-moz-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-webkit-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-o-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-ms-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:linear-gradient(to bottom, #ffab23 5%, #ffec64 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffab23', endColorstr='#ffec64',GradientType=0);
	background-color:#ffab23;
}
.myConfirmButton:active {
	position:relative;
	top:1px;
}

hr.mystylebetween {
	height: 6px;
	background: url(hr-12.png) repeat-x 0 0;
    border: 0;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#branchlabel").hide();$("#branchdiv").hide();
		 $('#btnSubmit').attr('disabled', false);$('#btnCalculate').attr('disabled', true);
		 
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true, value: null});
		
		 /* Searching Window */
     	 $('#driverDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Driver Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#driverDetailsWindow').jqxWindow('close');
  		 
  		 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#agreementDetailsWindow').jqxWindow('close');
 		 
  		 
		 $('#schserchinfowindow').jqxWindow({ width: '90%', height: '60%',  maxHeight: '70%' ,maxWidth: '95%' ,title: 'Time-Sheet Fill' , position: { x: 70, y: 100 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#schserchinfowindow').jqxWindow('close');
			
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 9999; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 9999;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#txtdrivername').dblclick(function(){
			 
			 $('#txtorgridclick').val('1');
			 driverSearchContent("driverDetailsSearch.jsp");
	     });
		 
		 $('#txtagreement').dblclick(function(){
			 $('#txtorgridclick').val('1');
			 agreementNoSearchContent("agreementDetailSearch.jsp");
	     });
		 
		 document.getElementById("view").checked=true;
		 setShow();
	});
	
	function driverSearchContent(url) {
	 	$('#driverDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#driverDetailsWindow').jqxWindow('setContent', data);
		$('#driverDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementNoSearchContent(url) {
	    $('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

	function schSearchContent(url) {
	    $('#schserchinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#schserchinfowindow').jqxWindow('setContent', data);
		$('#schserchinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					var optionsyear = '<option value="">--Select--</option>';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbyear").html(optionsyear);
					if($('#hidcmbyear').val()){
						document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
						freload(event);
					  }
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
	
	 function getDriverId(event){
        var x= event.keyCode;
        if(x==114){
        	
        	driverSearchContent("driverDetailsSearch.jsp");
        }
        else{}
	 }
	 
	 function getAgreementNo(event){
	        var x= event.keyCode;
	        if(x==114){
	        	$('#txtorgridclick').val('1');
				agreementNoSearchContent("agreementDetailSearch.jsp");
	        }
	        else{}
		 }
	 
	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');
		$('#date').val(null);$('#hiddate').val('');$('#txtdriverid').val('');$('#txtdrivername').val('');
	    $('#txtagreementid').val('');$('#txtagreement').val('');$('#txtfillbtnclick').val('0');
	    
	    $("#timeSheetDetailsGridID").jqxGrid('clear');$("#timeSheetDetailsGridID").jqxGrid('addrow', null, {});
	    
	    if (document.getElementById("txtdriverid").value == "") {
	        $('#txtdriverid').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtdrivername').attr('placeholder', 'Driver Name');
	    }
	    
	    if (document.getElementById("txtagreement").value == "") {
	        $('#txtagreement').attr('placeholder', 'Press F3 to Search'); 
	    }
		
	 }
	
	function funRestrictDate(){
		  var date = $('#date').jqxDateTimeInput('val');
		  
		  if(date!=''){
			  if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
					 $.messager.alert('Message','Year and Month are Mandatory.','warning');
					 $("#date").jqxDateTimeInput('val', null);
		             return 0;
			  }
		  }
		  var day = date.split(".");
		  var restrictedDate = new Date(new Date($('#cmbyear').val(),(parseInt($('#cmbmonth').val())-1),day[0]));
		  $("#date").jqxDateTimeInput('val', restrictedDate);
	}
	
	function funChangeDate(){
		$("#date").jqxDateTimeInput('val', null);
	}
	
	function funFillGrid(){
		
		if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
			 $.messager.alert('Message','Year and Month are Mandatory.','warning');
          return 0;
		 }
		 $('#txtfillbtnclick').val('1');
		 schSearchContent('timeSheetFillSearch.jsp');
	}
	
	function freload(event){
		 
		 if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		 $("#overlay, #PleaseWait").show();
		 
		 $("#timeSheetDetailsGridID").jqxGrid('clear');
		 $("#timeSheetDetailsGridID").jqxGrid('addrow', null, {"date": ""+$('#date').val()+"","drid": ""+$('#txtdriverid').val()+"","drname": ""+$('#txtdrivername').val()+"","agmtvoc_no": ""+$('#txtagreement').val()+"","agmtdoc_no": ""+$('#txtagreementid').val()+"","hrs": ""});
		 
		 $("#overlay, #PleaseWait").hide();
	}
	
	function funreload(event){
		 
		 if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		var driverID=$('#txtdriverdocno').val();
		var agmtNo=$('#txtagreementid').val();
		var year=$('#cmbyear').val();
		var month=$('#cmbmonth').val();
		var date=$('#date').jqxDateTimeInput('val');
		
		$("#overlay, #PleaseWait").show();
		$("#timeSheetDetailsDiv").load('timeSheetGrid.jsp?driverid='+driverID+'&agmtno='+agmtNo+'&year='+year+'&month='+month+'&date='+date+'&id=1');
		
	}
	
	function funNotify(){	
		
		if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Year is Mandatory.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Month is Mandatory.','warning');
			 return 0;
		 } 
		
		   var rows = $('#timeSheetDetailsGridID').jqxGrid('getrows');
	       var rowlength= rows.length;
		   if(rowlength==0 || (rowlength==1 && ((rows[0].hrs=="" && rows[0].othrs=="" ) || (typeof(rows[0].hrs) == "undefined" && typeof(rows[0].othrs) == "undefined" )))){
				$.messager.alert('Message','Enter Details & Save Again. ','warning');
				return 0;
		   } 
		  
		   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 		if (r){
	 				
	 			/* Time Sheet Grid  Saving*/
			 	var rows = $("#timeSheetDetailsGridID").jqxGrid('getrows');
			 	var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						 
						if(i!=(rows.length-1)){
							var chkhrs=rows[i].hrs;var chkothrs=rows[i].othrs;
							if(typeof(chkhrs) == "undefined" || typeof(chkhrs) == "NaN" || chkhrs == "" || chkhrs == null){
								if(typeof(chkothrs) == "undefined" || typeof(chkothrs) == "NaN" || chkothrs == "" || chkothrs == null){
									
									 $.messager.alert('Message','Please Enter Hour Details for '+rows[i].drname,'warning');
									 return 0;
									
								}
							}
						} else if(i==(rows.length-1)){
							var chkhrs=rows[i].hrs;var chkothrs=rows[i].othrs;var chkdate=rows[i].date;var chkdrid=rows[i].drid;
							if(typeof(chkhrs) == "undefined" || typeof(chkhrs) == "NaN" || chkhrs == "" || chkhrs == null){
								if(typeof(chkothrs) == "undefined" || typeof(chkothrs) == "NaN" || chkothrs == "" || chkothrs == null){
										if(typeof(chkdate) == "undefined" || typeof(chkdate) == "NaN" || chkdate == "" || chkdate == null){
											if(typeof(chkdrid) == "undefined" || typeof(chkdrid) == "NaN" || chkdrid == "" || chkdrid == null){
												    var rowid = $("#timeSheetDetailsGridID").jqxGrid('getrowid', (rows.length-1));
									                $("#timeSheetDetailsGridID").jqxGrid('deleterow', rowid);
											}
										}
									
								}
							}
						}
						
						
						
						
						if((typeof(chkhrs) != "undefined" && typeof(chkhrs) != "NaN" && chkhrs != "" && chkhrs != null) || (typeof(chkothrs) != "undefined" && typeof(chkothrs) != "NaN" && chkothrs != "" && chkothrs != null) || (typeof(chkhothrs) != "undefined" && typeof(chkhothrs) != "NaN" && chkhothrs != "" && chkhothrs != null)){
						
							var chkdate=rows[i].date;
							if(typeof(chkdate) == "undefined" || typeof(chkdate) == "NaN" || chkdate == "" || chkdate == null){
								 $.messager.alert('Message','Date is Mandatory for '+rows[i].empid+' - '+rows[i].empname,'warning');
								 return 0;
							} 
							if(typeof(chkdate) != "undefined" && typeof(chkdate) != "NaN" && chkdate != "" && chkdate != null) {
								
								var chkdrid=rows[i].drid;
								if(typeof(chkdrid) == "undefined" || typeof(chkdrid) == "NaN" || chkdrid == "" || chkdrid == null){
									 $.messager.alert('Message','Driver is Mandatory for the Detail Dated '+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "date"),'warning');
									 return 0;
								} 
								if(typeof(chkdrid) != "undefined" && typeof(chkdrid) != "NaN" && chkdrid != "" && chkdrid != null) {
									
									var chkagreement=rows[i].agmtdoc_no;
									if(typeof(chkagreement) == "undefined" || typeof(chkagreement) == "NaN" || chkagreement == "" || chkagreement == null){
										 $.messager.alert('Message','Agreement is Mandatory for '+rows[i].drname,'warning');
										 return 0;
									} else {
										
										newTextBox = $(document.createElement("input"))
									    .attr("type", "dil")
									    .attr("id", "test"+length)
									    .attr("name", "test"+length)
										.attr("hidden", "true");
										length=length+1;
										
							       		newTextBox.val(rows[i].drid+"::"+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "date")+":: "+rows[i].agmtdoc_no+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "hrs")+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "othrs")+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "intime")+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "outtime"));
							       		newTextBox.appendTo('form');
							       		
									} 
						       }
					       }
				      }
				}
	 		 	$('#gridlength').val(length);
			 	/* Time Sheet Grid  Saving Ends*/
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardTimeSheet").submit();
			 
	 		 }
	 		});
		 
		return 1;
	}
	
	function setValues(){
		getYear();
		
		document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
	  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 $('#gridlength').val('');
		 }
	}
	function setShow(){
		
		if(document.getElementById("view").checked){
			document.getElementById("btnSaveSalaryPayment").disabled = true;
			document.getElementById("btnFill").disabled = true;
			document.getElementById("txtagreement").disabled = false;
			document.getElementById("txtdrivername").disabled = false;
			$("#timeSheetDetailsGridID").jqxGrid({editable: false});
		}
		else if(document.getElementById("add").checked){
			$("#timeSheetDetailsGridID").jqxGrid('clear');$("#timeSheetDetailsGridID").jqxGrid('addrow', null, {});
			document.getElementById("btnSaveSalaryPayment").disabled = false;
			document.getElementById("btnFill").disabled = false;
			document.getElementById("txtagreement").disabled = true;
			document.getElementById("txtdrivername").disabled = true;
			$("#timeSheetDetailsGridID").jqxGrid({editable: true});
		}
		
	}
	
	function funExportBtn(){
		JSONToCSVCon(data1, 'TimeSheet', true);
	} 
	
</script>
</head>
<body onload="getBranch();setValues();getYear();">
<form id="frmDashboardTimeSheet" action="saveDashboardDriverTimeSheet" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td align="right"><label class="branch">Year</label></td>
     <td align="left"><select id="cmbyear" name="cmbyear" onchange="funChangeDate();" style="width:80%;" value='<s:property value="cmbyear"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Month</label></td>
     <td align="left"><select id="cmbmonth" name="cmbmonth" style="width:80%;" onchange="funChangeDate();" value='<s:property value="cmbmonth"/>'>
      <option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td></tr>
	 <tr><td colspan="2"><hr class="mystylebetween"></td></tr>
	 <tr>
	 	<td align="right"><label class="branch">View</label><input type="radio" name="rdshow" id="view" onclick="setShow();"></td>
	 	<td align="center"><label class="branch">Add</label><input type="radio" name="rdshow" id="add" onclick="setShow();"></td>
	 </tr>
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" onchange="funRestrictDate();" value='<s:property value="date"/>'></div>
     <input type="hidden" id="hiddate" name="hiddate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiddate"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Agreement</label></td>
     <td align="left"><input type="text" id="txtagreement" name="txtagreement" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtagreement"/>' onkeydown="getAgreementNo(event);"/>
     <input type="hidden" id="txtagreementid" name="txtagreementid" value='<s:property value="txtagreementid"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Driver</label></td>
     <td align="left"><input type="text" id="txtdrivername" name="txtdrivername" readonly="readonly" placeholder="Driver Name" style="width:95%;height:20;" tabindex="-1" value='<s:property value="txtdrivername"/>' onkeydown="getDriverId(event);"/>
     <input type="hidden" id="txtdriverdocno" name="txtdriverdocno" value='<s:property value="txtdriverdocno"/>'/></td></tr>
	 
	 <tr><td colspan="2"><hr class="mystylebetween"></td></tr>
	 
	 
	 <tr><td colspan="2" align="center"><div id="btnDiv1"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">&nbsp;
	 <input type="button" class="myButton" name="btnFill" id="btnFill"  value="Fill" onclick="funFillGrid();">&nbsp;&nbsp;&nbsp;
	 <input type="button" class="mySaveButton" id="btnSaveSalaryPayment" name="btnSaveSalaryPayment" value="Save" onclick="funNotify();"></div></td></tr>
	 
	 
	 <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;<input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;" value='<s:property value="gridlength"/>'/>
     <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
     <input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'>
     <input type="hidden" name="txtorgridclick" id="txtorgridclick" style="width:100%;height:20px;" value='<s:property value="txtorgridclick"/>'>
     <input type="hidden" name="txtfillbtnclick" id="txtfillbtnclick" style="width:100%;height:20px;" value='<s:property value="txtfillbtnclick"/>'></td></tr>
	 </table>
	 </fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="timeSheetDetailsDiv"><jsp:include page="timeSheetGrid.jsp"></jsp:include></div></td></tr>
	</table>
</td></tr></table>

</div>

<div id="driverDetailsWindow">
   <div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div>
</div> 
<div id="schserchinfowindow">
   <div></div>
</div>
</div> 
</form>
</body>
