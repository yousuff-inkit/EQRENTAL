
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%
String agmtexist=request.getParameter("agmtexist")==null?"0":request.getParameter("agmtexist");
String agmtno=request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
%>
<script type="text/javascript">
$(document).ready(function() {
$("#searchdrvlicensedate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null});
$('#btnsearchdriver').click(function(){

	var driverdocno=$('#searchdrvdocno').val();
	var driverlicense=$('#searchdrvlicense').val();
	var driverlicensedate=$('#searchdrvlicensedate').jqxDateTimeInput('val');
	var drivername=$('#searchdrvname').val();
	var drivermobile=$('#searchdrvmobile').val();
	var agmtexist='<%=agmtexist%>';
	var agmtno='<%=agmtno%>';
	var cldocno='<%=cldocno%>';
	$('#searchdriverdiv').load('driverSearchGrid.jsp?driverdocno='+driverdocno+'&driverlicense='+driverlicense+'&driverlicensedate='+driverlicensedate+'&drivername='+drivername+'&drivermobile='+drivermobile+'&id=1&agmtexist='+agmtexist+'&cldocno='+cldocno+'&agmtno='+agmtno);
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
                           id="searchdrvdocno"
                           name="searchdrvdocno"
                           class="search-input small-input">
                </td>

                <td class="lbl-right">
                    Driver Name
                </td>

                <td colspan="4">
                    <input type="text"
                           id="searchdrvname"
                           name="searchdrvname"
                           class="search-input large-input">
                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    License No
                </td>

                <td>
                    <input type="text"
                           id="searchdrvlicense"
                           name="searchdrvlicense"
                           class="search-input medium-input">
                </td>

                <td class="lbl-right">
                    License Expiry
                </td>

                <td>
                    <div id="searchdrvlicensedate"
                         name="searchdrvlicensedate"></div>
                </td>

                <td class="lbl-right">
                    Mobile
                </td>

                <td>
                    <input type="text"
                           id="searchdrvmobile"
                           name="searchdrvmobile"
                           class="search-input medium-input">
                </td>

                <td align="center">

                    <button
                        type="button"
                        id="btnsearchdriver"
                        class="myButton"
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

        <div id="searchdriverdiv">
            <jsp:include page="driverSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>