<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html> 
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>

<style type="text/css">
.classpass {
    -webkit-text-security: disc;
}
 #psearch {
 
background:#FAEBD7;
 
}

.blink {
  animation: blink-animation 2s steps(5, start) infinite;
  -webkit-animation: blink-animation 2s steps(5, start) infinite;
}
@keyframes blink-animation {
  to {
    visibility: hidden;
  }
}
@-webkit-keyframes blink-animation {
  to {
    visibility: hidden;
  }
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
  
  
 
}


 #divname {
     
    background-color: #e2c791;
    box-shadow: 10px 10px grey;
     position:fixed;z-index:1000;right:30px;top:100px;  
}
.classpass {
    -webkit-text-security: disc;
}
 #psearch {
 
background:#FAEBD7;
 
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
  
  
 
}


 #divname {
     
    background-color: #e2c791;
    box-shadow: 10px 10px grey;
     position:fixed;z-index:1000;right:30px;top:100px;  
}
.myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 7px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
	background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
	background-color:#476e9e;
}
.myButtons:active {
	position:relative;
	top:1px;
}      

</style>



<script type="text/javascript">
$(document).ready(function() {
$("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
$("#payDueDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
refChange();
//getCurrencyIds();
$('#cmbvatype').hide();
$('#vatype').hide(); 
document.getElementById("cmbvatype").value="";
document.getElementById("cmbvatype").value="exclusive";
$('#btnvaluechange').hide();
$('#disitems').hide();
getVatConfig();
//$("#btnEdit").attr('disabled', true );
chkfoc();


document.getElementById("checkhidegrid").value="0";

$('#userwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
$('#userwindow').jqxWindow('close');  
$('#customerDetailsWindow').jqxWindow({ width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#customerDetailsWindow').jqxWindow('close'); 
$('#sidesearchwndow').jqxWindow({  width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 300, y: 0 }, keyboardCloseKey: 27});
$('#sidesearchwndow').jqxWindow('close'); 
$('#salespersonwindow').jqxWindow({
		width : '25%',
		height : '58%',
		maxHeight : '70%',
		maxWidth : '45%',
		title : 'Sales Person Search',
		position : {
			x : 420,
			y : 87
		},
		theme : 'energyblue',
		showCloseButton : true,
		keyboardCloseKey : 27
	});
	$('#salespersonwindow').jqxWindow('close');
	
	
	$('#accountsearchwindow').jqxWindow({
		width : '25%',
		height : '58%',
		maxHeight : '70%',
		maxWidth : '45%', 
		title : 'Account Search',
		position : {
			x : 420,
			y : 87
		},
		theme : 'energyblue',
		showCloseButton : true,
		keyboardCloseKey : 27
	});
	$('#accountsearchwindow').jqxWindow('close');
	
	
	 $('#locationwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Location Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#locationwindow').jqxWindow('close');
	
	$('#searchwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
		x : 420,
		y : 87
	}, keyboardCloseKey: 27});
    $('#searchwndow').jqxWindow('close');  
	 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	   $('#refnosearchwindow').jqxWindow('close'); 
	
//getCurrencyIds();

$('#shipto').dblclick(function(){
    
 	if($('#mode').val()!= "view")
 		{
 	
 		 
	  	   shipSearchContent('shipmasterSearch.jsp?');
 		}
}); 
$('#date').on('change', function (event) {
	  
    var maindate = $('#date').jqxDateTimeInput('getDate');
  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
    funDateInPeriod(maindate);
  	 }
   });

$('#user_namess').dblclick(function(){
 
 	if($('#mode').val()!= "view")
		{
 		 
	usersearchcontent('searchuser.jsp?'); 
		}
	
     });

$('#txtclient').dblclick(function(){
	   
   	if($('#mode').val()!= "view")
   		{
	  	  CustomerSearchContent('clientINgridsearch.jsp');
   		}
 });

$('#txtsalesperson').dblclick(function(){
	   
   	if($('#mode').val()!= "view")
   		{
   		salespersonSearchContent('salesPersonSearch.jsp');
   		}
 });



$('#txtlocation').dblclick(function(){
	   
   	if($('#mode').val()!= "view")
   		{
   		$('#locationwindow').jqxWindow('open');
   		locationSearchContent('locationSearch.jsp');  
   		}
 });

$('#rrefno').dblclick(function(){
	   
	 var clientid=document.getElementById("clientid").value;
		
		if(clientid>0){
			
			document.getElementById("errormsg").innerText="";
			 $('#refnosearchwindow').jqxWindow('open');
			  	
		  	  refsearchContent('refnosearch.jsp');
			
		}
		else{
			document.getElementById("errormsg").innerText="Select a Customer";
			
			return 0;
		}
		
	 
 });

});

function getuser(event){
	 var x= event.keyCode;
	 if(x==114){
		   	if($('#mode').val()!= "view")
	   		{
	  usersearchcontent('searchuser.jsp?');
	   		}}
	 else{
		 }
	 } 
function usersearchcontent(url) {
	  $('#userwindow').jqxWindow('open');
      $.get(url).done(function (data) {
     $('#userwindow').jqxWindow('setContent', data);

	}); 
	}


function getshipdetails(event){
	 var x= event.keyCode;
  	
	if($('#mode').val()!="view")
		{
		
	 if(x==114){
	 
	
	  shipSearchContent('shipmasterSearch.jsp?');    }
	 else{
		 }
		}
	 }  
function shipSearchContent(url) {
	  $('#customerDetailsWindow').jqxWindow('open');
      $.get(url).done(function (data) {
//alert(data);
    $('#customerDetailsWindow').jqxWindow('setContent', data);

	}); 
	}  


function shipdescSearchContent(url) {
   //alert(url);
      $.get(url).done(function (data) {
//alert(data);
 $('#searchwndow').jqxWindow('open');
    $('#searchwndow').jqxWindow('setContent', data);

	}); 
	}  

function CustomerSearchContent(url) {
$('#customerDetailsWindow').jqxWindow('open');
$.get(url).done(function (data) {
$('#customerDetailsWindow').jqxWindow('setContent', data);
$('#customerDetailsWindow').jqxWindow('bringToFront');
}); 
} 

function getSalesPerson(event){
var x= event.keyCode;
if(x==114){
	salespersonSearchContent('salesPersonSearch.jsp');  	 }
else{
	 }
 }

function salespersonSearchContent(url) {
$('#salespersonwindow').jqxWindow('open');
$.get(url).done(function(data) {
	$('#salespersonwindow').jqxWindow('setContent', data);
	$('#salespersonwindow').jqxWindow('bringToFront');
});
}

function getLocation(event){
	 var x= event.keyCode;
	 if(x==114){
		locationSearchContent('locationSearch.jsp');  	 }
	 else{
		 }
     	 }
     	 
function accountSearchContent(url) {
	$('#accountsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#accountsearchwindow').jqxWindow('setContent', data);
		$('#accountsearchwindow').jqxWindow('bringToFront');
	});
}   	 

function locationSearchContent(url) {
	$('#locationwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#locationwindow').jqxWindow('setContent', data);
		$('#locationwindow').jqxWindow('bringToFront');
	});
}



function funReadOnly(){
	
	  $('#psearch').attr('disabled', true );
	$('#frmSalesInvoice input').attr('readonly', true );
	$('#frmSalesInvoice select').attr('disabled', true);
	$('#date').jqxDateTimeInput({disabled: true});
	$('#payDueDate').jqxDateTimeInput({disabled: true});
	$("#jqxInvoiceGrid").jqxGrid({ disabled: true});
	$("#jqxTerms").jqxGrid({ disabled: true});
	$("#jqxserviceGrid").jqxGrid({ disabled: true});
	$('#btnvaluechange').hide();
	$('#chkdiscount').attr('disabled', true);	 
	$('#btnCalculate').attr('disabled', true);
	$('#rrefno').attr('disabled', true);
	$("#shipdata").jqxGrid({ disabled: true});
	$('#disitems').hide();
	     $('#user_namess').attr('disabled', true);
	
		 $('#dscper').attr('disabled', true);
		 $('#process').attr('disabled', true);
		 $('#changeuser').attr('disabled', true);
		 
		 
		 $('#process1').attr('disabled', true);
		 
		 
		 
}




function funRemoveReadOnly(){
	if ($("#mode").val() == "A") {
gridLoad();
getDefaultLocation();
getVatConfig();
	}
	gettaxaccount(1);	
	getround();
	chkbatch();
		 chkmultiqty();
		 //chkproductconfig();
		 getCurrencyIds();
document.getElementById("editdata").value="";
    $('#rrefno').attr('disabled', true);
	$('#frmSalesInvoice input').attr('readonly', false );
	$('#frmSalesInvoice select').attr('disabled', false);
	
	$('#disitems').hide();
	
	
	$('#txtclientmob').attr('readonly', true );
	
	$('#st').attr('readonly', true );
	$('#taxontax1').attr('readonly', true );
	$('#taxontax2').attr('readonly', true );
	$('#taxontax3').attr('readonly', true );
	$('#taxtotal').attr('readonly', true );
	
	 $('#process1').attr('disabled', false);
	
	
		$('#totamt').attr('readonly', true);
		$('#taxpers').attr('readonly', true);
		$('#taxamounts').attr('readonly', true);
		$('#taxamountstotal').attr('readonly', true);
		$('#amounts').attr('readonly', true);
	
	
	$('#user_namess').attr('readonly', true );
	
	 $('#user_namess').attr('disabled', true);
	 $('#pass_wordss').attr('disabled', true);
	 $('#dscper').attr('disabled', true);
	 $('#process').attr('disabled', true);
	 $('#changeuser').attr('disabled', true);
	
	$('#txtclient').attr('readonly', true );
	$('#rrefno').attr('readonly', true );
	$('#txtlocation').attr('readonly', true );
	$('#txtsalesperson').attr('readonly', true );
	$('#txtproductamt').attr('readonly', true );
	$('#txtdiscount').attr('readonly', false );
	$('#txtnettotal').attr('readonly', true );
	
	$('#orderValue').attr('readonly', true);
	$('#orderValuefinal').attr('readonly', true);
	//$('#chkdiscount').attr('disabled', false);	
	
	
				 $('#shipto').attr('readonly', true);
			 $('#shipaddress').attr('readonly', true);
			 $('#contactperson').attr('readonly', true);
			 $('#shiptelephone').attr('readonly', true);
			 $('#shipmob').attr('readonly', true);
			 
			 $('#shipemail').attr('readonly', true);
			 $('#shipfax').attr('readonly', true);
			 $("#shipdata").jqxGrid({ disabled: false});
	 $('#descPercentage').attr('disabled', true);
	 $('#txtdiscount').attr('disabled', true);
	
	$('#payDueDate').jqxDateTimeInput({disabled: false});
	$('#date').jqxDateTimeInput({disabled: false});
	$('#docno').attr('readonly', true);
	$("#jqxInvoiceGrid").jqxGrid({ disabled: false}); 
	$("#jqxTerms").jqxGrid({ disabled: false});
	if ($("#mode").val() == "E") {
		/* $("#jqxserviceGrid").jqxGrid({ disabled: false});
		    $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
		    $("#jqxserviceGrid").jqxGrid('addrow', null, {}); */
		    $('#cmbvatype').attr('readonly', true);
			 $('#cmbvatype').attr('disabled', true);
				$("#jqxserviceGrid").jqxGrid({ disabled: true}); 
				$("#jqxTerms").jqxGrid({ disabled: true});
				$("#jqxInvoiceGrid").jqxGrid({ disabled: true});
				$('#btnvaluechange').show();	
				
		     	 if($('#cmbreftype').val()!="DIR")
	      		 {  $('#psearch').attr('disabled', true );
	      		 
	      		  $('#rrefno').attr('disabled', false);
	      		 }
		     	 else
		     		 {
		     	     reloads();
		     		 $('#psearch').attr('disabled', false );
		     		 
		     		 
		     		 }
		     	funckclientcat();
	  }
	
	if ($("#mode").val() == "A") {
		$("#txtproductamt").val("0.0");
		$("#txtdiscount").val("0.0");
		$("#txtnettotal").val("0.0");
		$("#descPercentage").val("0.0");
		$("#prodsearchtype").val("0");
		$("#orderValue").val("0.0");
		$("#orderValuefinal").val("0.0");
		$("#roundOf").val("0.0");
		$("#nettotal").val("0.0");
		//getCurrencyIds();
		 $('#psearch').attr('disabled', false );
		 
		$('#chkdiscount').attr('disabled', false);
		$('#btnvaluechange').hide();
		$('#date').val(new Date());
		$('#payDueDate').val(new Date());
		$("#jqxTerms").jqxGrid({ disabled: false});
		$("#jqxserviceGrid").jqxGrid({ disabled: false});
		$("#jqxserviceGrid").jqxGrid('clear'); 
		$("#jqxserviceGrid").jqxGrid('addrow', null, {});
		
		
		
		$("#jqxInvoiceGrid").jqxGrid('clear'); 
		$("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
		$("#shipdata").jqxGrid('clear');
		$("#shipdata").jqxGrid('addrow', null, {});
		
		  
		  $("#hidegrids").jqxGrid('clear'); 
	}
	
}

function funSearchLoad(){
changeContent('Mastersearch.jsp'); 
}

function funChkButton() {
	/* funReset(); */
}

function funFocus(){
	$('#date').jqxDateTimeInput('focus'); 	    		
}

$(function(){
   $('#frmSalesInvoice').validate({
           rules: {
           txtfromaccid:"required",
           txtfromamount:{"required":true,number:true}
           },
            messages: {
            txtfromaccid:" *",
            txtfromamount:{required:" *",number:"Invalid"}
            }
   });});


/* function funNotify(){
	
	if($('#txtlocation').val()== "")
	{
	document.getElementById("errormsg").innerText="select location";
	document.getElementById("txtlocation").focus();
	return 0;
	}
	
	
	var aa=0;
	 var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');

	 for(var i=0 ; i < rows.length ; i++){ 
		  
         var prodoc=rows[i].prodoc;
         if(prodoc>0)
       	  {
       	  aa=1;
       	  break;
       	  }
         
	 	    
	 }
	 
	 
	 if(aa==0)
		 {
		 
		   document.getElementById("errormsg").innerText="Product Is Mandatory..";  
		   
		      return 0;
		 
		 }
	
	

	
	
	  if(document.getElementById("cmbreftype").value=='SOR' || document.getElementById("cmbreftype").value=='DIR')
	   {
	checkqty();
	   }
	  else
		  {
		  save();
		  
		  }
	
	
}
 */
 function funDateInPeriodchk(value){
	    var styear = new Date(window.parent.txtaccountperiodfrom.value);
	    var edyear = new Date(window.parent.txtaccountperiodto.value);
	    var mclose = new Date(window.parent.monthclosed.value);
	    mclose.setHours(0,0,0,0);
	    edyear.setHours(0,0,0,0);
	    styear.setHours(0,0,0,0);
	    var currentDate = new Date(new Date());
	 
	     if(value>currentDate){
	     document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
	    
	     return 0;
	    } 
	    
	    document.getElementById("errormsg").innerText="";
	   
	     return 1;
	 }



 function funNotify(){
		var maindate = $('#date').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
 	/* 	  if(document.getElementById("cmbreftype").value=='SOR')
 		   {
 		checkqty();
 		   }
 		  else
 			  {
 			  save();
 			  
 			  } */
 		
 				if($('#txtlocation').val()== "")
 				{
 				document.getElementById("errormsg").innerText="select location";
 				document.getElementById("txtlocation").focus();
 				return 0;
 				}	  	
 				  
 				  if($('#cmbreftype').val()=="DEL" || $('#cmbreftype').val()=="JOR")
 					  {
 					  save();
 					  }
 				  else
 					  {
 					  chkstock();
 					  }
 				  
 				 
 			   
 	}


 function chkstock()
	{

			var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
			var list = new Array();
			 
		   for(var i=0 ; i < rows.length; i++){
			 
			   if(parseInt(rows[i].prodoc)>0)  
			   { 
			 
			   list.push(rows[i].prodoc+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].unitdocno+"::"+rows[i].oldqty);
			 
			   }
		   }
				 
		  ajaxcallchk(list);
		   
	}
		   

		 function ajaxcallchk(list){
			 var branch=document.getElementById("brchName").value;
			 var location=document.getElementById("locationid").value;
			 var mode=$('#mode').val();
			 	
			 	var x=new XMLHttpRequest();
			 	x.onreadystatechange=function(){
			 		if (x.readyState==4 && x.status==200)
			 			{
			 			 var items= x.responseText.trim();
			  
			 	 
			 		   
			 		    if(parseInt(items)==1)
				           {
			 		    	document.getElementById("errormsg").innerText=" Does Not Have Sufficient Stock !!";  
			 		        return 0;
				           }
			 		    else  if(parseInt(items)==2)
			 		    	{
			 		    	document.getElementById("errormsg").innerText=" error!!";  
			 		        return 0;
			 		    	
			 		    	}
				       

					           
				           
				           else
				        	   {
				        	   save();
				        	   }
				           
			 			    
			 			}
			 		  //type,description,remarks,lbrcost,partscost,total
			 	}
			 	 x.open("GET","validateqty.jsp?list="+list+"&branch="+branch+"&mode="+mode+"&location="+location+"&date="+document.getElementById("date").value,true);
					x.send();
				        
			 }


  function checkqty()
{
 
		var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
		var list = new Array();
		 
	   for(var i=0 ; i < rows.length; i++){
		   if(parseInt(rows[i].qty)>0)  
		   {
		   if(parseInt(rows[i].prodoc)>0)  
		   { 
		 
		   list.push(rows[i].prodoc+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].oldqty+"::"+rows[i].balqty+"::"+rows[i].totqty);
		 
		   }
		   }
	   }
			 
	  ajaxcall(list);
	   
}
	   

	 function ajaxcall(list){
		 var branch=document.getElementById("brchName").value;
 
		 
		 var location=0;
		 if(document.getElementById("cmbreftype").value=='DIR')
			 {
			   location=document.getElementById("locationid").value;  
			 }
		  
		 var mode=$('#mode').val();
		 	
		 	var x=new XMLHttpRequest();
		 	x.onreadystatechange=function(){
		 		if (x.readyState==4 && x.status==200)
		 			{
		 			 var items= x.responseText.trim();
		  
		 		 var temps1="";
		 		 var temps2="";
		 		    items = items.split('###');
		 		    
		 		    
			           var temp1=items[0];
			           var temp2=items[1];
			          
			       
			           if(temp1.indexOf(",")>=0){
			    
			 
			        	 
				            for ( var j = 0; j < temp1.length; j++) {
				            	
				             
				            var	test=temp1.split(",");
				            var test2=temp2.split(",");
				      
				         
				            	var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
				    		 
				    			 
				    		   for(var i=0 ; i < rows.length ; i++){
				    			   
				    			   if(parseInt(test[j])==parseInt(rows[i].prodoc)){
				    			   
				                   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "chkqty" ,1);
			 	    			   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "balqty" ,test2[j]);
				    			   }
				    			   
				    		   }
				    	 
				            	
				            }
				            	
				           }
			           
			           else
			        	   {
			        	   
			        	  
			        	   save();
			        	   }
			           
		 			    
		 			}
		 		  //type,description,remarks,lbrcost,partscost,total
		 	}
		 	 x.open("GET","validateqtys.jsp?list="+list+"&branch="+branch+"&location="+location+"&mode="+mode+"&dtype="+document.getElementById("cmbreftype").value,true);
				x.send();
			        
		 }

	   
	  
	   

	
	
	function save(){
	
	
	if($('#txtlocation').val()== "")
	{
	document.getElementById("errormsg").innerText="select location";
	document.getElementById("txtlocation").focus();
	return 0;
	}

	 $('#descPercentage').attr('disabled', false);
	 $('#txtdiscount').attr('disabled', false);
 var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
 var termrows = $("#jqxTerms").jqxGrid('getrows');
 
 
 $('#termsgridlength').val(termrows.length);
  
  var productcounter=0;
 for(var i=0 ; i < rows.length ; i++){ 
	 var qnty=rows[i].qty;
	 if(typeof(qnty) != "undefined" && typeof(qnty) != "NaN" && qnty != "" && qnty != "0" ){
	 	
	
	 
  newTextBox = $(document.createElement("input"))
     .attr("type", "dil")
     .attr("id", "prodg"+productcounter)
     .attr("name", "prodg"+productcounter)
     .attr("hidden", "true");
  //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::");
  // S[22::1::3::undefined::undefined::100::300::0::0::285.7142857142857::22::0::0::0::undefined::1::5::300::undefined::0::undefined::2::14.285714285714278::0000::],
 newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+
		 rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+
		 rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].locid+"::"+rows[i].taxper+"::"
		 +rows[i].taxamount+"::"+rows[i].allowdiscount+"::"+000+"::"+rows[i].collectqty+"::"+rows[i].taxdocno+"::"+rows[i].taxperamt+"::"+"0000"+"::");
  
 
/*  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+
		 rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+
		 rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].locid+"::"+rows[i].taxper+"::"
		 +rows[i].taxamount+"::"+rows[i].allowdiscount+"::"+000+"::"+rows[i].collectqty+"::"+rows[i].taxperamt+"::");  */
 
 
 newTextBox.appendTo('form');
 productcounter++;
	 } 
	    
 }
 $('#gridlength').val(productcounter);
 for(var i=0 ; i < termrows.length ; i++){ 
	   newTextBox = $(document.createElement("input"))      
	      .attr("type", "dil") 
	      .attr("id", "termg"+i)
	      .attr("name", "termg"+i)
	      .attr("hidden", "true");
	   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::");
	   
	  newTextBox.val(termrows[i].voc_no+"::"+termrows[i].dtype+"::"+termrows[i].terms+"::"+termrows[i].conditions+"::");
	  newTextBox.appendTo('form');
	  }
 
 var srows = $("#jqxserviceGrid").jqxGrid('getrows');
   $('#servgridlen').val(srows.length);
  for(var i=0 ; i < srows.length ; i++){
  // var myvar = rows[i].tarif; 
   newTextBox = $(document.createElement("input"))
      .attr("type", "dil")
      .attr("id", "serv"+i)
      .attr("name", "serv"+i)
      .attr("hidden", "true"); 
  
  newTextBox.val(srows[i].srno+"::"+srows[i].qty+" :: "+srows[i].description+" :: "
		   +srows[i].price+" :: "+srows[i].total+" :: "+srows[i].discount+" :: "+srows[i].nettotal+" :: "+srows[i].acno+" :: ");

  newTextBox.appendTo('form');
 
   
  
  
  }
 
  
  
  var rows = $("#shipdata").jqxGrid('getrows');
  $('#shipdatagridlenght').val(rows.length);
 //alert($('#gridlength').val());
 for(var i=0 ; i < rows.length ; i++){
 // var myvar = rows[i].tarif; 
  newTextBox = $(document.createElement("input"))
     .attr("type", "dil")
     .attr("id", "shiptest"+i)
     .attr("name", "shiptest"+i)
     .attr("hidden", "true"); 
 
 newTextBox.val(rows[i].doc_nos+"::"+rows[i].desc1+" :: "+rows[i].refno+" :: "+rows[i].date+" :: ");

// alert(newTextBox.val());
 newTextBox.appendTo('form');

  // alert("ddddd"+$("#test"+i).val());
  
 }  
 
  
  
  
  document.getElementById("frmSalesInvoice").submit();
} 


function setValues(){
 
 if($('#hiddate').val()){
		 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
	  }
 if($('#hidpayDueDate').val()){
	 $("#payDueDate").jqxDateTimeInput('val', $('#hidpayDueDate').val());
  }
 if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }


 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
 //funSetlabel();
 combochange();
 var hidvat=$('#hidcmbvatype').val();
//alert("hidvat===="+hidvat);
if(hidvat=="exclusive"){
	$('#cmbvatype').val("exclusive");
}
if(hidvat=="inclusive"){
	$('#cmbvatype').val("inclusive");
}
if(hidvat=="export"){
	$('#cmbvatype').val("export");
}

 var masterdoc_no=$('#masterdoc_no').val().trim();
 var refmasterdocno=$('#refmasterdocno').val().trim();
 var dtype=$('#formdetailcode').val().trim();
 
 var locationid=$('#locationid').val();
 
 
 var cmbreftype=$('#cmbreftype').val();
 
 
 if(masterdoc_no>0){
	 funchkforedit();
	  $("#invoiceDiv").load("invoiceGrid.jsp?qotdoc="+masterdoc_no+"&enqmasterdocno="+refmasterdocno+"&cmbreftype="+cmbreftype+"&locationid="+locationid+"&cond=2"+"&date="+document.getElementById("date").value);
	  
	  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+masterdoc_no);
	  $("#servicegrid").load("servicegrid.jsp?rdoc="+masterdoc_no);
	  
	  $("#shipdetdiv").load("shipdetailsGrid.jsp?masterdoc="+masterdoc_no+"&formcode="+$('#formdetailcode').val());
	  
	  	 
	  //checkout();
 }
 
 gettaxaccount(1);
 
	 
}

function getCustomer(event){
 var x= event.keyCode;
 	if(x==114){
	  
 	}
 }

function getCurrencyIds(){
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('####');
	           var curidItems=items[0].split(",");
	           var curcodeItems=items[1].split(",");
	           var currateItems=items[2].split(",");
	           var multiItems=items[3].split(",");
	           var optionscurr = '';
	          
	          //  curidItems.split(",");
	           // curcodeItems.split(",");
	           // currateItems.split(",");
	            for ( var i = 0; i < curcodeItems.length; i++) {
	           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
	           }
	            $("select#cmbcurr").html(optionscurr);
	          
	        
	            if($('#hidcmbcurr').val()!="")
				  {
			    	  // alert("currency=="+$('#hidcmbcurr').val());
				  
				  $('#cmbcurr').val($('#hidcmbcurr').val());   
				  
				  }
	   /*        else
	      {
	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
	           $("select#cmbcurr").html(optionscurr);
	          
	        //  $('#currate').val(currateItems) ;
	          
	          funRoundRate(currateItems,"currate");
	      
	          $('#currate').attr('readonly', true);
	       
	      } */
	    }
	       }
	   x.open("GET","getCurrencyId.jsp",true);
		x.send();
	        
	      
	        }


function getPriceGroup(){ 
	
	var clientid=document.getElementById("clientid").value;
	
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('####');
	           var pgid=items[0];
	           var pgcode=items[1];
	           var pgname=items[2];
	       //alert(pgname);
	           var optionspg = '';
	           if(pgname.indexOf(",")>=0){
	        	   var pgids=pgid.split(",");
	        	   var pgcodes=pgcode.split(",");
	        	   var pgnames=pgname.split(",");
	        	   /* alert(pgnames.length); */
	            for ( var i = 0; i < pgnames.length; i++) {
	            	
	            	optionspg += '<option value="' + pgids[i] + '">' + pgnames[i] + '</option>';
	           }
	           
	            
	        }
	   
	          else
	      {
	        	  optionspg += '<option value="' + pgid + '"selected>' + pgname + '</option>';
	         //  $("select#cmbprice").html(optionspg);
	       			       
	      }
	    }
	       }
	   x.open("GET","getPriceId.jsp?clientid="+clientid,true);
		x.send();
	        
	      
	        }



	   	  
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#customerDetailsWindow').jqxWindow('open');


	 clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow'));    }
	 else{
		 }
	 } 


function getDocumentSearch(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#customerDetailsWindow').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow'));    }
	 else{
		 }
	 } 



      function clientSearchContent(url) {
            
                $.get(url).done(function (data) {
   
	           $('#customerDetailsWindow').jqxWindow('setContent', data);

     	}); 
          	} 
      
      
      
      function termsSearchContent(url) {
   	   $('#searchwndow').jqxWindow('open');
            $.get(url).done(function (data) {
          	$('#searchwndow').jqxWindow('setContent', data);
          	$('#searchwndow').jqxWindow('bringToFront');

	}); 
      	} 
      
      
      function productSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#sidesearchwndow').jqxWindow('open');
      		$('#sidesearchwndow').jqxWindow('setContent', data);
      
      	}); 
      	} 


function refChange(){
	 $('#psearch').attr('disabled', false );
 var reftype=$('#cmbreftype').val();
  $("#jqxInvoiceGrid").jqxGrid('clear');
		 $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});

 if(reftype=='DIR'){
	  
	  $('#rrefno').attr('disabled', true);
	  $('#psearch').attr('disabled', false );
 }
 else{
	  
	  $('#rrefno').attr('disabled', false);
	  if(reftype!='JOR'){
	  $('#user_namess').attr('disabled', true);
		 $('#pass_wordss').attr('disabled', true);
		 $('#dscper').attr('disabled', true);
		 $('#process').attr('disabled', true);
		 $('#changeuser').attr('disabled', true);
	  }
	  
 }
 
 if(reftype=='JOR'){
	 $("#jqxserviceGrid").jqxGrid('addrow', null, {});
 chkaccount();
 }
 
}

function gridLoad(){
 var dtype=document.getElementById("formdetailcode").value;
 $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
}




function getrefno(event)
{
 
 var clientid=document.getElementById("clientid").value;
	
	if(clientid>0){
		
		document.getElementById("errormsg").innerText="";
		
	}
	else{
		document.getElementById("errormsg").innerText="Select a Customer";
		
		return 0;
	}
	
 
 
	 var x= event.keyCode;
	 if(x==114){
	  $('#refnosearchwindow').jqxWindow('open');
	
	  refsearchContent('refnosearch.jsp');  }
	 else{
		 }
	 }  
	
	  function refsearchContent(url) {
   //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#refnosearchwindow').jqxWindow('setContent', data);

	}); 
	}	
	  
	   function combochange()
            {
	   if($('#hidcmbcurrency').val()!="")
		  {
		  
		  
		  $('#cmbcurr').val($('#hidcmbcurrency').val());   
		  
		  }
	   if($('#hidcmbprice').val()!="")
		  {
		  
		  
		  $('#cmbprice').val($('#hidcmbprice').val());   
		  
		  }
	   
	   if($('#hidcmbbilltype').val()!="")
		  {
		  
		  
		  $('#cmbbilltype').val($('#hidcmbbilltype').val());   
		  
		  }
	    
	   
	   
	   
	   
		  if($('#hidcmbreftype').val()!="")
		  {
		  
		  
		  $('#cmbreftype').val($('#hidcmbreftype').val());
		  }
		 
		 if($('#hidcmbreftype').val()!="DIR")
		  {
		
		  $('#rrefno').attr('disabled', false);
		  
	  $('#rrefno').attr('readonly', true);
	
		  }
	   
		 if($('#cmbreftype').val()!='DIR'){
			 $('#btnDelete').attr('disabled', true);
		 }
		
		 
		 if($('#descPercentage').val()>0)
		  {
		  document.getElementById("chkdiscount").checked = true;
		  
		  }	 
		 
  }
	   
	   
	 function funcalcu()
	{
		
	 
		document.getElementById('prddiscount').value="";
		document.getElementById('roundOf').value="";
		$('#jqxInvoiceGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
		var  productTotal=document.getElementById('txtproductamt').value;
		var  descPercentage=document.getElementById('descPercentage').value;
		//alert("pro"+productTotal);
		//alert("descPercentage"+descPercentage);
		//productTotal descPercentage
		var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
		var netval=parseFloat(productTotal)-parseFloat(descvalue);
		var  roundOf=document.getElementById('roundOf').value;
		if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") 
		{
			netval=parseFloat(productTotal)+parseFloat(roundOf);
		}
		funRoundAmt2(descvalue,"txtdiscount");
		funRoundAmt2(netval,"txtnettotal");
		var aa;
	
		if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
		{
			aa=parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
		}
		else
		{
			aa=document.getElementById("txtnettotal").value;
		}
		document.getElementById("orderValue").value=aa;	
		document.getElementById("orderValuefinal").value=aa;	
		funRoundAmt2(aa,"orderValue");
		funRoundAmt2(aa,"orderValuefinal");
		var rows = $('#jqxInvoiceGrid').jqxGrid('getrows');
		var rowlength= rows.length;
	  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
	  	for(var i=0;i<rowlength;i++)
	  	{
	  		var totamt=rows[i].total;
	  		var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
	  		var nettot=parseFloat(totamt)-parseFloat(discounts);
	  		$('#jqxInvoiceGrid').jqxGrid('setcellvalue',i, "dis" ,discounts.toFixed(2));
	  		$('#jqxInvoiceGrid').jqxGrid('setcellvalue',i, "netotal" ,nettot.toFixed(2));
	  	}
		 
	
		
		}
		
	 	function funwarningopen(){
		 	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
		 	       if (r){
		 	    	   $('#chkdiscount').attr('disabled', false);
		 			   
		 	    	  if(document.getElementById("chkdiscount").checked == true)
		 	    		  
		 	    		  {
		 		 		 $('#descPercentage').attr('disabled', false);
		 		 		 $('#btnCalculate').attr('disabled', false);
		 		 		 $('#txtdiscount').attr('disabled', false);
		 		 		    
		 		 		  
		 		 	 
		 	    		  }
		 		 	 
		 			   
		 			   document.getElementById("editdata").value="Editvalue";
		 			  $('#cmbvatype').attr('readonly', false);
						 $('#cmbvatype').attr('disabled', false);
						 $('#psearch').attr('disabled', false);
		 			  $("#jqxInvoiceGrid").jqxGrid({ disabled: false});
						$("#jqxserviceGrid").jqxGrid({ disabled: false});
						$("#jqxTerms").jqxGrid({ disabled: false});
						
						
						$("#shipdata").jqxGrid({ disabled: false});
						
						 $("#shipdata").jqxGrid('addrow', null, {});
		 	      
		 	    	    $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
		 	    	    
		 	     
		 	    	    $("#jqxserviceGrid").jqxGrid('addrow', null, {});
		 	    		
		 	    	   $("#jqxTerms").jqxGrid('addrow', null, {});
		 	       }
		 	      });
		 	   }
		
		  
		
		
	function funvalcalcu()
		{
		
		
		document.getElementById('prddiscount').value="";
		$('#jqxInvoiceGrid').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
		var  productTotal=document.getElementById('txtproductamt').value;
		var  descountVal=document.getElementById('txtdiscount').value;
	 
		var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
		var netval=parseFloat(productTotal)-parseFloat(descountVal);
		
	 
		funRoundAmt2(descper,"descPercentage");
		funRoundAmt2(netval,"txtnettotal");
		funcalcu();
		}

	/* 		
	 function roundval()
	{
			var  netTotaldown=document.getElementById('txtnettotal').value;
		    var roundOf=document.getElementById('roundOf').value;
			 
			var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
			funRoundAmt(netval,"txtnettotal");
			funRoundAmt(netval,"orderValue");
	}
	  */
	function isNumber(evt) {
   var iKeyCode = (evt.which) ? evt.which : evt.keyCode
   if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
   	{
	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
      
       return false;
   	}
   document.getElementById("errormsg").innerText="";  
   return true;
}
	
 	function isNumber1(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
        
           if (iKeyCode == 45)
                      
             {
            
            
             return true;
               } 
          
          
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
         document.getElementById("errormsg").innerText=" Enter Numbers Only";  
           
            return false;
         }
        document.getElementById("errormsg").innerText="";  
        return true;
    }
	
	function fundisable()
	{
		
		   if (document.getElementById('chkdiscount').checked) {
		$.messager.confirm('Confirm', 'Line Discount Will Override With Bill Discount', function(r){
			if (r==false){
				document.getElementById('chkdiscount').checked=false;
				return 0;
			}
			else
				{
		
		
				
				   if (document.getElementById('chkdiscount').checked) {
					   $('#btnCalculate').attr('disabled', false);
				  $('#descPercentage').attr('disabled', false);
				 $('#txtdiscount').attr('disabled', false);
				 
				 
			
				    
				  
		   }
		  
		   
				}
			
			
		      
	      });
		   }
		   else
		   {
		   document.getElementById('descPercentage').value="";
		   document.getElementById('txtdiscount').value="";
		   var summaryData3= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
		   $('#descPercentage').attr('disabled', true);
			 $('#txtdiscount').attr('disabled', true);
				$('#jqxInvoiceGrid').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
		   }
	   
		}
	
	function chkfoc()
    {
     
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
     {
       var items= x.responseText.trim();
       var item = items.split('##');
			var foc  = item[0];
			var kg = item[1];
       if(parseInt(foc)>0)
        {
      
        
        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'foc');
     
        
        
         }
           else
       {
       
            $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'foc');
       
       }
       
        if(parseInt(kg)>0)
       {
     
       
       $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'kgprice');
       $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'totwtkg');
    
       
       
        }
          else
      {
      
           $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'kgprice');
           $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'totwtkg');
      
      } 
       
       
       
        }}
    x.open("GET","checkfoc.jsp",true);
  x.send();
  
       
         
     
    }
	
	function checkout()
  	{
  		var rdocno=$('#masterdoc_no').val().trim();
  	var x=new XMLHttpRequest();
  	x.onreadystatechange=function(){
  	if (x.readyState==4 && x.status==200)
  	 {
  	   var items= x.responseText.trim();
  		var qty = items;

  		if(parseInt(qty)>0){
  			$("#btnEdit").attr('disabled', true );
  			$("#btnDelete").attr('disabled', true );
  		}
  		else{
  			$("#btnEdit").attr('disabled', false );
  			$("#btnDelete").attr('disabled', false );
  		}
  	   
  	   }}
  	x.open("GET","checkout.jsp?rdocno="+rdocno,true);
  	x.send();
  	  
  	}


	function funchkforedit()
    {
	

	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					
					 $("#btnEdit").attr('disabled', true );
					 $("#btnDelete").attr('disabled', true ); 
					 
					 
					 
					}
				else
					{
					 
					}
			  
		/* 		$("#btnEdit").attr('disabled', true );
				 $("#btnDelete").attr('disabled', true );  */
				
				
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value+"&reftype="+document.getElementById("cmbreftype").value+"&refmasterdocno="+document.getElementById("refmasterdocno").value, true);
		x.send();
	
	
	}
	
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveSalesInvoicecr");
	        
	        $("#docno").prop("disabled", false);                
	        
	  
	var win= window.open(reurl[0]+"printinvcredit?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=CREDIT","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus();
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	
	   
		function funckangeuser()
	    {
		
			 $("#overlay, #PleaseWait").show();
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					
					  var item = items.split('::');
					  
					  var userid= item[0];
					 	
						var discper = item[1];
						
						
						var catid=item[2];
					  
					if(parseInt(userid)>0)
						{
						
						document.getElementById("dscper").value= discper;
						
						document.getElementById("clientcaid").value= catid;
						  $.messager.alert('Message','User Has Been Changed');
						  
						  
						  funreloadhidegrid();
							document.getElementById("checkhidegrid").value="1";
						  
			    	      return false;
						 
						}
					else
						{
						 $("#overlay, #PleaseWait").hide();
						  $.messager.alert('Message','Not Changed');
			    	      return false;
						}
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "changeuser.jsp?userids="+document.getElementById("userids").value+"&pass_wordss="+document.getElementById("pass_wordss").value, true);
			x.send();
		
		
		}
		  
		function funcksalesman()
	    {
		

			
			
			
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					 
					 var items= x.responseText.trim();
				       var item = items.split('##');
				       

				  /*  	response.getWriter().print(saldocno+"##"+catid+"##"+userdoc+"##"+salesman+"##"+username+"##"+usgper+"##");
 */				       
							var saldocno  = item[0];
							 	
							var catid = item[1];
							
							var userdoc = item[2];
							var salesman = item[3];
							
							var username = item[4];
							var usgper = item[5];
					
							document.getElementById("salespersonid").value=item[0];
							document.getElementById("clientcaid").value= item[1];
							
							document.getElementById("userdocno").value= item[2];
							
							document.getElementById("txtsalesperson").value=item[3];
							
							document.getElementById("user_namess").value= item[4];
							document.getElementById("userids").value= item[4];
					
							document.getElementById("dscper").value= item[5];
							
						
							document.getElementById("salesmanusgper").value= item[5];
							
						 
					
					
				} else {
				}
			}
			x.open("GET", "salesmanset.jsp?", true);
			x.send();
		
		
		}
		  
		
	 function funprocess()
	 {
		       
		 
		 $("#overlay, #PleaseWait").show();       
		 
			$("#jqxInvoiceGrid").jqxGrid({ disabled: true});
		 
		 if(parseInt(document.getElementById("checkhidegrid").value)==1)
			 {
		 var rows  = $("#jqxInvoiceGrid").jqxGrid('getrows');
		 var rows1 = $("#hidegrids").jqxGrid('getrows');
		 
		 for(var i=0 ; i < rows.length ; i++){ 
			 
			 for(var j=0 ; j<rows1.length ; j++){
				 
				 if(parseInt(rows1[j].doc_no)==parseInt(rows[i].prodoc))
					 {
					 
				     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "allowdiscount",rows1[j].allowdiscount);
					 
					 break;
					 }
				 
			 }
			 
			 
		 }
           
			 }
		 var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
		 
		 for(var i=0 ; i < rows.length ; i++){ 
			  
			   if(parseInt(rows[i].prodoc)>0)
				 {  
			  
		  
				
		         var dscper=document.getElementById("dscper").value;
		     	      
		     	 var allowdiscount=rows[i].allowdiscount;
		     	
		     	 var discallowper=0;
			       
 
				      	if(dscper!="" || dscper!=null)
				      		{
				      		 discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  print
				      		 if(discallowper>0)
			      			 {
				            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper",discallowper);
				     	
			      			 }
				      		}
			
		  }  
		  
	    }
		 
		 $("#overlay, #PleaseWait").hide();   
		 $("#jqxInvoiceGrid").jqxGrid({ disabled: false});
		 
	 } 
	 
	 
	function funreloadhidegrid()
	{
		
		 var prodsearchtype=$("#prodsearchtype").val();
    	 var refmasterdocno=$('#refmasterdocno').val();
    	 var reftype=$("#cmbreftype").val();
		 var cmbprice=document.getElementById("cmbprice").value;
		 var cmbreftype=document.getElementById("cmbreftype").value;
		 var clientcaid=document.getElementById("clientcaid").value; 
		 var clientid=document.getElementById("clientid").value;
		 var dates=document.getElementById("date").value;
		 $("#hidegrid").load("hidegrid.jsp?prodsearchtype="+prodsearchtype+"&enqmasterdocno="+refmasterdocno+"&reftype="+reftype+"&cmbprice="+cmbprice+"&clientid="+clientid+"&cmbreftype="+cmbreftype+"&location="+document.getElementById("locationid").value+"&clientcaid="+clientcaid+"&dates="+dates);
		 $("#overlay, #PleaseWait").hide();
	 
	}
	function gettaxaccount(val)
	{
	 
	
		 
		
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText.trim();
	     
	      var item = items.split('::');
 
	  
	      var method=item[0];
	      
	      var aa=item[1];
	      
	      if(parseInt(method)>0)
	    	  {
	     	  if(parseInt(aa)==0)
    		  {
	    		 	$('#taxsss').hide();
	    		 	$('#process1').hide(); 
	    		  	$('#taxontax1').hide();
    		  		$('#taxontax2').hide();
    		  		$('#taxontax3').hide();
    		    
    		  }
	    	  if(parseInt(aa)==1)
	    		  {
	    		  
	    		  document.getElementById("tax1per").value=item[3];
	    		  document.getElementById("labeltax1").innerText=item[2];
	    		  document.getElementById("typeoftaken").value=item[6];
	    		  
	    	 
	    		  $('#taxontax2').hide();
	    		  $('#taxontax3').hide();
	    		    
	    		  }
	    	  
	    	  if(parseInt(aa)==2)
    		  {
	    	
    		  document.getElementById("tax1per").value=item[3];
    		  document.getElementById("labeltax1").innerText=item[2];
    		  
    		  document.getElementById("tax2per").value=item[5];
    		  document.getElementById("labeltax2").innerText=item[4];
    		  
    		  document.getElementById("typeoftaken").value=item[6];
    		  
    		  
    		 
    		  $('#taxontax3').hide();
    		  
    		  }
	    	  
	    	  if(parseInt(aa)==3)
    		  {
	    	
    		  document.getElementById("tax1per").value=item[3];
    		  document.getElementById("labeltax1").innerText=item[2];
    		  
    		  document.getElementById("tax2per").value=item[5];
    		  document.getElementById("labeltax2").innerText=item[4];
    		  
    		  document.getElementById("typeoftaken").value=item[6];
    		  
    		  
    		  document.getElementById("tax3per").value=item[8];
    		  document.getElementById("labeltax3").innerText=item[7];
    		  
    		  
    		  }
	    	  
	    	  
	    	  }
	      
		  
	       }}
	   x.open("GET","gettaxaccount.jsp?date="+document.getElementById("date").value+"&cmbbilltype="+document.getElementById("cmbbilltype").value,true);
		x.send();
	 
	      
	        
		
	} 
	function gettaxaccounts()
	{
		
		 $("#jqxInvoiceGrid").jqxGrid('clear');
		    $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
		gettaxaccount(1);
	}
	
	
	
	function funcalutax()
	{
		
		
		var tax1=document.getElementById("tax1per").value;
		var tax2=document.getElementById("tax2per").value;
		
		var tax3=document.getElementById("tax3per").value;
		
		var typeoftaken=document.getElementById("typeoftaken").value;
		 
		var st=document.getElementById("st").value;
		
		var producttotal=document.getElementById("txtnettotal").value;
		var tax1val=0;
		var tax2val=0;
		var tax3val=0;
		var finaltax=0;
		
		if(parseInt(typeoftaken)==-1)
			{
			if(parseFloat(tax1)>0)
				{
				tax1val=parseFloat(producttotal)*(parseFloat(tax1)/100);
				
				
				if(parseFloat(tax2)>0)
				{
				tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100);
				}
				else
					{
					tax2val=0;
					}
				
				
						if(parseFloat(tax3)>0)
						{
							tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100);
						}
						else
							{
							tax3val=0;
							}
				
				
				
				
				finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
				
				
				
				}
			}
			
			else {
				
				if(parseFloat(tax1)>0)
				{
				tax1val=parseFloat(st)*(parseFloat(tax1)/100);
				if(parseFloat(tax2)>0)
				{
				tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100);
				}
				else
					{
					tax2val=0;
					}
				

				if(parseFloat(tax3)>0)
				{
					tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100);
				}
				else
					{
					tax3val=0;
					}
		
		
		
				
				finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
				

				/* funRoundAmt(finaltax,"taxtotal");
				
				var aa=document.getElementById("taxtotal").value;
				
		 
				
				
				var bb=parseFloat(finaltax)-parseFloat(aa);
			 
				
				
				if(parseFloat(bb)==0)
					{
					 
					}
				else
					{
					finaltax=parseFloat(finaltax)+0.01;
					} */
				
				
		 
				
				
				}
			}
			
			
		 
			
			
			
		
		funRoundAmt2(tax1val,"taxontax1"); 
		funRoundAmt2(tax2val,"taxontax2");
		funRoundAmt2(tax3val,"taxontax3");
		funRoundAmt2(finaltax,"taxtotal");
		
	 
		
		
		 	
		
	}
	
	function funRoundAmt4(value,id){
		  var res=parseFloat(value).toFixed(4);
		  var res1=(res=='NaN'?"0":res);
		  document.getElementById(id).value=res1;  
		 }  
	
	function funRoundAmt2(value,id){
		  var res=parseFloat(value).toFixed(2);
		  var res1=(res=='NaN'?"0":res);
		  document.getElementById(id).value=res1;  
		 }  
	function getSaleDet(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 
				 var items= x.responseText.trim();
				 var item = items.split('::');
				 document.getElementById("salelbl").innerText="Dt-"+item[0]+" "+"SP:-"+item[1];
				 document.getElementById("hidsellprice").value=item[1];
			}}
		   x.open("GET","getSaleDetails.jsp?cldoc="+document.getElementById("clientid").value+"&psrno="+document.getElementById("hidpsrno").value,true);
			x.send();
	}
	function getVatConfig(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 
				 var items= x.responseText.trim();
				 //alert("items===="+items);
			       if(parseFloat(items)==1){
			    	   $('#cmbvatype').show();
				    	  $('#vatype').show();  	  
			      }else{
			    	  $('#cmbvatype').hide();
			    	  $('#vatype').hide();
			    	  document.getElementById("cmbvatype").value="";
			    	  document.getElementById("cmbvatype").value="exclusive";
			      } 
			}}
		   x.open("GET","getvatconfig.jsp",true);
			x.send();
	}
	
	function getAlternativeConfig(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 
				 var items= x.responseText.trim();
				 //alert("items===="+items);
			       if(parseFloat(items)==1){
			    	   $('#setbtn2').show();				    	  	  
			      }else{
			    	  $('#setbtn2').hide();
			    	
			      } 
			}}
		   x.open("GET","getalternativeconfig.jsp",true);
			x.send();
	}
	function prosrch(){
		var prodsearchtype=$("#prodsearchtype").val();
    	var refmasterdocno=$("#refmasterdocno").val();
    	var reftype=$("#cmbreftype").val();
    	var clientid=document.getElementById("clientid").value;
		var cmbprice=document.getElementById("cmbprice").value;
  		var cmbreftype=document.getElementById("cmbreftype").value;
   		 var clientcaid=document.getElementById("clientcaid").value; 
   		 var dates=document.getElementById("date").value;
   		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
   		//var prddata=document.getElementById("prddata2").value;
   		//alert(prddata);
   			 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+'&location='+document.getElementById("locationid").value+'&clientcaid='+clientcaid+'&dates='+dates+'&cmbbilltype='+cmbbilltype+'&id=1'+'&hidalterid=1');
   			// $('#sidesearchwndow').jqxWindow('setContent', 'productSearch.jsp');
   			 //window.open('productSearch.jsp');
   			/*  var url='productSearch.jsp?id=1';
   			 $.get(url).done(function (data) {
   	 			$('#sidesearchwndow').jqxWindow('open');
				$('#sidesearchwndow').jqxWindow('setContent', data);
   			 }); */
		
	}
	
	function alterprosrch(){
		
   		var hidpsrno=document.getElementById("hidpsrno").value;
   		//alert(prddata);
   			 productSearchContent('productSearch.jsp?id=1'+'&hidpsrno='+hidpsrno+'&hidalterid=2');
   			// $('#sidesearchwndow').jqxWindow('setContent', 'productSearch.jsp');
   			 //window.open('productSearch.jsp');
   			/*  var url='productSearch.jsp?id=1';
   			 $.get(url).done(function (data) {
   	 			$('#sidesearchwndow').jqxWindow('open');
				$('#sidesearchwndow').jqxWindow('setContent', data);
   			 }); */
		
	}
	
	function vatChange(){
		//alert("in vat change");
		document.getElementById("quantity").value=0;
		document.getElementById("uprice").value=0;
		document.getElementById("dict").value=0;
		document.getElementById("dispers").value=0;
		document.getElementById("taxamountstotal").value=0;
		document.getElementById("amounts").value=0;
		document.getElementById("taxamounts").value=0;
		
		document.getElementById("totamt").value=0;
		var type=document.getElementById("cmbvatype").value;
		if(type=="export"){
			document.getElementById("taxpers").value=0;
			 var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');   
			 var chk=rows.length-1;
			 //alert("chk===="+chk);
			 if(parseFloat(chk)>0){
        	  for(var i=0;i<rows.length-1;i++){
        	   		$('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",0); 
           		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt",0);
           		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "qty",0);
           		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "unitprice",0);
           		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal",0);
           		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "dis",0);
           		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper",0);
           		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount",0);
        	  }
			 }
		}
		if(type=="exclusive"){
			var tsk=document.getElementById("taxpers").value;
			 var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');   
			 var chk=rows.length-1;
			 //alert("chk===="+chk);
			 if(parseFloat(chk)>0){
       	  for(var i=0;i<rows.length-1;i++){
       	   		
       		if(parseFloat(tsk)>0){
    		       $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",5);
    	   		}else{
    	   		$('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",0);
    	   		}
          		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt",0);
          		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "qty",0);
          		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "unitprice",0);
          		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal",0);
          		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "dis",0);
          		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper",0);
          		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount",0);
       	  }
			 }
		}
		if(type=="inclusive"){
			var tsk=document.getElementById("taxpers").value;
			 var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');   
			 var chk=rows.length-1;
			 //alert("chk===="+chk);
			 if(parseFloat(chk)>0){
      	  for(var i=0;i<rows.length-1;i++){
      	   		
      		if(parseFloat(tsk)>0){
 		       $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",5);
 	   		}else{
 	   		$('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",0);
 	   		}
         		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt",0);
         		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "qty",0);
         		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "unitprice",0);
         		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal",0);
         		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "dis",0);
         		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper",0);
         		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount",0);
      	  }
			 }
		}
		
	}
	
	function vatSwitch(){
        var upr=document.getElementById("uprice").value;
		
		var sprice=document.getElementById("hidsellprice").value;
		/* if(parseFloat(upr)>0 && parseFloat(sprice)>0){
		if(parseFloat(upr)<parseFloat(sprice)){
			//document.getElementById("errormsg").innerText="Enter Unit Price Greater Than Last Selling Price ";
			 $.messager.alert('Message','Enter Unit Price Greater Than Last Selling Price ');
			document.getElementById("uprice").focus();
		}
		} */
var frmdis=document.getElementById("dispers").value;
		
		var allw=document.getElementById("allowdiscount").value;
		
		if(parseFloat(allw)>0 && parseFloat(frmdis)>0){
			if(parseFloat(frmdis)<parseFloat(allw)){
				
			}
			else{
				document.getElementById("dispers").value=allw;
				//document.getElementById("errormsg").innerText="Maximum Allowed Discount Is "+allw.toFixed(2);
			}
		}
		var type=document.getElementById("cmbvatype").value;
		//alert("type======"+type);
		if(type=="exclusive"){
			calculatedatas(this.id);
		}
		if(type=="inclusive"){
			calcincl();
		}
        if(type=="export"){
			calcexp();
		}
	}
	
	function calcincl(){
		//alert("in inclusive");
		var qty=document.getElementById("quantity").value;
		var unitprce=document.getElementById("uprice").value;
		var tsk=document.getElementById("taxpers").value;
        var calfix="100";
		
		if(parseFloat(unitprce)>0){
		var cal=parseFloat(calfix)+parseFloat(tsk);
		var total=parseFloat(qty)*parseFloat(unitprce);
		funRoundAmt2(total,"totamt");
		var dis=document.getElementById("dispers").value;
		if(parseFloat(dis)>0){
		var disamt=(parseFloat(total)/100)*parseFloat(dis);
		//document.getElementById("dict").value=disamt;
		 funRoundAmt2(disamt,"dict");
		var net=parseFloat(total)-parseFloat(disamt);
		//document.getElementById("taxamountstotal").value=net;
		 funRoundAmt2(net,"taxamountstotal");
		var net1=(parseFloat(net)/cal)*100;
		//document.getElementById("amounts").value=net1;
		 funRoundAmt2(net1,"amounts");
		var taxamt=parseFloat(net)-parseFloat(net1);
		//document.getElementById("taxamounts").value=taxamt;
		 funRoundAmt2(taxamt,"taxamounts");
		}else{
			funRoundAmt2(total,"taxamountstotal");
			var net1=(parseFloat(total)/cal)*100;
			funRoundAmt2(net1,"amounts");
			var taxamt=parseFloat(total)-parseFloat(net1);
			//document.getElementById("taxamounts").value=taxamt;
			 funRoundAmt2(taxamt,"taxamounts");
		}
		}
	}
	
    function calcexp(){
    	//alert("in export");
    	document.getElementById("taxamounts").value=0;
    	document.getElementById("taxpers").value=0;
    	calculatedatas(this.id);
	}
    function getDefaultLocation(){
    	//alert("in locationset===");
    	var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 
				 var items= x.responseText.trim();
			       var item = items.split('::');
		
				          document.getElementById("locationid").value=item[0];
			               document.getElementById("txtlocation").value=item[1];
			              
			              	
			} else {
			}
		}
		x.open("GET", "locationset.jsp", true);
		x.send();
    	
    }
    
    function detailstock(){
	    
		 var aa=document.getElementById("hidpsrno").value;
		 
		 if(aa=="" ||aa==null || typeof(aa)=="undefiend") 
			 {
				document.getElementById("errormsg").innerText="Select a product";
	   			  

				 
			     document.getElementById("jqxInput1").focus();
	   			 
	   		   return 0;
			 
			 }
		 
		
		 var url=document.URL;
	 		var reurl=url.split("com/");
	 		var mod="v";
	 		/* window.parent.formName.value="";
	 		window.parent.formCode.value=""; */
	 		var detName= "Detail Stock Enquiry";
	 		
	var pname=document.getElementById("jqxInput1").value;

	 		var pna = pname.replace(/[^\w\s]/gi, '');
	 		
	 		
	 		 var path1='com/dashboard/procurment/detailstocklist/detailstocklist.jsp';  
	 
	    		    var path= path1+"?&temppsrno="+document.getElementById("hidpsrno").value+"&pna="+pna+"&mod="+mod;
	    		    		   
	      
	 		top.addTab( detName,reurl[0]+""+path);  
		 
		
	
}
    
	function funckclientcat()
    {
	

		
		
		
	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 
				 var items= x.responseText.trim();
			       var item = items.split('##');
	
				 
						
				 
				
				          document.getElementById("catid").value=item[0];
			               document.getElementById("clientcaid").value=item[0];
			               
			               document.getElementById("clientpricegroup").value=item[1];
			               var aa=item[1];
			               if(parseInt(aa)==0)
			            		   {
			            		 $('#user_namess').attr('disabled', false);
								 $('#pass_wordss').attr('disabled', true);
								 $('#dscper').attr('disabled', false);
								 $('#process').attr('disabled', true);
								 
								 $('#changeuser').attr('disabled', false);
								 funcksalesman();
								 
			            		   }   
			               else
			            	   {
			            	   
			            	  
			            		 $('#user_namess').attr('disabled', true);
								 $('#pass_wordss').attr('disabled', true);
								 $('#dscper').attr('disabled', true);
								 $('#process').attr('disabled', true);
								 $('#changeuser').attr('disabled', true);
			            	   }
			               
						
					 
				
				
			} else {
			}
		}
		x.open("GET", "clientcatchk.jsp?cldocno="+document.getElementById("clientid").value, true);
		x.send();
	
	
	}
		  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>

</head>
<body onload="setValues();getDefaultLocation();getVatConfig();getAlternativeConfig();getCurrencyIds();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSalesInvoice" action="saveSalesInvoicecr" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="calculation.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include>
<div  class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<%-- <table width="100%" border="1">
  <tr>
    <td     align="right">Date</td>
    <td  ><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td   align="right">Ref. No.</td>
    <td  ><input type="text" id="txtrefno" name="txtrefno" style="width:50%;" value='<s:property value="txtrefno"/>'/></td>
    <td align="right">Mode of Pay</td>
  <td><select id="cmbmodeofpay" name="cmbmodeofpay" style="width:51%;" value='<s:property value="cmbmodeofpay"/>'>
      <option value="cash">CASH</option></select>
      <input type="hidden" id="hidcmbmodeofpay" name="hidcmbmodeofpay" value='<s:property value="hidcmbmodeofpay"/>'/></td>
  <td align="right">Location</td>
  <td><input type="text" id="txtlocation" name="txtlocation" style="width:50%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onkeydown="getLocation(event);"/>
      <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/></td>
    <td   align="right">Doc No.</td>
    <td  ><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
  <td align="right">Sales Person</td>
  <td><input type="text" id="txtsalesperson" name="txtsalesperson" style="width:71%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
      
      
      <td align="right">User Name</td>
  <td><input type="text" id="usernames" name="usernames" style="width:71%;"  value='<s:property value="usernames"/>'>
      <input type="hidden" id="userids" name="userids" value='<s:property value="userids"/>'/></td>
          <td align="right">Password</td>
  <td><input type="password" id="pass_words" name="pass_words" style="width:71%;"  value='<s:property value="pass_words"/>'>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <button type="button" class="icon" id="process" title="Process" onclick="funprocess();">
							<img alt="process" src="<%=contextPath%>/icons/changeuser.png" width="18" height="18">
						    </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						    </td>  
      
  <td colspan="3" rowspan="2">
					 &nbsp;&nbsp; <button type="button" class="icon" id="process" title="Process" onclick="funprocess();">
							<img alt="process" src="<%=contextPath%>/icons/process2.png" width="18" height="18">
						   </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
 --%>
 
 <table width="100%"  >
  <tr>                              
    <td width="8%"     align="right">Date</td>
    <td width="11%"  ><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="6%"   align="right">Ref. No.</td>
    <td width="13%"  ><input type="text" id="txtrefno" name="txtrefno" style="width:90%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="7%" align="right">Mode of Pay</td>
  <td width="16%"><select id="cmbmodeofpay" name="cmbmodeofpay" style="width:61%;" value='<s:property value="cmbmodeofpay"/>'>
      <option value="credit">CREDIT</option></select>
      <input type="hidden" id="hidcmbmodeofpay" name="hidcmbmodeofpay" value='<s:property value="hidcmbmodeofpay"/>'/></td>
  <td width="6%" align="right">Location</td>
  <td width="17%"><input type="text" id="txtlocation" name="txtlocation" style="width:95%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onkeydown="getLocation(event);"/>
      <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/></td>
    <td width="5%"   align="right">Doc No.</td>
    <td width="11%"  ><input type="text" id="docno" name="docno" style="width:80%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
 <%--  <tr>
  <td   align="right">Sales Person</td>
  <td><input type="text" id="txtsalesperson" name="txtsalesperson" style="width:100%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
      

      <td align="right">User Name</td>   
  <td><input type="text" id="user_namess" name="user_namess" style="width:90%;"   autocomplete="off" placeholder="Press F3 to Search" onKeyDown="getuser(event);" value='<s:property value="user_namess"/>'>
      <input type="hidden" id="userids" name="userids" value='<s:property value="userids"/>'/>
       <input type="hidden" id="userdocno" name="userdocno" value='<s:property value="userdocno"/>'/></td>
          <td align="right">Password</td>
  <td><input type="text" id="pass_wordss" name="pass_wordss" class="classpass" style="width:60%;"  autocomplete="off"  value='<s:property value="pass_wordss"/>'>
   <button type="button" class="icon" id="process" title="Process" onclick="funckangeuser();">
							<img alt="process" src="<%=contextPath%>/icons/changeuser.png" width="18" height="18">
						    </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						    </td>  
      
  <td colspan="4"  >
					 &nbsp;&nbsp; <button type="button" class="icon" id="process" title="Process" onclick="funprocess();">
							<img alt="process" src="<%=contextPath%>/icons/process2.png" width="18" height="18">
						   </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr> --%>
</table>
<fieldset>
<table width="100%"  >   
  <tr>
    <td width="7%" align="right">Customer</td>
    <td width="14%"><input type="text" id="txtclient" name="txtclient" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/></td>
    <td colspan="3"><input type="text" id="txtclientdet" name="txtclientdet" style="width:48%;" value='<s:property value="txtclientdet"/>'   tabindex="-1"/>
    &nbsp;&nbsp;&nbsp;&nbsp;MOB&nbsp;
    <input type="text" id="txtclientmob" name="txtclientmob"  style="width:20%;" value='<s:property value="txtclientmob"/>'   tabindex="-1"/>
    </td>
  </tr>
  <tr>
    <td   align="right">Currency</td>
   <td  ><select name="cmbcurr" id="cmbcurr" style="width:73%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select><input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/></td>
    <td colspan="3"><input type="text" id="currate" name="currate" style="width:13%;" value='<s:property value="currate"/>'/>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <label id="billname">Bill Type</label>&nbsp;<select id="cmbbilltype" name="cmbbilltype"  onchange="gettaxaccounts()"  style="width:13%;" value='<s:property value="cmbbilltype"/>'>
      <option value="1">ST</option>
      <option value="2">CST</option>
      
      </select>
      <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
       <label id="vatype">Vat Type</label><select id="cmbvatype" name="cmbvatype" style="width:13%;" onchange="vatChange();" value='<s:property value="cmbvatype"/>'>
       <option value="inclusive">Inclusive</option>
       <option value="exclusive">Exclusive</option>
       <option value="export">Export</option>
       </select>
      <input type="hidden" id="hidcmbvatype" name="hidcmbvatype" value='<s:property value="hidcmbvatype"/>'/>
      
    
    </td>
  </tr>
  <tr>
    <td align="right">Ref. Type</td>
    <td><select id="cmbreftype" name="cmbreftype" style="width:71%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
       <option value="DIR">DIR</option>
       <option value="SOR">SOR</option>
       <option value="DEL">DEL</option>
       <!-- <option value="JOR">JOR</option> -->
       </select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
     <td width="14%"><input type="text" id="rrefno" name="rrefno" style="width:100%;" placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/></td> 
     <%-- <td>Sales Order
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="rrefno" name="rrefno" style="width:35%;"  placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/>
     </td> --%>
    <td width="5%" align="right">&nbsp;</td>
    <td width="53%"> <select hidden="true" id="cmbprice" name="cmbprice" style="width:20%;" value='<s:property value="cmbprice"/>'>
      <option value="1">Max Rate1</option>
       <option value="2">Mid Rate2</option>
         <option value="3">Min Rate3</option> </select>
      <input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Due on</td>     
    <td><div id="payDueDate" name="payDueDate" value='<s:property value="payDueDate"/>'></div>
    <input type="hidden" id="hidpayDueDate" name="hidpayDueDate" value='<s:property value="hidpayDueDate"/>'/></td>
    <td align="left" colspan="3">Del. Terms <input type="text" id="txtdelterms" name="txtdelterms" style="width:65%;" value='<s:property value="txtdelterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="4"><input type="text" id="txtpaymentterms" name="txtpaymentterms" style="width:75%;" value='<s:property value="txtpaymentterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" id="txtdescription" name="txtdescription" style="width:75%;" value='<s:property value="txtdescription"/>'/>
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
    
    
    </td>
  </tr>
</table>
</fieldset><br/>

 
<table width="96%"  id="disitems"  > 
 <tr>
  <td width="7%"   align="right">Sales Person</td>  
  <td width="15%"><input type="text" id="txtsalesperson" name="txtsalesperson" style="width:100%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
      

      <td width="7%" align="right">User Name</td>   
  <td width="16%"><input type="text" id="user_namess" name="user_namess" style="width:90%;"   autocomplete="off" placeholder="Press F3 to Search" onKeyDown="getuser(event);" value='<s:property value="user_namess"/>'>
      <input type="hidden" id="userids" name="userids" value='<s:property value="userids"/>'/>
       <input type="hidden" id="userdocno" name="userdocno" value='<s:property value="userdocno"/>'/></td>
          <td width="6%" align="right">Password</td>
  <td width="17%"><input type="text" id="pass_wordss" name="pass_wordss" class="classpass" style="width:60%;"  autocomplete="off"  value='<s:property value="pass_wordss"/>'>
   <button type="button" class="icon" id="changeuser" title="changeuser" onclick="funckangeuser();">
							<img alt="changeuser" src="<%=contextPath%>/icons/changeuser.png" width="18" height="18">
						    </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						    </td>  
       <td width="5%" align="right">Percentage</td>
       
        <td width="15%">  <input type="text" id="dscper" name="dscper"  style="width:25%;"   value='<s:property value="dscper"/>'/></td>
       
  <td width="12%" colspan="4"  >
					 &nbsp;&nbsp; <button type="button" class="icon" id="process" title="Process" onclick="funprocess();">
							<img alt="process" src="<%=contextPath%>/icons/process2.png" width="18" height="18">
						   </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>

</table>

 <fieldset id="psearch">
 
 <legend>Item Details</legend>
 
   <table width="100% " >   
   <tr> 
   <td align="center"> &nbsp;</td>
   <td align="center">Product ID</td>
   <td align="center" colspan="2">Product Name</td>
   <td align="center" style="width:15%;" >Brand</td>
   <td align="center">Unit</td>
     
   <td  width="6%" align="center">Qty</td>
      <td align="center"> Unit price</td>
   <td align="center">Total</td> 
   
   </tr>
  <!--   onblur="funRoundAmt(this.value,this.id);" --> 
    <tr><td align="center" ><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn"  class="btn" onclick="prosrch()" value="PS" ></td>
    <td align="center"><div id="part"><jsp:include page="part.jsp"></jsp:include></div> </td>
 <td colspan="2" align="center"> <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div> </td> 
 <td align="center" >   <input type="text" id="brand"   > <input type="hidden" id="collqty"    ></td>
<td align="center"> <select    id="unit"   onchange="closes()"  >   </select>      </td>  
  <input type="hidden" id="loads" class="myButtons" value="Load Data" >     


<td width="6%" align="center">   <input type="text"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  id="quantity" style="text-align: left;" onchange="vatSwitch();"  ></td>
  <input type="hidden" id="focs"   onchange="vatSwitch();"   >
 
   <td align="center">   <input type="text"      id="uprice"   onkeypress="javascript:return isNumber1 (event);"  onchange="vatSwitch();"  style="text-align: right;"     style="text-align: right;"></td>
 
 <td align="center">  <input type="text" id="totamt" tabindex="-1"      style="text-align: right;"   ></td>
 

 </tr>
 <tr>


   <td align="center">Discount% </td>
      <td align="center">Discount</td>  
 
     <td align="center">Net Total</td>  
 
<td align="center">Tax%</td>  
<td align="center">Tax Amount</td>  
  <td    align="center">Net Total</td>    
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>    
 </tr>
 <tr>

 
 
 


  <td align="center">   <input type="text" id="dispers"    onkeypress="javascript:return isNumber1 (event);"  onchange="vatSwitch();"  style="text-align: right;"  ></td>
<td align="center">   <input type="text" id="dict"  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"   onchange="vatSwitch();"    style="text-align: right;"  ></td>
 <td align="center">   <input type="text" id="amounts" tabindex="-1"     style="text-align: right;" ></td>

 

 <td align="center"> <input type="text" id="taxpers"  tabindex="-1"      style="text-align: right;" ></td>  
 
 <td align="center"> 
 <input type="text" id="taxamounts"   tabindex="-1"   onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>
  <td align="center"> 
 <input type="text" id="taxamountstotal" tabindex="-1"    onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>  
  <td align="center">
     <input type="hidden" id="cleardata">
 &nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
 <td align="center"><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn1"  class="btn" onclick="detailstock()" value="SD" ></td>
 <td align="center"><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn2"  class="btn" onclick="alterprosrch()" value="Alternative Items" ></td>
 </tr>  
   
   </table> 
   </fieldset> 


<div id="invoiceDiv"><center><jsp:include page="invoiceGrid.jsp"></jsp:include></center></div>

<div id="hidegrid" hidden="true" ><center><jsp:include page="hidegrid.jsp"></jsp:include></center></div>


<fieldset>
   <legend>Summary</legend>  
<table width="100%">
<tr>
<td align="right">Product</td><td><input type="text" name="txtproductamt" readonly="readonly" id="txtproductamt" value='<s:property value="txtproductamt"/>'    style="width:50%;text-align: right;"></td>
<td align="right">Discount</td><td><input type="checkbox"  value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
<td align="right">Discount %</td><td><input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td>
<td align="right">Discount Value</td><td><input type="text" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>

<td><input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>

<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundvals();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="txtnettotal" readonly="readonly" id="txtnettotal" value='<s:property value="txtnettotal"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>
</fieldset>


<fieldset>
   <legend>Service</legend>
       <div id="servicegrid" ><jsp:include page="servicegrid.jsp"></jsp:include></div>
</fieldset>


<table width="100%">
<tr>
<td width="80%">&nbsp;<td><td width="10%" align="right"><label >Order Value :</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td>
<td><div style="position:fixed;z-index:1000;right:320px;top:15px;font-weight:bold;color:red;font-size: 12PX "> <label  >Order Value:</label> 
<input type="text" id="orderValuefinal" name="orderValuefinal" style="width:60%;float: right;text-align: right;
font-weight:bold;color:#000000;
background-color:#F2F4F4; " readonly tabindex="-1" value='<s:property value="orderValuefinal"/>'/></div></td>
<tr>

</table>

<div id="taxsss">
<fieldset> 
 <legend>Tax Details</legend> 
<table width="100%">

<tr>

<td align="right">Total Tax</td><td align="left"><input type="text" id="st" name="st" style="width:50%;"   value='<s:property value="st"/>'  ></td>

<td><button type="button" class="icon" id="process1" title="Process1" onclick="funcalutax();">
							<img alt="process" src="<%=contextPath%>/icons/process2.png" width="18" height="18">
						   </button></td>

<td align="right"><label id="labeltax1"></label></td><td  align="left"><input type="text" id="taxontax1" name="taxontax1" style="width:50%;"   value='<s:property value="taxontax1"/>'  ></td>
<td align="right"><label id="labeltax2"></label></td><td  align="left"><input type="text" id="taxontax2" name="taxontax2" style="width:50%;"   value='<s:property value="taxontax2"/>'  >
<td align="right"><label id="labeltax3"></label></td><td  align="left"><input type="text" id="taxontax3" name="taxontax3" style="width:50%;"   value='<s:property value="taxontax3"/>'  >
 </td>

<td  align="right">Net Tax Total</td><td  align="left"><input type="text" id="taxtotal" name="taxtotal" style="width:50%;"   value='<s:property value="taxtotal"/>'  ></td>

</table>

</fieldset>
</div>
<fieldset>
 <legend>Shipping Details</legend>
<table width="100%"  >

<tr>

<td width="50%">
 <fieldset>
<table  width="100%"   >   

<tr><td align="right" width="15%">Name</td><td colspan="3"><input type="text" id="shipto" name="shipto" style="width:91%;" placeholder="Press F3 To Search"  value='<s:property value="shipto"/>' onkeydown="getshipdetails(event)" ></td></tr>
<tr><td align="right">Shipping Address</td><td colspan="3"><input type="text" id="shipaddress" name="shipaddress"  style="width:91%;"  value='<s:property value="shipaddress"/>' ></td></tr>
<tr><td align="right">Contact Person</td><td colspan="3"><input type="text" id="contactperson" name="contactperson"  style="width:91%;"    value='<s:property value="contactperson"/>' ></td></tr>
<tr><td align="right">Telephone</td><td><input type="text" id="shiptelephone" name="shiptelephone"   style="width:90%;"   value='<s:property value="shiptelephone"/>' ></td>
<td align="right">MOB</td><td><input type="text" id="shipmob" name="shipmob"  style="width:80%;"  value='<s:property value="shipmob"/>' ></td></tr>
<tr><td align="right">Email</td><td><input type="text" id="shipemail" name="shipemail"   style="width:90%;"   value='<s:property value="shipemail"/>' ></td>
<td align="right">FAX</td><td><input type="text" id="shipfax"  style="width:80%;"  name="shipfax" value='<s:property value="shipfax"/>' ></td>
</tr>
</table>
 </fieldset>
 </td>

 
<td width="50%"> 
 <fieldset>
<div id="shipdetdiv"><jsp:include page="shipdetailsGrid.jsp"></jsp:include></div> 
</fieldset>
</td>

</tr>
</table>
 
 
 
</fieldset>
<fieldset><legend>Terms and Conditions</legend>
<table width="100%">
  <tr><td>
    <div id="termsDiv"><jsp:include page="termsGrid.jsp"></jsp:include></div><br/>
  </td></tr>
</table>
</fieldset>
                  
 
<input type="hidden" id="clientcaid" name="clientcaid"  value='<s:property value="clientcaid"/>'/>
<input type="hidden" id="clientcatname" name="clientcatname"  value='<s:property value="clientcatname"/>'/>
<input type="hidden" id="clientpricegroup" name="clientpricegroup"  value='<s:property value="clientpricegroup"/>'/>

<input type="hidden" id="salesmancatid" name="salesmancatid"  value='<s:property value="salesmancatid"/>'/>          <!--    not use -->
<input type="hidden" id="salesmanusgper" name="salesmanusgper"  value='<s:property value="salesmanusgper"/>'/>    <!--    not use -->

 <input type="hidden" id="checkhidegrid" name="checkhidegrid"  value='<s:property value="checkhidegrid"/>'/>


<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="refmasterdocno" name="refmasterdocno"  value='<s:property value="refmasterdocno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="termsgridlength" name="termsgridlength" value='<s:property value="termsgridlength"/>'/>
<input type="hidden" id="servgridlen" name="servgridlen"  value='<s:property value="servgridlen"/>'/>
<input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>
 <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
 <input type="hidden" id="hidpsrno" name="hidpsrno"  value='<s:property value="hidpsrno"/>'/>
 <input type="hidden" id="shipdocno" name="shipdocno"  value='<s:property value="shipdocno"/>'/>
  <input type="hidden" id="shipdatagridlenght" name="shipdatagridlenght"  value='<s:property value="shipdatagridlenght"/>'/>
  <input type="hidden" id="rowindexg" name="rowindexg"  value='<s:property value="rowindexg"/>'/>
   <input type="hidden" id="hidsellprice" name="hidsellprice"  value='<s:property value="hidsellprice"/>'/>
  <input type="hidden" id="fixaccount">
<input type="hidden" id="fixaccountdoc">
<input type="hidden" id="fixaccountname">
      <input type="hidden" id="totalstock" name="totalstock"  value='<s:property value="totalstock"/>'/>
  <input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>'/>
   <input type="hidden" id="clntacno" name="clntacno"  value='<s:property value="clntacno"/>'/>
    <input type="hidden" id="allowdiscount" name="allowdiscount"  value='<s:property value="allowdiscount"/>'/>
        <input type="hidden" id="temppsrno" >  
        <input type="hidden" id="tempspecid" > 
 <input type="hidden" id="productchk" >  
        <input type="hidden" id="tempunitdocno" > 
  
  <!-- <label id="stockmsg" name="stockmsg" class="blink" style="position:fixed;z-index:1000;right:310px;top:25px;color:#003300;font-weight:bold;font-size: 14px;font-family: Times New Roman, Times, serif;">  </label> -->
  
   <label ><span id="stockmsg" style="position:absolute;z-index:1000;right:210px;top:15px;color:#003300;font-weight:bold;font-size: 14px;font-family: Times New Roman, Times, serif;"></span><span id="salelbl" style="position:absolute;z-index:1000;right:50px;top:15px;color:#FF335E;font-weight:bold;font-size: 14px;font-family: Times New Roman, Times, serif;"></span>  </label>
 
 <input type="hidden" id="typeoftaken"> <!-- valuebased -->
 <input type="hidden" id="tax1per"> <!-- first tax % -->
 <input type="hidden" id="tax2per"><!--  sec tax % -->
 <input type="hidden" id="tax3per"><!--  tird tax % -->
 
 
</div>
</form>
	
<div id="salespersonwindow">
			<div></div>
			<div></div>
		</div>
<div id="customerDetailsWindow">
	<div></div>
</div>

<div id="sidesearchwndow">
	<div></div>
</div>  
<div id="refnosearchwindow">
	<div></div>
</div>
<div id="searchwndow">
	<div></div>
</div>
<div id="locationwindow">
	<div></div>
</div>
<div id="accountsearchwindow">
			<div></div>
		</div>	
		 <div id="userwindow">
	   <div ></div>
	</div>
</div>
</body>
</html>
