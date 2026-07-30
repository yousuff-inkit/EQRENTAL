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
	
	
	function loadAccountSearch() {
		var masterdate=document.getElementById("vehpurorderDate").value;
		

			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var currs=document.getElementById("txtaccountcurrency").value;
		
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,currs,check,masterdate);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,check,masterdate){

		 $("#refreshAccountDetailsDiv").load("accountsDetailsFromGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&check='+check+'&masterdate='+masterdate);
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

            <!-- Dynamic layout based on label length -->
            <colgroup>
                <col width="11%" />
                <col width="25%" />

                <col width="9%" />
                <col width="20%" />

                <col width="35%" />
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">Account No</td>
                <td>
                    <input type="text"
                           name="txtaccountsno"
                           id="txtaccountsno"
                           value='<s:property value="txtaccountsno"/>'>
                </td>

                <td class="lbl-right">Currency</td>
                <td>
                    <input type="text"
                           name="txtaccountcurrency"
                           id="txtaccountcurrency"
                           value='<s:property value="txtaccountcurrency"/>'>

                    <input type="hidden"
                           name="txtsearchtype"
                           id="txtsearchtype"
                           value='<s:property value="txtsearchtype"/>'>
                </td>

                <td align="center" rowspan="2">
                    <input type="button"
                           name="btnAccountSearch"
                           id="btnAccountSearch"
                           class="myButton"
                           value="Search"
                           onclick="loadAccountSearch();">
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">Account Name</td>

                <td colspan="3">
                    <input type="text"
                           name="txtaccountsname"
                           id="txtaccountsname"
                           value='<s:property value="txtaccountsname"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountsDetailsFromGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>