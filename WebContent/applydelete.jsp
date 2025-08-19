<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="includes.jsp"></jsp:include>
<script type="text/javascript">
	function removeApply(){
		var acno=$('#acno').val();
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {

		    	$.messager.alert('Message','Successfully Removed','warning');
		    }
		  };
		  xhttp.open("POST", "APExecute.jsp?accountno="+acno, true);
		  xhttp.send();
	}
</script>
</head>
<body>

Account NO <input type="text" id="acno" >

<input type="button" value="Remove" onclick="removeApply();" > 
</body>
</html>