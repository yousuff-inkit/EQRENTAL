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
body,html{
/*  margin-top:0;
 padding-top:0; */
 margin:0px;
}

label {
    font: normal 10px ;
}
table {
    border: none;
}
/* td {
    border: none;
} */
 
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
	font-size: 11px;
	 
} 

.Row {
    display: table;
    width: 100%; /*Optional*/
    table-layout: fixed; /*Optional*/
    border-spacing: 10px; /*Optional*/
}
.column {
    display: table-cell;
    
}
.box{
 		
 	  width: 12px;
	  padding: 5px;
	  border: 2px solid gray;
	  margin: 0;
      top:10px;
 }</style> 
<script>
 
 
function gridload(){
	   var indexvals = document.getElementById("docnoval").value;
  
       $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
       if($('#signpath').val()!=''){
    	   $('#imgsignature').attr('src',$('#signpath').val());
    	   $('#imgsignature').css('visibility','visible');
       }
       else{
    	   $('#imgsignature').css('visibility','hidden');
       }
     }  


</script>
</head>
<body onload="gridload();" bgcolor="white" style="font: 9.5px Tahoma " >
<div id="mainBG" class="homeContent" data-type="background">
<div >
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
 <div style="background-color:white;">
<table width="100%" style="margin:0; padding:0;">
<tr>
<td align="left" style="font-size: 11px">
<table width="100%">
<tr><td width="50%" style="font-size: 11px; vertical-align: top;">
<table>
	<tr>
		<td><b>RANO :<label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>--<b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b></td>
	</tr>
	<tr>
		<td><b>Lessor (License Name):</b> <label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
	</tr>
	<tr>
	 <tr><td width="40%" style="font-size: 11px">Address: Abu Baker Al Siddique Rd, Deira, Dubai, UAE</td></tr>
<tr><td width="30%" style="font-size: 11px">Tel:+971 4 235 9339, +971 4 235 9339 Email:info@alqudrahcars.com</td> 
</tr>
<tr><td align="left" style="font-size: 12px; padding-right:15px;"><b><u>www.alqudrahcars.com</u></b></td></tr>
</table>
</td>
<td><img src="<%=contextPath%>/icons/alqudlogo.jpg" width="150" height="90" align="right" alt=""/></td>
</tr>



</table>
</td><br>
</tr> 
</table>

<table width="100%" >
  <tr>
  <td width="50%" style="font-size: 11px">
  <fieldset>
  <table width="100%" style="padding:0px"> 
  <tr>
  	<td width="33%" align="left" style="font-size: 11px">Client ID  </td>
    <td width="82%" style="font-size: 11px"><label id="lblindigocldocno" name="lblindigocldocno"><s:property value="lblindigocldocno"/></label></td>
    </tr>
  <tr>
      <td width="31%" align="left" style="font-size: 11px">Name &nbsp;  </td>
    <td style="font-size: 11px"><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
    <tr>
      <td  align="left" style="font-size: 11px">Nationality  &nbsp;  </td>
    <td style="font-size: 11px"><label id="lblindigonationality" name="lblindigonationality"><s:property value="lblindigonationality"/></label></td>
    </tr>
      <tr>
    <td  align="left" style="font-size: 11px">Address  </td>
    <td height="20px" style="font-size: 11px"><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
  <!--  </table> -->
  <!-- <table width="100%" style="padding:0px"> -->
      <tr>
    <td width="33%" align="left" style="font-size: 11px">MOB </td>
    <td width="82%" style="font-size: 11px"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td width="30%" align="left" style="font-size: 11px">Email   </td>
    <td style="font-size: 11px"><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend style="font-size: 11px"><b>Driver Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل السائق </b></legend>
    <table  width="100%" style="padding:0px">
   <tr>
      <td width="34.5%" align="left" style="font-size: 11px">Name [اسم]</td>
    <td width="82%" colspan="3" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label></td>
      
    </tr>
    </table>
        <table  width="100%" style="padding:0px">
    <tr>
        <td  width="37%" align="left" style="font-size: 11px">D\L NO [رقم الرخصة]</td>
    <td width="77%" colspan="3" style="font-size: 11px"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td width="34%" align="left" style="font-size: 11px">Exp Date [تاريخ الانتهاء]</td>
    <td width="20%" colspan="3" style="font-size: 11px"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td width="34%" align="left" style="font-size: 11px">Passport NO [رقم الجواز]</td>
    <td colspan="3" style="font-size: 11px"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    
    </tr>
    <tr>
    <td width="34%" align="left" style="font-size: 11px">Exp Date [تاريخ الانتهاء]</td>
    <td width="15%" style="font-size: 11px"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   </tr>
   <tr>
   <td width="27%" align="left" style="font-size: 11px">DOB [تاريخ الميلاد]</td>
    <td width="32%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
   
   </tr>
    <tr>
    <td width="34%" align="left" style="font-size: 11px">Emirates ID </td>
    <td width="32%"><label name="lblidno" id="lblidno" ><s:property value="lblidno"/></label></td>
    </tr>
    <tr>
    <td width="34%" align="left" style="font-size: 11px">Emirates Expiry </td>
    <td width="32%"><label name="lblvisaexp" id="lblvisaexp" ><s:property value="lblvisaexp"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend style="font-size: 11px"><b>Additional Driver Details &nbsp;&nbsp;&nbsp;&nbsp;    تفاصيل السائق الاضافى</b></legend>
    <table  width="100%" style="padding:0px">
<!--    <tr>
      <td width="20%" align="left"></td>
      <td width="40%" align="left" colspan="2">Additional Driver</td>
   </tr> -->
   <tr> 
  	  <td width="38%" align="left" style="font-size: 11px">Name [الأسم]</td>
      <td width="18%" style="font-size: 11px"><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
      <td width="30%" style="font-size: 11px">Nationality [الجنسيه]</td>
      <td width="40%" style="font-size: 11px"><label id="lblindigoaddnationality" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td>
    </tr>
    <tr>
      <td width="38%" align="left" style="font-size: 11px">D\L NO [رقم الرخصة]</td>
      <td width="25%" style="font-size: 11px"><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
      <td width="30%" style="font-size: 11px">Mobile [جوال]</td>
      <td width="40%" style="font-size: 11px"><label id="lblindigoaddmobile" name="lblindigoaddmobile"><s:property value="lblindigoaddmobile"/></label></td>
    </tr>
    <tr>
      <td width="" align="left" style="font-size: 11px">Exp Date [تاريخ الانتهاء]</td>
        <td width="" style="font-size: 11px"><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
        <!-- <td colspan="2" style="font-size: 11px">Signature [التوقيع]</td> -->
    </tr>
     <tr>
      <td width="" align="left" style="font-size: 11px">DOB [تاريخ الميلاد]</td>
        <td width="" style="font-size: 11px"><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
    	<!-- <td height="25px" colspan="2"><fieldset style="height:100%;"></fieldset></td> -->
    </tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    
    
  
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
 
  <td width="50%" rowspan="2">
 
  <fieldset style="padding-top: 0px">
  <legend><b style="font-size: 11px">Vehicle Details&nbsp;&nbsp;&nbsp;&nbsp;   تفاصيل المركبة</b></legend>
     <table width="100%" style="padding:0px" >  
  <tr>
    
    <td width="23%" >
    <br><label id="ravehname" name="ravehname" style="font-size: 11px"><s:property value="ravehname"/></label></td>
    <td width="25%"></td>
    <%-- <td width="18%" >YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td> --%>
    <td width="30%" colspan="2" style="font-size: 11px">Color[اللون]&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td width="26%" align="left" style="font-size: 11px">Reg NO[رقم التسجيل]</td>
      <td style="font-size: 11px"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label> &nbsp;&nbsp;</td>
 
<%--      <td align="left" style="font-size: 11px">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td>  --%>
    <td align="left" style="font-size: 11px">Chassis no.&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b style="font-size: 11px">Out Details  &nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل خروج المركبة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <th align="left" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="22%" align="left" style="font-size: 11px">Date [التاريخ]</th>
       <th width="22%" align="left" style="font-size: 11px">Time [الوقت]</th>
          <th width="25%" align="left" style="font-size: 11px">Km &nbsp;&nbsp;&nbsp; [كيلومتر]</th>
             <th width="25%" align="left" style="font-size: 11px">Fuel &nbsp;&nbsp;&nbsp; [الوقود]</th>
  </tr>
  <tr>
  <td style="font-size: 11px"><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td> 
<td style="font-size: 11px"><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
<td style="font-size: 11px"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
<td style="font-size: 11px"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
<td style="font-size: 11px"><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
  </tr>
   <tr>
<%--   <td style="font-size: 11px"><b><label id="deldetailss" name="deldetailss"><s:property value="deldetailss"/></label></b></td> --%>
<%-- <td style="font-size: 11px"><label id="deldates" name="deldates"><s:property value="deldates"/></label></td> --%>
<%-- <td style="font-size: 11px"><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td> --%>
<%-- <td style="font-size: 11px"><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td> --%>
<%-- <td style="font-size: 11px"><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td> --%>
  </tr>
 </table>
  </fieldset>     
  <fieldset>
    <legend><b style="font-size: 11px">Delivery Details &nbsp;&nbsp;&nbsp;&nbsp;تفاصيل تسليم السيارة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <th align="left" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left" style="font-size: 11px">Date [التاريخ]</th>
       <th width="20%" align="left" style="font-size: 11px">Time [الوقت] </th>
          <th width="22%" align="left" style="font-size: 11px">Km [كيلومتر]</th>
             <th width="19%" align="left" style="font-size: 11px">Fuel [الوقود] </th>
             <th width="19%" align="center" style="font-size: 11px">Signature [التوقيع] </th>
  </tr>
  <tr>
  <td style="font-size: 11px"><b>Dliv</b></td>
<td style="font-size: 11px"><label id="deldates" name="deldates"><s:property value="deldates"/></label></td>
<td style="font-size: 11px"><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td>
<td style="font-size: 11px"><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td>
<td style="font-size: 11px"><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td>
  </tr>
<!--    <tr> -->
<%--   <td style="font-size: 11px"><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td> --%>
<%-- <td style="font-size: 11px"><label id="coldates" name="coldates"><s:property value="coldates"/></label></td> --%>
<%-- <td style="font-size: 11px"><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td> --%>
<%-- <td style="font-size: 11px"><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td> --%>
<%-- <td style="font-size: 11px"><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td> --%>
<!--   </tr> -->
 </table>
  </fieldset>    
  <%-- <fieldset>
    <legend><b style="font-size: 11px">In Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل دخول السيارة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <th align="left" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left" style="font-size: 11px">Date </th>
       <th width="20%" align="left" style="font-size: 11px">Time </th>
          <th width="22%" align="left" style="font-size: 11px">Km </th>
             <th width="19%" align="left" style="font-size: 11px">Fuel </th>
             <th width="19%" align="center" style="font-size: 11px">Signature </th>
  </tr>
<!--   <tr> -->
  <td style="font-size: 11px"><b><label id="indetails" name="indetails"><s:property value="indetails"/></label></b></td>
<td style="font-size: 11px"><label id="indate" name="indate"><s:property value="indate"/></label></td>
<td style="font-size: 11px"><label id="intime" name="intime"><s:property value="intime"/></label></td>
<td style="font-size: 11px"><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
<td style="font-size: 11px"><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
<!--   </tr> -->
   <tr>
  <td style="font-size: 11px"><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
<td style="font-size: 11px"><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
<td style="font-size: 11px"><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
<td style="font-size: 11px"><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
<td style="font-size: 11px"><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
  </tr>
 </table>
  </fieldset>       --%>    
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
    <fieldset><legend><b style="font-size: 11px">Insurance Type </b></legend>  
	
	<br>
		<div class="row" align="center">
		 
		<div class="column"><div class="box"> </div></div>  
        <div class="column" style="top=100 px;">1500 AED  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   </div>
    	<div class="column"><div class="box"> </div></div> 
        <div class="column">2000 AED  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    	<div class="column"><div class="box"> </div> </div>
        <div class="column">3500 AED  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
        </div>
    <br>  
      </fieldset>
     <fieldset><legend><b style="font-size: 11px">Rental Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل الايجار</b></legend>  
       <table  width="100%" border="1">
      	<%-- <tr>
      		<td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>
      		<td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
      		<td><label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label>
       		<td width="18%" align="right">CDW&nbsp;&nbsp;</td>
       		<td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    	</tr> --%>
    	<tr>
    		<td style="font-size: 11px"><label id="lblindigorenttype" name="lblindigorenttype"><s:property value="lblindigorenttype"/></label>&nbsp;Tariff[السعر]</td>
    		<td align="right" "font-size: 11px"><label id="lblindigorate" name="lblindigorate"><s:property value="lblindigorate"/></label></td>
    		
    		    	</tr>
       <tr>
       <td style="font-size: 11px">Discount[الخصم]&nbsp;</td>
       <td align="right" style="font-size: 11px"><label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label></td>
       </tr>
  <!--   </table>
    <table  width="100%" style="padding:0px" > -->
       <tr><td style="font-size: 11px">Net Total[صافي المجموع]</td>
    		<td align="right" style="font-size: 11px"><label id="lblindigonettotal" name="lblindigonettotal"><s:property value="lblindigonettotal"/></label></b></td></tr>
       <tr><td width="15%" style="font-size: 11px">CDW[التأمين الممتاز]</td><td width="5%" align="right" style="font-size: 11px"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td></tr>
       <tr><td width="15%" style="font-size: 11px">Accessories[مستلزمات]</td><td width="5%" align="right" style="font-size: 11px"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td></tr>
        <tr><td width="35%" style="font-size: 11px">Add Driver Charges[قيمة السائق الاضافي] </td><td width="10%" align="right" style="font-size: 11px"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
		<tr><td width=35% style="font-size: 11px">Chauffer Charge [سائق خاص]</td><td width="25%" align="right" style="font-size: 11px"><label id="chaffchkvalue" name="chaffchkvalue"><s:property value="chaffchkvalue"/></label></td></tr>
       <tr><td width="15%" style="font-size: 11px">KM Limit[حد الكيلوميتر]</td><td width="25%" align="right" style="font-size: 11px"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td></tr>
       <tr><td width="55%" style="font-size: 11px">Extra per KM Charge[قيمة الاضافيه كيلوميتر]</td><td width="25%" align="right" style="font-size: 11px"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
       
  </table>
    </fieldset>
    
<!--   <fieldset><legend><b style="font-size: 11px">Insurance Type [نوع التأمين]</b></legend>
  	<table width="100%" style="padding:0px">
  		<tr>
  			<td  style="font-size: 11px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Excess AED 2000</td>
  		<tr>
  			<td width="45%" style="font-size: 11px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Excess AED 2000 + 30% Damage Value</td>
  			
  	</table>
  </fieldset> -->

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
<!--         <table width="100%"> -->
<!--     <tr> -->
<!--     <td width="100%"> -->
<%--  <%-- <div id="calcdiv"> --%>
<%--   <jsp:include page="calculationGrid.jsp"></jsp:include></div> --%> 
<!--   <!-- <img src="../../../../icons/indigoprintcar.png" style="width:100%;"/> --> 
<!--   </td> -->
<!--   </tr> -->
<!--   </table>  -->
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
<!--   </td> -->
<!--     </tr> -->
    <!-- <tr>
    	<td colspan="2">
    		<table width="100%" style="padding:0px">
    			<tr>
    				<td width="50%" style="font-size: 11px">
    					<fieldset><legend><b>Check Out</b></legend>
    						<img src="../../../../icons/indigoprintcar.png" style="width:100%;"  height="100px"/>
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel[اطار الاحتياطى]&nbsp;&nbsp;
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit[العره]
    						
    					</fieldset>
    				</td>
    				<td width="50%" style="font-size: 11px">
    					<fieldset><legend><b>Check In</b></legend>
    						<img src="../../../../icons/indigoprintcar.png" style="width:100%;" height="100px"/>
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel[اطار الاحتياطى]&nbsp;&nbsp;
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit[العره]
    					</fieldset>
    				</td>
    		</table>
    	</td>
    	</tr> -->
    	<tr>
    	<td style="font-size: 11px">
    	   <fieldset>
				    <legend><b style="font-size: 11px">In Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل دخول السيارة  </b></legend>  
				       <table style="padding:0px">
				  <tr>
				    <th align="left" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
				    <th width="25%" align="left" style="font-size: 11px">Date [التاريخ] </th>
				       <th width="20%" align="left" style="font-size: 11px">Time [الوقت] </th>
				          <th width="22%" align="left" style="font-size: 11px">Km [كيلومتر] </th>
				             <th width="19%" align="left" style="font-size: 11px">Fuel [الوقود]</th>
				             <th width="19%" align="center" style="font-size: 11px">Signature [التوقيع] </th>
				  </tr>
				<!--   <tr> -->
				<%--   <td style="font-size: 11px"><b><label id="indetails" name="indetails"><s:property value="indetails"/></label></b></td> --%>
				<%-- <td style="font-size: 11px"><label id="indate" name="indate"><s:property value="indate"/></label></td> --%>
				<%-- <td style="font-size: 11px"><label id="intime" name="intime"><s:property value="intime"/></label></td> --%>
				<%-- <td style="font-size: 11px"><label id="inkm" name="inkm"><s:property value="inkm"/></label></td> --%>
				<%-- <td style="font-size: 11px"><label id="infuel" name="infuel"><s:property value="infuel"/></label></td> --%>
				<!--   </tr> -->
				   <tr>
				  <td style="font-size: 11px"><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
				<td style="font-size: 11px"><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
				<td style="font-size: 11px"><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
				<td style="font-size: 11px"><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
				<td style="font-size: 11px"><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
				  </tr>
				 </table>
		  </fieldset>     
    	
    		<!-- <fieldset>
    		<legend><b>Documents Checklist</b></legend>
    			<table width="100%" style="padding:0px;">
    				<tr>
    					<td width="50%" style="font-size: 11px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Passport & VISA[جواذ و اقامه]</td>
    					<td width="50%" style="font-size: 11px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Emirates ID[هوية الاماراتيه]</td>
    				</tr>
 					<tr>
 						<td width="50%" style="font-size: 11px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Driving License[رخصة القياده]</td>
    					<td width="50%" style="font-size: 11px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Mulkiya Issued[أصدار الملكيه]</td>
 					</tr>   				
    			</table>
    		</fieldset> -->
    	</td>
    	
    		<!-- <td>
    			<fieldset>
    				<table width="100%" style="padding:0px">
    					<tr>
    						<td width="50%" style="font-size: 11px">Fuel Charges&nbsp;&nbsp;&nbsp;2.72 per liter</td>
    						<td width="50%" style="font-size: 11px">Fine Service Charges&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10%</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 11px">[قيمة الوقود]&nbsp;&nbsp;&nbsp;</td>
    						<td width="50%" style="font-size: 11px">[قيمة الخدمة المخالفات]&nbsp;&nbsp;&nbsp;</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 11px">Next Service Km</td>
    						<td width="50%" style="font-size: 11px">Salik Charges&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5 AED</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 11px">[خدمة الكيلوميترات القادمه]</td>
    						<td width="50%" style="font-size: 11px">[قيمة السالك]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					
    					</tr>
    				</table>
    			</fieldset>
    		</td> -->
    	</tr>
    	<!-- <tr>
    		<td colspan="2" style="font-size: 7px;padding:0px" >
    			<fieldset style="padding-left:7px;"><legend><b style="font-size: 11px">Terms & Conditions</b></legend>

						<p style="font-size: 9px; line-height: 2px;"> *  In case of delayed payments the Lessor has the right to terminate the contract and deactivate the engine of the car.</p>
						<p style="font-size: 9px; line-height: 2px;"> * All Contracts opened on monthly terms or transferred to monthly terms in future shall constitute 30 DAYS as one month.</p>
						<p style="font-size: 9px; line-height: 2px;"> * Lessee is not allowed to pay fines directly to relevant authorities without consent of the Lessor. Lessee is entitled to pay AED 300 per BLACK POINT FINES paid by the Lessor in addition  </p>
						<p style="font-size: 9px; line-height: 2px;">&nbsp;&nbsp;&nbsp;to the fines amount.</p>
						
						<p style="font-size: 9px; line-height: 2px;"> * Lessee is responsible to ensure that the vehicle is serviced on time, in case of delayed services, Lessee will penalised by AED 500 per extra 1000 kms.</p>
						<p style="font-size: 9px; line-height: 2px;"> * In event of accident Lesse must inform Lessor immediately and obtain POLICE REPORT.</p>
						<p style="font-size: 9px; line-height: 2px;"> * Tyres are not covered by insurance and shall charged separately in case of damage.</p>
						<p style="font-size: 9px; line-height: 2px;"> * Security Deposit wii be refundble after 30 days from the date of OFFHIRE.</p>	
						<p style="font-size: 9px; line-height: 2px;"> * I accept that SALIK(toll fees) & Traffic fines may be debited from my nominated card or to be deducted from my deposit EVEN contract is closed provided that it's attribute within    </p>
						<p style="font-size: 9px; line-height: 2px;">&nbsp;&nbsp;&nbsp; the time frame of my rental agreement.</p>
						<p style="font-size: 9px; line-height: 2px;"> *  ________________________________________________________________________________________________________________________</p>
						<p style="font-size: 9px; line-height: 2px;"> *  ________________________________________________________________________________________________________________________</p>		
    			</fieldset>	
    		</td>
    	</tr> -->
    	<!-- <tr>
    		<td>
    			<fieldset>
    				<table width="100%" style="padding:0px">
    					<tr>
    					<td style="font-size: 11px">Rental Agent Signature</td>
    					<td style="font-size: 11px"></td>
    					<td style="font-size: 11px">Date</td>
    					<td>&nbsp;</td>
    				</tr>	
    			
    				</table><br>	
    			</fieldset>
    		</td>
    		<td><fieldset>
    			<table width="100%" style="padding:0px">
    				<tr>
    					<td width="40%" style="font-size: 11px">Customer Signature</td>
    					<td width="">&nbsp;</td>
    					<td width="15%" style="font-size: 11px">Date</td>
    					<td width="15%" style="font-size: 11px">&nbsp;</td>
    				</tr>
    			
    			</table><br>
    		</fieldset></td></tr> -->
    		
  </table>
 
<table width="100%" border="1">
<tr><td width="20%" style="font-size: 9px;">
<table width="100%" border="0">
<tr bgcolor="green">
<td align="top" width="20%" style="font-size: 9px;">
<table><tr>
<td width="40%">Credit Card Deducting </td>
<td width="60%" align="right"> اتفاقية السحب من بطاقة الائتمان
</td>
</tr></table></td>
</tr>
<tr>
<td style="font-size: 9px;">I’m authorizing Al Qudrah Car Rental to charge 
any monetary dues on my credit card such as 
rental payments, traffic violation tickets. And or any additional charges that had resulted damages to the rented vehicle </td></tr>
<tr><td style="font-size: 9px;">
أنا أفوض شركة القدرة لتاجير السيارات بالسحب من بطاقة الائتمان الخاصة بي جميع مبالغ الايجار بالاضافة الى المبالغ المترتبة على أي حادث أو مخالفة (  مرورية ، بلدية ...إلخ )  أو مبالغ التعويض عن أي أضرار تحدث للسيارة 
 
 </td>
</tr>
<tr><td>
<table width="100%" border="1">
<tr><td width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td><td  width="5.9%"><br><br></td></tr>
</table>
</td></tr>
<tr><td>
<table width="100%">
<tr><td >
Expiry Date:....................</td>
<td rowspan="2"><fieldset>Signed<br><br><br><br></fieldset></td></tr>
<tr><td >Name:...........................</td></tr>
</table>
</td></tr>
</table>
</td>
<td width="15%" style="font-size: 9px;"><table><tr><td>*If you do not have a prior  
agreement to rent weekly or
monthly rate will be calculated daily 
price. </td></tr>
<tr><td><br>
*In the event of an accident and the
tenant emitter of the incident will 
be obliged to pay an amount of ( 
)      AED rent plus the number of 
days the car stays in the garage for 
repair and if it effected only pays 
rent the car number of days of stay 
in the garage.</td></tr>
<tr><td> <br>
*Tenant pays for each violation 
receives 60 AED :  10  AED to 
knowledge  +10 AED innovation  
+40AED pay objectionable wages. 
</td></tr>
<tr><td><br>
*Rental period is a minimum of two 
days(2). <br><br></td></tr></table></td>
<td width="15%" style="font-size: 9px;"><table>
<tr><td align="right">إذا لم يكن هناك اتفاق مسبق للإيجار الاسبوعي او الشهري فسوف يحسب بواقع السعر اليومي. </td></tr>
<tr><td align="right"><br>
في حال حدوث حادث وكان المستأجر متسبب بالحادث يكون ملزم بدفع مبلغ وقدره (          ) درهم بالإضافة الى قيمة إيجار عدد ايام بقاء السيارة في الكراج للتصليح وإذا كان متضرر يدفع فقط ايجار عدد ايام بقاء السيارة في الكراج.</td></tr>
<tr><td align="right"> <br>
في حال حدوث حادث وكان المستأجر متسبب بالحادث يكون ملزم بدفع مبلغ وقدره (          ) درهم بالإضافة الى قيمة إيجار عدد ايام بقاء السيارة في الكراج للتصليح وإذا كان متضرر يدفع فقط ايجار عدد ايام بقاء السيارة في الكراج.
</td></tr>
<tr><td align="right"><br>
أقل فترة ايجار يومين. <br><br></td></tr></table></td> </tr>
<!-- <tr>
<td width="100%">

<tr><td style="width:50%;font-size:6px;">
  <img src="../../../../icons/qodprint2.jpg" style="height:260px;;width:100%;" />
  </td></tr> -->
</table><br>
<table width="100%" style="padding:0px">
    <tr><td colspan="3" style="font-size: 9px;" align="center">
    أنا / نحن نقر بأننا اطلعنا على هذه الاتفاقية والشروط والبنود المدونة من أمام وخلف الاتفاقية ونوافق عليها ولأجله وقعنا</td></tr>
<tr><td colspan="3" align="center">I/We acknowledge that the terms and conditions are read and understood as to we agree with it </td></tr>
<tr><td colspan="3" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;and we signed without objections </td></tr>
<tr></tr>
<tr >
<td width="33%" align="center" style="font-size: 9px;">Sales Agent Signature توقيع محرر العقد   
</td>
<td width="33%" align="center" style="font-size: 9px;">Hirer\Driver Signature  توقيع المستأجر/السائق
</td>
<td width="33%" align="center">Sponser Signature  توقيع الكفيل</td></tr>
<tr><td> </td></tr>
<tr>
<td width="33%" align="center" ><table width="60%" border="1">
<tr><td><br><br><br><br><br><br></td></tr>
</table></td>
<td width="33%" align="center" ><table width="60%" border="1">
<tr><td><br><img src="" style="height:60px;width:60px;" id="imgsignature"/>
<input type="hidden" name="signpath" id="signpath" value='<s:property value="signpath"/>' ></td></tr>
</table></td>

<td  width="33%" align="center" ><table width="60%" border="1">
<tr><td><br><br><br><br><br><br></td></tr>
</table></td></tr>

</table>		
  <DIV style="page-break-after:always"></DIV>
  <!-- <table width="100%" style="padding:0px">
  <tr><td width="100%"><fieldset>
    		<table width="100%">
<tr>
<td width="100%">

<p align="justify"><b><u>Terms and Conditions.</u></b></p></td></tr>
<tr><td style="width:50%;font-size:6px;"> -->

  <img src="../../../../icons/kudraimg.jpg" style="height:100vh;width:100%;margin:0;"  />
 <!--  </td></tr>
</table><br>
    		</fieldset></td></tr>
    		</table> -->
 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />

<!-- <DIV style="page-break-after:always"></DIV>   -->
<h3 align="center">VEHICLE CHECK LIST</h3>
<table align="center" width="100%">
<tr>     
<td width="17%"><input type="checkbox" id="rentchk">Rent out</td><td width="17%"><input type="checkbox" id="retchk">Return</td><td width="17%"><input type="checkbox" id="repchk">REPLACEMENT</td><td width="17%"><input type="checkbox" id="serchk">SERVICE</td><td width="17%"><input type="checkbox" id="accchk">ACCIDENT</td>
<td colspan="3" align="right" width="35%">Agreement No:&nbsp;<label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></td>
</tr>    
<tr><td align="left" style="font-size: 9px;" colspan="2">Vehicle Reg No:&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
<td></td>
<td align="left" colspan="2">Model:&nbsp;<label id="ravehname" name="ravehname" style="font-size: 11px"><s:property value="ravehname"/></label></td>
<td align="right" colspan="3">Year:&nbsp;<label id="rayear" name="rayear"><s:property value="rayear"/></label></td></tr>
</table>
<!-- <img src="../../../../icons/qudrainspect.jpg" style="height:100%;width:100%;" /> -->
<table width="80%" style="padding:0px">
<tr><td width="100%"><table  width="90%" border="1" >
<tr><td width="20%" style="font-size: 9px;">&nbsp;&nbsp;&nbsp;VEHICLE OUT</td><td align="center" style="font-size: 9px;">X</td><td width="10%" style="font-size: 7px;">&nbsp;&nbsp;SCRATCHES</td><td align="center" style="font-size: 9px;">*</td><td width="10%"  style="font-size: 7px;">&nbsp;&nbsp;DENT/BROKEN</td><td align="center" style="font-size: 20px;">.</td><td width="10%"  style="font-size: 7px;">&nbsp;&nbsp;&nbsp;&nbsp;DOTS</td><td align="center" style="font-size: 20px;">-</td><td style="font-size: 7px;">&nbsp;&nbsp;LINES&nbsp;&nbsp;&nbsp;&nbsp;(DAMAGE MARKS)</td></tr>
</table></td></tr>
</table>
<table width="100%" style="padding:0px" >
<tr>
<td width="50%"><img src="../../../../icons/carout.png" style="height:100%;width:100%;" /></td>
<td width="50%">
<table width="100%" style="padding:0px">
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">ORG REG CARD</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Hazard Triangle</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Interior Clean</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Windows and Mirrors</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Wheel Caps</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Ac Cooling</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Spare Tyre</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Wiper & Wiper Blade</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Tool Kit</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">No Alert Lamps</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Fire Extinguisher</td><td width="50%" colspan="2"></td></tr></table>
<table width="100%"><tr><td width="8%" style="font-size: 9px;">DATE</td><td width="10%"><input type="text" id="txtdate"/></td><td width="8%" style="font-size: 9px;">TIME</td><td  width="10%"><input type="text" id="txttime"/></td></tr>    
<tr><td width="8%" style="font-size: 9px;" >KMS</td><td width="92%"><input type="text" id="txkm"/></td></tr>   
<tr><td  width="8%" style="font-size: 9px;">Fuel</td><td><table width="100%" style="padding:0px"><tr><td><table width="30%" style="padding:0px" border="1"><tr><td>1</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>2</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>3</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>4</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>5</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>6</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>7</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>8</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>9</td></tr></table></td></tr></table> </td></tr>
</table></td>   
</tr>
<tr><td></td><td width="30%">CHECK OUT LOCATION......................................</td></tr>
</table>
<table width="80%" style="padding:0px">
<tr><td width="100%"><table   width="90%" border="1" >
<tr><td width="20%" style="font-size: 9px;">&nbsp;&nbsp;&nbsp;VEHICLE IN</td><td align="center" style="font-size: 9px;">X</td><td width="10%" style="font-size: 7px;">&nbsp;&nbsp;SCRATCHES</td><td align="center" style="font-size: 9px;">*</td><td width="10%"  style="font-size: 7px;">&nbsp;&nbsp;DENT/BROKEN</td><td align="center" style="font-size: 20px;">.</td><td width="10%"  style="font-size: 7px;">&nbsp;&nbsp;&nbsp;&nbsp;DOTS</td><td align="center" style="font-size: 20px;">-</td><td style="font-size: 7px;">&nbsp;&nbsp;LINES&nbsp;&nbsp;&nbsp;&nbsp;(DAMAGE MARKS)</td></tr>
</table></td></tr>
</table>
<table width="100%" style="padding:0px" >
<tr>
<td width="50%"><img src="../../../../icons/carout.png" style="height:100%;width:100%;" /></td>
<td width="50%">
<table width="100%" style="padding:0px">
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">ORG REG CARD</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Hazard Triangle</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Interior Clean</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Windows and Mirrors</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Wheel Caps</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Ac Cooling</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Spare Tyre</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Wiper & Wiper Blade</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Tool Kit</td><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">No Alert Lamps</td></tr>
<tr><td width="5%"><table width="30%" style="padding:0px" border="1"><tr><td>&nbsp;&nbsp;</td></tr></table></td><td width="20%" style="font-size: 9px;">Fire Extinguisher</td><td width="50%" colspan="2"></td></tr></table>
<table width="100%"><tr><td width="8%" style="font-size: 9px;">DATE</td><td width="10%"><input type="text" id="txtdate"/></td><td width="8%" style="font-size: 9px;">TIME</td><td  width="10%"><input type="text" id="txttime"/></td></tr>    
<tr><td width="8%" style="font-size: 9px;" >KMS</td><td width="92%"><input type="text" id="txkm"/></td></tr>   
<tr><td  width="8%" style="font-size: 9px;">Fuel</td><td><table width="100%" style="padding:0px"><tr><td><table width="30%" style="padding:0px" border="1"><tr><td>1</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>2</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>3</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>4</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>5</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>6</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>7</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>8</td></tr></table></td><td><table width="30%" style="padding:0px" border="1"><tr><td>9</td></tr></table></td></tr></table> </td></tr>
</table></td>
</tr>
<tr><td></td><td width="30%">CHECK OUT LOCATION......................................</td></tr>
<tr></tr>
<tr></tr>
<tr></tr>
</table>
<table align="center" width="100%" style="padding:0px" border="1" >
<tr><td  width="50%">
<table width="100%" style="padding:0px" >
<tr><td style="font-size: 9px;">INTERIOR DEFECTS</td></tr>
<tr><td style="font-size: 6px;">BEFORE SIGNING AND PRIOR TO USING VEHICLE IT IS IMPERATIVE THAT YOU NOTIFY QUDRA CAR RENTAL OF ANY ADDITIONAL DAMAGE NOTICED OTHER THAN WHAT HAS ALREADY MARKED ABOVE.</td></tr>
<tr><td></td></tr>
<tr><td></td></tr>
<tr><td></td></tr>
<tr><td></td></tr>
<tr><td width="50%" style="font-size: 6px;">DRIVER'S NAME...................................<br><br></td><td width="50%" style="font-size: 6px;">SIGNATURE...................................<br><br></td></tr>
<tr><td style="font-size: 6px;">CUSTOMER NAME............................................</td><td width="50%" style="font-size: 6px;">SIGNATURE...................................</td></tr>

</table>

</td>

<td  width="50%">
<table width="100%" style="padding:0px" >
<tr><td style="font-size: 9px;">INTERIOR DEFECTS</td></tr>
<tr><td style="font-size: 6px;">BEFORE SIGNING THE VEHICLE CHECKLIST IT IS IMPERATIVE THAT YOU NOTICE QUDRA CAR RENTAL OF ANY ADDITIONAL DAMAGE OTHER THAN THE VEHICLE CHECKOUT ANY CHARGES IN RELATION TO THE (DAMAGES) TO BE CHECKED IN VEHICLE WILL BE NOTIFIED TO YOU BY QUDRA CAR RENTAL ACCOUNTS WITHIN 3 WORKING DAYS OF CHECKIN.</td></tr>
<tr><td width="50%" style="font-size: 6px;">DRIVER'S NAME..................................<br><br></td><td width="50%" style="font-size: 6px;">SIGNATURE...................................<br><br></td></tr>
<tr><td style="font-size: 6px;">CUSTOMER NAME............................................</td><td width="50%" style="font-size: 6px;">SIGNATURE...................................</td></tr>

</table>

</td></tr>
</table>
</form>
</div>
</div>
</body>
</html>
    