 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
<%
 
 
 String fleetno=request.getParameter("rfleet")==null?"0":request.getParameter("rfleet");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");

 
%> 
<script type="text/javascript">
	var fleet='<%=fleetno%> ';
    var doc='<%=docno%> ';
 	function printNormal() {
        //alert(fleet+"==="+doc);
 		if(fleet=='' || fleet=='0'){
 			 $.messager.alert('Warning','Select a Document');
 			 return false;
 		   		}
 			var url=document.URL;
 		 var reurl=url.split("com/");
 		  	//var reurl=url.split("tarifMgmt.jsp");
 		  	
 		  	var win= window.open(reurl[0]+"com/operations/vehicletransactions/vehicleinspection/inspectionPrint.action?docno="+doc+"&fleetno="+fleet+"&lblurl="+window.location.origin,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 		    	//var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 			win.focus();
				
 	}
 	
 	function printMobile(){
 		
 		if(fleet=='' || fleet=='0'){
			 $.messager.alert('Warning','Select a Document');
			 return false;
		   		}
			var url=document.URL;
		 var reurl=url.split("com/");
		  	//var reurl=url.split("tarifMgmt.jsp");
		  	
		  	var win= window.open(reurl[0]+"com/operations/vehicletransactions/vehicleinspection/inspectionMobilePrint.action?docno="+doc+"&fleetno="+fleet+"&lblurl="+window.location.origin,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		    	//var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			win.focus();
 	}
 	
 	

</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnmobileprint" id="btnmobileprint" class="myButton" value="Mobile Print"  onclick="printMobile();"></td>
    <td align="center"><input type="button" name="btnnormalprint" id="btnnormalprint" class="myButton" value="Normal Print"  onclick="printNormal();"></td>
    
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>