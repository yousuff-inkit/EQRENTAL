<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css">  -->
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
<style>
 .hidden-scrollbar {
  overflow: auto;
/*  height: 900px;  */
} 

label {
    font: normal 10px ;
}


 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 
    legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:1px;

    }
    
  p{
	font-size: 9px;
	 
} 
</style> 
<script>
 
 
function gridload(){
	   var indexvals = document.getElementById("docnoval").value;
  
       $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
       
     }  


</script>
</head>
<body onload="gridload();" bgcolor="white" style="font: 9.5px Tahoma " >
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
 <div style="background-color:white;">
     <table width="100%">
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="90"  alt=""/></td> 
    <td width="46%" rowspan="2"align="center"><b><font size="3">Rental Agreement</font></b></td>
    <td width="19%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td>
    <td width="15%" rowspan="6" align="center"><img src="../../../../icons/amexqrcode.jpg" style="width:100%;height:auto;"></td>
  </tr>
  <tr>
  	
    <td width="27%"><b><label id="address" name="address"><s:property value="address"/></label></b></td>
   	
    </tr>
  <tr>
    <td rowspan="2"  align="center"><b>RANO :<label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>--<b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblindigobranchmobile" name="lblindigobranchmobile"><s:property value="lblindigobranchmobile"/></label></td>
    
    </tr>
    <tr><td align="left"><b>Mob :</b>&nbsp;<label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td></tr>
  <tr>
    <td rowspan="2"  align="center">
     </td>
    <td align="left"><b>Email :</b>&nbsp;<label id="lblindigobranchemail" name="lblindigobranchemail">CS@AMEXCARS.NET</label></td>
 </tr>
  <tr>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
    </tr>
<tr>
<td align="left"><b>&nbsp;</b>&nbsp;</td>
</tr>

  <tr>
    <td colspan="4"><hr noshade size=1 width="100%"></td>
  </tr>
</table>  
<table width="100%">
	<tr>
		
		<td width="36.5%" align="center">&nbsp;</td>
		<td width="33.33%" align="left"><b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b></td>
	</tr>
</table>
<%-- <table width="100%">
	<tr>
		<td colspan="2" width="40%"><b>Lessor (License Name)</b> <label id="companyname" name="companyname"><s:property value="companyname"/></label></td>
		<td width="30%">&nbsp;</td>
		<td colspan="2" width="40%"><b>Branch</b>:<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
	</tr>
	<tr>
		<td>Tel: <label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
		<td>Branch Mob: <label id="lblindigobranchmobile" name="lblindigobranchmobile"><s:property value="lblindigobranchmobile"/></label></td>
		<td>&nbsp;</td>
		<td colspan="2"></td>
	</tr>
</table> --%>
<table width="100%" >
  <tr>
  <td width="50%">
  <fieldset>
  <table width="100%" > 
  <tr>
  	<td width="18%" align="left" >Client ID &nbsp;  </td>
    <td width="82%" ><label id="lblindigocldocno" name="lblindigocldocno"><s:property value="lblindigocldocno"/></label></td>
    </tr>
  <tr>
      <td  align="left" >Name &nbsp;  </td>
    <td><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
    <tr>
      <td  align="left" >Nationality &nbsp;  </td>
    <td ><label id="lblindigonationality" name="lblindigonationality"><s:property value="lblindigonationality"/></label></td>
    </tr>
      <tr>
    <td  align="left">Address </td>
    <td height="20px" ><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
   </table>
  <table width="100%" >
      <tr>
    <td width="18%" align="left">MOB</td>
    <td width="82%"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td  align="left">Email  </td>
    <td ><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل السائق</b></legend>
    <table  width="100%" >
   <tr>
      <td width="20%" align="left">Name</td>
    <td width="82%" colspan="3">&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label> &nbsp;&nbsp;اسم السائق</td>
      
    </tr>
    </table>
        <table  width="100%" >
    <tr>
        <td  width="23%" align="left">D\L NO</td>
    <td width="77%" colspan="3"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td width="22%" align="left">Exp Date</td>
    <td width="20%" colspan="3"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td align="left">Passport NO</td>
    <td colspan="3"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    </tr>
    <tr>
    <td width="20%" align="left">Exp Date</td>
    <td width="30%"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   

    <td width="15%" align="right">DOB&nbsp;&nbsp;</td>
    <td width="30%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend><b>Additional Driver Details &nbsp;&nbsp;&nbsp;&nbsp;    تفاصيل السائق الاضافى</b></legend>
    <table  width="100%" >
<!--    <tr>
      <td width="20%" align="left"></td>
      <td width="40%" align="left" colspan="2">Additional Driver</td>
   </tr> -->
   <tr> 
  	  <td width="15%" align="left">Name</td>
      <td width="40%" ><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
      <td width="15%">Nationality</td>
      <td width="40%"><label id="lblindigoaddnationality" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td>
    </tr>
    <tr>
      <td align="left">D\L NO</td>
      <td ><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
      <td>Mobile</td>
      <td><label id="lblindigoaddmobile" name="lblindigoaddmobile"><s:property value="lblindigoaddmobile"/></label></td>
    </tr>
    <tr>
      <td width="" align="left">Exp Date</td>
        <td width="" ><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
        <td colspan="2">Signature</td>
    </tr>
     <tr>
      <td width="" align="left">DOB</td>
        <td width="" ><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
    	<td height="25px" colspan="2"><fieldset style="height:100%;"></fieldset></td>
    </tr>
    </table>
</fieldset>


<%-- <table width="100%"  >
 <tr>
 <td   width="100%">
 <fieldset>
<legend><b>Accidents&nbsp;&nbsp;&nbsp;&nbsp; الحوادث   </b></legend>
<P style="text-align:right;display:inline-block;">التوقيع ادناه يعنى انه لديكم العلم بأنه فى حالة حدوث اية حادث و جب الحصول على تقرير من الشرطة و ان تم الذكر بأنك المتسبب سنقوم بحساب قيم التحمل للحادث  والتى قيمتها 750 درهم اماراتى</P>
By Initialing, you understand any accident, even if you have availed CDW, must be accompanied by a valid police report.
Failure to provide one will result in additional charges. Customer who opt out of CDW will be liable to pay the excess deductible amount of 750 AED
<label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label>
<!-- <table width="100%"  >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table> -->
</fieldset>
</td>
</tr>
<tr>
<td width="100%">
 <fieldset >
<legend><b>Traffic Fines&nbsp;&nbsp;&nbsp;&nbsp; المخالفات المرورية </b></legend>
<P style="text-align:right;display:inline-block;">التوقيع ادناه يعنى انه لديكم العلم بأنه سيتم حساب ما قيمته 10% على كل قيمة مخالفة يتم تحريرها لكم اثناء استأجار السيارة من قبلكم</P>
By putting your initial in box provided,
 You agree to pay all traffic and parking 
 fines issued to you whilst the vehicle is
  rented in your name, you also agree to pay 
  a 10% admin charge in addition to the fine.
<!--   <table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table> -->
</fieldset>

 </td>
 </tr>
<tr>
 <td>
 <fieldset width="100%">
<legend><b>Salik (Road tolls)&nbsp;&nbsp;&nbsp;&nbsp; تعرفة سالك </b></legend>
<P style="text-align:right;display:inline-block;">      التوقيع ادناه يعنى انه لديكم العلم بأنه سيتم حساب 5 دراهم اماراتية كرسم عبور لكل بوابة سالك</P> 
<br> By putting your initial in the box provided below you agree to pay salik charges of 4 Dhs for each crossing and 1 Dhs admin fee.
Total 5 Dhs per crossing.These charges will be added to the end of the rental, or as and when we are notified by the RTA.
<!-- <table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table> -->
</fieldset>
 </td></tr>
 </table> --%>
<!--  <table width="100%">
 	<tr>
 		<td width="50%">&nbsp;</td>
 		<td width="50%">
 			<table width="100%">
 				<tr>
 					<td colspan="2"><b>Documents</b></td>
 				</tr>
 				<tr>
 					<td width="10%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;width:25px;height:25px;background-color:transparent;"></td>
 					<td width="90%">Passport & VISA</td>
 				</tr>
 				<tr>
 					<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;width:25px;height:25px;background-color:transparent;"></td>
 					<td>Emirates ID</td>
 				</tr>
 				<tr>
 					<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;width:25px;height:25px;background-color:transparent;"></td>
 					<td>Driving License</td>
 				</tr>
 				<tr>
 					<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;width:25px;height:25px;background-color:transparent;"></td>
 					<td>Mulkiya Issued</td>
 				</tr>
 			</table>
 		</td>
 	</tr>
 </table> -->
 <!-- <table width="100%">
 <tr>
 <td>
<b>VEHICLE INSURED FOR UAE TERRITORY ONLY</b>
</td>
</tr>
<tr>
<td>
 
</td>
</TR>


</table> -->

  </td>
  <td width="50%">
  <fieldset>
  <legend><b>Vehicle&nbsp;&nbsp;&nbsp;&nbsp;   نوع المركبة</b></legend>
     <table width="100%" >  
  <tr>
    
    <td width="52%" ><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <%-- <td width="18%" >YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td> --%>
    <td width="30%" colspan="2">Color&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td align="left">Reg NO&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label> &nbsp;&nbsp;رقم المركبة</td>
 
     <td align="left" colspan="2">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b>Out Details  &nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل خروج السيارة  </b></legend>  
       <table>
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left">Date</th>
       <th width="22%" align="left">Time</th>
          <th width="22%" align="left">Km</th>
             <th width="19%" align="left">Fuel</th>
  </tr>
  <tr>
  <td><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td> 
<td><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
<td><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
<td><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
<td><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
  </tr>
   <tr>
  <td><b><label id="deldetailss" name="deldetailss"><s:property value="deldetailss"/></label></b></td>
<td><label id="deldates" name="deldates"><s:property value="deldates"/></label></td>
<td><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td>
<td><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td>
<td><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td>
  </tr>
<tr><td colspan="2">Vehicle Service Due</td><td colspan="3"><label id="rarentserdue" name="rarentserdue"><s:property value="rarentserdue"/></label></td></tr> </table>
  </fieldset>     
        
  <%--   <fieldset>
    <legend><b>Out Details</b></legend>
    <table width="100%" >
    <tr>
    <td width="10%" align="left">Date</td>
    <td width="18%"><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
    <td width="12%" align="right">Time&nbsp;&nbsp;</td>
     <td width="15%"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
    </tr>
    <tr>
   
    <td width="10%" align="left">KM</td><td width="25%">
      <label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
      
        <td width="10%" align="right">Fuel&nbsp;&nbsp;</td><td width="30%">
      <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
    </tr>
    </table>
    </fieldset> --%>
     <fieldset><legend><b>Rental Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل الايجار</b></legend>  
      <table  width="100%" >
      	<%-- <tr>
      		<td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>
      		<td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
      		<td><label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label>
       		<td width="18%" align="right">CDW&nbsp;&nbsp;</td>
       		<td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    	</tr> --%>
    	<tr>
    		<td><label id="lblindigorenttype" name="lblindigorenttype"><s:property value="lblindigorenttype"/></label>&nbsp;Tariff</td>
    		<td><label id="lblindigorate" name="lblindigorate"><s:property value="lblindigorate"/></label></td>
    		<td>Discount&nbsp;&nbsp;&nbsp;<label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label></td>
    		<td><b>Net Total&nbsp;&nbsp;&nbsp;<label id="lblindigonettotal" name="lblindigonettotal"><s:property value="lblindigonettotal"/></label></b></td>
    	</tr>
    </table>
    <table  width="100%" >
         <%-- <tr><td width="15%">Advance Rental Amount</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td> --%>
		<tr><td width="15%">Advance Rental Amount</td><td width="25%"><label id="lblcosmoadvance" name="lblcosmoadvance"><s:property value="lblcosmoadvance"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%">Security Deposit Amount</td><td width="25%"><label id="lblcosmosecurity" name="lblcosmosecurity"><s:property value="lblcosmosecurity"/></label></td>
       <td width="35%">Extra per KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
       <tr><td width=35%>&nbsp;</td><td width="25%">&nbsp;</td></tr>
  </table>
    </fieldset>
     <fieldset>
    <legend><b>In Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل دخول السيارة  </b></legend>  
       <table>
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left">Date</th>
       <th width="10%" align="left">Time</th>
          <th width="22%" align="left">Km</th>
             <th width="19%" align="left">Fuel</th>
             <th width="19%" align="center">Signature</th>
  </tr>
  <tr>
  <td><b><label id="indetails" name="indetails"><s:property value="indetails"/></label></b></td>
<td><label id="indate" name="indate"><s:property value="indate"/></label></td>
<td><label id="intime" name="intime"><s:property value="intime"/></label></td>
<td><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
<td><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
  </tr>
   <tr>
  <td><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
<td><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
<td><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
<td><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
<td><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
  </tr>
 </table>
  </fieldset>   
  
  <%--  <fieldset><legend><b> Closing Details</b></legend> 
     <table width="100%" > 
           <tr>
    <td width="18%" align="left">In KM </td>
    <td width="36%"><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
 
    <td width="20%" align="left">In Fuel </td>
    <td width="26%"><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
    </tr>
       <tr>
    <td align="left">In Date </td>
    <td ><label id="indate" name="indate"><s:property value="indate"/></label></td>
 
    <td  align="left">In Time</td>
    <td><label id="intime" name="intime"><s:property value="intime"/></label></td>
    </tr>
     </table>
     </fieldset> --%>
        <table width="100%">
    <tr>
    <td width="100%">
 <%-- <div id="calcdiv">
  <jsp:include page="calculationGrid.jsp"></jsp:include></div> --%>
  <!-- <img src="../../../../icons/indigoprintcar.png" style="width:100%;"/> -->
  </td>
  </tr>
  </table> 
<%--   <fieldset width="100%">
    <legend>
     <b>Closing Balance Amount &nbsp;&nbsp;&nbsp;&nbsp; الرصيد عند الاغلاق  </b></legend>
     <table  width="100%">
      <tr>
     
         
    <td width="25%" align="left">Total Receipt</td>
    <td width="75%">&nbsp;&nbsp;<label id="totalpaids" name="totalpaids"><s:property value="totalpaids"/></label></td>
 </tr>
 <tr>
    <td width="25%" align="left">Invoice Amount </td>
    <td width="75%">&nbsp;&nbsp;<label id="invamount" name="invamount"><s:property value="invamount"/></label></td>
 </tr>
 <tr>
    <td align="left">Balance</td>
    <td >&nbsp;&nbsp;<label id="balance" name="balance"><s:property value="balance"/></label></td>
    </tr>
    
     </table>
    <hr noshade size=1>
     <table  width="100%"   >
           <tr>
    <td>
        <P style="text-align:right;display:inline-block;"> 
        من المهم ان تقوم بقرائة و فهم  القواعد و الشروط المترتبة على هذا التعاقد قبل التوقيع .
اذا تم الدفع المالى من قبلكم بواسطة البطاقة الأتمانية , سيكون التوقيع على هذا التعاقد بمثابة موافقة من قبلكم ليتم
حسابكم تلقائيا لقيم الايجار و المخالفات المرورية و الحوادث و تعرفة سالك و الوقود المستخدم  بدون الرجوع اليكم
حتى و ان كان تم غلق التعاقد مهما كانت المدة.   
         </P>
  <font style="font-size:8px ;text-align:right;">It is important that you have read and understood the terms
     and conditions that  will apply  to this contract before singing.
      Only sign this agreement if you wish to be bound by the terms and conditions 
      over the page. (Arabic translation overleaf is available on the rental 
       wallet) and if you are paying by Credit card, your signature is authorization 
       for Automatic  billing. Your signature also allows us to deduct any additional 
       charges pertaining to this  contract after the rental agreement has been closed.</font>
      </td>
    </tr>
    <tr>
    <td align="left" ><hr noshade size=1>Customer Signature
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date</td></tr>
  <!--   <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
     <tr> <td align="left" ><hr noshade size=1>Rental Agent
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date</td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
      <tr>
      <td align="left">
    <fieldset>
     <font style="font-size:7.5px">You are responsible for any damage to the vehicle by striking overhanging objects.</font>
     
      </fieldset>
      </td>
      </tr>
     </table>
 </fieldset>  --%>
  </td>
    </tr>
    <tr>
    	<td colspan="2">
    		<fieldset><legend><b>Insurance Type</b></legend>
  	<table width="100%">
  		<tr>
  			<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Excess Claim 1000 AED + 10% Damage Value</td>
  		
  		
  			<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Excess Claim 1000 AED</td>
  			<!--<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Insurance Excess 2500</td>-->
  	
  	
  			<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Insurance Excess Zero (Collision Damage Waiver)</td>
  			<!--<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Excess 2500 + 30% Damage</td>-->
  		</tr>
  	</table>
  </fieldset>  
    		
    	</td>
    </tr>
    <tr>
    	<td colspan="2">
    		<table width="100%">
    			<tr>
    				<td width="50%">
    					<fieldset><legend><b>Check In</b></legend>
    						<img src="../../../../icons/carout.png" style="width:100%;height:120px;"/>
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel&nbsp;&nbsp;
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit
    					</fieldset>
    				</td>
    				<td width="50%">
    					<fieldset><legend><b>Check Out</b></legend>
    						<img src="../../../../icons/carout.png" style="width:100%;height:120px;"/>
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel&nbsp;&nbsp;
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit
    						
    					</fieldset>
    				</td>
    		</table>
    	</td>
    	</tr>
    	
    	<tr>
    		<td colspan="2">
    			<table width="100%">
    				<tr>
    					<td width="40%">
    						<fieldset><legend>Car Out</legend>
    							<table width="100%">
    								<tr>
    									<td style="width:52%;">Registration<span style="float:right;"><input type="checkbox"></span></td>
    									<td style="width:48%;">Rod Wheel<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>Radio/Type<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Wheel Spanner<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>A/C Controls<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Spare Tyre<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>Floor Matt<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Radio Antena<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>Wheel Caps/Cover<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Door Locks<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>Toolkit<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Wing Mirrors<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>LCD/Navigation System<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Remote<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    							</table>
    						</fieldset>
    					</td>
    					<td width="20%"><img src="<%=contextPath%>/icons/nosmoking.jpg" width="150" height="150"  alt=""/>
    					</td>
    					<td width="40%">  
    					<fieldset><legend>Car In</legend>
    							<table width="100%">
    								<tr>
    									<td style="width:52%;">Registration<span style="float:right;"><input type="checkbox"></span></td>
    									<td style="width:48%;">Rod Wheel<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>Radio/Type<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Wheel Spanner<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>A/C Controls<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Spare Tyre<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>Floor Matt<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Radio Antena<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>Wheel Caps/Cover<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Door Locks<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>Toolkit<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Wing Mirrors<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    								<tr>
    									<td>LCD/Navigation System<span style="float:right;"><input type="checkbox"></span></td>
    									<td>Remote<span style="float:right;"><input type="checkbox"></span></td>
    								</tr>
    							</table>
    						</fieldset>

    					</td>
    				</tr>
    			</table>
    		</td>
    	</tr>
    	<!-- <tr>
    	<td>
    		<fieldset>
    		<legend><b>Documents Checklist</b></legend>
    			<table width="100%">
    				<tr>
    					<td width="50%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Passport & VISA</td>
    					<td width="50%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Emirates ID</td>
    				</tr>
 					<tr>
 						<td width="50%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Driving License</td>
    					<td width="50%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Mulkiya Issued</td>
 					</tr>   				
    			</table>
    		</fieldset>
    	</td>
    	<td><fieldset><p style="font-size:9px;">In case of delayed payments rate will be changed to daily shelf rent of the contracted vehicle and all discounts will be removed from the contract. Tyres damages are not covered with insurance and shall be charged separately in case of a damage.</p></fieldset></td>
    	</tr> -->
    	
    	<tr>
    		<td colspan="2">
    			<fieldset><legend><b>Terms & Conditions</b></legend>
    				<p style="font-size:8px;">
    					I acknowledge receipt of the vehicle identified in this Vehicle Rental Agreement and that its condition is indicated in the Vehicle Check Report. I agree to pay all rental charges and 5 AED Salik charge for every crossing and any charges of fines or offence AED 50 surcharge per fine associated with this vehicle if the fines are below 500. If the fines are above 500 then I agree to pay 20% administrative charges above fine.
    				    I agree to pay AED 300 per black point. I agree to pay 1000 AED in case of impounding or in case of accident which is not covered by insurance policy. I agree to pay damages not covered by Police Report and to pay for any loss of documents or accessories from the vehicle. My signature below shall constitute my authority read, understood and accepted all the terms and conditions listed on the Vehicle Rental Agreements and security deposit amount will be returned after 15 days when the car is returned. 
    				    I agree to return the car at company’s office location.In an event where hirer opt to an early cancellation or termination of initial booking.AMEX Car Rental will not be responsible to refund the unused credits and days.
 
    				</p>
    			</fieldset>	
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<fieldset>
    				<table width="100%">
    					<!-- <tr>
    						<td width="50%">Fuel Charges</td>
    						<td width="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					</tr> -->
    					<tr>
    						<td width="50%">Next Service Km</td>
    						<td width="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					</tr>
    				</table>
    			</fieldset>
    		</td>
    		<td><fieldset>
    			<table width="100%">
    				<tr>
    					<td width="30%">Customer Signature</td>
    					<td width="40%">&nbsp;</td>
    					<td width="15%">Date</td>
    					<td width="15%">&nbsp;</td>
    				</tr>
    				<%-- <tr>
    					<td>Rental Agent</td>
    					<td><label id="lblindigorentalagent" name="lblindigorentalagent"><s:property value="lblindigorentalagent"/></label></td>
    					<td>Date</td>
    					<td>&nbsp;</td>
    				</tr> --%>
    			</table>
    		</fieldset>
    		  </table>
    		<div style="page-break-after: always;">
    		   
    		</div>
    		<table style="width:100%;">
    			<tr>
    				<td colspan="2">
    					<table style="width:100%;">
    						<tr>
    							<td style="width:50%;"><b>TERMS AND CONDITIONS</b></td>
    							<td align="right" style="width:50%;"><img src="../../../../icons/heading.png" /></td>
    						</tr>
    					</table>
    				</td>
    			</tr>
    			<tr>
    				<td colspan="2">This agreement made and execuled by and between the Hirer and AMEX Car Rental a company duly organized and existing
                    under and by virtue of the U.A.E, after called the COMPANY WITNESSED.</td>
                </tr>
    			<tr>
    				<td style="width:50%;font-size:2px; ">
                      <p> 1.&nbsp;&nbsp; The hirer declares that his/her license is more then six months old and is allowed to drive the hired vehicle according to U.A.E. Traffic law and will not allow any person to drive it. <br>
                       *&nbsp;  If the additional driver not added in rental agreement.<br>
                           *&nbsp;  Not licensed to drive the vehicle.<br>
                           *&nbsp;  Did not complete six months from date the license obtained. Less then 21 years old.<br></p>
                       <p>   2.&nbsp;&nbsp;	The vehicle is delivered to the hirer in good condition as per the checkout list which is duty signed by the hirer, with radiator and oil reservoirs fill, the hirer undertakes to ensure that sufficient water and oil is in the vehicle at all time.<br> </p>
<p>3.&nbsp;&nbsp;	The hirer undertakes to return the vehicle for periodical service as indicated in the checkout list and sticker in the vehicle indicating next service due. Failing to do so, any mechanical defect that may manifest due to the above negligence, the hirer will be held liable for all cost that may be incurred to repair such damages, and for any loss of hire the office may suffer.<br></p>
<p>4.&nbsp;&nbsp;	The hirer agrees and undertakes to return the vehicle back in the same condition when it was hired out. And with the same quantum of fuel condition in the vehicle as the time of commencement of hire, or agrees to pay for the difference in fuel levels if quantum differs at the end of the hire.<br></p>
<p>5.&nbsp;&nbsp;	Security will be refunded back after 21 days of returning the car.<br></p>
<p>6.&nbsp;&nbsp;	Should the hirer have repairs / alterations carried out without the office’s written consent. He / she will be liable for all costs in case of improper reapir and for any loss of hire the office may suffer.<br></p>
<p>7.&nbsp;&nbsp;	If the vehicle is damaged in any way. the office reserves the right to take possession of the vehicle and carry out any repairs required the period of the hire shall then be extended to cover the time take to repair such damages.<br></p>
<p>8.&nbsp;&nbsp;	The hirer agree to pay for any damages caused to tyres and / or rims whist the vehicle is in his / her possession as the same cannot be reclaimed from the insurance company.<br></p>
<p>9.&nbsp;&nbsp;	The hirer will not sublet the vehicle or use the vehicle for towing, races, rallers, competitions or carry articles which may cause damages to the vehicle. In such case the hirer will be liable for any damages or loss of income that may be incurred for non compliances of this conditions.<br></p>
<p>10.&nbsp;&nbsp;	In case of accident and if the hirer is under the influence of any alcoholic drinks and drugs. the hirer will bear all the results damages and liabilities. Towards the police, courts and fines.<br></p>
<p>11.&nbsp;&nbsp;	The vehicle is insuranced for use in the U.A.E. Only and specific extension of insurance coverage will have to be obtained, in advance through the office in the event of the vehicle being intended for use outside the U.A.E.<br></p>
<p>12.&nbsp;&nbsp;	I have seen the registration copy in the vehicle and will return it with thw car.<br></p>
<p>13.&nbsp;&nbsp;	The office absolves itself or any responsibility for any cash or valuable belongings to the hirer that may be lost whilst the vehicle is in his/her possession or after the entire period of the hire.<br></p> 
<p>14.&nbsp;&nbsp;	The hirer must ensure that the vehicle is parked in a safe and secure place when it is not in use any damage due to acts of God will be the sole responsibility of the hirer as the same cannot be claimed from the insurance.<br></p>
<p>15.&nbsp;&nbsp;	Delivery collection of vehicles away from the office will be made only between 08.00 - 13.00 hrs & 16:00 -20:00 hrs. since no delivery of collection will be made beyond these hours, the customer will be charged normal rental up to the time the vehicle is returned/collectd during these hours, as the minimum hire period is 24 hours & the part of the day is considered a full day.<br></p>
<p>16.&nbsp;&nbsp;	The office reserves the right to recover the vehicle wherever it my be without referring to the authorities. And charge the hirer any loss of income the office may suffer and the office absolves itself of any responsibility for any cash or valuable belonging left in the vehicle if the hirer.<br>
* &nbsp; Fails to comply with the terms and conditions of this agreement.<br>
* &nbsp; Made major alterations in the vehicle.<br>
* &nbsp; Did not make the payments on times as agreed.<br>
* &nbsp; If requested does not return the vehicle to renew its registration.<br></p>
<p>17.&nbsp;&nbsp;	ACCIDENT: In case of an accident caused by hirer, police & AMEX Car Rental should be informed immediately and the renter will bear the repair costs which will be amount not exceeding the compulsory charge amount 1000 AED referred to in the applicable laws and regulations in U.A.E Insurance consolidated policy) If the cost is less than that hirer will be bound to pay the amount for repairing the vehicle and the rent for all those days until the car comes into the proper condition in which it was delivered to the hirer.<br></p>
<p>18.&nbsp;&nbsp;	The hirer shall indemnify AMEX Car Rental for all legal claims (fines) caused by him as a result of using the vehicle during the hire period ( which are not covered under the conditions of insurance policy ).<br></p>
<p>19.&nbsp;&nbsp;	The hirer acknowledges that all details provided in the rental contract are correct and true and agrees to pay AED 5/- per salik crossing.<br></p>
<p>20.&nbsp;&nbsp;	In case hirer wishes to extend the hire period, he/she should inform prior one day from the expiry date of rental contract otherwise office office will be entitled to recall the vehicle wherever it is, or inform the concerned authorities about the vehicle as stolen.<br></p> 
<p>21.&nbsp;&nbsp;	EXCESS HOURS: Use of the vehicle beyond the agreed return time specified herein shall be subject to the penalty rate AED 20/ hour unless an extension has been requested and approved. No fraction of time is allowed for the 24 hours rental.<br></p>
<p>22.&nbsp;&nbsp;	The hirer will inform AMEX about additional driver or else no one else can drive the vehicle besides person signing this contract.<br></p>
<p>23.&nbsp;&nbsp;	The hirer will not smoke or let anyone else smoke in the car. In case there is a smell of cigarette then hirer will be fined 500 AED and more depending in the damage.<br></p>
<p>24.&nbsp;&nbsp;	Vehicle will be returned before 6:00 pm or else hirer will be charged extra day.<br></p>
<p>25.&nbsp;&nbsp;	In case of an additional driver there will be a charge of 100AED - Failing to do so will be reported to the police and legal action will be taken.<br></p> 
<p>26.&nbsp;&nbsp;	In an event where hirer opt an early cancellation or termination of initial booking, AMEX Car Rental will not be responsible to refund the unused credits and days.<br></p>
<p>27.&nbsp;&nbsp;	Cleaning charges is applied when not returned at the same condition.<br></p>
<p>28.&nbsp;&nbsp;	If security deposit can not be transferred back to the same card, then customer has to come to the office for receiving the cheque.</p><br>
                            

    				</td>
    				<td style="width:50%;font-size:6px;">
    				<img src="../../../../icons/bodynew.png" style="height:805px;;width:100%;" />
    				<!-- <p style="text-align:right;">ﻭﺍﻻﻣﺮﻳﻜﻴﻪ ﺍﻛﺴﺒﺮﺱ ﺗﺎﺟﻴﺮ ﺍﻟﺴﻴﺎﺭﺍﺕ ﻋﻠﻲ ﺍﻟﻔﻮﺭ ﺍﺧﻄﺎﺭ  ﻳﺠﺐ ﻋﻠﻲ ﺍﻟﺸﺮﻃﺔ ، ﻓﻲ ﺣﺎﻟﻪ ﻭﻗﻮﻉ ﺣﺎﺩﺙ ﺑﺴﺒﺐ ﺍﻟﻌﻤﻞ :ﺍﳊﺎﺩﺙ .١٧ ﺩﺭﻫﻢ ﺍﳌﺸﺎﺭ ﺍﻟﻴﻬﺎ ﻓﻲ               ١٠٠٠ ﺭ ﺍﻟﺴﺎﺣﻞ ﺳﻮﻑ ﺗﺘﺤﻤﻞ ﺇﺻﻼﺡ ﺍﻟﺬﻱ ﺳﻴﻜﻮﻥ ﻣﺒﻠﻎ ﻻ ﻳﺘﺠﺎﻭﺯ ﺍﻟﺮﺳﻮﻡ ﺇﻟﺰﺍﻣﻴﻪﻭﺍﺳﺘﺌﺠﺎ ﻭﺳﻮﻑ ﻳﻘﺘﺼﺮ ﺍﻟﺘﺎﺟﻴﺮ ، ﺇﺫﺍ ﻛﺎﻥ ﺍﳋﻂ ﺍﻟﺴﺎﺣﻠﻲ ﺍﻗﻞ (ﺑﻮﻟﻴﺼﺔ ﺍﻟﺘﺎﻣﲔ ﺍﳌﻮﺣﺪﺓ) .ﺍﻟﻘﻮﺍﻧﲔ ﻭﺍﻟﻠﻮﺍﺋﺢ ﺍﳌﻌﻤﻮﻝ ﺑﻬﺎ ﻓﻲ ﺍﻻﻣﺎﺭﺍﺕ ﻡ ﺣﺘﻰ ﺗﺎﺗﻲ ﺍﻟﺴﻴﺎﺭﺓ ﺇﻟﻰ ﺍﻟﺪﻭﻟﺔ ﺍﳌﻨﺎﺳﺒﺔ ﺍﻟﺘﻲ ﰎ ﺗﺴﻠﻴﻤﻬﺎ ﺇﻟﻰ ﺍﻹﻳﺠﺎﺭﺍﻟﺴﻴﺎﺭﺍﺕ ﻭﺍﻹﻳﺠﺎﺭ ﳉﻤﻴﻊ ﺗﻠﻚ ﺍﻷﻳﺎ  ﻟﺪﻓﻊ ﺛﻤﻦ ﺗﺼﻠﻴﺢ ﻭﺍﻟﺘﻲ ﻟﻴﺴﺖ ﺍﻟﻐﻼﻑ ﲢﺖ ﺍﻻﺷﺮﺍﻑ ﻋﻠﻲ ﺑﻮﻟﻴﺼﺔ ﺍﻟﺘﺎﻣﲔ( ﻻﺳﺘﺨﺪﺍﻡ ﺍﻟﺴﻴﺎﺭﺓ ﺧﻼﻝ ﻓﺘﺮﻩ ﺍﻻﺳﺘﺌﺠﺎﺭ)
    				</p>
    				<p style="text-align:right;">١٨ﺍﻟﺘﻲ ﻳﺴﺒﺒﻬﺎ ﻟﻪ ﻧﺘﻴﺠﺔ (ﺍﻟﻐﺮﺍﻣﺔ) ﻲ ﺍﳌﺴﺘﺎﺟﺮ ﺍﺳﺘﺌﺠﺎﺭ ﺳﻴﺎﺭﺓ ﺃﻣﺮﻳﻜﺎﻥ ﺍﻛﺴﺒﺮﻳﺲ ﳉﻤﻴﻊ ﺍﳌﻄﺎﻟﺒﺎﺕ ﺍﻟﻘﺎﻧﻮﻧﻴﺔﻳﺠﺐ ﻋﻠ .ﺩﺭﺍﻫﻢ ﻟﻜﻞ ﻣﻌﺒﺮ ﺳﺎﻟﻚ    ٥ ﻋﻠﻲ ﺩﻓﻊ.  
    				</p>
    				<p style="text-align:right;">١٩ﺎﺟﺮ ﺑﺎﻥ ﺟﻤﻴﻊ ﺍﻟﺘﻔﺎﺻﻴﻞ ﺍﻟﻮﺍﺭﺩﺓ ﻓﻲ ﻋﻘﺪ ﺍﻹﻳﺠﺎﺭ ﺻﺤﻴﺤﻪ ﻭﺻﺤﻴﺤﻪ ﻭﻳﻮﺍﻓﻖﻭﻳﻘﺮ ﺍﳌﺴﺘ .  .ﺃﻭ ﺍﻥ ﻳﺒﻠﻎ ﺍﻟﺴﻠﻄﺎﺕ ﺍﳌﻌﻨﻴﺔ ﻋﻦ ﺍﳌﺮﻛﺒﺔ ﺑﺄﻧﻬﺎ ﻣﺴﺮﻭﻗﺔ ، ﺍﻹﻳﺠﺎﺭ ﺑﺄﻧﻪ ﻳﺤﻖ ﻟﻪ ﺍﻥ ﻳﺘﺬﻛﺮ ﺍﳌﺮﻛﺒﺔ ﺃﻳﻨﻤﺎ ﻛﺎﻧﺖ
    				</p>
    				<p style="text-align:right;">٢٠ﻋﻘﺪ ﻳﻨﺒﻐﻲ ﻟﻪ ﺍﻥ ﻳﺒﻠﻎ ﺍﳌﻜﺘﺐ ﻗﺒﻞ ﻳﻮﻡ ﻣﻦ ﺗﺎﺭﻳﺦ ﺍﻧﺘﻬﺎﺀ ، ﻭﻓﻲ ﺣﺎﻟﻪ ﺭﻏﺒﻪ ﺍﳌﺴﺘﺎﺟﺮ ﻓﻲ ﲤﺪﻳﺪ ﻓﺘﺮﻩ ﺍﻻﺳﺘﺌﺠﺎﺭ .  
    				</p>
    				<P STYLE="TEXT-ALIGN:RIGHT;"> .٢١ﺩﺭﻫﻤﺎ      ٢٠ﻊ ﺍﺳﺘﺨﺪﺍﻡ ﺍﻟﺴﻴﺎﺭﺓ ﺇﻟﻰ ﻣﺎ ﺑﻌﺪ ﻭﻗﺖ ﺍﻟﻌﻮﺩﺓ ﺍﳌﺘﻔﻖ ﻋﻠﻴﻪ ﳌﻌﺪﻝ ﺍﻟﻐﺮﺍﻣﺔﻳﺠﺐ ﺍﻥ ﻳﺨﻀ :ﺍﻟﺴﺎﻋﺎﺕ ﺍﻟﺰﺍﺋﺪﺓ.  </P>
    				<p style="text-align:right;"> ﻓﻲ ﺣﺎﻟﻪ ﻭﺟﻮﺩ ﺭﺍﺋﺤﺔ ﺍﻟﺴﻴﺠﺎﺭ ﺳﻴﺘﻢ ﺗﻐﺮﱘ .ﺍﳌﺴﺘﺎﺟﺮ ﻟﻦ ﻳﺪﺧﻦ ﺃﻭ ﺍﻟﺴﻤﺎﺡ ﻷﻱ ﺷﺨﺺ ﺁﺧﺮ ﺍﻟﺘﺪﺧﲔ ﻓﻲ ﺍﻟﺴﻴﺎﺭﺓ .٢٣
    				</p>
    				<p style="text-align:right;"> .ﺳﺎﻋﺔ      ٢٤ ﻣﻦ ﺍﻟﻮﻗﺖ ﻟﻠﺘﺎﺟﻴﺮ ﻋﻠﻲ ﻣﺪﺍﺭ ﻭﻻ ﻳﺴﻤﺢ ﺑﺄﻱ ﺟﺰﺀ ، ﻟﻠﺴﺎﻋﺔ ﺍﻟﻮﺍﺣﺪﺓ ﻭﻗﺪ ﰎ ﻃﻠﺐ ﺍﻟﺘﻤﺪﻳﺪ ﻭﺍﳌﻮﺍﻓﻘﺔ ﻋﻠﻴﻪ ﺮ ﺑﺈﺑﻼﻍ ﺃﻣﺮﻳﻜﺎﻥ ﺍﻛﺴﺒﺮﻳﺲ ﻋﻦ ﺳﺎﺋﻖ ﺇﺿﺎﻓﻲ ﺃﻭ ﻻ ﳝﻜﻦ ﻷﻱ ﺷﺨﺺ ﺁﺧﺮ ﻗﻴﺎﺩﻩﺳﻴﻘﻮﻡ ﺍﳌﺴﺘﺎﺟ .٢٢ .ﺍﻟﺴﻴﺎﺭﺓ ﺇﻟﻰ ﺟﺎﻧﺐ ﺍﻟﺘﻮﻗﻴﻊ ﻋﻠﻲ ﻫﺬﺍ ﺍﻟﻌﻘﺪ
    				</p>

    				<p style="text-align:right;">.ﺩﺭﻫﻢ ﻭﺃﻛﺜﺮ ﺍﻋﺘﻤﺎﺩﺍ ﻋﻠﻲ ﺍﻟﻀﺮﺭ         ٥٠٠ ﺍﳌﺴﺘﺎﺟﺮ
ﻭﺍﻻ ﺳﻴﺘﻢ ﺍﺣﺘﺴﺎﺏ ﺍﻟﻴﻮﻡ ﺍﻹﺿﺎﻓﻲ ﻟﻠﺴﻴﺎﺭﺓ ﺍﳌﺴﺘﺎﺟﺮﻩ ، ﻣﺴﺎﺀ          ٦:٠٠ﺳﻴﺘﻢ ﺇﺭﺟﺎﻉ ﺍﳌﺮﻛﺒﺔ ﻗﺒﻞ ﺍﻟﺴﺎﻋﺔ.٢٤ ﻋﺪﻡ ﺍﻟﻘﻴﺎﻡ ﺑﺬﻟﻚ ﺑﺸﻜﻞ ﺟﻴﺪ ﻳﺘﻢ-ﺩﺭﻫﻢ            ١٠٠ ﻓﻲ ﺣﺎﻟﻪ ﻭﺟﻮﺩ ﺣﻤﻠﻪ ﺍﺿﺎﻓﻴﻪ ﺳﻴﻜﻮﻥ ﻫﻨﺎﻙ ﺗﻬﻤﻪ .٢٥
    				
    				ﺇﺑﻼﻍ ﺍﻟﺸﺮﻃﺔ ﺳﻴﺘﻢ ﺍﺗﺨﺎﺫ ﺍﻹﺟﺮﺍﺀﺍﺕ ﺍﻟﻘﺎﻧﻮﻧﻴﺔ
    				</p>
    				
    				
    				<p style="text-align:right;"> ٢٦.  ﻟﻦ ﻳﺘﻢ ﺃﻋﺎﺩﻩ ﺗﺎﺟﻴﺮ ﺍﻟﺴﻴﺎﺭﺍﺕ ﻣﻦ ﺃﻣﺮﻳﻜﺎﻥ،  ﻓﻲ ﺣﺎﻟﻪ ﺍﺧﺘﻴﺎﺭ ﺍﳌﺴﺘﺎﺟﺮ ﻟﻺﻟﻐﺎﺀ ﺍﳌﺒﻜﺮ ﺃﻭ ﺇﻧﻬﺎﺀ ﺍﳊﺠﺰ ﺍﻟﻜﺘﺮﻭﻧﻲ ﺍﻛﺴﺒﺮﻳﺲ ﻻﺳﺘﺮﺩﺍﺩ ﺍﻻﻋﺘﻤﺎﺩﺍﺕ ﻭﺍﻷﻳﺎﻡ ﻏﻴﺮ ﺍﳌﺴﺘﺨﺪﻣﺔ. 
    				</p>
    				<p style="text-align:right;">ﺗﻌﺎﺩ ﻓﻲ ﻧﻔﺲ ﺍﳊﺎﻟﺔ   ﻳﺘﻢ ﺗﻄﺒﻴﻖ ﺭﺳﻮﻡ ﺍﻟﺘﻨﻈﻴﻒ ﻋﻨﺪﻣﺎ ﻻ ﺗﻌﺎﺩ ﻓﻲ ﻧﻔﺲ ﺍﳊﺎﻟﺔ.٢٧
    				</p>
    				<p>_________________
    				</p>
   -->  			
   					<p>١٧ﻳﺠﺐ ﻋﻠﻲ ﺍﻟﺸﺮﻃﺔ  ﻭﺍﻻﻣﺮﻳﻜﻴﻪ ﺍﻛﺴﺒﺮﺱ ﺗﺎﺟﻴﺮ ﺍﻟﺴﻴﺎﺭﺍﺕ ﻋﻠﻲ ﺍﻟﻔﻮﺭ ﺍﺧﻄﺎﺭ ،  ﺍﳊﺎﺩﺙ :ﻓﻲ ﺣﺎﻟﻪ ﻭﻗﻮﻉ ﺣﺎﺩﺙ ﺑﺴﺒﺐ ﺍﻟﻌﻤﻞ ﻭﺍﺳﺘﺌﺠﺎﺭ ﺍﻟﺴﺎﺣﻞ ﺳﻮﻑ ﺗﺘﺤﻤﻞ ﺇﺻﻼﺡ ﺍﻟﺬﻱ ﺳﻴﻜﻮﻥ ﻣﺒﻠﻎ ﻻ ﻳﺘﺠﺎﻭﺯ ﺍﻟﺮﺳﻮﻡ ﺇﻟﺰﺍﻣﻴﻪ               ﺩﺭﻫﻢ ﺍﳌﺸﺎﺭ ﺍﻟﻴﻬﺎ ﻓﻲ ﻭﺳﻮﻑ ﻳﻘﺘﺼﺮ ﺍﻟﺘﺎﺟﻴﺮ،  ﺍﻟﻘﻮﺍﻧﲔ ﻭﺍﻟﻠﻮﺍﺋﺢ ﺍﳌﻌﻤﻮﻝ ﺑﻬﺎ ﻓﻲ ﺍﻻﻣﺎﺭﺍﺕ) .ﺑﻮﻟﻴﺼﺔ ﺍﻟﺘﺎﻣﲔ ﺍﳌﻮﺣﺪﺓ (ﺇﺫﺍ ﻛﺎﻥ ﺍﳋﻂ ﺍﻟﺴﺎﺣﻠﻲ ﺍﻗﻞ ﻟﺪﻓﻊ ﺛﻤﻦ ﺗﺼﻠﻴﺢ  ﺍﻟﺴﻴﺎﺭﺍﺕ ﻭﺍﻹﻳﺠﺎﺭ ﳉﻤﻴﻊ ﺗﻠﻚ ﺍﻷﻳﺎﻡ ﺣﺘﻰ ﺗﺎﺗﻲ ﺍﻟﺴﻴﺎﺭﺓ ﺇﻟﻰ ﺍﻟﺪﻭﻟﺔ ﺍﳌﻨﺎﺳﺒﺔ ﺍﻟﺘﻲ ﰎ ﺗﺴﻠﻴﻤﻬﺎ ﺇﻟﻰ ﺍﻹﻳﺠﺎﺭ</p>
   					<p>١٨ﻳﺠﺐ ﻋﻠﻲ ﺍﳌﺴﺘﺎﺟﺮ ﺍﺳﺘﺌﺠﺎﺭ ﺳﻴﺎﺭﺓ ﺃﻣﺮﻳﻜﺎﻥ ﺍﻛﺴﺒﺮﻳﺲ ﳉﻤﻴﻊ ﺍﳌﻄﺎﻟﺒﺎﺕ ﺍﻟﻘﺎﻧﻮﻧﻴﺔ) ﺍﻟﻐﺮﺍﻣﺔ (ﺍﻟﺘﻲ ﻳﺴﺒﺒﻬﺎ ﻟﻪ ﻧﺘﻴﺠﺔ ) ﻻﺳﺘﺨﺪﺍﻡ ﺍﻟﺴﻴﺎﺭﺓ ﺧﻼﻝ ﻓﺘﺮﻩ ﺍﻻﺳﺘﺌﺠﺎﺭ( ﻭﺍﻟﺘﻲ ﻟﻴﺴﺖ ﺍﻟﻐﻼﻑ ﲢﺖ ﺍﻻﺷﺮﺍﻑ ﻋﻠﻲ ﺑﻮﻟﻴﺼﺔ ﺍﻟﺘﺎﻣﲔ</p>
   					<p>١٩ﻭﻳﻘﺮ ﺍﳌﺴﺘﺎﺟﺮ ﺑﺎﻥ ﺟﻤﻴﻊ ﺍﻟﺘﻔﺎﺻﻴﻞ ﺍﻟﻮﺍﺭﺩﺓ ﻓﻲ ﻋﻘﺪ ﺍﻹﻳﺠﺎﺭ ﺻﺤﻴﺤﻪ ﻭﺻﺤﻴﺤﻪ ﻭﻳﻮﺍﻓﻖ ﻋﻠﻲ ﺩﻓﻊ    ﺩﺭﺍﻫﻢ ﻟﻜﻞ ﻣﻌﺒﺮ ﺳﺎﻟﻚ.</p>
					<p>٢٠ﻳﻨﺒﻐﻲ ﻟﻪ ﺍﻥ ﻳﺒﻠﻎ ﺍﳌﻜﺘﺐ ﻗﺒﻞ ﻳﻮﻡ ﻣﻦ ﺗﺎﺭﻳﺦ ﺍﻧﺘﻬﺎﺀ ﻋﻘﺪ ،  ﻭﻓﻲ ﺣﺎﻟﻪ ﺭﻏﺒﻪ ﺍﳌﺴﺘﺎﺟﺮ ﻓﻲ ﲤﺪﻳﺪ ﻓﺘﺮﻩ ﺍﻻﺳﺘﺌﺠﺎﺭ . ﺃﻭ ﺍﻥ ﻳﺒﻠﻎ ﺍﻟﺴﻠﻄﺎﺕ ﺍﳌﻌﻨﻴﺔ ﻋﻦ ﺍﳌﺮﻛﺒﺔ ﺑﺄﻧﻬﺎ ﻣﺴﺮﻭﻗﺔ، ﺍﻹﻳﺠﺎﺭ ﺑﺄﻧﻪ ﻳﺤﻖ ﻟﻪ ﺍﻥ ﻳﺘﺬﻛﺮ ﺍﳌﺮﻛﺒﺔ ﺃﻳﻨﻤﺎ ﻛﺎﻧﺖ</p>
					<p>٢١ﺍﻟﺴﺎﻋﺎﺕ ﺍﻟﺰﺍﺋﺪﺓ :ﻳﺠﺐ ﺍﻥ ﻳﺨﻀﻊ ﺍﺳﺘﺨﺪﺍﻡ ﺍﻟﺴﻴﺎﺭﺓ ﺇﻟﻰ ﻣﺎ ﺑﻌﺪ ﻭﻗﺖ ﺍﻟﻌﻮﺩﺓ ﺍﳌﺘﻔﻖ ﻋﻠﻴﻪ ﳌﻌﺪﻝ ﺍﻟﻐﺮﺍﻣﺔ      ﺩﺭﻫﻤﺎ . ﻭﻻ ﻳﺴﻤﺢ ﺑﺄﻱ ﺟﺰﺀ ﻣﻦ ﺍﻟﻮﻗﺖ ﻟﻠﺘﺎﺟﻴﺮ ﻋﻠﻲ ﻣﺪﺍﺭ      ﺳﺎﻋﺔ ، ﻟﻠﺴﺎﻋﺔ ﺍﻟﻮﺍﺣﺪﺓ ﻭﻗﺪ ﰎ ﻃﻠﺐ ﺍﻟﺘﻤﺪﻳﺪ ﻭﺍﳌﻮﺍﻓﻘﺔ ﻋﻠﻴﻪ</p>
					<p> ٢٢ﺳﻴﻘﻮﻡ ﺍﳌﺴﺘﺎﺟﺮ ﺑﺈﺑﻼﻍ ﺃﻣﺮﻳﻜﺎﻥ ﺍﻛﺴﺒﺮﻳﺲ ﻋﻦ ﺳﺎﺋﻖ ﺇﺿﺎﻓﻲ ﺃﻭ ﻻ ﳝﻜﻦ ﻷﻱ ﺷﺨﺺ ﺁﺧﺮ ﻗﻴﺎﺩﻩ ﺍﻟﺴﻴﺎﺭﺓ ﺇﻟﻰ ﺟﺎﻧﺐ ﺍﻟﺘﻮﻗﻴﻊ ﻋﻠﻲ ﻫﺬﺍ ﺍﻟﻌﻘﺪ .</p>
					<p>٢٣ﺍﳌﺴﺘﺎﺟﺮ ﻟﻦ ﻳﺪﺧﻦ ﺃﻭ ﺍﻟﺴﻤﺎﺡ ﻷﻱ ﺷﺨﺺ ﺁﺧﺮ ﺍﻟﺘﺪﺧﲔ ﻓﻲ ﺍﻟﺴﻴﺎﺭﺓ .ﻓﻲ ﺣﺎﻟﻪ ﻭﺟﻮﺩ ﺭﺍﺋﺤﺔ ﺍﻟﺴﻴﺠﺎﺭ ﺳﻴﺘﻢ ﺗﻐﺮﱘ ﺍﳌﺴﺘﺎﺟﺮ         ﺩﺭﻫﻢ ﻭﺃﻛﺜﺮ ﺍﻋﺘﻤﺎﺩﺍ ﻋﻠﻲ ﺍﻟﻀﺮﺭ.</p>
					<p>	٢١ﻭﺍﻻ ﺳﻴﺘﻢ ﺍﺣﺘﺴﺎﺏ ﺍﻟﻴﻮﻡ ﺍﻹﺿﺎﻓﻲ ﻟﻠﺴﻴﺎﺭﺓ ﺍﳌﺴﺘﺎﺟﺮﻩ، ﺳﻴﺘﻢ ﺇﺭﺟﺎﻉ ﺍﳌﺮﻛﺒﺔ ﻗﺒﻞ ﺍﻟﺴﺎﻋﺔ  </p>
					<p> ٢٥ﻣﺴﺎﺀ ﻓﻲ ﺣﺎﻟﻪ ﻭﺟﻮﺩ ﺣﻤﻠﻪ ﺍﺿﺎﻓﻴﻪ ﺳﻴﻜﻮﻥ ﻫﻨﺎﻙ ﺗﻬﻤﻪ          ﺩﺭﻫﻢ-ﻋﺪﻡ ﺍﻟﻘﻴﺎﻡ ﺑﺬﻟﻚ ﺑﺸﻜﻞ ﺟﻴﺪ ﻳﺘﻢ ﺇﺑﻼﻍ ﺍﻟﺸﺮﻃﺔ ﺳﻴﺘﻢ ﺍﺗﺨﺎﺫ ﺍﻹﺟﺮﺍﺀﺍﺕ ﺍﻟﻘﺎﻧﻮﻧﻴﺔ.</p>
					<p>٢٦ﻟﻦ ﻳﺘﻢ ﺃﻋﺎﺩﻩ ﺗﺎﺟﻴﺮ ﺍﻟﺴﻴﺎﺭﺍﺕ ﻣﻦ ﺃﻣﺮﻳﻜﺎﻥ،  ﻓﻲ ﺣﺎﻟﻪ ﺍﺧﺘﻴﺎﺭ ﺍﳌﺴﺘﺎﺟﺮ ﻟﻺﻟﻐﺎﺀ ﺍﳌﺒﻜﺮ ﺃﻭ ﺇﻧﻬﺎﺀ ﺍﳊﺠﺰ ﺍﻟﻜﺘﺮﻭﻧﻲ ﺍﻛﺴﺒﺮﻳﺲ ﻻﺳﺘﺮﺩﺍﺩ ﺍﻻﻋﺘﻤﺎﺩﺍﺕ ﻭﺍﻷﻳﺎﻡ ﻏﻴﺮ ﺍﳌﺴﺘﺨﺪﻣﺔ.</p>
   					<p>.٢٧ﻳﺘﻢ ﺗﻄﺒﻴﻖ ﺭﺳﻮﻡ ﺍﻟﺘﻨﻈﻴﻒ ﻋﻨﺪﻣﺎ ﻻ ﺗﻌﺎﺩ ﻓﻲ ﻧﻔﺲ ﺍﳊﺎﻟﺔ</p>
   					<p>ذا تعذر تحويل وديعة التأمين إلى البطاقة نفسها ، فيجب على العميل الحضور إلى المكتب لاستلام الشيك.</p>
					<p>Hirer’s Signature
    				</p>
    				</td>
    			</tr>
    		</table>
 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
   