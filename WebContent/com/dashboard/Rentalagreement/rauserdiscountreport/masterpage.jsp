
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	
	   
	  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
}); 
function funExportBtn(){
	   $("#detailsgrid").jqxGrid('exportdata', 'xls', 'RA Cancel List');
	 }

function funreload(event)
{

	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
		
	
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();  
  
	 
	  

	  $("#rtariff").load("rtariffdetails.jsp?"); 
	 var barchval = document.getElementById("cmbbranch").value;
	  $("#detlist").load("listgrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	
		
	}

}
function funExportBtn(){
    
  
  JSONToCSVCon(rauserdiscount, 'RA User Discount', true);
  }

</script>




</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr><td colspan="2">&nbsp;</td></tr>
	   <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr>
   <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
  
                          
                           
    	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 300px;">	</div></td> 
	</tr>	                       
                           
                           
                           
                           
	</table>
	</fieldset>
	
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="detlist"><jsp:include page="listgrid.jsp"></jsp:include></div></td>
			 </tr>
			 <tr>
			 <td><div id="rtariff"><jsp:include page="rtariffdetails.jsp"></jsp:include></div></td>
			 <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include> 
		</tr>
	</table>
</tr>
</table>

</div>

</div>
</body>
</html>
	 