<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - User Role</title>
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
.modern-ui input[type="email"],
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
.modern-ui input[type="email"]:focus,
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
    $(document).ready(function() {});
    
    function funReadOnly(){
        $('#frmUserRoleMaster input').attr('readonly', true );
        $("#jqxUserRole").jqxGrid({ disabled: true});
    }
    
    function funRemoveReadOnly(){
        $('#frmUserRoleMaster input').attr('readonly', false );
        $('#docno').attr('readonly', true);
        $("#jqxUserRole").jqxGrid({ disabled: false});
        
        if ($("#mode").val() == "A") {
            $("#userRoleDiv").load("userRoleGrid.jsp");  
        }
        if ($("#mode").val() == "E") {
            $('#txtrolename').attr('readonly', true);  
        }
    }
    
    function funSearchLoad(){
         changeContent('rleMainSearch.jsp');  
    }
        
    function funChkButton() {
            /* funReset(); */
    }
     
    function funFocus(){
        document.getElementById("txtrolename").focus(); 	    		
    }
    
    function funNotify(){	
        /* User Role Grid Saving */
        var rows = $("#jqxUserRole").jqxGrid('getrows');
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
                
                newTextBox.val(rows[i].mno+"::"+rows[i].menu_name+":: "+rows[i].add1+":: "+rows[i].edit+":: "+rows[i].del+":: "+rows[i].print+":: "+rows[i].attach+":: "+rows[i].excel+":: "+rows[i].email+":: "+rows[i].costing+":: "+rows[i].terms);
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
            $("#userRoleDiv").load("userRoleGrid.jsp?roleid="+indexVal);
        }
    }
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserRoleMaster" action="saveUserRoleMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    
    <div class="middle-panel">
        <span class="middle-panel-title">User Role Info</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Role</label>
            <input type="text" id="txtrolename" name="txtrolename" style="width:200px;" value='<s:property value="txtrolename"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Email</label>
            <input type="email" id="txtemail" name="txtemail" placeholder="someone@example.com" style="flex:1; max-width:300px;" value='<s:property value="txtemail"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtuserroledocno" style="width:125px;" value='<s:property value="txtuserroledocno"/>' tabindex="-1" readonly />
        </div>
    </div>

    <div class="middle-panel" style="padding-bottom: 20px;">
        <span class="middle-panel-title">Role Permissions</span>
        <div id="userRoleDiv" class="grid-container">
            <jsp:include page="userRoleGrid.jsp"></jsp:include>
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

<div id="roleDetailsWindow"><div></div><div></div></div> 

</div>
</body>
</html>