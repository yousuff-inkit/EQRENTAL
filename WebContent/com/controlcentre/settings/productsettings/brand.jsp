<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<%@page import="com.controlcentre.settings.productsettings.productmaster.ClsProductMasterDAO"%>
<% ClsProductMasterDAO DAO= new ClsProductMasterDAO(); %>
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

form label.error {
    color: red;
    font-weight: bold;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {    
	    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
	    $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue' });
	    
	    /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#date").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#date").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

	    $('#btnSearch').attr('disabled', true);
	    document.getElementById("formdet").innerText="Brand(BRD)";
		document.getElementById("formdetail").value="Brand";
		document.getElementById("formdetailcode").value="BRD";
		window.parent.formCode.value="BRD";
		window.parent.formName.value="Brand";
 		
 		var databrand= '<%=DAO.prdbrandLoad(session)%>';
        var num = 0; 
        var source = {
            datatype: "json",
            datafields: [
                {name : 'doc_no' , type: 'number' },
     			{name : 'brandname', type: 'String'  },
     			{name : 'desc1', type: 'String'  },
                {name : 'date', type: 'date'  }
            ],
            localdata: databrand,
            pager: function (pagenum, pagesize, oldpagenum) {}
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source, {
            loadError: function (xhr, status, error) {}
		});
    
        $("#jqxBrandSearch1").jqxGrid({
            width: '100%',
            source: dataAdapter,
            showfilterrow: true,
            filterable: true,
            selectionmode: 'multiplecellsextended',
            columns: [
        	    { text: 'DOC NO', datafield: 'doc_no', width: '8%' },
        		{ text: 'BRAND', columntype: 'textbox', filtertype: 'input', datafield: 'brandname', width: '28%' },
        		{ text: 'BRAND DESCRIPTION', columntype: 'textbox', filtertype: 'input', datafield: 'desc1', width: '45%' },
        		{ text: 'DATE', columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '19%', cellsformat:'dd.MM.yyyy' }
        	]
        });
        
        $('#jqxBrandSearch1').on('rowdoubleclick', function (event) {
            var rowindex1=event.args.rowindex;
            document.getElementById("docno").value= $('#jqxBrandSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
            document.getElementById("brand").value = $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "brandname");
            document.getElementById("branddesc").value = $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "desc1");
            $("#date").jqxDateTimeInput('val', $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
        }); 
    });

	function funSearchLoad(){
		changeContent('brandSearch.jsp', $('#window')); 
	}
	
	function funReadOnly() {
		$('#frmBrand input').attr('readonly', true);
		$('#date').jqxDateTimeInput({ readonly : true });
	}
	
	function funRemoveReadOnly() {
		$('#frmBrand input').attr('readonly', false);
		$('#date').jqxDateTimeInput({ readonly : false });
		$('#docno').attr('readonly', true);
	}

	function setValues() {
		if($('#datehidden').val()){
			$("#date").jqxDateTimeInput('val', $('#date').val());
		}
		if($('#msg').val()!=""){
			$.messager.alert('Message',$('#msg').val());
		}
	}
	
	$(function(){
	    $('#frmBrand').validate({
	        rules: {
	            brand: {
	                required:true,
	                maxlength:40
	            }
	        },
	        messages: {
	            brand: {
	                required:" *",
	                maxlength:"max 40 only"
	            } 
	        }
	    });
	});
	
	function funNotify(){
	    return 1;
	} 
	
	function funFocus(){
	    document.getElementById("brand").focus();
	}
</script>  
</head>

<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmBrand" action="savepbmAction" method="get" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
    
        <div class="middle-panel">
            <span class="middle-panel-title">Product Brand Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="date" name="date"></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:120px;" />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Brand</label>
                <input type="text" name="brand" id="brand" value='<s:property value="brand"/>' style="width:125px;" />
                
                <label class="lbl-right" style="width:100px;">Description</label>
                <input type="text" id="branddesc" name="branddesc" value='<s:property value="branddesc"/>' style="flex:1;" />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Existing Brands</span>
            <div class="grid-container">
                <div id="jqxBrandSearch1"></div>  
            </div>
        </div>
        
        <!-- Hidden Fields -->
        <div style="display:none;">
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        </div>

    </div>

</form>
</div>
</body>
</html>