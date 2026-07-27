 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var chk = 1;
 		
		getdata(partyname,accNo,chk);
	}
	function getdata(partyname,accNo,chk){
		 $("#refreshdiv").load('accountsDetailsGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accNo+'&chk='+chk);
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
    white-space:nowrap;
    vertical-align:middle;
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

.medium-input{
    width:170px;
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
                    Account
                </td>

                <td>
                    <input type="text"
                           id="txtaccountno"
                           name="txtaccountno"
                           class="search-input medium-input"
                           value='<s:property value="txtaccountno"/>'>
                </td>

                <td rowspan="2" align="center">

                    <button type="button"
                            id="btnsearch"
                            class="myButton"
                            onclick="loadSearch();"
                            style="width:100px;height:28px;">
                        Search
                    </button>

                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Name
                </td>

                <td>
                    <input type="text"
                           id="txtpartyname"
                           name="txtpartyname"
                           class="search-input large-input"
                           value='<s:property value="txtpartyname"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>