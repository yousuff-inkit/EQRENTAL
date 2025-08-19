 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<script type="text/javascript">
function funSendMail(){
    var id=1; 
    $('#printWindow').jqxWindow('close');               
	var x=new XMLHttpRequest();   
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
		var items=x.responseText.trim();

	 }
	} 
	x.open("GET","sendMail.jsp?rdocno="+$('#txtrdocno').val()+'&brhid='+$('#cmbbranch').val()+'&id='+id,true);              
	x.send(); 
	}

function funSendWhatsapp(){
  var id=2;
    $('#printWindow').jqxWindow('close');               
	var x=new XMLHttpRequest();   
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
		var items=x.responseText.trim();
		if(items.split("::")[1].trim()==""){
			swal({
				type: 'error',
				title: 'WhatsApp Message',
				text: 'Mobile not configured'       
			});
		}
		else if(items.split("::")[2].trim()==""){
			swal({
				type: 'error',
				title: 'WhatsApp Message',
				text: 'Message not configured'       
			});
		}
		else{
			var sendmobile=items.split("::")[1].trim();
			var sendmessage=items.split("::")[2].trim();
			funSendWhatsApp(sendmessage,sendmobile);
		}
	 }
	} 
	x.open("GET","sendMail.jsp?rdocno="+$('#txtrdocno').val()+'&brhid='+$('#cmbbranch').val()+'&id='+id,true);              
	x.send(); 
	}
	
function funSendMailWhatsapp(){
    var id=3;    
    $('#printWindow').jqxWindow('close');               
	var x=new XMLHttpRequest();   
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
		var items=x.responseText.trim();
		if(items.split("::")[1].trim()==""){
			swal({
				type: 'error',
				title: 'WhatsApp Message',
				text: 'Mobile not configured'       
			});
		}
		else if(items.split("::")[2].trim()==""){
			swal({
				type: 'error',
				title: 'WhatsApp Message',
				text: 'Message not configured'       
			});
		}
		else{
			var sendmobile=items.split("::")[1].trim();
			var sendmessage=items.split("::")[2].trim();
			funSendWhatsApp(sendmessage,sendmobile);
		}
		/* if(items=="success")   
		{
			$.messager.alert('Message', ' Mail Sent ','info');
		}
		else    
		{
			$.messager.alert('Message', ' Not Sent ','warning');
		} */            
	 }
	} 
	x.open("GET","sendMail.jsp?rdocno="+$('#txtrdocno').val()+'&brhid='+$('#cmbbranch').val()+'&id='+id,true);                    
	x.send();   
	}
	
	</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>     
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnsendmail" id="btnsendmail" class="myButton" value="Send via E-Mail"  onclick="funSendMail();"></td>
    <td align="center"><input type="button" name="btnsendwhatsapp" id="btnsendwhatsapp" class="myButton" value="Send via Whatsapp"  onclick="funSendWhatsapp();"></td>
    <td align="center"><input type="button" name="btnmailandwhatsapp" id="btnmailandwhatsapp" class="myButton" value="Send via both"  onclick="funSendMailWhatsapp();"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>  
  </div>
</body>
</html>