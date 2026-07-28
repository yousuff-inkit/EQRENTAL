 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
//flnames flno regnos
	
	function loadtSearch() {
		var flnames=document.getElementById("flnames").value;
		

			var flno=document.getElementById("flno").value;
		
			var regnos=document.getElementById("regnos").value;
		
			var check = "load";
	
			getFleetDetails(flnames,flno,regnos,check);
	}
		
	function getFleetDetails(flnames,flno,regnos,check){ 

		 $("#fleetdiv").load("subfleetsearch.jsp?flno="+flno+'&flnames='+flnames.replace(/ /g, "%20")+'&regnos='+regnos+'&check='+check);
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

/* Table Layout */
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
    font-size: 12px;
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

            <!-- Dynamic sizing based on field length -->
            <colgroup>
                <col width="10%" />
                <col width="26%" />

                <col width="10%" />
                <col width="20%" />

                <col width="34%" />
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">Fleet No</td>
                <td>
                    <input type="text"
                           name="flno"
                           id="flno"
                           value='<s:property value="flno"/>'>
                </td>

                <td class="lbl-right">Reg No</td>
                <td>
                    <input type="text"
                           name="regnos"
                           id="regnos"
                           value='<s:property value="regnos"/>'>
                </td>

                <td align="center" rowspan="2">
                    <input type="button"
                           name="btnfleetSearch"
                           id="btnfleetSearch"
                           class="myButton"
                           value="Search"
                           onclick="loadtSearch();">
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">Fleet Name</td>

                <td colspan="3">
                    <input type="text"
                           name="flnames"
                           id="flnames"
                           value='<s:property value="flnames"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="fleetdiv">
            <jsp:include page="subfleetsearch.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>