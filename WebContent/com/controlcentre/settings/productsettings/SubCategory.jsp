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
		$('#btnSearch').attr('disabled', true);
		
		/* Formatted jqxDateTimeInput heights to match modern UI 24px */
		$("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue' });  
 
		/* Force internal alignment AFTER render */
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
 
		document.getElementById("formdet").innerText="SubCategory(SCAT)";
		document.getElementById("formdetail").value="SubCateGory";
		document.getElementById("formdetailcode").value="SCAT";
		window.parent.formCode.value="SCAT";
		window.parent.formName.value="SubCateGory";
		
		var data= '<%=DAO.prdsubcategoryLoad(session) %>';
		var num = 0; 
		var source = {
			datatype: "json",
			datafields: [
				{name : 'doc_no' , type: 'int' },
				{name : 'subcategory', type: 'String'  },
				{name : 'date', type: 'date'  },
				{name : 'category',type:'String'},
				{name : 'catid',type:'String'}
			],
			localdata: data,
			pager: function (pagenum, pagesize, oldpagenum) {}
		};
          
		var dataAdapter = new $.jqx.dataAdapter(source, {
			loadError: function (xhr, status, error) {
				alert(error);    
			}
		});
  
		$("#jqxCategory").jqxGrid({
			width: '100%',
			height: 350,
			source: dataAdapter,
			showfilterrow: true,
			filterable: true,
			selectionmode: 'multiplecellsextended',
			sortable: true,
			altrows:true,
			columns: [
				{ text: 'Doc No', filtertype: 'number', datafield: 'doc_no', width: '15%' },
				{ text: 'Sub Cateogry', columntype: 'textbox', filtertype: 'input', datafield: 'subcategory', width: '30%' },
				{ text: 'Date', columntype: 'textbox', filtertype: 'input', datafield:'date', width: '15%', cellsformat:'dd.MM.yyyy'},
				{ text: 'Category', columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '40%' }
			]
		});

		$('#jqxCategory').on('rowdoubleclick', function (event) {
			var rowindex1=event.args.rowindex;
			document.getElementById("docno").value= $('#jqxCategory').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
			document.getElementById("subcat").value = $("#jqxCategory").jqxGrid('getcellvalue', rowindex1, "subcategory");
			$('#frmsubCategory select').attr('disabled', false);
			$('#date').jqxDateTimeInput({disabled: false});
			$("#date").jqxDateTimeInput('val',$("#jqxCategory").jqxGrid('getcellvalue', rowindex1, "date"));
			$('#category').val($("#jqxCategory").jqxGrid('getcellvalue', rowindex1, "catid")) ;
			$('#frmsubCategory select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
		}); 
		
		$("#jqxCategory").jqxGrid('hidecolumn', 'brandid'); 
	});

	function funSearchLoad(){
		changeContent('modelSearch.jsp', $('#window')); 
	}

	function funReadOnly() {
		$('#frmsubCategory input').attr('readonly', true);
		$('#frmsubCategory select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmsubCategory input').attr('readonly', false);
		$('#frmsubCategory select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
	}

	function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">' + brandItems[i] + '</option>';
				}
				$("select#category").html(optionsbrand);
				if ($('#hidtest').val() != null) {
					$('#category').val($('#hidtest').val());
				}
			}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}
	
	function funFocus(){
		document.getElementById("subcat").focus();
	}
	
	$(function(){
		$('#frmsubCategory').validate({
			rules: {
				brand: { required: true },
				model: { required: true, maxlength: 20 }
			},
			messages: {
				brand: { required: " *" },
				model: { required: " *", maxlength: "max 20 chars" }
			}
		});
	});
	
	function funNotify(){
		return 1;
	} 
	     
	function setValues() {
		if ($('#brandid').val() != null) {
			$('#category').val($('#catid').val());
		}
		if($('#msg').val()!=""){
			$.messager.alert('Message',$('#msg').val());
		}
	}
</script>
</head>
<body onload="getCategory();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmsubCategory" action="savepscmAction" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <div class="middle-panel">
            <span class="middle-panel-title">Sub Category Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly tabindex="-1" style="width:120px;" />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Category</label>
                <select name="category" id="category" style="width:125px;">
                </select>
                
                <label class="lbl-right" style="width:100px;">Sub Category</label>
                <input type="text" name="subcat" id="subcat" value='<s:property value="subcat"/>' style="flex:1;" />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Existing Sub Categories</span>
            <div class="grid-container">
                <div id="jqxCategory"></div>
            </div>
        </div>

        <!-- Hidden Fields -->
        <div style="display:none;">
            <input type="text" id="catid" name="catid" value='<s:property value="catid"/>' />
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
            <input type="hidden" id="hidtest" name="hidtest" value='<s:property value="hidtest"/>' />
        </div>

    </div>
</form>
</div>
</body>
</html>