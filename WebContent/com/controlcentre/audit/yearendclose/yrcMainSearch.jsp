<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
/* =========================================================
   SCOPED UI: Modern Segoe UI Theme & Search Panel
========================================================= */
html, body {
    margin: 0;
    padding: 0;
    background-color: #ffffff !important; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    background-color: #ffffff !important; 
}

/* Standardized Input Controls */
.modern-ui input[type="text"] {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #ffffff !important; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Container */
.modern-ui .search-panel {
    background-color: #ffffff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
    overflow-x: auto; 
}

/* Grid Layout Table */
.modern-ui table.form-grid {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    min-width: 900px; 
    background-color: #ffffff !important; 
}

.modern-ui table.form-grid td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Primary Button */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s ease-in-out;
    min-width: 90px;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Results Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    background-color: #ffffff !important; 
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        if ($("#yrcdate").length) {
            $("#yrcdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString: "dd.MM.yyyy", value: null });
        }
        if ($("#yrcAccFrmDate").length) {
            $("#yrcAccFrmDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString: "dd.MM.yyyy", value: null });
        }
        if ($("#yrcAccToDate").length) {
            $("#yrcAccToDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString: "dd.MM.yyyy", value: null });
        }
    }); 

    function loadSearch() {
        var docNo = document.getElementById("txtdocno") ? document.getElementById("txtdocno").value : "";
        // Correctly fetch widget values using jqx API instead of generic .value
        var date = $("#yrcdate").length ? $('#yrcdate').jqxDateTimeInput('val') : "";
        var yrcAccFrmDate = $("#yrcAccFrmDate").length ? $('#yrcAccFrmDate').jqxDateTimeInput('val') : "";
        var yrcAccToDate = $("#yrcAccToDate").length ? $('#yrcAccToDate').jqxDateTimeInput('val') : "";
    
        getdata(docNo, date, yrcAccFrmDate, yrcAccToDate);
    }

    function getdata(docNo, date, yrcAccFrmDate, yrcAccToDate) {
        var url = 'yrcMainSearchGrid.jsp?docNo=' + encodeURIComponent(docNo) + 
                  '&date=' + encodeURIComponent(date) + 
                  '&yrcAccFrmDate=' + encodeURIComponent(yrcAccFrmDate) + 
                  '&yrcAccToDate=' + encodeURIComponent(yrcAccToDate);
                  
        $("#refreshdiv").load(url);
    }
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- Modified colgroup to give longer labels (Accounting Year) extra room -->
            <colgroup>
                <col width="13%" />  <col width="17%" />
                <col width="13%" />  <col width="17%" />
                <col width="10%" />  <col width="10%" />
                <col width="10%" />  <col width="10%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="yrcdate"></div>
                    <input type="hidden" name="hidyrcdate" id="hidyrcdate" value='<s:property value="hidyrcdate"/>'>
                </td>
                
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>' autocomplete="off">
                </td>
                
                <!-- Spacer columns for alignment -->
                <td colspan="4"></td>
            </tr>
            
            <tr>
                <td class="lbl-right">Accounting Year From</td>
                <td>
                    <div id="yrcAccFrmDate"></div>
                    <input type="hidden" name="hidyrcAccFrmDate" id="hidyrcAccFrmDate" value='<s:property value="hidyrcAccFrmDate"/>'>
                </td>
                
                <td class="lbl-right">Accounting Year To</td>
                <td>
                    <div id="yrcAccToDate"></div>
                    <input type="hidden" name="hidyrcAccToDate" id="hidyrcAccToDate" value='<s:property value="hidyrcAccToDate"/>'>
                </td>
                
                <!-- Search Button aligned on far right -->
                <td colspan="4" align="right">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="yrcMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>