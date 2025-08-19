<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<!--  <title>GatewayERP(i)</title> --> 
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
	font-size: 8px;
	font-family: Times new roman;
	align: justify;
}
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

#para1{
	font-size: 8.5px;
	font-family: Times New Roman;
	align: justify;
}
P.breakhere {page-break-before: always}
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
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
 <div style="background-color:white;">
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<div style="text-align: center;">
<b>&nbsp;&nbsp;RANO :</b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>
    &nbsp;&nbsp; <b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b>&nbsp;&nbsp; 
    <b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b>
</div>
<br><br>
<table width="100%" >
  <tr>
		  <td width="50%">
			  <fieldset><legend><b>Client Details</b></legend>
			  <table width="100%" cellpadding="4"> 
			  <tr>
			      <td width="18%" align="left" >Name &nbsp;  </td>
			    <td width="82%" ><label id="clname" name="clname"><s:property value="clname"/></label></td>
			    </tr>
			      <tr>
			    <td  align="left">Address </td>
			    <td height="40px" ><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
			    </tr>
			   </table>
			  <table width="100%" >
			      <tr>
			    <td width="18%" align="left">MOB</td>
			    <td width="82%"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td> 
			 <tr>
			    <td  align="left">Email  </td>
			    <td ><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
			    </tr>
			    </table>
			</fieldset>
			<br>
			
			   <fieldset><legend><b>Driver Details</b></legend>
				    <table  width="100%" cellpadding="4">
				   <tr>
				      <td width="20%" align="left">Name</td>
				    <td width="82%" colspan="3">&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label></td>
				      
				    </tr>
				    </table>
			        <table  width="100%" >
				    <tr>
				        <td  width="23%" align="left">D\L NO</td>
				    <td width="77%" colspan="3"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
				    </tr>
				    <tr>
				   <td width="22%" align="left">Expire Date</td>
				    <td width="20%" colspan="3"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
				    </tr>
				    <tr>
				     <td align="left">Emirates ID NO</td>
				    <td colspan="3"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
				    </tr>
				    <tr>
				    <td width="20%" align="left">Expire Date</td>
				    <td width="30%"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
				   
				
				    <td width="15%" align="right">DOB&nbsp;&nbsp;</td>
				    <td width="30%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
				    </tr>
				    </table>
			</fieldset>
		
		 <br>&nbsp;		
		  </td>
  <td width="50%">
  <fieldset>
  <legend><b> Vehicle</b></legend>
     <table width="100%" cellpadding="4">  
  <tr>
    <td width="35%">Color&nbsp;&nbsp;&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    <td width="35%">Reg NO&nbsp;&nbsp;&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
    <td width="30%">Plate&nbsp;&nbsp;&nbsp;<label id="ravehplate" name="ravehplate"><s:property value="ravehplate"/></label></td>
    
    
    </tr>
    <tr>  
     <td align="left" colspan="2">Model&nbsp;&nbsp;&nbsp;<label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td> 
     <td align="left" >YOM&nbsp;&nbsp;&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td>
    </tr>
    </table>
    </fieldset>
    <br>
         <fieldset>
    <legend><b>Out And In Details</b></legend>  
    <table width="100%" border="0" cellpadding="4">
	  <tr>
	    <td width="25%">Date Of Leav</td>
	    <td width="25%"><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
	    <td width="25%">Due Date</td>
	    <td width="25%"><label id="duedate" name="duedate"><s:property value="duedate"/></td>
	  </tr>
	  <tr>
	    <td>Time Of Leav</td>
	    <td><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
	    <td>Due Time</td>
	    <td><label id="duetime" name="duetime"><s:property value="duetime"/></td>
	  </tr>
	  <tr>
	    <td>Date Of Return</td>
	    <td><label id="indate" name="indate"><s:property value="indate"/></label></td>
	    <td>Return Time</td>
	    <td><label id="intime" name="intime"><s:property value="intime"/></td>
  </tr>
</table>
       <%-- <table>
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left">Date</th>
       <th width="10%" align="left">Time</th>
          <th width="22%" align="left">Km</th>
             <th width="19%" align="left">Fuel</th>
             <th width="19%" align="center">Signature</th>
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
 </table> --%>
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
<%--      <fieldset><legend><b>Rental Rates</b></legend>  
      <table  width="100%" >
      <tr>
      <td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>   <td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
       <td width="18%" align="right">CDW&nbsp;&nbsp;</td>   <td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    </tr>
    </table>
     
    <table  width="100%"  >
       <tr><td width="15%">Accessories</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%">Extra KM</td><td width="25%"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%">Extra KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
  </table>
    </fieldset> --%>
    <br>
		<fieldset><legend><b>Insurance Details</b></legend> 
			<table width="100%" border="0" cellpadding="4">
			  <tr>
			    <td width="31%" align="right"><strong>Excess</strong></td>
			    <td width="60%">Excess</td>
			    <td width="9%">&nbsp;</td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td colspan="2" style="text-align: right;">Signature By customer</td>
			    
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td colspan="2">&nbsp;</td>
			  </tr>
			</table>
		</fieldset>
		        
    
<%--     
     <fieldset>
    <legend><b>In Details</b></legend>  
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
  </fieldset>      --%>
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
 
  </td>
    </tr>
  </table>
  <div>
  	<div style="width: 70%; float:left;">
  	 <fieldset><legend>Details</legend>
  		<table width="100%" border="0" cellpadding="4">
		  <tr>
		    <td width="25%">Current ODO</td>
		    <td width="25%"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></td>
		    <td width="25%">Rent Per Day</td>
		    <td width="25%"><label id="radaily" name="radaily"><s:property value="radaily"/></label></td>
		  </tr>
		  <tr>
		    <td>Ending ODO</td>
		    <td>0</td>
		    <td>Rent Per Week</td>
		    <td><label id="delfuels" name="raweakly"><s:property value="raweakly"/></label></td>
		  </tr>
		  <tr>
		    <td>Total ODO</td>
		    <td>0</td>
		    <td>Rent Per Month</td>
		    <td><label id="ramonthly" name="ramonthly"><s:property value="ramonthly"/></label></td>
		  </tr>
		</table>
	  </fieldset>	
  	</div>
  	<div style="width: 30%; float: left;">
  		  <fieldset><legend><b>Utilization</b></legend>
  		  
  		  	<table width="100%" border="0" cellpadding="4">
			  <tr>
			    <td width="49%">NO Of Days</td>
			    <td width="51%">0<%-- <label id="lblnofdays" name="lblnofdays"><s:property value="lblnofdays"/></label> --%></td>
			  </tr>
			  <tr>
			    <td>Excess KM</td>
			    <td><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
			  </tr>
			  <tr>
			    <td>Extra Hourse</td>
			    <td>0</td>
			  </tr>
			</table>
  
 		  </fieldset>
  	</div>
  </div>
  
  <br><br>
	<div style="margin-top: 90px;">
	<table width="100%" border="1" style="border-collapse: collapse;">
	  <tr>
	    <td width="33%">
	    	<table width="100%" border="0" cellpadding="6" >
			  <tr>
			    <td colspan="3">Aknowledge that I have read the above and overleaf terms &amp; conditons are agree to abide by them</td>
			  </tr>
			  <tr>
			    <td width="39%">&nbsp;</td>
			    <td width="15%">&nbsp;</td>
			    <td width="46%">&nbsp;</td>
			  </tr>
			  <tr>
			    <td align="center">Signature</td>
			    <td>&nbsp;</td>
			    <td align="center">Signature</td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td align="center">Hirer</td>
			    <td>&nbsp;</td>
			    <td align="center">Rental agent</td>
			  </tr>
			</table>
	    </td>
	    <td width="33%">
	    	<table width="100%" border="0" cellpadding="6">
	    	  <tr>
			    <td colspan="3" align="center">
			    	<b>Car Return Aknowledgment</b>
			    </td>			    
			  </tr>
			  <tr>
			    <td width="39%">&nbsp;</td>
			    <td width="15%">&nbsp;</td>
			    <td width="46%">&nbsp;</td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td align="center">Signature</td>
			    <td>&nbsp;</td>
			    <td align="center">Signature</td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td align="center">Hirer</td>
			    <td>&nbsp;</td>
			    <td align="center">Rental agent</td>
			  </tr>
			</table>
	    </td>
	    <td width="34%">
			<table  width="100%"  cellpadding="4">
		   
		        
		      	 <tr> <td width="40%">Tariff</td><td  width="20%" align="right"><label id="tariff" name="tariff"><s:property value="tariff"/></label></td><td  width="30%" >&nbsp; </td></tr>
		         
		         <tr> <td width="40%">Extra Hours Charge</td><td  width="20%" align="right">0<%-- <label id="tariff" name="tariff"><s:property value="tariff"/></label> --%></td><td  width="30%" >&nbsp; </td></tr>
		          
		         <tr> <td width="40%">Extra KM Charge</td><td  width="20%" align="right">0<%-- <label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/> --%></label></td><td  width="30%" >&nbsp; </td></tr>       
		                        
		     	 <tr> <td width="40%">Fuel</td><td  width="20%" align="right">0<%-- <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label> --%></td><td  width="30%" >&nbsp; </td></tr>
		      
      
      			 <tr> <td width="40%">Trafic Fine</td><td  width="20%" align="right">0<%-- <label id="lbltraficfine" name="lbltraficfine"><s:property value="lbltraficfine"/> --%></label></td><td  width="30%" >&nbsp; </td></tr>
       
             	 <tr> <td width="40%">Salik</td><td  width="20%" align="right">0<%-- <label id="lblsalik" name="lblsalik"><s:property value="lblsalik"/></label> --%></td><td  width="30%" >&nbsp; </td></tr>
      
                 <tr> <td width="40%">Misc</td><td  width="20%" align="right">0</td><td  width="30%" >&nbsp; </td></tr>
                    
                <tr> <td width="40%">Discount</td><td  width="20%" align="right">0<%-- <label id="lbldiscount" name="lbldiscount"><s:property value="lbldiscount"/></label> --%></td><td  width="30%" >&nbsp; </td></tr>      
                    
              	<tr> <td width="40%">VAT %</td><td  width="20%" align="right">0</td><td  width="30%" >&nbsp; </td></tr>  
              
              	<tr> <td width="40%">Total</td><td  width="20%" align="right">0</td><td  width="30%" >&nbsp; </td></tr>
              	
              	<tr> <td width="40%">Balance</td><td  width="20%" align="right">0<%-- <label id="balance" name="balance"><s:property value="balance"/></label> --%></td><td  width="30%" >&nbsp; </td></tr>
                
                <tr> <td width="40%">Amount Paid</td><td  width="20%" align="right">0<%-- <label id="totalpaids" name="totalpaids"><s:property value="totalpaids"/></label> --%></td><td  width="30%" >&nbsp; </td></tr>
                
                <tr> <td width="40%">Clossing Balance</td><td  width="20%" align="right">0</td><td  width="30%" >&nbsp; </td></tr>
              </table>     
		</td>
	  </tr>
	</table>	
  </div>
  
 </div>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
    