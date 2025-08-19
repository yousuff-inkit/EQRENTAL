<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<%String id=request.getParameter("id")==null?"":request.getParameter("id");
String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<% String contextPath=request.getContextPath();%>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}


.icons {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #E0ECF8;
}
</style>
</head>
<body onload="setValues();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form action="saveEquipContractClose" id="frmEquipContractClose" autocomplete="off">
			<jsp:include page="../../../header.jsp"></jsp:include>
			<div class='hidden-scrollbar'>
				<br>
				<table style="width:100%;">
					<tr>
						<td>
							<fieldset>
								<table style="width:100%;" border="0">
									<tr>
										<td align="right" style="width:12%;">Date</td>
										<td style="width:11%;"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
										<td colspan="3">&nbsp;</td>
										<td align="right">Doc No</td>
										<td style="width:10%;">
											<input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>'>
											<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
										</td>
									</tr>
									
									<tr>
										<td align="right">Contract No</td>
										<td><input type="text" id="contractvocno" name="contractvocno" value='<s:property value="contractvocno"/>' onkeydown="getContract(event);" placeholder="Press F3 to Search">
											<input type="hidden" id="contractdocno" name="contractdocno" value='<s:property value="contractdocno"/>' >
										</td>
										<td align="right" style="width:11%;">Details</td>
										<td colspan="2"><input type="text" id="contractdetails" name="contractdetails" value='<s:property value="contractdetails"/>'  style='width:99%;'>
										</td>
									</tr>
									<tr>
										<td align="right">Description</td>
										<td colspan="5"><input type="text" id="desc" name="desc" value='<s:property value="desc"/>'  style='width:99%;'></td>
									</tr>
									<tr>
										<td colspan="7">
											<fieldset><legend>Closing Info</legend>
												<table style="width:100%;">
													<tr>
														<td align="right">End Date</td>
														<td><div id="enddate" name="enddate" value='<s:property value="enddate"/>'></div></td>
														<td align="right">End Time</td>
														<td><div id="endtime" name="endtime" value='<s:property value="endtime"/>'></div></td>
													</tr>
												</table>
											</fieldset>
										</td>
									</tr>
								</table>	
							</fieldset>
						</td>
					</tr>
					<tr>
						<td><div id="rentalcontractgriddiv"><jsp:include page="rentalContractGrid.jsp"></jsp:include></div></td>
					</tr>
				</table>
				
				<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
				<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
				<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
				<input type="hidden" id="hidendtime" name="hidendtime"  value='<s:property value="hidendtime"/>'/>
			</div>
			<div id="equipwindow">
   				<div></div>
			</div>
			<div id="tariffwindow">
   				<div></div>
			</div>
			<div id="contractwindow">
   				<div></div>
			</div>
			<div id="salwindow">
   				<div></div>
			</div>
			<div id="qotwindow">
   				<div></div>
			</div>
		</form>	
	</div>	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#date").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
			$("#enddate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null});
			$("#endtime").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"HH:mm",value:null,showCalendarButton:false});
			$('#equipwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#equipwindow').jqxWindow('close');
       		$('#tariffwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Tariff Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#tariffwindow').jqxWindow('close');
       		$('#contractwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Contract Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#contractwindow').jqxWindow('close');
       		$('#qotwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Quote Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#qotwindow').jqxWindow('close');
       		$('#salwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#salwindow').jqxWindow('close');
       		
       		$('#date').on('change', function (event) {
				var maindate = $('#date').jqxDateTimeInput('getDate');
	      	 	if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
	        		funDateInPeriod(maindate);
	      	 	}
	       	});
			$('#contractvocno').dblclick(function(){
	       		if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
					$('#contractwindow').jqxWindow('open');
					innerWindowSearchContent('contractMasterSearch.jsp','contractwindow');
				}				
	       	});
	       	
		});
		
		function isNumber(evt,id) {
			//Function to restrict characters and enter number only
			var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
				$.messager.alert('Warning','Enter Numbers Only');
		        $("#"+id+"").focus();
		        return false;
			}
		    return true;
		}
		
		function getContract(event){
			if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
				var x= event.keyCode;
				if(x==114){
					$('#contractwindow').jqxWindow('open');
					innerWindowSearchContent('contractMasterSearch.jsp','contractwindow');
				}
			}
		}
		
		function innerWindowSearchContent(url,windowid){
			$.get(url).done(function (data) {
				$('#'+windowid).jqxWindow('setContent', data);
			});
		}
		function funReadOnly(){
			$('#frmEquipContractClose input').attr('readonly', true);
			$('#date').jqxDateTimeInput({'disabled':true});
			var reqid='<%=id%>';
	       	if(reqid=="3"){
	       		var reqbrhid='<%=brhid%>';
	       		$('#brchName').val(reqbrhid);
	       		var reqrefno='<%=refno%>';
	       		funCreateBtn();
	       		getReqRefData(reqrefno);
	       	}
		}
		function funRemoveReadOnly(){
			$('#frmEquipContractClose input').attr('readonly', false);
			$('#docno,#vocno,#contractvocno,#contractdetails').attr('readonly', true);
			if($('#mode').val()=='A' || $('#mode').val()=='E'){
				$('#date').jqxDateTimeInput({'disabled':false});
				$('#rentalContractGrid').jqxGrid('addrow',null,{});
			}
			if($('#mode').val()=='A'){
				$('#date').jqxDateTimeInput('setDate',new Date());
				$('#rentalContractGrid').jqxGrid('clear');
				$('#rentalContractGrid').jqxGrid('addrow',null,{});
			}
			if($('#mode').val()=='E'){
				/*if($('#cmbreftype').val()=='QOT'){
					$('#rentalContractGrid').jqxGrid('clear');
				}*/
			}
			if($('#mode').val()=='D'){
				$('#date').jqxDateTimeInput({'disabled':false});
			}
			
		}
		function funNotify(){
			if($('#contractdocno').val()==''){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Contract is mandatory";
				return 0;
			}
			
			if($('#desc').val().length>1000){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Description - Max 1000 Chars Only";
				return 0;
			}
			if($('#enddate').jqxDateTimeInput('getDate')==null){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Contract End Date is mandatory";
				return 0;
			}
			if($('#endtime').jqxDateTimeInput('getDate')==null){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Contract End Time is mandatory";
				return 0;
			}
			var selectedrows = $("#rentalContractGrid").jqxGrid('getselectedrowindexes');
			if(selectedrows.length==0){
				$.messager.alert('Warning','Please select valid rows');
				return 0;
			}
			var errorstatus=0;
			for(var i=0;i<selectedrows.length;i++){
				var startdate=new Date($('#rentalContractGrid').jqxGrid('getcellvalue',selectedrows[i],'startdate'));
				var starttime=new Date($('#rentalContractGrid').jqxGrid('getcellvalue',selectedrows[i],'starttime'));
				var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
				var endtime=new Date($('#endtime').jqxDateTimeInput('getDate'));
				startdate.setHours(0,0,0,0);
				enddate.setHours(0,0,0,0);
				if(enddate<startdate){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="End date cannot be less than start date";
					errorstatus=1;
					break;
				}
				if(enddate-startdate==0){
					if(endtime.getHours()<starttime.getHours()){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="End time cannot be less than start time";
						errorstatus=1;
						break;
					}
					else if(endtime.getMinutes()<starttime.getMinutes()){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="End time cannot be less than start time";
						errorstatus=1;
						break;
					}	
				}
			}
			if(errorstatus==1){
				return 0;
			}
			var rows = $("#rentalContractGrid").jqxGrid('getrows');
			
		   	var gridlength=0;
		   	for(var i=0;i<selectedrows.length;i++){
		   		newTextBox = $(document.createElement("input"))
		       			.attr("type", "dil")
		       			.attr("id", "closetest"+i)
		       			.attr("name", "closetest"+i)
		           		.attr("hidden", "true"); 
	 			
	 			var calcdocno=$("#rentalContractGrid").jqxGrid('getcellvalue',selectedrows[i],'calcdocno');
	   			newTextBox.val(calcdocno);
				newTextBox.appendTo('form'); 
	   			gridlength++;
		   	}
			$('#gridlength').val(selectedrows.length);
			return 1;
		}
		function funChkButton() {
			/* funReset(); */
		}

		function funSearchLoad(){
			changeContent('masterSearch.jsp'); 
		}
		
		function funFocus(){
	   		$('#date').jqxDateTimeInput('focus'); 	    		
		}
		function setValues() {
			if($('#msg').val()!=""){
				$.messager.alert('Message',$('#msg').val());
			}
			if($('#hidendtime').val()!=''){
				$('#endtime').jqxDateTimeInput('val',$('#hidendtime').val());
			}
			if($('#docno').val()!=''){
				var docno=$('#docno').val();
				$('#rentalcontractgriddiv').load('rentalContractGrid.jsp?docno='+docno+'&id=1');
			}
		}
		
		function funPrintBtn(){
  	   		if (($("#mode").val() == "view") && $("#docno").val()!="") {
  	  			var url=document.URL;
				var reurl=url.split("com/");
 				var win= window.open(reurl[0]+"printEquipContractClose?docno="+document.getElementById("docno").value+"&branch="+$('#brchName').val()+"&closedocno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 				
 				win.focus();
  	   		} 
  	  		else{
 	    		$.messager.alert('Message','Select a Document....!','warning');
 	    	    return false;
 	    	}
		}
		
	</script>
</body>
</html>


