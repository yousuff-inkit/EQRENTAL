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
<%--  <jsp:include page="../../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script> 
<style>
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
   #pageFooter {
    display: table-footer-group;
}
 table:last-of-type {
    page-break-after: auto
	font-size:12px;
}
#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
/*    .divFooter
{
    position:absolute;
    left:0;
    bottom:0;
    width:100%;
} */
/*  .divFooter {

  }
  @media print {
thead { display: table-header-group; }
tfoot { display: table-footer-group; }
}
@media screen {
thead { display: block; }
tfoot { display: block; }
} */
#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
.complogo{
padding-bottom:100px;
}
body{
font-size:12px;
}
</style> 

<script>
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}
$(document).ready(function(){
	
	if(document.getElementById("lblhidheader").value=="1"){
		$(".invheader").hide();
		$(".commonheader").show();
	}
	else{
		$(".invheader").show();
		$(".commonheader").hide();
	}
});
</script>
</head>
<body onload="" style="background-color:white;">
<div id="mainBG" class="homeContent" data-type="background">
<s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>
<s:iterator value='#request.TRIAL' var="#aa" status="arr">
<form id="frmManualInvoicePrint" action="printManualInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<div class="commonheader">
<jsp:include page="../../../common/printProgressHeader.jsp"></jsp:include> <br/> 
</div>
 <div style="background-color:white;">
<%--  <jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include> --%>
<div class="invheader">
<table width="100%" class="normaltable">
  <tr>
  <td align="center" colspan="2" class="complogo"><%-- <img src="<%=contextPath%>/icons/epic.jpg" width="100%" height="91"  alt=""/> --%></td>
  </tr>
  <tr>
  <td align="center" colspan="2"><font size="6"><b><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></b></font></td>
  </tr>
  
  <tr>
  	<td width="5%" align="left">Location </td>
  	<td width="95%" align="left"><label id="lbllocation" name="lbllocation" >: <s:property value="lbllocation"/></label></td>
  </tr>
  
  <tr>
  	<td align="left">Branch </td>
  	<td align="left"><label id="lblbranch" name="lblbranch" >: <s:property value="lblbranch"/></label></td>
  </tr>
  </table>
  </div>
<fieldset>
<table width="100%">
  <tr>
    <td width="8%" align="left">Customer </td>
    <td colspan="3">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="13%" align="left">INV No </td>
    <td width="27%">: <label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label>   <label name="lblinvtype" id="lblinvtype" >(<s:property value="lblinvtype"/>)</label></td>
  </tr>
  <tr>
    <td align="left">Code </td>
    <td width="26%">: <label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="14%"></td>
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
    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="left">Branch</td>
    <td>: <label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
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
    <td align="left">Salesman </td>
    <td colspan="3">: <label id="lblsalesman" name="lblsalesman" ><s:property value="lblsalesman"/></label></td>
    <td><%-- Inv From : <label name="lblinvfromtime" id="lblinvfromtime" ><s:property value="lblinvfromtime"/></label> To :<label name="lblinvtotime" id="lblinvtotime" ><s:property value="lblinvtotime"/></label> --%>
    Currency</td>
    <td> :
      <label name="lblcurrencycode" id="lblcurrencycode">
        <s:property value="lblcurrencycode" />
      </label></td>
    </tr>
     
</table>
</fieldset>
<br>
<fieldset>
  <table width="100%" >
    <tr>
      <td width="15%" align="left">Contract Vehicle  </td>
      <td width="85%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
    </tr>
  <tr>
      <td width="15%" align="left">Current Vehicle  </td>
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
    <!--     <td align="right">Agreed Rate</td>  -->
    <td align="right">Units</td>
<td align="right">Rate</td>
    <td align="right">Total</td>
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
<input type="hidden" name="lblsalikcount" id="lblsalikcount" value='<s:property value="lblsalikcount"/>'/>
<input type="hidden" name="lbltrafficcount" id="lbltrafficcount" value='<s:property value="lbltrafficcountdubai"/>'/>
<input type="hidden" name="lbltrafficcountelse" id="lbltrafficcountelse" value='<s:property value="lbltrafficcountelse"/>'/>
<input type="hidden" name="lblfleetcount" id="lblfleetcount" value='<s:property value="lblfleetcount"/>'/>
<input type="hidden" name="lbldamagecount" id="lbldamagecount" value='<s:property value="lbldamagecount"/>'/>
<input type="hidden" name="lblshowfees" id="lblshowfees" value='<s:property value="lblshowfees"/>'/>
<s:set name="saliktemp" value="lblsalikcount" />
<s:set name="trafficdubai" value="lbltrafficcountdubai" />
<s:set name="trafficelse" value="lbltrafficcountelse" />
<s:set name="fleetcount" value="lblfleetcount" />
<s:set name="damagecount" value="lbldamagecount" />
<s:set name="showfees" value="lblshowfees" />
<hr>

<s:if test="#trafficdubai > 0 || #trafficelse > 0"> 

<div class="trafficdiv" id="trafficdiv">
	<table width="100%">
  			
  			<tr><td colspan="4"><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td colspan="4"><table width="100%" class="saliktable">
  					
  						<tr class="saliktable">
  						<td width="10%" class="saliktable" align="left"><b>Sr No</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Reg No</b></td>
							  <td width="15%" class="saliktable" align="left"><b>Ticket No</b></td>
							  <td width="15%" class="saliktable" align="left"><b>Traffic Date</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Time</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Amount</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Fine Source</b></td>
							  <td width="30%" class="saliktable" align="left"><b>Description</b></td>
  						</tr>
  								
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
  					
  			</table>
  			</td></tr>
			<s:if test="#showfees > 0">
  				<tr><td>
  				<br>
  				**Govt. Knowledge Fees for Dubai Traffic fine AED 20/-</td></tr>
  			</s:if>
</table>
</div>
</s:if>
<s:if test="#damagecount > 0">
	<div class="damagediv">
		<fieldset><legend>Damage Details</legend>
		<table width="100%">
  			
  			<!-- <tr><td colspan="4"><hr noshade size=1 width="100%"></td></tr> --> 
  			<tr><td width="20%">Inspection Doc No :<label name="lblinspno" id="lblinspno"><s:property value="lblinspno"/>
  			</label></td><td width="80%">Vehicle Reg No :<label name="lblinspregno" id="lblinspregno"><s:property value="lblinspregno"/></label></b></td> 
  			<tr>
  				<td colspan="4"><table width="100%" class="saliktable">
  					
  						<tr class="saliktable">
  							  <td width="10%" class="saliktable" align="left"><b>Sr No</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Code</b></td>
							  <td width="30%" class="saliktable" align="left"><b>Name</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Type</b></td>
							  <td width="40%" class="saliktable" align="left"><b>Remarks</b></td>
  						</tr>
  					
  					 					
     					<s:iterator var="statdamage" status="arr" value='#request.DAMAGEPRINT' >
      						<s:if test="#arr.index==#counter">
								<s:iterator status="arr" value="#statdamage" var="statdamage2"> 
									<tr class="saliktable">
 										<s:iterator status="arr" value="#statdamage2.split('::')" var="desdamage"> 
  											<td class="saliktable"><s:property value="#desdamage"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							</s:if>
  						</s:iterator>
  					
  					</tbody>
  			</table>
  			</td></tr>
</table>
		</fieldset>
	</div>
</s:if>
<hr>
<table width="100%" >
  <tr>
    <td width="211" align="left">Total </td>
    <td width="10" align="right">:</td>
    <td width="731">&nbsp;</td>
    <td width="161">&nbsp;</td>
    <td width="147" align="right"><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></td>
  </tr>
  
  <tr>
    <td align="left">Amount In Words  </td>
    <td align="right">:</td>
    <td colspan="3" align="right"><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></td>
    </tr>
</table>
<hr>
<s:if test="#fleetcount > 0">
<table width="100%">

   <s:iterator var="stat2" status="arr" value='#request.FLEETPRINT' >
   <s:if test="#arr.index==#counter">
<tr>
<td align="left">Other Fleets : </td></tr>
 <s:iterator status="arr" value="#stat2" var="des2"> 
<tr>
  <td>    <s:property value="#des2"/> </td>

  </tr>
  </s:iterator>
  </s:if>
  </s:iterator>
  
</table>
</s:if>
<hr>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Checked By</td>
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
  					
  						<tr class="saliktable">
  							<td width="10%" class="saliktable"><b>Sr No</b></td>
							  <td width="10%" class="saliktable"><b>Transaction ID</b></td>
							  <td width="20%" class="saliktable"><b>Trip Date/Time</b></td>
							  <td width="15%" class="saliktable"><b>Transaction Post Date</b></td>
							  <td width="30%" class="saliktable"><b>Plate Info</b></td>
							  <td width="10%" class="saliktable"><b>Toll Gate Location</b></td>
							  <td width="10%" class="saliktable"><b>Toll Gate Direction</b></td>
							  <td width="10%" class="saliktable"><b>Amount<br>(AED)</b></td>
  						</tr>
  					
  					 					
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
  					
  						<tr class="saliktable">
  						<td width="10%" class="saliktable" align="left"><b>Sr No</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Reg No</b></td>
							  <td width="15%" class="saliktable" align="left"><b>Ticket No</b></td>
							  <td width="15%" class="saliktable" align="left"><b>Traffic Date</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Time</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Amount</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Fine Source</b></td>
							  <td width="30%" class="saliktable" align="left"><b>Description</b></td>
  						</tr>
  					
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
			     
			    <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg" width="100%" /></td> 
		    </tr>
  			<tr><td><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td><table width="100%" class="saliktable">
  					
  						<tr class="saliktable">
  						<td width="10%" class="saliktable" align="left"><b>Sr No</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Reg No</b></td>
							  <td width="15%" class="saliktable" align="left"><b>Ticket No</b></td>
							  <td width="15%" class="saliktable" align="left"><b>Traffic Date</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Time</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Amount</b></td>
							  <td width="10%" class="saliktable" align="left"><b>Fine Source</b></td>
							  <td width="30%" class="saliktable" align="left"><b>Description</b></td>
  						</tr>
  					
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
  
  <td width="43%" style="color: #D8D8D8;" align="left">Powered by GATEWAY ERP</td>
  
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
<input type="hidden" name="lblhidheader" id="lblhidheader" value='<s:property value="lblhidheader"/>'/>



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
