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
	 $("#securitychequedate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#chqdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	});

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("securitychequedate").value;
 		var amount=document.getElementById("txtamounts").value;
 		var chequeNo=document.getElementById("txtchqno").value;
 		var chequeDt=document.getElementById("chqdate").value;

		getdata(partyname,docNo,date,amount,chequeNo,chequeDt);
	}
	function getdata(partyname,docNo,date,amount,chequeNo,chequeDt){
		 $("#refreshdiv").load('secMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&chequeNo='+chequeNo+'&chequeDt='+chequeDt+'&check=1');
		}

	</script>
<style>
*{
    box-sizing:border-box;
}

html,body{
    margin:0;
    padding:0;
    width:100%;
    max-width:100%;
    background:#fff;
    font-family:Segoe UI,Tahoma,sans-serif;
    overflow-x:hidden;
}

#search{
    padding:10px;
    background:#fff;
    width:100%;
    max-width:100%;
}

.search-panel{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    padding:12px;
    margin-bottom:10px;
    width:100%;
    max-width:100%;
    display:flex;
    flex-wrap:wrap;
    align-items:flex-end;
    gap:10px 14px;
}

.field-group{
    display:flex;
    flex-direction:column;
    flex:1 1 140px;
    min-width:110px;
    max-width:100%;
}

.field-group.grow-2{
    flex:2 1 200px;
}

.lbl-right{
    text-align:left;
    font-size:12px;
    font-weight:500;
    color:#333;
    margin-bottom:4px;
    white-space:nowrap;
}

.search-input{
    height:26px;
    width:100%;
    max-width:100%;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 6px;
    font-size:12px;
}

.btn-group{
    flex:0 0 auto;
}

.grid-container{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    overflow:hidden;
    width:100%;
    max-width:100%;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <div class="field-group grow-2">
            <span class="lbl-right">Name</span>
            <input type="text"
                   id="txtpartyname"
                   name="txtpartyname"
                   class="search-input"
                   value='<s:property value="txtpartyname"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Doc No</span>
            <input type="text"
                   id="txtdocno"
                   name="txtdocno"
                   class="search-input"
                   value='<s:property value="txtdocno"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Date</span>
            <div id="securitychequedate"
                 name="securitychequedate"
                 value='<s:property value="securitychequedate"/>'></div>
            <input type="hidden"
                   id="hidsecuritychequedate"
                   name="hidsecuritychequedate"
                   value='<s:property value="hidsecuritychequedate"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Amount</span>
            <input type="text"
                   id="txtamounts"
                   name="txtamounts"
                   class="search-input"
                   value='<s:property value="txtamounts"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Cheque No</span>
            <input type="text"
                   id="txtchqno"
                   name="txtchqno"
                   class="search-input"
                   value='<s:property value="txtchqno"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Cheque Date</span>
            <div id="chqdate"
                 name="chqdate"
                 value='<s:property value="chqdate"/>'></div>
            <input type="hidden"
                   id="hidchqdate"
                   name="hidchqdate"
                   value='<s:property value="hidchqdate"/>'>
        </div>

        <div class="btn-group">
            <input
                type="button"
                id="btnsearch"
                name="btnsearch"
                class="myButton"
                onclick="loadSearch();"
                value="Search"
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
        </div>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="secMainSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>
