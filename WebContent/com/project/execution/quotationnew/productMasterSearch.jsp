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

	<script type="text/javascript">
	$(document).ready(function () {
		document.getElementById("txtcldocnos").value=$('#clientid').val();
		document.getElementById("txtestdates").value=$('#date').val();
		document.getElementById("txtgridservicetypeids").value=$('#txtgridservicetypeid').val();
		document.getElementById("txtgridscopeids").value=$('#txtgridscopeid').val();
	}); 

 	function loadSearch() {

 		var productsname=document.getElementById("txtproductsname").value;
 		var brandsname=document.getElementById("txtbrandsname").value;
 		var cldocnos=document.getElementById("txtcldocnos").value;
 		var estdates=document.getElementById("txtestdates").value;
 		var gridprdname=document.getElementById("txtgridprdname").value;
 		var gridunit=document.getElementById("txtgridunit").value;
 		var gridservicetypeid=document.getElementById("txtgridservicetypeids").value;
 		var gridscopeid=document.getElementById("txtgridscopeids").value;
		
		var id="1";
		getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit,gridservicetypeid,gridscopeid);
	}
	function getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit,gridservicetypeid,gridscopeid){
		 $("#refreshProductDiv").load('productSearch.jsp?productsname='+productsname.replace(/ /g, "%20")+'&brandsname='+brandsname.replace(/ /g, "%20")+'&cldocnos='+cldocnos+'&estdates='+estdates+"&id="+id+"&gridprdname="+gridprdname+"&gridunit="+gridunit+"&stypeid="+gridservicetypeid+"&scopeid="+gridscopeid);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Product</td> <!-- partno -->
    <td colspan="3"><input type="text" name="txtproductsname" id="txtproductsname" style="width:80%" value='<s:property value="txtproductsname"/>'></td>
    <td width="11%" align="right">Brand</td>
    <td colspan="2"><input type="text" name="txtbrandsname" id="txtbrandsname" style="width:80%" value='<s:property value="txtbrandsname"/>'>
    <input type="hidden" name="txtcldocnos" id="txtcldocnos" style="width:80%" value='<s:property value="txtcldocnos"/>'>
    <input type="hidden" name="txtestdates" id="txtestdates" style="width:80%" value='<s:property value="txtestdates"/>'>
    <input type="hidden" name="txtgridservicetypeids" id="txtgridservicetypeids" style="width:80%" value='<s:property value="txtgridservicetypeids"/>'>
    <input type="hidden" name="txtgridscopeids" id="txtgridscopeids" style="width:80%" value='<s:property value="txtgridscopeids"/>'></td>
    <td width="17%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  
  <tr>
  		<td width="6%" align="right">Product Name</td>
    	<td colspan="3"><input type="text" name="txtgridprdname" id="txtgridprdname" style="width:80%" value='<s:property value="txtgridprdname"/>'></td>
    	<td width="11%" align="right">Unit</td>
    	<td colspan="2"><input type="text" name="txtgridunit" id="txtgridunit" style="width:80%" value='<s:property value="txtgridunit"/>'>
    
  </tr>
  
  <tr>
    <td colspan="8"><div id="refreshProductDiv"><jsp:include  page="productSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>