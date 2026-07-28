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
	    
		   /* Date */ 	
	    $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var accountss=document.getElementById("accountss").value;
 		var accnamesss=document.getElementById("accnamess").value;
 		var datess=document.getElementById("datess").value;
 		var reftypess=document.getElementById("reftypess").value;
 		/* var brchName=document.getElementById("brchName").value;
 */ 		
 		var accnamess = accnamesss.replace(' ', '%20');

		
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,reftypess,aa);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,reftypess,aa){
		
	
		
		 $("#refreshdivs").load('submasterSearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&reftypess='+reftypess+'&aa='+aa);

		}

	</script>
<<style>
html,body{
    margin:0;
    padding:0;
    background:#fff;
    font-family:Segoe UI,Tahoma,sans-serif;
}

#search{
    padding:10px;
    background:#fff;
}

.search-panel{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    padding:12px;
    margin-bottom:10px;
}

.search-panel table{
    width:100%;
    border-collapse:collapse;
}

.search-panel td{
    padding:6px;
    vertical-align:middle;
    white-space:nowrap;
}

.lbl-right{
    text-align:right;
    font-size:12px;
    font-weight:500;
    color:#333;
}

.search-input{
    height:26px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    font-size:12px;
}

.small-input{
    width:120px;
}

.medium-input{
    width:170px;
}

.large-input{
    width:280px;
}

.grid-container{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    overflow:hidden;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <table>

            <tr>

                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text"
                           id="docnoss"
                           name="docnoss"
                           class="search-input small-input"
                           value='<s:property value="docnoss"/>'>
                </td>

                <td class="lbl-right">Account</td>
                <td>
                    <input type="text"
                           id="accountss"
                           name="accountss"
                           class="search-input medium-input"
                           value='<s:property value="accountss"/>'>
                </td>

                <td class="lbl-right">Account Name</td>
                <td>
                    <input type="text"
                           id="accnamess"
                           name="accnamess"
                           class="search-input large-input"
                           value='<s:property value="accnamess"/>'>
                </td>

            </tr>

            <tr>

                <td class="lbl-right">Date</td>
                <td>
                    <div id="datess"
                         name="datess"
                         value='<s:property value="datess"/>'></div>
                </td>

                <td class="lbl-right">Type</td>
                <td>
                    <select id="reftypess"
                            name="reftypess"
                            class="search-input medium-input">
                        <option value="">--Select--</option>
                        <option value="DIR">DIR</option>
                        <option value="VPR">VPR</option>
                    </select>
                </td>

                <td></td>

                <td align="center">

                    <button
                        type="button"
                        id="searchs"
                        class="myButton"
                        onclick="loadSearchs();"
                        style="
                            width:100px;
                            height:28px;
                            background:#205fd3;
                            color:#fff;
                            border:1px solid #205fd3;
                            border-radius:4px;
                            font-size:12px;
                            font-weight:600;
                            cursor:pointer;">
                        Search
                    </button>

                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdivs">
            <jsp:include page="submasterSearch.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>