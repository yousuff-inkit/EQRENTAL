<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	document.getElementById("btninvoicesave").style.display="none";
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#client').dblclick(function(){
		    $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
		});
		  document.getElementById("imgloading").style.display="none";
			document.getElementById("chkall").checked=true;
			setAll();
	   setSalik();
	   setTraffic();
	   $('#periodupto').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#periodupto').jqxDateTimeInput('focus');
						return false;
					}
				});
});
function getClient(event){
	 var x= event.keyCode;
    if(x==114){
    	  $('#clientwindow').jqxWindow('open');
  		$('#clientwindow').jqxWindow('focus');
  		 clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
    }
    else{
     }
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){
	 var barchval = document.getElementById("cmbbranch").value;
     	 var date1= $('#periodupto').jqxDateTimeInput('getText');
     		 //alert("barchval"+barchval);
     		 var client=document.getElementById("hidclient").value;
     		$('#rentalInvoiceGrid').jqxGrid('clear');
     		$("#rentalInvoiceGrid").jqxGrid("addrow", null, {});	
     		document.getElementById("btninvoicesave").style.display="none";
     		/* document.getElementById("client").value="";
     		document.getElementById("hidclient").value=""; */
	  $("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1");
	}
	}
function funCalculate(){
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	}
	$("#overlay, #PleaseWait").show(); 
	var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');
	//alert(rows);
	if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
		return false;
	}
	 var date1= $('#periodupto').jqxDateTimeInput('getText');
	 var client=document.getElementById("hidclient").value;
	 var branchvalue =document.getElementById("cmbbranch").value;
	 $('#rentalinvoicediv').load('rentalInvoiceGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1');
}
	

	function funNotify(){
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var z=0;
    			    var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
    	if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
    		return false;
    	}
    			    var selectedRecords = new Array();
                    var selectedrows=$("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');
        if(rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount==""){
            $.messager.alert('Warning','Please Calculate the Amount');
            return false;
        }
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select an Invoice');
			return false;
		}
		   $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
	 			if (r){
	 				
	 				var i=0;
                    $('#invgridlength').val(selectedrows.length);
    			    for(var j=0;j<selectedrows.length;j++){
    			    	newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "testinvoice"+z)
						    .attr("name", "testinvoice"+z)
						    .attr("hidden","true");
						    
						var rano=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'rano');
						var ratype=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'ratype');
						var fromdate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'fromdate');
						var todate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'todate');
						var acno=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'acno');
						var acname=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'acname');
						var amount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'amount');
						var cldocno=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'cldocno');
						var rentalsum=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'rentalsum');
						var accsum=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'accsum');
						var salikamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikamt');
						var trafficamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'trafficamt');
						var saliksrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'saliksrvc');
						var trafficsrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'trafficsrvc');
						var datediff=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'datediff');
						var brhid=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'brhid');
						var curid=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'curid');
						var insurchg=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'insurchg');
						var salikcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikcount');
						var trafficcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'trafficcount');
						var salamount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salamount');
						var salrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salrate');
						
						var salikauhamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhamt');
						var salikdxbamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbamt');
						var salikauhsrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhsrvc');
						var salikdxbsrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbsrvc');
						var salikauhcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhcount');
						var salikdxbcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbcount');
						var salikauhrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhrate');
						var salikdxbrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbrate');
						var salikauhsrvcrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhsrvcrate');
						var salikdxbsrvcrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbsrvcrate');
												
						newTextBox.val(rano+"::"+ratype+"::"+fromdate+"::"+todate+"::"+acno+"::"+acname+"::"+amount+"::"+cldocno+"::"+rentalsum+"::"+accsum+"::"+salikamt+"::"+trafficamt+"::"+saliksrvc+"::"+trafficsrvc+"::"+datediff+"::"+brhid+"::"+curid+"::"+insurchg+"::"+salikcount+"::"+trafficcount+"::"+salamount+"::"+salrate+"::"+salikauhamt+"::"+salikdxbamt+"::"+salikauhsrvc+"::"+salikdxbsrvc+"::"+salikauhcount+"::"+salikdxbcount+"::"+salikauhrate+"::"+salikdxbrate+"::"+salikauhsrvcrate+"::"+salikdxbsrvcrate);
    			    	
    			    	newTextBox.appendTo('form');
						z++;
    			    }
    			    
    			    document.getElementById("mode").value='A';
					$("#overlay, #PleaseWait").show();
					document.getElementById("frmDashboardRentalInvoice").submit();
    			 
    		 	}
    		});
		
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
	}
	function funExportBtn(){

			 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(invoicedata, 'Rental Invoice', true);
		  }
		 else
		  {
			 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
		  }

		
		
	}
		
	
 	function setSalik(){
		
 		if(document.getElementById("chksalik").checked==true){
			document.getElementById("hidchksalik").value="1";
			document.getElementById("hidchkexsalik").value="0";
			document.getElementById("chkall").checked=false;
 		}
 		if(document.getElementById("chkexsalik").checked==true){
			document.getElementById("hidchkexsalik").value="1";
			document.getElementById("hidchksalik").value="0";
			document.getElementById("chkall").checked=false;
 		} 
	}
	
	function setTraffic(){
		
		if(document.getElementById("chktraffic").checked==true){
			document.getElementById("hidchktraffic").value="1";
			document.getElementById("hidchkextraffic").value="0";
			document.getElementById("chkall").checked=false;
		}
		if(document.getElementById("chkextraffic").checked==true){
			document.getElementById("hidchkextraffic").value="1";
			document.getElementById("hidchktraffic").value="0";
			document.getElementById("chkall").checked=false;
		}
		}
	
	 function setAll(){
		 if(document.getElementById("chkall").checked==true){
			 document.getElementById("hidchkall").value="1";
			 $('#chksalik').removeAttr('checked');
			 $('#chkexsalik').removeAttr('checked');
			 $('#chktraffic').removeAttr('checked');
			 $('#chkextraffic').removeAttr('checked');
			 document.getElementById("hidchksalik").value="0";
			 document.getElementById("hidchkexsalik").value="0";
			 document.getElementById("hidchktraffic").value="0";
			 document.getElementById("hidchkextraffic").value="0";
		 }
		 else{
			 document.getElementById("hidchkall").value="0";
			
		 }
	 }
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardRentalInvoice" action="saveDashboardRentalInvoice" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td><label class="branch">Period Upto</label></td><td><div id="periodupto"></div></td></tr>
<tr><td><label class="branch">Client</label></td><td><input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>'></td></tr>
<tr>
  <td colspan="2" align="center"><label class="branch" for="chkall">All</label><input type="checkbox" name="chkall" id="chkall" onchange="setAll();"></td>
  <td width="28%" rowspan="3" align="left">&nbsp;</td>
</tr>
<tr>
  <td colspan="2" align="left"><fieldset><legend>Separate Invoice</legend>
    <div align="center">
      <input type="radio" name="chksalik" id="chksalik" onChange="setSalik();">&nbsp;<label class="branch">Salik</label>&nbsp;&nbsp;
      <input type="radio" name="chktraffic" id="chktraffic" onchange="setTraffic();">&nbsp;<label class="branch">Traffic</label>
      </div>
  </fieldset></td>
  </tr> 
 
  <tr>
  <td colspan="2" align="left"><fieldset><legend>Not To Be Invoiced</legend>
    <div align="center">
      <input type="radio" name="chksalik" id="chkexsalik" onChange="setSalik();">&nbsp;<label class="branch">Salik</label>&nbsp;&nbsp;
      <input type="radio" name="chktraffic" id="chkextraffic" onchange="setTraffic();">&nbsp;<label class="branch">Traffic</label>
      </div>
  </fieldset></td>
  </tr> 
   <tr>
  </tr> 
 <input type="hidden" name="hidchkall" id="hidchkall" value='<s:property value="hidchkall"/>'>
  <input type="hidden" name="hidchksalik" id="hidchksalik" value='<s:property value="hidchksalik"/>'>
  <input type="hidden" name="hidchktraffic" id="hidchktraffic" value='<s:property value="hidchktraffic"/>'>
   <input type="hidden" name="hidchkexsalik" id="hidchkexsalik" value='<s:property value="hidchkexsalik"/>'>
  <input type="hidden" name="hidchkextraffic" id="hidchkextraffic" value='<s:property value="hidchkextraffic"/>'>
<input type="hidden" name="hidclient" id="hidclient" >
		 <tr>
	<td colspan="2"> <div id="Readygrid" ><jsp:include page="invnoGrid.jsp"></jsp:include>
	</div> </td>
	</tr> 
	<tr>
	<td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
	</tr>
	<tr>
	<td colspan="2"></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/29load.gif"/></div> <div id="rentalinvoicediv"><jsp:include page="rentalInvoiceGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>