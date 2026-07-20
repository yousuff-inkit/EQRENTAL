 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
  <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>
<style>
/* =========================================================
   SCOPED UI: Strict Pixel Grid Alignment & Modern Inputs
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Master Input Heights - Explicit Font Family Added */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-weight: normal !important; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling - Pure White */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
}

/* Table Alignment - STRICT PERCENTAGE GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed; /* Locks columns from squishing */
}

.modern-ui td {
    vertical-align: middle;
    padding: 0;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Search Button */
.modern-ui .myButton {
    height: 26px !important; 
    line-height: 24px !important;
    padding: 0 30px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff !important;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
    text-transform: uppercase;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}
</style>
	<script type="text/javascript">
	$(document).ready(function () {
		 $("#searchsalesinvdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 


 	function mainloadSearch() {
 		
 		var searchdate=$('#searchsalesinvdate').jqxDateTimeInput('val');
 		var docno=document.getElementById("searchsalesinvvocno").value;
 		var name=document.getElementById("searchname").value;
 		var acno=document.getElementById("searchacno").value;
 		var mobile=document.getElementById("searchmobile").value;
		
		getdata(searchdate,docno,name,acno,mobile);
 
	}

	 function getdata(searchdate,docno,name,acno,mobile){
		
		 $("#srefreshdiv").load('salesInvSearchGrid.jsp?searchdate='+searchdate+'&docno='+docno+'&name='+name+'&acno='+acno+'&mobile='+mobile+'&id=1');
		 
		}
 
	</script>
<body bgcolor="#E0ECF8">
	<div id=search>
  		<table width="100%" >
    		<tr>
			    <td width="12%" align="right">Doc No</td>
			    <td width="14%" align="left"><input type="text" name="searchsalesinvvocno" id="searchsalesinvvocno"></td>
			    <td width="7%" align="right">Date</td>
			    <td width="13%" align="left"><div id="searchsalesinvdate" name="searchsalesinvdate"></div></td>
			    <td width="13%" align="right">Mobile</td>
			    <td width="15%" align="left"><input type="text" name="searchmobile" id="searchmobile" ></td>
			    <td width="12%" align="right">&nbsp;</td>
			    <td width="14%" align="left">&nbsp;</td>
    		</tr>
  			<tr>
			    <td align="right">Name</td>
			    <td colspan="3" align="left"><input type="text" name="searchname" id="searchname" style="width:99%;"></td>
			    <td align="right">A/c No</td>
			    <td align="left"><input type="text" name="searchacno" id="searchacno"></td>
			    <td align="right">&nbsp;</td>
			    <td align="center"><input type="button" name="btnSearchExt" id="btnSearchExt" class="myButton" value="Search" onClick="mainloadSearch();"></td>
  			</tr>
  			<tr>
  				<td colspan="8">
   					<div id="srefreshdiv">
   						<jsp:include page="salesInvSearchGrid.jsp"></jsp:include> 
  					</div>
  				</td>
  			</tr>
 		</table>
	</div>
</body>
</html>