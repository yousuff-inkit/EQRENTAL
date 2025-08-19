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
 height: 500px; 
}  
body,html{
/*  margin-top:0;
 padding-top:0; */
overflow: scroll;
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
function checkconfig()
{
	 
	var aa=0;
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
	 
     			
			var items=x.responseText;
			
	var chk=items.trim();

			 if(parseInt(chk)==1)
				 {
				/* document.getElementById("indetailsconfig").value=1; */
				 $('#indetails').show();
				 $('#indate').show();
				 $('#intime').show();
				 $('#inkm').show();
				 $('#infuel').show();
				 }
			 else
				 {
				/* document.getElementById("indetailsconfig").value=0; */ 
				 $('#indetails').hide();
				 $('#indate').hide();
				 $('#intime').hide();
				 $('#inkm').hide();
				 $('#infuel').hide();
				 }
	
			
			}
	 
	}
x.open("GET","greenstarprintconfig.jsp?aa="+aa,true);

x.send();

	
	
	 
}


</script>
</head>
<body onload="gridload();" bgcolor="white" style="font: 9.5px Tahoma " style="overflow: scroll; height : 90%; max-height:500px" >
<div id="mainBG" class="homeContent" data-type="background">
<div >
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
 <div style="background-color:white;">
<table width="100%" >
<tr>
<td align="left" style="font-size: 11px">
<table width="100%" style="padding-top:110px;">
<tr><td width="65%" style="font-size: 11px; vertical-align: bottom;">
<h2 align="right">RENTAL AGREEMENT</h2> </td>

		<td  align="right" ><b>RANO :<label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b></td>







</tr> 
</table>

<table width="100%" >
  <tr>
  <td width="50%" style="font-size: 11px">
  <fieldset>
  <table width="100%" > 
  <tr>
  	<td width="20%" align="left" style="font-size: 11px">Client ID  </td>
    <td width="80%" style="font-size: 11px"><label id="lblindigocldocno" name="lblindigocldocno"><s:property value="lblindigocldocno"/></label></td>
    </tr>
  <tr>
      <td width="20%" align="left" style="font-size: 11px">Name &nbsp;  </td>
    <td width="80%" style="font-size: 11px"><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
    
      <tr>
    <td width="20%" align="left" style="font-size: 11px">Address  </td>
    <td width="80%" style="font-size: 11px"><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
  <!--  </table> -->
  <!-- <table width="100%" style="padding:0px"> -->
      <tr>
    <td width="20%" align="left" style="font-size: 11px">TEL </td>
    <td width="80%" style="font-size: 11px"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td width="20%" align="left" style="font-size: 11px">Email   </td>
    <td width="80%" style="font-size: 11px"><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    <tr>
    <td width="20%" align="left" style="font-size: 11px">Security   </td>
    <td width="80%" style="font-size: 11px"><label id="clsiclpo" name="clsiclpo"><s:property value="clsiclpo"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend style="font-size: 11px"><b>Driver Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل السائق </b></legend>
    <table  width="100%" style="padding:0px">
   <tr>
    <td width="20%" align="left" style="font-size: 11px">Name [اسم]</td>
    <td width="80%"  style="font-size: 11px"><label id="radrname" name="radrname"><s:property value="radrname"/></label></td>
      
    </tr>
    <tr>
      <td width="20%"align="left" style="font-size: 11px">Nationality  &nbsp;  </td>
    <td width="80%"style="font-size: 11px"><label id="lblindigonationality" name="lblindigonationality"><s:property value="lblindigonationality"/></label></td>
    </tr>
    <tr>
    <td width="100%"  colspan="2">
     <table  width="100%"  align="left" >
     <tr>
     <td  width="35%" align="left" style="font-size: 11px">Driving License NO</td>
   <td colspan="30%" style="font-size: 11px"><label id="radlno" name="radlno"><s:property value="radlno"/></label>&nbsp;&nbsp;&nbsp;</td>
    <td width="40%" align="left" style="font-size: 11px">Exp Date [تاريخ الانتهاء]</td>
    <td colspan="30%" style="font-size: 11px"><label id="licexpdate" name="licexpdate" ><s:property value="licexpdate"/></label></td>
     </tr>
     <tr>
      <td width="35%" align="left" style="font-size: 11px">Passport NO</td>
    <td colspan="30%" style="font-size: 11px"><label name="passno" id="passno" ><s:property value="passno"/></label>&nbsp;&nbsp;&nbsp;</td>
     <td width="40%" align="left" style="font-size: 11px">Exp Date [تاريخ الانتهاء]</td>
    <td width="30%" style="font-size: 11px"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>  
     </tr>
     </table>
    </td>
    </tr>
    <tr>
       </tr>
    <tr>
      </tr>
       <tr>
         
    </tr>
      <tr>
   <td width="20%" align="left" style="font-size: 11px">DOB [تاريخ الميلاد]</td>
    <td width="80%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
   
   </tr>
   
    <tr>
    <td width="20%" align="left" style="font-size: 11px">EID NO</td>
    <td width="20%" align="left" style="font-size: 11px"><label name="lblidno" id="lblidno" ><s:property value="lblidno"/></label></td>
      </tr>
   <tr>
     <td width="35%" style="font-size: 11px">Mobile [جوال]</td>
      <td  style="font-size: 11px"><label id="lblindigoaddmobile" name="lblindigoaddmobile"><s:property value="lblindigoaddmobile"/></label></td>  
    </tr>
    <%-- <tr>
    <td width="34%" align="left" style="font-size: 11px"> ID </td>
    <td width="32%"><label name="lblidno" id="lblidno" ><s:property value="lblidno"/></label></td>
    </tr>
    <tr>
    <td width="34%" align="left" style="font-size: 11px"> Expiry </td>
    <td width="32%"><label name="lblvisaexp" id="lblvisaexp" ><s:property value="lblvisaexp"/></label></td>
    </tr> --%>
    </table>
</fieldset>
  <fieldset><legend style="font-size: 11px"><b>Additional Driver Details &nbsp;&nbsp;&nbsp;&nbsp;    تفاصيل السائق الاضافى</b></legend>
    <table  width="100%" style="padding:0px">
<!--    <tr>
      <td width="20%" align="left"></td>
      <td width="40%" align="left" colspan="2">Additional Driver</td>
   </tr> -->
   <tr> 
  	  <td width="35%" align="left" style="font-size: 11px">Name [الأسم]</td>
      <td style="font-size: 11px"><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
      <%-- <td width="30%" style="font-size: 11px">Nationality [الجنسيه]</td>
      <td width="40%" style="font-size: 11px"><label id="lblindigoaddnationality" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td> --%>
    </tr>
     <tr><td></td></tr>
    <tr>
      <td width="35%" align="left" style="font-size: 11px">Driving License NO</td>
      <td style="font-size: 11px"><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
     
    </tr>
     <tr><td></td></tr>
    <tr>
      <td width="35%" align="left" style="font-size: 11px">Exp Date [تاريخ الانتهاء]</td>
        <td style="font-size: 11px"><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
        <!-- <td colspan="2" style="font-size: 11px">Signature [التوقيع]</td> -->
    </tr>
     <tr><td></td></tr>
     <tr>
      <td width="35%" align="left" style="font-size: 11px">DOB [تاريخ الميلاد]</td>
        <td style="font-size: 11px"><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
    	<!-- <td height="25px" colspan="2"><fieldset style="height:100%;"></fieldset></td> -->
    	  
    </tr>
     <tr><td></td></tr>
    <tr>
    <td width="35%" style="font-size: 11px">Nationality [الجنسيه]</td>
      <td style="font-size: 11px"><label id="lblindigoaddnationality" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td>
    </tr>
     <tr><td></td></tr>
    <tr>
     <td width="35%" style="font-size: 11px">Mobile [جوال]</td>
      <td  style="font-size: 11px"><label id="ramobile" name="ramobile"><s:property value="ramobile"/></label></td>  
    </tr>
     <tr><td></td></tr>
   <!--  <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
    <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
    <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr> -->
    
  
    </table>

</fieldset>

<fieldset>
	<table width="100%" style="padding:0px">
		<tr>
		<td style="font-size: 11px" width="10%">Excess Insurance Terms:</td>
		<td style="font-size: 11px" width="20%"><label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label></td>
	   </tr>	
		</table>	
</fieldset>
  <fieldset>
	<table width="100%">
		<tr>
		<td><p style="font-size:9px;">If the vehicle is impounded by Govt.authorites for any violation of law. I accept to pay the rental charges till it is return back to the car rental office</p>
		<p style="font-size:9px;">إذا تم حجز السيارة من قبل السلطات الحكومية بسبب أي انتهاك للقانون ، سأقبل بدفع رسوم الإيجار حتى تتم إعادتها إلى مكتب تأجير السيارات</p>
		</td>
	   </tr>	
<tr><td><br></td></tr>	
	</table>	
</fieldset> 
  <fieldset>
	<table width="100%">
		<tr>
		<td><p style="font-size:9px;">Payment: every payment received from the lessor (from the first payment) will be charged under the rights of government fines & other expenses of Salik , extra kilometers and damages. Once those rights are settled only then the remainder amount would be adjusted against rental amount.</p>
	<p style="font-size:9px;">الدفع:كل دفعة مستلمة من المؤجر( من الدفعة الاولى) ستتم محاسبتها بموجب حقوق الغرامات الحكومية وغيرها من نفقات السالك والكيلومترات الإضافية والأضرار. ، سيتم تعديل المبلغ المتبقي مقابل مبلغ الإيجار بمجرد تسوية هذه المبالغ فقط ،  
		</p></td>
	   </tr>	

	</table>	
</fieldset> 
 <!--  <fieldset>
	<table width="100%">
		<tr>
			   </tr>	

	</table>	
</fieldset>   -->		
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
    <td width="26%" colspan="2" align="left" style="font-size: 11px">Model[النوع]:&nbsp;<label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
   <%--  <td width="23%" >
    <br><label id="ravehname" name="ravehname" style="font-size: 11px"><s:property value="ravehname"/></label></td> --%>
    <!-- <td width="25%"></td> -->
    <%-- <td width="18%" >YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td> --%>
    <td width="30%" colspan="2" style="font-size: 11px">Color[اللون]:&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td width="15%" align="left" style="font-size: 11px">Reg No[رقم التسجيل]:</td>
      <td width="20%" style="font-size: 11px"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td> 
    <td width="15%" align="left" style="font-size: 11px">Authority:</td>
      <td width="20%" style="font-size: 11px"><label id="vehauth" name="vehauth"><s:property value="vehauth"/></label></td>
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b style="font-size: 11px">Out Details  &nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل خروج المركبة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <td align="left" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="22%" align="left" style="font-size: 11px">Date [التاريخ]</td>
       <td width="22%" align="left" style="font-size: 11px">Time [الوقت]</td>
          <td width="25%" align="left" style="font-size: 11px">Km &nbsp;&nbsp;&nbsp; [كيلومتر]</td>
             <td width="25%" align="left" style="font-size: 11px">Fuel &nbsp;&nbsp;&nbsp; [الوقود]</td>
  </tr>
  <tr><!-- <td>&nbsp;&nbsp;&nbsp;&nbsp;</td> -->
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
 <%--  <fieldset>
    <legend><b style="font-size: 11px">Delivery Details &nbsp;&nbsp;&nbsp;&nbsp;تفاصيل تسليم السيارة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <td align="left" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="25%" align="left" style="font-size: 11px">Date [التاريخ]</td>
       <td width="20%" align="left" style="font-size: 11px">Time [الوقت] </td>
          <td width="22%" align="left" style="font-size: 11px">Km [كيلومتر]</td>
             <td width="19%" align="left" style="font-size: 11px">Fuel [الوقود] </td>
             <td width="19%" align="center" style="font-size: 11px">Signature [التوقيع] </td>
  </tr>
  <tr>
  <!-- <td style="font-size: 11px"><b>Dliv</b></td> -->
<td style="font-size: 11px"><label id="deldates" name="deldates"><s:property value="deldates"/></label></td>
<td style="font-size: 11px"><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td>
<td style="font-size: 11px"><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td>
<td style="font-size: 11px"><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td>
  </tr>
<!--    <tr> -->
  <td style="font-size: 11px"><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
<td style="font-size: 11px"><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
<td style="font-size: 11px"><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
<td style="font-size: 11px"><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
<td style="font-size: 11px"><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
<!--   </tr> -->
 </table>
  </fieldset> --%>
     <fieldset>
    <legend><b style="font-size: 11px">Due Date</b></legend>  
       <table style="padding:0px">
  <tr>
    <td align="left" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="22%" align="left" style="font-size: 11px">Date [التاريخ]</td>
       <td width="22%" align="left" style="font-size: 11px">Time [الوقت]</td>
          <td width="25%" align="left" style="font-size: 11px">Km &nbsp;&nbsp;&nbsp; [كيلومتر]</td>
             <td width="25%" align="left" style="font-size: 11px">Fuel &nbsp;&nbsp;&nbsp; [الوقود]</td>
  </tr>
 <tr>
 <td></td>
<td style="font-size: 11px"><label id="duedate" name="duedate"><s:property value="duedate"/></label></td> 
<td style="font-size: 11px"><label id="duetime" name="duetime"><s:property value="duetime"/></label></td>
<%--<td style="font-size: 11px"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
<td style="font-size: 11px"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
<td style="font-size: 11px"><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td> --%>
  </tr>
  
 </table>
  </fieldset> 
        <fieldset>
				    <legend><b style="font-size: 11px">In Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل دخول السيارة  </b></legend>  
				       <table style="padding:0px">
				  <tr>
				    <td align="left" style="font-size: 11px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				    <td width="25%" align="left" style="font-size: 11px">Date [التاريخ] </td>
				       <td width="20%" align="left" style="font-size: 11px">Time [الوقت] </td>
				          <td width="22%" align="left" style="font-size: 11px">Km [كيلومتر] </td>
				             <td width="19%" align="left" style="font-size: 11px">Fuel [الوقود]</td>
				             <td width="19%" align="center" style="font-size: 11px">Signature [التوقيع] </td>
				  </tr>
				 <tr> 
				<td style="font-size: 11px"><b><label id="indetails" name="indetails"><s:property value="indetails"/></label></b></td> 
				<td style="font-size: 11px"><label id="indate" name="indate"><s:property value="indate"/></label></td> 
				<td style="font-size: 11px"><label id="intime" name="intime"><s:property value="intime"/></label></td>
				<td style="font-size: 11px"><label id="inkm" name="inkm"><s:property value="inkm"/></label></td> 
				<td style="font-size: 11px"><label id="infuel" name="infuel"><s:property value="infuel"/></label></td> 
			    </tr> 
				   <%-- <tr>
				 <td style="font-size: 11px"><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td> 
				<td style="font-size: 11px"><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
				<td style="font-size: 11px"><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
				<td style="font-size: 11px"><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
				<td style="font-size: 11px"><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td> 
				  </tr> --%>
				 </table>
		  </fieldset>   
  <%-- <fieldset>
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
  <td style="font-size: 11px"><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
<td style="font-size: 11px"><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
<td style="font-size: 11px"><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
<td style="font-size: 11px"><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
<td style="font-size: 11px"><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
<!--   </tr> -->
 </table>
  </fieldset>     --%>
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
    <!-- <fieldset><legend><b style="font-size: 11px">Insurance Type </b></legend>  
	
	<br>
		<div class="row" align="center">
		 
		<div class="column"><div class="box"> </div></div>  
        <div class="column" style="top=100 px;">3500 AED  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   </div>
    	<div class="column"><div class="box"> </div></div> 
        <div class="column">3000 AED  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    	<div class="column"><div class="box"> </div> </div>
        <div class="column">5000 AED  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="column"><div class="box"> </div> </div>
        <div class="column">8000 AED  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        </div>
    <br>  
      </fieldset> -->
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
    		<td style="font-size: 11px"><label id="lblindigorenttype" name="lblindigorenttype"><s:property value="lblindigorenttype"/></label>&nbsp;Rental Charges[السعر]</td>
    		<%-- <td align="right" "font-size: 11px"><label id="lblindigorate" name="lblindigorate"><s:property value="lblindigorate"/></label></td> --%>
    		<td align="right" style="font-size: 11px"><label id="lblindigonettotal" name="lblindigonettotal"><s:property value="lblindigonettotal"/></label></b></td>
    		    	</tr>
       <%-- <tr>
       <td style="font-size: 11px">Discount[الخصم]&nbsp;</td>
       <td align="right" style="font-size: 11px"><label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label></td>
       </tr>
  <!--   </table> 
    <table  width="100%" style="padding:0px" > -->
       <tr><td style="font-size: 11px">Net Total[صافي المجموع]</td>
    		<td align="right" style="font-size: 11px"><label id="lblindigonettotal" name="lblindigonettotal"><s:property value="lblindigonettotal"/></label></b></td></tr> --%>
       <tr><td width="15%" style="font-size: 11px">Insurance Full SCDW</td><td width="5%" align="right" style="font-size: 11px"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td></tr>
       <tr><td width="15%" style="font-size: 11px">Personal Accident Insurance</td><td width="5%" align="right" style="font-size: 11px"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td></tr>
        <tr><td width="35%" style="font-size: 11px">Add Driver Charges[قيمة السائق الاضافي] </td><td width="10%" align="right" style="font-size: 11px"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
		<tr><td width=35% style="font-size: 11px">Chauffer Charge [سائق خاص]</td><td width="25%" align="right" style="font-size: 11px"><label id="lblchafcharge" name="lblchafcharge"><s:property value="lblchafcharge"/></label></td></tr>
       <tr><td width="15%" style="font-size: 11px">Total KM Limit</td><td width="25%" align="right" style="font-size: 11px"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td></tr>
       <tr><td width="55%" style="font-size: 11px">Extra per KM Charge[قيمة الاضافيه كيلوميتر]</td><td width="25%" align="right" style="font-size: 11px"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
       <tr><td width="15%" style="font-size: 11px">Damage Charges</td><td width="25%" align="right" style="font-size: 11px"><label id="lblcosmodamagechg" name="lblcosmodamagechg"><s:property value="lblcosmodamagechg"/></label></td></tr>
       <tr><td style="font-size: 11px">Net Total[صافي المجموع]</td><td align="right" style="font-size: 11px"><label id="rentaltotals" name="rentaltotals"><s:property value="rentaltotals"/></label></b></td></tr>
  </table>
    </fieldset>
    
		  <fieldset>
	<table width="100%">
		<tr>
		<td><p style="font-size:9px;">Renewal contract: If I fail to renew the contract on the due date, I hereby authorise the rental car company to confiscate the vehicle.</p>
	<p style="font-size:9px;">عقد التجديد:إذا عجزت عن تجديد العقد في تاريخ الاستحقاق ، فإنني أصرح لشركة تأجير السيارات بمصادرة السيارة.</p></td>
		
	   </tr>
	   
      <!--  <tr><td><br><br><br><br></td></tr> -->
	</table>	
</fieldset>
 <fieldset>
	<table width="100%">
		<tr>
		<td><p style="font-size:9px;">I understand that in case of accident ,even though availed SCDW ,must be accompanied by a valid police report.if without SCDW ,I will be liable to pay excess insurance charges of AED <label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> </p> 
<p style="font-size:9px;">أنا أفهم أنه في  حالة وقوع حادث ، على الرغم من حصول التنازل عن أضرار الاصطدام الفائق(scdw)، يجب أن يرافقه تقريرساري المفعول لشرطة. إذا لم يوجد (scdw)، فسأكون مسؤولاً عن دفع رسوم تأمين زائدة بقيمة <label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> درهم.
لقد قرأت وفهمت وأوافق على الالتزام بالأحكام والشروط المطبقة أعلاه وفي الجانب الاخر للصفحة،
	</p>			
		</td>
	   </tr>	
      <!--  <tr><td><br><br><br><br></td></tr> -->
	</table>	
</fieldset>
  <!-- <fieldset>
	<table width="100%">
		<tr>
		<td></td>
	   </tr>	

	</table>	
</fieldset>
  <fieldset>
	<table width="100%">
		<tr>
		<td><br><br></td>
	   </tr>	

	</table>	
</fieldset>	 -->	 
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
 <table width="100%" >
 <tr><td width="100%">
  <fieldset>
 <table width="100%" >
 <tr><td width="50%" style="text-align:center;"><b>I/We have read, understood and agree to abide by the terms and conditions printed above and overleaf as well</b></td></tr>
  <tr><td width="50%" style="text-align:center;"><b>أنا/نحن قد قرأت وفهمت وأوافق على الشـروط والأحكام أعلاه وكذلك المدونة خلف هذه العقد</b></td></tr> 
 </table>
 </fieldset>
 </td></tr>
</table>
<table width="100%">


<tr><td width="20%" align="center"><b>Customer Sign</b></td><td width="20%" align="center"><b>Driver Sign</b></td><td width="20%" align="center"><b>For <s:property value="branchwisname"/></b></td><td width="20%" align="center"><b>Sign On Off Hiring</b></td></tr>
<tr><td width="20%"><fieldset><img src="" style="height:50px;width:160px;" id="imgsignature"/></fieldset></td><td width="20%"><fieldset><br><br><br></fieldset></td><td width="20%"><fieldset><br><br><br></fieldset></td><td width="20%"><fieldset><br><br><br></fieldset></td></tr>
</table>
  <DIV style="page-break-after:always"></DIV>
  <!-- <table width="100%" style="padding:0px">
  <tr><td width="100%"><fieldset>
    		<table width="100%">
<tr>
<td >

<p align="justify"><b><u>Terms and Conditions.</u></b></p></td></tr>
<tr><td style="width:50%;font-size:6px;"> -->

  <!-- <img src="../../../../icons/kudraimg.jpg" style="height:100vh;width:100%;margin:0;"  /> -->
 <!--  </td></tr>
</table><br>
    		</fieldset></td></tr>
    		</table> -->
 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
<input type="hidden" name="signpath" id="signpath" value='<s:property value="signpath"/>'  />
<!-- <DIV style="page-break-after:always"></DIV>   -->

</form>
</div>
</div>
</body>
</html>
    