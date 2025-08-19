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
	$('#visasearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Visa Type Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	$('#visasearchwndow').jqxWindow('close');  
	$("#jqxvisagrid").jqxGrid({ disabled: true}); 
	$("#btnupdate").attr('disabled',true);  
	if($("#msg").val()=="Successfully Saved" || $("#msg").val()=="Not Saved") { 
		 $.messager.alert('Message',$('#msg').val());
	}
}); 
function visaSearchContent(url) {
		 $.get(url).done(function (data) {
		$('#visasearchwndow').jqxWindow('open');  
		$('#visasearchwndow').jqxWindow('setContent', data);

	}); 
	}
function funreload(event){
	  $("#pricediv").load("pricemanagementgrid.jsp?id=1"); 
	  $('#btnupdate').val("Edit"); 
	  $("#jqxvisagrid").jqxGrid('clear');     
	  $("#jqxvisagrid").jqxGrid({ disabled: true});
	  $('#cmbtaxtype').val("0");    
	}
function funExportBtn(){   
	    JSONToCSVCon(data1excel,  $('#refname').val()+' - '+$('#cmbtaxtype').val(), true);
	 }
function funcheck(){      
	if($('#btnupdate').val()=="Edit"){
		$("#jqxvisagrid").jqxGrid({ disabled: false});
		$('#btnupdate').val("Update");   
		return 1;  
	}
	if($('#btnupdate').val()=="Update"){    
		funSave();   
		$('#btnupdate').val("Edit"); 
		$("#jqxvisagrid").jqxGrid({ disabled: true});     
		return 1; 
	}
}
function funSave(){
	var docno=document.getElementById("docno").value;  
	//alert("docno==="+docno);                    
	if(docno=="" || docno=="0"){    
		$.messager.alert('warning','Please select a document');    
		return false;
	} 
	       //$("#overlay, #PleaseWait").show();         
		   var rows = $("#jqxvisagrid").jqxGrid('getrows'); 
		   var rowindex=0;    
		   for(var i=0;i<rows.length;i++){          
			   var chks2=rows[i].visaid;             
		 	   if(typeof(chks2) != "undefined" && typeof(chks2) != "NaN" && chks2 != "" && chks2 != "0"){
					newTextBox = $(document.createElement("input"))
				       .attr("type", "dil")
				       .attr("id", "test"+i)
				       .attr("name", "test"+i)      
				       .attr("hidden", "true");
			   newTextBox.val(rows[i].visaid+" :: "+ rows[i].value +" :: "+rows[i].maxdisval+" :: "+rows[i].marginper+" :: "+rows[i].marginval+" :: "+rows[i].sprice+" :: "+rows[i].rowno+" :: "+rows[i].rowdelete+" :: ");  
			   newTextBox.appendTo('form');                        
			   rowindex++;       
			   $('#gridlength').val(rowindex);  
		 	   }               
		   }
		   document.getElementById("mode").value="A";           
		   document.getElementById("frmvisapricemngmnt").submit();     
}
</script>
</head>
<body >
<div id="mainBG" class="homeContent" data-type="background">    
<form id="frmvisapricemngmnt" action="savevisapricemngmnt" method="post" autocomplete="off">
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" > 
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr> 
     <tr>   
	 <td align="right" width="25%"><label class="branch">Tax Type</label></td>   
	  <td align="left"><select id="cmbtaxtype" name="cmbtaxtype"  value='<s:property value="cmbtaxtype"/>' style="width:85%;">   
	  <option value="0">--------------select---------------</option><option value="INCLUSIVE">INCLUSIVE</option> <option value="EXCLUSIVE">EXCLUSIVE</option></select>
      <input type="hidden" id="hidcmbtaxtype" name="hidcmbtaxtype"  value='<s:property value="hidcmbtaxtype"/>' style="width:85%;"/>
      </td></tr>  
      <tr>    
 	  <td colspan="2"><center><input type="button" name="btnupdate" id="btnupdate" onclick="funcheck();" class="myButton" value="Edit" style="width:70px;height:24px;"/></center></td>
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
  </table>
   </fieldset>      
</td>  
<td width="80%">  
	<table width="100%">     
		<tr>
			  <td colspan="2"><div id="pricediv"><jsp:include page="pricemanagementgrid.jsp"></jsp:include></div> <br></td> 
		</tr>     
			<tr>   
		<td width="30%"><div id="visadiv"><jsp:include page="visagrid.jsp"></jsp:include></div></td>   
		</tr>
		<tr>    
		</tr>   
	</table>
</tr>   
</table>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>             
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>    
<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>  
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
<input type="hidden" name="refname" id="refname" value='<s:property value="refname"/>'>   
<div id="visasearchwndow">
   <div ></div>
</div>
</div>
</form>  
</div>
</body>
