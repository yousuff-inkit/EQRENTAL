 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>      
	<script type="text/javascript">        
	$(document).ready(function () {
	  $("#tdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function loadSearch(){  
 	    var brhid=document.getElementById("brchName").value;   
 		var trdate=document.getElementById("tdate").value;
 		var reftype=document.getElementById("reftype").value;
 		var msdocno=document.getElementById("msdocno").value;    
	    getdata1(msdocno,reftype,trdate,brhid);   
	}
	function getdata1(msdocno,reftype,trdate,brhid){
		 $("#refreshdivmas").load('subMastersearch.jsp?msdocno='+msdocno+'&reftype='+reftype+'&trdate='+trdate+'&brhid='+brhid+'&id='+1);  
	}
	</script>
<body bgcolor="#E0ECF8">  
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>       
   <tr>  
	    <td align="right">Docno</td>      
	    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
	    <td width="4%">Ref.Type</td><td><select  name="reftype" id="reftype" style="width:100%;"  value='<s:property value="reftype"/>' >
	      <option value="">--select--</option>      
	      <option value="T">Travel Desk</option><option value="A">Air Ticket</option><option value="V">Voucher</option></select></td>    
	    <td align="right" width="5%" >Date </td>  
	    <td align="left" ><div id="tdate" name="tdate"  value='<s:property value="tdate"/>'></div></td>
	    <td align="right"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch()"></td>
   </tr>       
    </table>  
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>