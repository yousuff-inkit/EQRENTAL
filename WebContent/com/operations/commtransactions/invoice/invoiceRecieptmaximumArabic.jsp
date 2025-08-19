<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page pageEncoding="utf-8"%>
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
 
<!--  <header> 
    <img src="E:/workspace/WORKSHOP/WebContent/workshopapp/images/icons/maximumheader.jpg" style="position:relative; left:80px;" height=35% width=80%> 
 </header>
 <footer>
    <img src="E:/workspace/WORKSHOP/WebContent/workshopapp/images/icons/maximumfooter.jpg" style="position:relative; left:80px; top:700px" height=30% width=80% alt="text"/>     
 </footer> -->


<div id="mainBG" class="homeContent" data-type="background">
<s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>
<s:iterator value='#request.TRIAL' var="#aa" status="arr">
<form id="frmManualInvoicePrint" action="printManualInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<div class="commonheader"> <br/><br/> 
<jsp:include page="../../../common/printHeadermaximuminv.jsp"></jsp:include> <br/> 
</div>
 <div style="background-color:white;">
<%--  <jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include> --%>
<div class="invheader">
<br/><br/>
<table width="100%" class="normaltable">
  <tr>
  <td align="center" colspan="2" class="complogo"><%-- <img src="<%=contextPath%>/icons/epic.jpg" width="100%" height="50%"  alt=""/> --%></td>
  </tr>
  <tr>
  <td align="center" colspan="2"><font size="4"><b><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></b></font></td>
  </tr>
  
  <tr>
  
  	<td width="85%" align="right"> <label id="lbllocation" name="lbllocation" > <s:property value="lbllocation"/> :</label></td>
    <td width="20%" align="right"> الموقع </td>
  </tr>
  
  <tr>
       <td align="right"><label id="lblbranch" name="lblbranch" > <s:property value="lblbranch"/> :</label></td>
  	   <td align="right"> الفرع </td>
  </tr>
  <tr>
  	<td align="right"><label id="lblcomptrn" name="lblcomptrn" > <s:property value="lblcomptrn"/> :</label></td>
  	<td align="right"> رقم السجل الضريبي </td>
  </tr>
  </table>
  </div>
<fieldset>
<table width="100%" dir="rtl">
<tr>
    <td width="12%" align="right">العميل </td>
    <td colspan="3">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="30%" align="right">رقم الفاتورة </td>
    <td width="27%">: <label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label>   <label name="lblinvtype" id="lblinvtype" >(<s:property value="lblinvtype"/>)</label></td>
  </tr>
   <tr>
    <td align="right">الكود </td>
    <td width="12%">: <label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td width="10%" align="left">&nbsp;</td>
    <td width="10%"></td>
    <td align="right">التاريخ </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td align="right">العنوان </td>
    <td colspan="3">: <label name="lbladdress1" id="lbladdress1" ><s:property value="lbladdress1"/></label></td>
    <td align="right">رقم آر أيه </td>
    <td>: <label name="lblrano" id="lblrano" ><s:property value="lblrano"/></label>&nbsp;(<label name="lblmrano" id="lblmrano" ><s:property value="lblmrano"/></label>)</td>
  </tr>
 <tr>
    <td align="left">&nbsp;</td>
    <td colspan="3">: <label name="lbladdress2" id="lbladdress2" ><s:property value="lbladdress2"/></label></td>
    <td align="right">رقم طلب الشراء المحلي</td>
    <td>: <label name="lbllpono" id="lbllpono" ><s:property value="lbllpono"/></label></td>
  </tr>
   <tr>
    <td align="right">السجل الضريبي</td>
    <td><label id="lblclienttrn" name="lblclienttrn" >: <s:property value="lblclienttrn"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right">الفرع</td>
    <td>: <label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="right">الموبايل </td>
    <td>: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    <td align="right">النوع </td>
    <td>: <label name="lblratype" id="lblratype" ><s:property value="lblratype"/></label></td>
  </tr>
  <tr>
    <td align="right"> الهاتف </td>
    <td>: <label name="lblphone" id="lblphone" ><s:property value="lblphone"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    <td align="right">بداية العقد </td>
    <td>: <label id="lblcontractstart" name="lblcontractstart"><s:property value="lblcontractstart"/></label></td>
  </tr>
  <tr>
    <td align="right">السائق </td>
    <td colspan="3">: <label id="lbldriven" name="lbldriven" ><s:property value="lbldriven"/></label></td>
    <td>الفاتورة من </td>
    <td> : <label name="lblinvfrom" id="lblinvfrom" ><s:property value="lblinvfrom"/></label> إلى:<label name="lblinvto" id="lblinvto" ><s:property value="lblinvto"/></label></td>
    </tr>
    <tr>
    <td align="right">مسئول المبيعات </td>
    <td colspan="3">: <label id="lblsalesman" name="lblsalesman" ><s:property value="lblsalesman"/></label></td>
    <td><%-- Inv From : <label name="lblinvfromtime" id="lblinvfromtime" ><s:property value="lblinvfromtime"/></label> To <label name="lblinvtotime" id="lblinvtotime" ><s:property value="lblinvtotime"/></label> --%>
    العملة</td>
    <td>:
      <label name="lblcurrencycode" id="lblcurrencycode">
        <s:property value="lblcurrencycode" />
      </label></td>
    </tr>
     
</table>
</fieldset>
<br>
<fieldset>
 <table width="100%" dir="rtl">
    <tr>
      <td width="12%" align="right">مركبة العقد   </td>
      <td width="96%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
    </tr>
  <tr>
      <td width="12%" align="right">المركبة الحالية  </td>
      <td width="96%">: <label name="lblcurrentvehicle" id="lblcurrentvehicle" >
        <s:property value="lblcurrentvehicle"/>
      </label></td>
    </tr>
  </table>
</fieldset>

<hr>

<table width="100%" dir="rtl">
 <tr>
    <!-- <td align="right">SI No</td>
    <td align="left">Charge Description</td>

    <td align="right">Agreed Rate</td>
    <td align="right">Units</td>
    <td align="right">Rate</td>
    <td align="right">Total</td> -->
    <td align="right">الرقم المتسلسل</td>
    <td align="right">تفاصيل الرسوم</td>
    <td align="right">المبلغ</td>
    <td align="right">نسبة الضريبة </td>
    <td align="right">مبلغ الضريبة</td>
    <td align="right">المبلغ الإجمالي</td>
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
<table width="100%" border="0" dir="rtl">
  <tr>
    <td>ملخص الضريبة</td>
    <td align="right">المبلغ</td>
    <td align="right">الضريبة</td>
    <td align="right">الإجمالي </td>
  </tr>
  <tr>
    <td>ضريبة القيمة المضافة 5%</td>
    <td align="right"><label name="lblwithtaxvalue" id="lblwithtaxvalue" >
        <s:property value="lblwithtaxvalue"/></label></td>
    <td align="right"><label name="lblwithtaxamount" id="lblwithtaxamount" >
        <s:property value="lblwithtaxamount"/></label></td>
    <td align="right"><label name="lblwithtaxtotal" id="lblwithtaxtotal" >
        <s:property value="lblwithtaxtotal"/></label></td>
  </tr>
  <tr>
    <td>ضريبة القيمة المضافة 0%</td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        <s:property value="lblwithouttaxtotal"/></label></td>
    <td align="right"><label name="lblwithouttaxamount" id="lblwithouttaxamount" >
        <s:property value="lblwithouttaxamount"/></label></td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        <s:property value="lblwithouttaxtotal"/></label></td>
  </tr>
  <tr>
    <td>مجموعة ضريبة القيمة المضافة  </td>
    <td align="right"><label name="lbltaxgrouptotal" id="lbltaxgrouptotal" >
        <s:property value="lbltaxgrouptotal"/></label></td>
    <td align="right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal" >
        0.00</label></td>
    <td align="right"><label name="lbltaxgrouptotal" id="lbltaxgrouptotal" >
        <s:property value="lbltaxgrouptotal"/></label></td>
  </tr>
  <tr>
    <td>الإجمالي</td>
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
  					<thead>
  						<tr class="saliktable">
  						<tD width="10%" class="saliktable" align="left">Sr No</tD>
							  <tD width="10%" class="saliktable" align="left">Reg No</tD>
							  <tD width="15%" class="saliktable" align="left">Ticket No</tD>
							  <tD width="15%" class="saliktable" align="left">Traffic Date</tD>
							  <tD width="10%" class="saliktable" align="left">Time</tD>
							  <tD width="10%" class="saliktable" align="left">Amount</tD>
							  <tD width="10%" class="saliktable" align="left">Fine Source</tD>
							  <tD width="30%" class="saliktable" align="left">Description</tD>
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
			<s:if test="#showfees > 0">
  				<!-- <tr><td>
  				<br>
  				**Govt. Knowledge Fees for Dubai Traffic fine AED 20/-</td></tr> -->
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
  					<thead>
  						<tr class="saliktable">
  							  <td width="10%" class="saliktable" align="left">Sr No</td>
							  <td width="10%" class="saliktable" align="left">Code</td>
							  <td width="30%" class="saliktable" align="left">Name</td>
							  <td width="10%" class="saliktable" align="left">Type</td>
							  <td width="40%" class="saliktable" align="left">Remarks</td>
  						</tr>
  					</thead>
  					<tbody>
  					 					
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
<table width="100%" dir="rtl">
  <tr>
    <td width="8%" align="right">الإجمالي  </td>
    <td width="3%" align="right"></td>
    <td width="731">&nbsp;</td>
    <td width="161">&nbsp;</td>
    <td width="95%" align="right">: <label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></td>
  </tr>
  
  <tr>
    <td align="right">المبلغ بالحروف    </td>
    <td align="right"></td>
    <td colspan="3" align="right">&nbsp;&nbsp;&nbsp;&nbsp;:<label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></td>
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
<!--<h3>BANK ACCOUNT DETAILS</h3>
<table width="100%">
	<tr>
		<td width="50%" style="border-right:1px solid #000;">
			<table width="100%">
				<tr><td width="40%">Account Name</td><td width="60%">MAXIMUM RENT A CAR</td></tr>
				<tr><td width="40%">Bank Account Number</td><td width="60%">0080033726</td></tr>
				<tr><td width="40%">Account Currency</td><td width="60%">AED</td></tr>
				<tr><td width="40%">IBAN Number</td><td width="60%">AE910420000000080033726</td></tr>
				<tr><td width="40%">Bank Name</td><td width="60%">NATIONAL BANK OF UMM AL QUWAIN (NBQ)</td></tr>
				<tr><td width="40%">SWIFT BIC</td><td width="60%">UMMQAEAD</td></tr>
				<tr><td width="40%">Branch</td><td width="60%">SHARJAH, KING FAISAL.</td></tr>
				<tr><td width="40%">Country</td><td width="60%">UNITED  ARAB EMIRATES</td></tr>
			</table>
		</td>
		<td width="50%">
			<table width="100%">
				<tr><td width="40%">Account Name</td><td width="60%">MAXIMUM RENT A CAR</td></tr>
				<tr><td width="40%">Bank Account Number</td><td width="60%">3707239233901</td></tr>
				<tr><td width="40%">Account Currency</td><td width="60%">AED</td></tr>
				<tr><td width="40%">IBAN Number</td><td width="60%">AE470340003707239233901</td></tr>
				<tr><td width="40%">Bank Name</td><td width="60%">EMIRATES ISLAMIC BANK</td></tr>
				<tr><td width="40%">SWIFT BIC</td><td width="60%">MEBLAEAD</td></tr>
				<tr><td width="40%">Branch</td><td width="60%">SHARJAH, AI QASIMIYAH</td></tr>
				<tr><td width="40%">Country</td><td width="60%">UNITED  ARAB EMIRATES</td></tr>
			</table>
		</td>
	</tr>
</table>-->

<hr>
</br></br></br>
<div id="bottompage">
<table width="100%" dir="rtl" >
  <tr>
    <td width="13%">تم التدقيق من قبل</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="23%">تم الاستلام من قبل </td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">التاريخ</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
    </tr>
    <tr>
      <td colspan="6">&nbsp;</td>
    </tr>
    </table>
   <table width="100%" class="normaltable">
   <tr>
      <td width="100%" ><img src="<%=contextPath%>/icons/maximumfooter.jpg" width="100%" height="78"  alt=""/></td>
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
  							<th width="10%" class="saliktable">Sr No</th>
							  <th width="10%" class="saliktable">Transaction ID</th>
							  <th width="20%" class="saliktable">Trip Date/Time</th>
							  <th width="15%" class="saliktable">Transaction Post Date</th>
							  <th width="30%" class="saliktable">Plate Info</th>
							  <th width="10%" class="saliktable">Toll Gate Location</th>
							  <th width="10%" class="saliktable">Toll Gate Direction</th>
							  <th width="10%" class="saliktable">Amount<br>(AED)</th>
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
  						<th width="10%" class="saliktable" align="left">Sr No</th>
							  <th width="10%" class="saliktable" align="left">Reg No</th>
							  <th width="15%" class="saliktable" align="left">Ticket No</th>
							  <th width="15%" class="saliktable" align="left">Traffic Date</th>
							  <th width="10%" class="saliktable" align="left">Time</th>
							  <th width="10%" class="saliktable" align="left">Amount</th>
							  <th width="10%" class="saliktable" align="left">Fine Source</th>
							  <th width="30%" class="saliktable" align="left">Description</th>
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
			     
			    <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg" width="100%"/></td> 
			    
		    </tr>
  			<tr><td><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td><table width="100%" class="saliktable">
  					<thead>
  						<tr class="saliktable">
  						<th width="10%" class="saliktable" align="left">Sr No</th>
							  <th width="10%" class="saliktable" align="left">Reg No</th>
							  <th width="15%" class="saliktable" align="left">Ticket No</th>
							  <th width="15%" class="saliktable" align="left">Traffic Date</th>
							  <th width="10%" class="saliktable" align="left">Time</th>
							  <th width="10%" class="saliktable" align="left">Amount</th>
							  <th width="10%" class="saliktable" align="left">Fine Source</th>
							  <th width="30%" class="saliktable" align="left">Description</th>
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
