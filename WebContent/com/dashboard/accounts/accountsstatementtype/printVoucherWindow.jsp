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
	//getbankname();
	document.getElementById("rdheader").checked=true;
});


 	function printlogo() {
 					
			//$("#docno").prop("disabled", false);                
			var dtype=$('#formdetailcode').val();
			var brhid=$("#brchName").val();
			
			var header=0;
	 		if(document.getElementById("rdheader").checked==true){
	 			header=1;
	 		} else if(document.getElementById("rdnoheader").checked==true){
	 			header=0;
	 		}
	 		var url=document.URL;
	        var reurl=url.split("accountsStatementType.jsp");
	        $("#txtdocno").prop("disabled", false);
	        var win= window.open(reurl[0]+"com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+document.getElementById("txtdocno").value+'&header='+header+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&chckopn='+$('#hidchckopnprint').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
			//var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header="+header+"&bankdocno="+bankdocno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			win.focus();
		 
		
 		$('#printWindow').jqxWindow('close');
 	}

 

</script>

<body>
<div id=searchprint>
<br/>
<table width="100%">

  <tr>
    <td>&nbsp;</td>
    <td colspan="2" align="left"><input type="radio" id="rdheader" name="rdo" value="rdheader" checked="checked">With Header
    <input type="radio" id="rdnoheader" name="rdo" value="rdnoheader" >Without Header</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="57%" align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="Print"  onclick="printlogo();"></td>
    <td width="36%">&nbsp;</td>
  </tr>

</table>
&nbsp;
  </div>
</body>
</html>