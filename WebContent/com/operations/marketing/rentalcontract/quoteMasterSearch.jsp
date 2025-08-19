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
		$("#quotesearchdate").jqxDateTimeInput({ width: '100%', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function quoteSearch() {
 		var attention=document.getElementById("quotesearchattention").value;
 		var docno=document.getElementById("quotesearchdocno").value;
 		var searchdate=$('#quotesearchdate').jqxDateTimeInput('val');
 		
		quotemastersearchdata(attention,docno,searchdate);
	}
	function quotemastersearchdata(attention,docno,searchdate){
		var cldocno=$('#cldocno').val();
		 $("#quotesearchgriddiv").load('quoteSearchGrid.jsp?cldocno='+cldocno+'&docno='+docno+'&searchdate='+searchdate+'&id=1&attention='+attention);
		 

		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
  <table width="100%" >
  <tr>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="quotesearchdocno" id="quotesearchdocno"  value='<s:property value="quotesearchdocno"/>'></td>
    <td align="right">Date</td>
    <td width="19%" align="left"><div id="quotesearchdate" name="quotesearchdate"></div></td>
    <td width="12%" align="right">Attention</td>
    <td width="11%" align="left"><input type="text" name="quotesearchattention" id="quotesearchattention"></td>
    <td width="24%" colspan="2" align="center"><input type="button" name="btnquotesearch" id="btnquotesearch" class="myButton" value="Search"  onClick="quoteSearch();"></td>
    
  </tr>
  <tr>
    <td colspan="8" align="right"> 
    <div id="quotesearchgriddiv">
      
   <jsp:include  page="quoteSearchGrid.jsp"></jsp:include> 
   
   </div></td>
    </tr>
</table>

  </div>
</body>
</html>