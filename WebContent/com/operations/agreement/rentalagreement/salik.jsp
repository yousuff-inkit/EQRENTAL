<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
	
<style type="text/css">
.icon1 {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #f0f0f0;
}
</style>
</head>
<body>
	<div style="width:100%;">
        <fieldset>
        	<legend><fmt:message key="global.saliks"/></legend>
        	<fieldset>
        		<legend><fmt:message key="global.saliksinvoiced"/></legend>
				<jsp:include page="salikInvoiced.jsp"></jsp:include><br/>
			</fieldset>
			<fieldset>
				<legend><fmt:message key="global.saliksnotinvoiced"/></legend>
				<jsp:include page="salikNotInvoiced.jsp"></jsp:include><br/>
			</fieldset>
		</fieldset>
	</div>
</body>
</html>