<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 
<style type="text/css">
	
</style>
<script type="text/javascript">

	$(document).ready(function () {
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	});
	
	function funValidateUsername() {
		var clientusername = $('#clientusername').val();
		var clientpassword = $('#clientpassword').val();
		var cldocno=$('#cldocno').val();
		var chksendmail=0;
		if(document.getElementById("chksendmail").checked==true){
			chksendmail=1;
		}
		if(cldocno==''){
			 $.messager.alert('Message','Please select a valid client','warning');
			 return false;
		}
		
		if(clientusername==''){
			 $.messager.alert('Message','Please type in valid username','warning');
			 return false;
		}

		 if(clientpassword==''){
			 $.messager.alert('Message','Please type in valid password','warning');   
			 return 0;
		 }
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		$('#overlay,#PleaseWait').show();
					var x = new XMLHttpRequest();
					x.onreadystatechange = function() {
						if (x.readyState == 4 && x.status == 200) {
							var items = x.responseText.trim();
							if(items=="1"){
								$('#overlay,#PleaseWait').hide();
								$.messager.alert('Message','Username already exists,try a different one','warning');
			 					return false;	
							}
							else{
								funSaveClientDetails(clientusername,clientpassword,chksendmail,cldocno);
							}
						} else {}
					}
					x.open("GET","validateUsername.jsp?clientusername="+clientusername, true);
					x.send();	
		     	}
		});
		
	}
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 $("#overlay, #PleaseWait").show();
		 $("#clientPortalDiv").load("clientPortalGrid.jsp?id=1");
	}
	   
	function funSaveClientDetails(clientusername,clientpassword,chksendmail,cldocno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				$('#overlay,#PleaseWait').hide();
				if(items=="0"){
					$('#clientusername,#clientpassword').val('');
					document.getElementById("chksendmail").checked=false;
					$.messager.alert('Message','Successfully Updated','Message');
					funreload("");
				}
				else{
					$.messager.alert('Warning','Not Updated','Warning');
					return false;
				}
			}
		}
		x.open("GET","saveClientDetails.jsp?clientusername="+clientusername+"&clientpassword="+clientpassword+"&chksendmail="+chksendmail+"&cldocno="+cldocno,true);
		x.send();
	}
	
	function funExportBtn(){
		 /* if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(dataExcelExport, 'PaymentFollowUp', true);
		 } else {
			 $("#paymentFollowUp").jqxGrid('exportdata', 'xls', 'PaymentFollowUp');
		 } */
		 
		$("#clientPortalDiv").excelexportjs({
			containerid: "clientPortalDiv",
			datatype: 'json', 
			dataset: null, 
			gridId: "clientPortalGrid", 
			columns: getColumns("clientPortalGrid") , 
			worksheetName: "Client Portal Details"
		});
	}
</script>
</head>
<body onload="getBranch();">
	<form autocomplete="off">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%" >
					<tr>
						<td width="20%" >
	    					<fieldset style="background: #ECF8E0;">
								<table width="100%" >
									<jsp:include page="../../heading.jsp"></jsp:include>
	     							<tr><td colspan="2"><hr></td></tr>
		 	 						<tr>
		 	 							<td align="right"><label class="branch">Username</label></td>
		 	 							<td><input type="text" id="clientusername" name="clientusername" style="width:100%;height:20px;" value='<s:property value="clientusername"/>'/></td>
		 	 						</tr>
		 	 						<tr>
		 	 							<td align="right"><label class="branch">Password</label></td>
		 	 							<td><input type="password" id="clientpassword" name="clientpassword" style="width:100%;height:20px;" value='<s:property value="clientpassword"/>'/></td>
		 	 						</tr>
		 	 						<tr><td colspan="2"><input type="checkbox" id="chksendmail" name="chksendmail"><label for="chksendmail" class="branch">Send Mail to the Client</label></td></tr>
		 	 						<tr><td colspan="2" align="center"><button type="button" name="btnsave" id="btnsave" class="myButton" onClick="funValidateUsername();">Save</button></td></tr>
		 	 						<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
		 	 					</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr><td><div id="clientPortalDiv"><jsp:include page="clientPortalGrid.jsp"></jsp:include></div></td></tr>
							</table>
						</td>
					</tr>
				</table>
				<input type="hidden" id="cldocno" name="cldocno">
			</div>
		</div>
	</form>
</body>
</html>