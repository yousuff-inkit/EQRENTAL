<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<script>
$(document).ready(function(e) {
	$('#vendorSearchGrid').jqxGrid('clear');
    $('#btnVendorSearch').click(function(e) {
        var name=$('#searchvendorname').val();
		var mobile=$('#searchvendormobile').val();
		var tariftype='<%=request.getParameter("tariftype")==null?"":request.getParameter("tariftype")%>';
		$('#vendorsearchdiv').load('vendorSearchGrid.jsp?name='+name+'&mobile='+mobile+'&tariftype='+tariftype+'&id=1');
    });
});
</script>
<style>
body{
background: #E0ECF8 !important;
}
</style>
</head>
<body>
<table width="100%">
  <tr>
    <td width="12%" align="right">Name</td>
    <td width="51%"><input type="text" id="searchvendorname" name="searchvendorname" style="width:100%;"></td>
    <td width="8%" align="right">Mobile</td>
    <td width="14%"><input type="text" id="searchvendormobile" name="searchvendormobile"></td>
    <td width="15%" align="center"><button type="button" name="btnVendorSearch" id="btnVendorSearch" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="5"><div id="vendorsearchdiv"><jsp:include page="vendorSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>