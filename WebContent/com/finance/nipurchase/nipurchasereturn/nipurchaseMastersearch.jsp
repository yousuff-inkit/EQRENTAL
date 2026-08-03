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
        // JQX input alignment fix to match standard 24px height
        setTimeout(function () {
            $("#datess1").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Segoe UI, Tahoma, Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#datess1").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

        $("#datess1").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null}); 
    });   
           
    function loadSearchs() {
        var docnoss = document.getElementById("docnoss1").value;
        var accountss = document.getElementById("accountss1").value;
        var accnamesss = document.getElementById("accnamess1").value;
        var datess = document.getElementById("datess1").value;
        var reftypess = document.getElementById("reftypess1").value;
        var desc = document.getElementById("description1").value;
        
        // Use global regex to safely replace all spaces
        var description = desc.replace(/ /g, '%20');
        var accnamess = accnamesss.replace(/ /g, '%20');
        var aa = "yes";
        
        getdata(docnoss, accountss, accnamess, datess, reftypess, aa, description);
    }
    
    function getdata(docnoss, accountss, accnamess, datess, reftypess, aa, description){
         $("#refreshdivs").load('submasterSearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&reftypess='+reftypess+'&aa='+aa+'&description='+description);
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
        
        <div class="field-group">
            <span class="lbl-right">Doc No</span>
            <input type="text"
                   id="docnoss1"
                   name="docnoss1"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="docnoss1"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Account</span>
            <input type="text"
                   id="accountss1"
                   name="accountss1"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="accountss1"/>'>
        </div>

        <div class="field-group grow-2">
            <span class="lbl-right">Account Name</span>
            <input type="text"
                   id="accnamess1"
                   name="accnamess1"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="accnamess1"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Date</span>
            <div id="datess1"
                 name="datess1"
                 value='<s:property value="datess1"/>'></div>
        </div>

        <div class="field-group grow-2">
            <span class="lbl-right">Description</span>
            <input type="text"
                   id="description1"
                   name="description1"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="description1"/>'>
        </div>

        <!-- Hidden References -->
        <select hidden="true" name="reftypess1" id="reftypess1" value='<s:property value="reftypess1"/>'></select>

        <div class="btn-group">
            <input
                type="button"
                id="searchs"
                name="searchs"
                class="myButton"
                onclick="loadSearchs();"
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
           <jsp:include page="submasterSearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>