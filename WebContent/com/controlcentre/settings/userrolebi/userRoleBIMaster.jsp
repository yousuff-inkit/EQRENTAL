<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - User Role BI</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Master UI Standard)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
    $(document).ready(function() {
        $('#userRoleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User-Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#userRoleDetailsWindow').jqxWindow('close');
        
        /* Bound dblclick directly on ready to avoid redundant wrapping */
        $('#txtrolename').dblclick(function(){
            userRoleSearchContent('<%=contextPath%>/userRoleSearchGrid.jsp');
        });
    });
    
    function userRoleSearchContent(url) {
        $('#userRoleDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#userRoleDetailsWindow').jqxWindow('setContent', data);
            $('#userRoleDetailsWindow').jqxWindow('bringToFront');
        }); 
    }
    
    function funReadOnly(){
        $('#frmUserRoleBIMaster input').attr('readonly', true );
        $("#jqxUserRoleBI").jqxGrid({ disabled: true});
    }
    
    function funRemoveReadOnly(){
        $('#frmUserRoleBIMaster input').attr('readonly', false );
        $('#txtrolename').attr('readonly', true);
        $('#docno').attr('readonly', true);
        $("#jqxUserRoleBI").jqxGrid({ disabled: false});
        
        if ($("#mode").val() == "A") {
            $("#userRoleBIDiv").load("userRoleBIGrid.jsp");  
        }
    }
    
    function funSearchLoad(){
         changeContent('ubiMainSearch.jsp');  
    }
        
    function funChkButton() {
        /* funReset(); */
    }
     
    function funFocus(){
        document.getElementById("txtrolename").focus(); 	    		
    }
    
    function funNotify(){	
        /* User Role Grid Saving */
        var rows = $("#jqxUserRoleBI").jqxGrid('getrows');
        var length=0;
        for(var i=0 ; i < rows.length ; i++){
            var chk=rows[i].mno;
            if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "test"+length)
                .attr("name", "test"+length)
                .attr("hidden", "true");
                length=length+1;
                
                newTextBox.val(rows[i].mno+"::"+rows[i].master+":: "+rows[i].dno+":: "+rows[i].detail+":: "+rows[i].permission+":: "+rows[i].email+":: "+rows[i].excel);
                newTextBox.appendTo('form');
            }
        }
        $('#gridlength').val(length);
        /* User Role Grid Saving Ends*/ 
                
        return 1;
    } 
      
    function setValues(){
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();
        
        var indexVal = document.getElementById("docno").value;
        if(indexVal>0){
            $("#userRoleBIDiv").load("userRoleBIGrid.jsp?roleid="+indexVal);
        }
    }
      
    function getRole(event){
        var x= event.keyCode;
        if(x==114){
            userRoleSearchContent('<%=contextPath%>/userRoleSearchGrid.jsp');
        }
    }
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserRoleBIMaster" action="saveUserRoleBIMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    
    <div class="middle-panel">
        <span class="middle-panel-title">User Role Info</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Role</label>
            <div class="input-search-container" style="width: 250px;">
                <input type="text" id="txtrolename" name="txtrolename" placeholder="Press F3" value='<s:property value="txtrolename"/>' onkeydown="getRole(event);" />
                <svg class="magnifier-icon" onclick="userRoleSearchContent('<%=contextPath%>/userRoleSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtuserrolebidocno" style="width:125px;" value='<s:property value="txtuserrolebidocno"/>' tabindex="-1" readonly />
        </div>
    </div>

    <div class="middle-panel" style="padding-bottom: 20px;">
        <span class="middle-panel-title">Role BI Permissions</span>
        <div id="userRoleBIDiv" class="grid-container">
            <jsp:include page="userRoleBIGrid.jsp"></jsp:include>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
    </div>

</div>
</form>

<div id="userRoleDetailsWindow"><div></div><div></div></div> 

</div>
</body>
</html>