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
		$("#msearchdate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy",value:null
		});
	}); 

 	function mainSearch() {
 		
 		var docno=document.getElementById("msearchdocno").value;
 		var date=$('#msearchdate').jqxDateTimeInput('val');
 		var client=document.getElementById("msearchclient").value;
 		var type=document.getElementById("msearchcmbtype").value;
 		var acno=document.getElementById("msearchacno").value;
 		var mobile=document.getElementById("msearchmobile").value;
		var branch=document.getElementById("brchName").value;
 		
 		getmaindata(docno,date,client,type,acno,mobile,branch);
 

	}
	 function getmaindata(docno,date,client,type,acno,mobile,branch){
		
		
		 $("#srefreshdiv").load('disposalSearch.jsp?docno='+docno+'&date='+date+'&client='+client+'&type='+type+'&acno='+acno+'&mobile='+mobile+'&branch='+branch+'&id=1');
		 

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
    width:130px;
}

.medium-input{
    width:170px;
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
                           id="msearchdocno"
                           name="msearchdocno"
                           class="search-input small-input">
                </td>

                <td class="lbl-right">Date</td>
                <td>
                    <div id="msearchdate"></div>
                </td>

                <td class="lbl-right">Type</td>
                <td>
                    <select id="msearchcmbtype"
                            name="msearchcmbtype"
                            class="search-input medium-input">
                        <option value="">--Select--</option>
                        <option value="S">Sale</option>
                        <option value="L">Total Loss</option>
                    </select>
                </td>

                <td rowspan="2" align="center">

                    <button
                        type="button"
                        id="searchbtn"
                        class="myButton"
                        onclick="mainSearch();"
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

                <td class="lbl-right">Client</td>
                <td>
                    <input type="text"
                           id="msearchclient"
                           name="msearchclient"
                           class="search-input medium-input">
                </td>

                <td class="lbl-right">A/c No</td>
                <td>
                    <input type="text"
                           id="msearchacno"
                           name="msearchacno"
                           class="search-input medium-input">
                </td>

                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text"
                           id="msearchmobile"
                           name="msearchmobile"
                           class="search-input medium-input">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="srefreshdiv">
            <jsp:include page="disposalSearch.jsp"></jsp:include>
        </div>

    </div>

</div>


</body>
</html>