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

/* Standardized Input & Select Styles */
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
        /* Standardized JQX setup */
        $("#sdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null}); 
        
        /* Force internal alignment AFTER render to match modern-ui standard */
        setTimeout(function () {
            $("#sdate").css({"margin-top": "0px", "border-color": "#BDBDBD", "border-radius": "3px", "background-color": "#ffffff"});
            $("#sdate").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box", "background-color": "#ffffff"
            });
            $("#sdate").find(".jqx-action-button").css({"top": "0px", "height": "24px", "background-color": "#ffffff"});
        }, 100);
    }); 

    function qotloadSearch1() {
        var msdocno = document.getElementById("msdocno").value || "";
        var tobranch = document.getElementById("tobranch").value || "";
        var tolocation = document.getElementById("tolocation").value || "";
        var reftype = document.getElementById("reftype").value || "";
        var sdate = $('#sdate').jqxDateTimeInput('val') || ""; // Grab JQX value safely

        getdata1(tobranch, msdocno, tolocation, sdate, reftype);
    }

    function getdata1(tobranch, msdocno, tolocation, sdate, reftype){
        /* Safely encoding URI components */
        $("#refreshdivmas").load('subMastersearch.jsp?tobranch=' + encodeURIComponent(tobranch) + 
                                 '&msdocno=' + encodeURIComponent(msdocno) + 
                                 '&tolocation=' + encodeURIComponent(tolocation) + 
                                 '&sdate=' + sdate + 
                                 '&reftype=' + encodeURIComponent(reftype));
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
                <td class="lbl-right">Docno</td>
                <td>
                    <input type="text" name="msdocno" id="msdocno" autocomplete="off" value='<s:property value="msdocno"/>'>
                </td>
                
                <td class="lbl-right">To Branch</td>
                <td>
                    <input type="text" name="tobranch" id="tobranch" autocomplete="off" value='<s:property value="tobranch"/>'>
                </td>
                
                <td class="lbl-right">To Location</td>
                <td>
                    <input type="text" name="tolocation" id="tolocation" autocomplete="off" value='<s:property value="tolocation"/>'>
                </td>
                
                <!-- Fill the remaining columns to keep alignment solid -->
                <td colspan="2"></td>
            </tr>
            
            <tr>
                <td class="lbl-right">Type</td>
                <td>
                    <select id="reftype" name="reftype">
                        <option value="">----select------</option>
                        <option value="IBT" <s:if test="reftype == 'IBT'">selected</s:if>>Branch Transfer (IBT)</option>
                        <option value="ILT" <s:if test="reftype == 'ILT'">selected</s:if>>Location Transfer (ILT)</option>
                    </select>
                </td>
                
                <td class="lbl-right">Date</td>
                <td>
                    <div id="sdate" name="sdate" value='<s:property value="sdate"/>'></div>
                </td>
                
                <!-- Search button aligned on the far right -->
                <td colspan="4" align="right">
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