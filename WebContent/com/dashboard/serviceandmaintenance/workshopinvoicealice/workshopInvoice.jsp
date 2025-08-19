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

<script type="text/javascript">

$(document).ready(function () {
	 
	 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#hidinvdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
   
	 $('#nipurinsertbtn').attr('disabled', true);
});

function funreload(event){
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 /* if(fromdate>todate){
		 $.messager.alert('Message','Not a Valid Period, From Date is Greater than to Date','Warning');
		 return;
	 }
	 else{ */
		 $("#workshopinvoiceDiv").load("workshopInvoiceGrid.jsp?fromdate="+fromdate+'&todate='+todate+'&id=1');
	 /* } */
}

function funnipurins(){
	var invno=$('#hidinvno').val();
	
	var invdate=$('#hidinvdate').val();
	
	var regno=$('#hidregno').val();
	var plate=$('#hidplate').val();
	var make=$('#hidmake').val();
	var desc="WS INV No. - "+invdate+" - Reg No - "+regno+" - Plate - "+plate+" - Fleet - "+make;
	
	var jobcardno=$('#hidjobcardno').val();	
	var totalinv=$('#hidtotalinv').val();
	var refno=$('#hidrefno').val();
	var acno=$('#hidacno').val();
	
	var nipurchasearray=new Array();
	var sparetot=$('#hidsparetot').val();
	var labourtot=$('#hidlabourtot').val();
	var fleetno=$('#hidfleetno').val();
	var acnosp=$('#hidacnosp').val();
	var acnolab=$('#hidacnolab').val();
	var hidinsurcldocno=$('#hidinsurcldocno').val();
	
	var hidinvoicetoacno=$('#hidinvoicetoacno').val();
	/***
	 * 
	 			account
				Top Technology Insurance#19237
				Al buhaira national insurance#19091
	 */

	if(hidinsurcldocno==200 && hidinvoicetoacno==20820){
			
			acno=19237;
			var withoutvat=(parseFloat(totalinv)/105)*100;
			withoutvat=parseFloat(withoutvat).toFixed(window.parent.curdec.value);
			withoutvat=(withoutvat=='NaN'?"0":withoutvat);
			var vatper=5;
			var vatamt=parseFloat(totalinv)-parseFloat(withoutvat);
			nipurchasearray.push(1+"::"+1+"::"+desc+"::"+withoutvat+"::"+withoutvat+"::"+0+"::"+withoutvat+"::"+withoutvat+"::"+
				6+"::"+fleetno+"::"+' '+"::19091::"+vatper+"::"+vatamt+"::"+totalinv+"::0:: ");
		
	}
	else if(hidinsurcldocno==200 && hidinvoicetoacno==20424){
		
		acno=19031;
		var withoutvat=(parseFloat(totalinv)/105)*100;
		withoutvat=parseFloat(withoutvat).toFixed(window.parent.curdec.value);
		withoutvat=(withoutvat=='NaN'?"0":withoutvat);
		var vatper=5;
		var vatamt=parseFloat(totalinv)-parseFloat(withoutvat);
		nipurchasearray.push(1+"::"+1+"::"+desc+"::"+withoutvat+"::"+withoutvat+"::"+0+"::"+withoutvat+"::"+withoutvat+"::"+
			6+"::"+fleetno+"::"+''+"::14799::"+vatper+"::"+vatamt+"::"+totalinv+"::0:: ");
	
	}
	else{
		
			if(sparetot!=0){
				var withoutvat=(parseFloat(sparetot)/105)*100;
				withoutvat=parseFloat(withoutvat).toFixed(window.parent.curdec.value);
				withoutvat=(withoutvat=='NaN'?"0":withoutvat);
				var vatper=5;
				var vatamt=parseFloat(sparetot)-parseFloat(withoutvat);
			nipurchasearray.push(1+"::"+1+"::"+desc+"::"+withoutvat+"::"+withoutvat+"::"+0+"::"+withoutvat+"::"+withoutvat+"::"+
					6+"::"+fleetno+"::"+''+"::"+acnosp+"::"+vatper+"::"+vatamt+"::"+sparetot+"::0");
			
			}
			if(labourtot!=0){
				var withoutvat=(parseFloat(labourtot)/105)*100;
				withoutvat=parseFloat(withoutvat).toFixed(window.parent.curdec.value);
				withoutvat=(withoutvat=='NaN'?"0":withoutvat);
				var vatper=5;
				var vatamt=parseFloat(labourtot)-parseFloat(withoutvat);
			nipurchasearray.push(2+"::"+1+"::"+desc+"::"+withoutvat+"::"+withoutvat+"::"+0+"::"+withoutvat+"::"+withoutvat+"::"+
					6+"::"+fleetno+"::"+''+"::"+acnolab+"::"+vatper+"::"+vatamt+"::"+labourtot+"::0");
			
			}
		}
	funNIPurchaseSave(invno,invdate,desc,acno,refno,totalinv,nipurchasearray);
}

function funNIPurchaseSave(invno,invdate,desc,acno,refno,totalinv,nipurchasearray){
// 	alert(invno+"--"+invdate+"--\n"+desc+"\n--"+acno+"--"+refno+"--"+totalinv);
// 	alert(nipurchasearray);
		var x=new XMLHttpRequest();
	  x.onreadystatechange=function(){
	  if (x.readyState==4 && x.status==200){
	         
	    var items=x.responseText.trim();
 	    
	    if(parseInt(items)>"0")  
	    { 
	    
	    $.messager.alert('Message', '  Order no '+parseInt(items)+' Successfully Created ','info');
	    funreload(event)
	    }
	    else
	    {
	    $.messager.alert('Message', '  Not Created  ','warning');
	    }
	    }
	  }
	  x.open("GET","NIpurchaseCreate.jsp?invno="+invno+"&invdate="+invdate+"&desc="+desc+"&acno="+acno+"&refno="+refno+"&totalinv="+totalinv+"&nipurchasearray="+nipurchasearray,true);    
	  x.send();
	  $('#nipurinsertbtn').attr('disabled', true);
	  $('#workshopInvGrid').jqxGrid('clear');
	  
	}
function funExportBtn(){
		   JSONToCSVCon(invexceldata, 'Workshop Invoice', true);
} 

</script>
</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="20%">
    <fieldset style="background: #ECF8E0;">
    
    <table width="100%" border="0" cellspacing="1" cellpadding="1">
     <jsp:include page="../../heading.jsp"></jsp:include>
      <tr>
        <td width="30%">&nbsp;</td>
        <td width="70%">&nbsp;</td>
      </tr>
      <tr>
        <td align="right"><label class="branch">From Date</label></td>
        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
      </tr>
      <tr>
        <td align="right"><label class="branch">To Date</label></td>
        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" align="center"><input type="Button" name="nipurinsertbtn" id="nipurinsertbtn" class="myButton" value="NI Purchase Create" onclick="funnipurins()"></td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    </fieldset>
    </td>
    <td width="80%">
    	<div id="workshopinvoiceDiv"><jsp:include page="workshopInvoiceGrid.jsp"></jsp:include>
    </td>
  </tr>
</table>
	<input type="hidden" name="hidinvno" id="hidinvno" value='<s:property value="hidinvno"/>' >
	<%-- <input type="false" name="hidinvdate" id="hidinvdate" value='<s:property value="hidinvdate"/>' > --%> 
	<input type="hidden" name="hidjobcardno" id="hidjobcardno" value='<s:property value="hidjobcardno"/>' >
	<input type="hidden" name="hidregno" id="hidregno" value='<s:property value="hidregno"/>' >
	<input type="hidden" name="hidmake" id="hidmake" value='<s:property value="hidmake"/>' >
	<input type="hidden" name="hidtotalinv" id="hidtotalinv" value='<s:property value="hidtotalinv"/>' >
	<input type="hidden" name="hidsparetot" id="hidsparetot" value='<s:property value="hidsparetot"/>' >
	<input type="hidden" name="hidlabourtot" id="hidlabourtot" value='<s:property value="hidlabourtot"/>' >
	<input type="hidden" name="hidrefno" id="hidrefno" value='<s:property value="hidrefno"/>' >
	
	<input type="hidden" name="hidplate" id="hidplate" value='<s:property value="hidplate"/>' >
	<input type="hidden" name="hidfleetno" id="hidfleetno" value='<s:property value="hidfleetno"/>' >
	<input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>' >
	<input type="hidden" name="hidacnosp" id="hidacnosp" value='<s:property value="hidacnosp"/>' >
	<input type="hidden" name="hidacnolab" id="hidacnolab" value='<s:property value="hidacnolab"/>' >
	<input type="hidden" name="hidinsurcldocno" id="hidinsurcldocno" value='<s:property value="hidinsurcldocno"/>' >
	<input type="hidden" name="hidinvoicetoacno" id="hidinvoicetoacno" value='<s:property value="hidinvoicetoacno"/>' >
	
	<div id="hidinvdate" name="hidinvdate" hidden="true" value='<s:property value="hidinvdate"/>'></div> 
</div></div></body>
</html>