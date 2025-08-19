
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
	 
	 $('#clientwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	     
	     
	     
	 $('#client').dblclick(function(){
	  	    $('#clientwindow').jqxWindow('open');
	   
	  	  clientSearchContent('clientSearch.jsp?', $('#clientwindow')); 
    });
	 
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




function clientSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 

function getClientData(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientwindow').jqxWindow('open');


	  clientSearchContent('clientSearch.jsp?', $('#clientwindow'));     }
	 else{
		 }
	 }

function funreload(event)
{
	 var client = document.getElementById("hidclient").value;

	 if(client=="")
		 {
		   $.messager.alert('Message','Search Client  ','warning'); 
		   return 0;
		 }
	 else
		 {
		 
		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else{
		 
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	  $("#vehiclediv").load("vehicleMovementGrid.jsp?client="+client+"&fromdate="+fromdate+"&todate="+todate);
	  $("#vehiclesummdiv").load("vehicleSummaryGrid.jsp?client="+client+"&fromdate="+fromdate+"&todate="+todate+"&ready=1");
		   }
		 }
	
	}
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	
}

function funPrintMov(){
	var client = document.getElementById("hidclient").value;

	 if(client=="")
		 {
		   $.messager.alert('Message','Search Client  ','warning'); 
		   return false;
		 }
	 else
		 {
    var url=document.URL;
    var reurl=url.split("vehicleMovement.jsp");
  
    var win= window.open(reurl[0]+"printClientVehicleMov?client="+document.getElementById("hidclient").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
		 }
}

</script>
</head>
<body onload="hiddenbrh();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" rowspan="2" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 
	 	 <tr><td align="right"><label class="branch">Client</label></td>
	 <td align="left"><input type="text" id="client" style="height:20px;width:61%;" name="client" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly value='<s:property value="client"/>' onkeydown="getClientData(event);" > </td></tr>
	 <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'/>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                <tr>    
      <td colspan="2"><textarea id="clientinfo" style="height:180px;width:200px;font: 10px Tahoma;resize:none" name="clientinfo"  readonly="readonly"  ><s:property value="clientinfo" ></s:property></textarea>  </td></tr>               
                    
    <tr><td colspan="2">&nbsp;</td></tr>               
  <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnPrint" name="btnPrint" onclick="funPrintMov(event);">Print</button></td></tr>                  
                 

<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height:125px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
 			 <td height="274"><div id="vehiclediv"><jsp:include page="vehicleMovementGrid.jsp"></jsp:include></div></td>
			 <!--<td></td>-->
		</tr>
	</table>
</tr>
<tr>
<td><div id="vehiclesummdiv"><jsp:include page="vehicleSummaryGrid.jsp"></jsp:include></div></td>
</tr>
</table>

</div>
<div id="clientwindow"><div></div>
</div>
</div>
</body>
</html>