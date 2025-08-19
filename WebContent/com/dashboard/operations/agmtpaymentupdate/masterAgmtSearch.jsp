<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
.dfont{
	font-size:12px;
	font-family: Tahoma;
}
</style>
<script>
$(document).ready(function() {
	$("#searchagmtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    $('#btnagmtsearch').click(function(e) {
        var agmtno=$('#searchagmtdocno').val();
		var clientname=$('#searchclientname').val();
		var clientmobile=$('#searchclientmobile').val();
		var clientmail=$('#searchclientmail').val();
		var agmtdate=$('#searchagmtdate').jqxDateTimeInput('val');
		//$("#overlay, #PleaseWait").show();
		
		$('#agmtsearchdiv').load('agmtSearchGrid.jsp?agmtno='+agmtno+'&clientname='+clientname+'&clientmobile='+clientmobile+'&clientmail='+clientmail+'&id=1&agmtdate='+agmtdate);
    });
});
</script>
</head>
<body>
<table width="100%" border="0">
  <tr>
    <td width="13%" align="right"><span class="dfont">Doc No</span></td>
    <td width="15%"><input type="text" name="searchagmtdocno" id="searchagmtdocno" style="height:18px;"></td>
    <td width="11%" align="right"><span class="dfont">Client</span></td>
    <td colspan="4"><input type="text" name="searchclientname" id="searchclientname" style="height:18px;width:100%;"></td>
  </tr>
  <tr>
    <td align="right"><span class="dfont">Mobile</span></td>
    <td><input type="text" name="searchclientmobile" id="searchclientmobile" style="height:18px;"></td>
    <td align="right"><span class="dfont">Email</span></td>
    <td width="16%"><input type="text" name="searchclientmail" id="searchclientmail" style="height:18px;"></td>
    <td width="12%" align="right"><span class="dfont">Date</span></td>
    <td width="22%"><div id="searchagmtdate"></div></td>
    <td width="11%" align="center"><button type="button" name="btnagmtsearch" id="btnagmtsearch" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="7"><div id="agmtsearchdiv"><jsp:include page="agmtSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>