 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
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
	 	$("#fadpdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("fadpdate").value;
 		var amount=document.getElementById("txtamount").value;
 		var branch=document.getElementById("brchName").value;
	
		getdata(partyname,docNo,date,amount,branch);
	}
	function getdata(partyname,docNo,date,amount,branch){
		 $("#refreshdiv").load('fadpMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&branch='+branch);
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

                <td class="lbl-right">Date</td>

                <td>
                    <div id="fadpdate" name="fadpdate"
                         value='<s:property value="fadpdate"/>'></div>

                    <input type="hidden"
                           id="hidfadpdate"
                           name="hidfadpdate"
                           value='<s:property value="hidfadpdate"/>'>
                </td>

                <td class="lbl-right">Doc No</td>

                <td>
                    <input type="text"
                           id="txtdocno"
                           name="txtdocno"
                           class="search-input medium-input"
                           value='<s:property value="txtdocno"/>'>
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

                <td class="lbl-right">Name</td>

                <td colspan="2">
                    <input type="text"
                           id="txtpartyname"
                           name="txtpartyname"
                           class="search-input large-input"
                           value='<s:property value="txtpartyname"/>'>
                </td>

                <td>

                    <table style="border-collapse:collapse;">
                        <tr>
                            <td class="lbl-right" style="padding-right:6px;">Total</td>
                            <td>
                                <input type="text"
                                       id="txtamount"
                                       name="txtamount"
                                       class="search-input small-input"
                                       value='<s:property value="txtamount"/>'>
                            </td>
                        </tr>
                    </table>

                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="fadpMainSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>