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

.icon1 {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #ECF8E0;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#clientcatwindow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '85%' ,maxWidth: '40%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 	 $('#clientcatwindow').jqxWindow('close');	 
	 	 $('#salesmanwindow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '85%' ,maxWidth: '40%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#salesmanwindow').jqxWindow('close');	
		 $('#clientcat').dblclick(function(){     
				$('#clientcatwindow').jqxWindow('open');
				$('#clientcatwindow').jqxWindow('focus');    
				clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow'));
			});
		 $('#txtsalesman').dblclick(function(){     
				$('#salesmanwindow').jqxWindow('open');
				$('#salesmanwindow').jqxWindow('focus');
				salesmanSearchContent('salesmanSearchGrid.jsp?id=1', $('#salesmanwindow'));
			});
	});
	function getSalesman(event){
		 var x= event.keyCode;
	    if(x==114){
	    	$('#salesmanwindow').jqxWindow('open');
			$('#salesmanwindow').jqxWindow('focus');
			salesmanSearchContent('salesmanSearchGrid.jsp?id=1', $('#salesmanwindow'));
	    }
	    else{
	     }
	}
	function salesmanSearchContent(url) {
		$.get(url).done(function (data) {
		    $('#salesmanwindow').jqxWindow('setContent', data);
		}); 
	}
	function getClientCat(event){
		 var x= event.keyCode;
	    if(x==114){
	    	$('#clientcatwindow').jqxWindow('open');
			$('#clientcatwindow').jqxWindow('focus');
			clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow'));
	    }
	    else{
	     }
	}
	function clientCatSearchContent(url) {
		$.get(url).done(function (data) {
		    $('#clientcatwindow').jqxWindow('setContent', data);
		}); 
	}
	function funreload(event) {     
		    var  catid=$('#hidclientcat').val();     
		    var  salid=$('#hidsalesman').val(); 
		    var  branchval=$('#cmbbranch').val(); 
		 	$("#bsmsDiv").load("clientlistGrid.jsp?branchval="+branchval+"&catid="+catid +"&salid="+salid +'&check=1');
	}
	             
	function funExportBtn(){      
		  	$("#bsmsDiv").excelexportjs({
		  		containerid: "bsmsDiv", 
		  		datatype: 'json', 
		  		dataset: null, 
		  		gridId: "jqxclientGrid", 
		  		columns: getColumns("jqxclientGrid") , 
		  		worksheetName:"Bulk SMS"
		  		});
	}
	function mobileValid(value){
		   if(value!=""){ 
		    var phoneno = /^\d{12}$/;  
			if(value.match(phoneno)){
				return true;
			}
			else{
				$.messager.alert('Message',' Invalid Mobile Number!!!Please select documents having valid mobile number','warning');
				return false;
			}
		    }else{
		    	$.messager.alert('Message',' Invalid Mobile Number!!!Please select documents having valid mobile number','warning');
				return false;    
		    } 
		   return true;
	}

	function funSendSMS(){    
		var rows = $("#jqxclientGrid").jqxGrid('getrows');
		$("#overlay, #PleaseWait").show();
		var selectedrows=$("#jqxclientGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
		$("#overlay, #PleaseWait").hide();
		$.messager.alert('Warning','Select documents.');
		return false;
		}

		var i=0,val=0;         
		var temptrno="";            
		var j=0;
		for (i = 0; i < selectedrows.length; i++) {

		if(i==0){      
			var accdocno= $('#jqxclientGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
			var mobno= $('#jqxclientGrid').jqxGrid('getcellvalue', selectedrows[i], "per_mob");  
			if(!mobileValid(mobno)){ 
				$("#overlay, #PleaseWait").hide();
				return false;
			 }       
			temptrno=accdocno;   
		}  
		else{  
			var accdocno= $('#jqxclientGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");   
			var mobno= $('#jqxclientGrid').jqxGrid('getcellvalue', selectedrows[i], "per_mob");
			if(!mobileValid(mobno)){  
				$("#overlay, #PleaseWait").hide();
				return false;   
			 }
			temptrno=temptrno+","+accdocno;
		}
		temptrno1=temptrno+","; 
		j++; 
		}
		$('#cldocnos').val(temptrno1);
		sendSMS($('#cldocnos').val());	
		}    
	function sendSMS(cldocnos){    
		var message=$("#txtmessage").val();
		var branch=$("#cmbbranch").val();   
		$("#overlay, #PleaseWait").show(); 
	    var x=new XMLHttpRequest();   
	 		x.onreadystatechange=function(){
	 			if (x.readyState==4 && x.status==200)
	 			{  
	 				var items=x.responseText.trim();   
	 				if(parseInt(items)>0){                                     
	 					 $.messager.alert('Message',' Successfully SMS sent ','success');
	 					 $("#overlay, #PleaseWait").hide();     
	 				}
	 				else{   
	 					 $.messager.alert('Message',' SMS not sent ','warning'); 
	 					 $("#overlay, #PleaseWait").hide();  
	 				}   
	 			}
	 			else    
	 			{       
	 			}                      
	 		}
	 		x.open("GET","sendSMS.jsp?message="+encodeURIComponent(message)+"&gridarray="+cldocnos+"&branch="+branch,true);                              
	 		x.send();      
	}
	function funClearData(){
		$("#clientcat").val('');
		$("#hidclientcat").val('');
		$("#hidsalesman").val('');
		$("#txtsalesman").val('');
		$("#txtmessage").val('');
		$('#jqxclientGrid').jqxGrid('clear');             
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
	<tr><td align="right"><label class="branch">Category</label></td>
        <td align="left">
			<input type="text" readonly id="clientcat" name="clientcat" value='<s:property value="clientcat"/>' onkeydown="getClientCat(event);" style="height:18px;" placeholder="Press F3 to Search">
      		<input type="hidden" readonly id="hidclientcat" name="hidclientcat" value='<s:property value="hidclientcat"/>' >
      	</td>
    </tr>
    <tr><td align="right"><label class="branch">Salesman</label></td>
        <td align="left">
			<input type="text" readonly id="txtsalesman" name="txtsalesman" value='<s:property value="txtsalesman"/>' onkeydown="getSalesman(event);" style="height:18px;" placeholder="Press F3 to Search">
      		<input type="hidden" readonly id="hidsalesman" name="hidsalesman" value='<s:property value="hidsalesman"/>' >
      	</td>
    </tr>      
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Message</label></td>
        <td align="left">   
      		<textarea rows="10" style="width: 100%;" name="txtmessage" id="txtmessage"></textarea>   
      	</td>
    </tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="left"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td>
	<td align="right"><input type="button" class="myButtons" name="sendsms" id="sendsms"  value="Send SMS" onclick="funSendSMS();"></td></tr>    
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="bsmsDiv"><jsp:include page="clientlistGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<input type="hidden" name="cldocnos" id="cldocnos" value='<s:property value="cldocnos"/>'>
</div>
<div id="clientcatwindow">
<div></div>
</div>
<div id="salesmanwindow">
<div></div>
</div>
</div> 
</body>
</html>