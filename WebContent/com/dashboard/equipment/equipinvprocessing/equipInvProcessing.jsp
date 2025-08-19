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
			$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		  
			$('#btnupdate').click(function(){
				var selectedrows=$('#equipGrid').jqxGrid('getselectedrowindexes');
				if(selectedrows.length==0){
					$.messager.alert('Warning','Please select Equipment','warning');
					return false;
				}
				var equiparray=new Array();
				
				for(var i=0;i<selectedrows.length;i++){
					var calcdocno=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'calcdocno');
					var amount=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'amount');
					var vatamt=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'vatamt');
					var netamount=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'netamount');
					var invdate=$('#equipGrid').jqxGrid('getcelltext',selectedrows[i],'invdate');
					var invtodate=$('#equipGrid').jqxGrid('getcelltext',selectedrows[i],'invtodate');
					var daysused=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'daysused');
					var rate=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
					var vatpercent=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'vatpercent');
					var fleetno=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
					var flname=$('#equipGrid').jqxGrid('getcellvalue',selectedrows[i],'flname');
					
					equiparray.push(calcdocno+" :: "+invdate+" :: "+invtodate+" :: "+amount+" :: "+vatamt+" :: "+netamount+" :: "+daysused+" :: "+rate+" :: "+vatpercent+" :: "+fleetno+" :: "+flname);
				}
				var brhid=$('#docbrhid').val();
				var contractdocno=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'doc_no');
				var contractvocno=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'voc_no');
				var cldocno=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'cldocno');
				var periodupto=$('#periodupto').jqxDateTimeInput('val');
				var delcharges=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'delcharges');
				var collectcharges=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'collectcharges');
				var srvcharges=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'srvcharges');
				var srvdesc=$('#contractGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'srvdesc');
				if(delcharges=="" || delcharges==null || delcharges=="undefined" || typeof(delcharges)=="undefined"){
					delcharges="0.0";
				}
				if(collectcharges=="" || collectcharges==null || collectcharges=="undefined" || typeof(collectcharges)=="undefined"){
					collectcharges="0.0";
				}
				if(srvcharges=="" || srvcharges==null || srvcharges=="undefined" || typeof(srvcharges)=="undefined"){
					srvcharges="0.0";
				}
				$.messager.confirm('Confirm', 'Do you want to create invoice?', function(r){
					if (r){
						$.post('saveData.jsp',{'brhid':brhid,'delcharges':delcharges,'collectcharges':collectcharges,'srvcharges':srvcharges,'srvdesc':srvdesc,'contractdocno':contractdocno,'equiparray[]':equiparray,'periodupto':periodupto,'cldocno':cldocno,'contractvocno':contractvocno},function(data,status){
							data=JSON.parse(data);
							var invno=data.invvocno;
							if(data.errorstatus=="0"){
								$.messager.alert('Message','Invoice generated #'+invno,'message');
								$('#equipGrid').jqxGrid('clear');
								funreload("");
							}
							else{
								$.messager.alert('Warning','Not Saved','warning');
								return false;
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
			if(brhid=="" || brhid=="a"){
				$.messager.alert('Warning','Please select a branch','warning');
				return false;
			}
	 		var periodupto=$('#periodupto').jqxDateTimeInput('val');
			 $("#overlay, #PleaseWait").show();

	   		$("#contractdiv").load("contractGrid.jsp?brhid="+brhid+"&periodupto="+periodupto+"&id=1");
	 	}
		
	</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmEquipInvProcessing" action="saveEquipInvProcessing">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%">
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
									<tr><td width="31%" align="right"><label class="branch">Period Upto</label></td><td width="69%"><div id="periodupto" name="periodupto"></div></td></tr>
									<tr><td colspan="2"><hr></td></tr>
		   							<tr>
										<td colspan="2" align="center"><input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButton"></td>
									</tr>
									<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr>
			 						<td>
			 							<div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>
			 							<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' >
										<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
									</td>
			 					</tr>
			 					<tr>
			 						<td>
			 							<div id="equipdiv"><jsp:include page="equipGrid.jsp"></jsp:include></div>
			 						</td>
			 					</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input type="hidden" name="docbrhid" id="docbrhid">
	</form>
</body>
</html>