 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
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
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var cldocno=document.getElementById("txtclientdocno").value;
 		
 		
		getdata(cldocno);
		
	}
	
	function funupdate(){
	
	var rtype=document.getElementById("txthidtype").value; 
	var docno=document.getElementById("hiddocno").value;
	  $.messager.confirm('Message', 'Do you want to change Agreement?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 
		     		 saveGridData(rtype,docno);	
		     	}
		 });
	
	
	}
	
	function saveGridData(rtype,docno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						$("#overlay, #PleaseWait").hide();
						 $.messager.alert('Message',items); 
						
		}
			
	x.open("GET","updateData.jsp?rtype="+rtype+"&rdocno="+docno,true);
	x.send();
	}
	function getdata(cldocno){
		 $("#refreshdiv").load('agmtsearchGrid.jsp?cldoc='+cldocno);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <%-- <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;height:20px;" value='<s:property value="txtpartyname"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  <td width="7%" align="right" style="font-size:9px;">Account</td>
    <td width="26%"><input type="text" name="txtaccountno" id="txtaccountno" style="width:70%;height:20px;" value='<s:property value="txtaccountno"/>'></td>
    <td width="18%" align="right" style="font-size:9px;">Contact No.</td>
    <td width="49%"><input type="text" name="txtcontactno" id="txtcontactno" style="width:50%;height:20px;" value='<s:property value="txtcontactno"/>'></td>   
  </tr> --%>
  <tr>
  <td>
<button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funupdate();">Update</button></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="agmtsearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>