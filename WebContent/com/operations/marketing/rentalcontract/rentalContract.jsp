<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
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
		<form action="saveRentalContract" id="frmRentalContract" autocomplete="off">
			<jsp:include page="../../../../header.jsp"></jsp:include>
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
										<td colspan="5">&nbsp;</td>
										<td align="right">Doc No</td>
										<td style="width:10%;">
											<input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>'>
											<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
										</td>
									</tr>
									<tr>
										<td align="right">Client</td>
										<td><input type="text" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>' onkeydown="getClient(event);" placeholder="Press F3 to Search"></td>
										<td colspan="7"><input type="text" id="clientdetails" name="clientdetails" value='<s:property value="clientdetails"/>' style='width:97.3%;' onkeydown="getClient(event);" placeholder="Client Details"></td>
									</tr>
									<tr>
										<td align="right">Ref Type</td>
										<td><select name="cmbreftype" id="cmbreftype"><option value="QOT">Quote</option></select>
											<input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>' >
										</td>
										<td align="right" style="width:11%;">Ref No</td>
										<td><input type="text" id="refno" name="refno" value='<s:property value="refno"/>' onkeydown="getRefno(event);" placeholder="Press F3 to Search">
											<input type="hidden" id="hidrefno" name="hidrefno" value='<s:property value="hidrefno"/>' >
										</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td align="right">Salesman</td>
										<td>
											<input type="text" id="salesman" name="salesman" value='<s:property value="salesman"/>' onkeydown="getSalesman(event);" placeholder="Press F3 to Search">
											<input type="hidden" id="hidsalesman" name="hidsalesman" value='<s:property value="hidsalesman"/>'>
										</td>
										<td align="right">LPO No</td>
										<td><input type="text" id="lpono" name="lpono" value='<s:property value="lpono"/>'></td>
										<td align="right">LPO Date</td>
										<td><div id="lpodate" name="lpodate" value='<s:property value="lpodate"/>'></div></td>						
									</tr>
									<tr>
										<td align="right">Hire Mode</td>
										<td><select name="cmbhiremode" id="cmbhiremode" >
												<option value="">--Select--</option>
												<option value="Daily">Daily</option>
												<option value="Weekly">Weekly</option>
												<option value="Monthly">Monthly</option>
											</select>
											<input type="hidden" id="hidcmbhiremode" name="hidcmbhiremode" value='<s:property value="hidcmbhiremode"/>'>
										</td>
										<td align="right">Hire From Date</td>
										<td><div id="hirefromdate" name="hirefromdate" value='<s:property value="hirefromdate"/>'></div></td>
										
									</tr>
									<tr>
										<td align="right">Description</td>
										<td colspan="9"><input type="text" id="desc" name="desc" value='<s:property value="desc"/>'  style='width:99%;'></td>
									</tr>
									
										<tr>
								<td align="right">Delivery Charges</td>
								<td>
									<input type="text" id="delcharges" name="delcharges" value='<s:property value="delcharges"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id),funCalTotal();">
								</td>
								
								<td align="right">Collection Charges</td>
								<td>
									<input type="text" id="collcharges" name="collcharges" value='<s:property value="collcharges"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id),funCalTotal();">
								</td>
								
								<td align="right">Service Charges</td>
								<td>
									<input type="text" id="srvcharges" name="srvcharges" value='<s:property value="srvcharges"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id),funCalTotal();">
								</td>
						
								<td align="right">VAT Amount</td>
								<td>
									<input type="text" id="vatamt" name="vatamt" value='<s:property value="vatamt"/>' style="text-align:right;">
								</td>

								<td align="right">Total</td>
								<td>
									<input type="text" id="totalamt" name="totalamt" value='<s:property value="totalamt"/>' style="text-align:right;width:92%;">
								</td>
							</tr>
							
							<tr>
								<td align="right">Delivery Remark</td>
								<td colspan="9"><input type="text" id="delremark" name="delremark" value='<s:property value="delremark"/>'  style='width:99%;'></td>
							</tr>
							
							<tr>
								<td align="right">Service Description</td>
								<td colspan="8"><input type="text" id="srvdesc" name="srvdesc" value='<s:property value="srvdesc"/>' style='width:98.65%;'></td>
								<td align="center"><button type="button" class="myButton" id="btnloadquote">Load Quote</button></td>
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
				<input type="hidden" id="hidtaxperc"/>
			</div>
			<div id="equipwindow">
   				<div></div>
			</div>
			<div id="tariffwindow">
   				<div></div>
			</div>
			<div id="clientwindow">
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
			$("#lpodate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
			$("#hirefromdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       		$('#equipwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#equipwindow').jqxWindow('close');
       		$('#tariffwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Tariff Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#tariffwindow').jqxWindow('close');
       		$('#clientwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#clientwindow').jqxWindow('close');
       		$('#qotwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Quote Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#qotwindow').jqxWindow('close');
       		$('#salwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#salwindow').jqxWindow('close');
       		
       		$('#date').on('change', function (event) {
				var maindate = $('#date').jqxDateTimeInput('getDate');
	      	 	if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
	        		funDateInPeriod(maindate);
	        		getTaxper($("#date").jqxDateTimeInput('val'));
	      	 	}
	       	});
			$('#cldocno,#clientdetails').dblclick(function(){
	       		if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
					$('#clientwindow').jqxWindow('open');
					innerWindowSearchContent('clientMasterSearch.jsp','clientwindow');
				}				
	       	});
	       	$('#salesman').dblclick(function(){
	       		if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
					$('#salwindow').jqxWindow('open');
					innerWindowSearchContent('salesmanSearchGrid.jsp?id=1','salwindow');
				}				
	       	});
	       	$('#refno').dblclick(function(){
	       		if (($("#mode").val() == "A" || $("#mode").val() == "E") && $('#cmbreftype').val()=='QOT') { 
	       			if($('#cldocno').val()==''){
	       				$.messager.alert('Warning','Please Select Client');
	       				$("#cldocno").focus();
	       				return false;
	       			}
					$('#qotwindow').jqxWindow('open');
					innerWindowSearchContent('quoteMasterSearch.jsp','qotwindow');
				}				
	       	});
	       	
	       	$('#btnloadquote').click(function(){
	       		if($('#mode').val()=='A' || $('#mode').val()=='E'){
	       			if($('#cmbreftype').val()=='DIR'){
	       				$.messager.alert('Warning','Please Select Quotation');
	       				$("#cmbreftype").focus();
	       				return false;
	       			}
	       			if($('#cmbreftype').val()==''){
	       				$.messager.alert('Warning','Please Select Quotation');
	       				$("#refno").focus();
	       				return false;
	       			}
	       			if($('#cmbhiremode').val()==''){
	       				$.messager.alert('Warning','Please Select Hire mode');
	       				$("#cmbhiremode").focus();
	       				return false;
	       			}
	       			var quoteno=$('#hidrefno').val();
	       			var hiremode=$('#cmbhiremode').val();
	       			$('#rentalcontractgriddiv').load('rentalContractGrid.jsp?quoteno='+quoteno+'&hiremode='+hiremode+'&id=2');
	       		}
	       	});
	       	
		});
		
		function getTaxper(date){
			var x = new XMLHttpRequest();
		    x.onreadystatechange = function(){
			    if (x.readyState == 4 && x.status == 200) {
				    var items = x.responseText.trim();
				    $('#hidtaxperc').val(items);
			    }
		    }
		   x.open("GET", "getTaxper.jsp?date="+date, true);
		   x.send();
		}
		
		function getReqRefData(reqrefno){
			$.get('getReqRefData.jsp',{'refno':reqrefno},function(data){
				data=JSON.parse(data);
				if(data.errorstatus=="1"){
					$.messager.alert('Warning','Cannot find approved quotes');
					return false;
				}
				else{
					$('#cldocno').val(data.cldocno);
					$('#clientdetails').val(data.clientdetails);
					$('#refno').val(data.refno);
					$('#cmbreftype').val(data.reftype);
					$('#salesman').val(data.salesman);
					$('#hidsalesman').val(data.salid);
					$('#delcharges').val(data.delcharges);
					$('#collcharges').val(data.collcharges);
					$('#vatamt').val(data.vatamt);
					$('#totalamt').val(data.totalamt);
					$('#desc').val(data.description);
					$('#delremark').val(data.delremark);
					$('#srvcharges').val(data.srvcharges);
					$('#srvdesc').val(data.srvdesc);
					$('#hidrefno').val(data.hidrefno);
					$('#date').jqxDateTimeInput('setDate',new Date());
					getTaxper($('#date').jqxDateTimeInput('val'));
				}
				
			});
		}
		 function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
		    }
		function getClient(event){
			if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
				var x= event.keyCode;
				if(x==114){
					$('#clientwindow').jqxWindow('open');
					innerWindowSearchContent('clientMasterSearch.jsp','clientwindow');
				}
			}
		}
		function getQuote(event){
			if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
				var x= event.keyCode;
				if(x==114){
					$('#qotwindow').jqxWindow('open');
					innerWindowSearchContent('quoteMasterSearch.jsp','qotwindow');
				}
			}
		}
		function getSalesman(event){
			if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
				var x= event.keyCode;
				if(x==114){
					$('#salwindow').jqxWindow('open');
					innerWindowSearchContent('salesmanSearchGrid.jsp?id=1','salwindow');
				}
			}
		}
		
		function funCalTotal(){
			if($('#mode').val()=='A' || $('#mode').val()=='E'){
			var delcharges=$.isNumeric($("#delcharges").val())?parseFloat($("#delcharges").val()):0;
			var collcharges=$.isNumeric($("#collcharges").val())?parseFloat($("#collcharges").val()):0;
			var srvcharges=$.isNumeric($("#srvcharges").val())?parseFloat($("#srvcharges").val()):0;
			var vatperc=parseFloat($('#hidtaxperc').val());		    	
	    	
			var tot=(delcharges+collcharges+srvcharges).toFixed(2);
			var vatamt = (parseFloat(tot)*(vatperc/100)).toFixed(2);
	   		var totalamt = (parseFloat(tot) + parseFloat(vatamt)).toFixed(2);
	   		$("#vatamt").val(vatamt)
	   		$("#totalamt").val(totalamt)
			}
		}
		
		function innerWindowSearchContent(url,windowid){
			$.get(url).done(function (data) {
				$('#'+windowid).jqxWindow('setContent', data);
			});
		}
		function funReadOnly(){
			$('#frmRentalContract input').attr('readonly', true);
			$('#date').jqxDateTimeInput({'disabled':true});
			var reqid='<%=id%>';
	       	if(reqid=="3"){
	       		var reqbrhid='<%=brhid%>';
	       		$("#brchName").val(reqbrhid);
	       		var reqrefno='<%=refno%>';
	       		funCreateBtn();
	       		getReqRefData(reqrefno);
	       	}
		}
		function funRemoveReadOnly(){
			$('#frmRentalContract input').attr('readonly', false);
			$('#docno,#vocno,#cldocno,#clientdetails,#vatamt,#totalamt').attr('readonly', true);
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
			getTaxper($("#date").jqxDateTimeInput('val'));
		}
		
		function funNotify(){
			if($('#cldocno').val()==''){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Client is mandatory";
				return 0;
			}
			if($('#cmbhiremode').val()==''){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Hire Mode is mandatory";
				return 0;
			}
			if($('#cmbreftype').val()=='QOT' && $('#refno').val()==''){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Ref No is mandatory";
				return 0;
			}
			if($('#cmbhiremode').val().length>1000){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Description - Max 1000 Chars Only";
				return 0;
			}
			var rows = $("#rentalContractGrid").jqxGrid('getrows');
			var selectedrows = $("#rentalContractGrid").jqxGrid('getselectedrowindexes');
			if(selectedrows.length==0){
				$.messager.alert('Warning','Please select valid rows');
				return 0;
			}
		   	var gridlength=0;
		   	for(var i=0 ; i < selectedrows.length ; i++){
		   		var orgindex=selectedrows[i];
		   		if(rows[orgindex].subcatid!=null && rows[orgindex].subcatid!="" && rows[orgindex].subcatid!="undefined" && typeof(rows[orgindex].subcatid)!="undefined"){
					newTextBox = $(document.createElement("input"))
		       			.attr("type", "dil")
		       			.attr("id", "quottest"+i)
		       			.attr("name", "quottest"+i)
		           		.attr("hidden", "true"); 
		 
		   			newTextBox.val(rows[orgindex].subcatid+" :: "+rows[orgindex].grpid+" :: "+rows[orgindex].tarifdocno+" :: "+rows[orgindex].qty+" :: "+rows[orgindex].hiremode+" :: "+rows[orgindex].subtotal+" :: "+rows[orgindex].maxdiscount+" :: "+rows[orgindex].discount+" :: "+rows[orgindex].total+" :: "+rows[orgindex].vatperc+" :: "+rows[orgindex].vatamt+" :: "+rows[orgindex].nettotal+" :: "+rows[orgindex].flname+" :: "+rows[orgindex].detaildocno);
					newTextBox.appendTo('form'); 
		   			gridlength++;	
		   		}
			}
			$('#gridlength').val(gridlength);
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
			if($('#hidcmbreftype').val()!=''){
				$('#cmbreftype').val($('#hidcmbreftype').val());
			}
			if($('#hidcmbhiremode').val()!=''){
				$('#cmbhiremode').val($('#hidcmbhiremode').val());
			}
			if($('#docno').val()!=''){
				var docno=$('#docno').val();
				$('#rentalcontractgriddiv').load('rentalContractGrid.jsp?docno='+docno+'&id=1');
				funCheckEditStatus();
			}
		}
		
		function funCheckEditStatus(){
			var docno=$('#docno').val();
			$.get('checkEditStatus.jsp',{'docno':docno},function(data){
				data=JSON.parse(data);
				if(parseInt(data.status)>0){
					$('#btnEdit').attr('disabled',true);
					document.getElementById("errormsg").innerText="Cannot edit,Invoice Created";
				}
				else{
					$('#btnEdit').attr('disabled',false);
					document.getElementById("errormsg").innerText="";
				}
			});
		}
		
		function funPrintBtn(){
  	   		if (($("#mode").val() == "view") && $("#docno").val()!="") {
  	  			var url=document.URL;
				var reurl=url.split("com/");
				var branch=$('#brchName').val();
 				var win= window.open(reurl[0]+"printRentalContract?docno="+document.getElementById("docno").value+"&branch="+branch,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 				
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


