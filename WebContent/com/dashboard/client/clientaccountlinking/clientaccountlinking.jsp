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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>  
.myButtons {
  display: inline-block;
  margin-right:4px;
  margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
  touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	$('#branchlabel').hide();
	$('#branchdiv').hide();
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
});

function funreload(event)
{
	var aa="load";
  	$("#overlay, #PleaseWait").show();  
  	$("#clientListDiv").load("clientListGrid.jsp?check="+aa);
}	
function funExportBtn(){ 
		JSONToCSVCon(dataExcelExport, 'Client Account Linking', true);
}
function funUpdate(event){
	var cldocno=$('#txtcldocno').val();
	var acno = $('#txtacno').val();
	if(cldocno==''){
		 $.messager.alert('Message','Please select document.','warning');   
		 return 0;   
	 }
		 if(acno==''){
		 $.messager.alert('Message','Please Enter Acno.','warning');   
		 return 0;
	 }
	
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		saveGridData(acno);	
	     	}
	});
}

function saveGridData(acno){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
     			
			var items=x.responseText;
			if(items>0){    
				$('#txtacno').val('');     
				 document.getElementById("etext").innerText ='';
				funreload(event); 
				$.messager.alert('Message', '  Record Successfully Updated ');
			}else{
				$.messager.alert('Message', '  Record Not Updated ');	  
			}
			}
	}
		
x.open("GET","saveData.jsp?acno="+acno+"&cldocno="+$('#txtcldocno').val(),true);   
x.send();
		
}
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
        return false;
    return true;
}
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2"><label class="branch" name="etext" id="etext"  style="color:#3342FF;"></label></td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td align="right"><label class="branch">Acno</label></td>
	 <td align="left"><input type="text" id="txtacno" name="txtacno" onkeypress="return isNumberKey(event)" style="width:100%;height:20px;" value='<s:property value="txtacno"/>'/></td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr> 
	<tr><td colspan="2"><input type="hidden" id="txtcldocno" name="txtcldocno"  style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'/></td></tr>
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
</table></fieldset></td>
<td width="80%">
<div  >
	<table width="100%" id="grid1">      
	<tr><td ><label name="user" id="user"></label></td></tr>   
		<tr>
			  <td ><div id="clientListDiv"><jsp:include page="clientListGrid.jsp"></jsp:include></div> 
			</td></tr>
	</table>
</div>
<div >
</div>
</tr>
</table>
</div>
</div>
</body>
</html>