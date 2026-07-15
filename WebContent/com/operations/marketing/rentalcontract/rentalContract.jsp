<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
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

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }

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
    <form action="saveRentalContract" id="frmRentalContract" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include>

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Document Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px;">Ref Type</label>
                    <select name="cmbreftype" id="cmbreftype" style="width:120px;">
                        <option value="QOT">Quote</option>
                    </select>
                    <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>' />
                    
                    <label class="lbl-right" style="width:80px;">Ref No</label>
                    <div class="input-search-container" style="width: 120px;">
                        <input type="text" id="refno" name="refno" value='<s:property value="refno"/>' onkeydown="getRefno(event);" placeholder="Press F3" />
                        <svg class="magnifier-icon" onclick="$('#refno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="hidrefno" name="hidrefno" value='<s:property value="hidrefno"/>' />

                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' tabindex="-1" style="width:120px;" readonly />
                    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Client</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>' onkeydown="getClient(event);" placeholder="Press F3" />
                        <svg class="magnifier-icon" onclick="$('#cldocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="clientdetails" name="clientdetails" value='<s:property value="clientdetails"/>' style="flex:1;" tabindex="-1" readonly />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Salesman</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="salesman" name="salesman" value='<s:property value="salesman"/>' onkeydown="getSalesman(event);" placeholder="Press F3" />
                        <svg class="magnifier-icon" onclick="$('#salesman').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="hidsalesman" name="hidsalesman" value='<s:property value="hidsalesman"/>'>

                    <label class="lbl-right" style="width:80px;">LPO No</label>
                    <input type="text" id="lpono" name="lpono" value='<s:property value="lpono"/>' style="width:120px;" />

                    <label class="lbl-right" style="width:80px;">LPO Date</label>
                    <div style="width: 120px;">
                        <div id="lpodate" name="lpodate" value='<s:property value="lpodate"/>'></div>
                    </div>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Hire Mode</label>
                    <select name="cmbhiremode" id="cmbhiremode" style="width:125px;">
                        <option value="">--Select--</option>
                        <option value="Daily">Daily</option>
                        <option value="Weekly">Weekly</option>
                        <option value="Monthly">Monthly</option>
                    </select>
                    <input type="hidden" id="hidcmbhiremode" name="hidcmbhiremode" value='<s:property value="hidcmbhiremode"/>'>

                    <label class="lbl-right" style="width:80px;">Hire From Date</label>
                    <div style="width: 120px;">
                        <div id="hirefromdate" name="hirefromdate" value='<s:property value="hirefromdate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px;">Description</label>
                    <input type="text" id="desc" name="desc" value='<s:property value="desc"/>' style="flex:1;" />
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Charges & Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Delivery Charges</label>
                    <input type="text" id="delcharges" name="delcharges" value='<s:property value="delcharges"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id),funCalTotal();" />

                    <label class="lbl-right" style="width:110px;">Collection Charges</label>
                    <input type="text" id="collcharges" name="collcharges" value='<s:property value="collcharges"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id),funCalTotal();" />

                    <label class="lbl-right" style="width:100px;">Service Charges</label>
                    <input type="text" id="srvcharges" name="srvcharges" value='<s:property value="srvcharges"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id),funCalTotal();" />

                    <label class="lbl-right" style="width:80px; margin-left:auto;">VAT Amount</label>
                    <input type="text" id="vatamt" name="vatamt" value='<s:property value="vatamt"/>' style="width:100px; text-align:right;" readonly tabindex="-1" />

                    <label class="lbl-right" style="width:50px;">Total</label>
                    <input type="text" id="totalamt" name="totalamt" value='<s:property value="totalamt"/>' style="width:100px; text-align:right; font-weight:bold; color:#0b45a2;" readonly tabindex="-1" />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Delivery Remark</label>
                    <input type="text" id="delremark" name="delremark" value='<s:property value="delremark"/>' style="flex:1;" />
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Service Desc.</label>
                    <input type="text" id="srvdesc" name="srvdesc" value='<s:property value="srvdesc"/>' style="flex:1;" />
                    <button type="button" class="myButton" id="btnloadquote" style="margin-left: 10px;">Load Quote</button>
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
                <input type="hidden" id="hidtaxperc"/>
            </div>

        </div>

        <div id="equipwindow"><div></div></div>
        <div id="tariffwindow"><div></div></div>
        <div id="clientwindow"><div></div></div>
        <div id="salwindow"><div></div></div>
        <div id="qotwindow"><div></div></div>
    </form> 
</div>  

<script type="text/javascript">
    $(document).ready(function(){
        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
        $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        $("#lpodate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        $("#hirefromdate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});

        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#date, #lpodate, #hirefromdate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#date, #lpodate, #hirefromdate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

        $('#equipwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#equipwindow').jqxWindow('close');
        $('#tariffwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Tariff Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#tariffwindow').jqxWindow('close');
        $('#clientwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#clientwindow').jqxWindow('close');
        $('#qotwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Quote Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#qotwindow').jqxWindow('close');
        $('#salwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#salwindow').jqxWindow('close');
        
        $('#date').on('change', function (event) {
            var maindate = $('#date').jqxDateTimeInput('getDate');
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
                funDateInPeriod(maindate);
                getTaxper($("#date").jqxDateTimeInput('val'));
            }
        });
        
        $('#cldocno,#clientdetails').dblclick(function(){
            if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
                $('#clientwindow').jqxWindow('open');
                innerWindowSearchContent('clientMasterSearch.jsp','clientwindow');
            }               
        });
        
        $('#salesman').dblclick(function(){
            if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
                $('#salwindow').jqxWindow('open');
                innerWindowSearchContent('salesmanSearchGrid.jsp?id=1','salwindow');
            }               
        });
        
        $('#refno').dblclick(function(){
            if (($("#mode").val() == "A" || $("#mode").val() == "E") && $('#cmbreftype').val()=='QOT') { 
                if($('#cldocno').val()==''){
                    $.messager.alert('Warning','Please Select Client');
                    $("#cldocno").focus();
                    return false;
                }
                $('#qotwindow').jqxWindow('open');
                innerWindowSearchContent('quoteMasterSearch.jsp','qotwindow');
            }               
        });
        
        $('#btnloadquote').click(function(){
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
                if($('#cmbreftype').val()=='DIR'){
                    $.messager.alert('Warning','Please Select Quotation');
                    $("#cmbreftype").focus();
                    return false;
                }
                if($('#cmbreftype').val()==''){
                    $.messager.alert('Warning','Please Select Quotation');
                    $("#refno").focus();
                    return false;
                }
                if($('#cmbhiremode').val()==''){
                    $.messager.alert('Warning','Please Select Hire mode');
                    $("#cmbhiremode").focus();
                    return false;
                }
                var quoteno=$('#hidrefno').val();
                var hiremode=$('#cmbhiremode').val();
                $('#rentalcontractgriddiv').load('rentalContractGrid.jsp?quoteno='+quoteno+'&hiremode='+hiremode+'&id=2');
            }
        });
    });
    
    function getTaxper(date){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function(){
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                $('#hidtaxperc').val(items);
            }
        }
       x.open("GET", "getTaxper.jsp?date="+date, true);
       x.send();
    }
    
    function getReqRefData(reqrefno){
        $.get('getReqRefData.jsp',{'refno':reqrefno},function(data){
            data=JSON.parse(data);
            if(data.errorstatus=="1"){
                $.messager.alert('Warning','Cannot find approved quotes');
                return false;
            }
            else{
                $('#cldocno').val(data.cldocno);
                $('#clientdetails').val(data.clientdetails);
                $('#refno').val(data.refno);
                $('#cmbreftype').val(data.reftype);
                $('#salesman').val(data.salesman);
                $('#hidsalesman').val(data.salid);
                $('#delcharges').val(data.delcharges);
                $('#collcharges').val(data.collcharges);
                $('#vatamt').val(data.vatamt);
                $('#totalamt').val(data.totalamt);
                $('#desc').val(data.description);
                $('#delremark').val(data.delremark);
                $('#srvcharges').val(data.srvcharges);
                $('#srvdesc').val(data.srvdesc);
                $('#hidrefno').val(data.hidrefno);
                $('#date').jqxDateTimeInput('setDate',new Date());
                getTaxper($('#date').jqxDateTimeInput('val'));
            }
            
        });
    }
    
    function isNumber(evt,id) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
            $.messager.alert('Warning','Enter Numbers Only');
            $("#"+id+"").focus();
            return false;
        }
        return true;
    }
    
    function getClient(event){
        if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
            var x= event.keyCode;
            if(x==114){
                $('#cldocno').dblclick();
            }
        }
    }
    
    function getQuote(event){
        if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
            var x= event.keyCode;
            if(x==114){
                $('#refno').dblclick();
            }
        }
    }
    
    function getSalesman(event){
        if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
            var x= event.keyCode;
            if(x==114){
                $('#salesman').dblclick();
            }
        }
    }
    
    function funCalTotal(){
        if($('#mode').val()=='A' || $('#mode').val()=='E'){
            var delcharges=$.isNumeric($("#delcharges").val())?parseFloat($("#delcharges").val()):0;
            var collcharges=$.isNumeric($("#collcharges").val())?parseFloat($("#collcharges").val()):0;
            var srvcharges=$.isNumeric($("#srvcharges").val())?parseFloat($("#srvcharges").val()):0;
            var vatperc=parseFloat($('#hidtaxperc').val());         
            
            var tot=(delcharges+collcharges+srvcharges).toFixed(2);
            var vatamt = (parseFloat(tot)*(vatperc/100)).toFixed(2);
            var totalamt = (parseFloat(tot) + parseFloat(vatamt)).toFixed(2);
            $("#vatamt").val(vatamt)
            $("#totalamt").val(totalamt)
        }
    }
    
    function innerWindowSearchContent(url,windowid){
        $.get(url).done(function (data) {
            $('#'+windowid).jqxWindow('setContent', data);
        });
    }
    
    function funReadOnly(){
        $('#frmRentalContract input').attr('readonly', true);
        $('#date').jqxDateTimeInput({'disabled':true});
        var reqid='<%=id%>';
        if(reqid=="3"){
            var reqbrhid='<%=brhid%>';
            $("#brchName").val(reqbrhid);
            var reqrefno='<%=refno%>';
            funCreateBtn();
            getReqRefData(reqrefno);
        }
    }
    
    function funRemoveReadOnly(){
        $('#frmRentalContract input').attr('readonly', false);
        $('#docno,#vocno,#cldocno,#clientdetails,#vatamt,#totalamt').attr('readonly', true);
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
        getTaxper($("#date").jqxDateTimeInput('val'));
    }
    
    function funNotify(){
        if($('#cldocno').val()==''){
            document.getElementById("errormsg").innerText="Client is mandatory";
            return 0;
        }
        if($('#cmbhiremode').val()==''){
            document.getElementById("errormsg").innerText="Hire Mode is mandatory";
            return 0;
        }
        if($('#cmbreftype').val()=='QOT' && $('#refno').val()==''){
            document.getElementById("errormsg").innerText="Ref No is mandatory";
            return 0;
        }
        if($('#desc').val().length>1000){
            document.getElementById("errormsg").innerText="Description - Max 1000 Chars Only";
            return 0;
        }
        var rows = $("#rentalContractGrid").jqxGrid('getrows');
        var selectedrows = $("#rentalContractGrid").jqxGrid('getselectedrowindexes');
        if(selectedrows.length==0){
            $.messager.alert('Warning','Please select valid rows');
            return 0;
        }
        var gridlength=0;
        for(var i=0 ; i < selectedrows.length ; i++){
            var orgindex=selectedrows[i];
            if(rows[orgindex].subcatid!=null && rows[orgindex].subcatid!="" && rows[orgindex].subcatid!="undefined" && typeof(rows[orgindex].subcatid)!="undefined"){
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "quottest"+i)
                    .attr("name", "quottest"+i)
                    .attr("hidden", "true"); 
     
                newTextBox.val(rows[orgindex].subcatid+" :: "+rows[orgindex].grpid+" :: "+rows[orgindex].tarifdocno+" :: "+rows[orgindex].qty+" :: "+rows[orgindex].hiremode+" :: "+rows[orgindex].subtotal+" :: "+rows[orgindex].maxdiscount+" :: "+rows[orgindex].discount+" :: "+rows[orgindex].total+" :: "+rows[orgindex].vatperc+" :: "+rows[orgindex].vatamt+" :: "+rows[orgindex].nettotal+" :: "+rows[orgindex].flname+" :: "+rows[orgindex].detaildocno);
                newTextBox.appendTo('form'); 
                gridlength++;   
            }
        }
        $('#gridlength').val(gridlength);
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
        if($('#hidcmbreftype').val()!=''){
            $('#cmbreftype').val($('#hidcmbreftype').val());
        }
        if($('#hidcmbhiremode').val()!=''){
            $('#cmbhiremode').val($('#hidcmbhiremode').val());
        }
        if($('#docno').val()!=''){
            var docno=$('#docno').val();
            $('#rentalcontractgriddiv').load('rentalContractGrid.jsp?docno='+docno+'&id=1');
            funCheckEditStatus();
        }
    }
    
    function funCheckEditStatus(){
        var docno=$('#docno').val();
        $.get('checkEditStatus.jsp',{'docno':docno},function(data){
            data=JSON.parse(data);
            if(parseInt(data.status)>0){
                $('#btnEdit').attr('disabled',true);
                document.getElementById("errormsg").innerText="Cannot edit,Invoice Created";
            }
            else{
                $('#btnEdit').attr('disabled',false);
                document.getElementById("errormsg").innerText="";
            }
        });
    }
    
    function funPrintBtn(){
        if (($("#mode").val() == "view") && $("#docno").val()!="") {
            var url=document.URL;
            var reurl=url.split("com/");
            var branch=$('#brchName').val();
            var win= window.open(reurl[0]+"printRentalContract?docno="+document.getElementById("docno").value+"&branch="+branch,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
            
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