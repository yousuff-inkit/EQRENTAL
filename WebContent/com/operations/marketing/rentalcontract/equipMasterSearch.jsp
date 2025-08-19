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
		$("#equipsearchdate").jqxDateTimeInput({ width: '100%', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function equipSearch() {
 		var fleetno=document.getElementById("equipsearchfleet").value;
 		var docno=document.getElementById("equipsearchdocno").value;
 		var regno=document.getElementById("equipsearchregno").value;
 		var fleetname=document.getElementById("equipsearchfleetname").value;
 		var searchdate=$('#equipsearchdate').jqxDateTimeInput('val');
 		var engine=document.getElementById("equipsearchengine").value;
		var chassis=document.getElementById("equipsearchchassis").value;
		equipgetdata(fleetno,docno,regno,fleetname,searchdate,engine,chassis);
	}
	function equipgetdata(fleetno,docno,regno,fleetname,searchdate,engine,chassis){
		
		 $("#equipsearchgriddiv").load('equipSearchGrid.jsp?fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&fleetname='+fleetname+'&searchdate='+searchdate+'&id=1&engine='+engine+'&chassis='+chassis);
		 

		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
  <table width="100%" >
    <tr>
    <td width="6%" align="right">Equip No</td>
    <td width="19%" align="left"><input type="text" name="equipsearchfleet" id="equipsearchfleet" value='<s:property value="equipsearchfleet"/>'></td>
    <td width="9%" align="right">Equip Name</td>
    <td align="left"><input type="text" name="equipsearchfleetname" id="equipsearchfleetname" value='<s:property value="equipsearchfleetname"/>' style="width:99%;"></td>
    <td align="right">Engine No</td>
    <td align="left"><input type="text" name="equipsearchengine" id="equipsearchengine" value='<s:property value="equipsearchengine"/>'></td>
    <td align="right">Chassis No</td>
    <td align="left"><input type="text" name="equipsearchchassis" id="equipsearchchassis" value='<s:property value="equipsearchchassis"/>'></td>
    </tr>
  <tr>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="equipsearchdocno" id="equipsearchdocno"  value='<s:property value="equipsearchdocno"/>'></td>
    <td align="right">Date</td>
    <td width="19%" align="left"><div id="equipsearchdate" name="equipsearchdate"></div></td>
    <td width="12%" align="right">Asset id</td>
    <td width="11%" align="left"><input type="text" name="equipsearchregno" id="equipsearchregno"></td>
    <td width="24%" colspan="2" align="center"><input type="button" name="btnequipsearch" id="btnequipsearch" class="myButton" value="Search"  onClick="equipSearch();"></td>
    
  </tr>
  <tr>
    <td colspan="8" align="right"> 
    <div id="equipsearchgriddiv">
      
   <jsp:include  page="equipSearchGrid.jsp"></jsp:include> 
   
   </div></td>
    </tr>
</table>

  </div>
</body>
</html>