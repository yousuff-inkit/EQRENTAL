<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<!-- Fixed link tag location (moved out of the style block) -->
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

/* Standardized Input Styles */
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
        /* Standardized JQX setup for standard component width */
        $("#qotdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null}); 
        
        /* Force internal alignment AFTER render to match modern-ui standard */
        setTimeout(function () {
            $("#qotdate").css({"margin-top": "0px", "border-color": "#BDBDBD", "border-radius": "3px", "background-color": "#ffffff"});
            $("#qotdate").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box", "background-color": "#ffffff"
            });
            $("#qotdate").find(".jqx-action-button").css({"top": "0px", "height": "24px", "background-color": "#ffffff"});
        }, 100);
    }); 

    function qotloadSearch1() {
        var msdocno = document.getElementById("msdocno").value || "";
        var desc = document.getElementById("desc").value || "";
        
        // Grab JQX value safely using the API rather than pure JS .value
        var qotdate = $('#qotdate').jqxDateTimeInput('val') || ""; 
        
        getdata1(desc, msdocno, qotdate);
    }

    function getdata1(desc, msdocno, qotdate) {
        /* Safely encoding URI components to prevent string breakage */
        $("#refreshdivmas").load('subMastersearch.jsp?descs=' + encodeURIComponent(desc) + 
                                 '&msdocno=' + encodeURIComponent(msdocno) + 
                                 '&qotdate=' + encodeURIComponent(qotdate));
    }
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- 8-column layout for perfect field alignment matching the master template -->
            <colgroup>
                <col width="8%" />  <col width="17%" />
                <col width="8%" />  <col width="17%" />
                <col width="8%" />  <col width="17%" />
                <col width="10%" /> <col width="15%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="msdocno" id="msdocno" autocomplete="off" value='<s:property value="msdocno"/>'>
                </td>
                
                <td class="lbl-right">Description</td>
                <!-- Spanning 5 columns so the description field is nice and wide like the original code -->
                <td colspan="5">
                    <input type="text" name="desc" id="desc" autocomplete="off" value='<s:property value="desc"/>'>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="qotdate" name="qotdate" value='<s:property value="qotdate"/>'></div>
                </td>
                
                <!-- Search button aligned on the far right -->
                <td colspan="6" align="right">
                    <input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search" onclick="qotloadSearch1(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="refreshdivmas">
            <jsp:include page="subMastersearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>