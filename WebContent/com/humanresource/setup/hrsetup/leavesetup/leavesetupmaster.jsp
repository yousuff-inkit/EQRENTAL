<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
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

/* Custom Legacy Buttons */
.myButton1 {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border-radius:4px; border:1px solid #566963; cursor:pointer; color:#ffffff; font-family:Arial; font-size:12px; padding:2px 12px; height: 24px;
}
.myButton1:hover { background-color:#6c7c7c; }

.myButton4 {
	background-color:#e4685d; border-radius:4px; border:1px solid #ffffff; cursor:pointer; color:#ffffff; font-family:Arial; font-size:12px; padding:3px 12px; height: 24px;
}
.myButton4:hover { background-color:#eb675e; }

.bounce {
	color: #f35626; background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a); -webkit-background-clip: text; -webkit-text-fill-color: transparent; animation: hue 60s infinite linear,bounce 2s infinite; 
}
@keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateX(0); }
  40% { transform: translateX(-30px); }
  60% { transform: translateX(-15px); }
} 
@keyframes hue { from { filter: hue-rotate(0deg); } to { filter: hue-rotate(-360deg); } }

form label.error { color:red; font-weight:bold; }
</style>

<script type="text/javascript">
$(document).ready(function () {   
    document.getElementById("formdet").innerText="Leave Setup(LSP)";
    document.getElementById("formdetail").value="Leave Setup";
    document.getElementById("formdetailcode").value="LSP";
    window.parent.formCode.value="LSP";
    window.parent.formName.value="Leave Setup";
    document.getElementById("showlabel").innerText="";
		
    $('#refSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Ref No Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#refSearchwindow').jqxWindow('close');
		
    $('#btnCreate').attr('disabled', true);
    $('#btnDelete').attr('disabled', true);
    $('#btnSearch').attr('disabled', true);
    $('#btnEdit').attr('disabled', true);
		
    $('#refno').dblclick(function(){
        $('#refSearchwindow').jqxWindow('open');
        refnoSearchContent('refmastersearch.jsp?');
    });   
});
	
function funSearchLoad(){}

function refnoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#refSearchwindow').jqxWindow('open');
        $('#refSearchwindow').jqxWindow('setContent', data);
    }); 
}
	
function gethrsetup(event){
    var x= event.keyCode;
    if(x==114){
        $('#refSearchwindow').jqxWindow('open');
        refnoSearchContent('refmastersearch.jsp?');    
    }
}
      
function funReadOnly() {
    $('#frmleavesetup input').attr('readonly', true);
    $('#savebtn').attr('disabled', true);
    $('#deltbtn').attr('disabled', true);
}
	
function funRemoveReadOnly() {
    $('#frmleavesetup input').attr('readonly', false);
    $('#docno').attr('readonly', true);
}
 
function setValues() {
    if(document.getElementById("newmode").value=='Saved') {
        var leaveid=document.getElementById("leaveid").value;
        var refno= document.getElementById("refno").value;
        $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
        var disdata="hide";
        $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
        document.getElementById("showlabel").innerText=document.getElementById("hidshowlabel").value;
        $.messager.alert('Message', '  Record successfully Updated ');
        funReadOnly();
    } else if(document.getElementById("newmode").value=='notSaved') {
        $.messager.alert('Message', '  Not Updated ');
    } 
}
	
function funNotify(){}
	
function fundel() {
    var leavetype="";
    var rows = $("#leavesetupgrid").jqxGrid('getrows');      
    for(var i=0;i<rows.length;i++){
        if(parseInt(rows[i].checkclick)==1){
            leavetype=rows[i].leavetype; 
        }
    }
    $.messager.confirm('Message', 'Do you want to delete all records of '+leavetype, function(r){
        if(r==false) { return false;  } 
        else{
            var leaveid="";
            var rows = $("#leavesetupgrid").jqxGrid('getrows');      
            for(var i=0;i<rows.length;i++){
                if(parseInt(rows[i].checkclick)==1){ leaveid=rows[i].ldocno; }
            }
            fundeldata(leaveid,leavetype);
        }
    });
}

function fundeldata(leaveid,leavetype) {
    var refno= document.getElementById("refno").value;
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            if(parseInt(items)>0) {
                $.messager.alert('Message', 'Record Successfully Deleted Leave Type - '+leavetype);
                document.getElementById("newmode").value="";
                var leaveid=document.getElementById("leaveid").value;
                var refno= document.getElementById("refno").value;
                $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
                var disdata="hide";
                $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
            } else { 
                $.messager.alert('Message', '  Not Deleted'); 
            }
        }
    }
    x.open("GET","deletedate.jsp?leaveid="+leaveid+"&refno="+refno,true);
    x.send();
}
   
function funsave(){
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false) { return false; } 
        else{ funsavedata(); }
    });
}
     
function funsavedata(){	 
    var z=0;
    var rows = $("#condtiongrid").jqxGrid('getrows');      
    var selectedrows=$("#condtiongrid").jqxGrid('selectedrowindexes');
    $('#algridlength').val(selectedrows.length);
    for (var i = 0; i < rows.length; i++) {
        for(var j=0;j<selectedrows.length;j++){
            if(selectedrows[j]==i){
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "condtest"+z)
                    .attr("name", "condtest"+z)
                    .attr("hidden", "true");  
                newTextBox.val(rows[i].allowanceid+" :: ");
                newTextBox.appendTo('form');
                z++;
            }
        }
    }
    var rows = $("#leavesetupgrid").jqxGrid('getrows');      
    for(var i=0;i<rows.length;i++){
        if(parseInt(rows[i].checkclick)==1){
            newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "leavetest"+0)
                .attr("name", "leavetest"+0)
                .attr("hidden", "true");  
            newTextBox.val(rows[i].ldocno+" :: "+rows[i].cf+" :: "+rows[i].deduct+" :: "+rows[i].l1+" :: "+rows[i].l2+" :: "+rows[i].l3+" :: "+rows[i].l1ded+" :: "+rows[i].l2ded+" :: "+rows[i].l3ded); 
            newTextBox.appendTo('form');
        }
    }
    document.getElementById("frmleavesetup").submit();
} 
     
function funFocus(){}
</script>  
 
</head>
<body onLoad="setValues();" >

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmleavesetup" action="saveLeavesetup" method="post" autocomplete="off"> 
<jsp:include page="../../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">Leave Setup Info</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Ref No</label>
            <div class="input-search-container" style="width: 150px;">
                <input type="text" placeholder="Press F3" onKeyDown="gethrsetup(event);" name="refno" id="refno" value='<s:property value="refno"/>'>
                <svg class="magnifier-icon" onclick="$('#refno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:80px;">Category</label>
            <input type="text" name="category" id="category" style="width:250px;" value='<s:property value="category"/>'>
            
            <div class="bounce" style="margin-left:auto; text-align:center;">
                <b><label id="showlabel" style="font-size: 13px; font-family: Tahoma; color:#6000FC" value='<s:property value="showlabel"/>'></label></b>
            </div>
        </div>
    </div>
    
    <div style="display: flex; gap: 15px;">
        <div class="middle-panel" style="flex: 6.5; margin-bottom: 0;">
            <span class="middle-panel-title">Leave Details</span>
            <div id="lsetup1" class="grid-container" style="height:375px;">
                <jsp:include page="leavesetupgrid.jsp"></jsp:include>
            </div>
        </div>
        
        <div class="middle-panel" style="flex: 3.5; margin-bottom: 0;">
            <span class="middle-panel-title">Conditions</span>
            <div id="lsetup2" class="grid-container" style="margin-bottom: 15px; height: 320px;">
                <jsp:include page="condtiongrid.jsp"></jsp:include>
            </div>
            <div style="text-align:center;">
                <input type="button" id="savebtn" class="myButton1" onclick="funsave();" value="Save" style="margin-right:20px;"> 
                <input type="button" id="deltbtn" onclick="fundel()" class="myButton4" value="Delete">
            </div>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>' />
        <input type="hidden" id="hidshowlabel" name="hidshowlabel" value='<s:property value="hidshowlabel"/>' />
        <input type="hidden" id="leaveid" name="leaveid" value='<s:property value="leaveid"/>' />
        <input type="hidden" id="newmode" name="newmode" value='<s:property value="newmode"/>' />
        <input type="hidden" id="algridlength" name="algridlength" value='<s:property value="algridlength"/>' />
        <input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>' />
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
    </div>

</div>

</form>

<div id="refSearchwindow"><div></div></div>  

</div>
</body>
</html>