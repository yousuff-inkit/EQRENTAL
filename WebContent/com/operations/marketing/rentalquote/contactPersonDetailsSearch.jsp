 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadContactPersonSearch() {

 		var contactpersonsname=document.getElementById("txtcontactpersonsname").value;
 		var contactpersonsmobile=document.getElementById("txtcontactpersonsmobile").value;
 		var contactpersonsdocno=document.getElementById("txtcontactpersonsdocno").value;
 		var clientdocno=document.getElementById("cldocno").value;
 		var chk = 1;
 		
		getdata(clientdocno,contactpersonsname,contactpersonsmobile,contactpersonsdocno,chk);
	}
	function getdata(clientdocno,contactpersonsname,contactpersonsmobile,contactpersonsdocno,chk){
		 $("#refreshcontactpersondiv").load('contactPersonDetailsGrid.jsp?contactpersonsname='+contactpersonsname.replace(/ /g, "%20")+'&contactpersonsmobile='+contactpersonsmobile.replace(/ /g, "%20")+'&contactpersonsdocno='+contactpersonsdocno+'&clientdocno='+clientdocno+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Doc No</td>
    <td width="46%"><input type="text" name="txtcontactpersonsdocno" id="txtcontactpersonsdocno" style="width:90%;" value='<s:property value="txtcontactpersonsdocno"/>'></td>
    <td width="6%" align="right">Mobile</td>
    <td width="28%"><input type="text" name="txtcontactpersonsmobile" id="txtcontactpersonsmobile" style="width:90%;" value='<s:property value="txtcontactpersonsmobile"/>'></td>
    <td width="14%" rowspan="2" align="center"><input type="button" name="btncontactpersonsearch" id="btncontactpersonsearch" class="myButton" value="Search"  onclick="loadContactPersonSearch();"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="3"><input type="text" name="txtcontactpersonsname" id="txtcontactpersonsname" style="width:90%;" value='<s:property value="txtcontactpersonsname"/>'></td>
  </tr>
  <tr>
	<td colspan="5"><div id="refreshcontactpersondiv"><jsp:include page="contactPersonDetailsGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>