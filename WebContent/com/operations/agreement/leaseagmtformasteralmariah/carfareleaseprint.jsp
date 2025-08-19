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
p.page { page-break-after: always; }
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
  	<%-- <img src="<%=contextPath%>/icons/headercarfare.jpg" width="100%" height="70%"  alt=""/> --%>
    <td rowspan="6"><div style="width: 100%; height: 140px;">&nbsp;</div>
    </td>
    </tr>
   </table> 
 <table width="100%">
 <tr>
 <td align="center"><b><font size="3" >Lease Agreement</font></b></td></tr>
 </table>
 
    <%-- <td width="36%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td> --%>
 
  <%-- <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="4"></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label id="lblindigobranchfax" name="lblindigobranchfax"><s:property value="lblindigobranchfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center">
     </td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr> --%>
</table> 
<table width="100%" >
	<tr>
		<td width="33.33%" align="left"><b>LA NO :<label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b></td>
		<td width="36.5%" align="center"></td>
		<td width="33.33%" align="left"><b>RA STATUS:</b><b>&nbsp;<label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b></td>
	</tr>
	<tr>
	<td width="33.33%" align="left">Manual LA NO :&nbsp;<label id="mrano" name="mrano"><s:property value="mrano"/></label></td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td colspan="2" width="40%"><b>Lessor (License Name) :</b> &nbsp;<label id="companyname" name="companyname"><s:property value="companyname"/></label></td>
		<td width="30%">&nbsp;</td>
		<td colspan="2" width="40%"><b>Branch</b>:&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
	</tr>
	<tr>
		<td colspan="2" width="40%"> </td>
		<td width="30%">&nbsp;</td>
		<td colspan="2" width="40%"><b>LPO NO</b>:&nbsp;<label id="clsiclpo" name="clsiclpo"><s:property value="clsiclpo"/></label></td>
	</tr>
	<tr>
		<%-- <td>Tel: <label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
		<td>Branch Mob: <label id="lblindigobranchmobile" name="lblindigobranchmobile"><s:property value="lblindigobranchmobile"/></label></td>
		 --%><td>&nbsp;</td>
		<td colspan="2"></td>
	</tr>
</table>
<table width="100%" >

  <tr>
  <td width="50%">
  <fieldset><legend><b>Customer Details &nbsp;&nbsp;&nbsp;&nbsp; بيانات العميل    </b></legend>

  <table  width="100%" > 
  
  <tr>
  	<td width="18%" align="left" >Client ID &nbsp;  </td>
    <td width="82%" >:&nbsp;<label id="lblindigocldocno" name="lblindigocldocno"><s:property value="lblindigocldocno"/></label></td>
    </tr>
  <tr>
      <td  align="left" >Name &nbsp;  </td>
    <td>:&nbsp;<label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
   
      <tr>
    <td  align="left">Address </td>
    <td height="20px" >:&nbsp;<label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>

      <tr>
    <td width="18%" align="left">Mob/Telephone</td>
    <td width="82%">:&nbsp;<label id="clmobno" name="clmobno"><s:property value="clmobno"/></label>/&nbsp;<label id="cltelno" name="cltelno"><s:property value="cltelno"/></label></td>
 </tr>
 <tr>
    <td  align="left">Email  </td>
    <td >:&nbsp;<label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details &nbsp;&nbsp;&nbsp;&nbsp; بيانات السائق </b></legend>
    <table  width="100%">
   <tr>
      <td  width="18%" align="left">Name</td>
    <td width="82%" colspan="3">&nbsp;&nbsp;&nbsp;:&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label> </td>
      
    </tr>
    <tr>
        <td   width="18%" align="left">D\L NO</td>
    <td width="82%" colspan="3">&nbsp;&nbsp;&nbsp;:&nbsp;<label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td  width="18%" align="left">Exp Date</td>
    <td width="82%" colspan="3">&nbsp;&nbsp;&nbsp;:&nbsp;<label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td   width="18%" align="left">Passport NO</td>
    <td width="82%" colspan="3">&nbsp;&nbsp;&nbsp;:&nbsp;<label name="passno" id="passno" ><s:property value="passno"/></label></td>
    </tr>
    <tr>
    <td  width="18%" align="left">Exp Date</td>
    <td width="82%">&nbsp;&nbsp;&nbsp;:&nbsp;<label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   </tr>
     <tr>
     <td  width="18%" align="left" >Nationality &nbsp;  </td>
    <td width="82%">&nbsp;&nbsp;&nbsp;:&nbsp;<label id="lblindigonationality" name="lblindigonationality"><s:property value="lblindigonationality"/></label></td>
    </tr>
 
<tr>
    <td   width="18%" align="left">D.O.B&nbsp;&nbsp;</td>
    <td width="82%">&nbsp;&nbsp;&nbsp;:&nbsp;<label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    </tr>
    <tr>
    <td  width="18%" align="left">Mobile No.&nbsp;&nbsp;</td>
    <td width="82%">&nbsp;&nbsp;&nbsp;:&nbsp;<label name="drivermobno" id="drivermobno" ><s:property value="drivermobno"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend><b>Additional Driver Details &nbsp;&nbsp;&nbsp;&nbsp;    بيانات السائق الإضافي  </b></legend>
    <table  width="100%">
<!--    <tr>
      <td width="20%" align="left"></td>
      <td width="40%" align="left" colspan="2">Additional Driver</td>
   </tr> -->
   <tr> 
  	  <td width="18%" align="left">Name</td>
      <td width="37%" >&nbsp;&nbsp;&nbsp;&nbsp;:<label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
      <td width="15%">Nationality</td>
      <td width="40%">&nbsp;&nbsp;:<label id="lblindigoaddnationality1" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td>
    </tr>
    <tr>
      <td align="left">D\L NO</td>
      <td >&nbsp;&nbsp;&nbsp;&nbsp;:<label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
      <td>Mobile</td>
      <td>&nbsp;&nbsp;:<label id="lblindigoaddmobile" name="lblindigoaddmobile"><s:property value="lblindigoaddmobile"/></label></td>
    </tr>
    <tr>
      <td width="" align="left">Exp Date</td>
        <td width="" >&nbsp;&nbsp;&nbsp;&nbsp;:<label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
        <td >Signature</td><td>&nbsp;&nbsp;:</td>
    </tr>
     <tr>
      <td width="" align="left">DOB</td>
        <td width="" >&nbsp;&nbsp;&nbsp;&nbsp;:<label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
    	<td height="35px" colspan="2">____________________________</td>
    </tr>
    </table>

</fieldset>

<fieldset><legend><b>Credit Card Details &nbsp;&nbsp;&nbsp;&nbsp;     بيانات بطاقة الإئتمان </b></legend>
    						<table  width="100%"  >
   <tr> 
  	  <td width="18%" align="left">Cr. Card Type &nbsp;&nbsp;:</td>
      <td width="30%" ><label id="cardtype" name="cardtype"><s:property value="cardtype"/></label></td>
       </tr>
    
    <tr>
    <td width="25%">Credit Card No &nbsp;:</td>
      <td width="45%"><label id="cosmocreditcardno" name="cosmocreditcardno"><s:property value="cosmocreditcardno"/></label></td>
   
      <td width="10" align="left">Exp Date</td>
        <td width="20" >:<label id="lblcosmocreditvaliddate" name="lblcosmocreditvaliddate"><s:property value="lblcosmocreditvaliddate"/></label></td>    
    </tr>
     
    </table>
    </fieldset>
    <fieldset><legend><b>Remarks &nbsp;&nbsp;&nbsp;&nbsp;   ملاحظات  </b></legend>
    						<table  width="100%"  >
   <tr> 
  	  <td width="20%" align="left">Remarks</td>
      <td width="80%" >:<label id="cldesc" name="cldesc"><s:property value="cldesc"/></label></td>
       </tr>
     
    </table>
    </fieldset>

  </td>
  <td width="50%">
  <fieldset>
  <legend><b>Vehicle Details&nbsp;&nbsp;&nbsp;&nbsp;  بيانات المركبة </b></legend>
     <table width="100%" >  
  <tr>
    
    <td width="70%" >Vehicle Type&nbsp;:<label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <td align="left" >YOM&nbsp;:<label id="rayom" name="rayom"><s:property value="rayom"/></label></td>  
    
    </tr>
    </table>
    <table width="100%">
     <tr>
      <td  width="40%">Reg NO&nbsp;:<label id="ravehauthregno" name="ravehauthregno"><s:property value="ravehauthregno"/></label> &nbsp;&nbsp;</td>
      <td width="29%" >Color&nbsp;:<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>  
     <td width="31%">Group&nbsp;:<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b>Vehicle Out Details  &nbsp;&nbsp;&nbsp;&nbsp;   بداية عقد الإيجار </b></legend>  
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
 </table>
  </fieldset>     
        
 
     <fieldset><legend><b>Rental Details &nbsp;&nbsp;&nbsp;&nbsp;  إيجار المركبة </b></legend>  
      
    <table  width="100%" >
       <tr>
       <td width="35%">Rate  </td><td width="25%">:<label id="tariff" name="tariff"><s:property value="tariff"/></label></td></tr>
        <tr><td width="35%">CDW (Collision Damage Waiver)</td><td width="25%">:<label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td></tr>
       <tr><td width="35%">PAI (Personal Accident Insurance)</td><td width="25%">:<label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td></tr>
       <tr><td width=35%>Delivery Charges </td><td width="25%">:<label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td></tr>
       <tr><td width=35%>Additional Driver Charges  </td><td width="25%">:<label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
       <tr><td width=35%>Approved Mileage KMs  </td><td width="25%">:<label id="raextrakm" name="raextrakm"><s:property value="approvedmilage"/></label></td></tr>
       <tr><td width=35%>Excess KM Rate  </td><td width="25%">:<label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
       <tr><td width=35%>Fuel Charge </td><td width="25%">:<label id="lblcosmofuelin" name="lblcosmofuelin"><s:property value="lblcosmofuelin"/></label></td></tr>
  </table>
    </fieldset>
     <fieldset>
     <table>
    <legend><b> Agreed Return Date &nbsp;&nbsp;&nbsp;&nbsp;    نهاية العقد الإيجار   </b></legend>  
      
 <tr><td width=35%></td></tr>
 <tr>
 <td width="25%">Agreed Return Date : <label id="duedate" name="duedate"><s:property value="duedate"/></label></td></tr>
 <tr>
 <%-- <td width="25%">Time:<label id="duetime" name="duetime"><s:property value="duetime"/></label></td></tr> --%>
 </table>
  </fieldset>   
     <fieldset><legend><b>Accident Excess Charge &nbsp;&nbsp;&nbsp;&nbsp;    نسبة تحمل التأمين </b></legend>
    						<table  width="100%" >
   <tr> 
  	  <td width="20%" align="left">
  	  <p>Renter declines CDW (Collision Damage Waiver) and agrees to pay Accident Excess
  	   Charge of AED ………………..for each accident/ damage due to own mistake, or “Hit & Run” cases. 
  	   However, a valid POLICE REPORT is mandatory for both the cases. 
  	  </p></td>
       </tr>
       <tr>
       <td>Customer Signature : ___________________________
       </td></tr>
     
    </table>
    					</fieldset>
  </td>
    </tr>
      <tr><td></td></tr>
    <tr>
    <td colspan="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;Note: Value Added Tax (VAT) will be applicable extra for the rental and other services.</b>
    </td>
    </tr>
    <tr><td></td></tr>

    	<tr>
    		<td colspan="2">
    			<fieldset><legend><b>Terms & Conditions &nbsp;&nbsp;&nbsp;&nbsp;   الشروط والأحكام </b></legend>
    				<p >
    				    I acknowledge in the event of any accident, I will obtain a valid POLICE REPORT. 
    					Failure to do so could result in legal action, and further void all insurances, 
    					rendering me liable for all cost incurred by the Lessor. This vehicle cannot be taken outside the
    				    U.A.E without the permission of Owner. By this signature, I/ we hereby agree to the Terms & Conditions 
    				    mentioned on both sides of this agreement.
    				</p>
    				
    				<table width="100%" >
    				<tr>
    				 <td width="10%">Sales Person </td>
                      <td width="40%" align="left">:<label id="salname" name="salname"><s:property value="salname"/></label></td>
                      <td width="10%">Lessee</td>
                      <td width="40%" align="left">:<label id="clname" name="clname"><s:property value="clname"/></label></td>
                     
    				</tr>
    				 <tr>
    				  <td width="10%">Rental Agent </td>
                      <td width="40%" align="left">:<%= session.getAttribute("USERNAME").toString()%></td>
                
                      </tr>
                     </table>
                     <table width="100%">
                     <tr>
                     <td>
                     </td>
                     </tr>
                     <tr>
                     <td>
                     </td>
                     </tr>
                     <tr>
                     <td></td>
                     </tr>
                     <tr><td>&nbsp;</td>
                     </tr>
                     <tr>
                     <td width="10%">Signature&nbsp;</td><td width="40%">: ___________________________________</td>
                     <td width="10%">Signature&nbsp;</td><td width="40%">: ___________________________________</td>
                     </tr>
                     <tr>
                     <td width="10%">Date&nbsp;</td><td width="40%">: <label id="lblcurrentdate" name="lblcurrentdate"><s:property value="lblcurrentdate"/></label></td>
                     <td width="10%">Date&nbsp;</td><td width="40%">: </td>
                     </tr>
                     <tr>
                     <td></td>
                     </tr>
                     <tr><td>&nbsp;</td>
                     </tr>
                       
                   
    				</table>
    			</fieldset>	
    		</td>
    	</tr>
    	
    		</table>
    		
    	
    		
    		<%-- <fieldset>
    			<table width="100%">
    				<tr>
    					<td width="30%">Customer Signature :</td>
    					<td width="40%">&nbsp;</td>
    					<td width="15%">Date :</td>
    					<td width="15%">&nbsp;</td>
    				</tr>
    				<tr>
    					<td>Rental Agent :</td>
    					<td align="left"><label id="lblindigorentalagent" name="lblindigorentalagent"><s:property value="lblindigorentalagent"/></label></td>
    					<td>Date :</td>
    					<td>&nbsp;</td>
    				</tr>
    			</table>
    		</fieldset> --%>
    		
    		
    		</div>
 
    		 <table>
    		<tr>
    			<%-- <img src="<%=contextPath%>/icons/footercarfare.jpg"/> --%>
    		    <td align="center"  width="18%" rowspan="6"><div style="width: 100%; height: 47.4px" >&nbsp;</div>
    		</tr></table> 
    		<%--
    		<div>
    		<p class="page"></p>
    		<table width="100%">
 <tr>
 <td align="left"><b><u>Terms & Conditions for Rental Agreement</u></b></td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">Owner Undertaking:</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">1) To keep the vehicle fully covered by comprehensive insurance including third party liabilities in respect of death and bodily injury. Hirer shall have the option to decline or accept PAI and CDW at extra cost.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">2) To carry out routine maintenance, servicing and repairs (including tyre but excluding tyre puncture and blast), resulting from normal wear and tear.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">3) To arrange for registration of the vehicle.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">Terms & Conditions for Rental Agreement</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">4) To provide a replacement during maintenance and service of the leased, daily, weekly and monthly vehicles. Replacement will be subject to availability and not exceed a small saloon/commercial vehicle specified in the rental agreement. In case of an accident, replacement will be provided only after the original police report is given, or in case of no police report - hirer accepts the damages on the vehicle Check out/In report and agrees to pay for entire damages.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left"><u><b>Hirer Undertaking:</b></u></td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">1) To pay the Daily/Weekly/Monthly/Lease rental charges in advance, or within mutuallyagreed prior approved credit period. </td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">2) To bring the vehicle for routine service/repair and for registration renewal at least 7 days prior to expiry.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">3)  Minimum age as declared on the hirer’s passport should be at least 25 years of age. If the age is between 21 to 25 Years, 10% of the total repair cost of the vehicle should be borne by the customer. A person below 21 Years is NOT allowed to drive the vehicle. The hirer, if a U.A.E. resident should have a valid U.A.E. driving license which should be at least 1 year old. If the U.A.E. license is less than one year old, then the Hirer must possess a driving license from his country of origin that is more than one year old. Both these licenses should be presented to the Owner at the start of the rental.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">4) To inform Owner immediately in the event of an accident, and obtain a police report to process insurance claims therein. However, the Hirer shall bear the 1st AED ....................of the total indemnity as per the agreed policy terms (unless CDW is accepted in advance). In case, due to any reason, if it is not possible to obtain a police report for insurance claim, the hirer will pay for all costs of repair incurred including, but not limited to loss of use. The hirer will pay the cost of transporting accident    vehicle to inspection yard and to the workshop.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">5) To accept liability for all fines and expenses incurred through violation of traffic, municipality, RTA, Salik and local laws. Owner reserves the right to charge these to hirer’s account or hirer’s credit card, inclusive of service charge(s) and any additional charge(s) therein.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">6) To ensure all fluid levels ( Oil, Water, etc) and tyre pressures are maintained  to level specified and accept liability for any damage resulting from use of the vehicle below specified level.</td>
 </tr>

 <tr>
 <td align="left">7) To ensure that the vehicle will not be used for transportation of any illegal substances (alcohol, drugs, etc), or to transport merchandises or transport passengers for hire or any other illegal act. In case of fines or confiscation of the vehicle, the hirer is responsible for payment of all damages to the owner such as, the full value of the vehicle, fines, claims of passengers, third party claims and loss of income or loss of rental.  </td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">8) Not to use the hired vehicle for rallying, racing and over load or excess the number of passengers for which the vehicle is licensed and mentioned in registration card.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">9) Not to take the vehicle outside of UAE territories, unless agreed in advance or mentioned in the agreement.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">10) To return the vehicle on due date in the same condition in which it was handed over, including exterior and interior cleaned. In case of any damage the hirer agrees to pay for repair as per estimate from the owner and rental charges till the vehicle is restored to its original condition.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">11)  To pay for usage of owner’s fuel at 1.5 times the price, if the vehicle is returned with fuel below the limit at which it was supplied at the start of vehicle rental.</td>
 </tr>
 <tr>
 <td align="left">12) To ensure that no unauthorized person repairs or carries out modification on the vehicle without prior written approval from the owner.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">13) To compensate the owner for any losses, including loss of profit due to failure to adhere to the terms and conditions of this agreement.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">14) To accept all liabilities and to absolve the owner of any charges, during the period that the vehicle is under the possession of the hirer.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left"><b><u>Early Termination:</u></b></td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">1) Owner shall have the option to terminate the contract and take possession of the vehicle, if the hirer misuses the vehicle, uses the vehicle for illegal or criminal activities, or fails to pay the rental charges beyond 7 days from due date.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">2) The owner shall also have the authorization to charge early settlement fees.</td>
 </tr>
 <tr>
   <td>&nbsp;</td>
  </tr>
 <tr>
 <td align="left">3) U.A.E. Laws shall govern this agreement.</td>
 </tr>
 
 
 
 </table>
 
 </div>
    	--%>	
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
 