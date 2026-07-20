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

	<script type="text/javascript">

	$(document).ready(function () { 
	    
		 
		   
	});   
		   
  	function loadSearchss() { // docnoss prdid prdname
 		
 		var docnoss=document.getElementById("docnoss").value;
 		 
 		var prdid=document.getElementById("prdid").value;
 		var prdname=document.getElementById("prdname").value;
 		
 		 

		
	var aa="yes";
		getdatas(docnoss,prdid,prdname,aa);
 

	}
	function getdatas(docnoss,prdid,prdname,aa){
		
		 
			 $("#refsearch").load('productssubsearch.jsp?docnoss='+docnoss.replace(/ /g, "%20")+'&prdid='+prdid.replace(/ /g, "%20")+'&prdname='+prdname.replace(/ /g, "%20")+'&aa='+aa);
		

		}  
	
	
 
	

	</script>
<style type="text/css">
/* =========================================================
   SCOPED UI: Master Search UI
========================================================= */

body{
    margin:0;
    background:#f5f7fa;
}

/* Main Wrapper */
#search.modern-ui{
    font-family:'Segoe UI','Roboto','Arial',sans-serif !important;
    font-size:12px !important;
    color:#333;
    padding:10px;
    background:#f5f7fa;
}

/* Search Panel */
#search.modern-ui .search-panel{
    background:#fff;
    border:1px solid #c5d3e0;
    border-radius:8px;
    padding:15px 10px;
    margin-bottom:12px;
    box-shadow:0 2px 8px rgba(0,0,0,.04);
}

/* Grid Panel */
#search.modern-ui .grid-container{
    background:#fff;
    border:1px solid #c5d3e0;
    border-radius:8px;
    padding:5px;
    min-height:50px;
    box-shadow:0 2px 8px rgba(0,0,0,.04);
}

/* Table */
#search.modern-ui table{
    width:100%;
    border-collapse:separate;
    border-spacing:4px 10px;
}

#search.modern-ui td{
    font-family:'Segoe UI','Roboto','Arial',sans-serif !important;
    font-size:12px !important;
    vertical-align:middle;
}

/* Labels */
#search.modern-ui td[align="right"]{
    color:#000 !important;
    font-weight:normal !important;
    background:none !important;
    white-space:nowrap;
    padding-right:5px;
}

/* Textboxes */
#search.modern-ui input[type="text"]{
    width:100%;
    height:24px !important;
    border:1px solid #b8c6d8;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    font-size:12px !important;
    font-family:'Segoe UI','Roboto','Arial',sans-serif !important;
    background:#fff !important;
}

#search.modern-ui input[type="text"]:focus{
    border-color:#007bff;
    outline:none;
    box-shadow:0 0 0 2px rgba(0,123,255,.10);
}

/* Button */
#search.modern-ui .myButton{
    width:80px !important;
    height:24px !important;
    line-height:22px !important;
    padding:0 15px !important;
    font-size:11px !important;
    font-family:'Segoe UI','Roboto','Arial',sans-serif !important;
    font-weight:700 !important;
    color:#fff !important;
    background:linear-gradient(135deg,#0b45a2 0%,#2563eb 100%) !important;
    border:1px solid #083a8a !important;
    border-radius:3px;
    cursor:pointer;
    text-transform:uppercase;
    box-shadow:0 1px 2px rgba(59,130,246,.3);
}

#search.modern-ui .myButton:hover{
    background:linear-gradient(135deg,#083a8a 0%,#1d4ed8 100%) !important;
    transform:translateY(-1px);
}

#refreshdiv,
#refsearch{
    margin-top:5px;
}
</style>

</head>

<body bgcolor="#f5f7fa">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table>

            <tr>

                <td align="right" width="8%">Product</td>

                <td width="25%">
                    <input type="text"
                           name="prdid"
                           id="prdid"
                           value='<s:property value="prdid"/>'>
                </td>

                <td align="right" width="10%">Product Name</td>

                <td width="37%">
                    <input type="text"
                           name="prdname"
                           id="prdname"
                           value='<s:property value="prdname"/>'>
                </td>

                <td width="20%" align="left" style="padding-left:8px;">
                    <input type="button"
                           name="searchs"
                           id="searchs"
                           class="myButton"
                           value="Search"
                           onclick="loadSearchss();">
                </td>

            </tr>

        </table>

        <input type="hidden"
               name="docnoss"
               id="docnoss"
               value='<s:property value="docnoss"/>'>

    </div>

    <div class="grid-container">

        <div id="refsearch">
            <jsp:include page="productssubsearch.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>