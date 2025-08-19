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
<script type="text/javascript">

$(document).ready(function () {  
	$('#branchlabel').hide();
	$('#branchdiv').hide();     
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
  	$('#btnupdate').attr('disabled', true);
	
}); 
 

function funreload(event)
{
	  $("#userdiv").load("usergrid.jsp?id=1");          
}      	
function funload()
{
var docno=document.getElementById("txtuserdoc").value;
 $("#locdiv").load("locationgrid.jsp?docno="+docno+"&id=1");           
} 
function funExportBtn(){
	 //   JSONToCSVCon(datasssss, 'name', true);
	 }
  
function funUpdate(){ 
$.messager.confirm('Confirm', 'Do you want to Link?', function(r){
	if (r){
				
	var docno=document.getElementById("txtuserdoc").value;  
	//alert("docno==="+docno);                    
	if(docno=="" || docno=="0"){
		$.messager.alert('warning','Please select a document');    
		return false;
	}
	var gridarray=new Array();      
	var rows = $("#jqxLocation").jqxGrid('getrows'); 
	var temp=0;
	   for(var i=0 ; i < rows.length ; i++){ 
	 	               
		   //alert(rows[i].val);
		    gridarray.push(rows[i].val+" :: "+ rows[i].docno +" :: "+rows[i].rowno+" :: ");   
		   
		}
	 
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {    
			items = x.responseText;
			if(items.trim()>0){
			    funload();  
				$.messager.alert('warning','Successfully Linked');
				
			 	/* $('#btnupdate').attr('disabled', true); */      
			}
			else{
				$.messager.alert('warning','Not Linked');
			}
			
		} else {
		}   
	}
	x.open("GET", "updateData.jsp?gridarray="+gridarray+"&docno="+docno, true);                  
	x.send();
	}
 	 		});
}

</script>
</head>
<body >
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
	 <tr>
 	  <td colspan="2"><center><button type="button" name="btnupdate" id="btnupdate" onclick="funUpdate();" class="myButton">Link</button></center></td>
    </tr>  
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
			  <td colspan="2"><div id="userdiv"><jsp:include page="usergrid.jsp"></jsp:include></div> <br></td> 
		</tr>  
		<tr>
		<td colspan="2"><div id="locdiv"><jsp:include page="locationgrid.jsp"></jsp:include></div></td>
		</tr> 
		
	</table>   
</tr>
</table>
<input type="hidden" name="txtuserdoc" id="txtuserdoc" value='<s:property value="txtuserdoc"/>'>   
  
</div>  
</div>
</body>
