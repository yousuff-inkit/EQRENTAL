 <%@ taglib prefix="s" uri="/struts-tags" %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String contextPath=request.getContextPath(); 
 %>
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
		 
		
		
	}); 
	
	 function loadDataSearch() {
		 
			var regno=document.getElementById("vehregno").value;
			var flno=document.getElementById("vehflno").value;
			var flname=document.getElementById("vehflname").value;
			var check = 1;
			
		getdata(flname,regno,flno,check);
	}
	function getdata(flname,regno,flno,check){
		 $("#vehicleSearchGridDiv").load('vehicleSearchGrid.jsp?flname='+flname.replace(/ /g, "%20")+'&check='+check+'&regno='+regno+'&flno='+flno);
	} 

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Asset id</td>
    <td><input type="text" name="vehregno" id="vehregno" style="height:20px;" value='<s:property value="vehregno"/>'></td>
    <td align="right" style="font-size:9px;">Fleet No</td>
    <td><input type="text" name="vehflno" id="vehflno" style="height:20px;" value='<s:property value="vehflno"/>'></td>
    <td align="right" style="font-size:9px;">Fleet Name</td>
    <td><input type="text" name="vehflname" id="vehflname" style="height:20px;" value='<s:property value="vehflname"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadDataSearch()"></td>
  </tr>
  <tr>
     <td colspan="7"><div id="vehicleSearchGridDiv"><jsp:include page="vehicleSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>