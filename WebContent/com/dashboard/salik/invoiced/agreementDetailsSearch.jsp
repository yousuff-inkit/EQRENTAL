<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
    $(document).ready(function () {
        // Initialization if needed
    }); 

    function mainloadSearch() {
        var sclname = document.getElementById("SCl_name").value;
        var smob = document.getElementById("Sl_mob").value;
        var rno = document.getElementById("rno").value;
        var flno = document.getElementById("flno").value;
        var sregno = document.getElementById("sregno").value;
        
        // Safely fetch rentaltype value to prevent JS errors
        var rentalTypeElem = document.getElementById("rentaltype");
        var rentaltype = rentalTypeElem ? rentalTypeElem.value : "";
        
        getdata(sclname, smob, rno, flno, sregno, rentaltype);
    }
    
    function getdata(sclname, smob, rno, flno, sregno, rentaltype){
        // Upgraded to use encodeURIComponent for safe parameter passing
        var url = 'agreementDetailsSearchGrid.jsp' +
                  '?sclname=' + encodeURIComponent(sclname) +
                  '&smob=' + encodeURIComponent(smob) +
                  '&rno=' + encodeURIComponent(rno) +
                  '&flno=' + encodeURIComponent(flno) +
                  '&sregno=' + encodeURIComponent(sregno) +
                  '&rentaltype=' + encodeURIComponent(rentaltype);
                  
         $("#srefreshdiv").load(url);
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
                   id="SCl_name"
                   name="SCl_name"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="SCl_name"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Mob</span>
            <input type="text"
                   id="Sl_mob"
                   name="Sl_mob"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="Sl_mob"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Reg No</span>
            <input type="text"
                   id="sregno"
                   name="sregno"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="sregno"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Doc No</span>
            <input type="text"
                   id="rno"
                   name="rno"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="rno"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Fleet No</span>
            <input type="text"
                   id="flno"
                   name="flno"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="flno"/>'>
        </div>

        <!-- Added gracefully to prevent JS errors based on your original script -->
        <input type="hidden" id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>

        <div class="btn-group">
            <input
                type="button"
                id="mbtnrasearch"
                name="mbtnrasearch"
                class="myButton"
                onclick="mainloadSearch();"
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
        <div id="srefreshdiv">
           <jsp:include page="agreementDetailsSearchGrid.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>