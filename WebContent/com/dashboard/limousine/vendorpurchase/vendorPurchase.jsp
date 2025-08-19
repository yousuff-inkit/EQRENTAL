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
	$("#invdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#date").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
	
}); 

function funreload(event){
	$('#vendorPurchaseDetailsGrid,#vendorPurchaseGrid').jqxGrid('clear');
	$("#vendorpurchasediv").load("vendorPurchaseGrid.jsp?id=1");                 
}
function funExportBtn(){                           
	$("#vendorpurchasediv").excelexportjs({
		containerid: "vendorpurchasediv",
		datatype: 'json',
		dataset: null,
		gridId: "vendorPurchaseGrid",
		columns: getColumns("vendorPurchaseGrid"),
		worksheetName: "Vendor Purchase Data"
	});	    
}
function funCreateNIPurchase(){
	var selectedrows=$('#vendorPurchaseDetailsGrid').jqxGrid('getselectedrowindexes');
	if(selectedrows.length==0){
		$.messager.alert('warning','Please select a document');    
		return false;
	} 
	var invno=$('#txtinvno').val();  
	if(invno==""){
		$.messager.alert('warning','Please enter Inv No');      
		return false;
	}
	var invdate=$('#invdate').jqxDateTimeInput('val'); 
	var date=$('#date').jqxDateTimeInput('val');     
	var desc=$('#txtdesc').val();                        
	var gridarray=new Array();
	var vendorid=$('#vendorid').val();
	var vendortax=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',0,'tax');
	var chkinclusive=0;
	if(document.getElementById("chkinclusive").checked==true){
		chkinclusive=1;
	}
	else{
		chkinclusive=0;
	}
	for(var i=0;i<selectedrows.length;i++){
		var bookdocno=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',selectedrows[i],'bookdocno');
		var docname=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',selectedrows[i],'docname');
		var vendoramount=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',selectedrows[i],'vendoramount');
		vendoramount.toFixed(2);
		var vendordiscount=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',selectedrows[i],'vendordiscount');
		vendordiscount.toFixed(2);
		var vendornetamount=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',selectedrows[i],'vendornetamount');
		vendornetamount.toFixed(2);
		var vendortaxamount=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',selectedrows[i],'vendortaxamount');
		vendortaxamount.toFixed(2);
		var vendortaxtotal=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',selectedrows[i],'vendortaxtotal');
		vendortaxtotal.toFixed(2);
		gridarray.push(bookdocno+"::"+docname+"::"+vendoramount+"::"+vendordiscount+"::"+vendornetamount+"::"+vendortaxamount+"::"+vendortaxtotal);
	} 
   	$.messager.confirm('Message', 'Do you want to create NI Purchase?', function(r){        
		if(r){
			var x=new XMLHttpRequest();  
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.split("::");          
		   			if(parseInt(items[0])==0)                       
					{  
			   			$.messager.alert('Message', 'CPU - '+items[1]+' Successfully Created ');
			   			$('#vendorPurchaseGrid,#vendorPurchaseDetailsGrid').jqxGrid('clear');
			   			$('#invdate,#date').jqxDateTimeInput('setDate',new Date());
			   			$('#txtinvno,#txtdesc,#vendorid').val('');
			   			document.getElementById("chkinclusive").checked=false;
			   			funreload("");
					}
					else
					{       
						$.messager.alert('Warning', 'Not Created');
					}
				}   
			}        
			x.open("GET","createNIPurchase.jsp?gridarray="+gridarray+"&invdate="+invdate+"&date="+date+"&desc="+encodeURIComponent(desc)+"&invno="+invno+"&vendorid="+vendorid+"&bill="+vendortax+"&chkinclusive="+chkinclusive,true);                                
			x.send();
		}
	});      
}     
 

function setInclusive(){
	var vendorid=$('#vendorid').val();
	$("#vendorpurchasedetaildiv").load("vendorPurchaseDetailsGrid.jsp?vendorid="+vendorid+"&id=1");
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
	<table width="100%" > 
	<jsp:include page="../../heading.jsp"></jsp:include>
	    <tr><td colspan="2">&nbsp;</td></tr>
	    <tr><td colspan="2">&nbsp;</td></tr> 
	    <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2"><input type="checkbox" name="chkinclusive" id="chkinclusive" onchange="setInclusive();"><label class="branch">Inclusive Tax</label></td></tr>   
	<tr>
	 <td align="right" width="25%"><label class="branch">Date</label></td>
	  <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div>      
      </td></tr>     
     <tr>   
	 <td align="right" width="25%"><label class="branch">Inv No</label></td>
	  <td align="left"><input type="text" id="txtinvno" name="txtinvno"  value='<s:property value="txtinvno"/>' style="width:85%;height:20px;">   
      </td></tr> 
       <tr>   
	 <td align="right" width="25%"><label class="branch">Inv Date</label></td>
	  <td align="left"><div id="invdate" name="invdate" value='<s:property value="invdate"/>'></div>      
      </td></tr>    
       <tr>   
	 <td align="right" width="25%"><label class="branch">Description</label></td>
	  <td align="left"><input type="text" id="txtdesc" name="txtdesc"  value='<s:property value="txtdesc"/>' style="width:85%;height:20px;">   
      </td></tr>       
     <tr>  
 	  <td colspan="2"><center><button name="btnupdate" id="btnupdate" onclick="funCreateNIPurchase();" class="myButton" style="width:65%;height:24px;">Create NI Purchase</button></center></td>  
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
  </table>
   </fieldset>      
</td>                                
<td width="80%">    
	<table width="100%">          
		<tr>
			<td colspan="2"><div id="vendorpurchasediv"><jsp:include page="vendorPurchaseGrid.jsp"></jsp:include></div></td>    
		</tr>     
		<tr>
		<td colspan="2"><div id="vendorpurchasedetaildiv"><jsp:include page="vendorPurchaseDetailsGrid.jsp"></jsp:include></div> <br></td> 
		</tr>
		<tr>    
		</tr>    
	</table>  
</tr>   
</table>
<input type="hidden" id="vendorid" name="vendorid" value='<s:property value="vendorid"/>'/>
<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'/>
<input type="hidden" id="accname" name="accname" value='<s:property value="accname"/>'/>
<input type="hidden" id="accno" name="accno" value='<s:property value="accno"/>'/>
<input type="hidden" id="acctype" name="acctype" value='<s:property value="acctype"/>'/> 
<input type="hidden" id="netamt" name="netamt" value='<s:property value="netamt"/>'/>             
 <div id="accounttypeSearchwindow">
	   <div></div>
	</div>
	<div id="costtpesearchwndow">
	   <div></div>
	</div>
	 <div id="costcodesearchwndow">
	   <div></div>
	</div> 
</div>
</div>
</body>
