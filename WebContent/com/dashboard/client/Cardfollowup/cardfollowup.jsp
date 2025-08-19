
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
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#clientcatwindow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '85%' ,maxWidth: '40%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientcatwindow').jqxWindow('close');	
    $('#clientcat').dblclick(function(){
		$('#clientcatwindow').jqxWindow('open');
		$('#clientcatwindow').jqxWindow('focus');
		clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow'));
	});
    $('#btnclear').click(function(){
    	$('#uptodate').jqxDateTimeInput('setDate',new Date());
    	$('#clientcat,#hidclientcat,#rentalstatus').val('');
    	$('#rentaltype').val('RAG');
    	$('#followup').jqxGrid('clear');
    }); 
   
});
function getClientCat(event){
	 var x= event.keyCode;
    if(x==114){
    	$('#clientcatwindow').jqxWindow('open');
		$('#clientcatwindow').jqxWindow('focus');
		clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow'));
    }
    else{
     }
}
function clientCatSearchContent(url) {
	$.get(url).done(function (data) {
	    $('#clientcatwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var rentaltype=document.getElementById("rentaltype").value;
	 var rentalstatus=document.getElementById("rentalstatus").value;
	 var uptodate=$('#uptodate').jqxDateTimeInput('val');
	 var clientcat=$('#hidclientcat').val();
	   $("#overlay, #PleaseWait").show();
	  $("#cradfwdiv").load("cardfollowupGrid.jsp?barchval="+barchval+'&uptodate='+uptodate+'&type='+rentaltype+'&check=1&rentalstatus='+rentalstatus+'&clientcat='+clientcat);
	
	
	}

	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(exceldata, 'Card Block Followup', true);
		 } else {
			 $("#followup").jqxGrid('exportdata', 'xls', 'Card Block Followup');
		 }
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
		<table width="100%"  >
			<jsp:include page="../../heading.jsp"></jsp:include>
	 		<tr><td colspan="2">&nbsp;</td></tr>
	  		<tr>
				<td align="left" colspan="2">
					<table>
						<tr><td align="right"><label class="branch">Upto Date</label></td><td><div id="uptodate" name="uptodate"></div></td></tr>
						<tr><td align="right"><label class="branch">Client Category</label></td>
        					<td align="left">
					        	<input type="text" readonly id="clientcat" name="clientcat" value='<s:property value="clientcat"/>' onkeydown="getClientCat(event);" style="height:18px;" placeholder="Press F3 to Search">
      							<input type="hidden" readonly id="hidclientcat" name="hidclientcat" value='<s:property value="hidclientcat"/>' >
      						</td>
      					</tr>
						<tr><td align="right"><label class="branch">Rental Type</label></td>
        					<td align="left">
					        	<select id="rentaltype" name="rentaltype"  value='<s:property value="rentaltype"/>' style="width:125px;">
					     			<!--  <option value="">--Select--</option> -->
					       			<option value="RAG">Rental</option>
					        		<option value="LAG">Lease</option>
					      		</select>
      						</td>
      					</tr>
      					<tr><td align="right"><label class="branch">Rental Status</label></td>
        					<td align="left">
					        	<select id="rentalstatus" name="rentalstatus"  value='<s:property value="rentalstatus"/>' style="width:125px;">
					     			<option value="">All</option>
					       			<option value="0">Opened</option>
					        		<option value="1">Closed</option>
					      		</select>
      						</td>
      					</tr>
      					<tr><td align="center" colspan="2"><hr></td></tr>
      					<tr>
      						<td align="center" colspan="2">
      							<button type="button" id="btnclear" name="btnclear" class="myButton">Clear</button>
      						</td>
      					</tr>
   					</table>
 				</td>
			</tr> 
	 <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td colspan="2"><div id='pieChart1' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="cradfwdiv"><jsp:include page="cardfollowupGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientcatwindow">
<div></div>
</div>
</div>
</body>
</html>