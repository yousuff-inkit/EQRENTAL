 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>   
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	  $("#mastersearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qutloadSearch() {
 		
 		
 		
 		
 		
 		var qutdocno=document.getElementById("qutdocno").value;
 		 var clientnames=document.getElementById("clientname").value;
 		var refno=document.getElementById("searchrefno").value;
 		var qutdate=document.getElementById("mastersearchdate").value;
 		//var quttype=document.getElementById("quttype").value; 
 		
 		
 		var clientname = clientnames.replace(' ', '%20');
 		var assetid=document.getElementById("assetid").value;

	
	getdata1(qutdocno,clientname,refno,qutdate,assetid);
 
           
	}
	function getdata1(qutdocno,clientname,refno,qutdate,assetid){
		

		var branch=$('#brchName').val();
		 $("#qutrediv").load('masterSearchGrid.jsp?branch='+branch+'&id=1&qutdocno='+qutdocno+'&clientname='+clientname+'&refno='+refno+'&qutdate='+qutdate+'&assetid='+assetid);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table style="width:100%;" >
   <tr>
   <td align="right">Doc No</td>
    <td align="left" width="2%"><input type="text" name="qutdocno" id="qutdocno"  value='<s:property value="qutdocno"/>'></td>
    <td align="right" >Date</td>
    <td align="left" ><div id="mastersearchdate" name="mastersearchdate"  value='<s:property value="mastersearchdate"/>'></div></td>
    <td align="right" >Ref No</td>
      <td align="left" width="28%"><input type="text" name="searchrefno" id="searchrefno" value='<s:property value="searchrefno"/>'></td>
      </tr>
        <tr> 
        <td align="right">Client Name </td>
    	<td align="left" colspan="4"><input type="text" name="clientname" id="clientname"  style="width:98%" value='<s:property value="clientname"/>'></td>
	    <td width="12%" align="left">Asset Id&nbsp;&nbsp;<input type="text" name="assetid" id="assetid"></td>
			     
	<td>   
   <input type="button" name="qutbtnrasearch" id="qutbtnrasearch" class="myButton" value="Search"  onclick="qutloadSearch()"></td>
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="qutrediv">
      
   <jsp:include  page="masterSearchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>