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
			$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			$('#btnupdate').click(function(){
				var date=$('#date').jqxDateTimeInput('val');
				$.messager.confirm('Confirm', 'Do you want to download?', function(r){
					if (r){
						
						$.post('saveData.jsp',{'date':date},function(data,status){
							data=JSON.parse(data);
							if(data.errorstatus=="0"){
								$.messager.alert('Message','Downloaded Successfully','success');
								funreload("");
							}
							else{
								$.messager.alert('Warning','Not Updated','warning');
							}
						});		
					}
				});
			});
		});
		function funExportBtn(){
			$("#contractGrid").excelexportjs({
				containerid: "contractGrid",
				datatype: 'json',
				dataset: null,
				gridId: "contractGrid",
				columns: getColumns("contractGrid"),
				worksheetName: "Contract Data"
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
	   		$("#contractdiv").load("contractGrid.jsp?brhid="+brhid+"&fromdate="+fromdate+"&todate="+todate+"&id=1");
	 	}
	 	function funClearData(){
	 		$('#startdate,#starttime,#enddate,#endtime').jqxDateTimeInput('setDate',null);
	 		$('#amount,#remarks').val('');
	 		$('#contractGrid').jqxGrid('clear');
	 	}
	</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmEquipUtil" action="saveEquipUtil">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%">
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
									<tr hidden="true"><td width="31%" align="right"><label class="branch">Date</label></td><td width="69%"><div id="date" name="date"></div></td></tr>
		 							<tr><td colspan="2"><hr></td></tr>
		   							<tr>
										<td colspan="2" align="center"><input type="button" name="btnupdate" id="btnupdate" value="Download" class="myButton"></td>
									</tr>
									<tr><td><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr>
			 						<td>
			 							<div id="contractdiv"><%-- <jsp:include page="contractGrid.jsp"></jsp:include> --%></div>
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