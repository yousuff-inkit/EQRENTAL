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

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
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
.modern-ui input[type="text"],
.modern-ui select {
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

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
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
        if ($("#mastersearchdate").length) {
            $("#mastersearchdate").jqxDateTimeInput({ 
                width: '100%', 
                height: '24px', 
                formatString: "dd.MM.yyyy", 
                value: null 
            });
        }
    }); 

    function qutloadSearch() {
        var qutdocno = document.getElementById("qutdocno") ? document.getElementById("qutdocno").value : "";
        var clientnames = document.getElementById("clientname") ? document.getElementById("clientname").value : "";
        var refno = document.getElementById("searchrefno") ? document.getElementById("searchrefno").value : "";
        var qutdate = document.getElementById("mastersearchdate") ? $("#mastersearchdate").jqxDateTimeInput('val') : "";
        var quttype = document.getElementById("quttype") ? document.getElementById("quttype").value : "";
        var assetid = document.getElementById("assetid") ? document.getElementById("assetid").value : "";

        getdata1(qutdocno, clientnames, refno, qutdate, quttype, assetid);
    }

    function getdata1(qutdocno, clientname, refno, qutdate, quttype, assetid) {
        var branchElem = document.getElementById("brchName");
        var branch = branchElem ? branchElem.value : ($('#brchName').length ? $('#brchName').val() : "");

        var url = 'masterSearchGrid.jsp?branch=' + encodeURIComponent(branch) + 
                  '&id=1' +
                  '&qutdocno=' + encodeURIComponent(qutdocno) + 
                  '&clientname=' + encodeURIComponent(clientname) + 
                  '&refno=' + encodeURIComponent(refno) + 
                  '&qutdate=' + encodeURIComponent(qutdate) + 
                  '&quttype=' + encodeURIComponent(quttype) + 
                  '&assetid=' + encodeURIComponent(assetid);

        $("#qutrediv").load(url);
    }
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- Standardized 8-column layout -->
            <colgroup>
                <col width="8%" />  <col width="17%" />
                <col width="8%" />  <col width="17%" />
                <col width="8%" />  <col width="17%" />
                <col width="10%" /> <col width="15%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Docno</td>
                <td>
                    <input type="text" name="qutdocno" id="qutdocno" value='<s:property value="qutdocno"/>' autocomplete="off">
                </td>
                
                <td class="lbl-right">Name</td>
                <!-- Expanded across 3 columns to give Name more space -->
                <td colspan="3">
                    <input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>' autocomplete="off">
                </td>
                
                <td class="lbl-right">Ref No</td>
                <td>
                    <input type="text" name="searchrefno" id="searchrefno" value='<s:property value="searchrefno"/>' autocomplete="off">
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="mastersearchdate"></div>
                </td>
                
                <td class="lbl-right">Type</td>
                <td>
                    <select name="quttype" id="quttype">
                        <option value="">--select--</option>
                        <option value="DIR" <s:if test="%{quttype == 'DIR'}">selected</s:if>>Direct</option>
                        <option value="QOT" <s:if test="%{quttype == 'QOT'}">selected</s:if>>Quote</option>
                    </select>
                </td>
                
                <td class="lbl-right">Asset Id</td>
                <td>
                    <input type="text" name="assetid" id="assetid" autocomplete="off">
                </td>
                
                <!-- Search Button aligned right -->
                <td colspan="2" align="right">
                    <input type="button" name="qutbtnrasearch" id="qutbtnrasearch" class="myButton" value="Search" onclick="qutloadSearch()">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="qutrediv">
            <jsp:include page="masterSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>