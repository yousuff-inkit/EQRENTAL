<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

form {
    height: 100%;
    width: 100%;
    margin: 0;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.release-filter-table input[type="text"],
.release-filter-table select {
    width: 100%;
    height: 24px;             
    padding: 2px 8px;         
    border: 1px solid #ccd6e0;
    border-radius: 4px;       
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

/* Textarea styling */
.search-textarea {
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    padding: 6px;
    font-size: 11px;
    background-color: #f3f6f9;
    resize: none;
    margin-top: 10px;
    font-family: 'Segoe UI', Tahoma, sans-serif;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100%;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    font-size: 12px;
    color: #333;
    padding: 5px 0 15px 0;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-weight: 600;
}
.radio-group input[type="radio"] {
    margin-right: 4px;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

.release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

/* Inline action flex */
.inline-action-row {
    display: flex;
    gap: 5px;
}
.inline-action-row select {
    flex: 1;
}
.btn-icon {
    width: 30px;
    height: 24px;
    line-height: 24px;
    padding: 0;
    text-align: center;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
/* 	   document.getElementById("rdomonthwise").disabled=true;
	   document.getElementById("rdomonthwise").style.display="none";
	   document.getElementById("lblmonthwise").style.display="none"; */
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	   $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:520px;'><img src='../../../../icons/31load.gif'/></div>");
	   $('#maingrids').hide();
 	   $('#maingrid').show();
	   $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy" });
	   $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy" });
	   $('#clientwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#clientsearchwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientsearchwindow').jqxWindow('close');
	   $('#salesagentwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sales Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#salesagentwindow').jqxWindow('close');
	   $('#rentalagentwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#rentalagentwindow').jqxWindow('close');
	   $('#brandwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   
	   $('#fleetwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	    $('#fleetwindow').jqxWindow('close');
	    
	    $('#mtypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Maintenance Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	    $('#mtypewindow').jqxWindow('close');
	    
	   $('#yomwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#yomwindow').jqxWindow('close');
	   $('#chartwindow').jqxWindow({ width: '52%',height: '65%',  maxHeight: '65%'  ,maxWidth: '52%' , title: 'Chart' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
	   $('#chartwindow').jqxWindow('close');
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
      
});


function getClient(){
	 
   	  $('#clientsearchwindow').jqxWindow('open');
 		$('#clientsearchwindow').jqxWindow('focus');
 		 clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));
  
}


function getClientcat(){
	 
  	  $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 clientcatSearchContent('clientCatSearch.jsp?id=1', $('#clientwindow'));
 
}

function getSalesAgent(){
	
	  $('#salesagentwindow').jqxWindow('open');
		$('#salesagentwindow').jqxWindow('focus');
		 salesagentSearchContent('salesAgentSearch.jsp?id=1', $('#salesagentwindow'));

}

function getRentalAgent(){

	  $('#rentalagentwindow').jqxWindow('open');
		$('#rentalagentwindow').jqxWindow('focus');
		 rentalagentSearchContent('rentalAgentSearch.jsp?id=1', $('#rentalagentwindow'));
}


function getBrand(){
	 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));

}


function getFleet()
{

	 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		fleetSearchContent('fleetSearch.jsp?id=1', $('#brandwindow'));
	
	}

function getModel(){
	
	 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 modelSearchContent('modelSearch.jsp?id=1', $('#brandwindow'));

}

function getGroup(event){

	$('#groupwindow').jqxWindow('open');
	$('#groupwindow').jqxWindow('focus');
	 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));

}
function getYom(event){

	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}
function getMtype()
{

	 $('#mtypewindow').jqxWindow('open');
		$('#mtypewindow').jqxWindow('focus');
		mtypeSearchContent('mtypeSearch.jsp?id=1', $('#mtypewindow'));
	
	}
	
function mtypeSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
    	  $('#mtypewindow').jqxWindow('open');
//alert(data);
    $('#mtypewindow').jqxWindow('setContent', data);

}); 
}
	
function fleetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
    	  $('#fleetwindow').jqxWindow('open');
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
	
	
function clientcatSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientsearchwindow').jqxWindow('setContent', data);

}); 
}

function salesagentSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#salesagentwindow').jqxWindow('setContent', data);

}); 
}

function rentalagentSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#rentalagentwindow').jqxWindow('setContent', data);

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

function groupSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#groupwindow').jqxWindow('setContent', data);

}); 
}

function yomSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#yomwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
/* 	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate')); */
	//alert(dateval);
	/* if(dateval==1){ */

  /*    if(document.getElementById("hidrdobetweendates").value=="0" && document.getElementById("hidrdomonthwise").value=="0"){
    	 $.messager.alert('Warning','Monthwise/Period is Mandatory');
    	 return false;
     } */
     
     var branch=document.getElementById("cmbbranch").value;
     var fromdate=$('#fromdate').jqxDateTimeInput('val');
     var todate=$('#todate').jqxDateTimeInput('val');
     var grpby1=document.getElementById("grpby1").value;
     //var hidclientcat=document.getElementById("hidclientcat").value;
     // var hidclient=document.getElementById("hidclient").value;
     // var hidsalesman=document.getElementById("hidsalesman").value;
     // var hidrentalagent=document.getElementById("hidrentalagent").value;
     var hidbrand=document.getElementById("hidbrand").value;
     var hidmodel=document.getElementById("hidmodel").value;
     // var hidgroup=document.getElementById("hidgroup").value;
     var hidyom=document.getElementById("hidyom").value;
     
     var hidfleet=document.getElementById("hidfleet").value;
     
     var hidmtype=document.getElementById("hidmtype").value;
     
     var distribution=document.getElementById("distribution").value;
     
     var searchdetails=document.getElementById("searchdetails").value;
     var radiotype = "";
	 
	 if(document.getElementById("rdsummary").checked==true){
		 radiotype = $('#rdsummary').val();
	 }else if(document.getElementById("rddetail").checked==true){
		 radiotype = $('#rddetail').val();
	 }
     
       if(grpby1=="" && distribution=="" )
    	   {
    	   
    /* 	   if(searchdetails=="")
    		   {
 
    		   $("#overlay, #PleaseWait").show();
    	   		// $('#distributiondiv').hide();
    	    		$('#maingrid').show();
    	   		 $("#maingrid").load("ListGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidyom="+hidyom+"&hidfleet="+hidfleet+"&id=1");	 
    	    	   
    		   }
    	   else{ */
    		   
    		 
    		   $("#overlay, #PleaseWait").show();
    	   	   $('#maingrids').hide();
    	 	   $('#distributiondiv').hide();
    	       $('#maingrid').show();
    	    	
    	    		
    	   		 $("#maingrid").load("ListGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidyom="+hidyom+"&hidfleet="+hidfleet+"&hidmtype="+hidmtype+"&radiotype="+radiotype+"&id=1");	 
    	    	   
    	    	    
    		   
    	      /*    } */
    	   
    	
    	   
    	   }
     
       else if(grpby1!="" && distribution=="" ){
    	   
    	 
    	   $("#overlay, #PleaseWait").show();
    	 
	    		$('#maingrid').hide();
	    		$('#distributiondiv').hide();
	    	  	$('#maingrids').show();
   
  	      
  	      
  	    $("#maingrids").load("groupinggrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidyom="+hidyom+"&hidfleet="+hidfleet+"&hidmtype="+hidmtype+"&id=1");
    	   
    	   
    	   
       }
       
       else if(distribution!="")
       {
    	   
    	   
    	   if(grpby1=="")
    		   {
    		   
    		   $.messager.alert('Warning','Grouping is Mandatory');
 		    	return false;
    		   
    		   
    		   }
    	   
    	   
    	 
       		if($('#distribution').val()=='quarterwise'){
       			var d1=$('#fromdate').jqxDateTimeInput('getDate');
          		 var d2=$('#todate').jqxDateTimeInput('getDate');
          		 months = (d2.getFullYear() - d1.getFullYear()) * 12;
          		    months -= d1.getMonth() + 1;
          		    months += d2.getMonth();
          		    months=months <= 0 ? 0 : months;
          		  
          		    if(months<2){
          		    	$.messager.alert('Warning','Quarterwise must contain minimum 3 months');
          		    	return false;
          		    }
          		 	
       		}
    	   
    	   
    	   var cmbfrequency='';
    	   
    	  if(distribution=='monthwise'){
    	    	 cmbfrequency='2';
    	     }
    	     else if(distribution=='quarterwise'){
    	    	 cmbfrequency='3';
    	     }
    	     else if(distribution=='yearwise'){
    	    	 cmbfrequency='4';
    	     }
    	  $("#overlay, #PleaseWait").show();
    		$('#maingrid').hide();
    		$('#distributiondiv').show();
    	  	 $('#maingrids').hide();
    	   
    	   $("#distributiondiv").load("monthwisegrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidyom="+hidyom+"&hidfleet="+hidfleet+"&hidmtype="+hidmtype+"&cmbfrequency="+cmbfrequency+"&id=1");  
       }
       
       
  //    
/*      var cmbfrequency='';
     if(distribution=='branchwise'){
    	 cmbfrequency='1';
     }
     else if(distribution=='monthwise'){
    	 cmbfrequency='2';
     }
     else if(distribution=='quarterwise'){
    	 cmbfrequency='3';
     }
     else if(distribution=='yearwise'){
    	 cmbfrequency='4';
     }
     else if(distribution=='clientcat'){
    	 cmbfrequency='5';
     }
     else if(distribution=='salesman'){
    	 cmbfrequency='6';
     }
     else if(distribution=='rentalagent'){
    	 cmbfrequency='7';
     }
     else if(distribution=='brand'){
    	 cmbfrequency='8';
     }
     else if(distribution=='model'){
    	 cmbfrequency='9';
     }
     else if(distribution=='group'){
    	 cmbfrequency='10';
     }
     else if(distribution=='yom'){
    	 cmbfrequency='11';
     }
     else{
    	 
    	 
     } */
/*      if(document.getElementById("grpby1").value==document.getElementById("distribution").value && (document.getElementById("grpby1").value!='' && document.getElementById("distribution").value!='')){
    	 $.messager.alert('Warning','Grouping and Distribution cannot be Same');
    	 document.getElementById("distribution").focus();
    	 return false;
     } */
     
   /*   if(document.getElementById("hidrdobetweendates").value=="1"){ */
    	 
    	/*  if($('#distribution').val()!=''){ */
    	/* 	if($('#distribution').val()=='quarterwise'){
    			var d1=$('#fromdate').jqxDateTimeInput('getDate');
       		 var d2=$('#todate').jqxDateTimeInput('getDate');
       		 months = (d2.getFullYear() - d1.getFullYear()) * 12;
       		    months -= d1.getMonth() + 1;
       		    months += d2.getMonth();
       		    months=months <= 0 ? 0 : months;
       		    
       		    if(months<3){
       		    	$.messager.alert('Warning','Quarterwise must contain minimum 3 months');
       		    	return false;
       		    }
       		 	
    		}
    		    $("#overlay, #PleaseWait").show();
    		$('#distributiondiv').show();
    		$('#maingrid').hide();
    		 $("#distributiondiv").load("salesMonthwiseGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&distribution="+cmbfrequency+"&check=1&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidrentalagent="+hidrentalagent);
    	 } */
    /* 	 else{ */
    		// $("#overlay, #PleaseWait").show();
    		// $('#distributiondiv').hide();
     	//	$('#maingrid').show();
    		// $("#maingrid").load("ListGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidyom="+hidyom+"&hidfleet="+hidfleet+"&id=1");	 
    	/*  }
    	  
     }

	} */
	}
	

	function setValues(){

/* 		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		 var value=document.getElementById("rdobetweendates").value;
		 document.getElementById("rdobetweendates").checked=true;
		 setType(value);
		 document.getElementById("rdobetweendates").style.display="none";
		 document.getElementById("lblbetweendates").style.display="none"; */
	 
	}
		function funExportBtn(){
		 
	     var branch=document.getElementById("cmbbranch").value;
	     
	     var grpby1=document.getElementById("grpby1").value;
	    
	    
	     
	     var distribution=document.getElementById("distribution").value;
	     
	     var searchdetails=document.getElementById("searchdetails").value;
	     
	     
	     
	       if(grpby1=="" && distribution=="" )
    	   {
    	   
 		   
	  		 if(parseInt(window.parent.chkexportdata.value)=="1")
			  {
	  			JSONToCSVCon(mainexceldata, 'Maintenance Analysis', true);
			  }
			 else
			  {
		    	   $("#alllistgrid").jqxGrid('exportdata', 'xls', 'Maintenance Analysis');  
		    }
    	   

	    	//   
	    	   
	      	
    	   
    	   }
     
       else if(grpby1!="" && distribution=="" ){
    	   
     
  	        	   

    	//   
    	   if(parseInt(window.parent.chkexportdata.value)=="1")
			  {
    		   JSONToCSVCon(groupingexceldata, 'Maintenance Analysis', true); 
			  }
			 else
			  {
		    	   $("#groupgrid").jqxGrid('exportdata', 'xls', 'Maintenance Analysis');  	
		    	}

    	   
       }
       
       else if(distribution!="")
       {
    	   
    	   
     	   
    	  //$("#distributionGrid").jqxGrid('exportdata', 'xls', 'Maintenance Analysis');  
    	 //  
   	   if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
   		JSONToCSVCon(data, 'Maintenance Analysis', true); 
		  }
		 else
		  {
	    	  $("#distributionGrid").jqxGrid('exportdata', 'xls', 'Maintenance Analysis');  
	    	}
 
     
       }
	     
	     
	     
	     
	     
		
	}
	function setType(value){
		/* if(value=="dates"){
			$('#fromdate').jqxDateTimeInput({disabled:false});
			$('#todate').jqxDateTimeInput({disabled:false});
			document.getElementById("hidrdobetweendates").value="1";
			document.getElementById("hidrdomonthwise").value="0";
		}
		else if(value=="monthwise"){
			if($('#fromdate').jqxDateTimeInput('disabled')==false){
				$('#fromdate').jqxDateTimeInput({disabled:true});
				$('#todate').jqxDateTimeInput({disabled:true});
				document.getElementById("hidrdobetweendates").value="1";
				document.getElementById("hidrdomonthwise").value="0";
			
			}
		}
		else{
			
			document.getElementById("hidrdobetweendates").value="0";
			document.getElementById("hidrdomonthwise").value="0";
		} */
	}
		
	
	function funClearData(){
		document.getElementById("rdsummary").checked=true;
		$('input[type=text],[type=hidden]').val('');
	//	$('input[type=radio]').prop("checked", false);
		$('textarea').val('');
		$('#distribution').val('');
		
		$('#grpby1').val('');
		$('#searchby').val('');
	}
	function setSearch(){
		var value=$('#searchby').val().trim();
 
		 
         if(value=="brand"){
			getBrand();
		}
		else if(value=="model"){
			getModel();
		}
		 
		else if(value=="yom"){
			getYom();
		}
		else if(value=="fleet"){
			getFleet();
		}
		else if(value=="mtype"){
			getMtype();
		}
		
		else{
			
		}



	}
	
	
	function setRemove(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="fleet"){  
			
			document.getElementById("searchdetails").value="";
			document.getElementById("fleet").value="";
			document.getElementById("hidfleet").value="";
			
		}
		if(value=="brand"){
			document.getElementById("searchdetails").value="";
			document.getElementById("brand").value="";
			document.getElementById("hidbrand").value="";
		}
		
		if(value=="model"){
			document.getElementById("searchdetails").value="";
			document.getElementById("model").value="";
			document.getElementById("hidmodel").value="";
		}
		if(value=="yom"){
			document.getElementById("searchdetails").value="";
			document.getElementById("yom").value="";
			document.getElementById("hidyom").value="";
		}
		if(value=="mtype"){
			document.getElementById("searchdetails").value="";
			document.getElementById("mtype").value="";
			document.getElementById("hidmtype").value="";
		}
		 
		
		if(document.getElementById("fleet").value!=""){
			
		var	text = document.getElementById("fleet").value.split("::").join("\n");
			
			document.getElementById("searchdetails").value+="\n\n"+text;	
		}
		if(document.getElementById("brand").value!=""){
			
			
			var	text = document.getElementById("brand").value.split("::").join("\n");
			
			document.getElementById("searchdetails").value+="\n\n"+text;	
			 
		}
		
		
	if(document.getElementById("model").value!=""){
			
			
			var	text = document.getElementById("model").value.split("::").join("\n");
			
			document.getElementById("searchdetails").value+="\n\n"+text;	
			 
		}
	
	if(document.getElementById("yom").value!=""){
			
			
			var	text = document.getElementById("yom").value.split("::").join("\n");
			
			document.getElementById("searchdetails").value+="\n\n"+text;	
			 
		}
	
	if(document.getElementById("mtype").value!=""){
		
		
		var	text = document.getElementById("mtype").value.split("::").join("\n");
		
		document.getElementById("searchdetails").value+="\n\n"+text;	
		 
	}
	
	}
function getChart(){
/* 	var grpby1=document.getElementById("grpby1").value;
	if(grpby1==""){
		$.messager.alert('warning','Please Select a Grouping');
		return false;
	}
	if(grpby1=="client"){
		$.messager.alert('warning','Client cannot be shown on chart');
		return false;
	}  
	  
	$('#chartwindow').jqxWindow('open');
	$('#chartwindow').jqxWindow('focus');
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
    var branch=document.getElementById("cmbbranch").value;
    chartSearchContent('chartSearch.jsp?id=1&grpby1='+grpby1+'&fromdate='+fromdate+'&todate='+todate+'&branch='+branch, $('#chartwindow'));
	 $("#loadingImage").css({ "display": "block", "left":280, "top": 200}); */
}

function chartSearchContent(url) {
 
/*       $.get(url).done(function (data) {
 
    $('#chartwindow').jqxWindow('setContent', data);

});  */
}

</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" method="post" style="height: 100%;">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">

                        <!-- Hidden Fields from old layout setup -->
                        <input type="hidden" name="hidrdobetweendates" id="hidrdobetweendates">
                        <input type="hidden" name="hidrdomonthwise" id="hidrdomonthwise">

                        <div class="radio-group">
                            <label for="rdsummary">
                                <input type="radio" id="rdsummary" name="rdo" checked="checked" value="RS">
                                Summary
                            </label>
                            <label for="rddetail">
                                <input type="radio" id="rddetail" name="rdo" value="RD">
                                Detail
                            </label>
                        </div>

                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">From Date</td>
                                <td><div id="fromdate"></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To Date</td>
                                <td><div id="todate"></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">Grouping</td>
                                <td>
                                    <select name="grpby1" id="grpby1">
                                        <option value="">--Select--</option>
                                        <option value="fleetno">Fleet No</option> 
                                        <option value="brand">Brand</option>
                                        <option value="model">Model</option>
                                        <option value="yom">YOM</option>
                                        <option value="mtype">Maintenance Type</option>
                                        <option value="mdesc">Description</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Distribution</td>
                                <td>
                                    <select name="distribution" id="distribution">
                                        <option value="">--Select--</option>
                                        <option value="monthwise">Monthwise</option>
                                        <option value="quarterwise">Quarterwise</option>
                                        <option value="yearwise">Yearwise</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Filter</td>
                                <td>
                                    <div class="inline-action-row">
                                        <select name="searchby" id="searchby">    
                                            <option value="">--Select--</option>
                                            <option value="fleet">Fleet NO</option>  
                                            <option value="brand">Brand</option>
                                            <option value="model">Model</option>
                                            <option value="yom">YOM</option>
                                            <option value="mtype">Maintenance Type</option>
                                        </select>
                                        <button type="button" name="btnadditem" id="additem" class="btn-submit btn-icon" onClick="setSearch();">+</button>
                                        <button type="button" name="btnremoveitem" id="btnremoveitem" class="btn-submit btn-icon" onclick="setRemove();">-</button>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <textarea id="searchdetails" name="searchdetails" rows="8" readonly class="search-textarea"></textarea>

                        <div class="release-actions">
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div hidden="true" id="maingrid"><jsp:include page="ListGrid.jsp"></jsp:include></div>   
                    <div hidden="true" id="maingrids"><jsp:include page="groupinggrid.jsp"></jsp:include></div>  
                    <div id="distributiondiv" hidden="true"><jsp:include page="monthwisegrid.jsp"></jsp:include></div>

                    <!-- Hidden fields for submission -->
                    <input type="hidden" name="hidmodel" id="hidmodel">
                    <input type="hidden" name="hidyom" id="hidyom">
                    <input type="hidden" name="hidbrand" id="hidbrand">
                    <input type="hidden" name="yom" id="yom">
                    <input type="hidden" name="brand" id="brand">
                    <input type="hidden" name="model" id="model">
                    <input type="hidden" name="fleet" id="fleet">
                    <input type="hidden" name="hidfleet" id="hidfleet">
                    <input type="hidden" name="mtype" id="mtype">
                    <input type="hidden" name="hidmtype" id="hidmtype">
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" name="hidclientcat" id="hidclientcat">
                    <input type="hidden" name="hidclient" id="hidclient">
                    <input type="hidden" name="hidgroup" id="hidgroup">  
                    <input type="hidden" name="hidrentalagent" id="hidrentalagent">
                    <input type="hidden" name="hidsalesman" id="hidsalesman">  
                    <input type="hidden" name="clientcat" id="clientcat">
                    <input type="hidden" name="client" id="client">
                    <input type="hidden" name="group" id="group">  
                    <input type="hidden" name="rentalagent" id="rentalagent">
                    <input type="hidden" name="salesman" id="salesman"> 
                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="clientwindow"><div></div></div>
        <div id="clientsearchwindow"><div></div></div>
        <div id="salesagentwindow"><div></div></div>
        <div id="rentalagentwindow"><div></div></div>
        <div id="brandwindow"><div></div></div>
        <div id="modelwindow"><div></div></div>
        <div id="groupwindow"><div></div></div>
        <div id="yomwindow"><div></div></div>
        <div id="mtypewindow"><div></div></div>
        <div id="chartwindow">
            <div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;" /></div>
        </div>
        <div id="fleetwindow">
            <div><img id="loadingImageFleet" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
        </div>

    </div>
</form>
</body>
</html>