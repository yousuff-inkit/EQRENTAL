<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">
<script>
	$(document).ready(function(){
		var chk=$('#hdbrhid').val();
		//alert("====branch===="+chk);
		if($('#hdbrhid').val()=='1'){
			$('#imgcomplogo').attr('src','../../../../icons/greenstarlogo1.jpg');
		}
		else if($('#hdbrhid').val()=='2'){
			$('#imgcomplogo').attr('src','../../../../icons/greenstarlogo2.jpg');
		}
		else if($('#hdbrhid').val()=='3'){
			$('#imgcomplogo').attr('src','../../../../icons/greenstarlogo3.jpg');
		}
	});
</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<form>
 <div style="background-color:white;">
<table width="100%">
  <tr>
    <td width="100%" rowspan="6"><img src="<%=contextPath%>/icons/aitsheader.jpg" width="780" height="91"  alt="" id="imgcomplogo"/></td>
  <%--   <td width="45%" rowspan="2">&nbsp;</td>
    <td width="30%"><font size="3"><label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></font></td> --%>
  </tr>
 <%--  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>--%>
  <tr>
  <%--   <td rowspan="2"  align="center"><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr> --%>
   <%--<tr>
    <td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr> --%>
    
    </table>
    <table width="100%">
    <tr>
    <td rowspan="2"  align="center"><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <%--<td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>--%>
  </tr>
    </table>
    </div>
<input type="hidden" name="hdbrhid" id="hdbrhid" value='<s:property value="hdbrhid"/>'>
<hr>
</form>
</div>

</body>
</html>
