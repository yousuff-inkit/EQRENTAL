<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#txtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	});


 	function loadSearch() {
 		var docNo=document.getElementById("txtdocno").value;
 		var dates=document.getElementById("txtdate").value;
 		var descriptions=document.getElementById("txtdesc").value;
 		var refNo=document.getElementById("txtreference").value;
 		var amounts=document.getElementById("txtamount").value;
 		var check = 1;

		getdata(docNo,dates,descriptions,refNo,amounts,check);

	}

	function getdata(docNo,dates,descriptions,refNo,amounts,check){
		 $("#refreshdiv").load('jvtMainSearchGrid.jsp?docNo='+docNo+'&dates='+dates+'&descriptions='+descriptions.replace(/ /g, "%20")+'&refNo='+refNo+'&amounts='+amounts+'&check='+check);
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

        <div class="field-group">
            <span class="lbl-right">Doc No</span>
            <input type="text"
                   id="txtdocno"
                   name="txtdocno"
                   autocomplete="off"
                   class="search-input"
                   value='<s:property value="txtdocno"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Ref. No.</span>
            <input type="text"
                   id="txtreference"
                   name="txtreference"
                   autocomplete="off"
                   class="search-input"
                   value='<s:property value="txtreference"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Date</span>
            <div id="txtdate"
                 name="txtdate"
                 value='<s:property value="txtdate"/>'></div>
            <input type="hidden"
                   id="hidtxtdate"
                   name="hidtxtdate"
                   value='<s:property value="hidtxtdate"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Amount</span>
            <input type="text"
                   id="txtamount"
                   name="txtamount"
                   autocomplete="off"
                   class="search-input"
                   value='<s:property value="txtamount"/>'>
        </div>

        <div class="field-group grow-2">
            <span class="lbl-right">Description</span>
            <input type="text"
                   id="txtdesc"
                   name="txtdesc"
                   autocomplete="off"
                   class="search-input"
                   value='<s:property value="txtdesc"/>'>
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
            <jsp:include page="jvtMainSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>
