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
	$(document).ready(function () {
 		document.getElementById("txtatype").value=$('#cmbtype').val();
 		if(($('#cmbtype').val()=='GL') || ($('#cmbtype').val()=='HR')){
 			$('#txtcontactno').attr('readonly', true );
 		}
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		var atype=document.getElementById("txtatype").value;
 		var chk = 1;
 		
		getdata(atype,partyname,accNo,contactNo,chk);
	}
	function getdata(atype,partyname,accNo,contactNo,chk){
		 $("#refreshdiv").load('accountsDetailsGrid.jsp?atype='+atype+'&partyname='+partyname+'&accNo='+accNo+'&contactNo='+contactNo+'&chk='+chk);
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
    border:1px solid #d9d9d9;
    border-radius:4px;
    padding:12px;
    margin-bottom:10px;
    background:#fff;
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

.small-input{
    width:120px;
}

.medium-input{
    width:160px;
}

.large-input{
    width:280px;
}

.grid-container{
    border:1px solid #d9d9d9;
    border-radius:4px;
    overflow:hidden;
    background:#fff;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <table>

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

                <td class="lbl-right">
                    Contact No.
                </td>

                <td>
                    <input type="text"
                           id="txtcontactno"
                           name="txtcontactno"
                           class="search-input medium-input"
                           value='<s:property value="txtcontactno"/>'>

                    <input type="hidden"
                           id="txtatype"
                           name="txtatype"
                           value='<s:property value="txtatype"/>'>
                </td>

                <td>

                    <button type="button"
                            class="myButton"
                            id="btnsearch"
                            onclick="loadSearch();"
                            style="width:100px;height:28px;">
                        Search
                    </button>

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