 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<style>
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
 --%>
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#contractsearchdate").jqxDateTimeInput({ width: '100%', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function contractSearch() {
 		var contractno=document.getElementById("contractsearchvocno").value;
 		var hiremode=document.getElementById("cmbcontractsearchhiremode").value;
 		var quoteno=document.getElementById("contractsearchquoteno").value;
 		var contractdate=$('#contractsearchdate').jqxDateTimeInput('val');
 		var clientname=document.getElementById("contractsearchclientname").value;
 		var assetid=document.getElementById("assetid").value;
 		
 		$("#contractsearchgriddiv").load('contractSearchGrid.jsp?contractno='+contractno+'&hiremode='+hiremode+'&quoteno='+quoteno+'&id=1&contractdate='+contractdate+'&clientname='+clientname+'&assetid='+assetid);
	}
	</script>
<body bgcolor="#E0ECF8">
	<div id=search>
		<table width="100%" border="0">
 			<tr>
			    <td align="right">Doc No</td>
			    <td align="left"><input type="text" name="contractsearchvocno" id="contractsearchvocno"  value='<s:property value="contractsearchvocno"/>'></td>
			    <td align="right">Date</td>
			    <td width="19%" align="left"><div id="contractsearchdate" name="contractsearchdate"></div></td>
			    <td width="12%" align="right">Quote No</td>
			    <td width="11%" align="left"><input type="text" name="contractsearchquoteno" id="contractsearchquoteno"></td>
			    <td width="24%" colspan="2" align="center"><input type="button" name="btnquotesearch" id="btnquotesearch" class="myButton" value="Search"  onClick="contractSearch();"></td>
  			</tr>
  			<tr>
  				<td align="right">Hire Mode</td>
  				<td>
  					<select name="cmbcontractsearchhiremode" id="cmbcontractsearchhiremode">
  						<option value="">--Select--</option>
  						<option value="Daily">Daily</option>
  						<option value="Weekly">Weekly</option>
  						<option value="Monthly">Monthly</option>
  					</select>	
  				</td>
  				<td align="right">Client Name</td>
  				<td ><input style="width: 98%;" type="text" name="contractsearchclientname" id="contractsearchclientname"  value='<s:property value="contractsearchclientname"/>'></td>
  				<td width="12%" align="right">Asset Id</td>
			    <td width="11%" align="left"><input type="text" name="assetid" id="assetid"></td>
			    
  			</tr>
  			<tr>
    			<td colspan="8" align="right"> 
    				<div id="contractsearchgriddiv">
						<jsp:include  page="contractSearchGrid.jsp"></jsp:include> 
   					</div>
   				</td>
    		</tr>
		</table>
  	</div>
</body>
</html>