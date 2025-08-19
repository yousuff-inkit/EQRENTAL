 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	
	
	function loadAccountSearch() {
		var masterdate=document.getElementById("vehpurorderDate").value;
		

			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var currs=document.getElementById("txtaccountcurrency").value;
		
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,currs,check,masterdate);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,check,masterdate){

		 $("#refreshAccountDetailsDiv").load("accountsDetailsFromGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&check='+check+'&masterdate='+masterdate);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="30%"><input type="text" name="txtaccountsno" id="txtaccountsno" style="width:85%;" value='<s:property value="txtaccountsno"/>'></td>
    <td width="10%" align="right">Currency</td>
    <td width="27%"><input type="text" name="txtaccountcurrency" id="txtaccountcurrency" style="width:50%;" value='<s:property value="txtaccountcurrency"/>'>
     <input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'></td>
    <td width="23%" rowspan="2" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearch();"></td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="3"><input type="text" name="txtaccountsname" id="txtaccountsname" style="width:80%;" value='<s:property value="txtaccountsname"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshAccountDetailsDiv"><jsp:include page="accountsDetailsFromGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>