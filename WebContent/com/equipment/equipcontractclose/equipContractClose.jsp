<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<%
String id=request.getParameter("id")==null?"":request.getParameter("id");
String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String contextPath=request.getContextPath();
%>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

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

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

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
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form action="saveEquipContractClose" id="frmEquipContractClose" autocomplete="off">
        <jsp:include page="../../../header.jsp"></jsp:include>

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">General Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' tabindex="-1" style="width:120px;" readonly />
                    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' />
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Contract No</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="contractvocno" name="contractvocno" value='<s:property value="contractvocno"/>' onkeydown="getContract(event);" placeholder="Press F3" />
                        <svg class="magnifier-icon" onclick="$('#contractvocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="contractdocno" name="contractdocno" value='<s:property value="contractdocno"/>' />

                    <label class="lbl-right" style="width:80px;">Details</label>
                    <input type="text" id="contractdetails" name="contractdetails" value='<s:property value="contractdetails"/>' style="flex:1;" tabindex="-1" readonly />
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Closing Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">End Date</label>
                    <div style="width: 125px;">
                        <div id="enddate" name="enddate" value='<s:property value="enddate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px;">End Time</label>
                    <div style="width: 125px;">
                        <div id="endtime" name="endtime" value='<s:property value="endtime"/>'></div>
                    </div>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Description</label>
                    <input type="text" id="desc" name="desc" value='<s:property value="desc"/>' style="flex:1;" />
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Rental Items</span>
                <div id="rentalcontractgriddiv" class="grid-container">
                    <jsp:include page="rentalContractGrid.jsp"></jsp:include>
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="hidendtime" name="hidendtime" value='<s:property value="hidendtime"/>'/>
            </div>
            
        </div>

        <div id="equipwindow"><div></div></div>
        <div id="tariffwindow"><div></div></div>
        <div id="contractwindow"><div></div></div>
        <div id="salwindow"><div></div></div>
        <div id="qotwindow"><div></div></div>
    </form> 
</div>  

<script type="text/javascript">
    $(document).ready(function(){
        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
        $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        $("#enddate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value: null, theme: 'energyblue'});
        $("#endtime").jqxDateTimeInput({ width: '125px', height: 24, formatString:"HH:mm", value: null, showCalendarButton: false, theme: 'energyblue'});
        
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#date, #enddate, #endtime").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#date, #enddate, #endtime").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

        $('#equipwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#equipwindow').jqxWindow('close');
        $('#tariffwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Tariff Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#tariffwindow').jqxWindow('close');
        $('#contractwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Contract Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#contractwindow').jqxWindow('close');
        $('#qotwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Quote Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#qotwindow').jqxWindow('close');
        $('#salwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#salwindow').jqxWindow('close');
        
        $('#date').on('change', function (event) {
            var maindate = $('#date').jqxDateTimeInput('getDate');
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
                funDateInPeriod(maindate);
            }
        });
        
        $('#contractvocno').dblclick(function(){
            if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
                $('#contractwindow').jqxWindow('open');
                innerWindowSearchContent('contractMasterSearch.jsp','contractwindow');
            }               
        });
        
    });
    
    function isNumber(evt,id) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
            $.messager.alert('Warning','Enter Numbers Only');
            $("#"+id+"").focus();
            return false;
        }
        return true;
    }
    
    function getContract(event){
        if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
            var x= event.keyCode;
            if(x==114){
                $('#contractvocno').dblclick();
            }
        }
    }
    
    function innerWindowSearchContent(url,windowid){
        $.get(url).done(function (data) {
            $('#'+windowid).jqxWindow('setContent', data);
        });
    }
    
    function funReadOnly(){
        $('#frmEquipContractClose input').attr('readonly', true);
        $('#date').jqxDateTimeInput({'disabled':true});
        var reqid='<%=id%>';
        if(reqid=="3"){
            var reqbrhid='<%=brhid%>';
            $('#brchName').val(reqbrhid);
            var reqrefno='<%=refno%>';
            funCreateBtn();
            getReqRefData(reqrefno);
        }
    }
    
    function funRemoveReadOnly(){
        $('#frmEquipContractClose input').attr('readonly', false);
        $('#docno,#vocno,#contractvocno,#contractdetails').attr('readonly', true);
        if($('#mode').val()=='A' || $('#mode').val()=='E'){
            $('#date').jqxDateTimeInput({'disabled':false});
            $('#rentalContractGrid').jqxGrid('addrow',null,{});
        }
        if($('#mode').val()=='A'){
            $('#date').jqxDateTimeInput('setDate',new Date());
            $('#rentalContractGrid').jqxGrid('clear');
            $('#rentalContractGrid').jqxGrid('addrow',null,{});
        }
        if($('#mode').val()=='D'){
            $('#date').jqxDateTimeInput({'disabled':false});
        }
    }
    
    function funNotify(){
        if($('#contractdocno').val()==''){
            document.getElementById("errormsg").innerText="Contract is mandatory";
            return 0;
        }
        
        if($('#desc').val().length>1000){
            document.getElementById("errormsg").innerText="Description - Max 1000 Chars Only";
            return 0;
        }
        if($('#enddate').jqxDateTimeInput('getDate')==null){
            document.getElementById("errormsg").innerText="Contract End Date is mandatory";
            return 0;
        }
        if($('#endtime').jqxDateTimeInput('getDate')==null){
            document.getElementById("errormsg").innerText="Contract End Time is mandatory";
            return 0;
        }
        var selectedrows = $("#rentalContractGrid").jqxGrid('getselectedrowindexes');
        if(selectedrows.length==0){
            $.messager.alert('Warning','Please select valid rows');
            return 0;
        }
        var errorstatus=0;
        for(var i=0;i<selectedrows.length;i++){
            var startdate=new Date($('#rentalContractGrid').jqxGrid('getcellvalue',selectedrows[i],'startdate'));
            var starttime=new Date($('#rentalContractGrid').jqxGrid('getcellvalue',selectedrows[i],'starttime'));
            var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
            var endtime=new Date($('#endtime').jqxDateTimeInput('getDate'));
            startdate.setHours(0,0,0,0);
            enddate.setHours(0,0,0,0);
            if(enddate<startdate){
                document.getElementById("errormsg").innerText="End date cannot be less than start date";
                errorstatus=1;
                break;
            }
            if(enddate-startdate==0){
                if(endtime.getHours()<starttime.getHours()){
                    document.getElementById("errormsg").innerText="End time cannot be less than start time";
                    errorstatus=1;
                    break;
                }
                else if(endtime.getMinutes()<starttime.getMinutes()){
                    document.getElementById("errormsg").innerText="End time cannot be less than start time";
                    errorstatus=1;
                    break;
                }   
            }
        }
        if(errorstatus==1){
            return 0;
        }
        var rows = $("#rentalContractGrid").jqxGrid('getrows');
        
        var gridlength=0;
        for(var i=0;i<selectedrows.length;i++){
            newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "closetest"+i)
                    .attr("name", "closetest"+i)
                    .attr("hidden", "true"); 
            
            var calcdocno=$("#rentalContractGrid").jqxGrid('getcellvalue',selectedrows[i],'calcdocno');
            newTextBox.val(calcdocno);
            newTextBox.appendTo('form'); 
            gridlength++;
        }
        $('#gridlength').val(selectedrows.length);
        return 1;
    }
    
    function funChkButton() {
        /* funReset(); */
    }

    function funSearchLoad(){
        changeContent('masterSearch.jsp'); 
    }
    
    function funFocus(){
        $('#date').jqxDateTimeInput('focus');               
    }
    
    function setValues() {
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        if($('#hidendtime').val()!=''){
            $('#endtime').jqxDateTimeInput('val',$('#hidendtime').val());
        }
        if($('#docno').val()!=''){
            var docno=$('#docno').val();
            $('#rentalcontractgriddiv').load('rentalContractGrid.jsp?docno='+docno+'&id=1');
        }
    }
    
    function funPrintBtn(){
        if (($("#mode").val() == "view") && $("#docno").val()!="") {
            var url=document.URL;
            var reurl=url.split("com/");
            var win= window.open(reurl[0]+"printEquipContractClose?docno="+document.getElementById("docno").value+"&branch="+$('#brchName').val()+"&closedocno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
            
            win.focus();
        } 
        else{
            $.messager.alert('Message','Select a Document....!','warning');
            return false;
        }
    }
</script>
</body>
</html>