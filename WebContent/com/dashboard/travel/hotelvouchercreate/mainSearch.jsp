 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" /> --%>
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#issuingdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 	    var branch=document.getElementById("cmbbranch").value;
 		var customer=document.getElementById("txtcustomer").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("issuingdate").value;
 		var suppconfno=document.getElementById("txtsuppconfno").value;    
		var check=1;
		getdata(customer,docNo,date,suppconfno,check,branch);    
	}
	function getdata(customer,docNo,date,suppconfno,check,branch){  
		 $("#refreshdiv").load('mainSearchGrid.jsp?customer='+customer.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&tno='+suppconfno+'&check='+check+'&branch='+branch);
		}

	</script>
<body>
<div id=search>
<table width="100%">    
  <tr>
    <td width="6%" align="right">Customer</td>
    <td colspan="3" width="25%" ><input type="text" name="txtcustomer" id="txtcustomer" style="width:100%" value='<s:property value="txtcustomer"/>'></td>
    <td width="6%" align="right">Doc No</td>
    <td width="6%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="17%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>  
  </tr>
  <tr>
    <td width="10%" align="right">Supplier Conformation No</td>      
    <td width="14%" colspan="3"><input type="text" name="txtsuppconfno" id="txtsuppconfno" style="width:100%" value='<s:property value="txtsuppconfno"/>'></td>
    <td align="right" width="6%" >Issuing Date</td>   
    <td width="6%"><div id="issuingdate" name="issuingdate"  value='<s:property value="issuingdate"/>'></div></td>      
   </tr>
  <tr>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="mainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>