<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<script type="text/javascript">

	$(document).ready(function () {
	   //  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		// $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	   //  var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	   //  var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	   //  var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	   //  $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     $("#detailList").hide();
	
	});

	function funreload(event){
			//alert("in reload");
			//var fromdate = $('#fromdate').val();
		    // var todate = $('#todate').val();
			 $("#overlay, #PleaseWait").show();
			 
			 $("#loaDiv").load("loaGrid.jsp?check="+1);
	}
	
	function funExportBtn(){
		
		  	JSONToCSVCon(dataExcel, 'LOA List', true);
		  	JSONToCSVCon(detExcel, 'LOA Detail List', true);
		
	 }
	 
   function funLoadData(){
   
  
   var doc=$('#hiddoc').val();
	//alert(doc);
   if($('#hiddoc').val()==''){
		$.messager.alert('Warning','Please select a valid document');
		return 0;
	}
    if($('#cmbtype').val()==''){
		$.messager.alert('Warning','Please select a Type');
		return 0;
	}
	 $("#detailList").show();
	var type=$('#cmbtype').val();
    $("#DetailDiv").load("loadetailGrid.jsp?docno="+doc+"&type="+type+"&tst="+1);
   
   }
		
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
    <tr><td colspan="2">&nbsp;</td></tr>
     <%-- <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  --%>
     <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td align="right"><label class="branch">Type</label></td><td align="left"><select name="cmbtype" id="cmbtype" style="height:20px;width:50%;"><option value="">--Select--</option><option value="VEH">Vehicle</option><option value="DRV">Driver</option></select></td></tr>
       <tr><td colspan="2">&nbsp;</td></tr>
        <tr><td colspan="2">&nbsp;</td></tr>
        <tr><td  align="center" colspan="2"><input type="Button" name="load" id="load" class="myButton" value="Vehicle-Driver Detail" onclick="funLoadData();"></td> </tr>
        <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
       <tr><td colspan="2">&nbsp;</td></tr>
        <tr><td colspan="2">&nbsp;</td></tr>
        
         <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
      
	<%-- <tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:70%;" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="SLM">Sales Man</option><option value="SLA">Sales Agent</option><option value="RLA">Rental Agent</option>
    <option value="DRV">Driver</option><option value="CHK">Check In</option><option value="STF">Staff</option></select></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td style="background-color: #FFEBEB;"></td>
	<td align="left"><label class="branch">Sales Man</label></td></tr>
	<tr><td style="background-color: #FFFFD1;"></td>
	<td align="left"><label class="branch">Sales Agent</label></td></tr>
	<tr><td style="background-color: #FFFAFA;"></td>
	<td align="left"><label class="branch">Rental Agent</label></td></tr> 
	<tr><td style="background-color: #F0FFFF;"></td>
	<td align="left"><label class="branch">Driver</label></td></tr>
	<tr><td style="background-color: #F8E0F7;"></td>
	<td align="left"><label class="branch">Staff</label></td></tr>
	<tr><td style="background-color: #F7F2E0;"></td>
	<td align="left"><label class="branch">Check In</label></td></tr> --%>
    <tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="loaDiv"><jsp:include page="loaGrid.jsp"></jsp:include></div>
			 <input type="hidden" name="hiddoc" id="hiddoc" value='<s:property value="hiddoc"/>'></td>
			  
		</tr>
		<tr>
		<td><div id="DetailDiv"><jsp:include page="loadetailGrid.jsp"></jsp:include></div></td>
		</tr>
	
	</table>
</tr>
</table>
</div>


</div> 
</body>
</html>