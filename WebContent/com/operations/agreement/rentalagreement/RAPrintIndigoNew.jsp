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
<%--       <table width="100%" >
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="90"  alt=""/></td> 
    <td width="46%" rowspan="2"align="center"><b><font size="3">Rental Agreement</font></b></td>
    <td width="36%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td>
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="4"> عقد ايجار</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label id="lblindigobranchfax" name="lblindigobranchfax"><s:property value="lblindigobranchfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>RANO :</b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b>
     </td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  <tr>
  	<td colspan="3" align="center"><b>Dubai Police : 999&nbsp;&nbsp;&nbsp;Roadside Assistance : 0554013557</b></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
</table> --%>
<table width="100%" style="padding-top:110px;">
	<tr>
		<td width="17%" align="left" style="font-size: 7px"><b>RANO[رقم عقد الايجار] :</td>
		<td style="font-size: 7px"><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>--<b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b></td>
		<td width="25%" style="font-size: 7px"></td>
		<td width="36%" align="left" style="font-size: 7px"><b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b></td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td colspan="2" width="27%" style="font-size: 7px"><b>Lessor[مؤجر](License Name)[اسم الرخصه ]: </b></td><td style="font-size: 7px"><label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
		<td width="8%" style="font-size: 7px">&nbsp;</td>
		<td  width="6.5%" style="font-size: 7px"><b>Branch[فرع]</b>:</td>
		<td style="font-size: 7px"><label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td width="7%" style="font-size: 7px">Tel[هاتف]: </td>
		<td width="9%" style="font-size: 7px"><label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
		<td width="15%" style="font-size: 7px">Branch Mob[جوال الفرع]: </td>
		<td style="font-size: 7px"><label id="lblindigobranchmobile" name="lblindigobranchmobile"><s:property value="lblindigobranchmobile"/></label></td>
		<td width="28%" style="font-size: 7px">&nbsp;</td>
		<td width="16%" style="font-size: 7px">Dubai Police[شرطة دبي] :</td><td style="font-size: 7px" width="20%">999</td>
		<!-- &nbsp;&nbsp;&nbsp;Roadside Assistance[حالة الطوارئ] :</td><td> 0554013557 -->
	</tr>
</table>
<table width="100%">
	<tr>
		<td width="7%" style="font-size: 7px"></td>
		<td width="9%" style="font-size: 7px"></td>
		<td width="15%" style="font-size: 7px"></td>
		<td style="font-size: 7px"></td>
		<td width="33%" style="font-size: 7px">&nbsp;</td>
		<td width="20%" style="font-size: 7px">Roadside Assistance[حالة الطوارئ] :</td><td width="20%" style="font-size: 7px"> 0554013557</td>
	</tr>
</table>
<table width="100%" >
  <tr>
  <td width="50%" style="font-size: 7px">
  <fieldset>
  <table width="100%" style="padding:0px"> 
  <tr>
  	<td width="33%" align="left" style="font-size: 7px">Client ID [رمز المستأجر]  </td>
    <td width="82%" style="font-size: 7px"><label id="lblindigocldocno" name="lblindigocldocno"><s:property value="lblindigocldocno"/></label></td>
    </tr>
  <tr>
      <td width="31%" align="left" style="font-size: 7px">Name [اسم] &nbsp;  </td>
    <td style="font-size: 7px"><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
    <tr>
      <td  align="left" style="font-size: 7px">Nationality [الجنسيه] &nbsp;  </td>
    <td style="font-size: 7px"><label id="lblindigonationality" name="lblindigonationality"><s:property value="lblindigonationality"/></label></td>
    </tr>
      <tr>
    <td  align="left" style="font-size: 7px">Address [عنوان] </td>
    <td height="20px" style="font-size: 7px"><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
   </table>
  <table width="100%" style="padding:0px">
      <tr>
    <td width="33%" align="left" style="font-size: 7px">MOB [جوال]</td>
    <td width="82%" style="font-size: 7px"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td width="30%" align="left" style="font-size: 7px">Email [بريد الاليكترونيه]  </td>
    <td style="font-size: 7px"><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل السائق</b></legend>
    <table  width="100%" style="padding:0px">
   <tr>
      <td width="34.5%" align="left" style="font-size: 7px">Name [اسم]</td>
    <td width="82%" colspan="3" style="font-size: 7px">&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label> &nbsp;&nbsp;اسم السائق</td>
      
    </tr>
    </table>
        <table  width="100%" style="padding:0px">
    <tr>
        <td  width="37%" align="left" style="font-size: 7px">D\L NO [رقم الرخصه القياده]</td>
    <td width="77%" colspan="3" style="font-size: 7px"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td width="34%" align="left" style="font-size: 7px">Exp Date [تاريخ الانتهاء]</td>
    <td width="20%" colspan="3" style="font-size: 7px"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td width="34%" align="left" style="font-size: 7px">Passport NO [رقم الجواز]</td>
    <td colspan="3" style="font-size: 7px"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    </tr>
    <tr>
    <td width="34%" align="left" style="font-size: 7px">Exp Date [تاريخ الانتهاء]</td>
    <td width="18%" style="font-size: 7px"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   

    <td width="27%" align="right" style="font-size: 7px">DOB [تاريخ الميلاد]</td>
    <td width="32%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend><b>Additional Driver Details &nbsp;&nbsp;&nbsp;&nbsp;    تفاصيل السائق الاضافى</b></legend>
    <table  width="100%" style="padding:0px">
<!--    <tr>
      <td width="20%" align="left"></td>
      <td width="40%" align="left" colspan="2">Additional Driver</td>
   </tr> -->
   <tr> 
  	  <td width="38%" align="left" style="font-size: 7px">Name [اسم]</td>
      <td width="18%" style="font-size: 7px"><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
      <td width="30%" style="font-size: 7px">Nationality [الجنسيه]</td>
      <td width="40%" style="font-size: 7px"><label id="lblindigoaddnationality" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td>
    </tr>
    <tr>
      <td width="38%" align="left" style="font-size: 7px">D\L NO [رقم الرخصه القياده]</td>
      <td width="25%" style="font-size: 7px"><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
      <td width="30%" style="font-size: 7px">Mobile [جوال]</td>
      <td width="40%" style="font-size: 7px"><label id="lblindigoaddmobile" name="lblindigoaddmobile"><s:property value="lblindigoaddmobile"/></label></td>
    </tr>
    <tr>
      <td width="" align="left" style="font-size: 7px">Exp Date [تاريخ الانتهاء]</td>
        <td width="" style="font-size: 7px"><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
        <td colspan="2" style="font-size: 7px">Signature [التوقيع]</td>
    </tr>
     <tr>
      <td width="" align="left" style="font-size: 7px">DOB [تاريخ الميلاد]</td>
        <td width="" style="font-size: 7px"><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
    	<td height="25px" colspan="2"><fieldset style="height:100%;"></fieldset></td>
    </tr>
    </table>

</fieldset>

<fieldset style="margin-top:10px;">
	<table style="width:100%;">
		<tr>
			<td>In case the driver age is less than 25 or driving license is less than 3 years old customer will have to pay insurance excess of AED 1500 plus 30% of damages incurred as a result of the accident. In case the vehicle is declared total loss the 30% damage would be considered as 30% of the vehicle value. Vehicle value in such an event would be the purchase value of the vehicle purchased by Lessor.</td>
		</tr>
		<tr>
			<td>Every payment received from the lessor ( from the first payment ) will be charged under the rights of government fines & other expenses of the governement , salik , extra kilometers and damages and or any other penalty incurred during rental period. Once those rights are settled only then the remainder amount would be adjusted against rental amount.</td>
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
  <legend><b style="font-size: 7px">Vehicle&nbsp;&nbsp;&nbsp;&nbsp;   نوع المركبة</b></legend>
     <table width="100%" style="padding:0px" >  
  <tr>
    
    <td width="23%" ><label id="ravehname" name="ravehname" style="font-size: 7px"><s:property value="ravehname"/></label></td>
    <td width="25%"></td>
    <%-- <td width="18%" >YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td> --%>
    <td width="30%" colspan="2" style="font-size: 7px">Color[اللون]&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td width="26%" align="left" style="font-size: 7px">Reg NO[رقم التسجيل]</td>
      <td style="font-size: 7px"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label> &nbsp;&nbsp;رقم المركبة</td>
 
     <td align="left" style="font-size: 7px">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b style="font-size: 7px">Out Details  &nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل خروج السيارة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <th align="left" style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="22%" align="left" style="font-size: 7px">Date [تاريخ]</th>
       <th width="22%" align="left" style="font-size: 7px">Time [وقت]</th>
          <th width="25%" align="left" style="font-size: 7px">Km [كلوميتر]</th>
             <th width="25%" align="left" style="font-size: 7px">Fuel [البيترول]</th>
  </tr>
  <tr>
  <td style="font-size: 7px"><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td> 
<td style="font-size: 7px"><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
<td style="font-size: 7px"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
<td style="font-size: 7px"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
<td style="font-size: 7px"><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
  </tr>
   <tr>
  <td style="font-size: 7px"><b><label id="deldetailss" name="deldetailss"><s:property value="deldetailss"/></label></b></td>
<td style="font-size: 7px"><label id="deldates" name="deldates"><s:property value="deldates"/></label></td>
<td style="font-size: 7px"><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td>
<td style="font-size: 7px"><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td>
<td style="font-size: 7px"><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td>
  </tr>
 </table>
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
     <fieldset><legend><b style="font-size: 7px">Rental Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل الايجار</b></legend>  
      <table  width="100%" style="padding:0px">
      	<%-- <tr>
      		<td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>
      		<td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
      		<td><label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label>
       		<td width="18%" align="right">CDW&nbsp;&nbsp;</td>
       		<td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    	</tr> --%>
    	<tr>
    		<td style="font-size: 7px"><label id="lblindigorenttype" name="lblindigorenttype"><s:property value="lblindigorenttype"/></label>&nbsp;Tariff[سعر]</td>
    		<td style="font-size: 7px"><label id="lblindigorate" name="lblindigorate"><s:property value="lblindigorate"/></label></td>
    		<td style="font-size: 7px">Discount[الخصم]&nbsp;</td>
    		<td style="font-size: 7px"><label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label></td>
    		<td style="font-size: 7px">Net Total[صافي المجموع]</td>
    		<td style="font-size: 7px"><label id="lblindigonettotal" name="lblindigonettotal"><s:property value="lblindigonettotal"/></label></b></td>
    	</tr>
    </table>
    <table  width="100%" style="padding:0px" >
       <tr><td width="15%" style="font-size: 7px">Accessories[مستلزمات]</td><td width="5%" style="font-size: 8px"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%" style="font-size: 7px">Add Driver Charges[قيمة السائق الاضافي] </td><td width="10%" style="font-size: 8px"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%" style="font-size: 7px">KM Limit[حد الكيلوميتر]</td><td width="25%" style="font-size: 8px"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%" style="font-size: 7px">Extra per KM Charge[قيمة الاضافيه كيلوميتر]</td><td width="25%" style="font-size: 8px"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
       <tr><td width=35% style="font-size: 7px">Vehicle Service Due [خدمة السيارة مستحقه]</td><td width="25%" style="font-size: 8px"><label id="rarentserdue" name="rarentserdue"><s:property value="rarentserdue"/></label></td></tr>
  </table>
    </fieldset>
     <fieldset>
    <legend><b style="font-size: 7px">In Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل دخول السيارة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <th align="left" style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left" style="font-size: 7px">Date [تاريخ]</th>
       <th width="20%" align="left" style="font-size: 7px">Time [وقت]</th>
          <th width="22%" align="left" style="font-size: 7px">Km [كلوميتر]</th>
             <th width="19%" align="left" style="font-size: 7px">Fuel [البيترول]</th>
             <th width="19%" align="center" style="font-size: 7px">Signature [التوقيع]</th>
  </tr>
  <tr>
  <td style="font-size: 7px"><b><label id="indetails" name="indetails"><s:property value="indetails"/></label></b></td>
<td style="font-size: 7px"><label id="indate" name="indate"><s:property value="indate"/></label></td>
<td style="font-size: 7px"><label id="intime" name="intime"><s:property value="intime"/></label></td>
<td style="font-size: 7px"><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
<td style="font-size: 7px"><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
  </tr>
   <tr>
  <td style="font-size: 7px"><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
<td style="font-size: 7px"><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
<td style="font-size: 7px"><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
<td style="font-size: 7px"><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
<td style="font-size: 7px"><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
  </tr>
 </table>
  </fieldset>   
  <fieldset><legend><b style="font-size: 8px">Insurance Type [نوع التأمين]</b></legend>
  	<table width="100%" style="padding:0px">
  		<tr>
  			<td  style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Excess AED 1500 + 30% Damage Value</td>
  			<td width="30%" style="font-size: 7px">[مبلغ تحمل التأمين+٣٠٪؜ قيمة الاضر]</td>
  		</tr>
  		<!--  <tr>
  		<td style="font-size: 7px">[مبلغ تحمل التأمين+٣٠٪؜ قيمة الاضر]</td>
  		</tr>  -->
  		<tr>
  			<td width="45%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Insurance Excess 1500</td>
  			
  			<td width="40%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Insurance Excess 2500</td>
  			
  		</tr>
  		
  		 <tr>
  			<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [مبلغ تحمل التامين  1500]</td>
  			<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [مبلغ تحمل التامين  2500]</td>
  		</tr>
  		
  		<tr>
  			<td width="45%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Insurance Excess Zero</td>
  			<td width="35%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Excess2500 + 30%Damage</td>
  		</tr>
  		 <tr>
  			<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[مبلغ تحمل التامين صفر]</td>
  			<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[اضافي2500 + ضرا%30]</td>
  			
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
    		<table width="100%" style="padding:0px">
    			<tr>
    				<td width="50%" style="font-size: 7px">
    					<fieldset><legend><b>Check In</b></legend>
    						<img src="../../../../icons/indigoprintcar.png" style="width:100%;" height="100px"/>
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel[اطار الاحتياطى]&nbsp;&nbsp;
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit[العره]
    					</fieldset>
    				</td>
    				<td width="50%" style="font-size: 7px">
    					<fieldset><legend><b>Check Out</b></legend>
    						<img src="../../../../icons/indigoprintcar.png" style="width:100%;"  height="100px"/>
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel[اطار الاحتياطى]&nbsp;&nbsp;
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit[العره]
    						
    					</fieldset>
    				</td>
    		</table>
    	</td>
    	</tr>
    	<tr>
    	<td style="font-size: 7px">
    		<fieldset>
    		<legend><b>Documents Checklist</b></legend>
    			<table width="100%" style="padding:0px;">
    				<tr>
    					<td width="50%" style="font-size: 7px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Passport & VISA[جواذ و اقامه]</td>
    					<td width="50%" style="font-size: 7px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Emirates ID[هوية الاماراتيه]</td>
    				</tr>
 					<tr>
 						<td width="50%" style="font-size: 7px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Driving License[رخصة القياده]</td>
    					<td width="50%" style="font-size: 7px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Mulkiya Issued[أصدار الملكيه]</td>
 					</tr>   				
    			</table>
    		</fieldset>
    	</td>
    	<td style="height:20px "><fieldset><p style="font-size:7px;">In case of delayed payments rate will be changed to daily shelf rent of the contracted vehicle and all discounts will be removed from the contract. Tyres damages are not covered with insurance and shall be charged separately in case of a damage.</p></fieldset></td>
    	</tr>
    	<tr>
    		<td colspan="2" style="font-size:7px;padding:0px" >
    			<fieldset><legend><b style="font-size: 7px">Terms & Conditions</b></legend>
    				<p style="font-size:7px;padding:0px;margin:0px;">
    					Lesse is not allowed to pay fines directly to relevant authorities. Lessor reserve the right to not wait for the fine settlement and clear its 
    					traffic file without consent of the Lesse. Lesse is entitled to pay charges of AED 300 per black point. Moreover, it is Lessee's responsibility to 
    					ensure that the vehicle is serviced on time. In cases of delayed services the Lessee is responsible to pay AED 500 per extra thousand kilometers. 
    					In case a driver not mentioned on this agreement is caught driving the LESSOR is entitled to impose a penalty of AED 4000 other than state imposed 
    					penalties and or other incurred damages. In case of Additional Driver both Lesse and Additional Driver shall be responsible to abide by all terms 
    					and conditions of this contract. Moreover by signing this document Additional Driver undertakes responsibility against this contract on individual 
    					level. All terms and conditions applicable to the LESSE shall be applicable on additional driver as well. The vehicle Insurance will only be 
    					covered in UAE. Personal Accident Insurance is not covered as part of this agreement. This means any kind of bodily injuries or death of driver 
    					or/and any of the passengers will not be covered. Lessor does not provide this cover and lesse hereby agrees to hire vehicle without this cover. 
    					All contracts opened on monthly terms or transferred to monthly terms in future shall constituite 30 days as one month. I/We hereby agree to the 
    					Terms and Conditions mentioned on both sides of this agreement. I hereby confirm and authorize payment to be made by credit card/charge card. My 
    					signature on this agreement shall constitute authority to debit my nominated card company with all charges related to this transactions, which 
    					includes, but is not limited to, Rental Charges, Insurance Charges, Damage Liability, Salik/Tool Fees, Traffic Fines, Administration Fees, Fuel 
    					Charges, and any charges directly attributable to this rental agreement. I accept that Salik/Toll Fees & Traffic Fines may be debited to my account 
    					EVEN AFTER the contract is closed. All vehicles are monitored by DPS. I acknowledge in the event of accident I will obtain POLICE REPORT. Failure to 
    					do so could result in legal action, and further void all insurances, rendering me liable for all cost incurred by the Lessor. All charges to 
    					transfer security deposit shall be borne by the Lesse.The rental prices mentioned on this agreement are exclusive of any taxes. All applicable taxes levied by the state of UAE shall be applied separately on rental prices, delivery charges, CDW, damage charges, insurance excess, fine service charges, salik service charges and or any other charges incurred as a result of this rental agreement.Tinting on vehicles is strictly not allowed and will result in a penalty of AED 1000
    				</p>
    			</fieldset>	
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<fieldset>
    				<table width="100%" style="padding:0px">
    					<tr>
    						<td width="50%" style="font-size: 7px">Fuel Charges&nbsp;&nbsp;&nbsp;3 per liter</td>
    						<td width="50%" style="font-size: 7px">Fine Service Charges&nbsp;&nbsp;&nbsp;50 AED</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 7px">[قيمة الوقود]&nbsp;&nbsp;&nbsp;</td>
    						<td width="50%" style="font-size: 7px">[قيمة الخدمة المخالفات]&nbsp;&nbsp;&nbsp;</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 7px">Next Service Km</td>
    						<td width="50%" style="font-size: 7px">Salik Charges&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5 AED</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 7px">[خدمة الكيلوميترات القادمه]</td>
    						<td width="50%" style="font-size: 7px">[قيمة السالك]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					
    					</tr>
    				</table>
    			</fieldset>
    		</td>
    		<td><fieldset>
    			<table width="100%" style="padding:0px">
    				<tr>
    					<td width="40%" style="font-size: 7px">Customer Signature[توقيع المستأجر]</td>
    					<td width="">&nbsp;</td>
    					<td width="15%" style="font-size: 7px">Date[تاريخ]</td>
    					<td width="15%" style="font-size: 7px">&nbsp;</td>
    				</tr>
    				<tr>
    					<td style="font-size: 7px">Rental Agent[وكيل الؤجر]</td>
    					<td style="font-size: 7px"><label id="lblindigorentalagent" name="lblindigorentalagent"><s:property value="lblindigorentalagent"/></label></td>
    					<td style="font-size: 7px">Date[تاريخ]</td>
    					<td>&nbsp;</td>
    				</tr>
    			</table>
    		</fieldset>
  </table>
 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
    