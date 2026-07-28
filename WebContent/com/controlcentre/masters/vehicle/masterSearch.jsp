 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<style>
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
 --%>
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#searchdate").jqxDateTimeInput({ width: '100%', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function mainloadSearch() {
 		
 		var fleetno=document.getElementById("searchfleet").value;
 		var docno=document.getElementById("searchdocno").value;
 		var regno=document.getElementById("searchregno").value;
 		var fleetname=document.getElementById("searchfleetname").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		var engine=document.getElementById("searchengine").value;
		var chassis=document.getElementById("searchchassis").value;
		getdata(fleetno,docno,regno,fleetname,searchdate,engine,chassis);
 
 

	}
	 function getdata(fleetno,docno,regno,fleetname,searchdate,engine,chassis){
		
		 $("#srefreshdiv").load('subMainSearch.jsp?fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&fleetname='+fleetname+'&searchdate='+searchdate+'&id=1&engine='+engine+'&chassis='+chassis);
		 

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

/* Inputs */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    box-sizing: border-box;
    background: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus{
    border-color:#007bff;
    outline:none;
}

/* Search Panel */
.modern-ui .search-panel{
    background:#fff;
    border:1px solid #BDBDBD;
    border-radius:4px;
    padding:12px 10px;
    margin-bottom:10px;
    width:100%;
    box-sizing:border-box;
}

/* Table */
.modern-ui table{
    width:100%;
    border-collapse:separate;
    border-spacing:8px 10px;
    table-layout:fixed;
}

.modern-ui td{
    vertical-align:middle;
}

.modern-ui .lbl-right{
    text-align:right;
    font-size:12px;
    font-weight:600;
    color:#222;
    white-space:nowrap;
    padding-right:6px;
}

/* Button */
.modern-ui .myButton{
    height:26px;
    padding:0 22px;
    background:#0056b3;
    color:#fff;
    border:none;
    border-radius:3px;
    cursor:pointer;
    font-size:12px;
    font-weight:bold;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
}

.modern-ui .myButton:hover{
    background:#004494;
}

/* Grid */
.modern-ui .grid-container{
    border:1px solid #BDBDBD;
    background:#fff;
    overflow:hidden;
    width:100%;
}
</style>

<body style="background:#fff;margin:0;">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table border="0" cellspacing="0" cellpadding="0">

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

                <td class="lbl-right">Fleet No</td>
                <td>
                    <input type="text"
                           name="searchfleet"
                           id="searchfleet"
                           value='<s:property value="searchfleet"/>'>
                </td>

                <td class="lbl-right">Fleet Name</td>
                <td>
                    <input type="text"
                           name="searchfleetname"
                           id="searchfleetname"
                           value='<s:property value="searchfleetname"/>'>
                </td>

                <td class="lbl-right">Engine No</td>
                <td>
                    <input type="text"
                           name="searchengine"
                           id="searchengine"
                           value='<s:property value="searchengine"/>'>
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">Chassis No</td>
                <td>
                    <input type="text"
                           name="searchchassis"
                           id="searchchassis"
                           value='<s:property value="searchchassis"/>'>
                </td>

                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text"
                           name="searchdocno"
                           id="searchdocno"
                           value='<s:property value="searchdocno"/>'>
                </td>

                <td class="lbl-right">Date</td>
                <td>
                    <div id="searchdate" name="searchdate"></div>
                </td>

            </tr>

            <!-- Row 3 -->
            <tr>

                <td class="lbl-right">Reg No</td>
                <td>
                    <input type="text"
                           name="searchregno"
                           id="searchregno">
                </td>

                <td></td>
                <td></td>
                <td></td>

                <td align="center">
                    <input type="button"
                           name="btninvsearch"
                           id="btninvsearch"
                           class="myButton"
                           value="Search"
                           onclick="mainloadSearch();">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="srefreshdiv">

            <jsp:include page="subMainSearch.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>