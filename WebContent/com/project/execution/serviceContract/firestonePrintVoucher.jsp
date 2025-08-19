 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<%-- <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>  --%>
<title>GatewayERP(i)</title>

<script type="text/javascript">
	
$(document).ready(function () { 
	//hidedat();
});

 	
 	
	
 	  function funPrint() {
			
				 $("#docno").prop("disabled", false);
				 $("#masterdoc_no").prop("disabled", false);
				 $("#formdetailcode").prop("disabled", false);
				 
				var docno=$('#docno').val();
		  		var trno=$('#masterdoc_no').val();
		  		var dtype=$('#formdetailcode').val();
				var url=document.URL;
				var reurl=url.split("com/"); 
				
				var cmbfreq=$("#cmbfreq").val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
				 var win= window.open(reurl[0]+"printAmcContract?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&header=1&freq="+cmbfreq,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					  win.focus(); 
				
				
		    
  }
 	
  	
 		
 		
 		
 	 

 	


</script>
</head>
<body >
<div id=search>
<br/><br/><br/><br/>
<table width="100%">
  
 
   
    
	
	<tr>
		<td colspan="2" align="center"><select id="cmbfreq" name="cmbfreq" style="width:50%;" value='<s:property value="cmbfreq"/>'>
      <option value="1">Quarterly Basis</option>
      <option value="2">half Yearly Basis</option>
      <option value="3">Monthly Basis</option>
	  <option value="4">Yearly Basis</option>
      </select>
		</td></tr>
	</table>
	<table width="100%">
	<tr>
	  	<td>
		</td>
	 <td align="center" width="33%"><input type="button" name="btncheque" id="btnamc" class="myButton" value="Print"  onclick="funPrint();"></td>
	<td></td>
	</tr>
   
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>