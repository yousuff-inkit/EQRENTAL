<%@page pageEncoding="utf-8"%>
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
       

</style> 
<script>
$(document).ready(function () {
	
	
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
<input type="hidden" name="headerchk" id="headerchk" value='<s:property value="headerchk"/>'/>
<s:set name="headerchk" value="headerchk" />
<s:iterator value='#request.TRIAL' var="#aa" status="arr">

<form id="frmManualInvoicePrint" action="printManualInvoice" autocomplete="off" target="_blank">

 <div style="background-color:white;">
 
<s:if test="#headerchk == 0"> 
 <div id="header2" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="6%"><br/><br/><br/><br/><br/><br/></td>
    <td width="22%">&nbsp;</td>
    <td width="11%">&nbsp;</td>
    <td width="28%">&nbsp;</td>
    <td width="7%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
    <td width="16%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="font-size: x-small">&nbsp;Branch
      </td>
    <td><span style="font-size: x-small">:
        <label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></span>
    </td>
    <td><span style="font-size: x-small" dir="RTL">ألفرع:</span></td>
    <td><font size="4" style="font-weight: bold; text-align: center;">Tax Invoice</font></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="font-size: x-small">&nbsp;Location</td>
    <td>:<label id="lbllocation" style="font-size: x-small" name="lbllocation" ><s:property value="lbllocation"/></label></td>
    <td><span style="font-size: x-small" dir="RTL">المنطقة:</span></td>
    <td><span dir="RTL"><font size="4" style="font-weight: bold; text-align: center;">فاتورة الضريبة</font></span></td>
    <td><b style="font-size: x-small">TRN</b></td>
    <td>:<label id="lblcomptrn" name="lblcomptrn" style="font-size: x-small"><s:property value="lblcomptrn"/></label></td>
    <td><strong><span style="font-size: x-small" dir="RTL">رقم تسجيل الضريبة:</span></strong></td>
    
  </tr>
</table>
 </div>
 </s:if>
 <s:else>
 <div id="headerdiv">
 <jsp:include page="../../../common/printHeaderMorningStar.jsp"></jsp:include> 
</div>
</s:else>

<fieldset>
<table width="100%" border="0" cellspacing="1" cellpadding="0" style="font-size: x-small;">
  <tr>
    <td width="13%" style="font-weight: normal">Customer Name</td>
    <td width="38%">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="13%" align="right" style="font-weight: normal; font-style: normal;"><span dir="RTL">أسم المشتري</span></td>
    <td width="3%">&nbsp;</td>
    <td width="9%">INV  No</td>
    <td width="14%">: <label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label></td>
    <td width="10%" align="right"><span dir="RTL"> رقم الفاتورة</span></td>
  </tr>
  <tr>
    <td style="font-weight: normal"><strong style="font-weight: normal">Customer  Code</strong></td>
    <td>: <label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td align="right" style="font-weight: normal"> <span dir="RTL"> رمزالمشتري </span></td>
    <td>&nbsp;</td>
    <td>Date</td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
    <td align="right"><span dir="RTL">التاريخ</span></td>
  </tr>
  <tr>
    <td style="font-weight: normal">TRN</td>
    <td>: <label name="lblclienttrn" id="lblclienttrn" ><s:property value="lblclienttrn"/></label></td>
    <td align="right" style="font-weight: normal"><span dir="RTL"> الضريبة رقم تسجيل</span></td>
    <td>&nbsp;</td>
    <td>RA No</td>
    <td>: <label name="lblrano" id="lblrano" ><s:property value="lblrano"/></label></td>
    <td align="right"><span dir="RTL">رقم أر أيه</span></td>
  </tr>
  <tr>
    <td style="font-weight: normal">Address</td>
    <td>: <label name="lbladdress1" id="lbladdress1" ><s:property value="lbladdress1"/></label></td>
    <td align="right" style="font-weight: normal"><span dir="RTL">العنوان</span></td>
    <td>&nbsp;</td>
    <td>LPO  No</td>
    <td>: <label name="lbllpono" id="lbllpono" ><s:property value="lbllpono"/></label></td>
    <td align="right"><span dir="RTL">رق أل بي أو</span></td>
  </tr>
  <tr>
    <td style="font-weight: normal">Mobile</td>
    <td>: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
    <td align="right" style="font-weight: normal"><span dir="RTL">الهاتف المتحرك</span></td>
    <td>&nbsp;</td>
    <td>MRA  No</td>
    <td>: <label name="lblmranno" id="lblmrano" ><s:property value="lblmrano"/></label></td>
    <td align="right"><span dir="RTL">رق أم أر أيه</span></td>
  </tr>
  <tr>
    <td style="font-weight: normal">Driven</td>
    <td>: <label id="lbldriven" name="lbldriven" ><s:property value="lbldriven"/></label></td>
    <td align="right" style="font-weight: normal"><span dir="RTL">مقود</span></td>
    <td>&nbsp;</td>
    <td>Type</td>
    <td>: <label name="lblratype" id="lblratype" ><s:property value="lblratype"/></label></td>
    <td align="right"><span dir="RTL">ألنوع</span></td>
  </tr>
  <tr>
    <td style="font-weight: normal">&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right" style="font-weight: normal">&nbsp;</td>
    <td>&nbsp;</td>
    <td>Contract  Start</td>
    <td>: <label id="lblcontractstart" name="lblcontractstart"><s:property value="lblcontractstart"/></label></td>
    <td align="right"><span dir="RTL">ابتداء العقد</span></td>
  </tr>
  <tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td colspan="3">Inv From &emsp;&emsp;&ensp;: <label name="lblinvfrom" id="lblinvfrom" ><s:property value="lblinvfrom"/></label> 
  &emsp;&emsp;&emsp;To&emsp;:<label name="lblinvto" id="lblinvto" ><s:property value="lblinvto"/></label></td>
  </tr>

</table>
</fieldset>


<br>
<fieldset>
  <table width="100%" >
    <tr>
      <td width="15%" align="right"> Contract Vehicle  </td>
      <td width="68%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
      <td width="17%" align="right" style="text-align: right">:  سيارة&nbsp;العقد &emsp;</td>
    </tr>
  </table>
</fieldset>
<hr>

<table width="100%">
 <tr>
    <td align="left">SI No&nbsp;&nbsp;الرقم</td>
    <td align="left">Charge Description&nbsp;&nbsp;التفاصيل</td>
    <td align="right">Amount&nbsp;&nbsp;المبلغ</td>
    <td align="right">Tax Percent&nbsp;&nbsp;الضريبة&nbsp;نسبة</td>
    <td align="right">Tax Amount&nbsp;&nbsp;الضريبة&nbsp;مبلغ</td>
    <td align="right">Total   الاجمالي</td>
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
    <td><b>Tax Summary&nbsp;موجز&nbsp;الضريبة</b></td>
    <td>&nbsp;</td>
    <td align="right"><b>Amount&nbsp;االمبلغ</b></td>
    <td align="right"><b>Tax&nbsp;ضريب</b>ة</td>
    <td align="right"><b>Total&nbsp;الاجمالي</b></td>
  </tr>
  <tr>
    <td>VAT 5%<br/>ضريبة قيمة المضافة %5</td>
    <td>:</td>
    <td align="right"><label name="lblwithtaxvalue" id="lblwithtaxvalue" >
        <s:property value="lblwithtaxvalue"/></label></td>
    <td align="right"><label name="lblwithtaxamount" id="lblwithtaxamount" >
        <s:property value="lblwithtaxamount"/></label></td>
    <td align="right"><label name="lblwithtaxtotal" id="lblwithtaxtotal" >
        <s:property value="lblwithtaxtotal"/></label></td>
  </tr>
  <tr>
    <td>VAT 0%<br/>ضريبة قيمة المضافة %0</td>
    <td>:</td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        <s:property value="lblwithouttaxtotal"/></label></td>
    <td align="right"><label name="lblwithouttaxamount" id="lblwithouttaxamount" >
        <s:property value="lblwithouttaxamount"/></label></td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        <s:property value="lblwithouttaxtotal"/></label></td>
  </tr>
  <tr>
    <td>VAT Group<br/>مجموعة ضريبة قيمة المضافة</td>
    <td>:</td>
    <td align="right"><label name="lbltaxgrouptotal" id="lbltaxgrouptotal" >
        <s:property value="lbltaxgrouptotal"/></label></td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        0.00</label></td>
    <td align="right"><label name="lbltaxgrouptotal" id="lbltaxgrouptotal" >
        <s:property value="lbltaxgrouptotal"/></label></td>
  </tr>
  <tr>
    <td>Total<br/>ألاجمالي</td>
    <td>:</td>
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
    <td width="169" align="left"><b>Total<br>ألاجمالي</b></td>
    <td colspan="2">:</td>
    <td width="131">&nbsp;</td>
    <td width="122" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount<br/>ألمبلغ الصافي </b></td>
    <td colspan="2">:</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words<br/>المبلغ في الكلمات</b>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&nbsp;&nbsp;</td>
    <td width="14" align="left">:</td>
    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/>
      </label></b></td>
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

<hr>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="10%" style="font-size: x-small">Processed By:</td>
    <td width="14%" style="font-size: x-small"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="11%" align="right" style="font-size: x-small; text-align: right; font-weight: normal;"><span dir="RTL"> معالجة بواسطة : </span></td>
    <td width="9%" style="font-size: x-small">Received By:</td>
    <td width="19%" style="font-size: x-small"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="14%" style="font-size: x-small; text-align: right;"><span dir="RTL">تم الاستلام من قبل :</span></td>
    <td width="4%" style="font-size: x-small">Date</td>
    <td width="14%" style="font-size: x-small"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
    <td width="5%" style="font-size: x-small"><span dir="RTL">ألتاريخ :</span></td>
   
  </tr>
  <tr>
    <td colspan="9">&nbsp;</td>
    
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
</div>


<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>




</div>
 <s:if test="#arr.index!=#request.TRIAL.size-1">
<DIV style="page-break-after:always"></DIV>
</s:if>
</form>

 <s:set name="counter" value="%{#counter+1}" />
</s:iterator>

<input type="hidden" name="headerchk" id="headerchk" value='<s:property value="headerchk"/>'/>
</div>
</body>
</html>
