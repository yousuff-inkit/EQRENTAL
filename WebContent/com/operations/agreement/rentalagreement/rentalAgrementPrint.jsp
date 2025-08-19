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
.tablepadd{
	padding-top: 6px;
	padding-bottom: 6px;
}

#rent tr td{
	padding-top: 6px;
	padding-bottom: 6px;
}
#util tr td{
	padding-top: 6px;
	padding-bottom: 6px;
}
#carreport tr td{
	padding-top: 6px;
	padding-bottom: 6px;
}
P.breakhere {page-break-before: always}

#tab{border:1px solid black;}
</style> 
<script>
 


</script>
</head>
<body  bgcolor="white" style="font: 10px Tahoma " >
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
 <div style="background-color:white;">
<br><br><br><br><br><br><br><br><br><br>
<input type="hidden" name="lblrentaltype" id="lblrentaltype" value='<s:property value="lblrentaltype"/>'/>
<s:set name="rentaltype" value="lblrentaltype"></s:set>
<div style="text-align: center; font-size: 15px; padding: 0; margin: 0">
<b>&nbsp;&nbsp;RA NO :</b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>
</div>
<table width="100%" style="position:static; top: 80px;">
  <tr>
		  <td width="50%">
		  <br><br>
			  <fieldset><legend><b>Client Details</b></legend>
			  	<table width="100%" border="0" style="border-collapse: collapse;" cellpadding="1">
			  		 <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
					  <tr>
					    <td width="10%"><strong>NAME</strong></td>
					    <td width="65%" align="left">: <label id="clname" name="clname"><s:property value="clname"/></label></td>
					    <td width="25%" align="right"><strong>اسم المستأجر</strong></td>
					  </tr>
					  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
					  <tr>
					    <td><strong>ADDRESS</strong></td>
					    <td align="left">: <label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
					    <td align="right"><strong>عنوان</strong></td>
					  </tr>
					  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
					  <tr>
					    <td><strong>MOB NO</strong></td>
					    <td align="left"> : <label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
					    <td align="right"><strong>رقم الهاتف </strong></td>
					  </tr>
					  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
					  <tr>
					    <td><strong>EMAIL</strong></td>
					    <td align="left"> : <label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
					    <td align="right"><strong>البريد الإلكتروني</strong></td>
					  </tr>
					  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
					</table>
			</fieldset>
			<br>
			
			<fieldset><legend><b>Driver Details</b></legend>
				    <table width="100%" border="0" style="border-collapse: collapse;" cellpadding="1">
					  <tr>
					    <td width="28%"><strong>NAME</strong></td>
					    <td width="42%" align="left"> : <label id="radrname" name="radrname"><s:property value="radrname"/></label></td>
					    <td width="30%" align="right"><strong>اسم سائق</strong></td>
					  </tr>
<!-- 					  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr> -->
					  <tr>
					    <td><strong>NATIONALITY</strong></td>
					    <td align="left"> : <label id="lblnation" name="lblnation"><s:property value="lblnation"/></label></td>
					    <td align="right"><strong>جنسية</strong></td>
					  </tr>
					  <tr>
					    <td><strong>D/L NO</strong></td>
					    <td align="left"> : <label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
					    <td align="right"><strong>رقم الرخصة</strong></td>
					  </tr>
					  <tr>
					    <td><strong>ISS FROM</strong></td>
					    <td align="left"> : <label id="lblpassissued" name="lblpassissued"><s:property value="lblpassissued"/></label></td>
					    <td align="right"><strong>جهة الاصدار</strong></td>
					  </tr>
					  <tr>
					    <td><strong>EXPIRE DATE</strong></td>
					    <td align="left"> : <label name="licexpdate" id="licexpdate" ><s:property value="licexpdate"/></label></td>
					    <td align="right"><strong>تاريخ انتهاء الصلاحية</strong></td>
					  </tr>
					  <tr>
					    <td><strong>EMIRATES ID NO</strong></td>
					    <td align="left"> : <label name="lblidno" id="lblidno" ><s:property value="lblidno"/></label></td>
					    <td align="right"><strong> رقم هوية</strong></td>
					  </tr>
					  <tr>
					    <td><strong>DOB</strong></td>
					    <td align="left"> : <label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
					    <td align="right"><strong>تاريخ  الميلاد</strong></td>
					  </tr>
					</table>
			</fieldset>
		
		 <br>&nbsp;		
		  </td>
  <td width="50%">
  
  <fieldset><legend><b> Vehicle</b></legend>
     	<table width="100%" border="0" style="border-collapse: collapse;" cellpadding="1">
     		 <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
		  <tr>
		    <td width="25%"><strong>REG NO</strong></td>
		    <td width="50%" align="left"> : <label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
		    <td width="25%" align="right"><strong>رقم لوحة</strong></td>
		  </tr>
		  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
		  <tr>
		    <td><strong>PLATE NO</strong></td>
		    <td align="left"> : <label id="ravehplate" name="ravehplate"><s:property value="ravehplate"/></label></td>
		    <td align="right"><strong>لون لوحة </strong></td>
		  </tr>
		  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
		  <tr>
		    <td><strong>COLOR</strong></td>
		    <td align="left"> : <label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
		    <td align="right"><strong>لون السيارة</strong></td>
		  </tr>
		  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
		  <tr>
		    <td><strong>MODEL</strong></td>
		    <td align="left"> : <label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
		    <td align="right"><strong>نوع السيارة</strong></td>
		  </tr>
		  <tr>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  </tr>
		  <tr>
		    <td><strong>MOY</strong></td>
		    <td align="left"> : <label id="rayom" name="rayom"><s:property value="rayom"/></label></td>
		    <td align="right"><strong>سنة الصنع</strong></td>
		  </tr>
		</table>
    </fieldset>
    
    
    <br>
   <fieldset><legend><b>Car In And Out Details</b></legend>
    	<table width="100%" border="0" style="border-collapse: collapse;" cellpadding="1">
		  <tr>
		    <td width="28%"><strong>DATE OF LEAVE</strong></td>
		    <td width="37%" align="left">: <label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
		    <td width="35%" align="right"><strong>تاريخ الخروج</strong></td>
		  </tr>
		  <tr>
		    <td><strong>TIME OF LEAVE</strong></td>
		    <td align="left"> : <label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
		    <td align="right"><strong>ساعة الخروج </strong></td>
		  </tr>
		  <tr>
		    <td><strong>CURRENT ODO</strong></td>
		    <td align="left"> : <label id="raklmout" name="raklmout"><s:property value="raklmout"/></td>
		    <td align="right"><strong>الخروج /كم</strong></td>
		  </tr>
		  <tr>
		    <td><strong>DUE DATE</strong></td>
		    <td align="left"> : <label id="duedate" name="duedate"><s:property value="duedate"/></td>
		    <td align="right"><strong>تاريخ العودة المتوقعة</strong></td>
		  </tr>
		  <tr>
		    <td><strong>EXPECT TIME</strong></td>
		    <td align="left"> : <label id="duetime" name="duetime"><s:property value="duetime"/></td>
		    <td align="right"><strong>ساعة العودة المتوقعة</strong></td>
		  </tr>
		  <tr>
		    <td><strong>DATE OF RETURN</strong></td>
		    <td align="left"> : <label id="indate" name="indate"><s:property value="indate"/></label></td>
		    <td align="right"><strong>تاريخ الدخول</strong></td>
		  </tr>
		  <tr>
		    <td><strong>TIME OF RETURN</strong></td>
		    <td align="left"> : <label id="intime" name="intime"><s:property value="intime"/></label></td>
		    <td align="right"><strong>ساعة الدخول</strong></td>
		  </tr>
		</table>
  </fieldset>     
        		        
  </td>
    </tr>
  </table>
  <div>
  	<div style="width: 34%; float: left;">
  		<fieldset><legend><b>Insurance Details</b></legend>
  			<table width="100%" border="0" cellpadding="1">
			  <tr>
			    <td width="25%"><strong>EXCESS</strong></td>
			    <td width="58%" align="left">: <label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label></td>
			    <td width="17%" align="right"><strong> التحمل</strong></td>
			  </tr>
			  <tr>
			    <td><strong>PERCENTAGE</strong></td>
			    <td align="left"> : <label id="lblrentaldesc" name="lblrentaldesc"><s:property value="lblrentaldesc"/></label></td>
			    <td align="right"><strong>النسبة </strong></td>
			  </tr>
			  <tr>
			    <td height="25">&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td align="center">SIGNATURE &nbsp;&nbsp;&nbsp; التوقيع</td>
			    <td>&nbsp;</td>
			  </tr>
			</table>
  		</fieldset>
  	</div>
  	<div style="width: 33%; float: left;">
  		 <fieldset><legend><b>Rent</b></legend>
  		  
  		  	<table width="100%" border="0" cellpadding="4" id="rent">
			  <tr>
			    <td width="49%"><strong>RENT PER DAY</strong></td>
			    <td width="51%">: <s:if test="%{#rentaltype=='Daily'}"><label id="radaily" name="radaily"><s:property value="radaily"/></label></s:if></td>
			  </tr>
			  <tr>
			    <td><strong>RENT PER WEEK</strong></td>
			    <td>: <s:if test="%{#rentaltype=='Weekly'}"><label id="delfuels" name="raweakly"><s:property value="raweakly"/></label></s:if></td>
			  </tr>
			  <tr>
			    <td><strong>RENT PER MONTH</strong></td>
			    <td>: <s:if test="%{#rentaltype=='Monthly'}"><label id="ramonthly" name="ramonthly"><s:property value="ramonthly"/></label></s:if></td>
			  </tr>
			</table>
  
 		  </fieldset>
  	</div>
  	<div style="width: 33%; float: left;">
  		  <fieldset><legend><b>Utilization</b></legend>
  		  
  		  	<table width="100%" border="0" cellpadding="4" id="util">
			  <tr>
			    <td width="49%"><strong>NO OF DAYS</strong></td>
			    <td width="51%">: 0<%-- <label id="lblnofdays" name="lblnofdays"><s:property value="lblnofdays"/></label> --%></td>
			  </tr>
			  <tr>
			    <td><strong>ALLOWED KM</strong></td>
			    <td>: <label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
			  </tr>
			  <tr>
			    <td><strong>EXTRA HOURS</strong></td>
			    <td>: 0</td>
			  </tr>
			</table>
  
 		  </fieldset>
  	</div>
  	<br>
  </div>

		  <table width="100%" border="0">
		  <tr>
		    <td>As per the UAE law the VAT charges will be added on the amount shown above which will be refelected in the actual invoice</td>
		  </tr>
		  <tr>
		    <td align="right">وفقا لقانون دولة الإمارات العربية المتحدة سيتم إضافة رسوم ضريبة القيمة المضافة على المبلغ الموضح أعلاه والتي سيتم إعادة حسابها في الفاتورة الفعلية</td>
		  </tr>
		</table>
		
	<div >
	<br>
	<table width="100%" border="1" style="border-collapse: collapse; padding: 0;">
	  <tr>
	    <td width="37%" style="vertical-align:top">
	    	<table width="100%" border="0" cellpadding="2">
			  <tr>
			    <td colspan="2" align="right"> في الخلف وعليها أوقع أقر بأنني أطلعت علي هذه الاتفاقية والشروط المدونة </td>
			  </tr>
			  <tr>
			    <td colspan="2">Aknowledge that I have read the above and overleaf terms &amp; conditons are agree to abide by them</td>
			  </tr>
			  <tr>
			    <td width="45%" height="40">&nbsp;</td>
			    <td width="55%" height="40">&nbsp;</td>
			  </tr>
			  <tr>
			    <td align="center" style="border-right:thin solid black ;">SIGNATURE &nbsp;&nbsp; التوقيع</td>
			    <td align="center">SIGNATURE &nbsp;&nbsp; التوقيع</td>
			  </tr>
			  <tr>
			    <td style="border-right:thin solid black ;" height="180">&nbsp;</td>
			    <td height="180">&nbsp;</td>
			  </tr>
			  <tr>
			    <td align="center" style="border-right:thin solid black ;">HIRER &nbsp;&nbsp; المستأجر</td>
			    <td align="center">RENTAL AGENT &nbsp;&nbsp; وكيل الإيجار</td>
			  </tr>
			</table>
	    </td>
	    <td width="37%" style="vertical-align:top">
	    	<table width="100%" border="0" cellpadding="2">
			  <tr>
			    <td colspan="2" align="right"> التوقيع عند الد خول واستلام المحجوزات</td>
			  </tr>
			  <tr>
			    <td colspan="2">Car return aknowledgment</td>
			  </tr>
			  <tr>
			    <td width="45%" style="border-right:thick ;" height="65">&nbsp;</td>
			    <td width="55%" height="65">&nbsp;</td>
			  </tr>
			  <tr>
			    <td align="center" style="border-right:thin solid black ;">SIGNATURE &nbsp;&nbsp; التوقيع</td>
			    <td align="center">SIGNATURE &nbsp;&nbsp; التوقيع</td>
			  </tr>
			  <tr>
			    <td style="border-right:thin solid black ;" height="180">&nbsp;</td>
			    <td height="180">&nbsp;</td>
			  </tr>
			  <tr>
			    <td align="center" style="border-right:thin solid black ;">HIRER &nbsp;&nbsp; المستأجر</td>
			    <td align="center">RENTAL AGENT &nbsp;&nbsp; وكيل الإيجار</td>
			  </tr>
			</table>
	    </td>
	    <td width="26%">
				<table  width="100%" border="1"  cellpadding="4" style="border-collapse: collapse;">
		   
		        
		      	 <tr> <td width="55%" class="tablepadd">Tariff</td><td  width="45%" class="tablepadd" align="right">0</td></tr>
		         
		         <tr> <td width="55%" class="tablepadd">Extra Hours Charge</td><td  width="45%" class="tablepadd" align="right">0<%-- <label id="tariff" name="tariff"><s:property value="tariff"/></label> --%></td></tr>
		          
		         <tr> <td width="55%" class="tablepadd">Extra KM Charge</td><td  width="45%" class="tablepadd" align="right">0<%-- <label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/> --%></label></td></tr>       
		                        
		     	 <tr> <td width="55%" class="tablepadd">Fuel</td><td  width="45%" class="tablepadd" align="right">0<%-- <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label> --%></td></tr>
		      
      
      			 <tr> <td width="55%" class="tablepadd">Trafic Fine</td><td  width="45%" class="tablepadd" align="right">0<%-- <label id="lbltraficfine" name="lbltraficfine"><s:property value="lbltraficfine"/> --%></label></td></tr>
       
             	 <tr> <td width="55%" class="tablepadd">Salik</td><td  width="45%" class="tablepadd" align="right">0<%-- <label id="lblsalik" name="lblsalik"><s:property value="lblsalik"/></label> --%></td></tr>
      
                 <tr> <td width="55%" class="tablepadd">Misc</td><td  width="45%" class="tablepadd" align="right">0</td></tr>
                    
                <tr> <td width="55%" class="tablepadd">Discount</td><td  width="45%" class="tablepadd" align="right">0<%-- <label id="lbldiscount" name="lbldiscount"><s:property value="lbldiscount"/></label> --%></td></tr>      
                    
              	<tr> <td width="55%" class="tablepadd">VAT %</td><td  width="45%" class="tablepadd" align="right">0</td></tr>  
              
              	<tr> <td width="55%" class="tablepadd">Total</td><td  width="45%" class="tablepadd" align="right">0</td></tr>
              	
              	<tr> <td width="55%" class="tablepadd">Balance</td><td  width="45%" class="tablepadd" align="right">0<%-- <label id="balance" name="balance"><s:property value="balance"/></label> --%></td></tr>
                
                <tr> <td width="55%" class="tablepadd">Amount Paid</td><td  width="45%" class="tablepadd" align="right">0<%-- <label id="totalpaids" name="totalpaids"><s:property value="totalpaids"/></label> --%></td></tr>
                
                <tr> <td width="55%" class="tablepadd">Clossing Balance</td><td  width="45%" class="tablepadd" align="right">0</td></tr>
              </table>    
		</td>
	  </tr>
	</table>	
  </div>
  <br><br>
  <%-- <table width="100%" border="0" cellpadding="3">
	  <tr>
	    <td width="9%">Client ID</td>
	    <td width="16%"><label id="lblcldocno" name="lblcldocno"><s:property value="lblcldocno"/></label></td>
	    <td width="14%">Out</td>
	    <td width="24%">&nbsp;</td>
	    <td width="13%">In</td>
	    <td width="24%">&nbsp;</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td>Checked By</td>
	    <td><label id="salagent" name="salagent"><s:property value="salagent"/></label></td>
	    <td>Checked By</td>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td>User</td>
	    <td><label id="lbluser" name="lbluser"><s:property value="lbluser"/></label></td>
	    <td>User</td>
	    <td>&nbsp;</td>
	  </tr>
	</table> --%>
	<table width="100%" border="0">
  <tr>
    <td width="10%">Client ID</td>
    <td width="25%"><label id="lblcldocno" name="lblcldocno"><s:property value="lblcldocno"/></label></td>
    <td width="8%">User</td>
    <td width="33%"><label id="lbluser" name="lbluser"><s:property value="lbluser"/></label></td>
    <td width="24%">&nbsp;</td>
  </tr>
</table>
  <P CLASS="breakhere">
    <!-- Page 2 -->
    <div style="border: medium solid black; padding: 5px;">
    	<table width="100%" border="0">
		  <tr>
		    <td width="28%" height="60">&nbsp;</td>
		    <td width="33%" rowspan="2">
		    	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   		 <img src="<%=contextPath%>/icons/epic.jpg" width="100" height="80"  alt=""/>
		    </td>
		    <td width="39%" style="vertical-align:top" align="right"><h1 style="font-size: 18px;">GHANTOOT RENT A CAR EST</h1></td>
		  </tr>
			<tr>
			 <td >&nbsp;</td>
			 <td align="right">P.O.Box 20168 Sarooj Street , Al Ain, UAE</td>
			</tr>
		</table>
		<table width="100%" border="0">
		  <tr>
		    <td align="center"><u><h2 style="margin: 0; padding: 0;">تقريرحالة سيارة</h2></u></td>
		  </tr>
		  <tr>
		    <td align="center"><h2>CAR REPORT</h2></td>
		  </tr>
		</table>
		<table width="100%" border="0" id="carreport">
	  <tr>
	    <td width="14%">Customer Name</td>
	    <td width="69%">: <label id="clname" name="clname"><s:property value="clname"/></label></td>
	    <td width="17%" align="right">اسم المستأجر</td>
	  </tr>
	  <tr>
	    <td>Car No</td>
	    <td>: <label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
	    <td align="right">رقم السياره</td>
	  </tr>
	  <tr>
	    <td>Contract No</td>
	    <td>: <b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b></td>
	    <td align="right">رقم العقد</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	    <td><img src="<%=contextPath%>/icons/replacevehicle.jpg" width="100%" height="60%" alt=""/></td>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td>Body</td>
	    <td>: .......................................................................................................................................................</td>
	    <td align="right">الهيكل</td>
	  </tr>
	  <tr>
	    <td width=35% align="left">Wheel Cups</td>
	    <td width=30% colspan="2">: ......................................................................................................................................&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- </td> -->
	   <!--  <td align="right"> -->اغطية الرنجات</td>
	  </tr>
	  <tr>
	    <td>Rings</td>
	    <td>: .......................................................................................................................................................</td>
	    <td align="right">الرنجات</td>
	  </tr>
	  <tr>
	    <td>Tyres</td>
	    <td>: .......................................................................................................................................................</td>
	    <td align="right">الأطارت</td>
	  </tr>
	  <tr>
	    <td width=35% align="left">Spare Tyre</td>
	    <td width=30% colspan="2">: ......................................................................................................................................&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- </td> -->
	    <!-- <td align="right"> -->الأطار الاحتياطي</td>
	  </tr>
	  <tr>
	    <td>Tools</td>
	    <td>: .......................................................................................................................................................</td>
	    <td align="right">العده</td>
	  </tr>
	  <tr>
	    <td>Antena</td>
	    <td>: .......................................................................................................................................................</td>
	    <td align="right">الهواني</td>
	  </tr>
	  <tr>
	    <td>Lights</td>
	    <td>: .......................................................................................................................................................</td>
	    <td align="right">الأضوأ</td>
	  </tr>
	  <tr>
	    <td>Glasses</td>
	    <td>: .......................................................................................................................................................</td>
	    <td align="right">الزجاج</td>
	  </tr>
	  <tr>
	    <td width=35% align="left">Seats</td>
	    <td width=30% colspan="2">: ................................................................................................................................................&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- </td> -->
	   <!--  <td align="right"> -->المقاعد</td>
	  </tr>
	  <tr>
	    <td width=35% align="left">Remarks</td>
	    <td width=30% colspan="2">: ....................................................................................................................................&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- </td> -->
	    <!-- <td align="right"> -->ملاحظات أخري</td>
	  </tr>
	  </table>
	 <table id="tab">
	
	  <tr>
	    <td width=35% align="left">Original Registartion Card received </td>
	    <td width=30% colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ملكية الأصلية المستلمة</td>
	  </tr>
	  <tr>
	    <td width=35% align="left">If any loss of mulkiya I will be reasponsible for the cost </td>
	    <td width=28% colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    إذا كان أي خسائر في ملكية سوف أكون مسؤولا عن التكلفة</td>
	  </tr>
	 
	</table> 
	
	<table width="100%" border="0">
	  <tr>
	    <td width="33%" align="center">فحص الموظفين</td>
	    <td width="34%" align="center">&nbsp;</td>
	    <td width="33%" align="center">توقيع المستأجر عند الحروج</td>
	  </tr>
	  <tr>
	    <td align="center">Checked By</td>
	    <td align="center">&nbsp;</td>
	    <td align="center">Hirer's Sign. While Exit</td>
	  </tr>
	  <tr>
	    <td align="center" height="50">................................................................................</td>
	    <td align="center" height="50">&nbsp;</td>
	    <td align="center" height="50">...........................................................................</td>
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
    