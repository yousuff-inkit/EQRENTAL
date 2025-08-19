 
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<style type="text/css">
.icons {
	width: 2.5em;
	height: 2em;
	border: none;
 background-color: #E0ECF8;
}



input[type=text]::-webkit-search-cancel-button {
    -webkit-appearance: searchfield-cancel-button;
}


.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#ptypewindow').jqxWindow({ width: '30%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#ptypewindow').jqxWindow('close');
		   $('#brandwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#brandwindow').jqxWindow('close');
		   $('#modelwindow').jqxWindow({ width: '30%',height: '62%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#modelwindow').jqxWindow('close');
		   $('#submodelwindow').jqxWindow({ width: '30%',height: '62%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#submodelwindow').jqxWindow('close');
		   $('#productwindow').jqxWindow({ width: '50%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close');
		   $('#pcategorywindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pcategorywindow').jqxWindow('close');
		   $('#pdeptwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pdeptwindow').jqxWindow('close');
		   $('#psubcategorywindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#psubcategorywindow').jqxWindow('close');
 
		   
		   $("#btngenate").attr('disabled', true );
		   $("#cmbtype").attr('disabled', true );
		 
		      
			   
			   
});
 
	
 

	 
function getPtype(){
	 
 	  $('#ptypewindow').jqxWindow('open');
		$('#ptypewindow').jqxWindow('focus');
		typeSearchContent('typeSearch.jsp', $('#ptypewindow'));

}


function getPbrand(t){
	 
	  $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		brandSearchContent('brandSearch.jsp?id='+t, $('#brandwindow'));

}

function getPmodel(t){
	
	var brandid=$('#hidsbrandid').val().trim();
	
	if(brandid==""){
		 $.messager.alert('Message','Select Brand','warning');
		 
		 return 0;
	 }
	
	  $('#modelwindow').jqxWindow('open');
	  $('#modelwindow').jqxWindow('focus');
		 modelSearchContent('modelSearch.jsp?id='+t+'&brandid='+brandid, $('#modelwindow'));

}

function getSubmodel(){
	
	var brandid=$('#hidsbrandid').val().trim();
	var modelid=$('#hidsmodelid').val().trim();
	
	if(brandid==""){
		 $.messager.alert('Message','Select Brand','warning');
		 
		 return 0;
	 }
	
	if(modelid==""){
		 $.messager.alert('Message','Select Model','warning');
		 
		 return 0;
	 }
	
	  $('#submodelwindow').jqxWindow('open');
	  $('#submodelwindow').jqxWindow('focus');
	  subModelSearchContent('SubModelSearch.jsp?modelid='+modelid+'&brandid='+brandid, $('#submodelwindow'));

}




function getPcategory(){

	  $('#pcategorywindow').jqxWindow('open');
		$('#pcategorywindow').jqxWindow('focus');
		 categorySearchContent('catSearch.jsp', $('#pcategorywindow'));
}

function getDept(){

	  $('#pdeptwindow').jqxWindow('open');
		$('#pdeptwindow').jqxWindow('focus');
		 deptSearchContent('deptSearch.jsp', $('#pdeptwindow'));
}


function getPsubcategory(){
	var catid=$('#hidcatid').val().trim();
	 $('#psubcategorywindow').jqxWindow('open');
		$('#psubcategorywindow').jqxWindow('focus');
		 subcategorySearchContent('subcatSearch.jsp?catid='+catid, $('#psubcategorywindow'));

}


function getProduct(){
	
	var brandid=$('#hidbrandid').val().trim();
	var catid=$('#hidcatid').val().trim();
	var subcatid=$('#hidsubcatid').val().trim();
	
	 $('#productwindow').jqxWindow('open');
		$('#productwindow').jqxWindow('focus');
		 productSearchContent('productSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid, $('#productwindow'));

}

function getSpec1(){
	
	$('#spec1window').jqxWindow('open');
	$('#spec1window').jqxWindow('focus');
	 spec1SearchContent('spec1Search.jsp', $('#spec1window'));
}

function getSpec2(){

	$('#spec2window').jqxWindow('open');
	$('#spec2window').jqxWindow('focus');
	 spec2SearchContent('spec2Search.jsp', $('#spec2window'));

}
function getSpec3(){

	$('#spec3window').jqxWindow('open');
	$('#spec3window').jqxWindow('focus');
	 spec3SearchContent('spec3Search.jsp', $('#spec3window'));

}
 
function getSuit(){
	
	 $('#suitsearchwindow').jqxWindow('open');
		$('#suitsearchwindow').jqxWindow('focus');
		suitSearchContent('suitSearch.jsp', $('#suitsearchwindow'));
}

function suitSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#suitsearchwindow').jqxWindow('setContent', data);

	}); 
	}
	

function typeSearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#ptypewindow').jqxWindow('setContent', data);

}); 
}
function brandSearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#brandwindow').jqxWindow('setContent', data);

}); 
}

function modelSearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#modelwindow').jqxWindow('setContent', data);

}); 
}

function subModelSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#submodelwindow').jqxWindow('setContent', data);

	}); 
	}

function categorySearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#pcategorywindow').jqxWindow('setContent', data);

}); 
}

function deptSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#pdeptwindow').jqxWindow('setContent', data);

	}); 
	}

function subcategorySearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#psubcategorywindow').jqxWindow('setContent', data);

}); 
}

function spec1SearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#spec1window').jqxWindow('setContent', data);

}); 
}

function spec2SearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#spec2window').jqxWindow('setContent', data);

	}); 
	}
	
function spec3SearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#spec3window').jqxWindow('setContent', data);

	}); 
	}

 

function productSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#productwindow').jqxWindow('setContent', data);

	}); 
	}



function funExportBtn(){
	   $("#partSearchgrid").jqxGrid('exportdata', 'xls', 'PartList');
	 }


function setprodSearch(){
	var value=$('#prodsearchby').val().trim();

	if(value=="ptype"){
		getPtype();
	}
	else if(value=="pbrand"){
		getPbrand(2);
	}
	else if(value=="pdept"){
		getDept();
	}
	else if(value=="product"){
		getProduct();
	}
	else if(value=="pcategory"){
		getPcategory();
	}
	else if(value=="psubcategory"){
		getPsubcategory();
	}
	
	
	else{
		
	}
}

function setsuitSearch(){
	var value=$('#suitsearchby').val().trim();
	//alert(value);
	if(value=="suit"){
		getSuit();
	}
	 if(value=="sbrand"){
		getPbrand(1);
	}
	else if(value=="smodel"){
		getPmodel(1);
	}
	else if(value=="submodel"){
		getSubmodel();
	}
	else if(value=="syom"){
		getYom();
	}
	else if(value=="spec1"){
		getSpec1();
	}
	else if(value=="spec2"){
		getSpec2();
	}
	else if(value=="spec3"){
		getSpec3();
	}
	else{
		
	}
}


function funreload(event)
{

	  var cal="";
 
	$('#gridtype').val(1);
	
	var suitvalue="";
	var prodvalue=$('#prodsearchby').val().trim();
	var type;
 
	type="1";
 
	var hidsbrand;
	var hidsmodel;
	var hidyom;
	var hidspec1;
	var hidspec2;
	var hidspec3;
	var branchid;
	var hidbrand;
	var hidtype;
	var hidproduct;
	var hidcat;
	var hidsubcat;
	
	 branchid=document.getElementById("cmbbranch").value;
	/* if(type=="1"){ */
		
  $("#btngenate").attr('disabled', true );
  $("#cmbtype").attr('disabled', true );
		
		 hidbrand=document.getElementById("hidbrandid").value;
		 hidtype=document.getElementById("hidtypeid").value;
		 hidproduct=document.getElementById("hidproductid").value;
		 hidcat=document.getElementById("hidcatid").value;
		 hidsubcat=document.getElementById("hidsubcatid").value;
		 hidept=document.getElementById("hideptid").value;
		 
		  
	 $("#overlay, #PleaseWait").show();
		var load="load";
		
	 
	$("#searchdiv").load("productGrid.jsp?type="+type+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&load=load");	
	
}

function funClearData(){
		
	 document.getElementById("hidsbrandid").value="";
	 document.getElementById("hidsmodelid").value="";
	 document.getElementById("hidyomid").value="";
	 document.getElementById("hidspec1id").value="";
	 document.getElementById("hidspec2id").value="";
	 document.getElementById("hidspec3id").value="";
	 document.getElementById("hidbrandid").value="";
	 document.getElementById("hidtypeid").value="";
	 document.getElementById("hidproductid").value="";
	 document.getElementById("hidcatid").value="";
	 document.getElementById("hidsubcatid").value=""; 
	 document.getElementById("hidsbrand").value="";
	 document.getElementById("hidsmodel").value="";
	 document.getElementById("hidyom").value="";
	 document.getElementById("hidspec1").value="";
	 document.getElementById("hidspec2").value="";
	 document.getElementById("hidspec3").value="";
	 document.getElementById("hidbrand").value="";
	 document.getElementById("hidtype").value="";
	 document.getElementById("hidproduct").value="";
	 document.getElementById("hidcat").value="";
	 document.getElementById("hidsubcat").value="";
 
	 document.getElementById("prodsearchby").value="";
	 document.getElementById("searchdetails").value="";
	 document.getElementById("hideptid").value="";
	 document.getElementById("hidept").value="";
	 document.getElementById("cmbbranch").value="a";
	 
	 
 
 		 
  
	
}
function setRemove(){
	
	var suitvalue="";
	var prodvalue=$('#prodsearchby').val().trim();
	
	if(prodvalue=="ptype"){
		 
		 document.getElementById("hidtypeid").value="";
		 document.getElementById("hidtype").value="";
		 
	}
	else if(prodvalue=="pbrand"){
		document.getElementById("hidbrandid").value="";
		document.getElementById("hidproduct").value="";
		
	}
	else if(prodvalue=="product"){
		document.getElementById("hidproductid").value="";
		document.getElementById("hidbrand").value="";
	}
	else if(prodvalue=="pcategory"){
		 document.getElementById("hidcatid").value="";
		 document.getElementById("hidcat").value="";
		 
	}
	else if(prodvalue=="psubcategory"){
		document.getElementById("hidsubcatid").value="";
		document.getElementById("hidsubcat").value="";
	}
	else if(prodvalue=="pdept"){
		document.getElementById("hideptid").value="";
		document.getElementById("hidept").value="";
	}
	
	if(suitvalue=="sbrand"){
		 document.getElementById("hidsbrandid").value="";
		 document.getElementById("hidsbrand").value="";
		 
	}
	else if(suitvalue=="smodel"){
		document.getElementById("hidsmodelid").value="";
		document.getElementById("hidsmodel").value="";
		
	}
	else if(suitvalue=="syom"){
		document.getElementById("hidyomid").value="";
		 document.getElementById("hidyom").value="";
		 
	}
	
	else if(suitvalue=="spec1"){
		document.getElementById("hidspec1id").value="";
		document.getElementById("hidspec1").value="";
		 
	}
	else if(suitvalue=="spec2"){
		document.getElementById("hidspec2id").value="";
		document.getElementById("hidspec2").value="";
		 
	}
	else if(suitvalue=="spec3"){
		document.getElementById("hidspec3id").value="";
		document.getElementById("hidspec3").value="";
	}
	document.getElementById("searchdetails").value="";
	
	if(document.getElementById("hidsbrand").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsbrand").value;	
	}
	if(document.getElementById("hidsmodel").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsmodel").value;	
	}
	if(document.getElementById("hidyom").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidyom").value;	
	}
	if(document.getElementById("hidspec1").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec1").value;	
	}
	if(document.getElementById("hidspec2").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec2").value;	
	}
	if(document.getElementById("hidspec3").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec3").value;	
	}
	if(document.getElementById("hidbrand").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidbrand").value;	
	}
	if(document.getElementById("hidtype").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidtype").value;	
	}
	if(document.getElementById("hidcat").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidcat").value;	
	}
	if(document.getElementById("hidsubcat").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsubcat").value;	
	}
	if(document.getElementById("hidproduct").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidproduct").value;	
	}
	if(document.getElementById("hidept").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidept").value;	
	}
}


 
	
 
	   
	   
		function hidebranch()
		{
			
			 
 
			  $("#branchdiv").hide();
			  $("#branchlabel").hide();
			 
		}
		function funGenerate()
		{
			
		 
				  	  
			  	   var url=document.URL;

			         var reurl=url.split("barcodegenerator.jsp");
			         
			         
		 
		
			 var win= window.open(reurl[0]+"printBarcode?docno="+document.getElementById("psrno").value+"&cmbtype="+document.getElementById("cmbtype").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			 win.focus();
			  	    
		
		}
	
		
		
</script>
</head>
<body onload="getBranch();hidebranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmbarcode" action="Barcodes" autocomplete="OFF" >     


<div class='hidden-scrollbar'>
 
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
    <!--   <tr>
       <td colspan="2">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rdall" name="rdo" value="rdall"><label for="rdall" class="branch">All</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" id="rdsummary" name="rdo" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
       </tr>
    
 <tr><td colspan="2" align="center"><button type="button" id="btnsearch" name="btnsearch" onClick="getSuit();" class="myButton">Suitability Main Search</button></td></tr>	
	 -->
	 <tr><td><input type="hidden" id="gridtype"></td></tr>
<%-- 	<tr>
	  <td width="24%" align="right"><label class="branch">Suitability</label></td>
	  <td width="76%"  align="left"><select name="suitsearchby" id="suitsearchby" style="width:52%;">
<option value="">--Select--</option>
	 
     <option value="sbrand">BRAND</option>
    <option value="smodel">MODEL</option>
    <option value="submodel">SUB MODEL</option>
    <option value="syom">YOM</option>
    <option value="spec1">BEDSIZE</option>
     <option value="spec2">ENGINESIZE</option>
      <option value="spec3">CABINSIZE</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setsuitSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr> --%>

 	
	  
      <tr >
	  <td align="right"><label class="branch">PRODUCT</label></td>
	  <td  align="left"><select name="prodsearchby" id="prodsearchby" style="width:52%;"> 
    <option value="">--Select--</option>
    <option value="ptype">TYPE</option>
    <option value="pbrand">BRAND</option>
    <option value="pdept">DEPARTMENT</option>
    <option value="pcategory">CATEGORY</option>
    <option value="psubcategory">SUB CATEGORY</option>
    <option value="product">PRODUCT</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setprodSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr>
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="15"  readonly></textarea></td>
	  </tr>
	  
	 
	<tr >
	<td colspan="2"  ><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
    </td>
	</tr>
	  <tr><td colspan="2">   
<fieldset><legend><b>Generate</b></legend>
		    <table width="100%" >
		      <tr><td align="right"  width="20%"><label class="branch">Type</label></td><td width="80%"> <select id="cmbtype" name="cmbtype"   style="width:90%;" >
		      <option value="small">SMALL</option>
		       <option value="large">LARGE</option>
		      
		      </select> </td></tr>
		       
	  <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		        <tr >
	<td colspan="2"  align="center">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btngenate" id="btngenate" value="Generate Barcode" class="myButton" onclick="funGenerate();">
    </td>
	</tr>
	</table></fieldset>
	
	</td></tr>
		       	 
		    <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>  
		            <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		              <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		          
	</table>
	</fieldset>
	
</td>
<td width="80%">
	<table width="100%">
		<tr>
		<td>		<div id="searchdiv"><jsp:include page="productGrid.jsp"></jsp:include></div>
			 
			 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  
		 
			  
			  
 			  
			  <input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidmodelid" id="hidmodelid">
			  <input type="hidden" name="hidyomid" id="hidyomid">
			  <input type="hidden" name="hidspec1id" id="hidspec1id">
			  <input type="hidden" name="hidspec2id" id="hidspec2id">
			  <input type="hidden" name="hidspec3id" id="hidspec3id">
			  <input type="hidden" name="hidsubmodelid" id="hidsubmodelid">
			  
              <input type="hidden" name="hidsubmodel" id="hidsubmodel">
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidmodel" id="hidmodel">
			  <input type="hidden" name="hidyom" id="hidyom">
			  <input type="hidden" name="hidspec1" id="hidspec1">
			  <input type="hidden" name="hidspec2" id="hidspec2">
			  <input type="hidden" name="hidspec3" id="hidspec3">  
			  
			  <input type="hidden" name="hidsbrandid" id="hidsbrandid">
			  <input type="hidden" name="hidsmodelid" id="hidsmodelid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  
   			  <input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidsbrand" id="hidsbrand">
			  <input type="hidden" name="hidsmodel" id="hidsmodel">
			   <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  
			  <input type="hidden" name="hidproduct" id="hidproduct">
			  
			  
			   <input type="hidden" name="psrno" id="psrno">
			  
			  
			  
			  
			   
			 </td>
			  
		</tr>
	</table>
</tr>
</table>

 <div id="ptypewindow">
<div></div>
</div>
<div id="brandwindow">
<div></div>
</div>
<div id="modelwindow">
<div></div>
</div>
<div id="submodelwindow">
<div></div>
</div>
<div id="productwindow">
<div></div>
</div>
<div id="pcategorywindow">
<div></div>
</div>
<div id="pdeptwindow">
<div></div>
</div>
<div id="psubcategorywindow">
<div></div>
</div>
 
</div>
</form>
</div>
 
</body>

</html>