<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
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
        /* $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); */
    }); 

    function loadSearch() {
        var clnames = document.getElementById("Cl_name") ? document.getElementById("Cl_name").value : "";
        var mob = document.getElementById("Cl_mob") ? document.getElementById("Cl_mob").value : "";
        
        var clname = encodeURIComponent(clnames); 
        getdata(clname, mob);
    }

    function getdata(clname, mob){
        var branchElem = document.getElementById("brchName");
        var branch = branchElem ? branchElem.value : ($('#brchName').length ? $('#brchName').val() : "");
        
        $("#cldiv").load('clientSearchGrid.jsp?clname=' + clname + '&mob=' + encodeURIComponent(mob) + '&branch=' + encodeURIComponent(branch) + '&id=1');
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
                <td class="lbl-right">Name</td>
                <!-- Spanned across 3 columns to give Name more space just like the reference -->
                <td colspan="3">
                    <input type="text" name="Cl_name" id="Cl_name" value='<s:property value="Cl_name"/>' autocomplete="off">
                </td>
                
                <td class="lbl-right">MOB</td>
                <td>
                    <input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>' autocomplete="off">
                </td>
                
                <!-- Search Button aligned right -->
                <td colspan="2" align="right">
                    <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearch()">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="cldiv">
            <jsp:include page="clientSearchGrid.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>