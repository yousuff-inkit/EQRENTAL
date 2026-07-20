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

.release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
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


	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	     $('#searchwindow').jqxWindow('close');
	     
	     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		
		 
	 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 $('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#productDetailsWindow').jqxWindow('close');
	 
	 $('#salmwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sales Man Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#salmwindow').jqxWindow('close');
	 
	 $('#txtpartno').dblclick(function(){
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
	 }); 
	 
	 $('#txtclientname').dblclick(function(){
		  accountsSearchContent('clientDetailsSearch.jsp');
	 });
	 
	 $('#salname').dblclick(function(){
	 	    
		   $('#salmwindow').jqxWindow('open');
		   salmsearchContent('salmsearch.jsp', $('#salmwindow')); 
	       });
	 $('#itemname').dblclick(function(){
	 
 	    $('#searchwindow').jqxWindow('open');
 	
		if(document.getElementById("itemtype").value=="1") 
			{
		 
			refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
			}
		
		else
			{
			  	
			}
		
		 
			  
	  }); 
  
});
function accountsSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getClientAccount(event){
    var x= event.keyCode;
    if(x==114){
  	  accountsSearchContent('clientDetailsSearch.jsp');
    }
    else{}
    }
 
function productSearchContent(url) {
    $('#productDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#productDetailsWindow').jqxWindow('setContent', data);
	$('#productDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getProduct(){
	
	 $('#productDetailsWindow').jqxWindow('open');
		$('#productDetailsWindow').jqxWindow('focus');
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));

}

function getsalminfo(event){
	 var x= event.keyCode;
	if(x==114){
		$('#salmwindow').jqxWindow('open');
		salmsearchContent('salmsearch.jsp', $('#salmwindow'));    }
	else{}
} 

function salmsearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#salmwindow').jqxWindow('open');
		$('#salmwindow').jqxWindow('setContent', data);
}); 
}
function getitem(event){
	
 	 var x= event.keyCode;
 	 if(x==114){

 		  $('#searchwindow').jqxWindow('open');
 			
 		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
		{
 		
		refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno=1');
		}
 		
		
 		
	else
		{
		  	
		}		  
 	 
 	 }
 	 }  
 	  function refsearchContent(url) {
      
       //document.getElementById("errormsg").innerText="";
         $.get(url).done(function (data) {
 //alert(data);
       $('#searchwindow').jqxWindow('setContent', data);

 	}); 
   	}
 function funExportBtn(){
	  
	
		JSONToCSVCon(rdatas, 'GIS Reports', true);
	
} 
function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	  
		 
	   
		   

		   
		   
		   
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 

	 
	  var psrno = document.getElementById("psrno").value; 
	
	 
	
 
	 
	   $("#overlay, #PleaseWait").show();
	  
	  
	   
	   var aa="yes";
	   
		   $("#listdetdiv").load("ginreportGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&psrno="+psrno+"&aa="+aa);
			         
		   }
	
	
	
/* function funClearInfo()
{
	 
	 
	 
	  $("#fromdocno").val('');
	  $("#todocno").val('');   
	 $("#fromamount").val('');  
	 $("#toamount").val(''); 
	  $("#accdocno").val(''); 
	  
	 $("#acno").val(''); 
	 $("#accname").val(''); 
	 
	 
	  $("#fromdocno").attr('placeholder', 'From');
	  $("#todocno").attr('placeholder', 'To');
	  $("#fromamount").attr('placeholder', 'From');
	  $("#toamount").attr('placeholder', 'To');
	  
	  
	/*   $(this).attr('placeholder', '');
	  $(this).attr('placeholder', '');
	  $(this).attr('placeholder', '');
	  
	 
	 
} */
	   
	
	
/* function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	  // document.getElementById("errormsg").innerText=" Enter Numbers Only";  
 	   $.messager.alert('Message',' Enter Numbers Only  ','warning');   
        return false;
    	}
   // document.getElementById("errormsg").innerText="";  
    return true;
} */	
function fundisable(){
	

	/* 
	if (document.getElementById('rsumm').checked) {
		$('#orderlist').show(); 
		  $('#orderlistdetails').hide();
		 
		   $('#summuryselect').attr('disabled', false);
		}
	 else if (document.getElementById('rdet').checked) {
		 
		 $('#orderlist').hide(); 
		   $('#orderlistdetails').show();
		  $('#summuryselect').attr('disabled', true);
		} */
	 }
function  getproject(){
	document.getElementById("itemtype").value="1";
	$('#summuryselect').attr('disabled', true);
}

function  funcleardata()
{
	// txtpartno  psrno   txtproductname   Press F3 to Search;
	 

	 document.getElementById('txtpartno').value="";
	 document.getElementById('psrno').value="";
	 document.getElementById('txtproductname').value="";
 
	 document.getElementById("cmbbranch").value="a";
	 
	 $('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
	
	}
</script>
</head>
<body onload="getBranch();getproject();">
<div id="mainBG" class="homeContent" data-type="background">  
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">

                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Product</td>
                            <td>
                                <input type="text" id="txtpartno" name="txtpartno" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/>
                                <input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtproductname" name="txtproductname" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" name="clear" id="clear" onclick="funcleardata()">Clear</button>
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" id="costtr_no" name="costtr_no">
                    <input type="hidden" id="itemtype" name="itemtype">

                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="listdetdiv">
                    <jsp:include page="ginreportGrid.jsp"></jsp:include> 
                </div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="accountDetailsWindow">
        <div></div> 
    </div>
    <div id="productDetailsWindow">
        <div></div> 
    </div>
    <div id="salmwindow">
        <div></div> 
    </div>
    <div id="searchwindow">
        <div></div>
    </div>

</div>
</body>
</html>