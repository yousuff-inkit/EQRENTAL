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

 	function loadSearchs() {
 
 		
 		var formdetailcode=document.getElementById("formdetailcode").value;
 		
 
 		
 		var seachdoc=document.getElementById("seachdoc").value;
 		var fleetnoss=document.getElementById("fleetnoss").value;
 		var flnames=document.getElementById("flnamess").value;
 		var regnoss=document.getElementById("regnoss").value;
 	
 	
 		var flname = flnames.replace(/ /g, "%20");
		
	    var aa="yes";
		getdatas(seachdoc,fleetnoss,flname,regnoss,aa,formdetailcode);
 

	}
	function getdatas(seachdoc,fleetnoss,flname,regnoss,aa,formdetailcode){ 
 
		 $("#submastersearchs").load('submastersearch.jsp?fleetnoss='+fleetnoss+'&seachdoc='+seachdoc+'&flnames='+flname+'&regnoss='+regnoss+'&aa='+aa+"&formdetailcode="+formdetailcode);

		}

	</script>
<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Search Panel
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
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
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

/* Search Panel */
.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table */
.modern-ui table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 8px 10px;
    table-layout: fixed;
}

.modern-ui td {
    vertical-align: middle;
}

.modern-ui .lbl-right {
    text-align: right;
    color: #222;
    font-size: 12px;
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap;
    padding-right: 6px;
}

/* Button */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background-color: #0056b3;
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
    overflow: hidden;
    width: 100%;
}
</style>

<body style="background:#fff; margin:0;">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table border="0" cellspacing="0" cellpadding="0">

            <!-- Uniform Master Layout -->
            <colgroup>
                <col width="10%">
                <col width="23%">
                <col width="10%">
                <col width="23%">
                <col width="10%">
                <col width="24%">
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text"
                           name="seachdoc"
                           id="seachdoc"
                           value='<s:property value="seachdoc"/>'>
                </td>

                <td class="lbl-right">Fleet</td>
                <td>
                    <input type="text"
                           name="fleetnoss"
                           id="fleetnoss"
                           value='<s:property value="fleetnoss"/>'>
                </td>

                <td></td>
                <td></td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">Reg No</td>
                <td>
                    <input type="text"
                           name="regnoss"
                           id="regnoss"
                           value='<s:property value="regnoss"/>'>
                </td>

                <td class="lbl-right">Name</td>
                <td>
                    <input type="text"
                           name="flnamess"
                           id="flnamess"
                           value='<s:property value="flnamess"/>'>
                </td>

                <td></td>

                <td align="center">
                    <input type="button"
                           id="searchdata"
                           class="myButton"
                           value="Search"
                           onclick="loadSearchs();">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="submastersearchs">

            <jsp:include page="submastersearch.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>