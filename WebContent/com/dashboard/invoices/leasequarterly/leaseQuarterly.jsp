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
	   getNoSalikConfig();
	   $('#periodupto').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#periodupto').jqxDateTimeInput('focus');
						return false;
					}
				});
});
function getNoSalikConfig(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			document.getElementById("nosalik").value=items;
			var hideproperty="";
			if(items=="1"){
				hideproperty="hidecolumn";
				$('#leaseQuarterlyGrid').jqxGrid('setcolumnproperty', 'acname', 'width', '44%');
			}
			else{
				hideproperty="showcolumn";
				$('#leaseQuarterlyGrid').jqxGrid('setcolumnproperty', 'acname', 'width', '20%');
			}
			$("#leaseQuarterlyGrid").jqxGrid(hideproperty, 'salikamt');
			$("#leaseQuarterlyGrid").jqxGrid(hideproperty, 'trafficamt');
			$("#leaseQuarterlyGrid").jqxGrid(hideproperty, 'saliksrvc');
			$("#leaseQuarterlyGrid").jqxGrid(hideproperty, 'trafficsrvc');
			
		} else {

		}
	}
	x.open("GET","getNoSalikConfig.jsp", true);
	x.send();
}
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
	 var branch = document.getElementById("cmbbranch").value;
     	 var date1= $('#periodupto').jqxDateTimeInput('getText');
     		 //alert("barchval"+barchval);
     		 var client=document.getElementById("hidclient").value;
     		$('#leaseQuarterlyGrid').jqxGrid('clear');
     		$("#leaseQuarterlyGrid").jqxGrid("addrow", null, {});	
     		document.getElementById("btninvoicesave").style.display="none";
     		/* document.getElementById("client").value="";
     		document.getElementById("hidclient").value=""; */
	  $("#leasequarterlycountdiv").load("leaseQuarterlyCountGrid.jsp?branch="+branch+"&date1="+date1+"&client="+client+"&status=1");
	}
	}
function funCalculate(){
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	}
	$("#overlay, #PleaseWait").show(); 
	var rows = $("#leaseQuarterlyGrid").jqxGrid('getrows');
	//alert(rows);
	if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
		return false;
	}
	 var date1= $('#periodupto').jqxDateTimeInput('getText');
	 var client=document.getElementById("hidclient").value;
	 var branchvalue =document.getElementById("cmbbranch").value;
	 $('#leasequarterlydiv').load('leaseQuarterlyGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1');
}
	

	function funNotify(){
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var z=0;
    			    var rows = $("#leaseQuarterlyGrid").jqxGrid('getrows');                    
    	if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
    		return false;
    	}
    			    var selectedRecords = new Array();
                    var selectedrows=$("#leaseQuarterlyGrid").jqxGrid('selectedrowindexes');
        if(rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount==""){
            $.messager.alert('Warning','Please Calculate the Amount');
            return false;
        }
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select an Invoice');
			return false;
		}
		   /* $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
	 			if (r){
	 				
	 				var i=0;
                    $('#invgridlength').val(selectedrows.length);
    			    for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							if(selectedrows[j]==i){
								
								//alert("Inside"+z);
								//selectedRecords[j]=$("#rentalInvoiceGrid").jqxGrid('getrowdata', selectedrows[j]);
								newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "testinvoice"+z)
							    .attr("name", "testinvoice"+z)
							    .attr("hidden","true");
								
							newTextBox.val(rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate);
							
							newTextBox.appendTo('form');
							z++;
							//alert("ddddd"+$("#testinvoice"+z).val());
							}
						}
						if(i==rows.length-1){
							 document.getElementById("mode").value='A';
							 $("#overlay, #PleaseWait").show();
							 document.getElementById("frmDashboardLeaseQuarterlyInvoice").submit();
						}
			}
    			 
    		 			}
    		 	 		});
		 */
		 
		 
		var dataarray=new Array();
		$.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
 			if (r){
		var i=0;
                    $('#gridlength').val(selectedrows.length);
    			     for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							if(selectedrows[j]==i){
								
								//alert("Inside"+z);
								//selectedRecords[j]=$("#rentalInvoiceGrid").jqxGrid('getrowdata', selectedrows[j]);
								/* newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "testinvoice"+z)
							    .attr("name", "testinvoice"+z)
							    .attr("hidden","true"); */
						if(typeof(rows[i].rano)!="undefined" && rows[i].rano!="" && typeof(rows[i].acno)!="undefined" && rows[i].acno!="" && typeof(rows[i].amount)!="undefined" && rows[i].amount!=""){		
							var nosalik=document.getElementById("nosalik").value;
							if(nosalik=="1"){
								dataarray.push(rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+0+"::"+0+"::"+0+"::"+0+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+0+"::"+0+"::"+0+"::"+0);
							}
							else{
								dataarray.push(rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate);	
							}
							
							
							}
							//alert("ddddd"+$("#testinvoice"+z).val());
							z++;
							
							}
							
						}
						//alert(i+"::::::"+rows.length);
						
						/* var temprows=$("#leaseInvoiceGrid").jqxGrid('selectedrowindexes');
						
						for(var i=0;i<temprows.length;i++){
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate
							checkarray.push($('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano'));
						} */
						$('#reqhidden').val(dataarray);
							 document.getElementById("mode").value='A';
							 $("#overlay, #PleaseWait").show();
	    	    				document.getElementById("frmDashboardLeaseQuarterlyInvoice").submit();
						
			}
    		 		
    	    			   
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
		  	//JSONToCSVCon(invoicedata, 'Rental Invoice', true);
		  }
		 else
		  {
			 //$("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
		  }

		
		
	}
		
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardLeaseQuarterlyInvoice" action="saveDashboardLeaseQuarterlyInvoice" method="post">
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
 <input type="hidden" name="hidclient" id="hidclient" >
		 <tr>
	<td colspan="2"><div id="leasequarterlycountdiv"><jsp:include page="leaseQuarterlyCountGrid.jsp"></jsp:include></div></td>
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
<img id="imgloading" alt="" src="../../../../icons/29load.gif"/></div>
<div id="leasequarterlydiv"><jsp:include page="leaseQuarterlyGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="reqhidden" id="reqhidden" value='<s:property value="reqhidden"/>'>
			  <input type="hidden" name="nosalik" id="nosalik" value='<s:property value="nosalik"/>'>
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