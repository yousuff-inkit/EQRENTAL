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

 		var driverName=document.getElementById("txtpartyname").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		
		getdata(driverName,contactNo);
	}
	function getdata(driverName,contactNo){
		 $("#refreshdiv").load('driverDetailsSearchGrid.jsp?drivername='+driverName.replace(/ /g, "%20")+'&contactno='+contactNo+'&id=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;height:20px;" value='<s:property value="txtpartyname"/>'></td>
    <td  align="right" style="font-size:9px;">Contact No.</td>
    <td  ><input type="text" name="txtcontactno" id="txtcontactno" style="height:20px;" value='<s:property value="txtcontactno"/>'></td>
    <td  align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include page="driverDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>