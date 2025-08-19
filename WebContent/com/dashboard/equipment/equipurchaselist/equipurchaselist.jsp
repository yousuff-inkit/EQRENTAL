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
	<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
	<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
	<script type="text/javascript">
		$(document).ready(function () {
			$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
			$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
		       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
		       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
		       document.getElementById("sum").checked=true;
		       funchange();
		});
		function funExportBtn(){
			if(document.getElementById("sum").checked){
			$("#contractdiv").excelexportjs({
				containerid: "contractdiv",
				datatype: 'json',
				dataset: null,
				gridId: "contractGrid",
				columns: getColumns("contractGrid"),
				worksheetName: "Equipurchaselist1"
			});
			}else if(document.getElementById("det").checked){
			$("#vehpuchase").excelexportjs({
				containerid: "vehpuchase",
				datatype: 'json',
				dataset: null,
				gridId: "vehpurchasedirgrid",
				columns: getColumns("vehpurchasedirgrid"),
				worksheetName: "Equipurchaselist2"
			});	
			}else{}
		}
	
	 
		function funreload(event){
			var brhid = document.getElementById("cmbbranch").value;
			var todate=$('#todate').val();
	 		var fromdate=$('#fromdate').val();
	   		$("#overlay, #PleaseWait").show();
	   		if(document.getElementById("sum").checked){
	   			$("#contractdiv").load("contractGrid.jsp?brhid="+brhid+"&fromdate="+fromdate+"&id=1&todate="+todate);
	 		}else if(document.getElementById("det").checked){
	 			 $("#vehpuchase").load("vehpurchaseDetails.jsp?brhid="+brhid+"&fromdate="+fromdate+"&id=1&todate="+todate);
	 		}else{}
	   		
	 	}
	 	function funClearData(){
	 		$('#contractGrid').jqxGrid('clear');
	 	}
	 	function funchange(){
	 		if(document.getElementById("sum").checked){
	 			$("#vehpuchase").hide();
	 			$("#contractdiv").show();
	 		}else if(document.getElementById("det").checked){
	 			$("#vehpuchase").show();
	 			$("#contractdiv").hide();  
	 		}else{}
	 	}
	</script>
</head>
<body onload="getBranch();">
	<form id="frmEquippurlist">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%">
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
									<tr><td width="31%" align="right"><label class="branch">From Date</label></td><td width="69%"><div id="fromdate" name="fromdate"></div></td></tr>
									<tr><td width="31%" align="right"><label class="branch">To Date</label></td><td width="69%"><div id="todate" name="todate"></div></td></tr>
									 <tr><td colspan="2" align="center"><label for="sum" class="branch">Summary</label>
                                     <input type="radio" id="sum" name="rdio" value="summary" onchange="funchange()">
                                     <label for="det" class="branch">Detail</label>
                                     <input type="radio" id="det" name="rdio" value="detail" onchange="funchange()"></td></tr>
									<tr><td colspan="2"><hr></td></tr>
									<tr><td><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>   
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr>
			 						<td>
			 							<div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>
									</td>
			 					</tr>
			 					<tr>
			 						 <td>
                                   <div id="vehpuchase"><jsp:include page="vehpurchaseDetails.jsp"></jsp:include></div> 
                                </td>
			 					</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>
</body>
</html>