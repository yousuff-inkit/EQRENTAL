 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
		
	$(document).ready(function () {
	
		
	});
	
	
	  function funPrint() {
			
		  $("#docno").prop("disabled", false);
			 $("#maintrno").prop("disabled", false);
			 $("#formdetailcode").prop("disabled", false);
			
			var docno=$('#docno').val();
	  		var trno=$('#maintrno').val();
	  		var dtype=$('#formdetailcode').val();
	  		//var dtype=$('#brchName').val();
	  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
			var url=document.URL;
			var reurl=url.split("com/"); 
			
			var cmbfreq=$("#cmbfreq").val();
	  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
	  		var win= window.open(reurl[0]+"printInvoice?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&bankdocno=0&header=1&freq="+cmbfreq,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     	win.focus();
			
			
	    
}


 	
 	

</script>

<body >
<div id=search>
<br/><br/><br/><br/>
<table width="100%">
  
 
  
  <tr>
		<td colspan="1" align="center"><select id="cmbfreq" name="cmbfreq" style="width:50%;" value='<s:property value="cmbfreq"/>'>
      <option value="1">Without Unitprice</option>
      <option value="2">With Unitprice</option>
      
    </select>
		</td></tr>
		<tr>
		 <td align="center" width="33%"><input type="button" name="btncheque" id="btnamc" class="myButton" value="Print"  onclick="funPrint();"></td>
		</tr>
	</table>
	
<br/><br/><br/>
  </div>
</body>
</html>