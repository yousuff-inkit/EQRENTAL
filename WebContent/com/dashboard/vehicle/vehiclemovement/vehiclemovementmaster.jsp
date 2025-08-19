
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
	 
	 $('#fleetwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#fleetwindow').jqxWindow('close');
	     
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
	     
	 $('#fleetno').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
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




function fleetSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#fleetwindow').jqxWindow('open');
 		$('#fleetwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 

function getfleetdata(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');


	  fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));     }
	 else{
		 }
	 }

function funreload(event)
{
	 var fleetno = document.getElementById("fleetno").value;

	 if(fleetno=="")
		 {
		   $.messager.alert('Message','Search Fleet  ','warning'); 
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
			   document.getElementById("trncodeval").innerText="";
			   document.getElementById("statusval").innerText="";
			   
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 $("#overlay, #PleaseWait").show();
	  $("#vehdiv").load("vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+fromdate+"&todate="+todate);
		   }
		 }
	
	}
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	
}
function funExportBtn(){
	   
	   
	   
	   if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(datamov, 'Vehicle Movement', true);
	    }
	   else
	    {
		   $("#vehmovement").jqxGrid('exportdata', 'xls', 'Vehicle Movement');
	    }
	   
	   
	   
	   
	   
	 }


</script>
</head>
<body onload="hiddenbrh();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 
	 	 <tr><td align="right"><label class="branch">Fleet</label></td>
	 <td align="left"><input type="text" id="fleetno" style="height:20px;width:61%;" name="fleetno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="fleetno"/>' onkeydown="getfleetdata(event);" > </td></tr>
	 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                <tr>    
      <td colspan="2"><p id="vehinfo" style="padding:5px;background-color:#fff;height:180px;width:210px;font: 10px Tahoma;resize:none" name="vehinfo"  readonly="readonly"  ><s:property value="vehinfo" ></s:property></p>  </td></tr>               
                    
           
 <tr><td colspan="2" >&nbsp;</td></tr>  

 <tr><td colspan="2">&nbsp;<font size="3" color="Blue"><b><label id="trncodeval"></label></b></font></td></tr>
 <tr><td colspan="2">&nbsp;<font size="3" color="Blue"><b><label id="statusval"></label></b></font></td></tr>

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height:60px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="vehdiv"><jsp:include page="vehiclemovementGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="fleetwindow"><div></div>
</div>
</div>
</body>
</html>