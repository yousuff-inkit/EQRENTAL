 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
  <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		
	
	}); 


 	function mainloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 	//	var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		var docno=document.getElementById("searchdocno").value;
 		var name=document.getElementById("searchname").value;
 		var acno=document.getElementById("searchacno").value;
 		var mobile=document.getElementById("searchmobile").value;
 		//var status=document.getElementById("cmbsearchstatus").value;
		
		getdata(searchdate,docno,name,acno,mobile);
 

	}

	 function getdata(searchdate,docno,name,acno,mobile){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('clientSearch.jsp?searchdate='+searchdate+'&docno='+docno+'&name='+name+'&acno='+acno+'&mobile='+mobile+'&id=1');
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
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
    width: 100%;
    box-sizing: border-box;
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
    color: #222;
    font-size: 12px;
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap;
    padding-right: 6px;
}

/* Search Button */
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
    transition: all .2s;
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

            <!-- Master Layout : 3 Label-Field Pairs -->
            <colgroup>
                <col width="10%" />
                <col width="23%" />

                <col width="10%" />
                <col width="23%" />

                <col width="10%" />
                <col width="24%" />
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text"
                           name="searchdocno"
                           id="searchdocno">
                </td>

                <td class="lbl-right">Date</td>
                <td>
                    <div id="searchdate" name="searchdate"></div>
                </td>

                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text"
                           name="searchmobile"
                           id="searchmobile">
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">Name</td>
                <td colspan="3">
                    <input type="text"
                           name="searchname"
                           id="searchname">
                </td>

                <td class="lbl-right">A/c No</td>
                <td>
                    <input type="text"
                           name="searchacno"
                           id="searchacno">
                </td>

            </tr>

            <!-- Row 3 -->
            <tr>

                <td></td>
                <td></td>

                <td></td>
                <td></td>

                <td></td>

                <td align="center">
                    <input type="button"
                           name="btnSearchExt"
                           id="btnSearchExt"
                           class="myButton"
                           value="Search"
                           onclick="mainloadSearch();">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="srefreshdiv">

            <jsp:include page="clientSearch.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>