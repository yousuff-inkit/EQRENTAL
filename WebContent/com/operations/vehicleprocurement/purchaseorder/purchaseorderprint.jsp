<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
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
 .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
 
 hr { 
   border-top: 1px solid #e1e2df  ;
    
    }

</style> 
  <%-- <style type="text/css">
    @media screen {
        div.divFooter {
            display: none;
        }
    }
    @media print {
        div.divFooter {
            position: fixed;
            bottom: 0;
        }
    }
 </style>  --%>
 
 
 
 
<script type="text/javascript">
		$(document).ready(function() {
			var term=$("#lblterms").text().trim();
			//alert(term)
			  if (!term) {
				 $("#termfield").hide();
			}else{
				 $("#termfield").show();
			}
});

</script>
</head>
<body style="font-size:10px;"  bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>
<!-- <table width="100%">
<tr>
<td width="60%">


 -->
  
<table width="100%"> 
  <tr>
    <td width="7%" align="left">Date </td>
    <td width="8%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
     <td width="6%" align="right">Type </td>
    <td width="11%" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td> 
     <td width="8%" align="right">Vendor</td>
    <td width="32%" align="left">: <label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> 
    &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>
    </td> 
    <td width="7%" align="right">Vendor TRN</td>
    <td width="12%" align="left">: <label name="lblventrnno" id="lblventrnno" ><s:property value="lblventrnno"/></label></td>
    <td width="6%" align="right">Doc No</td>
    <td width="10%" align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr>
    <tr>
        <td width="7%"align="left">Exp.Delivery</td>
    <td width="8%">: <label name="expdeldate" id="expdeldate" ><s:property value="expdeldate"/></label></td>
    <td align="right">Description</td>
    <td width="10%" colspan="5" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
    
  </tr>

 
   </table>

</fieldset>
<br>  


 <fieldset>  
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Brand</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Model</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Specification</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Color</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Qty</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Price</b></td>
     <td align="left" style="border-collapse: collapse;"><b>Total</b></td>

 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
 <tr >
    <td >&nbsp;</td>
    <td>&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td  >&nbsp;</td>
     <td  >&nbsp;</td>

 
  </tr>
  <tr><td colspan="8"><hr></td></tr>
 <tr >
    <td ><b></b></td>
    <td><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td align="left" ><b>Total</b></td>
     <td align="right" ><label id="lbltotal"><s:property value="lbltotal"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
   <tr >
    <td ><b></b></td>
    <td><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td align="left" ><b>Tax Amount</b></td>
     <td align="right" ><label id="lbltaxamount"><s:property value="lbltaxamount"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  
     <tr >
    <td ><b></b></td>
    <td><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td align="left" ><b>Net Total</b></td>
     <td align="right" ><label id="lblnettotal"><s:property value="lblnettotal"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  
</table>
 </fieldset> 
 <fieldset id="termfield"><legend><b>Terms & Conditions</b></legend> 
 
 <table width="100%" > 
  <tr>
    <td>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <label id="lblterms"><s:property value="lblterms"/></label>
  </td>
  </tr>
  </table>
   </fieldset> 
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>


</div>
</form>
</div>
</body>
</html>
