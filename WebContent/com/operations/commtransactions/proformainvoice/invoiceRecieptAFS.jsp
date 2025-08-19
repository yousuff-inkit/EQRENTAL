
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
<script>
$(document).ready(function () {
	//document.getElementById("salikdiv").style.display="none";
	//alert(document.getElementById("lblsalikcount").value);
	/* if(document.getElementById("lblsalikcount").value=="0"){
		document.getElementById("salikdiv").style.display="none";
	}
	else{
		document.getElementById("salikdiv").style.display="block";
	} */
});
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}
</script>
</head>
<body onload="" bgcolor="white"  style="font-size:12px">
<div id="mainBG" class="homeContent" data-type="background">
<s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>
<s:iterator value='#request.TRIAL' var="#aa" status="arr">

<form id="frmManualInvoicePrint" action="printManualInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
 <jsp:include page="../../../common/printHeader.jsp"></jsp:include> 
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Customer Name </td>
    <td colspan="3">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="18%" align="left">INV No </td>
    <td width="20%"> : <label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label></td>
  </tr>
  <tr>
    <td align="left">Customer Code </td>
    <td width="18%">: <label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Date </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
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
    <td>: <label name="lblratype" id="lblratype" ><s:property value="lblratype"/></label></td>
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
	<tr>
    <td align="left">&nbsp;</td>
    <td colspan="3">&nbsp;</td>
    <td colspan="2">Inv From : <label name="lblinvfromtime" id="lblinvfromtime" ><s:property value="lblinvfromtime"/></label> To :<label name="lblinvtotime" id="lblinvtotime" ><s:property value="lblinvtotime"/></label></td>
    </tr> 
</table>
</fieldset>
<br>
<fieldset>
  <table width="100%" >
    <tr>
      <td width="15%" align="right"> Contract Vehicle  </td>
      <td width="85%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
    </tr>
	<tr>
      <td width="15%" align="right"> Current Vehicle  </td>
      <td width="85%">: <label name="lblcurrentvehicle" id="lblcurrentvehicle" >
        <s:property value="lblcurrentvehicle"/>
      </label></td>
    </tr>
  
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
  
  </tr>
  

 
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}" >
		 <s:if test="#arr.index==#counter">
		
		    <s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr>   
<%int i=0; %>
 
     <s:iterator status="arr" value="#stat.split('::')" var="des">
    <%
    if(i>1){%>
    
  <td  align="right">
  
  <s:property value="#des"/>

  </td>
   <%} else{ %>
    
  <td  align="left">
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
</s:if>
</s:iterator>

</table>
<hr>
<table width="100%" border="0">
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
</table>
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
    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
    </tr>
</table>
<hr>
<table width="100%">

   <s:iterator var="stat2" status="arr" value='#request.FLEETPRINT' >
   <s:if test="#arr.index==#counter">
<tr>
 <s:iterator status="arr" value="#stat2" var="des2"> 
<td  align="left"><b>Other Fleets</b></td>
  <td><s:property value="#des2"/> </td>

  </tr>
  </s:iterator>
  </s:if>
  </s:iterator>
  
</table>
<s:if test="#showfees > 0">
<table>
  				<tr><td>
  				<br>
  				**Govt. Knowledge Fees for Dubai Traffic fine AED 20/-</td></tr>
</table>  			</s:if>

<table width="100%" border="0">
	<tr><td>Please prepare Cheque/Transfer as per:</td></tr>
  <tr>
    <td align="center"><table width="80%" border="0">
  <tr>
    <td width="34%">ACCOUNT NAME &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
    <td width="66%">ARABIAN FLEET SERVICE RENT A CAR</td>
  </tr>
  <tr>
    <td>BANK | ADDRESS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
    <td>EMIRATES ISLAMIC BANK | ABU DHABI | UAE</td>
  </tr>
  <tr>
    <td>ACCOUNT NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
    <td>3707457645301</td>
  </tr>
  <tr>
    <td>CIF NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
    <td>74576453</td>
  </tr>
  <tr>
    <td>IBAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
    <td>AE69 0340 0037 0745 7645 301</td>
  </tr>
  <tr>
    <td>SWIFTCODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
    <td>MEBLAEADXXX</td>
  </tr>
  <tr>
    <td>CURRENCY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
    <td>AED</td>
  </tr>
</table>
</td>
  </tr>
  <tr><td>Note: Please send transfer document with invoice details to <i><span style="color:#000;">accounts@arabianfleetservices.com</span></i> and secure official reciept for the same.</td></tr>
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
<s:if test="#saliktemp > 0">

<!-- <DIV style="page-break-after:auto"></DIV> -->
	<div class="salikdiv" id="salikdiv">
	<DIV style="page-break-after:always"></DIV>
		<table width="100%">
  			<tr>
			    <td width="18%"><img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg"/></td>
			    <td width="25%">&nbsp;</td>
			    <td width="34%">&nbsp;</td>
			    <td width="23%"><img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg"/></td>
  			</tr>
  			<tr><td colspan="4"><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td colspan="4"><table width="100%" class="saliktable">
  					<thead>
  						<tr class="saliktable">
  							<th width="10%" class="saliktable"><b>Sr No</b></th>
							  <th width="10%" class="saliktable"><b>Transaction ID</b></th>
							  <th width="20%" class="saliktable"><b>Trip Date/Time</b></th>
							  <th width="15%" class="saliktable"><b>Transaction Post Date</b></th>
							  <th width="30%" class="saliktable"><b>Plate Info</b></th>
							  <th width="10%" class="saliktable"><b>Toll Gate Location</b></th>
							  <th width="10%" class="saliktable"><b>Toll Gate Direction</b></th>
							  <th width="10%" class="saliktable"><b>Amount<br>(AED)</b></th>
  						</tr>
  					</thead>
  					<tbody>
  					 					
     					<s:iterator var="statsalik" status="arr" value='#request.SALIKPRINT' >
      						<s:if test="#arr.index==#counter">
								<s:iterator status="arr" value="#statsalik" var="statsalik2"> 
									<tr class="saliktable">
									
 										<s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
											
  											<td class="saliktable"><s:property value="#dessalik"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							</s:if>
  						</s:iterator>
  					</tbody>
  			</table>
  			</td></tr>
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
</s:if>


<s:if test="#trafficdubai > 0"> 

<div class="trafficdiv" id="trafficdiv">
<DIV style="page-break-after:always"></DIV>
	<table width="100%">
  			<tr>
  			 	
  				<td width="18%"><img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg"/></td>
			    <td width="25%">&nbsp;</td>
			    <td width="34%">&nbsp;</td>
			    <td width="23%"><img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg"/></td>
  				
			    <%-- <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg"/></td> --%>
			     
			    <%-- <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg"/></td> --%>
		    </tr>
  			<tr><td colspan="4"><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td colspan="4"><table width="100%" class="saliktable">
  					<thead>
  						<tr class="saliktable">
  						<th width="10%" class="saliktable"><b>Sr No</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Reg No</b></th>
							  <th width="15%" class="saliktable" align="left"><b>Ticket No</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Traffic Date</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Time</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Amount</b></th>
							  <th width="30%" class="saliktable" align="left"><b>Fine Source</b></th>
							  <th width="20%" class="saliktable" align="left"><b>Description</b></th>
  						</tr>
  					</thead>
  					<tbody>
  					 					
     					<s:iterator var="stattraffic" status="arr" value='#request.TRAFFICPRINTDUBAI' >
      						<s:if test="#arr.index==#counter">
								<s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
									<tr class="saliktable">
									
 										<s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
											
  											<td class="saliktable"><s:property value="#destraffic"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							</s:if>
  						</s:iterator>
  					</tbody>
  			</table>
  			</td></tr>
			<s:if test="#showfees > 0">
  				<tr><td>
  				<br>
  				**Govt. Knowledge Fees for Dubai Traffic fine AED 20/-</td></tr>
  			</s:if>
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
</s:if>


<s:if test="#trafficelse > 0"> 

<div class="trafficdiv" id="trafficdiv">
<DIV style="page-break-after:always"></DIV>
	<table width="100%">
  			<tr>
  			 	
  			<%-- 	<td width="18%"><img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg"/></td>
			    <td width="25%">&nbsp;</td>
			    <td width="34%">&nbsp;</td>
			    <td width="23%"><img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg"/></td>
  				
			    <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg"/></td> --%>
			     
			    <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg"/></td> 
		    </tr>
  			<tr><td><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td><table width="100%" class="saliktable">
  					<thead>
  						<tr class="saliktable">
  						<th width="10%" class="saliktable"><b>Sr No</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Reg No</b></th>
							  <th width="15%" class="saliktable" align="left"><b>Ticket No</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Traffic Date</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Time</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Amount</b></th>
							  <th width="30%" class="saliktable" align="left"><b>Fine Source</b></th>
							  <th width="20%" class="saliktable" align="left"><b>Description</b></th>
  						</tr>
  					</thead>
  					<tbody>
  					 					
     					<s:iterator var="stattraffic" status="arr" value='#request.TRAFFICPRINTELSE' >
      						<s:if test="#arr.index==#counter">
								<s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
									<tr class="saliktable">
									
 										<s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
											
  											<td class="saliktable"><s:property value="#destraffic"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							</s:if>
  						</s:iterator>
  					</tbody>
  			</table>
  			</td></tr>
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
</s:if>
<%-- <br/><br/><br/><br/><br/><br/>
 <div class="divFooter">
 
<table width="100%">
<tr>
    <td colspan="3" align="left" style="color: #D8D8D8;">System Generated Document Signataure Not Required.</td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #D8D8D8;" align="left"><b>Powered by GATEWAY ERP</b></td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>

</div>  --%>

 <%-- <jsp:include page="../../../common/printFooter.jsp"></jsp:include>  --%>

<%-- </s:if> --%>
</div>


<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>




</div>
 <s:if test="#arr.index!=#request.TRIAL.size-1">
<DIV style="page-break-after:always"></DIV>
</s:if>
</form>

 <s:set name="counter" value="%{#counter+1}" />
</s:iterator>
</div>
</body>
</html>
