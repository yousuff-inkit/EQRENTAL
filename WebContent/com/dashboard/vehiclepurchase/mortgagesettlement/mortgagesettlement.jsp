<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 320px; /* Slightly wider for the textarea and extra buttons */
    flex: 0 0 320px; 
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
    width: 100px; /* Adjusted for longer labels */
}

/* ===== UNIFORM INPUTS & SELECTS ===== */
input[type="text"], select, textarea,
.release-filter-table input[type="text"],
.release-filter-table select,
.release-filter-table textarea {
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

.release-filter-table textarea {
    height: auto;
    resize: none;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
textarea[readonly],
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"],
.release-filter-table div[id^="postingdate"] {
    width: 100% !important; 
}

.radio-group {
    display: flex;
    gap: 10px;
    align-items: center;
    font-size: 12px;
    color: #333;
    padding: 2px 0;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
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

/* Original custom buttons preserved */
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
    padding: 4px 8px;
    font-size: 11px;
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

/* Action buttons layout */
.release-secondary-actions, .release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

.release-actions .btn-submit {
    min-width: 100px;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
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
    display: flex;
    flex-direction: column;
    gap: 20px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	$('#btnsave').hide();
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	$("#currentdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	$("#postingdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy",value:null});
	var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
    $('#purchasewindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Purchase Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#purchasewindow').jqxWindow('close'); 
    $('#balanceloanacwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Purchase Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#balanceloanacwindow').jqxWindow('close'); 
    $('#vehiclewindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Vehicle Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#vehiclewindow').jqxWindow('close');
	$("#postingdate").val('');
	if($("#msg").val()=="Successfully Restructured" || $("#msg").val()=="Not Restructured") { 
		 $.messager.alert('Message',$('#msg').val());
	}
	$('#postingdate').on('change', function (event) 
			{  
	//checkfuturedate();
	if($('#postingdate').jqxDateTimeInput('getDate')!=null){
		var date=new Date($('#postingdate').jqxDateTimeInput('getDate'));
		var status=funDateInPeriod(date);//Checking Future date.Written on 11-07-2016	
		if(status){
			document.getElementById("errormsg").innerText="";
			return true;
		}
		else{
			$('#postingdate').jqxDateTimeInput('focus');
			return false;
		}
	}
	});
	
    $('#purchasedocno,#vendor,#dealno').dblclick(function(){
    	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
			$.messager.alert('warning','Please select a branch');
			return false;
		}
    	$('#mortgageGrid').jqxGrid('clear');
		$('#deleteGrid').jqxGrid('clear');
    	$('#purchasewindow').jqxWindow('open');
    	var branch=$('#cmbbranch').val();
		purchaseSearchContent('purchaseSearchGrid.jsp?branch='+branch);
    });
    
    $('#balanceloanacno').dblclick(function(){
    	$('#balanceloanacwindow').jqxWindow('open');
	  	balanceLoanAcnoSearchContent('balanceLoanAcnoSearchGrid.jsp');
    });
    
    $('#purchasedocno,#vendor,#dealno,#total,#balanceloanacno,#balanceloanamt').attr('disabled',true);
    $('#fromdate').jqxDateTimeInput({disabled:true});
    $('#todate').jqxDateTimeInput({disabled:true});
});

function purchaseSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#purchasewindow').jqxWindow('setContent', data);
	}); 
}
function balanceLoanAcnoSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#balanceloanacwindow').jqxWindow('setContent', data);
	}); 
}
function getPurchaseDoc(event){
	var x= event.keyCode;
	if(x==114){
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
			$.messager.alert('warning','Please select a branch');
			return false;
		}
		$('#purchasewindow').jqxWindow('open');
		var branch=$('#cmbbranch').val();
		purchaseSearchContent('purchaseSearchGrid.jsp?branch='+branch);
	}
	else{
	}
}
function getBalanceLoanAcno(event){
	var x= event.keyCode;
	if(x==114){
		$('#balanceloanacwindow').jqxWindow('open');
	  	balanceLoanAcnoSearchContent('balanceLoanAcnoSearchGrid.jsp');
	}
	else{
	}
}
	function funreload(event){
		
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
			$.messager.alert('warning','Please select a branch');
			return false;
		}
		if(document.getElementById("purchasedocno").value==""){
			$.messager.alert('warning','Please select a document');
			return false;
		}
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
		var purchasedocno=$('#hidpurchasedocno').val();
		
		$('#mortgageGrid').jqxGrid('clear');
		$('#deleteGrid').jqxGrid('clear');
		$("#overlay, #PleaseWait").show();
		$('#mortgagediv').load('mortgageGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1&purchasedocno='+purchasedocno);
		$('#deletediv').load('deleteGrid.jsp?id=1&purchasedocno='+purchasedocno);
	}
	
	
	function funSave(){
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
			$.messager.alert('warning','Please select a branch');
			return false;
		}
		if(document.getElementById("purchasedocno").value==""){
			$.messager.alert('warning','Please select a document');
			return false;
		}
		var principal=$('#mortgageGrid').jqxGrid('getcolumnaggregateddata', 'principalamt', ['sum'], true);
        var principalsum=principal.sum;
        var totalloanamount=$('#total').val();
        principalsum=principalsum.replace(/,/g,'');
        if(principalsum!=totalloanamount){
        	if($('#hidbalanceloanacno').val()==''){
            	$.messager.alert('warning','Please Select Balance Loan A/c');
            	return false;        		
        	}
			if($('#postingdate').jqxDateTimeInput('getDate')==null){
				$.messager.alert('warning','Please Select Posting Date');
            	return false;        		
			}

        }
        else{
        	
                    	
        }
        var balanceloanacno=$('#hidbalanceloanacno').val();
        funSaveAJAX(principalsum,totalloanamount,balanceloanacno);
	}
	function funSaveAJAX(principalsum,totalloanamount,balanceloanacno){
		document.getElementById("hidprincipalsum").value=principalsum;
		var branch=$('#cmbbranch').val();
		var vehicleremove=$('#hidvehicle').val();
		//alert(vehicleremove);
		var rows=$('#mortgageGrid').jqxGrid('getrows');
		var purchasearray=new Array();
		var deleterows=$('#deleteGrid').jqxGrid('getrows');
		var deletearray=new Array();
		var rowindex=0;
		var dltrowindex=0;
		  $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else {
		     		 $("#overlay, #PleaseWait").show();
		//new lines 
		for(var i=0;i<rows.length;i++){
		
			var date=$('#mortgageGrid').jqxGrid('getcelltext',i,'date');
			var purchasedocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'purchasedocno');
			var ucrdocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'ucrdocno');
			var detaildocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'detaildocno');
			var chequeno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'chequeno');
			var principalamt=$('#mortgageGrid').jqxGrid('getcellvalue',i,'principalamt');
			var interestamt=$('#mortgageGrid').jqxGrid('getcellvalue',i,'interestamt');
			var amount=$('#mortgageGrid').jqxGrid('getcellvalue',i,'amount');
			var bpvno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'bpvno');
			var defaultrow=$('#mortgageGrid').jqxGrid('getcellvalue',i,'defaultrow');
			var editstatus=$('#mortgageGrid').jqxGrid('getcellvalue',i,'editstatus');
			/* if(defaultrow==0){
				purchasearray.push(purchasedocno+"::"+ucrdocno+"::"+detaildocno+"::"+date+"::"+chequeno+"::"+principalamt+"::"+interestamt+"::"+amount+"::"+bpvno+"::"+defaultrow+"::"+editstatus);
			}  */
			if(defaultrow==0){
				
				if(typeof(date) != "undefined" && typeof(date) != "NaN" && date != ""){
					newTextBox = $(document.createElement("input"))
				       .attr("type", "dil")
				       .attr("id", "test"+i)
				       .attr("name", "test"+i)      
				       .attr("hidden", "true");
				   newTextBox.val(purchasedocno+"::"+ucrdocno+"::"+detaildocno+"::"+date+"::"+chequeno+"::"+principalamt+"::"+interestamt+"::"+amount+"::"+bpvno+"::"+defaultrow+"::"+editstatus);  
				   newTextBox.appendTo('form');                        
				   rowindex++;       
				   $('#gridlength').val(rowindex); 
				}
	 	   }
			
		}
		// existing lines 
		for(var i=0;i<rows.length;i++){
			var date=$('#mortgageGrid').jqxGrid('getcelltext',i,'date');
			 var purchasedocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'purchasedocno');
			var ucrdocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'ucrdocno');
			var detaildocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'detaildocno');
			var chequeno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'chequeno');
			var principalamt=$('#mortgageGrid').jqxGrid('getcellvalue',i,'principalamt');
			var interestamt=$('#mortgageGrid').jqxGrid('getcellvalue',i,'interestamt');
			var amount=$('#mortgageGrid').jqxGrid('getcellvalue',i,'amount');
			var bpvno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'bpvno');
			var defaultrow=$('#mortgageGrid').jqxGrid('getcellvalue',i,'defaultrow');
			var editstatus=$('#mortgageGrid').jqxGrid('getcellvalue',i,'editstatus');
			/*if(defaultrow==1){
				purchasearray.push(purchasedocno+"::"+ucrdocno+"::"+detaildocno+"::"+date+"::"+chequeno+"::"+principalamt+"::"+interestamt+"::"+amount+"::"+bpvno+"::"+defaultrow+"::"+editstatus);
			} */
			if(defaultrow==1){
				newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "test"+i)
			       .attr("name", "test"+i)      
			       .attr("hidden", "true");
		   newTextBox.val(purchasedocno+"::"+ucrdocno+"::"+detaildocno+"::"+date+"::"+chequeno+"::"+principalamt+"::"+interestamt+"::"+amount+"::"+bpvno+"::"+defaultrow+"::"+editstatus);  
		   newTextBox.appendTo('form');                        
		   rowindex++;       
		   $('#gridlength').val(rowindex);  
	 	   }
		}
		
		for(var i=0;i<deleterows.length;i++){
			var date=$('#deleteGrid').jqxGrid('getcelltext',i,'date');
			 var purchasedocno=$('#deleteGrid').jqxGrid('getcellvalue',i,'purchasedocno');
			var ucrdocno=$('#deleteGrid').jqxGrid('getcellvalue',i,'ucrdocno');
			var detaildocno=$('#deleteGrid').jqxGrid('getcellvalue',i,'detaildocno');
			var chequeno=$('#deleteGrid').jqxGrid('getcellvalue',i,'chequeno');
			var principalamt=$('#deleteGrid').jqxGrid('getcellvalue',i,'principalamt');
			var interestamt=$('#deleteGrid').jqxGrid('getcellvalue',i,'interestamt');
			var amount=$('#deleteGrid').jqxGrid('getcellvalue',i,'amount');
			var bpvno=$('#deleteGrid').jqxGrid('getcellvalue',i,'bpvno');
			var defaultdeleterow=$('#deleteGrid').jqxGrid('getcellvalue',i,'defaultdeleterow');
			/*deletearray.push(purchasedocno+"::"+ucrdocno+"::"+detaildocno+"::"+date+"::"+chequeno+"::"+principalamt+"::"+interestamt+"::"+amount+"::"+bpvno+"::"+defaultdeleterow); */
			newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "dtest"+i)
		       .attr("name", "dtest"+i)      
		       .attr("hidden", "true");
	   newTextBox.val(purchasedocno+"::"+ucrdocno+"::"+detaildocno+"::"+date+"::"+chequeno+"::"+principalamt+"::"+interestamt+"::"+amount+"::"+bpvno+"::"+defaultdeleterow);  
	   newTextBox.appendTo('form');                        
	   dltrowindex++;       
	   $('#dltgridlength').val(dltrowindex);  
		}
		 document.getElementById("mode").value="A";           
		 document.getElementById("frmloanrestructuring").submit(); 
		}
		/* var x=new XMLHttpRequest();
 		x.onreadystatechange=function(){
 		if (x.readyState==4 && x.status==200)
 			{
			var items = x.responseText;
			if(items.trim()=="0"){
				$.messager.alert('message','Successfully Restructured');
			}
			else{
				$.messager.alert('message','Not Restructured');
			}
			funreload("");
			
 			}
 		}
 		
		x.open("GET","saveAJAX.jsp?purchasearray="+purchasearray+"&deletearray="+deletearray+"&deleteucrdocno="+$("#deleteucrdocno").val()+"&purchasedocno="+$("#hidpurchasedocno").val()+"&currentdate="+$("#currentdate").jqxDateTimeInput("val")+"&vendor="+$("#vendor").val()+"&principalsum="+principalsum+"&totalloanamount="+totalloanamount+"&balanceloanacno="+balanceloanacno+"&branch="+branch+"&vehicleremove="+vehicleremove+"&postingdate="+$('#postingdate').jqxDateTimeInput('val'),true);
		x.send(); */
         
	            });
		  }
	
	
	function funEdit(){
		$('#purchasedocno,#vendor,#dealno,#total,#balanceloanacno,#balanceloanamt,#vehicleremove').attr('disabled',false);
	    $('#fromdate').jqxDateTimeInput({disabled:false});
	    $('#todate').jqxDateTimeInput({disabled:false});
	    $('#btnedit').hide();
	    $('#btnsave').show();
	    $('#tempmode').val('E');
	}
	
	function funAddFleet(){
		if($('#tempmode').val()!='E'){
			return false;
		}
		else{
			if(document.getElementById("purchasedocno").value=="" && document.getElementById("dealno").value==""){
				$.messager.alert('warning','Please select a document');
				return false;
			}
			else{
				getVehicle();
			}
		}
	}
	
	function getVehicle(){
		 $('#vehiclewindow').jqxWindow('open');
			$('#vehiclewindow').jqxWindow('focus');
			 vehicleSearchContent('vehicleSearch.jsp?id=1&purchasedocno='+$('#hidpurchasedocno').val()+'&dealno='+$('#dealno').val(), $('#vehiclewindow'));

	}
	
	function vehicleSearchContent(url) {
	    //alert(url);  
	      $.get(url).done(function (data) {
	//alert(data);
	    $('#vehiclewindow').jqxWindow('setContent', data);

	}); 
	}
function funClearFleet(){
		$('#vehicleremove,#vehicle,#hidvehicle').val('');
	}
function funExportBtn(){   
	   $("#mortgagediv").excelexportjs({   
		   containerid: "mortgagediv",     
		   datatype: 'json', 
		   dataset: null, 
		   gridId: "mortgageGrid", 
		   columns: getColumns("mortgageGrid") ,   
		   worksheetName:"Loan Restructuring"    
		   });
	 }
</script>

</head>
<body onload="getBranch();">
<form id="frmloanrestructuring" action="saveloanrestructuring" method="post" autocomplete="off"> 
<div id="mainBG" class="homeContent" data-type="background">
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">From Date</td>
                            <td><div id="fromdate" name="fromdate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To Date</td>
                            <td><div id="todate" name="todate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Purchase Docno</td>
                            <td>
                                <input type="text" name="purchasedocno" id="purchasedocno" placeholder="Press F3 to Search" readonly onKeyDown="getPurchaseDoc(event);">
                                <input type="hidden" name="hidpurchasedocno" id="hidpurchasedocno">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Vendor</td>
                            <td><input type="text" name="vendor" id="vendor" placeholder="Press F3 to Search" readonly onKeyDown="getPurchaseDoc(event);"></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Deal No</td>
                            <td><input type="text" id="dealno" name="dealno" placeholder="Press F3 to Search" readonly onKeyDown="getPurchaseDoc(event);"></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Total Loan Amt</td>
                            <td><input type="text" id="total" name="total"></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Balance Loan A/c</td>
                            <td>
                                <input type="text" id="balanceloanacno" name="balanceloanacno" placeholder="Press F3 to Search" readonly onkeydown="getBalanceLoanAcno(event);">
                                <input type="hidden" id="hidbalanceloanacno" name="hidbalanceloanacno">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Balance Amt</td>
                            <td><input type="text" id="balanceloanamt" name="balanceloanamt" readonly></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Vehicle to Remove</td>
                            <td>
                                <textarea name="vehicleremove" id="vehicleremove" readonly rows="3"></textarea>
                                <input type="hidden" name="hidvehicleremove" id="hidvehicleremove">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center; padding-top: 5px;">
                                <button type="button" class="myButtons" id="btnaddfleet" onclick="funAddFleet();">Search Fleet</button>
                                <button type="button" class="myButtons" id="btnremovefleet" onclick="funClearFleet();">Clear Fleet</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell" style="padding-top: 10px;">Posting Date</td>
                            <td style="padding-top: 10px;"><div id="postingdate" name="postingdate" value='<s:property value="postingdate"/>'></div></td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" id="btnedit" name="btnedit" class="btn-submit" onClick="funEdit();">Edit</button>
                        <button type="button" id="btnsave" name="btnsave" class="btn-submit" onClick="funSave();">Save</button>
                    </div>

                    <!-- Additional hidden inputs grouped neatly inside the sidebar -->
                    <div id="currentdate" name="currentdate" hidden="true"></div>
                    <input type="hidden" name="tempmode" id="tempmode">
                    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>    
                    <input type="hidden" name="hidvehicle" id="hidvehicle" value='<s:property value="hidvehicle"/>' />
                    <input type="hidden" name="vehicle" id="vehicle">
                    <input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>' />
                    <input type="hidden" id="dltgridlength" name="dltgridlength" value='<s:property value="dltgridlength"/>' />
                    <input type="hidden" id="hidprincipalsum" name="hidprincipalsum" value='<s:property value="hidprincipalsum"/>' />
                    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="mortgagediv"><jsp:include page="mortgageGrid.jsp"></jsp:include></div>
                <div id="deletediv"><jsp:include page="deleteGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="purchasewindow">
       <div></div>
    </div>
    <div id="balanceloanacwindow">
       <div></div>
    </div>
    <div id="vehiclewindow">
       <div></div>
    </div>
</div> 
</form>
</body>
</html>