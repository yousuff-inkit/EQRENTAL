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

 	function loadSearch() {

 		var clientname=document.getElementById("txtclname").value;
 		var cldocno=document.getElementById("txtcldocno").value;
 		var chk = 1;
 		
		getdata(clientname,cldocno,chk);
	}
	function getdata(clientname,cldocno,chk){
		 $("#clientSearchDiv").load('clientSearchGrid.jsp?clientname='+clientname.replace(/ /g, "%20")+'&cldocno='+cldocno+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtclname" id="txtclname" style="width:100%;height:20px;" value='<s:property value="txtclname"/>'>
    <input type="hidden" name="txtcldocno" id="txtcldocno" style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearchClient" id="btnsearchClient" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="clientSearchDiv"><jsp:include page="clientSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>