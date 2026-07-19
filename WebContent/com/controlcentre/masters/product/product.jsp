<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		//getpmconfig();
		getmastertype();
		getSpecConfig();
		getConfig();
		//getAlterConfig();
		$("#date").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});

		$('#unitsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Unit Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#unitsearchwindow').jqxWindow('close');
		
		$('#deptsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Department Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#deptsearchwindow').jqxWindow('close');
		
		$('#typesearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Type Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#typesearchwindow').jqxWindow('close');
		
		$('#submodelsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Sub Model Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#submodelsearchwindow').jqxWindow('close');
		
		
		$('#catsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Category Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#catsearchwindow').jqxWindow('close');
		
		$('#subcatsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Sub Category Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#subcatsearchwindow').jqxWindow('close');
		
		$('#brandsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '70%',
			title : 'Brand Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#brandsearchwindow').jqxWindow('close');
		$('#suitsearchwindow').jqxWindow({
			width : '80%',
			height : '70%',
			maxHeight : '90%',
			maxWidth : '90%',
			title : 'Brand Search',
			position : {
				x : 100,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#suitsearchwindow').jqxWindow('close');
		
		$('#modelsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Model Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#modelsearchwindow').jqxWindow('close');
		
		
		$('#yomsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Yom Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#yomsearchwindow').jqxWindow('close');
		
		
		$('#spec1searchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Spec Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#spec1searchwindow').jqxWindow('close');
		
		
		$('#spec2searchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Spec Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#spec2searchwindow').jqxWindow('close');
		
		
		$('#spec3searchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Spec Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#spec3searchwindow').jqxWindow('close');
		$('#prodsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Product Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#prodsearchwindow').jqxWindow('close');
		
		$('#txtproducttype').dblclick(function(){
			
			typeFormSearchContent('typeFormSearchGrid.jsp'); 
			
		}); 
		
		$('#txtbrand').dblclick(function(){
			 
			 brandFormSearchContent('brandFormSearchGrid.jsp'); 
		}); 
		
		$('#txtcategory').dblclick(function(){
			
			catFormSearchContent('catFormSearchGrid.jsp'); 
		}); 
		
		
		$('#txtsubcategory').dblclick(function(){
			 
			var catid=document.getElementById("cmbcategory").value;
	   		subCatFormSearchContent('subCatFormSearchGrid.jsp?catid='+catid);
		}); 
		
		
		$('#txtunit').dblclick(function(){
			 
			unitFormSearchContent('unitFormSearchGrid.jsp');  
		}); 
		
		
		$('#textdept').dblclick(function(){
			deptFormSearchContent('deptFormSearchGrid.jsp'); 
		}); 

	});

	function unitSearchContent(url) {
		$('#unitsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#unitsearchwindow').jqxWindow('setContent', data);
			$('#unitsearchwindow').jqxWindow('bringToFront');
		});
	}

	
	function getProdType(event){
    	 var x= event.keyCode;
    	 if(x==114){
    		 typeFormSearchContent('typeFormSearchGrid.jsp');  	 
    		 }
     	 else{
    		 }
           	 }
	
	function typeSearchContent(url) {
		$('#typesearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#typesearchwindow').jqxWindow('setContent', data);
			$('#typesearchwindow').jqxWindow('bringToFront');
		});
	}
	function submodelSearchContent(url) {
		$('#submodelsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#submodelsearchwindow').jqxWindow('setContent', data);
			$('#submodelsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	
	function typeFormSearchContent(url) {
		//alert($('#mode').val());
		$('#typesearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#typesearchwindow').jqxWindow('setContent', data);
			$('#typesearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function getProdBrand(event){
   	 var x= event.keyCode;
   	 if(x==114){
   		 brandFormSearchContent('brandFormSearchGrid.jsp');  	 }
    	 else{
   		 }
          	 }

	function brandSearchContent(url) {
		$('#brandsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#brandsearchwindow').jqxWindow('setContent', data);
			$('#brandsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function suitSearchContent(url) {
		$('#suitsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#suitsearchwindow').jqxWindow('setContent', data);
			$('#suitsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function brandFormSearchContent(url) {
		$('#brandsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#brandsearchwindow').jqxWindow('setContent', data);
			$('#brandsearchwindow').jqxWindow('bringToFront');
		});
	}

	function modelSearchContent(url) {
		$('#modelsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#modelsearchwindow').jqxWindow('setContent', data);
			$('#modelsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function yomSearchContent(url) {
		$('#yomsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#yomsearchwindow').jqxWindow('setContent', data);
			$('#yomsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function spec1SearchContent(url) {
		$('#spec1searchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#spec1searchwindow').jqxWindow('setContent', data);
			$('#spec1searchwindow').jqxWindow('bringToFront');
		});
	}
	
	
	function spec2SearchContent(url) {
		$('#spec2searchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#spec2searchwindow').jqxWindow('setContent', data);
			$('#spec2searchwindow').jqxWindow('bringToFront');
		});
	}
	
	function spec3SearchContent(url) {
		$('#spec3searchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#spec3searchwindow').jqxWindow('setContent', data);
			$('#spec3searchwindow').jqxWindow('bringToFront');
		});
	}
	
	
	function getProdCat(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		 catFormSearchContent('catFormSearchGrid.jsp');  	 }
	    	 else{
	   		 }
	          	 }

	function catFormSearchContent(url) {
		$('#catsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#catsearchwindow').jqxWindow('setContent', data);
			$('#catsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function getProdSubCat(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		 var catid=document.getElementById("cmbcategory").value;
	   		subCatFormSearchContent('subCatFormSearchGrid.jsp?catid='+catid);  	 }
	    	 else{
	   		 }
	          	 }

	function subCatFormSearchContent(url) {
		$('#subcatsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#subcatsearchwindow').jqxWindow('setContent', data);
			$('#subcatsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function getProdUnit(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		unitFormSearchContent('unitFormSearchGrid.jsp');  	 }
	    	 else{
	   		 }
	          	 }

	function unitFormSearchContent(url) {
		$('#unitsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#unitsearchwindow').jqxWindow('setContent', data);
			$('#unitsearchwindow').jqxWindow('bringToFront');
		});
	}
	function prodSearchContent(url) {
		$('#prodsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#prodsearchwindow').jqxWindow('setContent', data);
			$('#prodsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function getProdDept(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		deptFormSearchContent('deptFormSearchGrid.jsp');  	 }
	    	 else{
	   		 }
	          	 }

	function deptFormSearchContent(url) {
		$('#deptsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#deptsearchwindow').jqxWindow('setContent', data);
			$('#deptsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	/* Validations */
	$(function() {
		$('#frmProduct').validate({
			rules : {
				txtproductcode : "required",
				txtproductname : "required",
			/* 	txtbarcode : "required", */
				cmbproducttype : "required",
				cmbbrand : "required",
				cmbcategory : "required",
				cmbsubcategory : "required",
				cmbunit : "required",
				cmbdept : "required"
			},
			messages : {
				txtproductcode : " *",
				txtproductname : " *",
			/* 	txtbarcode : " *", */
				cmbproducttype : " *",
				cmbbrand : " *",
				cmbcategory : " *",
				cmbsubcategory : " *",
				cmbunit : " *",
				cmbdept : " *"
			}
		});
	});

	function funReadOnly() {
		$('#frmProduct input').attr('readonly', true);
		$('#frmProduct input').attr('disabled', true);
		
		$('#hidpricemgt').attr('disabled', false);
		
		$('#cmbstar').attr('disabled', true);
		
		$('#cmbmastertype').attr('disabled', true);
		
		
		
		
		if(document.getElementById("docno").value=="")
			{
			document.getElementById("company").checked = true;
			
			}
		
		
 
			
		$('#date').jqxDateTimeInput({
			disabled : true
		});
		$("#jqxProductGrid").jqxGrid({
			disabled : true
		});
		$("#jqxUomGrid").jqxGrid({
			disabled : true
		});
		$("#jqxSpecGrid").jqxGrid({
			disabled : true
		});
		$("#jqxSuitGrid").jqxGrid({
			disabled : true
		});
		$("#jqxSuitGrid").jqxGrid({
			disabled : true
		});
		
		$("#jqxpmgt").jqxGrid({
			disabled : true
		});
		$("#jqxaltersearch").jqxGrid({
			disabled : true
		}); 
		 
	}
/* function funprddel(){
	$('#docno').attr('disabled', false);
	var docno=document.getElementById("docno").value;

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
		 
			if(parseInt(items)>0)
				{
				$('#frmProduct input').attr('disabled', true);
				$('#frmProduct select').attr('disabled', true);
				 
				exit(0);
			//	alert("34567890-");
				return 0;
				 
				}
			else
				{
				$('#frmProduct input').attr('disabled', false);
				$('#frmProduct select').attr('disabled', false);
				$('#mode').val('D');
				$('#frmProduct').submit();
				
				}
				
				
				
				}
 			 
			} 
		 
		x.open("GET", "deleteproduct.jsp?psrno="+docno, true);
		x.send();
 
} */
	function funRemoveReadOnly() {
	 
	 
 
		$('#hidpricemgt').attr('disabled', false);
		$('#txtproductcode').attr('readonly', false);
		$('#txtproductname').attr('readonly', false);
		$('#txtbarcode').attr('readonly', false);
		$('#frmProduct input').attr('disabled', false);
		$('#cmbmastertype').attr('disabled', false);
		$('#cmbstar').attr('disabled', false);

		$('#date').jqxDateTimeInput({
			disabled : false
		});
		$("#jqxProductGrid").jqxGrid({
			disabled : false
		});
		$("#jqxUomGrid").jqxGrid({
			disabled : false
		});
		$("#jqxpmgt").jqxGrid({
			disabled : false
		});
		 $("#jqxaltersearch").jqxGrid({
			disabled : false
		}); 
		
		$('#docno').attr('readonly', true);

		if ($("#mode").val() == "A") {
			 $('#date').jqxDateTimeInput('setDate', new Date()); 
			$("#jqxUomGrid").jqxGrid('clear');
			$("#jqxUomGrid").jqxGrid('addrow', null, {});
			$("#jqxProductGrid").jqxGrid('clear');
			$("#jqxProductGrid").jqxGrid('addrow', null, {});
			 $("#jqxaltersearch").jqxGrid('clear');
			$("#jqxaltersearch").jqxGrid('addrow', null, {}); 
			
			// pmDiv pricemanagementgrid.jsp
			
			$("#jqxSpecGrid").jqxGrid({
				disabled : false
			});
			$("#jqxSpecGrid").jqxGrid('clear');
			$("#jqxSpecGrid").jqxGrid('addrow', null, {});
			$("#jqxSuitGrid").jqxGrid({
				disabled : false
			});
			$("#jqxSuitGrid").jqxGrid('clear');
			$("#jqxSuitGrid").jqxGrid('addrow', null, {});
			$("#pmDiv").load("pricemanagementgrid.jsp?");
			getpmconfig();
			   
			$("#productDiv").load("productGrid.jsp?chktype="+1);
			
			$("#jqxProductGrid").jqxGrid({
				disabled : false
			});
			
			document.getElementById("company").checked = true;
			document.getElementById("comorbranch").value="1";
		}

	 	if ($("#mode").val() == "E") {
			 
			var docno=document.getElementById("docno").value;
			if(docno>0){
				if(document.getElementById("comorbranch").value=="1")
				{
					$("#productDiv").load("productGrid.jsp?docno="+docno+"&chktype="+1);
				}
			else if(document.getElementById("comorbranch").value=="2")
				{
				$("#productDiv").load("productGrid.jsp?docno="+docno+"&chktype="+2);
				}	
			}
			$("#jqxSuitGrid").jqxGrid({
	  			disabled : false
	  		});
			$("#jqxUomGrid").jqxGrid('addrow', null, {});
			
			if($('#mode').val()=='E')
	        {
	       var rows = $('#jqxUomGrid').jqxGrid('getrows');
	       var rowlength= rows.length;
	       
	       if(rowlength==1){
	   		$('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'unit',$('#txtunit').val());
	           $('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'unitid',$('#cmbunit').val());
	           $('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'fr',1);

	   	  } 
	      }
			
			$("#jqxSpecGrid").jqxGrid('addrow', null, {});
			$("#jqxSuitGrid").jqxGrid('addrow', null, {});
			$("#jqxaltersearch").jqxGrid('addrow', null, {});
		} 
	}

	
	
	
	
	
	
	
	
	function getBrand() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbbrand").html(optionsbrand);
				$('#cmbbrand').val($('#hidcmbbrand').val());
			} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}

	function getModel() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbbrand").html(optionsbrand);
				$('#cmbbrand').val($('#hidcmbbrand').val());
			} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}

	function getConfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');

				var spec = items[0];
				var suit = items[1];

				if (parseInt(spec) == 0) {

					$("#SpecDiv").hide();
					
					
				}
				if (parseInt(suit) == 0) {

					$("#SuitDiv").hide();
					$("#suits").hide();
					
				}

			} else {
			}
		}
		x.open("GET", "getConfig.jsp", true);
		x.send();
	}

	function getSpecConfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');

				document.getElementById("spec1").value = items[0];
				document.getElementById("spec2").value = items[1];
				document.getElementById("spec3").value = items[2];
				document.getElementById("spec4").value = items[3];
				$("#specDiv").load("specGrid.jsp");
			} else {
			}
		}
		x.open("GET", "getSpecConfig.jsp", true);
		x.send();
	}

	function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbcategory").html(optionsbrand);
				$('#cmbcategory').val($('#hidcmbcategory').val());
			} else {
			}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}

	function getType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbproducttype").html(optionsbrand);
				$('#cmbproducttype').val($('#hidcmbproducttype').val());
			} else {
			}
		}
		x.open("GET", "getType.jsp", true);
		x.send();
	}
	function getpmconfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
			var	items = x.responseText.trim();
			 
		  
			if(parseInt(items)==1)
				{
			 
				document.getElementById("hidpricemgt").value=items;
				$("#pricediv").show();
				$("#mtypess").show();
				$("#cmbmastertype").show();
				
				 
				
				chkfoc();
				}
			else
				{
				document.getElementById("hidpricemgt").value="0";
				$("#pricediv").hide();
				$("#mtypess").hide();
				$("#cmbmastertype").hide();
				}
			
	 
			} else {
			}
		}
		x.open("GET", "checkpricemgt.jsp", true);
		x.send();
	}

	function getAlterConfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
			var	items = x.responseText.trim();
			// alert("alter item=="+items);
		  
			if(parseInt(items)==1)
				{
			 
				
				$("#alterinfo").show();

				}
			else
				{
				
				$("#alterinfo").hide();
				
				}
			
	 
			} else {
			}
		}
		x.open("GET", "checkalternativeitem.jsp", true);
		x.send();
	}
	
	
	function getUnit() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbunit").html(optionsbrand);
				$('#cmbunit').val($('#hidcmbunit').val());
			} else {
			}
		}
		x.open("GET", "getUnit.jsp", true);
		x.send();
	}

	function getDept() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbdept").html(optionsbrand);
				$('#cmbdept').val($('#hidcmbdept').val());
			} else {
			}
		}
		x.open("GET", "getdept.jsp", true);
		x.send();
	}
	function getmastertype() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				
				 
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand;
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbmastertype").html(optionsbrand);
				 
				
				if ($('#hidcmbmastertype').val() != "") {
					$('#cmbmastertype').val($('#hidcmbmastertype').val());
				}
				
		
			} else {
			}
		}
		x.open("GET", "getmastertype.jsp", true);
		x.send();
	}

	function getsubCategory(catid) {

		//var catid=$('#cmbcategory').val();

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbsubcategory").html(optionsbrand);
				$('#cmbsubcategory').val($('#hidcmbsubcategory').val());
			} else {
			}
		}
		x.open("GET", "getsubCategory.jsp?id=" + catid, true);
		x.send();
	}

	function funChkButton() {
		/* funReset(); */
	}

	function funSearchLoad(){
		changeContent('masterSearch.jsp', $('#window'));
	}

	function funFocus() {
		document.getElementById("txtproductcode").focus();
	}

	function setValues() {

		
	 
		if ($('#msg').val() != "") {
			
			if(document.getElementById("msg").value.trim()=="Not Deleted" && $('#chkstatus').val()=="5")
				{
				//$('#msg').val('Cannot Delete Product With Stock');
				$.messager.alert('Message', 'Cannot Delete Product With Stock');
				$('#msg').val('');
				$('#mode').val('view');
				funReadOnly();
				
				}
			else if(document.getElementById("msg").value.trim()=="Not Deleted" && $('#chkstatus').val()=="6")
			{
			//$('#msg').val('Cannot Delete Product With Stock');
			$.messager.alert('Message', 'Cannot Delete Product');
			$('#msg').val('');
			$('#mode').val('view');
			funReadOnly();
			
			}
			else
				{
			
			$.messager.alert('Message', $('#msg').val());
				}
		}
		
	/* 	
		if($('#msg').val()=="Cannot Delete Product With Stock")
			{
			$('#msg').val('');
			$('#mode').val('view');
			
			alert("---asdsa-----");
			funReadOnly();
			
			
			} */
		
		if ($('#hidecmbstar').val() != "") {
			$('#cmbstar').val($('#hidecmbstar').val());
		}
			if ($('#hidcmbmastertype').val() != "") {
				$('#cmbmastertype').val($('#hidcmbmastertype').val());
			}
			
	
			
		 
		document.getElementById("formdet").innerText = $('#formdetail').val()
				+ " (" + $('#formdetailcode').val().trim() + ")";
		funSetlabel();
		 
		if(parseInt(document.getElementById("comorbranch").value)==1)
			{
			document.getElementById("company").checked = true;
			}
		else if(parseInt(document.getElementById("comorbranch").value)==2)
			{
			document.getElementById("branch").checked = true;
			}
		 
	
		
		fungridload();
		
		 
		
	}
	
	function fungridload(){
		
		var docno=document.getElementById("docno").value;
		
		if(docno>0){
			
			if(document.getElementById("comorbranch").value=="1")
			{
				$("#productDiv").load("productGrid.jsp?docno="+docno+"&chktype="+1);
			}
		else if(document.getElementById("comorbranch").value=="2")
			{
			$("#productDiv").load("productGrid.jsp?docno="+docno+"&chktype="+2);
			}		
			
		//	$("#pmDiv").load("pricemanagementgrid.jsp");
 	    //$("#pmDiv").load("pricemanagementgrid.jsp?docno="+docno);
		//$("#uomDiv").load("uomGrid.jsp?docno="+docno);
		//$("#SuitDiv").load("suitGrid.jsp?docno="+docno);
		$("#alterDiv").load("alterGrid.jsp?docno="+docno+"&chk=y");
		}
	}

	function funNotify() {

		var prorows = $("#jqxProductGrid").jqxGrid('getrows');
		var uomrows = $("#jqxUomGrid").jqxGrid('getrows');
		var specrows = $("#jqxSpecGrid").jqxGrid('getrows');
		var suitrows = $("#jqxSuitGrid").jqxGrid('getrows');
		var alterrowsk=$('#jqxaltersearch').jqxGrid('getrows');
		document.getElementById("errormsg").innerText ="";
		
		$('#proGridlen').val(prorows.length);
		var j = 0;
		for (var i = 0; i < prorows.length; i++) {
			var dis=0;
			
			if (prorows[i].selects == true) {
				newTextBox = $(document.createElement("input")).attr("type",
						"dil").attr("id", "prod" + j).attr("name", "prod" + j)
						.attr("hidden", "true");
				if (prorows[i].discontinued == true) {
					
					//alert("1");
					
					dis=1;
				}
				newTextBox.val(prorows[i].bdocno + "::" +prorows[i].selects
						+ "::" + dis + "::"
						+ prorows[i].bin+ "::" + prorows[i].minstock + "::"
						+ prorows[i].maxstock+ "::" + prorows[i].retailprice
						+ "::" + prorows[i].wholesale+ "::"
						+ prorows[i].normal+ "::"+prorows[i].reorderlevel+ "::"+prorows[i].reorderqty+ "::");  

				newTextBox.appendTo('form');
				j++;
				$('#proGridlen').val(j);
			}
			
		}
		
		if(j==0){
			document.getElementById("errormsg").innerText ="Select atleast one branch...!!!";
			return 0;
		}
//alter(uomrows[0].unitid);
		if (!((uomrows[0].unitid == "undefined") || (uomrows[0].unitid == null) || (uomrows[0].unitid ==" "))) {
			$('#uomGridlen').val(uomrows.length);
			
			for (var i = 0; i < uomrows.length; i++) {
				//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input")).attr("type",
						"dil").attr("id", "uom" + i).attr("name", "uom" + i)
						.attr("hidden", "true");

				newTextBox.val(uomrows[i].unitid + "::" + uomrows[i].fr + "::"
						+ uomrows[i].weight + "::" + uomrows[i].volumn + "::"
						+ uomrows[i].thickness + "::" + uomrows[i].len
						+ "::" + uomrows[i].width + "::");
/* alert(uomrows[i].unitid + "::" + uomrows[i].fr + "::"
		+ uomrows[i].weight + "::" + uomrows[i].volumn + "::"
		+ uomrows[i].thickness + "::" + uomrows[i].len
		+ "::" + uomrows[i].width + "::"); */
				newTextBox.appendTo('form');

			}
		}

		var g=0;
		for (var i = 0; i < alterrowsk.length; i++) {
			var myvar = alterrowsk[i].psrno;
		if (!((typeof(alterrowsk[i].psrno)=== "undefined") || (alterrowsk[i].psrno == null) || (alterrowsk[i].psrno == ""))) {	 
			//alert("psrno===="+myvar);
			   newTextBox = $(document.createElement("input"))  
			      .attr("type", "dil")
			      .attr("id", "altr"+i)
			      .attr("name", "altr"+i)
			      .attr("hidden", "true");         
			  
			 newTextBox.val(alterrowsk[i].psrno+" :: "+alterrowsk[i].doc_no+" :: ");
			 g=g+1;
		 
			  newTextBox.appendTo('form');
			 
			 }
		//alert("altrgrid===="+g);
		$('#alterGridlen').val(g);
		}
		
		if (!((specrows[0].spec1 == "undefined") || (specrows[0].spec1 == null) || (specrows[0].spec1 == ""))) {
			$('#specGridlen').val(specrows.length);

			for (var i = 0; i < specrows.length; i++) {
				//	var myvar = rows[i].tarif; 
				var barcode=$('#txtbarcode').val()+i;
				alert(barcode);
				newTextBox = $(document.createElement("input")).attr("type",
						"dil").attr("id", "spec" + i).attr("name", "spec" + i)
						.attr("hidden", "true");

				newTextBox.val(specrows[i].spec1 + "::" + specrows[i].spec2
						+ "::" + specrows[i].spec3 + "::" + specrows[i].spec4
						+ "::"+ barcode+ "::");

				newTextBox.appendTo('form');

			}
		}

		if (!((suitrows[0].doc_no == "undefined") || (suitrows[0].doc_no == null) || (suitrows[0].doc_no == ""))) {
			$('#suitGridlen').val(suitrows.length);
			for (var i = 0; i < suitrows.length; i++) {
				//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input")).attr("type",
						"dil").attr("id", "suit" + i).attr("name", "suit" + i)
						.attr("hidden", "true");
				/* suitrows[i].typeid + "::" + */
				
				newTextBox.val( suitrows[i].doc_no
						+ "::"+ suitrows[i].yomfrmid
						+ "::" + suitrows[i].yomtoid + "::"+ suitrows[i].bsize1id + "::"+ suitrows[i].bsize2id + "::"+ suitrows[i].bsize3id + "::"
						+ suitrows[i].csize1id + "::"+ suitrows[i].csize2id + "::"+ suitrows[i].csize3id + "::");

				newTextBox.appendTo('form');

			}
		}

		var rows = $("#jqxpmgt").jqxGrid('getrows');
		   $('#pmgtgridlength').val(rows.length);
		   
		  for(var i=0 ; i < rows.length ; i++){
			  
			  
						   newTextBox = $(document.createElement("input"))  
						      .attr("type", "dil")
						      .attr("id", "pmgt"+i)
						      .attr("name", "pmgt"+i)
						      .attr("hidden", "true");         
						  
						 newTextBox.val(rows[i].catid+"::"+rows[i].price1+" :: "+rows[i].price2+" :: "+rows[i].price3+" :: "  
								   +rows[i].discount1+" :: "+rows[i].discount2+" :: "+rows[i].discount3+" :: "+rows[i].foc1+" ::"+rows[i].foc2+" ::"+rows[i].foc3+" ::"
								   +rows[i].qty1+" ::"+rows[i].qty2+" ::"+rows[i].qty3+" ::");
						
					 
						  newTextBox.appendTo('form');
						  
				   
						 
	 
		   
		  }   
			  
		
		   // doc_no price1 price2 price3 discount1 discount2 discount3 foc1 foc2 foc3
		
		
		
		
		$('#cmbstar').attr('disabled', false);
		document.getElementById("errormsg").innerText = "";
		return 1;

	}
	function funcomorbranch()
        {
		if(document.getElementById("company").checked == true)
			
			{
			document.getElementById("comorbranch").value="1";
			
			$("#productDiv").load("productGrid.jsp?chktype="+1);
			 
			document.getElementById("comorbranch").value="1";
			
			}
		else if(document.getElementById("branch").checked == true)
			{
			$("#productDiv").load("productGrid.jsp?chktype="+2);
			document.getElementById("comorbranch").value="2";
			}
		
		} 
    function chkfoc()
    {
     
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText.trim();
	   
	      if(parseInt(items)==1)
	       {
	     
	    	  
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'foc1');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'foc2');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'foc3');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'qty1');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'qty2');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'qty3');
	    
	    	  
	    	  
	        }
	          else
	      {
	      
	        	 
	         	  $('#jqxpmgt').jqxGrid('hidecolumn', 'foc1');
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'foc2');
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'foc3');
    	    	  
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'qty1');
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'qty2');
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'qty3');
	      
	      }
	      
	       }}
	   x.open("GET","checkfoc.jsp?",true);
		x.send();
	 
	      
	        
    	
    }
	      
</script>

<style>
/* =========================================================
   SCOPED UI: Modern Layout Adapted for Table Structure
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

#frmProduct input[type="text"],
#frmProduct select,
.textbox { 
    height: 24px !important; 
    width: 100% !important;
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    box-shadow: none !important;
    outline: none;
}

#frmProduct input[type="text"]:focus,
#frmProduct select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmProduct input[readonly],
#frmProduct input:disabled,
#frmProduct select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.myButton, .btn {
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
    display: inline-block;
    box-sizing: border-box;
}

.myButton:hover, .btn:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Grid Containers */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* JQX Widget Overrides for 24px Alignment */
.jqx-datetimeinput-input { 
    height: 24px !important; 
    line-height: 24px !important; 
    margin-top: 0px !important; 
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
}
.jqx-action-button {
    height: 24px !important;
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

.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: nowrap; /* Prevent wrapping */
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0;
}

.modern-ui .input-search-container {
    position: relative;
    display: flex;
    flex-shrink: 0;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
    width: 100%;
    box-sizing: border-box;
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
</style>

</head>
<div class='modern-ui hidden-scrollbar'>
    
    <!-- General Info Header -->
    <div class="field-row" style="background: #f8f9fa; padding: 10px; border-radius: 4px; border: 1px solid #c5d3e0;">
        <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
        <div style="width: 125px; flex-shrink:0;">
            <div id="date" name="date" value='<s:property value="date"/>'></div> 
            <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>' />
        </div>
        
        <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left:auto;">Doc No</label>
        <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' readonly style="width:150px; flex-shrink:0;" />
    </div>

    <div style="display: flex; gap: 15px; margin-bottom: 15px;">
        <!-- Left Panel: Product Details -->
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Product Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px; flex-shrink:0;">Product Code</label>
                <input type="text" id="txtproductcode" name="txtproductcode" value='<s:property value="txtproductcode"/>' style="width:120px; flex-shrink:0;" />
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px; flex-shrink:0;">Product Name</label>
                <input type="text" id="txtproductname" name="txtproductname" value='<s:property value="txtproductname"/>' style="flex:1; min-width:0;" />
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px; flex-shrink:0;">Bar Code</label>
                <input type="text" id="txtbarcode" name="txtbarcode" value='<s:property value="txtbarcode"/>' style="width:120px; flex-shrink:0;" />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px; flex-shrink:0;">Star</label>
                <select name="cmbstar" id="cmbstar" value='<s:property value="cmbstar"/>' style="width:60px; flex-shrink:0;">
                    <option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option>
                </select>
                
                <label class="lbl-right" id="mtypess" style="width:60px; flex-shrink:0; margin-left:15px;">Type</label> 
                <select name="cmbmastertype" id="cmbmastertype" value='<s:property value="cmbmastertype"/>' style="width:120px; flex-shrink:0;">
                    <option></option>
                </select>
            </div>
        </div>

        <!-- Right Panel: Categorization -->
        <div class="middle-panel" style="flex: 1.2; margin-bottom: 0;">
            <span class="middle-panel-title">Categorization</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px; flex-shrink:0;">Product Type</label>
                <div class="input-search-container" style="width: 150px; flex-shrink:0;">
                    <input type="text" id="txtproducttype" name="txtproducttype" placeholder="Press F3" readonly="true" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' />
                    <svg class="magnifier-icon" onclick="typeFormSearchContent('typeFormSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="lbl-right" style="width:100px; flex-shrink:0; margin-left:auto;">Brand</label>
                <div class="input-search-container" style="width: 150px; flex-shrink:0;">
                    <input type="text" id="txtbrand" name="txtbrand" placeholder="Press F3" readonly="true" onKeyDown="getProdBrand(event);" value='<s:property value="txtbrand"/>' />
                    <svg class="magnifier-icon" onclick="brandFormSearchContent('brandFormSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px; flex-shrink:0;">Category</label>
                <div class="input-search-container" style="width: 150px; flex-shrink:0;">
                    <input type="text" id="txtcategory" name="txtcategory" placeholder="Press F3" readonly="true" onKeyDown="getProdCat(event);" value='<s:property value="txtcategory"/>' />
                    <svg class="magnifier-icon" onclick="catFormSearchContent('catFormSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="lbl-right" style="width:100px; flex-shrink:0; margin-left:auto;">Sub Category</label>
                <div class="input-search-container" style="width: 150px; flex-shrink:0;">
                    <input type="text" id="txtsubcategory" name="txtsubcategory" placeholder="Press F3" readonly="true" onKeyDown="getProdSubCat(event);" value='<s:property value="txtsubcategory"/>' />
                    <svg class="magnifier-icon" onclick="var catid=document.getElementById('cmbcategory').value; subCatFormSearchContent('subCatFormSearchGrid.jsp?catid='+catid);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px; flex-shrink:0;">Unit</label>
                <div class="input-search-container" style="width: 150px; flex-shrink:0;">
                    <input type="text" id="txtunit" name="txtunit" placeholder="Press F3" readonly="true" onKeyDown="getProdUnit(event);" value='<s:property value="txtunit"/>' />
                    <svg class="magnifier-icon" onclick="unitFormSearchContent('unitFormSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>

                <label class="lbl-right" style="width:100px; flex-shrink:0; margin-left:auto;">Department</label>
                <div class="input-search-container" style="width: 150px; flex-shrink:0;">
                    <input type="text" id="textdept" name="textdept" placeholder="Press F3" readonly="true" onKeyDown="getProdDept(event);" value='<s:property value="textdept"/>' />
                    <svg class="magnifier-icon" onclick="deptFormSearchContent('deptFormSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
        </div>
    </div>

    <!-- Custom Cost Labels row -->
    <div class="field-row" style="margin-bottom: 15px; padding: 10px; border-radius: 4px; border: 1px solid #c5d3e0; background: #fdfdfd; justify-content: center; gap: 20px;">
        <div style="display:flex; gap:8px;">
            <b><label id="stdcostname" name="stdcostname" style="font-size: 13px; font-family: Tahoma; color:#6000FC;"><s:property value="stdcostname"/> </label></b>   
            <b><label id="stdcostprice" name="stdcostprice" style="font-size: 13px; font-family: Tahoma; color:#a03838;"><s:property value="stdcostprice"/> </label></b>
        </div>
        <div style="display:flex; gap:8px;">
            <b><label id="fixname" name="fixname" style="font-size: 13px; font-family: Tahoma; color:#6000FC;"><s:property value="fixname"/> </label></b> 
            <b><label id="fixprices" name="fixprices" style="font-size: 13px; font-family: Tahoma; color:#a03838;"><s:property value="fixprices"/> </label></b>
        </div>
        <div style="display:flex; gap:8px;">
            <b><label id="lbrcostname" name="lbrcostname" style="font-size: 13px; font-family: Tahoma; color:#6000FC;"><s:property value="lbrcostname"/> </label></b>
            <b><label id="lbrcosts" name="lbrcosts" style="font-size: 13px; font-family: Tahoma; color:#a03838;"><s:property value="lbrcosts"/> </label></b>
        </div>
    </div>

    <!-- Permissions Grid -->
    <div class="middle-panel">
        <span class="middle-panel-title">Permissions</span>
        <div class="field-row">
            <label style="display:flex; align-items:center; gap:4px; margin-right:15px; cursor:pointer;">
                <input type="radio" id="company" name="chkbrorcom" value="" onchange="funcomorbranch()" style="margin:0; width:auto!important; height:auto!important;"> Company
            </label>
            <label style="display:flex; align-items:center; gap:4px; cursor:pointer;">
                <input type="radio" id="branch" name="chkbrorcom" value="" onchange="funcomorbranch()" style="margin:0; width:auto!important; height:auto!important;"> Branch  
            </label>
        </div>
        <div id="productDiv" class="grid-container">
            <jsp:include page="productGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Price Management -->
    <div id="pricediv" class="middle-panel">
        <span class="middle-panel-title">Price Management</span>
        <div id="pmDiv" class="grid-container"> 
            <jsp:include page="pricemanagementgrid.jsp"></jsp:include>
        </div>
    </div>
    
    <!-- UOM -->
    <div class="middle-panel">
        <span class="middle-panel-title">UOM</span>
        <div id="uomDiv" class="grid-container">
            <jsp:include page="uomGrid.jsp"></jsp:include>
        </div>
    </div>
         
    <!-- Alternative Item -->
    <div id="alterinfo" class="middle-panel">
        <span class="middle-panel-title">Alternative Item</span>
        <div id="alterDiv" class="grid-container">
            <jsp:include page="alterGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Specification -->
    <div id="SpecDiv" class="middle-panel">
        <span class="middle-panel-title">Specification</span>
        <div class="grid-container">
            <jsp:include page="specGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Suitability -->
    <div id="suits" class="middle-panel">
        <span class="middle-panel-title">Suitability</span>
        <div id="SuitDiv" class="grid-container">
            <jsp:include page="suitGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="hidden" id="spec1" name="spec1" value='<s:property value="spec1"/>' /> 
        <input type="hidden" id="spec2" name="spec2" value='<s:property value="spec2"/>' />
        <input type="hidden" id="spec3" name="spec3" value='<s:property value="spec3"/>' /> 
        <input type="hidden" id="spec4" name="spec4" value='<s:property value="spec4"/>' />
        <input type="hidden" id="cmbproducttype" name="cmbproducttype" value='<s:property value="cmbproducttype"/>' />
        <input type="hidden" id="cmbbrand" name="cmbbrand" value='<s:property value="cmbbrand"/>' />
        <input type="hidden" id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>' />
        <input type="hidden" id="cmbsubcategory" name="cmbsubcategory" value='<s:property value="cmbsubcategory"/>' />
        <input type="hidden" id="cmbunit" name="cmbunit" value='<s:property value="cmbunit"/>' />
        <input type="hidden" id="cmbdept" name="cmbdept" value='<s:property value="cmbdept"/>' />
        <input type="hidden" id="hidcmbmastertype" name="hidcmbmastertype" value='<s:property value="hidcmbmastertype"/>' />
        <input type="hidden" id="specGridlen" name="specGridlen" value='<s:property value="specGridlen"/>' /> 
        <input type="hidden" id="proGridlen" name="proGridlen" value='<s:property value="proGridlen"/>' /> 
        <input type="hidden" id="suitGridlen" name="suitGridlen" value='<s:property value="suitGridlen"/>' /> 
        <input type="hidden" id="uomGridlen" name="uomGridlen" value='<s:property value="uomGridlen"/>' />
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' />
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        <input type="hidden" id="hidspec1id" name="hidspec1id" value='<s:property value="hidspec1id"/>' />
        <input type="hidden" id="hidspec2id" name="hidspec2id" value='<s:property value="hidspec2id"/>' />
        <input type="hidden" id="hidspec3id" name="hidspec3id" value='<s:property value="hidspec3id"/>' />
        <input type="hidden" id="hidsuitid" name="hidsuitid" value='<s:property value="hidsuitid"/>' />
        <input type="hidden" id="alterGridlen" name="alterGridlen" value='<s:property value="alterGridlen"/>' />
        <input type="hidden" id="hidecmbstar" name="hidecmbstar" value='<s:property value="hidecmbstar"/>' />
        <input type="hidden" id="pmgtgridlength" name="pmgtgridlength" value='<s:property value="pmgtgridlength"/>' />
        <input type="hidden" id="comorbranch" name="comorbranch" value='<s:property value="comorbranch"/>' />
        <input type="hidden" id="hidpricemgt" name="hidpricemgt" value='<s:property value="hidpricemgt"/>' /> 
    </div>

</div>
</html>