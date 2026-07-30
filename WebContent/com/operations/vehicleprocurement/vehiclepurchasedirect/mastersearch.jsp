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
	    
		   /* Date */ 	
	    $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var accountss=document.getElementById("accountss").value;
 		var accnamesss=document.getElementById("accnamess").value;
 		var datess=document.getElementById("datess").value;
 
 		
 		var accnamess = accnamesss.replace(' ', '%20');
		
	    var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,aa);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,aa){
		
		 $("#refreshdivs").load('submasterSearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&aa='+aa);

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
    box-sizing: border-box;
    width: 100%;
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
    font-weight: 600;
    color: #222;
    white-space: nowrap;
    padding-right: 6px;
    font-size: 12px;
}

/* Button */
.modern-ui .myButton {
    height: 26px;
    padding: 0 22px;
    background: #0056b3;
    border: none;
    border-radius: 3px;
    color: #fff;
    font-size: 12px;
    font-weight: bold;
    cursor: pointer;
}

.modern-ui .myButton:hover {
    background: #004494;
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

            <!-- Adjusted widths -->
            <colgroup>
                <col width="8%" />
                <col width="18%" />

                <col width="8%" />
                <col width="18%" />

                <col width="14%" />
                <col width="34%" />
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text"
                           name="docnoss"
                           id="docnoss"
                           value='<s:property value="docnoss"/>'>
                </td>

                <td class="lbl-right">Account</td>
                <td>
                    <input type="text"
                           name="accountss"
                           id="accountss"
                           value='<s:property value="accountss"/>'>
                </td>

                <td class="lbl-right">Account Name</td>
                <td>
                    <input type="text"
                           name="accnamess"
                           id="accnamess"
                           value='<s:property value="accnamess"/>'>
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">Date</td>

                <td>
                    <div id="datess"
                         name="datess"
                         value='<s:property value="datess"/>'></div>
                </td>

                <td></td>
                <td></td>
                <td></td>

                <td align="center">
                    <input type="button"
                           name="searchs"
                           id="searchs"
                           class="myButton"
                           value="Search"
                           onclick="loadSearchs()">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdivs">

            <jsp:include page="submasterSearch.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>