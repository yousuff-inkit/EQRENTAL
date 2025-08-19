<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includesn.jsp"></jsp:include>

<% String contextPath=request.getContextPath();%>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 570px;
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
		<form action="saveRentalQuote" id="frmRentalQuote" autocomplete="off">
			<jsp:include page="../../../../header.jsp"></jsp:include>
			<div class='hidden-scrollbar'>
				<br>
				<table style="width:100%;" border="0">
					<tr><td>
					<fieldset>
						<table style="width:100%;">
							<tr>
								<td align="right" style="width:12%;">Date</td>
								<td style="width:11%;"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
								<td colspan="3">&nbsp;</td>
								<td align="right" colspan="3">Doc No</td>
								<td style="width:10%;">
									<input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>'>
									<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
								</td>
							</tr>
							<tr>
								<td align="right">Client</td>
								<td><input type="text" id="cldocno" name="cldocno" placeholder="Press F3 to Search" value='<s:property value="cldocno"/>' onkeydown="getClient(event);"></td>
								<td colspan="7"><input type="text" id="clientdetails" name="clientdetails" value='<s:property value="clientdetails"/>' style='width:97.3%;' onkeydown="getClient(event);"></td>
							</tr>
							<tr>
								<td align="right">Contact Person</td>
								<td><input type="text" id="contactperson" name="contactperson" placeholder="Press F3 to Search" onkeydown="getcontactperson(event);"value='<s:property value="contactperson"/>'>
								<input type="hidden" id="cptrno" name="cptrno"  value='<s:property value="cptrno"/>'/></td>
								<td align="right">Contact Number</td>
								<td><input type="text" id="contactnumber" name="contactnumber" value='<s:property value="contactnumber"/>'></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="right">Attention</td>
								<td colspan="9"><input type="text" id="attention" name="attention" value='<s:property value="attention"/>' style='width:99%;'></td>
							</tr>
							<tr>
								<td align="right">Subject</td>
								<td colspan="9"><input type="text" id="subject" name="subject" value='<s:property value="subject"/>'  style='width:99%;'></td>
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
								<td colspan="9"><input type="text" id="srvdesc" name="srvdesc" value='<s:property value="srvdesc"/>' style='width:99%;'></td>
							</tr>
							
						</table>
					</fieldset></td></tr>
					
					<tr>
						<td colspan="5"><div id="rentalquotegriddiv"><jsp:include page="rentalQuoteGrid.jsp"></jsp:include></div></td>
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
			<div id="cpinfowindow">
   				<div></div>
			</div>
		</form>	
	</div>	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#date").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       		$('#equipwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#equipwindow').jqxWindow('close');
       		$('#tariffwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Tariff Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#tariffwindow').jqxWindow('close');
       		$('#clientwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       		$('#clientwindow').jqxWindow('close');
       	  	$('#cpinfowindow').jqxWindow({ width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 	     	$('#cpinfowindow').jqxWindow('close');
 	     	
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
			
			 $('#contactperson').dblclick(function(){
		  		   var cldocno=document.getElementById("cldocno").value;
		  		   if(cldocno==""){
		  			  document.getElementById("errormsg").innerText="Client is Mandatory.";
		  			  if (document.getElementById("contactperson").value == "") {
				      	$('#contactperson').attr('placeholder', 'Press F3 to Search'); 
				      }
		  			  return 0;
		  		   }
		  		   document.getElementById("errormsg").innerText=" ";
		  	       cpSearchContent('contactPersonDetailsSearch.jsp?clientdocno='+cldocno);  
				});
		});
		
		function getcontactperson(event){
	         var x= event.keyCode;
	         if(x==114){
	        	 var cldocno=document.getElementById("cldocno").value;
	        	 if(cldocno==""){
	 				document.getElementById("errormsg").innerText="Client is Mandatory.";
	 				if (document.getElementById("contactperson").value == "") {
	 			        $('#contactperson').attr('placeholder', 'Press F3 to Search'); 
	 			    }
	 				return 0;
	 			}
	        	 document.getElementById("errormsg").innerText="";
	        	 cpSearchContent('contactPersonDetailsSearch.jsp?clientdocno='+cldocno);
	         }
	    }
		
		function cpSearchContent(url) {
		    $('#cpinfowindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#cpinfowindow').jqxWindow('setContent', data);
			$('#cpinfowindow').jqxWindow('bringToFront');
		}); 
		}
		
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
			$('#frmRentalQuote input').attr('readonly', true);
			$('#date').jqxDateTimeInput({'disabled':true});
		}
		function funRemoveReadOnly(){
			$('#frmRentalQuote input').attr('readonly', false);
			$('#docno,#vocno,#cldocno,#clientdetails,#vatamt,#totalamt').attr('readonly', true);
			if($('#mode').val()=='A' || $('#mode').val()=='E'){
				$('#date').jqxDateTimeInput({'disabled':false});
				$('#rentalQuoteGrid').jqxGrid('addrow',null,{});
			}
			if($('#mode').val()=='A'){
				$('#date').jqxDateTimeInput('setDate',new Date());
				$('#rentalQuoteGrid').jqxGrid('clear');
				$('#rentalQuoteGrid').jqxGrid('addrow',null,{});
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
			if($('#cmbrentaltype').val()==''){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Rental Type is mandatory";
				return 0;
			}
			
			var rows = $("#rentalQuoteGrid").jqxGrid('getrows');
		   	var gridlength=0;
		   	for(var i=0 ; i < rows.length ; i++){
		   		if(rows[i].code!=null && rows[i].code!="" && rows[i].code!="undefined" && typeof(rows[i].code)!="undefined"){
					newTextBox = $(document.createElement("input"))
		       			.attr("type", "dil")
		       			.attr("id", "quottest"+i)
		       			.attr("name", "quottest"+i)
		           		.attr("hidden", "true"); 
		 
		   			newTextBox.val(rows[i].subcatid+" :: "+rows[i].grpid+" :: "+rows[i].tarifdocno+" :: "+rows[i].qty+" :: "+rows[i].hiremode+" :: "+rows[i].subtotal+" :: "+rows[i].maxdiscount+" :: "+rows[i].discount+" :: "+rows[i].total+" :: "+rows[i].vatperc+" :: "+rows[i].vatamt+" :: "+rows[i].nettotal+" :: "+rows[i].flname);
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
			if($('#hidcmbrentaltype').val()!=''){
				$('#cmbrentaltype').val($('#hidcmbrentaltype').val());
			}
			if($('#docno').val()!=''){
				var docno=$('#docno').val();
				$('#rentalquotegriddiv').load('rentalQuoteGrid.jsp?docno='+docno+'&id=1');
				funCheckEditStatus();
			}
		}
		function funCheckEditStatus(){
			var docno=$('#docno').val();
			$.get('checkEditStatus.jsp',{'docno':docno},function(data){
				data=JSON.parse(data);
				if(parseInt(data.itemcount)>0){
					$('#btnEdit').attr('disabled',true);
					document.getElementById("errormsg").innerText="Cannot edit,Quote approved";
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
				var reurl=url.split("saveRentalQuote");
 				var win= window.open(reurl[0]+"printRentalQuote?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 				win.focus();
  	   		} 
  	  		else{
 	    		$.messager.alert('Message','Select a Document....!','warning');
 	    	    return false;
 	    	}
		}
		function funPrintBtn(){
  	   		if (($("#mode").val() == "view") && $("#docno").val()!="") {
  	  			var url=document.URL;
				var reurl=url.split("com/");
 				var win= window.open(reurl[0]+"printRentalQuote?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 				
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


