<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style type="text/css">
	label.branch{
		background-color:transparent;
	}
	body{
		margin:0;
	}
	table.temp{
		background-color: #E0ECF8;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#agmtsearchdate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy",value:null});
		$('#agmtsearchbtn').click(function(){
			var docno=$('#agmtsearchdocno').val();
			var date=$('#agmtsearchdate').jqxDateTimeInput('val');
			var fleetno=$('#agmtsearchfleetno').val();
			var regno=$('#agmtsearchregno').val();
			var clientname=$('#agmtsearchclientname').val();
			var mobile=$('#agmtsearchmobile').val();
			$("#overlay, #PleaseWait").show(); 
			$('#agmtsearchdiv').load('agmtSearchGrid.jsp?docno='+docno+'&date='+date+'&fleetno='+fleetno+'&regno='+regno+'&clientname='+clientname+'&clientmobile='+mobile+'&id=1');
		});
	});
	
</script>
</head>
<body>
	<table width="100%" class="temp">
  		<tr>
    		<td width="8%" align="right"><label class="branch">Doc No</label></td>
		    <td width="20%"><input type="text" name="agmtsearchdocno" id="agmtsearchdocno" value='<s:property value="agmtsearchdocno"/>'  style="height:20px;"></td>
		    <td width="7%" align="right"><label class="branch">Date</label></td>
		    <td width="12%"><div id="agmtsearchdate" name="agmtsearchdate"></div></td>
		    <td width="10%" align="right"><label class="branch">Fleet No</label></td>
		    <td width="14%"><input type="text" name="agmtsearchfleetno" id="agmtsearchfleetno" value='<s:property value="agmtsearchfleetno"/>'  style="height:20px;"></td>
		    <td width="15%" align="right"><label class="branch">Reg No</label></td>
		    <td width="14%"><input type="text" name="agmtsearchregno" id="agmtsearchregno" value='<s:property value="agmtsearchregno"/>'  style="height:20px;"></td>
  		</tr>
  		<tr>
    		<td align="right"><label class="branch">Client Name</label></td>
		    <td colspan="3"><input type="text" name="agmtsearchclientname" id="agmtsearchclientname" value='<s:property value="agmtsearchclientname"/>' style="width:99%;height:20px;"></td>
		    <td align="right"><label class="branch">Mobile</label></td>
		    <td><input type="text" name="agmtsearchmobile" id="agmtsearchmobile" value='<s:property value="agmtsearchmobile"/>'  style="height:20px;"></td>
		    <td colspan="2" align="center"><button type="button" name="agmtsearchbtn" id="agmtsearchbtn" class="myButton">Search</button></td>
  		</tr>
  		<tr>
    		<td colspan="8"><div id="agmtsearchdiv"><jsp:include page="agmtSearchGrid.jsp"></jsp:include></div></td>
  		</tr>
	</table>
</body>
</html>