<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 
		 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     $('#txtclientname').dblclick(function(){
			  clientSearchContent('clientDetailsSearch.jsp');
		 });
	     
	});
	
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	      var x= event.keyCode;
	      if(x==114){
	    	  clientSearchContent('clientDetailsSearch.jsp');
	      } else{}
	}
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var cldocno = $('#txtcldocno').val();
		 var check="1";
		 
		 $("#overlay, #PleaseWait").show();
		
	     $("#clientApprovalDiv").load("clientApprovalGrid.jsp?branchval="+branchval+'&cldocno='+cldocno+'&check='+check);
		 
		 
		}
	
      function funClearInfo(){

    	 $('#cmbbranch').val('a');
    	 $('#txtcldocno').val('');$('#txtclientname').val('');$('#txtselectedclients').val('');
    	 
		 $("#clientApprovalGridID").jqxGrid('clear');$("#clientApprovalGridID").jqxGrid('clearselection');
		
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		}
      
	function funExportBtn(){ 
		if(parseInt(window.parent.chkexportdata.value)=="1") {
			JSONToCSVCon(dataExcelExport, 'ClientApproval', true);
		 } else {
			 $("#clientApprovalGridID").jqxGrid('exportdata', 'xls', 'ClientApproval');
		 }
	}
	
	function funClientApproval(){
		
		var rows = $("#clientApprovalGridID").jqxGrid('getrows');
		var selectedrows=$("#clientApprovalGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Clients to be Approved.');
			return false;
		}
		
		var i=0;var tempcldocno="",tempcldocno1="";
        var j=0,k=0;
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(i==0){
						tempcldocno=rows[i].cldocno;
						k=1;
					}
					else{
						if(k==0){
							tempcldocno=rows[i].cldocno;
							k=1;
						} else {
							tempcldocno=tempcldocno+","+rows[i].cldocno;
						}
					}
					tempcldocno1=tempcldocno;
					
				j++; 
			  }
            }
	     $('#txtselectedclients').val(tempcldocno1);
		
	     $.messager.confirm('Confirm', 'Do you want to Approve ?', function(r){
	  	 		if (r){
	  	 			  var selectedclients = $('#txtselectedclients').val();
	  	 			  
	  	 			  $("#overlay, #PleaseWait").show();
	  	 			 
	  	 			  saveGridData(selectedclients);
	  	 	  }
	  	  });  
	}
	
	function saveGridData(selectedclients) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				
				if(val>0) {
					$.messager.alert('Message', ' Successfully Approved', function(r){
					});
					
					$('#txtcldocno').val('');$('#txtclientname').val('');$('#txtselectedclients').val('');
			    	 
					if (document.getElementById("txtclientname").value == "") {
					        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
					}
				} else {
					$.messager.alert('Message', ' Failed', function(r){
					});
				}
				funreload(event);
		  }
		}
			
		
	x.open("GET","saveData.jsp?selectedclients="+selectedclients,true);
	x.send();
	}

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);"/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'/></td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
    <button class="myButton" type="button" id="btnApproved" name="btnApproved" onclick="funClientApproval();">Approval</button></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;<input type="hidden" id="txtselectedclients" name="txtselectedclients" value='<s:property value="txtselectedclients"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="clientApprovalDiv"><jsp:include page="clientApprovalGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientDetailsWindow">
	<div></div>
</div>

</div>
</body>
</html>