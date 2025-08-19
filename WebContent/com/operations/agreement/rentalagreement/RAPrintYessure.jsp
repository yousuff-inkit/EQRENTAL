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

<table width="100%" >
 <tr>
<td colspan=2>
<table width="100%" style="padding-right:20px;">
    <tr>
	<td align="right"><b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b></td>
	</tr>
  
	<tr>
	<td align="right"><b>Branch</b>:<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
	</tr>
	<tr>
	<td align="right">Branch Mob: <label id="lblindigobranchmobile" name="lblindigobranchmobile"><s:property value="lblindigobranchmobile"/></label>
	</td> 
	</tr>
	<tr>
	<td align="right">Tel: <label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
	</tr>
	  <tr>
	<td align="right"><b>RANO :<label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>--<b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b></td>	
	</tr>
	
	
	<tr>
	<td align="right"><b>Lessor ( License Name ): </b><label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
	</tr>
	<tr>
	<td align="right">Dubai Police : 999&nbsp;&nbsp;&nbsp;Roadside Assistance : 0589135966</td>
	</tr>

</table>
</td>
</tr>
<tr>
<td width="50%">
<table width="100%" >

  <tr>
  <td width="50%">
  <fieldset>
  <table width="100%"> 
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
</td>
</tr>
<tr>
<td>
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
</td>
</tr>
<tr>
<td>
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
</td>
</tr>

 <tr>
       <td>
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
       </td>
       </tr>
 <tr>
 <td>
<fieldset><legend><b>Check In</b></legend>
	<img src="../../../../icons/indigoprintcar.png" style="width:100%;" height="200px"/>
	
</fieldset>
    				
</td>
</tr>
 <tr>
 <td>
  <fieldset>
    		<legend><b>Documents Checklist</b></legend>
    			<table width="100%">
    				<tr>
    					<td width="28%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Passport & VISA</td>
    					<td width="22%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Emirates ID</td>
    				    <td width="28%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Driving License</td>
    					<td width="28%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;MulkiyaIssd</td>
    				    
    				</tr>
 					 				
    			</table>
    		</fieldset>
 

</td>
  
  </tr>
    
   
    <tr>
    <td><fieldset>
    	All Our Cars Has Comprehensive Insurance , In Case of any Faulty Accident including HIT & RUN customer will pay 1500 AED, in additional to the days car is parked for repair. to avid paying 1500 Aed customer must pay 350 Aed monthly. 
جميع سيلرات اشركة لديها ـامين شامل ، في حال التسبب في حادث او تقرير ضد مجهول يتوجب على  المستأجر دفع  مبلغ 1500 درهم بالاضافة الى عدد ايام اصلاح السيارة  المستاجرة
    	</fieldset></td>
    </tr>
    <tr>
    <td><fieldset>
    	Rates: The minimum rental period is 24 hours. Our rates are quoted in UAE dirhams (AED) and are subject to change without prior notice.<b>Rental amount paid is not refundable</b>.
الأسعار: إن الحد الأدنى لفترة الإيجار هو 24 ساعة. وأسعارنا بالدرهم الاماراتي كما قد تخضع للتغيير دون إشعار مسبق. مبلغ 
الإيجار المدفوع غير قابلة للاسترداد.
    	
    	</fieldset></td>
    </tr>
    <tr>
    <td><fieldset>
    This to acknowledge that I reviewed and read all the terms and conditions mentioned in this contract and I agreed for all of terms and conditions.
اقر باني قرات الشروط والاحكام في هذا العقد وموافق عليها جمعيها بدون اي استثناء.
    	</fieldset></td>
    </tr>
  </table>
    
    </td>
    
    
    <td width="50%">
    <table  width="100%">
  
    <tr>
    <td>
     <fieldset>
  <legend><b>Vehicle&nbsp;&nbsp;&nbsp;&nbsp;   نوع المركبة</b></legend>
     <table width="100%" >  
  <tr>
    
    <td width="52%" ><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
   
    <td width="30%" colspan="2">Color&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
     
      <tr>
      <td align="left">Reg NO&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label> &nbsp;&nbsp;رقم المركبة</td>
 
     <td align="left" colspan="2">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
   
    </table>
    </fieldset>
    </td>
    </tr>
     <tr>
     <td>
        <fieldset>
    <legend><b>Out Details  &nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل خروج السيارة  </b></legend>  
       <table >
  <tr>
    <th width="35%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="15%" align="left">Date</th>
       <th width="15%" align="left">Time</th>
          <th width="15%" align="left">Km</th>
             <th width="30%" align="left">Fuel</th>
  </tr>
  <tr>
  <td><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label>:</b></td> 
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
   <tr>
   <th width="25%" align="left"><b>Due :</b></th>
   <td><label id="duedate" name="duedate"><s:property value="duedate"/></label></td>
   <td><label id="duetime" name="duetime"><s:property value="duetime"/></label></td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
  </tr>
 </table>
  </fieldset>     
     </td>
     </tr>
      <tr>
      <td>
       <fieldset><legend><b>Rental Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل الايجار</b></legend>  
      <table  width="100%" >
      	
    	<tr>
    		<td><label id="lblindigorenttype" name="lblindigorenttype"><s:property value="lblindigorenttype"/></label>&nbsp;Tariff</td>
    		<td><label id="lblindigorate" name="lblindigorate"><s:property value="lblindigorate"/></label></td>
    		<td>Discount&nbsp;&nbsp;&nbsp;<label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label></td>
    		<td><b>Net Total&nbsp;&nbsp;&nbsp;<label id="lblindigonettotal" name="lblindigonettotal"><s:property value="lblindigonettotal"/></label></b></td>
    	</tr>
    </table>
    <table  width="100%"  >
       <tr><td width="15%">Accessories</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%">KM Limit</td><td width="25%"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%">Extra per KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
       <tr><td width="35%">CDW</td><td width="25%"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td></tr>
       
  </table>
    </fieldset>
      </td>
      </tr>
       
        <tr>
        <td>
        <fieldset><legend><b>Check Out</b></legend>
    						<img src="../../../../icons/indigoprintcar.png" style="width:100%;"  height="200px"/>
    					<table  width="100%"  >
    					<tr>
    					<td width="25%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel</td>
    					<td width="25%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit</td>
    					<td width=35%>Vehicle Service Due</td><td width="25%"><label id="rarentserdue" name="rarentserdue"><s:property value="rarentserdue"/></label></td>
    					</tr>
    					</table>	
    					</fieldset>
        </td>
        </tr>
         <tr><td><fieldset>
    	In case the ( monthly or weekly ) rental not paid within 48 hours from due date we will consider the daily rate for each day during the rental period and the agreed ( monthly or weekly ) rate will not be applicable and will be canceled
في حال عدم سداد قيمة الايجار الشهري خلال 48 ساعة من تاريخ استحقاق الايجار سيتم حساب قيمة الايجار حسب السعر اليومي لكل يوم خلال فترة الايجار ويعتبر السعر الشهري المتفق عليه ملغي 
    	</fieldset></td>
    	</tr>
         <tr>
         <td>
         <fieldset>
    	Smoking: ALL our cars are "NON-Smoking". Sustained cigarette odor in the car observed at the time of service/off-hire will attract a charge of 1000AED/.
 التدخين: يمنع التدخين نهائيا داخل السيارات المؤجرة. في حال ملاحظة رائحة السجائر في السيارة في وقت تقديم الخدمة / الإرجاع سيؤدي إلى جذب تخمة 1000 درهم  
    	</fieldset>
         </td>
         </tr>
          <tr>
          <td>
          <fieldset>
    	Salik Fee: 1 AED it- additional to the salik fee will be charged each time the vehicle passes through a Salik gate in Dubai. 
سالك: سيتم احتساب 1 درهم / - إضافي إلى رسوم سالك المعتمدة كل تعبر السيارة عبر بوابة في دبي
    	
    	
    	</fieldset>
          </td>
          </tr>
           <tr>
           <td>
           <fieldset>
    	Cleanliness: Keeping the car interior/exterior clean at all times is the customer's responsibility. Dirty cars coming for service or off-hire will attract 'appropriate' cleaning charges.
النظافة : إبقاء داخل / خارج السيارة نظيف في كل الأوقات هي مسؤولية العميل السيارات القذرة القادمة للخدمة أو الارجاع تجذب رسوم تنظيف
    	
    	</fieldset>
           </td>
           </tr>
            <tr>
            <td>
            <fieldset>
    	20% of the repair cost is related by the tenant if the driver is under 25 years of age or the driver's license is less than six months.
20% من قيمة الاصلاح يتحملها المستأجر في حالة كان عمر السائق تحت 20 أو رخصة القيادة أقل من ستة أشهر
    	</fieldset>
            </td>
            </tr>
             <tr>
             <td>
             <fieldset>
    	Traffic Fines: For every traffic and municipality One incurred during the rental period, you will be charged AED 100/ fee to cover administration costs. All costs related to car confiscation will be charged to customer.
المخالفات المرورية : يضاف 100 درهما على قيمة كل مخالفة مرورية يرتكبها المستأجر خلال فترة الإيجار وتحمل جميع التكاليف المتعلقة بمصادرة السيارة إلى العملاء
    	
    	</fieldset>
             </td>
             </tr>
              <tr>
              <td>
              <table width="100%">
    	<tr><td align="center">Signature</td></tr>
    	<tr><td align="center"><br></td></tr>
    
    	<tr><td align="center">................................</td></tr>
    	</table>
              </td>
              </tr>
    </table>
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
    