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
		$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
    	$("#searchGrid").jqxGrid('clear');

	}); 

 	function loadSearch1() {
 		$("#searchGrid").jqxGrid('clear');
 		var date=document.getElementById("searchdate").value;
 		 var fleetno=document.getElementById("Fleet No").value;
 		var Driver=document.getElementById("Driver").value;
 		var msdocno=document.getElementById("msdocno").value;
 		var regno=document.getElementById("reg_nos").value;
 		var id="1";
	getdata1(fleetno,msdocno,Driver,date,regno,id)
 

	}
	function getdata1(fleetno,msdocno,Driver,date,regno,id){
		 $("#refreshdivmas").load('searchGrid.jsp?fleetno='+fleetno+'&msdocno='+msdocno+'&Driver='+Driver+'&date='+date+'&regno='+regno+'&id='+id);
		
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
    width:120px;
}

.medium-input{
    width:170px;
}

.large-input{
    width:260px;
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
                           id="msdocno"
                           name="msdocno"
                           class="search-input small-input"
                           value='<s:property value="msdocno"/>'>
                </td>

                <td class="lbl-right">
                    Fleet No
                </td>

                <td>
                    <input type="text"
                           id="Fleet No"
                           name="Fleet No"
                           class="search-input medium-input"
                           value='<s:property value="Fleet No"/>'>
                </td>

                <td class="lbl-right">
                    Driver
                </td>

                <td>
                    <input type="text"
                           id="Driver"
                           name="Driver"
                           class="search-input medium-input"
                           value='<s:property value="Driver"/>'>
                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Date
                </td>

                <td>
                    <div id="searchdate" name="searchdate"></div>
                </td>

                <td class="lbl-right">
                    Asset Id
                </td>

                <td>
                    <input type="text"
                           id="reg_nos"
                           name="reg_nos"
                           class="search-input medium-input"
                           value='<s:property value="reg_nos"/>'>
                </td>

                <td></td>

                <td align="center">

                    <button
                        type="button"
                        id="enqbtnrasearch"
                        class="myButton"
                        onclick="loadSearch1();"
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

        <div id="refreshdivmas">
            <jsp:include page="searchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>
