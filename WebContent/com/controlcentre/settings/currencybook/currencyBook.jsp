<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Currency Book</title>
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
    $(document).ready(function () { 
        /* Formatted height to match modern UI 24px standard */
        $("#jqxCurrencyBookDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy"});
        
        /* Force internal alignment AFTER render */
		setTimeout(function () {
		     $("#jqxCurrencyBookDate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxCurrencyBookDate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		}, 0);
    	  
        /* Searching Window */
        $('#currencyWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Currency Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#currencyWindow').jqxWindow('close');
    });
      
    function CurrencySearchContent(url) {
        $('#currencyWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#currencyWindow').jqxWindow('setContent', data);
            $('#currencyWindow').jqxWindow('bringToFront');
        }); 
    } 
      
    function getBaseCurrency(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                items= x.responseText;
                items=items.split('####');
                $('#txtbasecurId').val(items[0]);
                $('#txtbasecurrency').val(items[1]);
            }
        }
        x.open("GET", "getBaseCurrency.jsp", true);
        x.send();
    }
      
    function funReadOnly(){
        $('#frmCurrencyBook input').attr('readonly', true );
        $('#jqxCurrencyBookDate').jqxDateTimeInput({disabled: true});
        $("#jqxCurrencyBook").jqxGrid({ disabled: true});
    }

    function funRemoveReadOnly(){
        getBaseCurrency();
        $('#frmCurrencyBook input').attr('readonly', true );
        $('#jqxCurrencyBookDate').jqxDateTimeInput({disabled: false});
        $("#jqxCurrencyBook").jqxGrid({ disabled: false});
  		
        if ($("#mode").val() == "A") {
            $("#jqxCurrencyBook").jqxGrid('clear');
            $("#currencyBookDiv").load("currencyBookGrid.jsp?check=1");
        }  
    }

    function funSearchLoad(){
        /* changeContent('opnMainSearch.jsp', $('#window')); */  
    }

    function funChkButton(){
        /* funReset(); */
    }

    function funFocus(){
        $('#jqxCurrencyBookDate').jqxDateTimeInput('focus'); 
    }

    function funNotify(){	
        /* Currency Grid Saving */
        var rows = $("#jqxCurrencyBook").jqxGrid('getrows');
        var length=0;
        for(var i=0 ; i < rows.length ; i++){
            var chk=rows[i].curid;
            if(typeof(chk) != "undefined"){
                length=length+1;
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "test"+i)
                    .attr("name", "test"+i)
                    .attr("hidden", "true");
                newTextBox.val(rows[i].curid+"::"+rows[i].c_rate+":: "+rows[i].type+":: "+rows[i].description);
                newTextBox.appendTo('form');
            }
        }
        $('#gridlength').val(length);
        /* Currency Grid Saving Ends */
        return 1;
    } 

    function setValues(){
        if($('#hidjqxCurrencyBookDate').val()){
            $("#jqxCurrencyBookDate").jqxDateTimeInput('val', $('#hidjqxCurrencyBookDate').val());
        }
        
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
  	  
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel(); 
  	 
        var indexVal = document.getElementById("txtbasecurId").value;
        if(indexVal>0){
            $("#currencyBookDiv").load("currencyBookGrid.jsp?check=1&disable=1");
        } 
    }
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCurrencyBook" action="saveCurrencyBook">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">Currency Info</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxCurrencyBookDate" name="jqxCurrencyBookDate" value='<s:property value="jqxCurrencyBookDate"/>'></div>
                <input type="hidden" id="hidjqxCurrencyBookDate" name="hidjqxCurrencyBookDate" value='<s:property value="hidjqxCurrencyBookDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:120px; margin-left: 20px;">Base Currency</label>
            <input type="text" id="txtbasecurrency" name="txtbasecurrency" style="width:80px;" tabindex="-1" readonly value='<s:property value="txtbasecurrency"/>'/>
            <input type="hidden" id="txtbasecurId" name="txtbasecurId" value='<s:property value="txtbasecurId"/>'/>
        </div>
    </div>

    <div class="middle-panel" style="padding-bottom: 20px;">
        <span class="middle-panel-title">Currency Rates</span>
        <div id="currencyBookDiv" class="grid-container">
            <jsp:include page="currencyBookGrid.jsp"></jsp:include>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
    </div>

</div>
</form>

<div id="currencyWindow"><div></div><div></div></div>

</div>
</body>
</html>