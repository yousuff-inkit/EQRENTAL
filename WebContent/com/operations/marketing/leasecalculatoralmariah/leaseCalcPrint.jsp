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
       table td{
      	cellspacing:0;
      	cellpadding:0;
      	border-collapse:collapse;
      	padding:0;
      }
      
</style> 
<style media="all">
      table{
   /*    	cellpadding:0; */
      	cellspacing:0;
      	border-collapse:collapse;
      	border-spacing:0px;
      }
/*       table td{
      	cellspacing:0;
      	cellpadding:0;
      	border-collapse:collapse;
      	padding:0;
      }
 */
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }

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
	document.getElementById("frmLeaseCalcPrintNormal").submit(); 
}
</script>
</head>
<body onload="" bgcolor="white"  style="font-size:10px;background-color:#fff;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLeaseCalcPrintNormal" action="printLeaseCalculatorNormal" autocomplete="off" target="_blank">

 <div style="background-color:white;">
 <jsp:include page="../../../common/printHeader.jsp"></jsp:include> 
 	<s:set name="reqcounter" value="1" />
  	<s:set name="reqsrno" value="0" />
  	<s:set name="srno" value="0" />
  	<s:set name="rdocno" value="0" />
  	<s:set name="savestatus" value="0" />
<table style="width:100%;">
  <tr>
    <td width="11%" align="right">Customer Name:</td>
    <td width="13%" align="left"><label id="lblclient"><s:property value="Lblclient"/></label></td>
    <td width="12%" align="right">Customer Address:</td>
    <td width="21%" align="left"><label id="lblclientaddress"><s:property value="lblclientaddress"/></label></td>
    <td width="5%" align="right">Date:</td>
    <td width="10%" align="left"><label id="lbldate"><s:property value="lbldate"/></label></td>
    <td width="12%" align="right">Lease Req Doc No:</td>
    <td width="6%" align="left"><label id="lblleasereqdocno"><s:property value="lblleasereqdocno"/></label></td>
    <td width="5%" align="right">Doc No:</td>
    <td width="6%" align="left"><label id="lbldocno"><s:property value="lbldocno"/></label></td>
  </tr>
  </table>
  <br>
  		<fieldset>
		  <table style="width:100%;">
  			<tr>
		  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Sr No</td>
			  	<!-- <td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Lease From</td> -->
			  	<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Brand</td>
			  	<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Model</td>
			  	<!-- <td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Specification</td>
			  	<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Color</td> -->
			  	<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Lease in months</td>
			  	<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Km use per month</td>
			  	<!-- <td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Cost Group</td> -->
			  	<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-right:1px solid black;border-bottom:1px solid black;" align="right">Total</td>
  			</tr>
			<s:iterator var="stat1" status="arr" value="%{#request.REQPRINT}" >
  				<s:iterator status="arr" value="#stat1" var="stat">
  					<tr>
     					<s:iterator status="arr" value="#stat.split('::')" var="des">
     					<s:if test="#arr.index==5">
     						<td align="right">
     					</s:if>
     					<s:else>
     						<td>
     					</s:else>
     						<s:property value="#des"/></td>
  						</s:iterator>
  					</tr>
  				</s:iterator>
  			</s:iterator>
  			<table width="100%">
  				<tr><td colspan="3"><hr></tr>
  			</table>
  			<table width="50%">
  				
  				<tr><td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Sr No</td>
			  	<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Details</td>
			  	<td align="right" style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;border-right:1px solid black;">Amount</td></tr>
  				<s:iterator var="stat3" status="arr" value="%{#request.REQDETAILPRINT}" >
  					<s:iterator status="arr" value="#stat3" var="stat4">
  						<tr>
  							<s:iterator status="arr" value="#stat4.split('::')" var="des1">
  								<s:if test="#arr.index==2">
  									<td align="right">
  								</s:if>
  								<s:else><td></s:else>
  								<s:property value="#des1"/></td>
  							</s:iterator>
  						</tr>
  					</s:iterator>
  				</s:iterator>
  			</table>
  			<%-- 
			<s:iterator var="stat3" status="arr" value="%{#request.REQDETAILPRINT}" >
  				<s:iterator status="arr" value="#stat3" var="stat4">
  					<s:if test="#stat4.split('::')[0]==#reqsrno">
  						<tr>
  						<s:set name="colorcounter" value="%{#colorcounter+1}" />
  							<s:if test="#colorcounter==20">
  								<td colspan="10"><hr style="width:100%;height:1px;background-color:grey;"></td>
  								</tr>
  								<tr>
  								<s:set name="colorcounter" value="%{#colorcounter+1}" />
  							</s:if>
  							<s:iterator status="arr" value="#stat4.split('::')" var="des1">
  								<s:if test="#arr.index==0">
  									<s:set name="srno" value="%{#des1}"></s:set>
  								</s:if>
  								<s:if test="#srno==#reqsrno">
	  								<s:if test="#arr.index>0">
	  									<s:if test="#arr.index==1">
	  										<s:if test="#colorcounter==19 || #colorcounter==28">
	  											<td colspan="4" style="background-color:#F6CECE;"><s:property value="#des1"/></td>
	  										</s:if>
	  										<s:else>
	  											<td colspan="4"><s:property value="#des1"/></td>
	  										</s:else>
	  										
	  									</s:if>
	  									<s:elseif test="#arr.index==1">
	  										<td ><s:property value="#des1"/></td>
	  									</s:elseif>
	  									<s:else>
	  									<s:if test="#colorcounter==19 || #colorcounter==28">
	  											<td align="right" style="background-color:#F6CECE;"><s:property value="#des1"/></td>
	  										</s:if>
	  										<s:else>
	  											<td align="right"><s:property value="#des1"/></td>
	  										</s:else>
	  										
	  									</s:else>
	  								</s:if>
  								</s:if>
  							</s:iterator>
  						</tr>
  					</s:if>
  				</s:iterator>
  			</s:iterator>
		</s:iterator>
  </table>
  </fieldset>
    <s:if test="#arr.index!=#request.REQPRINT.size-1">
		<DIV style="page-break-after:always"></DIV>
	</s:if>
  	</s:iterator> --%>
</div>
</form>
</div>
</body>
</html>