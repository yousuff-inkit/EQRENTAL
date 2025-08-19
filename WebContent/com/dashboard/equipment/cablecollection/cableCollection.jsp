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
	    	
	    	$("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
		 	$("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			var onemonthbefore=new Date();
			onemonthbefore=new Date(onemonthbefore.setMonth(onemonthbefore.getMonth()-1));
			$('#fromdate').jqxDateTimeInput('setDate',onemonthbefore);
			
		});
		function funExportBtn(){
			$("#cableGrid").excelexportjs({
				containerid: "cableGrid",
				datatype: 'json',
				dataset: null,
				gridId: "cableGrid",
				columns: getColumns("cableGrid"),
				worksheetName: "Cable Data"
			});
						
		}
	
		function setValues(){
			if(($('#msg').val()!="")){
				$.messager.alert('Message',$('#msg').val());
			}
		}
		function funreload(event){
			var brhid = document.getElementById("cmbbranch").value;
			/*if(brhid=="a" || brhid==""){
				$.messager.alert('Warning','Please select branch','warning');
				return false;
			}*/
	 		var fromdate=$('#fromdate').jqxDateTimeInput('val');
			var todate=$('#todate').jqxDateTimeInput('val');
			
			var collectstatus="1";
			if(document.getElementById("rdotobecollected").checked==true){
				collectstatus="1";
			}
			else if(document.getElementById("rdoall").checked==true){
				collectstatus="0";
			}
	   		$("#overlay, #PleaseWait").show();
	   		$("#cablediv").load("cableGrid.jsp?brhid="+brhid+"&fromdate="+fromdate+"&todate="+todate+"&id=1&collectstatus="+collectstatus);
	 	}
	 	function funClearData(){
	 		$('#contractGrid').jqxGrid('clear');
	 	}
	 	
	 	function funCollectCable(){
	 		var gridindex=$('#rowindex').val();
	 		var contractdocno=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "contractdocno");
	 		var contractvocno=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "contractvocno");
	 		var collectqty=$('#collectqty').val();
	 		var assetgrpdocno=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "assetgrpdocno");
	 		var cablerowno=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "cablerowno");//rowno in my_cableissue
	 		var cableqty=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "qty");//Qty of cable issued
	 		var savedcollectqty=$('#cableGrid').jqxGrid('getcellvalue', gridindex, "collectqty");//Qty of cable collected
	 		
	 		if(parseFloat(collectqty)>parseFloat(cableqty)){
	 			$.messager.alert('Warning','Collect Qty cannot be more than issued qty');
	 			$('#collectqty').val($('#cableGrid').jqxGrid('getcellvalue', gridindex, "qty"));
	 			return false;
	 		}
	 		
	 		if(parseFloat(cableqty)-parseFloat(savedcollectqty)==0){
	 			$.messager.alert('Warning','Collection already done');
	 			return false;
	 		}
	 		$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 			if (r){
	 				$.post('collectCable.jsp',{'contractdocno':contractdocno,'collectqty':collectqty,'assetgrpdocno':assetgrpdocno,'cablerowno':cablerowno},function(data,status){
	 		 			data=JSON.parse(data);
	 		 			if(data.errorstatus=="0"){
	 		 				$.messager.alert('Message','Successfully Collected');
	 		 				funreload("");
	 		 			}
	 		 			else{
	 		 				$.messager.alert('Warning','Not Collected');
	 		 			}
	 		 		});
	 			}
	 		});
	 		
	 		
	 	}
	</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmCableCollection" >
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
		 							<tr><td colspan="2" align="center"><input type="radio" name="rdotype" id="rdotobecollected" checked>&nbsp;<label class="branch">To Be Collected</label> <input type="radio" name="rdotype" id="rdoall">&nbsp;<label class="branch">All</label></td></tr>
		 							<tr><td colspan="2"><hr></td></tr>
		 							<tr>
		 								<td colspan="2" align="center"><label class="branch" style="font-weight:bold;color:red;">Selected Contract : <span class="selected-contract"></span></label></td>
		 							</tr>
		 							<tr><td align="right"><label class="branch">Cable</label></td><td><input type="text" name="cablename" id="cablename" disabled style="height:18px;"></td></tr>
		 							<tr><td align="right"><label class="branch">Quantity</label></td><td><input type="text" name="collectqty" id="collectqty" style="height:18px;"></td></tr>
		 							<tr><td colspan="2"><hr></td></tr>
									<tr><td colspan="2" align="center"><button type="button" name="btncollect" id="btncollect" class="myButton" onclick="funCollectCable();">Collect</button></td></tr>
									<tr><td><br><br><br><br><br><br><br><br><br><br></td></tr>
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr>
			 						<td>
			 							<div id="cablediv"><jsp:include page="cableGrid.jsp"></jsp:include></div>
			 							<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' >
										<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
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