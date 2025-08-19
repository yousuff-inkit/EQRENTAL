
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
   <jsp:include page="../../../../includes.jsp"></jsp:include>  
<style media="print">
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 .saliktable{
 border:1px solid;
 border-collapse:collapse;

 }
 
 table:last-of-type {
    page-break-after: auto
}



#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
       
  /* /* tr.saliktable:nth-child(even) {background: #fff } 
tr.saliktable:nth-child(odd) {background: #fdf5e6} */ */
/* #salikdiv{
break-before: always;
}  */
/* div.salikdiv
      {
        page-break-after: always;
        page-break-inside: avoid;
      } */
</style> 
<script type="text/javascript">

function hidedata(){
	
	/* var first=document.getElementById("firstarray").value;
	var header=document.getElementById("txtheader").value;
	header=1;
	if(parseInt(header)==1){
	   $("#headerdiv").prop("hidden", false);
	   $("#withoutHeaderDiv").attr("hidden", true);
	}
	else{
		$("#headerdiv").prop("hidden", true);
		$("#withoutHeaderDiv").attr("hidden", false);
	}
	
	if(parseInt(first)==1){
		   $("#firstdiv").prop("hidden", false);
		}
	else{
		   $("#firstdiv").prop("hidden", true);
		} */
	
	}

</script>
</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCreditDebitVoucherPrint" action="creditDebitVoucherPrint" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<%-- <div id="headerdiv" hidden="false" >
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div> --%>

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Customer Name </td>
    <td colspan="3">: <label id="lblaccountname" name="lblaccountname"><s:property value="lblaccountname"/></label></td>
    <td width="18%" align="left">INV No </td>
    <td width="20%"> : <label id="lbldocumentno" name="lbldocumentno"><s:property value="lbldocumentno"/></label></td>
  </tr>
  <tr>
    <td align="left">Customer Code </td>
    <td width="18%">: <label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Date </td>
    <td>: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td align="left">Address </td>
    <td colspan="3">: <label name="lbladdress1" id="lbladdress1" ><s:property value="lbladdress1"/></label></td>
    <td align="left">RA No </td>
    <td>: <label name="lblrano" id="lblrano" ><s:property value="lblrano"/></label></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td colspan="3">: <label name="lbladdress2" id="lbladdress2" ><s:property value="lbladdress2"/></label></td>
    <td align="left">LPO No</td>
    <td>: <label name="lbllpono" id="lbllpono" ><s:property value="lbllpono"/></label></td>
  </tr>
  <tr>
    <td align="left">TRN</td>
    <td colspan="2">: <label name="lblclienttrn" id="lblclienttrn" ><s:property value="lblclienttrn"/></label></td>
    <td>&nbsp;</td>
    <td align="left">MRA No </td>
    <td>: <label name="lblmranno" id="lblmrano" ><s:property value="lblmrano"/></label></td>
  </tr>
  <tr>
    <td align="left">Mobile </td>
    <td>: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    <td align="left">Type </td>
    <td>: <label name="lblratype" id="lblratype" ><%-- <s:property value="lblratype"/> --%>Driver Agreement</label></td>
  </tr>
  <tr>
    <td align="left"> Phone </td>
    <td>: <label name="lblphone" id="lblphone" ><s:property value="lblphone"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    <td align="left">Contract Start </td>
    <td>: <label id="lblcontractstart" name="lblcontractstart"><s:property value="lblcontractstart"/></label></td>
  </tr>
  <tr>
    <td align="left">Driven </td>
    <td colspan="3">: <label id="lbldriven" name="lbldriven" ><s:property value="lbldriven"/></label></td>
    <td colspan="2">Inv From : <label name="lblinvfrom" id="lblinvfrom" ><s:property value="lblinvfrom"/></label> To :<label name="lblinvto" id="lblinvto" ><s:property value="lblinvto"/></label></td>
    </tr>
	<%-- <tr>
    <td align="left">&nbsp;</td>
    <td colspan="3">&nbsp;</td>
    <td colspan="2">Inv From : <label name="lblinvfromtime" id="lblinvfromtime" ><s:property value="lblinvfromtime"/></label> To :<label name="lblinvtotime" id="lblinvtotime" ><s:property value="lblinvtotime"/></label></td>
    </tr>  --%>
</table>
</fieldset>

<hr>

<table width="100%">
 <tr>
    <td align="left">SI No</td>
    <td align="left">Charge Description</td>
    <td align="right">Amount</td>
    <td align="right">Tax Percent</td>
    <td align="right">Tax Amount</td>
    <td align="right">Total</td>
  </tr>
  <s:set var="temp" value="1"></s:set>
  <s:iterator var="stat1" status="arr" value="%{#request.printingarray}" >
	<s:iterator status="arr" value="#stat1" var="stat">    
		<tr>   
	    	<s:iterator status="arr" value="#stat.split('::')" var="des">
				<s:if test="#arr.index>1">
					<td align="right"><s:property value="#des"/></td>
				</s:if>
				<s:else>
					<td align="left"><s:property value="#des"/></td>
				</s:else>
			</s:iterator>
		</tr>
	</s:iterator>
</s:iterator>

</table>
<hr>
<%-- <table width="100%" border="0">
  <tr>
    <td>Tax Summary</td>
    <td align="right">Amount</td>
    <td align="right">Tax</td>
    <td align="right">Total</td>
  </tr>
  <tr>
    <td>VAT 5%</td>
    <td align="right"><label name="lblwithtaxvalue" id="lblwithtaxvalue" >
        <s:property value="lblwithtaxvalue"/></label></td>
    <td align="right"><label name="lblwithtaxamount" id="lblwithtaxamount" >
        <s:property value="lblwithtaxamount"/></label></td>
    <td align="right"><label name="lblwithtaxtotal" id="lblwithtaxtotal" >
        <s:property value="lblwithtaxtotal"/></label></td>
  </tr>
  <tr>
    <td>VAT 0%</td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        <s:property value="lblwithouttaxtotal"/></label></td>
    <td align="right"><label name="lblwithouttaxamount" id="lblwithouttaxamount" >
        <s:property value="lblwithouttaxamount"/></label></td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        <s:property value="lblwithouttaxtotal"/></label></td>
  </tr>
  <tr>
    <td>VAT Group</td>
    <td align="right"><label name="lbltaxgrouptotal" id="lbltaxgrouptotal" >
        <s:property value="lbltaxgrouptotal"/></label></td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        0.00</label></td>
    <td align="right"><label name="lbltaxgrouptotal" id="lbltaxgrouptotal" >
        <s:property value="lbltaxgrouptotal"/></label></td>
  </tr>
  <tr>
    <td>Total</td>
    <td align="right"><label name="lblnettaxvalue" id="lblnettaxvalue" >
        <s:property value="lblnettaxvalue"/></label></td>
    <td align="right"><label name="lblnettaxamount" id="lblnettaxamount" >
        <s:property value="lblnettaxamount"/></label></td>
    <td align="right"><label name="lblnettaxtotal" id="lblnettaxtotal" >
        <s:property value="lblnettaxtotal"/></label></td>
  </tr>
</table> --%>
<input type="hidden" name="lblsalikcount" id="lblsalikcount" value='<s:property value="lblsalikcount"/>'/>
<input type="hidden" name="lbltrafficcount" id="lbltrafficcount" value='<s:property value="lbltrafficcountdubai"/>'/>
<input type="hidden" name="lbltrafficcountelse" id="lbltrafficcountelse" value='<s:property value="lbltrafficcountelse"/>'/>
<s:set name="saliktemp" value="lblsalikcount" />
<s:set name="trafficdubai" value="lbltrafficcountdubai" />
<s:set name="trafficelse" value="lbltrafficcountelse" />
<input type="hidden" name="lblshowfees" id="lblshowfees" value='<s:property value="lblshowfees"/>'/>
<s:set name="showfees" value="lblshowfees" />
<hr>
<table width="100%" >
  <tr>
    <td width="197" align="left">Total :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></b></td>
    </tr>
</table>
<hr>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Processed By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Received By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
   
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    
    </tr>
</table>
</div>
<br/><br/><br/><br/><br/><br/>
<div class="divFooter">
 
<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>

</div>

</div>


<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>




</div>
 <s:if test="#arr.index!=#request.TRIAL.size-1">
<DIV style="page-break-after:always"></DIV>
</s:if>
</form>

 <s:set name="counter" value="%{#counter+1}" />
</div>
</body>
</html>
