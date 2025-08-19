<jsp:include page="../../../../includes.jsp"></jsp:include>  

<%@ taglib prefix="s" uri="/struts-tags" %>

<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>

.icons {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #ECF8E0;
}
.iconss {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #ECF8E0;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	$('#vehiclewindow').jqxWindow({ autoOpen: false,width: '80%', height: '80%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 240, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	$('#fleetno').dblclick(function(){
		$('#vehiclewindow').jqxWindow('open');
		$('#vehiclewindow').jqxWindow('focus');
	 	vehicleSearchContent('vehiclewindow.jsp', $('#vehiclewindow'));
	});
});
function vehicleSearchContent(url) {
	$('#vehiclewindow').jqxWindow('focus'); 
	$.get(url).done(function (data) {
		$('#vehiclewindow').jqxWindow('setContent', data);
	});  
}
function funreload(event)  
{     
	var branch = document.getElementById("cmbbranch").value;
	$("#vehlistdiv").load("vehListGrid.jsp?branch="+branch+"&id=1");
}
	
	
function funExportBtn()
{	
	if(parseInt(window.parent.chkexportdata.value)=="1"){
		JSONToCSVCon(exceldata, 'For Sale Vehicle List', true);
	}
 	else{
		
	}
}
</script>
</head>
  
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<div class='hidden-scrollbar'>
			<table width="100%">
				<tr>
					<td width="20%">
    					<fieldset style="background: #ECF8E0;">
							<table width="100%" >
								<jsp:include page="../../heading.jsp"></jsp:include>
								<tr><td colspan="2">&nbsp;</td></tr> 
								<tr>
									<td align="right"><label class="branch">&nbsp;</label></td>
									<td><input type="hidden" name="fleetno" id="fleetno" style="height:20px;width:90%;" readonly="readonly" value='<s:property value="fleetno"/>' ></td>
								</tr>
								<tr><td colspan="2" align="center"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
								<tr><td colspan="2" ></td></tr> 
							</table>
						</fieldset>
					</td>
					<td width="80%">
						<table width="100%">
							<tr>
			 					<td><div id="vehlistdiv"><jsp:include page="vehListGrid.jsp"></jsp:include></div></td>
			 				</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div id="vehiclewindow">
			<div></div>
		</div> 
	</div>
</body>
</html>