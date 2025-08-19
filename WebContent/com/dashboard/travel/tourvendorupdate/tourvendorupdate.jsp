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
<style>
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
 .hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>
<script type="text/javascript">

$(document).ready(function () {  
	$('#branchlabel').hide();
	$('#branchdiv').hide();     
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vendorsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Vendor Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	$('#vendorsearchwndow').jqxWindow('close');
	$( "#vendor" ).dblclick(function() {   
			vendorSearchContent('vendorSearch.jsp?docno='+$('#rdocno').val());  
		});         
});         
 
function vendorSearchContent(url) {
	 $.get(url).done(function (data) {
	$('#vendorsearchwndow').jqxWindow('open');  
	$('#vendorsearchwndow').jqxWindow('setContent', data);

}); 
}
function getVendor(event){     
	var x= event.keyCode;
    if(x==114){       
    	vendorSearchContent('vendorSearch.jsp?docno='+$('#rdocno').val()+"&vndid="+$('#vndid').val());          
      }
}
function funreload(event){
	  $("#trvnddiv").load("tourlistGrid.jsp?id=1");    
}      	
function funExportBtn(){
	    JSONToCSVCon(Exceldata, "Tour Vendor Update", true);                 
	 }
  
function funUpdate(){
    var adult=document.getElementById("adult").value; 
    var child=document.getElementById("child").value;  
	var stdadult=document.getElementById("stdadult").value;  
	var stdchild=document.getElementById("stdchild").value;   
	var tourrow=document.getElementById("tourrow").value;      
	var vndid=document.getElementById("vendorid").value;  
	//alert("docno==="+docno);
	if(tourrow=="" || tourrow=="0"){        
				$.messager.alert('warning','Please select a document');    
				return false;
	 }	
	if(vndid=="" || vndid=="0"){        
				$.messager.alert('warning','Please select vendor');    
				return false;
	 }	
    if(stdadult==""){        
				$.messager.alert('warning','Please enter adult cost');    
				return false;
	 }   
	if(stdchild==""){        
				$.messager.alert('warning','Please enter child cost');                 
				return false;    
	 }   
	var stdtotal=(parseFloat(child)*parseFloat(stdchild))+(parseFloat(adult)*parseFloat(stdadult));              
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {    
			items = x.responseText;
			if(items.trim()>0){     
			   funClearData();      
				$.messager.alert('warning','Successfully Updated');
			}
			else{
				$.messager.alert('warning','Not Updated');
			}
			
		} else {
		}      
	}
	x.open("GET", "updateData.jsp?stdadult="+stdadult+"&stdtotal="+stdtotal+"&stdchild="+stdchild+"&tourrow="+tourrow+"&vendorid="+vndid, true);                     
	x.send();
}
	 function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
		        return false;
		    return true;
		}

function  funClearData(){  
	 $('#vendor').val('');$('#vendorid').val('');$('#stdadult').val('');$('#stdchild').val('');
	 $('#tourGrid').jqxGrid('clear'); 
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
	<table width="100%"> 
	<jsp:include page="../../heading.jsp"></jsp:include>  
	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>   
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	  <tr>  
       <td align="left" width="24%"><label class="branch">Vendor</label></td>  
       <td><input type="text" name="vendor" id="vendor" style="width:100%" readonly class="filters"  placeholder="Press F3 to Search" class="filters" onkeydown="getVendor(event);">
        <input type="hidden" name="vendorid" id="vendorid" readonly  class="filters"></td>       
     </tr>
      <tr>  
       <td align="left" width="24%"><label class="branch">Adult Cost</label></td>  
       <td><input type="text" name="stdadult" id="stdadult" class="filters"  onblur="funRoundAmt(this.value,this.id);" onkeypress="return isNumberKey(event)" style="width:100%;text-align:right"></td>       
     </tr>
      <tr>  
       <td align="left" width="24%"><label class="branch">Child Cost</label></td>  
       <td><input type="text" name="stdchild" id="stdchild" class="filters"  onblur="funRoundAmt(this.value,this.id);" onkeypress="return isNumberKey(event)" style="width:100%;text-align:right"></td>       
     </tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
 	  <td colspan="2"><center><button type="button" name="btnupdate" id="btnupdate" onclick="funUpdate();" class="myButton">Update</button></center></td>
     </tr> 
     <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td></tr>           
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
  </table>
   </fieldset>      
</td>  
<td width="80%">  
	<table width="100%">     
		<tr>
			  <td colspan="2"><div id="trvnddiv"><jsp:include page="tourlistGrid.jsp"></jsp:include></div> <br></td> 
		</tr>    
	</table>     
	</td>      
</tr>    
</table>
<input type="hidden" name="vndid" id="vndid" value='<s:property value="vndid"/>'>
<input type="hidden" name="rdocno" id="rdocno" value='<s:property value="rdocno"/>'>
<input type="hidden" name="tourrow" id="tourrow" value='<s:property value="tourrow"/>'> 
<input type="hidden" name="child" id="child" value='<s:property value="child"/>'> 
<input type="hidden" name="adult" id="adult" value='<s:property value="adult"/>'>       
<div id="vendorsearchwndow">    
   <div ></div>                              
</div> 
</div>  
</div>
</body>
