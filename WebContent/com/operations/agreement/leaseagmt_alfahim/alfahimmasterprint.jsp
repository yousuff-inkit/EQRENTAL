﻿<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
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
  /* fieldSet
    {
        
    
        border-width: 1px; border-color: rgb(225,224,223);
       
        margin:0;
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

</style> 
<script>
 
function gridload(){
	   var indexvals = document.getElementById("docnoval").value;
  
       $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
       
     }  


</script>
</head>
<body onload="gridload();" bgcolor="white" style="font: 10px Tahoma " >
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
<form id="frmPrintlease" action="printleaseone" autocomplete="off" target="_blank">
 <div style="background-color:white;">
<%--   <table width="100%" >
    <tr>
      <td width="23%" rowspan="4"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="79"  alt=""/></td>
      <td width="45%"><b><font size="5PX">Lease Agreement</font></b></td>
      <tr>
      </table> --%>
      <table width="100%" >
  <tr>
  
    <td width="24" rowspan="6" ><img src="<%=contextPath%>/icons/epic.jpg" width="200" height="70"  alt=""/></td> 
    <td width="50%" rowspan="2">&nbsp;</td>
    <td width="26%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td>
 
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
     <!-- <td  align="center"><b><font size="4">عقد الإيجار</font></b></td>
    <td   align="center"><b><font size="4">Lease Agreement </font></b></td> -->
    <td   align="center"><b><font size="4">عقد الإيجار</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></td>
  </tr>
  <tr>
  <td   align="center"><b><font size="4">Lease Agreement </font></b></td>
    <td align="left"><b>Fax :</b>&nbsp;<label id="fax" name="fax"><s:property value="fax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>LANO :</b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b>LA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b>
     </td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
</table>
  <%-- <table width="100%" >
    <tr>
      <td width="30%"><b>Branch :</b><label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
   <td align="center">&nbsp;&nbsp;&nbsp;<b>LANO :</b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></td>
    
     <td align="center"><b>LA :</b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b></td>
    </tr>
  </table> --%>
<!-- <hr noshade size=1 > -->
<table width="100%" >
  <tr>
  <td width="50%">
  <fieldset><legend><b>Lessee Details تفاصيل المستأجر</b></legend>
  <table width="100%" > 
  <tr>
      <td width="20%" align="left" >Name&nbsp;&nbsp; الاسم  </td><td></td>
    <td width="80%" ><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
      <tr>
    <td  align="left"> Address&nbsp;العنوان </td><td></td>
    <td height="40px" ><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
    <tr></tr>
   </table>
  <table width="100%" >
      <tr>
    <td width="30%" align="left">MOB&nbsp; هاتف متحرك </td>
    <td width="70%"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td  align="left"> Email&nbsp; البريد الإلكتروني   </td>
    <td ><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details&nbsp;&nbsp;&nbsp; بيانات السائق</b></legend>
    <table  width="100%" >
   <tr>
      <td width="20%" align="left">Name &nbsp; الاسم</td>
    <td width="80%" colspan="3">&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label></td>
      
    </tr>
    </table>
        <table  width="100%"  >
    <tr>
        <td  width="40%" align="left">D\L NO&nbsp; رقم رخصة القيادة </b></td>
    <td width="60%" colspan="3"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td width="22%" align="left">Exp Date &nbsp;&nbsp; تاريخ الانتهاء	</td>
    <td width="20%" colspan="3"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td align="left">Passport NO &nbsp;&nbsp;رقم جواز السفر </td>
    <td colspan="3"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    </tr>
    <tr>
     <td align="left">Emirates ID &nbsp;&nbsp;الهوية الإماراتية </td>
    <td colspan="3"> <label name="drvemiratesid" id="drvemiratesid" ><s:property value="drvemiratesid"/></label></td>
    </tr>
    <tr>
    <td width="20%" align="left">Exp Date&nbsp;&nbsp; تاريخ الانتهاء 	</td>
    <td width="30%"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   </tr>
   <tr>

    <td width="20%" align="left">DOB&nbsp;&nbsp;&nbsp; تاريخ الميلاد</td>
    <td width="25%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend><b>Additional Driver Details  &nbsp;&nbsp;بياناتالسائقالإضافي</b></legend>
    <table  width="100%"   >
   <tr>
      <td width="25%" align="left"></td>
          <td width="37%" align="right"><b>بيانات السائق الإضافي الأول<br>Additional Driver One</b></td>
    
     <td width="38%" align="right"><b>بيانات السائق الإضافي الثاني<br>Additional Driver Two</b></td>
   
    </tr>
     <tr> 
      <td width="" align="left">الاسم&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name</td>  
        <td width="" ><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
   
      <td width="" ><label id="adddrname2" name="adddrname2"><s:property value="adddrname2"/></label></td>
   
    </tr>
      <tr>
      <td width="" align="left">رقم رخصة القيادة &nbsp; D\L NO</td>
        <td width="" ><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
   
      <td width="" ><label id="addlicno2" name="addlicno2"><s:property value="addlicno2"/></label></td>
   
    </tr>
    <tr>
      <td width="" align="left">تاريخ الانتهاء	&nbsp; &nbsp;&nbsp;Exp Date</td>
        <td width="" ><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
   
      <td width="" ><label id="expdate2" name="expdate2"><s:property value="expdate2"/></label></td>
   
    </tr>
     <tr>
      <td width="" align="left">تاريخ الميلاد&nbsp;&nbsp; &nbsp;&nbsp;DOB&nbsp;&nbsp;</td>
        <td width="" ><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
   
      <td width="" ><label id="adddob2" name="adddob2"><s:property value="adddob2"/></label></td>
   
    </tr>
    </table>

</fieldset>
<table width="100%" style="font-size: 8.4px" ><tr>
 <td   width="100%">
 <fieldset>

<legend></legend>

<p align="right">
<b>الحوادث</b><br>
بالتوقيع على الوثيقة الماثلة، أفهم أنه في حالة حدوث حادثة – حتى في حالة الاستفادة من تأمين الإعفاء من الأضرار في حالة التصادم، فيجب أن تكون مصحوبة بتقرير ساري من الشرطة، وفي حالة عدم الإعفاء من الأضرار في حالة التصادم، سألتزم بدفع مبلغ وقدره  
</p>


<table width="100%"  >
<tr><td  width="40%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table>
<b>Accidents</b><br>
By initialing, I understand that in case of accident, even though availed CDW, must be accompanied by a valid police report. If without CDW, I will be liable to pay excess deductible amount of  AED.<label   id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> <!-- amount in extra insurance charge. -->

</fieldset>
</td>
</tr>
<tr>
<td width="100%">
 <fieldset >
<legend></legend>

<span>
المرور/ مواقف السيارات/ سالك (الرسوم)
بالتوقيع على الوثيقة الماثلة، أكون موافقاً على دفع جميع غرامات المرور/المواقف وغيرها بالإضافة إلى مبلغ وقدره <label   id="trafficcharge"><s:property value="trafficcharge"/></label> درهم إماراتي لكل غرامة و<label id="salikcharge"><s:property value="salikcharge"/></label> درهم لكل معبر سالك كرسوم إضافية، خلال فترة الاتفاق
</span>
<table width="100%" >
<tr><td  width="40%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table>
<b>Traffic/Parking Fines/Salik (Toll)</b><br>
<p style="font_size:1px;">By initialing, I agree to pay all traffic/parking/other fines plus AED. </p> <!-- .25/- --><label   id="trafficcharge"><s:property value="trafficcharge"/></label>/-per fine and plus AED.<label id="salikcharge"><s:property value="salikcharge"/></label> /- per Salik crossing  as surcharge, occurring during the agreement period. 
  
</fieldset>

 </td>
 </tr>
 
  </tr>
 <tr>
<td>
<b>VEHICLE INSURED FOR UAE TERRITORY ONLY</b>
</td>
</tr>
<tr>
<td>


</td>
</TR>
 <tr>
 <td>
 <fieldset>
 <legend></legend><p align="right">
 .المبالغ الواردة أعلاه لا تشمل ضريبة القيمة المضافة<br/>
 سيتم تطبيق ضريبة القيمة المضافة  وفقا لدولة الإمارات العربية المتحدة على <br/>
.المبالغ المشار إليها في هذه الاتفاقية وستظهر الضريبة السارية في الفاتورة الصادرة 
 </p><br/>
 The above Amounts are exclusive of VAT.<br/>
VAT according to the UAE law will be applied to the amounts indicated in this agreement and will be reflected in the valid tax invoice
 

 </fieldset>
 </td>
 </tr>
 
<tr>
 <td>
 <!-- <fieldset width="100%">
<legend><b>Salik (Road tolls)</b></legend>
 By putting your initial in the box provided below you agree to pay salik charges of 4 Dhs for each crossing and 1 Dhs admin fee.
Total 5 Dhs per crossing.These charges will be added to the end of the rental, or as and when we are notified by the RTA.
<table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table>
</fieldset> -->
 </td></tr>
 </table>
 &nbsp;
 <table width="100%">


</table>

  </td>
  <td width="50%">
  <fieldset>
  <legend><b> Leased Vehicle&nbsp;&nbsp;&nbsp;&nbsp; المركبة المستأجرة</b></legend>
   <table width="100%"  >  
  <tr>
    
    <td width="52%" ><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <td width="18%" >YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td>
    <td width="30%">Color&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
   
   <!--  </table>
      <table width="100%">  -->
      <tr>
      <td align="left">Reg NO&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
 
     <td align="left" colspan="2">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
     <td width="10%" align="left">Chassis No</td><td width="25%">
      <label id="vehdet_chasisno" name="vehdet_chasisno"><s:property value="vehdet_chasisno"/></label></td>
      
    </table>
    </fieldset>
    <fieldset>
    <legend><b> Out Details &nbsp;&nbsp;بيانات الخروج</b></legend>
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
    <tr>
    <td width="10%" align="left">Due Date</td><td width="25%">
      <label id="outdet_duedate" name="outdet_duedate"><s:property value="outdet_duedate"/></label></td>
      
       
    </tr>
    </table>
    </fieldset>
 
    <%-- <fieldset>
    <legend><b>KM Allowed</b></legend>
    <!--    <table width="100%">
      <tr> -->
      <!-- <td width="30%" align="left" >KM ALLOWED</td> -->
    <!--   <td width="70%"> -->
      <table  width="100%" >
      <tr>
            <td width="35%" align="center">DAILY</td>
                <td width="35%" align="center">WEEKLY</td>
                    <td width="35%" align="center">MONTHLY</td> 
        </tr>
       <tr> 
    <td width="35%" align="center"><label id="radaily" name="radaily"><s:property value="radaily"/></label></td>
    <td width="35%" align="center"><label id="raweakly" name="raweakly"><s:property value="raweakly"/></label></td>
    <td width="35%" align="center"><label id="ramonthly" name="ramonthly"><s:property value="ramonthly"/></label></td>
      </tr>
      </table>
     <!--  </td>
      </tr> -->
      <!-- </table> -->
      </fieldset> --%>
       <fieldset><legend><b>Rental Rates&nbsp;&nbsp;&nbsp;سعر الإيجار &nbsp;</b></legend>  
      <table  width="100%" >
      <tr>
      <td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff/Month</td>   <td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
       <td width="18%" align="right">CDW&nbsp;&nbsp;</td>   <td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    </tr>
    </table>
     
    <table  width="100%"  >
       <tr><td width="15%">Accessories</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
                        

       <tr><td width="15%">Mileage Allowance</td><td width="25%"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%">Extra KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
  </table>
    </fieldset>
   <fieldset><legend><b> Closing Details&nbsp;&nbsp;&nbsp;تفاصيل الإغلاق</b></legend> 
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
     </fieldset>
        <table width="100%">
    <tr>
    <td width="100%">
<%--  <div id="calcdiv">
  <jsp:include page="calculationGrid.jsp"></jsp:include></div> --%>
  </td>
  </tr>
  </table> 
   <fieldset width="100%">
   
    
     <table  width="100%"   >
          
          <tr><td align="right">أقر باستلام السيارة المنصوص عليها في العقد بالشروط المنصوص عليها في تقرير فحص المركبة، وأوافق على دفع جميع تكاليف الإيجار الخاصة بهذه السيارة طالما كانت في حيازتي كما أوافق على الإصلاحات التي لا تغطيها وثيقة التأمين بالإضافة إلى الأجزاء أو قطع الغيار الناقصة. ويمثل توقيعي على عقد الإيجار هذا موافقتي على تسديد ديون بطاقتي الائتمانية بالمبالغ المستحقة بموجب هذا العقد. وقد قرأت بعناية شديدة وفهمت ووافقت على جميع أحكام وشروط هذا العقد. وإذا كانت السيارة محتجزة من قبل الشرطة بسبب المخالفات المرورية أكون مسؤولاً عن تسديد الغرامات بالإضافة إلى مصاريف الحجز/ كما أوافق تماماً على أن تنقل جميع النقاط السوداء المتعلقة بأية مخالفات مرورية مرتبطة بهذه السيارة – أثناء حيازتي لها -  إلى رخصة قيادتي. جميع السيارات لدينا مخصصة لغير المدخنين ولا نسمح لمن دون 21 سنة بقيادة السيارة أو إذا لم يكن المستخدم أُضيف كسائق إضافي. </td> </tr> 
          <tr><td align="right">الشروط والأحكام العامة لعقد الإيجار المؤرخة _______، تشكل كامل الاتفاق والتفاهم بين الطرفين فيما يتعلق بالمسائل المنصوص عليها فيها، في حالة وجود أي تناقض بين الاتفاقية الماثلة والشروط والأحكام العامة لعقد الإيجار؛ ، إذن ينبغي أن تحل الشروط والأحكام العامة لعقد الإيجار محل الاتفاقية الماثلة</td></tr>
          <tr>
    <td>I acknowledge the receipt of the vehicle identified in this agreement and that its condition is as indicated in the Vehicle Check Report. 
I agree to pay all rental charges or any charges associated with this vehicle, while in my possession, any damage not covered by the insurance policy or a police report, as well as any missing items or accessories.
My signature on this rental agreement shall constitute my authority to debit my nominated credit card with the amounts due under this agreement. 
I have thoroughly read, understood and accept all terms and conditions in this agreement. 
If the vehicle is impounded by the police due to traffic offences, I will be liable to pay the fine amount plus all impounding charges/ I fully agree that any black points related to any traffic offences associated with this vehicle, while in my possession, will be transferred on my driver license.

All our cars are non-smoking cars. 
Nobody under the age of 21 is permitted to drive the car or if the user is not added as an additional driver.<br>
The general terms and conditions of the Lease Agreement dated -- -- -- -, constitutes the entire agreement and understanding of the parties with respect to the matters set out therein,  in the event of any contradiction between this Agreement and the general terms and conditions of the Lease Agreement; then the general terms and conditions of the Lease Agreement shall supersede this Agreement
</td>
    </tr>
 
         <tr>
    <td align="left" ><hr noshade size=1>Customer Signature
    &nbsp;&nbsp;توقيع العميل;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date&nbsp;&nbsp;&nbsp;التاريخ</td></tr>
  <!--   <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
     <tr> <td align="left" ><hr noshade size=1>Rental Agent
      &nbsp;&nbsp;&nbsp;وكيل الإيجار&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date&nbsp;&nbsp;&nbsp;التاريخ</td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
      <tr>
      <td align="left">
    <!-- <fieldset>
    You are responsible for any damage to the vehicle by striking overhanging objects.
      </fieldset> -->
      </td>
      </tr>
     </table>
 </fieldset> 
 <br> <br> <br>
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
