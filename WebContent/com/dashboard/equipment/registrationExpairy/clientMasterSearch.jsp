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
            $("#dr_DOB").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Segoe UI, Tahoma, Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#dr_DOB").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

        $("#dr_DOB").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
    }); 

    function loadSearch() {
        var clname = document.getElementById("Cl_name").value;
        var mob = document.getElementById("Cl_mob").value;
        var lcno = document.getElementById("dr_Licence").value;
        var passno = document.getElementById("dr_Passport").value;
        var nation = document.getElementById("dr_Nation").value;
        var dob = $('#dr_DOB').jqxDateTimeInput('val');
        
        // Safely fetch branch value
        var branchElem = document.getElementById("cmbbranch");
        var branch = branchElem ? branchElem.value : "";
        
        getdata(clname, mob, lcno, passno, nation, dob, branch);
    }   
    
    function getdata(clname, mob, lcno, passno, nation, dob, branch){
         $("#refreshdiv").load('clientSearchGrid.jsp?clname='+clname.replace(/ /g,"%20")+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&branch='+branch+'&mode=1');
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
                   id="Cl_name"
                   name="Cl_name"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="Cl_name"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">MOB</span>
            <input type="text"
                   id="Cl_mob"
                   name="Cl_mob"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="Cl_mob"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Licence#</span>
            <input type="text"
                   id="dr_Licence"
                   name="dr_Licence"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="dr_Licence"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Passport#</span>
            <input type="text"
                   id="dr_Passport"
                   name="dr_Passport"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="dr_Passport"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Nationality</span>
            <input type="text"
                   id="dr_Nation"
                   name="dr_Nation"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="dr_Nation"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">DOB</span>
            <div id="dr_DOB"
                 name="dr_DOB"
                 value='<s:property value="dr_DOB"/>'></div>
            <input type="hidden"
                   id="hiddr_DOB"
                   name="hiddr_DOB"
                   value='<s:property value="hiddr_DOB"/>'>
        </div>

        <!-- Added gracefully to prevent JS errors based on your original script -->
        <input type="hidden" id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>'>

        <div class="btn-group">
            <input
                type="button"
                id="btnrasearch"
                name="btnrasearch"
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
           <jsp:include page="clientSearchGrid.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>