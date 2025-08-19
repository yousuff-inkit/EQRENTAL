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
.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#costCodeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Cost Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeDetailsWindow').jqxWindow('close');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
		 $('#hidchckuptodate').val(0);document.getElementById("rdsummary").checked=true;
		 
		 $('#txtcostcodeid').dblclick(function(){
			  if($('#cmbcosttype').val()==''){
    			 $.messager.alert('Message','Please Choose Cost Type.','warning');
    			 return 0;
    		  }
			  costCodeSearchContent('costCodeDetailsSearch.jsp');
			});
		 
	});
	
	function costCodeSearchContent(url) {
	    $('#costCodeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeDetailsWindow').jqxWindow('setContent', data);
		$('#costCodeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getCostType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbcosttype").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getCostType.jsp", true);
		x.send();
	}
	
	function funExportBtn(){
		//JSONToCSVCon(dataExcel, 'CostLedger', true);
		if(document.getElementById("rddetailed").checked==true){
		  $("#costLedgerDetailedDiv").excelexportjs({  
       		containerid: "costLedgerDetailedDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "costLedgerDetailGridID", 
       		columns: getColumns("costLedgerDetailGridID") , 
       		worksheetName:"Detail Cost Ledger"
       		}); 
		}
		else{
			 $("#costLedgerSummaryDiv").excelexportjs({  
       		containerid: "costLedgerSummaryDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "costLedgerSummaryGridID", 
       		columns: getColumns("costLedgerSummaryGridID") , 
       		worksheetName:"Summary Cost Ledger"
       		}); 
		}
	} 
	
	function getCostCode(event){
        var x= event.keyCode;
        if(x==114){
		    if($('#cmbcosttype').val()==''){
    			 $.messager.alert('Message','Please Choose Cost Type.','warning');
    			 return 0;
    		 }
		    costCodeSearchContent('costCodeDetailsSearch.jsp');
        }
        else{}
        }
	
	
	function clearCostCodeInfo(){
		$('#txtcostcode').val('');$('#txtcostcodeid').val('');$('#txtcostcodename').val('');
		
		if (document.getElementById("txtcostcodeid").value == "") {
	        $('#txtcostcodeid').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		$("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
		$("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
	}
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var costtype = $('#cmbcosttype').val();
		 var costcode = $('#txtcostcode').val();
		 var check = 1;
		 
		if(costtype==''){
			 $.messager.alert('Message','Please Choose Cost Type.','warning');
			 return 0;
		 }
		 
		 if(costcode==''){
			 $.messager.alert('Message','Cost Code is Mandatory.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 document.getElementById("lblaccountname").innerText=$("#cmbcosttype option:selected").text().trim()+" - "+$('#txtcostcodename').val();
		 if(document.getElementById("rddetailed").checked==true){
		 	$("#costLedgerDetailedDiv").load("costLedgerDetailGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&costtype='+costtype+'&costcode='+costcode+'&check='+check);
		 } else {
			$("#costLedgerSummaryDiv").load("costLedgerSummaryGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&costtype='+costtype+'&costcode='+costcode+'&check='+check);
		 }
		 
		}
	
	function checkuptodate(){
		 if(document.getElementById("chckuptodate").checked){
			 document.getElementById("hidchckuptodate").value = 1;
			 $('#fromdate').jqxDateTimeInput({disabled: true});
			 document.getElementById("rddetailed").checked=true;
			 $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			 $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			 $("#costLedgerSummaryDiv").prop("hidden", true);$("#costLedgerDetailedDiv").prop("hidden", false);			 
			 document.getElementById("lblaccountname").innerText="";
		 }
		 else{
			 document.getElementById("hidchckuptodate").value = 0;
			 $('#fromdate').jqxDateTimeInput({disabled: false});
			 document.getElementById("rdsummary").checked=true;
			 $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			 $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			 $("#costLedgerSummaryDiv").prop("hidden", false);$("#costLedgerDetailedDiv").prop("hidden", true);
			 document.getElementById("lblaccountname").innerText="";
		 }
	 }
	
	function funCheck(a){
		  if(document.getElementById("chckuptodate").checked != false){
		 	  $('#hidchckuptodate').val(1);$('#fromdate').jqxDateTimeInput({disabled: true});
		 	  document.getElementById("rddetailed").checked=true;
		 	  $("#costLedgerSummaryDiv").prop("hidden", true);$("#costLedgerDetailedDiv").prop("hidden", false); 
		 	 $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
		 	$("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
		 	 document.getElementById("lblaccountname").innerText="";
		  }
		  else{
			  $('#hidchckuptodate').val(0);$('#fromdate').jqxDateTimeInput({disabled: false});
			  document.getElementById("rdsummary").checked=true;
			  $("#costLedgerSummaryDiv").prop("hidden", false);$("#costLedgerDetailedDiv").prop("hidden", true); 
			  $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			  $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			  document.getElementById("lblaccountname").innerText="";
		  }
	  }
	
	function radioClick(){
		 if(document.getElementById("rdsummary").checked==true) {
			 $('#hidchckuptodate').val(0);$('#fromdate').jqxDateTimeInput({disabled: false});
			  document.getElementById("chckuptodate").checked=false;
			  $("#costLedgerSummaryDiv").prop("hidden", false);$("#costLedgerDetailedDiv").prop("hidden", true);
			  $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			  $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			  document.getElementById("lblaccountname").innerText="";
		 } else if(document.getElementById("rddetailed").checked==true) {
			 $('#hidchckuptodate').val(1);$('#fromdate').jqxDateTimeInput({disabled: true});
			 document.getElementById("chckuptodate").checked=true;
			 $("#costLedgerSummaryDiv").prop("hidden", true);$("#costLedgerDetailedDiv").prop("hidden", false);
			 $("#costLedgerSummaryGridID").jqxGrid('clear');$("#costLedgerDetailGridID").jqxGrid('clear');
			 $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});$("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
			 document.getElementById("lblaccountname").innerText="";
		 }
	}
	
	
</script>
</head>
<body onload="getBranch();getCostType();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmCostLedger" action="saveCostLedger" method="post" autocomplete="off">
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2"><input type="checkbox" id="chckuptodate" name="chckuptodate" value="" onclick="funCheck();" onchange="checkuptodate();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
    <input type="hidden" id="hidchckuptodate" name="hidchckuptodate" value='<s:property value="hidchckuptodate"/>'/></td></tr>
	<tr>
	<td align="right"><label class="branch">Period</label></td>
    <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">
	<table width="100%"><tr><td width="20%" align="right"><label class="branch">Cost Type</label></td>
	<td width="80%" align="left"><select id="cmbcosttype" name="cmbcosttype" style="width:60%;" onchange="clearCostCodeInfo();" value='<s:property value="cmbcosttype"/>'></select>
    </td></tr>
    <tr><td align="right"><label class="branch">Cost Code</label></td>
	<td align="left"><input type="text" id="txtcostcodeid" name="txtcostcodeid" style="width:70%;height:20px;" readonly placeholder="Press F3 to Search" value='<s:property value="txtcostcodeid"/>' onkeydown="getCostCode(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtcostcodename" name="txtcostcodename" style="width:100%;height:20px;" readonly value='<s:property value="txtcostcodename"/>' tabindex="-1"/>
    <input type="hidden" id="txtcostcode" name="txtcostcode" value='<s:property value="txtcostcode"/>'/>
    </td></tr></table>
    </td></tr> 
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdsummary" name="rdo" onclick="radioClick();" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
       <td width="52%" align="center"><input type="radio" id="rddetailed" name="rdo" onclick="radioClick();" value="rddetailed"><label for="rddetailed" class="branch">Detailed</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
	    <tr><td><label class="account">Cost Center :&nbsp;</label><label class="accname" name="lblaccountname" id="lblaccountname"></label></td></tr> 
		<tr>
			 <td><div id="costLedgerSummaryDiv"><jsp:include page="costLedgerSummaryGrid.jsp"></jsp:include></div>
			 <div id="costLedgerDetailedDiv" hidden="true"><jsp:include page="costLedgerDetailGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<table width="100%">
<tr>
		<td width="92%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Net Amount :&nbsp;</td>
        <td width="8%" align="left"><input type="text" class="textbox" id="txtnetamount" name="txtnetamount" style="width:80%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
</tr>
</table>

</div>
</form>
<div id="costCodeDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>