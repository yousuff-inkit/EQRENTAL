
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
			$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
		 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			var onemonthbefore=new Date();
			onemonthbefore=new Date(onemonthbefore.setMonth(onemonthbefore.getMonth()-1));
			$('#fromdate').jqxDateTimeInput('setDate',onemonthbefore);
			
			$("#startdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 	$("#enddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
			
			$("#starttime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",value:null,showCalendarButton:false});
		 	$("#endtime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",value:null,showCalendarButton:false});
		
			$('#btnupdate').click(function(){
				
				var rowindex=$('#rowindex').val();
				var eqdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'eqdocno');
				var eqclstatus=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'eqclstatus');
				if(eqdocno=="0" || (eqdocno!="0" && eqclstatus=="1")){
					if($('#startdate').jqxDateTimeInput('getDate')==null){
						$.messager.alert('Warning','Please enter start date','warning');
						return false;
					}
					if($('#starttime').jqxDateTimeInput('getDate')==null){
						$.messager.alert('Warning','Please enter start time','warning');
						return false;
					}
					
					var contractdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
					var fleetno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'currentfleetno');
					var calcdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'calcdocno');
					var date=$('#startdate').jqxDateTimeInput('val');
					var time=$('#starttime').jqxDateTimeInput('val');
					var brhid=$('#cmbbranch').val();
					var remarks=$('#remarks').val();
					$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
						if (r){
							$.post('saveData.jsp',{'remarks':remarks,'brhid':brhid,'contractdocno':contractdocno,'fleetno':fleetno,'calcdocno':calcdocno,'date':date,'time':time,'mode':1},function(data,status){
								data=JSON.parse(data);
								if(data.errorstatus=="0"){
									$.messager.alert('Message','Updated Successfully','success');
									funClearData();
									funreload("");
								}
								else{
									$.messager.alert('Warning','Not Updated','warning');
								}
							});		
						}
					});
				}
				else{
					if($('#enddate').jqxDateTimeInput('getDate')==null){
						$.messager.alert('Warning','Please enter end date','warning');
						return false;
					}
					if($('#endtime').jqxDateTimeInput('getDate')==null){
						$.messager.alert('Warning','Please enter end time','warning');
						return false;
					}
					if($('#amount').val()==''){
						$.messager.alert('Warning','Please enter amount','warning');
						return false;
					}
					var startdate=new Date($('#contractGrid').jqxGrid('getcellvalue',rowindex,'startdate'));
					startdate.setHours(0,0,0,0);
					var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
					enddate.setHours(0,0,0,0);
					if(enddate<startdate){
						$.messager.alert('Warning','End date cannot be less than start date','warning');
						return false;
					}
					if(enddate-startdate==0){
						var starttime=new Date();
						var tempstarttime=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'starttime');
						starttime.setHours(tempstarttime.split(":")[0]);
						starttime.setMinutes(tempstarttime.split(":")[1]);
						var endtime=new Date($('#endtime').jqxDateTimeInput('getDate'));
						if(endtime.getHours()<starttime.getHours()){
							$.messager.alert('Warning','End time cannot be less than start time','warning');
							return false;	
						}
						if(endtime.getHours()==starttime.getHours()){
							if(endtime.getMinutes()<starttime.getMinutes()){
								$.messager.alert('Warning','End time cannot be less than start time','warning');
								return false;
							}
						}
					}
					var contractdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
					var fleetno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'currentfleetno');
					var calcdocno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'calcdocno');
					var date=$('#enddate').jqxDateTimeInput('val');
					var time=$('#endtime').jqxDateTimeInput('val');
					var remarks=$('#remarks').val();
					var amount=$('#amount').val();
					var brhid=$('#cmbbranch').val();
					$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
						if (r){
							$.post('saveData.jsp',{'docno':eqdocno,'remarks':remarks,'amount':amount,'brhid':brhid,'contractdocno':contractdocno,'fleetno':fleetno,'calcdocno':calcdocno,'date':date,'time':time,'mode':2},function(data,status){
								data=JSON.parse(data);
								if(data.errorstatus=="0"){
									$.messager.alert('Message','Updated Successfully','success');
									funClearData();
									funreload("");
								}
								else{
									$.messager.alert('Warning','Not Updated','warning');
								}
							});		
						}
					});
				}
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
			if(brhid=="a" || brhid==""){
				$.messager.alert('Warning','Please select branch','warning');
				return false;
			}
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
	<form id="frmEquipBreakdown" action="saveEquipBreakdown">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%">
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
									<tr><td width="31%" align="right"><label class="branch">From Date</label></td><td width="69%"><div id="fromdate" name="fromdate"></div></td></tr>
									<tr><td align="right"><label class="branch">To Date</label></td><td><div id="todate" name="todate"></div></td></tr>
		 							<tr><td colspan="2"><hr></td></tr>
		 							<tr>
		 								<td colspan="2">
		 									<fieldset id="startfield">
		 										<legend>Start Details</legend>
		 										<table style="width:100%;">
		 											<tr>
						 								<td align="right"><label class="branch">Start Date</label></td>
						   								<td><div id="startdate" name="startdate"></div></td>
						   							</tr>
						 							<tr>
						   								<td align="right"><label class="branch">Start Time</label></td>
						   								<td><div id="starttime" name="starttime"></div></td>
						   							</tr>			
		 										</table>
		 									</fieldset>
		 								</td>
		 							</tr>
		 							<tr>
		 								<td colspan="2">
		 									<fieldset id="endfield">
		 										<legend>End Details</legend>
		 										<table style="width:100%;">
		 											<tr>
						 								<td align="right"><label class="branch">End Date</label></td>
						   								<td><div id="enddate" name="enddate"></div></td>
						   							</tr>
						 							<tr>
						   								<td align="right"><label class="branch">End Time</label></td>
						   								<td><div id="endtime" name="endtime"></div></td>
						   							</tr>
						 							<tr>
						   								<td align="right"><label class="branch">Amount</label></td>
						   								<td><input type="text" name="amount" id="amount" style="text-align:right;height:18px;"></td>
						   							</tr>			
		 										</table>
		 									</fieldset>
		 								</td>
		 							</tr>
		 							<tr>
		   								<td align="right"><label class="branch">Remarks</label></td>
		   								<td><input type="text" name="remarks" id="remarks" style="height:18px;"></td>
		   							</tr>
		   							<tr><td colspan="2"><hr></td></tr>
		   							<tr>
										<td colspan="2" align="center"><input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButton"></td>
									</tr>
									<tr><td><br><br><br><br></td></tr>
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
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>
</body>
</html>