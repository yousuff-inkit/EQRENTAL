 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
     <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
     <%String partindex=request.getParameter("partindex")==null?"":request.getParameter("partindex");
     String srvcadvisorconfig=request.getParameter("srvcadvisorconfig")==null?"0":request.getParameter("srvcadvisorconfig");
     %> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">
	var srvcadvisorconfig='<%=srvcadvisorconfig%>';
	
	$(document).ready(function () {
	 /* $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); */
	}); 

 	function loadSearch() {
 		var partindex='<%=partindex%>';
 		/* alert(partindex) */;
 		
 		var partno=document.getElementById("partno").value;
 		var prdctnme=document.getElementById("prdctnme").value.replace(/ /g, "%20");
 		var stock=document.getElementById("stock").value;
 		var unit=document.getElementById("unit").value;
 		var brand=document.getElementById("brand").value.replace(/ /g, "%20");
 		var cat=document.getElementById("cat").value.replace(/ /g, "%20");
 		var subcat=document.getElementById("subcat").value.replace(/ /g, "%20");
 		//var clname = clnames.replace(' ', '%20');
 		
	
		getdata(partno,prdctnme,stock,unit,partindex,brand,cat,subcat);
 

	}
	function getdata(partno,prdctnme,stock,unit,partindex,brand,cat,subcat){
		//alert(partno);
		$("#partsSearchGrid").jqxGrid('clear');
		$("#refreshdiv1").load('partsSearchGrid.jsp?partno='+partno+'&prdctnme='+prdctnme+'&stock='+stock+'&unit='+unit+'&partindex='+partindex+
				'&id=1&srvcadvisorconfig='+srvcadvisorconfig+'&brand='+brand+'&cat='+cat+'&subcat='+subcat);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table>
   <tr>
    <td align="right"><label style="font:10px Tahoma;">Part No</label></td>
    <td align="left" width="19%"><input type="text" name="partno" id="partno"  style="height:120%;" value='<s:property value="partno"/>'></td>
    <td align="right"><label style="font:10px Tahoma;">Product Name</label></td>
    <td align="left"><input type="text" name="prdctnme" id="prdctnme" style="height:120%;" value='<s:property value="prdctnme"/>'></td>
    <td align="right"><label style="font:10px Tahoma;">Stock</label></td>
    <td align="left" width="19%"><input type="text" name="stock" id="stock"  style="height:120%;" value='<s:property value="stock"/>'></td>
    <td width="3%" align="right"><label style="font:10px Tahoma;">Unit</label></td>
    <td width="19%" align="left"><input type="text" name="unit" id="unit" style="height:120%;" value='<s:property value="unit"/>'></td>
    </tr>
      <tr>
<td align="left" width="4%"><label style="font:10px Tahoma;">Brand</label></td>
    <td align="left" width=19%><input type="text" name="brand" id="brand" style="height:120%;" value='<s:property value="brand"/>'>
    
    <td width="8%" align="right"><label style="font:10px Tahoma;">Category</label></td>
    
    <td align="left" width="19%"><input type="text" name="cat" id="cat" style="height:120%;"  value='<s:property value="cat"/>'></td>
    <td width="9%" align="right"><label style="font:10px Tahoma;">Sub Category</label></td>
    <td width="19%" align="left"><input type="text" id="subcat" name="subcat" style="height:120%;" value='<s:property value="subcat"/>'></td>
   
    
    
    <td colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
    </table>
    </td>
  </tr>
  
 

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdiv1">
      
  <jsp:include  page="partsSearchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>