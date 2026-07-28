 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		
 	
 		var sclnames=document.getElementById("assetnamess").value;
 		var gp=document.getElementById("assetgroupss").value;
 		
 		var sdocno=document.getElementById("sdocno").value;
 		var assetid=document.getElementById("assetidss").value;

 		

 		var assetgroup = gp.replace(/ /g, "%20");
 		var assetname = sclnames.replace(/ /g, "%20");
 		var chk="yes";
		getdata(assetname,assetid,sdocno,assetgroup,chk);
		
		

	}
	 function getdata(assetname,assetid,sdocno,assetgroup,chk){



		
		 $("#srefreshdiv").load('submasterSearch.jsp?assetname='+assetname+'&assetid='+assetid+'&sdocno='+sdocno+'&assetgroup='+assetgroup+'&chk='+chk);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script> 
<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
body{
    margin:0;
    background:#fff;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
}

.modern-ui{
    font-size:12px;
    color:#333;
    padding:10px;
    width:100%;
    box-sizing:border-box;
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select{
    width:100%;
    height:24px !important;
    border:1px solid #BDBDBD;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    font-size:12px;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    background:#fff;
    color:#333;
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
    font-weight:600;
    color:#222;
    font-size:12px;
    white-space:nowrap;
    padding-right:6px;
}

/* Button */
.modern-ui .myButton{
    height:26px;
    padding:0 20px;
    background:#0056b3;
    color:#fff;
    border:none;
    border-radius:3px;
    cursor:pointer;
    font-size:12px;
    font-weight:600;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    transition:all .2s;
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

            <!-- Adjusted widths because Asset Name is long -->
            <colgroup>
                <col width="10%">
                <col width="18%">

                <col width="10%">
                <col width="22%">

                <col width="12%">
                <col width="28%">
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text"
                           name="sdocno"
                           id="sdocno"
                           value='<s:property value="sdocno"/>'>
                </td>

                <td class="lbl-right">Asset Id</td>
                <td>
                    <input type="text"
                           name="assetidss"
                           id="assetidss"
                           value='<s:property value="assetidss"/>'>
                </td>

                <td class="lbl-right">Asset Name</td>
                <td>
                    <input type="text"
                           name="assetnamess"
                           id="assetnamess"
                           value='<s:property value="assetnamess"/>'>
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">Asset Group</td>

                <td colspan="3">
                    <input type="text"
                           name="assetgroupss"
                           id="assetgroupss"
                           value='<s:property value="assetgroupss"/>'>
                </td>

                <td></td>

                <td align="center">
                    <input type="button"
                           name="mbtnrasearch"
                           id="mbtnrasearch"
                           class="myButton"
                           value="Search"
                           onclick="mainloadSearch();">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="srefreshdiv">

            <jsp:include page="submasterSearch.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>