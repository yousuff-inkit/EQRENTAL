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
 		var trdate=document.getElementById("tdate").value;
 		var Cl_namess=document.getElementById("Cl_names").value;
 		var reftype=document.getElementById("reftype").value;
 		var types=document.getElementById("type").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		
	getdata1(Cl_names,msdocno,reftype,trdate,types);   
	}
	function getdata1(Cl_names,msdocno,reftype,trdate,types){
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&reftype='+reftype+'&trdate='+trdate+'&types='+types+'&id='+1);   
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
	    <td align="right">Name</td>
	    <td align="left" width="70%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
	    <td align="right" width="5%" >Date </td>  
	    <td align="left" ><div id="tdate" name="tdate"  value='<s:property value="tdate"/>'></div>
   </tr>       
   <tr>
	  <td width="4%">Ref.Type</td><td><select  name="reftype" id="reftype" style="width:100%;"  value='<s:property value="reftype"/>' >
	  <option value="">--select--</option>      
	  <option value="ser">Service Request</option></select></td>  
	    <td width="4%">Type</td><td><select  name="type" id="type" style="width:50%;"  value='<s:property value="type"/>' >
	  <option value="">--select--</option>                                  
	  <option value="tour">Tour</option>
            <option value="ticket">Ticket</option>
            <option value="hotel">Hotel</option></select>  </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch()"></td>
    <tr>
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