<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Client Search</title>
<script>
	$(document).ready(function(e) {
        $('#btnclientsearch').click(function(){
			var clientdocno=$('#searchclientcldocno').val();
			var clientname=$('#searchclientname').val();
			var clientaddress=$('#searchclientaddress').val();
			var clientmobile=$('#searchclientmobile').val();
			var clientmail=$('#searchclientmail').val();
			$('#clientsearchdiv').load('clientSearchGrid.jsp?id=1&clientdocno='+clientdocno+'&clientname='+clientname+'&clientaddress='+clientaddress+'&clientmobile='+clientmobile+'&clientmail='+clientmail);
			
		});
    });
</script>
</head>
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
    width:130px;
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

                <td class="lbl-right">
                    Doc No
                </td>

                <td>
                    <input type="text"
                           id="searchclientcldocno"
                           name="searchclientcldocno"
                           class="search-input small-input">
                </td>

                <td class="lbl-right">
                    Name
                </td>

                <td colspan="5">
                    <input type="text"
                           id="searchclientname"
                           name="searchclientname"
                           class="search-input large-input">
                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Address
                </td>

                <td colspan="2">
                    <input type="text"
                           id="searchclientaddress"
                           name="searchclientaddress"
                           class="search-input large-input">
                </td>

                <td class="lbl-right">
                    Mobile
                </td>

                <td>
                    <input type="text"
                           id="searchclientmobile"
                           name="searchclientmobile"
                           class="search-input medium-input">
                </td>

                <td class="lbl-right">
                    Mail
                </td>

                <td>
                    <input type="text"
                           id="searchclientmail"
                           name="searchclientmail"
                           class="search-input medium-input">
                </td>

                <td align="center">

                    <button
                        type="button"
                        id="btnclientsearch"
                        onclick="loadSearch();"
                        style="
                            width:100px;
                            height:28px;
                            background:#205fd3;
                            color:#ffffff;
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

        <div id="clientsearchdiv">
            <jsp:include page="clientSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>