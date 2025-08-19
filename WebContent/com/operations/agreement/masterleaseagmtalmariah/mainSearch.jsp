<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../../../../css/body.css" rel="stylesheet">
<title>Insert title here</title>
<script>
	$(document).ready(function(e) {
		$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});

        $('#btnsearchdoc').click(function(e) {
            var cldocno=$('#searchcldocno').val();
			var clientname=$('#searchclientname').val();
			var date=$('#searchdate').jqxDateTimeInput('val');
			var po=$('#searchpo').val();
			var refno=$('#searchrefno').val();
			var vocno=$('#searchrefno').val();
			$('#mainsearchdiv').load('mainSearchGrid.jsp?cldocno='+cldocno+'&clientname='+clientname+'&date='+date+'&po='+po+'&refno='+refno+'&vocno='+vocno+'&id=1');
        });
    });
</script>
</head>
<body>
<table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Client </td>
    <td width="16%"><input type="text" name="searchcldocno" id="searchcldocno" placeholder="Client Id"> </td>
    <td colspan="4"><input type="text" name="searchclientname" id="searchclientname" placeholder="Client Name" style="width:99%;"></td>
    <td width="9%"  align="right">Date</td>
    <td width="12%"><div id="searchdate"></div></td>
  </tr>
  <tr>
    <td  align="right">Doc No</td>
    <td><input type="text" name="searchvocno" id="searchvocno" placeholder="Doc No"></td>
    <td width="7%"  align="right">PO</td>
    <td width="16%"><input type="text" name="searchpo" id="searchpo" placeholder="PO No"></td>
    <td width="12%"  align="right">Ref No</td>
    <td width="20%"><input type="text" name="searchrefno" id="searchrefno" placeholder="Ref No"></td>
    <td></td>
    <td><button type="button" name="btnsearchdoc" id="btnsearchdoc" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="8"><div id="mainsearchdiv"><jsp:include page="mainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>