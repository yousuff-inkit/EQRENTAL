
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript">
$(document).ready(function() {
$("#searchfleetdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null});
$('#btnsearchfleet').click(function(){

	var fleetno=$('#searchfleetno').val();
	var regno=$('#searchfleetregno').val();
	var date=$('#searchfleetdate').jqxDateTimeInput('val');
	var fleetname=$('#searchfleetname').val();
	$('#searchfleetdiv').load('fleetSearchGrid.jsp?fleetno='+fleetno+'&regno='+regno+'&date='+date+'&fleetname='+fleetname+'&id=1');
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
                    Fleet No
                </td>

                <td>
                    <input type="text"
                           id="searchfleetno"
                           name="searchfleetno"
                           class="search-input medium-input">
                </td>

                <td class="lbl-right">
                    Asset Id
                </td>

                <td>
                    <input type="text"
                           id="searchfleetregno"
                           name="searchfleetregno"
                           class="search-input medium-input">
                </td>

                <td class="lbl-right">
                    Date
                </td>

                <td>
                    <div id="searchfleetdate"
                         name="searchfleetdate"></div>
                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Fleet Name
                </td>

                <td colspan="4">
                    <input type="text"
                           id="searchfleetname"
                           name="searchfleetname"
                           class="search-input large-input">
                </td>

                <td align="center">

                    <button
                        type="button"
                        id="btnsearchfleet"
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

        <div id="searchfleetdiv">
            <jsp:include page="fleetSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>