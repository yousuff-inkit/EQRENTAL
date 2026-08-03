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
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
	<script type="text/javascript">

	$(document).ready(function () {

		   /* Date */
	    $("#datess1").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null});

	});

 	function loadSearchs() {

 		var docnoss=document.getElementById("docnoss").value;
 		var accountss=document.getElementById("accountss").value;
 		var accnamesss=document.getElementById("accnamess").value;
 		var datess=document.getElementById("datess1").value;

 		var refnoss=document.getElementById("refnoss").value;


 		var accnamess = accnamesss.replace(' ', '%20');
 		var descriptionss=document.getElementById("descriptionss").value.replace(/ +(?= )/g,'');

	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,aa,descriptionss,refnoss);


	}
	function getdata(docnoss,accountss,accnamess,datess,aa,descriptionss,refnoss){

		 $("#refreshdivs").load('Subsearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&aa='+aa+'&descriptions='+descriptionss+'&refnoss='+refnoss);

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
                   id="docnoss"
                   name="docnoss"
                   class="search-input"
                   value='<s:property value="docnoss"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Account</span>
            <input type="text"
                   id="accountss"
                   name="accountss"
                   class="search-input"
                   value='<s:property value="accountss"/>'>
        </div>

        <div class="field-group grow-2">
            <span class="lbl-right">Account Name</span>
            <input type="text"
                   id="accnamess"
                   name="accnamess"
                   class="search-input"
                   value='<s:property value="accnamess"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Date</span>
            <div id="datess1"
                 name="datess1"
                 value='<s:property value="datess1"/>'></div>
        </div>

        <div class="field-group">
            <span class="lbl-right">Ref Type No</span>
            <input type="text"
                   id="refnoss"
                   name="refnoss"
                   class="search-input"
                   value='<s:property value="refnoss"/>'>
        </div>

        <div class="field-group grow-2">
            <span class="lbl-right">Description</span>
            <input type="text"
                   id="descriptionss"
                   name="descriptionss"
                   class="search-input"
                   value='<s:property value="descriptionss"/>'>
        </div>

        <div class="btn-group">
            <input
                type="button"
                id="searchs"
                name="searchs"
                class="myButton"
                onclick="loadSearchs()"
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

        <div id="refreshdivs">
            <jsp:include page="Subsearch.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>
