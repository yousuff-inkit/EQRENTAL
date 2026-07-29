<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
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
        if ($("#msearchdate").length) {
            $("#msearchdate").jqxDateTimeInput({ 
                width: '100%', 
                height: '24px', 
                formatString: "dd.MM.yyyy", 
                value: null 
            });
        }
        getStatus();
    }); 

    function masterloadSearch() {
        var reftype = document.getElementById("cmbsearchrtype") ? document.getElementById("cmbsearchrtype").value : "";
        var searchdate = document.getElementById("msearchdate") ? $('#msearchdate').jqxDateTimeInput('val') : "";
        var fleetno = document.getElementById("msearchfleetno") ? document.getElementById("msearchfleetno").value : "";
        var docno = document.getElementById("msearchdocno") ? document.getElementById("msearchdocno").value : "";
        var regno = document.getElementById("msearchregno") ? document.getElementById("msearchregno").value : "";
        var status = document.getElementById("cmbsearchstatus") ? document.getElementById("cmbsearchstatus").value : "";
    
        // Removed the duplicate 'reftype' parameter from your original function call
        getdata(reftype, searchdate, fleetno, docno, regno, status);
    }
    
    function getStatus() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('***');
                var statusItems = items[0].split(",");
                var statusIdItems = items[1].split(",");
                var optionsstatus = '<option value="">--Select--</option>';
                for (var i = 0; i < statusItems.length; i++) {
                    optionsstatus += '<option value="' + statusIdItems[i] + '">' + statusItems[i] + '</option>';
                }
                $("select#cmbsearchrtype").html(optionsstatus);
            }
        };
        x.open("GET", "getStatus.jsp", true);
        x.send();
    }
    
    function getdata(reftype, searchdate, fleetno, docno, regno, status) {
        var url = 'subMainSearch.jsp?reftype=' + encodeURIComponent(reftype) + 
                  '&msearchdate=' + encodeURIComponent(searchdate) + 
                  '&mfleetno=' + encodeURIComponent(fleetno) + 
                  '&mdocno=' + encodeURIComponent(docno) + 
                  '&mregno=' + encodeURIComponent(regno) + 
                  '&status=' + encodeURIComponent(status);
                  
        $("#mainrefreshdiv").load(url);
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
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="msearchdocno" id="msearchdocno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Ref Type</td>
                <td>
                    <select name="cmbsearchrtype" id="cmbsearchrtype">
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td class="lbl-right">Status</td>
                <td>
                    <select name="cmbsearchstatus" id="cmbsearchstatus">
                        <option value="">--Select--</option>
                        <option value="1">IN</option>
                        <option value="0">OUT</option>
                    </select>
                </td>
                
                <td colspan="2"></td> <!-- Filler -->
            </tr>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="msearchdate" name="msearchdate"></div>
                </td>
                
                <td class="lbl-right">Fleet No</td>
                <td>
                    <input type="text" name="msearchfleetno" id="msearchfleetno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Asset Id</td>
                <td>
                    <!-- ID kept as msearchregno as per your original mapping -->
                    <input type="text" name="msearchregno" id="msearchregno" autocomplete="off">
                </td>
                
                <!-- Search Button aligned right -->
                <td colspan="2" align="right">
                    <input type="button" name="btnmainSearchExt" id="btnmainSearchExt" class="myButton" value="Search" onclick="masterloadSearch()">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="mainrefreshdiv">
            <jsp:include page="subMainSearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>