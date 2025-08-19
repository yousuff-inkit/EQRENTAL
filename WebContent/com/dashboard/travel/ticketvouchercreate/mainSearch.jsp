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
	 $("#bookdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		var branch=document.getElementById("cmbbranch").value;  
 		var customer=document.getElementById("txtcustomer").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("bookdate").value;
 		var tno=document.getElementById("txtticketno").value;  
		var check=1;
		  
		getdata(customer,docNo,date,tno,check,branch);
	}
	function getdata(customer,docNo,date,tno,check,branch){   
		 $("#refreshdiv").load('mainSearchGrid.jsp?customer='+customer.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&tno='+tno+'&check='+check+'&branch='+branch);
		}

	</script>
<body>
<div id=search>
<table width="100%">  
  <tr>
    <td width="6%" align="right">Customer</td>
    <td colspan="3" width="25%" ><input type="text" name="txtcustomer" id="txtcustomer" style="width:100%" value='<s:property value="txtcustomer"/>'></td>
    <td width="11%" align="right">Doc No</td>
    <td colspan="2"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="17%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td width="10%" align="right">Ticket No</td>  
    <td width="14%" colspan="3"><input type="text" name="txtticketno" id="txtticketno" value='<s:property value="txtticketno"/>'></td>
    <td align="right" width="10%" >Booking Date</td>   
    <td width="14%"><div id="bookdate" name="bookdate"  value='<s:property value="bookdate"/>'></div></td>
   </tr>
  <tr>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="mainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>