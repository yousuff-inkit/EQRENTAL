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

	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno2").value;
			var accountsname=document.getElementById("txtaccountsname2").value;
			var currs=document.getElementById("txtaccountcurrency2").value;
		
		
			var check ="bankaac";
	
			getAccountDetails(accountsno,accountsname,currs,check);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,check){
		 $("#bankdiv").load("bankaccSubgrid.jsp?accountno="+accountsno+'&accountname='+accountsname+'&currency='+currs+'&check='+check);
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
    width:300px;
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
                           id="txtaccountsno2"
                           name="txtaccountsno2"
                           class="search-input small-input"
                           value='<s:property value="txtaccountsno2"/>'>
                </td>

                <td class="lbl-right">
                    Currency
                </td>

                <td>
                    <input type="text"
                           id="txtaccountcurrency2"
                           name="txtaccountcurrency2"
                           class="search-input small-input"
                           value='<s:property value="txtaccountcurrency2"/>'>

                    <%--
                    <input type="hidden" name="txtdoctypes" id="txtdoctypes"
                           value='<s:property value="txtdoctypes"/>'>

                    <input type="hidden" name="txtsearchtype" id="txtsearchtype"
                           value='<s:property value="txtsearchtype"/>'>
                    --%>
                </td>

                <td rowspan="2" align="center">

                    <button
                        type="button"
                        id="btnAccountSearch"
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

            <tr>

                <td class="lbl-right">
                    Account Name
                </td>

                <td colspan="3">
                    <input type="text"
                           id="txtaccountsname2"
                           name="txtaccountsname2"
                           class="search-input large-input"
                           value='<s:property value="txtaccountsname2"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="bankdiv">
            <jsp:include page="bankaccSubgrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>