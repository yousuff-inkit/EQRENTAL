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
        // JQX input alignment fix to match standard 24px height for both date fields
        setTimeout(function () {
            $("#bankdate, #chqdate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Segoe UI, Tahoma, Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#bankdate, #chqdate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

        $("#bankdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
        $("#chqdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
    }); 

    function loadSearch() {
        var partyname=document.getElementById("txtpartyname").value;
        var docNo=document.getElementById("txtdocno").value;
        var date=document.getElementById("bankdate").value;
        var amount=document.getElementById("txtamount").value;
        var chequeNo=document.getElementById("txtchqno").value;
        var chequeDt=document.getElementById("chqdate").value;
        var check = 1;
        
        getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check);
    }
    
    function getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check){
         $("#refreshdiv").load('ibpMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&chequeNo='+chequeNo+'&chequeDt='+chequeDt+'&check='+check);
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
</head>
<body>

<div id="search">

    <div class="search-panel">

        <div class="field-group grow-2">
            <span class="lbl-right">Name</span>
            <input type="text"
                   id="txtpartyname"
                   name="txtpartyname"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="txtpartyname"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Doc No</span>
            <input type="text"
                   id="txtdocno"
                   name="txtdocno"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="txtdocno"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Date</span>
            <div id="bankdate"
                 name="bankdate"
                 value='<s:property value="bankdate"/>'></div>
            <input type="hidden"
                   id="hidbankdate"
                   name="hidbankdate"
                   value='<s:property value="hidbankdate"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Amount</span>
            <input type="text"
                   id="txtamount"
                   name="txtamount"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="txtamount"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Cheque No</span>
            <input type="text"
                   id="txtchqno"
                   name="txtchqno"
                   class="search-input"
                   autocomplete="off"
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
            <jsp:include page="ibpMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>