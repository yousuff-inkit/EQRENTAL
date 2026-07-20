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

<script type="text/javascript">

$(document).ready(function () {
    document.getElementById("txtatype").value = $('#cmbtype').val();
});

function loadSearch() {

    var partyname = document.getElementById("txtpartyname").value;
    var accNo = document.getElementById("txtaccountno").value;
    var contactNo = document.getElementById("txtcontactno").value;
    var atype = document.getElementById("txtatype").value;

    getdata(atype, partyname, accNo, contactNo);

}

function getdata(atype,partyname,accNo,contactNo){

    $("#refreshdiv").load(
        'accountsDetailsGrid.jsp?atype=' + atype +
        '&partyname=' + partyname.replace(/ /g,"%20") +
        '&accNo=' + accNo +
        '&contactNo=' + contactNo +
        '&check=1'
    );

}

</script>

<style type="text/css">

body{
    margin:0;
    background:#f5f7fa;
}

#search.modern-ui{
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    font-size:12px;
    color:#333;
    background:#f5f7fa;
    padding:10px;
}

#search.modern-ui .search-panel{

    background:#ffffff;
    border:1px solid #c5d3e0;
    border-radius:8px;
    padding:15px 10px;
    margin-bottom:12px;
    box-shadow:0 2px 8px rgba(0,0,0,.04);

}

#search.modern-ui .grid-container{

    background:#ffffff;
    border:1px solid #c5d3e0;
    border-radius:8px;
    padding:5px;
    box-shadow:0 2px 8px rgba(0,0,0,.04);

}

#search.modern-ui table{

    width:100%;
    border-collapse:separate;
    border-spacing:4px 10px;

}

#search.modern-ui td{

    font-size:12px;
    vertical-align:middle;

}

#search.modern-ui td.label{

    width:8%;
    text-align:right;
    padding-right:5px;
    white-space:nowrap;

}

#search.modern-ui input[type=text]{

    height:24px;
    font-size:12px;
    border:1px solid #b8c6d8;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    background:#ffffff;

}

#search.modern-ui input[type=text]:focus{

    outline:none;
    border-color:#007bff;
    box-shadow:0 0 0 2px rgba(0,123,255,.10);

}

#search.modern-ui .myButton{

    width:80px;
    height:24px;
    line-height:22px;
    font-size:11px;
    font-weight:bold;
    text-transform:uppercase;
    color:#fff;
    border:1px solid #083a8a;
    border-radius:3px;
    cursor:pointer;
    background:linear-gradient(135deg,#0b45a2,#2563eb);

}

#search.modern-ui .myButton:hover{

    background:linear-gradient(135deg,#083a8a,#1d4ed8);

}

#refreshdiv{

    margin-top:5px;

}

</style>

</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table>

            <tr>

                <td class="label">Name</td>

                <td width="38%">
                    <input
                        type="text"
                        name="txtpartyname"
                        id="txtpartyname"
                        style="width:100%;"
                        value='<s:property value="txtpartyname"/>'
                    >
                </td>

                <td width="10%" align="center">
                    <input
                        type="button"
                        name="btnsearch"
                        id="btnsearch"
                        class="myButton"
                        value="Search"
                        onclick="loadSearch();"
                    >
                </td>

                <td width="44%"></td>

            </tr>

            <tr>

                <td class="label">Account</td>

                <td>
                    <input
                        type="text"
                        name="txtaccountno"
                        id="txtaccountno"
                        style="width:70%;"
                        value='<s:property value="txtaccountno"/>'
                    >
                </td>

                <td class="label">Contact No.</td>

                <td>

                    <input
                        type="text"
                        name="txtcontactno"
                        id="txtcontactno"
                        style="width:50%;"
                        value='<s:property value="txtcontactno"/>'
                    >

                    <input
                        type="hidden"
                        name="txtatype"
                        id="txtatype"
                        value='<s:property value="txtatype"/>'
                    >

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