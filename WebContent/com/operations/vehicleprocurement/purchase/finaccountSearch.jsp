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

<script type="text/javascript">
	$(document).ready(function () {
		 //document.getElementById("txtdoctypes").value=document.getElementById("formdetailcode").value;
		// document.getElementById("txtsearchtype").value=document.getElementById("txtforsearch").value;
	}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno1").value;
			var accountsname=document.getElementById("txtaccountsname1").value;
			//var currs=document.getElementById("txtaccountcurrency1").value;
		//	var formcode=document.getElementById("txtdoctypes").value;
		//	var searchtype=document.getElementById("txtsearchtype").value;
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,check);
	}
		
	function getAccountDetails(accountsno,accountsname,check){
		 $("#findiv").load("finaccsubsearch.jsp?accountno="+accountsno+'&accountname='+accountsname+'&check='+check);
	}

</script>
<style>
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
    width:140px;
}

.large-input{
    width:320px;
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

                <td class="lbl-right">
                    Account No
                </td>

                <td>
                    <input type="text"
                           id="txtaccountsno1"
                           name="txtaccountsno1"
                           class="search-input small-input"
                           value='<s:property value="txtaccountsno1"/>'>
                </td>

                <td class="lbl-right">
                    Account Name
                </td>

                <td>
                    <input type="text"
                           id="txtaccountsname1"
                           name="txtaccountsname1"
                           class="search-input large-input"
                           value='<s:property value="txtaccountsname1"/>'>
                </td>

                <td align="center">

                    <button
                        type="button"
                        id="btnAccountSearch1"
                        class="myButton"
                        onclick="loadAccountSearch();"
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

        <div id="findiv">
            <jsp:include page="finaccsubsearch.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>