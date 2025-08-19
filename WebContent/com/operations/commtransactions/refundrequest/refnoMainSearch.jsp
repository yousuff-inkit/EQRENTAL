 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
   <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>    --%>   
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">
	$(document).ready(function () {
	}); 
 	function loadSearch() {  
 	    var brhid=$('#brchName').val();   
 	    var reftype=$('#cmbreftype').val();        
 		var clnames=document.getElementById("Cl_name").value;
 		var clname = clnames.replace(' ', '%20');
		getdata(clname,reftype,brhid);      
	}
	function getdata(clname,reftype,brhid){       
	    var id=1;
	    $("#refreshdiv").load("searchRefno.jsp?clname="+clname+"&reftype="+reftype+"&brhid="+brhid+"&id="+id);             
    }
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">     
  <tr >  
   <td>
   <table width="100%">     
   <tr>  
    <td align="right">Customer</td>    
    <td align="left" width="70%" colspan="2"><input type="text" name="Cl_name" id="Cl_name"  style="width:96.5%;" value='<s:property value="Cl_name"/>'></td>
    <td align="right" width="5%"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td colspan="8" align="right">   
    <div id="refreshdiv"><jsp:include  page="searchRefno.jsp"></jsp:include></div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>