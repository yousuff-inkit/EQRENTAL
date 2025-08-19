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
	$(document).ready(function () {
		 
		 $("#txtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		
	});  

 	function loadSearch() {

 		var clientName=document.getElementById("txtclient").value;
 		var agmtNo=document.getElementById("txtagmtno").value;
 		var regNo=document.getElementById("txtregno").value;
 		var fleetNo=document.getElementById("txtfleetno").value;
 		var txtdate=$('#txtdate').jqxDateTimeInput('val');
		getdata(clientName,agmtNo,regNo,fleetNo,txtdate);
	}
	function getdata(clientName,agmtNo,regNo,fleetNo,txtdate){
		 $("#agmtdiv").load('agreementDetailSearchGrid.jsp?clientName='+clientName.replace(/ /g, "%20")+'&agmtno='+agmtNo+'&regno='+regNo+'&fleetno='+fleetNo+'&date='+txtdate);
		}

	</script>
<body>
<div id=search>
<table width="100%" border="0">
  <tr>
    <td width="10%" align="right" style="font-size:9px;">Date</td>
    <td width="18%"><div id="txtdate" name="txtdate"></div></td>
    <td width="10%" align="right" style="font-size:9px;">Client</td>
    <td colspan="2"><input type="text" name="txtclient" id="txtclient" style="width:100%;height:20px;" value='<s:property value="txtclient"/>'></td>
    <td width="25%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Agmt No</td>
    <td><input type="text" name="txtagmtno" id="txtagmtno" style="width:100%;height:20px;" value='<s:property value="txtagmtno"/>'></td>
    <td align="right" style="font-size:9px;">Reg No</td>
    <td width="25%"><input type="text" name="txtregno" id="txtregno" style="width:100%;height:20px;" value='<s:property value="txtregno"/>'></td>
    <td width="12%" align="right" style="font-size:9px;">Fleet No</td>
    <td><input type="text" name="txtfleetno" id="txtfleetno" style="width:100%;height:20px;" value='<s:property value="txtfleetno"/>'></td>
  </tr>
    <tr>
    <td colspan="6"><div id="agmtdiv"><jsp:include page="agreementDetailSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>