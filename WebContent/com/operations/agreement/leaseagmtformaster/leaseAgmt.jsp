<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 <link href="../../../../css/body.css" rel="stylesheet" type="text/css"> 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> -->

<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

</style>
<script type="text/javascript">
$(document).ready(function () {
	
	  /* create jqxMenu */
     $("#jqxMenuMore").jqxMenu({ width: '20%', height: '30px', autoSizeMainItems: true});
    $("#jqxMenuMore").jqxMenu('minimize');            
    $("#jqxMenuMore").css('visibility', 'visible');     
     
   /*   Menu-minimized window  */
     $('#windows2').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
	$('#windows2').jqxWindow('close');   
	
	getLeasePrior();
$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
$("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true,value:null});
$("#deldateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true,value:null});
$("#timeout").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
$("#deltimeout").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$('#clientinfowindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clientinfowindow').jqxWindow('close');
$('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#driverinfowindow').jqxWindow('close');
$('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#chauffeurinfowindow').jqxWindow('close');
$('#vehinfowindow').jqxWindow({ width: '60%', height: '67%',  maxHeight: '70%' ,maxWidth: '70%' , title: ' Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#vehinfowindow').jqxWindow('close');
$('#deldrvwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 650, y: 110 }, keyboardCloseKey: 27});
$('#deldrvwindow').jqxWindow('close');


$('#projectwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Project Search' ,position: { x: 800, y: 150 }, keyboardCloseKey: 27});
$('#projectwindow').jqxWindow('close');
$('#masterrefnowindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '54%' ,maxWidth: '60%' , title: 'Master Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#masterrefnowindow').jqxWindow('close');
$("#btnEdit").attr('disabled', true );

$('#clientid').dblclick(function(){
	    $('#clientinfowindow').jqxWindow('open');
      $('#clientinfowindow').jqxWindow('focus');
      clieninfoSearchContent('clientINgridsearch.jsp', $('#clientinfowindow'));
     });
     
$('#leaseproject').dblclick(function(){
    $('#projectwindow').jqxWindow('open');
  $('#projectwindow').jqxWindow('focus');
 projectinfoSearchContent('searchproject.jsp');
 });   
 $('#masterrefno').dblclick(function(){
	 var masterreftype=$('#cmbmasterreftype').val();
	 if(masterreftype=="MLA"){
		    $('#masterrefnowindow').jqxWindow('open');
		    $('#masterrefnowindow').jqxWindow('focus');
		   masterrefnoSearchContent('masterrefnoSearch.jsp');		 
	 }

 });  

     
$('#deldrvname').dblclick(function(){
    $('#deldrvwindow').jqxWindow('open');
  $('#deldrvwindow').jqxWindow('focus');
  drvdelSearchContent('Searchdeldriver.jsp?', $('#deldrvwindow'));  
 });  
     
$('#ladriverlist').dblclick(function(){
    $('#chauffeurinfowindow').jqxWindow('open');
  $('#chauffeurinfowindow').jqxWindow('focus');
  chauffeurSearchContent('SearchChauffeur.jsp', $('#chauffeurinfowindow'));
 });

$('#permanentfleet').dblclick(function(){
	
	   $('#vehinfowindow').jqxWindow('open');
  $('#vehinfowindow').jqxWindow('focus');
  vehinfoSearchContent('vehinfo.jsp', $('#vehinfowindow'));
 }); 

$('#tempfleet').dblclick(function(){

    $('#vehinfowindow').jqxWindow('open');
  $('#vehinfowindow').jqxWindow('focus');
  vehinfoSearchContent('vehinfotemp.jsp', $('#vehinfowindow'));
		
 }); 
     
$('#date').on('change', function (event) {
	  
    var maindate = $('#date').jqxDateTimeInput('getDate');
  	 if ($("#mode").val() == "A") {   
    funDateInPeriod(maindate);
  	 }
   });
$('#dateout').on('change', function (event) {
	 
    var dateout = $('#dateout').jqxDateTimeInput('getDate');
    
	 if ($("#mode").val() == "ADD") {  
		
	
    funDateInPeriod(dateout);
	 }
	
	 
   });
     
$('#deldateout').on('change', function (event) {
	
	 if ($("#mode").val() == "DLY") {  
		
	   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate')); 
	// out date
	  var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate')); //del date
	  
	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0);
	  
	  
	   if(indate1>agmtdate1){
	   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
	   
	   return false;
	  }   
	
	   else{
	  
	   document.getElementById("errormsg").innerText="";  
	   }
		
	 }
    });


$('#deltimeout').on('change', function (event) {
	   
	 if ($("#mode").val() == "DLY") {  
		 $('#dateout').jqxDateTimeInput({ disabled: false}); 
		 $('#timeout').jqxDateTimeInput({ disabled: false}); 
		 
	   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     // out date
	  var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate')); //del date
	 
	  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  //out time
	  var agmttime1=new Date($('#deltimeout').jqxDateTimeInput('getDate')); // del time  
	 
	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0);
	  
	  
	   if(indate1>agmtdate1){
	   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	   return false;
	  }   
	
	   if(indate1.valueOf()==agmtdate1.valueOf()){
	 
	  var out=intime1.getHours();
	  var del=agmttime1.getHours();
	
	  if(out > del){
		   
	    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	    return false;
	   }
	   if(out==del){
	    if(intime1.getMinutes()>agmttime1.getMinutes()){
	     document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	     return false;
	    }
	   }
	  }
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	   document.getElementById("errormsg").innerText="";  
	  
	 }

    });
  
  $('#timeout').on('change', function (event) {
	if($('#timeout').jqxDateTimeInput('getDate')!=null){
		   var intime=new Date($('#timeout').jqxDateTimeInput('getDate'));
		   var status=checkPriorTime(intime);
		   if(status){
			   document.getElementById("errormsg").innerText="";
			   return true;
		   }
		   else{
			   $('#timeout').jqxDateTimeInput('focus');
			   return false;
		   }
	   }
});
});


function checkPriorTime(intime){
	var currenttime=new Date();
	 var priormethod=document.getElementById("priormethod").value;
	 var priorvalue=document.getElementById("priorvalue").value;
	 var priorhours=priorvalue/60;
	 if(priormethod=="0"){
		 return true;
	 }
	 else if(priormethod=="1"){
		 var difference=currenttime-intime;
		 var minutediff=parseInt(difference/(1000*60));
		 if(minutediff>priorvalue){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Prior Opening time is "+priorhours+" hours";
			 return false;
		 }
		 else{
			 return true;
		 }
	 }
}

function getLeasePrior(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items = items.split('***');
			document.getElementById("priormethod").value=items[0];
			document.getElementById("priorvalue").value=items[1];
			} else {
			}
		}
		x.open("GET", "../getLeasePrior.jsp?status=create", true);
		x.send();
 }
function  funReadOnly(){
	
	$("#jqxMenuMore").css('visibility', 'visible');  
	$('#docno').attr('disabled', true);
	$('#date').jqxDateTimeInput({ disabled: true});
	$('#dateout').jqxDateTimeInput({ disabled: true});
	$('#deldateout').jqxDateTimeInput({ disabled: true});
	$('#frmLeaseAgreementForMaster input').attr('disabled', true );
	$('#frmLeaseAgreementForMaster textarea').attr('disabled', true );
	$('#frmLeaseAgreementForMaster select').attr('disabled', true);
	 $('#nwevehgrid').jqxGrid({ disabled: true}); 
	
	$('#rateGrid').jqxGrid({ disabled: true});
	  $('#ladriverlist').attr('readonly', true);
	  $('#adidrvcharges').attr('readonly', true);
	
	$('#btnupdate').attr('disabled', false);
	$('#leaseprintbtn').attr('disabled', false);
	
	if($('#delchkvalue').val()==1)
	  {
		
	$('#btndelupdate').attr('disabled', false);
	  }
	
	else
		{
		$('#btndelupdate').attr('disabled', true);
		}
	 $("#jqxgrid2").jqxGrid({ disabled: true});
	 $("#jqxgridpayment").jqxGrid({ disabled: true});
	 document.getElementById("btndelupdate").value="Edit";
	 document.getElementById("btnupdate").value="Edit";
	 

	 $("#cleardata").hide();	
	 
	 
}

function btndisabled()
{
	

}

function change1()
{ 
	
	
   if(document.getElementById("m2").value!="")
	   {
	document.getElementById("m3").value=parseInt(document.getElementById("m2").value)+1;
	   }
   else
	   {
	   document.getElementById("m3").value="";
	   }
}
function change2()
{
	
	 if(document.getElementById("m4").value!="")
	   {
	document.getElementById("m5").value=parseInt(document.getElementById("m4").value)+1;
	   }
	 else
	   {
	   document.getElementById("m5").value="";
	   }
}
function change3()
{
	
	 if(document.getElementById("m6").value!="")
	   {
	
	document.getElementById("m7").value=parseInt(document.getElementById("m6").value)+1;
	   }
	 
	 else
		 {
		 
		 document.getElementById("m7").value="";
		 }
}
function change4()
{
	 if(document.getElementById("m8").value!="")
	   {
	document.getElementById("m9").value=parseInt(document.getElementById("m8").value)+1;
	   }
	 else
		 {
		 
		 document.getElementById("m9").value="";
		 
		 }
}
function getclientinfo(event){
     	 var x= event.keyCode;
     	 if(x==114){
     	  $('#clientinfowindow').jqxWindow('open');
     
        // $('#accountWindow').jqxWindow('focus');
               clieninfoSearchContent('clientINgridsearch.jsp');  	 }
      	 else{
     		 }
            	 }
            	 
function clieninfoSearchContent(url) {
	 //alert(url);
     	 $.get(url).done(function (data) {
			 //alert(data);
	$('#clientinfowindow').jqxWindow('setContent', data);

                   	}); 
         	}
function getproject(event){
	
	 var x= event.keyCode;
	 if(x==114){
	  $('#projectwindow').jqxWindow('open');

 // $('#accountWindow').jqxWindow('focus');
	  projectinfoSearchContent('searchproject.jsp'); 	 }
	 else{
		 }
	 }
function getMasterRefno(event){
	
	 var x= event.keyCode;
	 if(x==114){
		 var masterreftype=$('#cmbmasterreftype').val();
		 if(masterreftype=="MLA"){
			    $('#masterrefnowindow').jqxWindow('open');
			    $('#masterrefnowindow').jqxWindow('focus');
			   masterrefnoSearchContent('masterrefnoSearch.jsp');		 
		 }
	  }
	 else{
		 }
	 }	 

function projectinfoSearchContent(url) {
   //alert(url);
$.get(url).done(function (data) {
	 //alert(data);
 $('#projectwindow').jqxWindow('setContent', data);

	   }); 
}
function masterrefnoSearchContent(url) {
$.get(url).done(function (data) {
 $('#masterrefnowindow').jqxWindow('setContent', data);
	   }); 
}
function funRemoveReadOnly(){

	 if ($("#mode").val() == "D") {
		 $('#docno').attr('disabled', false);
		 $('#clientid').attr('disabled', true);
		 $('#permanentfleet').attr('disabled', false);
		 $('#tempfleet').attr('disabled', false);
		var fleet_no=0;
		 var docnos=document.getElementById("masterdoc_no").value;
		 var clientid=document.getElementById("clientid").value;
				
			if($('#permanentfleet').val()=="")
			{
			fleet_no=document.getElementById("tempfleet").value;
			}
		else if($('#tempfleet').val()=="")
			{
			fleet_no=document.getElementById("permanentfleet").value;
			}
		 
		 
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					
			     			
						var items=x.responseText;
						
				var chkfleet=items.trim();
				
						 if(parseInt(chkfleet)==1)
							 {
							 $.messager.alert('Message',' Transaction Found Not Deleted ','warning'); 
							 $('#docno').attr('disabled', true);
							 $('#permanentfleet').attr('disabled', true);
							 $('#tempfleet').attr('disabled', true);
							 $("#mode").val("view");	
							  exit(); 
							  return 0;
							 }
						 else
							 {
							 $.messager.alert('Message','LA Is Successfully Deleted ','warning');  
						
							 $('#docno').attr('disabled', true);
							 $('#clientid').attr('disabled', true);
							 
							 $('#permanentfleet').attr('disabled', true);
							 $('#tempfleet').attr('disabled', true);
							 $("#mode").val("D");	
							  exit(); 
							 
							 return 0;	
							 }
				
						
						}
					
				}
					
			x.open("GET","deletelease.jsp?valfleet="+fleet_no+"&docnos="+docnos+"&clientid="+clientid+"&branch="+$('#brchName').val(),true);

			x.send();
			exit(); 	
			}
	
	
	$('#frmLeaseAgreementForMaster input').attr('disabled', false );
	$('#frmLeaseAgreementForMaster textarea').attr('disabled', false );
	$('#frmLeaseAgreementForMaster select').attr('disabled', false);
	$('#date').jqxDateTimeInput({ disabled: false});
	$('#jqxgrid2').jqxGrid({ disabled: false});
	$('#jqxgridpayment').jqxGrid({ disabled: false});
	 $('#rateGrid').jqxGrid({ disabled: false}); 
	 
	 $('#nwevehgrid').jqxGrid({ disabled: false}); 
	 
	$("#adidrvcharges").prop("disabled", true);
	$("#ladriverlist").prop("readonly", true);
    $("#ladriverlist").prop("disabled", true);
    $("#delkmout").attr("disabled", true);
    $('#adidrvcharges').attr('readonly', false);
	   $("#cmbdelfuelout").attr("disabled", true);
	   $('#deldateout').jqxDateTimeInput({ disabled: true});
	   $('#deltimeout').jqxDateTimeInput({ disabled: true});
	   $('#deltimeout').attr("disabled", true);
	   $('#delkmout').attr("disabled", true);
	   $('#cmbdelfuelout').attr("disabled", true);
	   
	
	   
	   
	   $('#vehdetailsupdate').attr('disabled', true);
	   
	   $('#delupdatefd').attr('disabled', true); 
		$('#btnupdate').attr('disabled', false);
		$('#btndelupdate').attr('disabled', false);
		$('#leaseprintbtn').attr('disabled', true);
	   
       $("#jqxgrid2").jqxGrid('clear');
	      $("#jqxgrid2").jqxGrid('addrow', null, {});
	      $("#jqxgrid2").jqxGrid('addrow', null, {});
	      
	       $("#rateGrid").jqxGrid('clear');
		      $("#rateGrid").jqxGrid('addrow', null, {});
		    
	      $("#paymentdiv").load("paymentdetailsgrid.jsp?");
	      
	    if($("#mode").val()=='A')  
	    	{
	    	$("#jqxMenuMore").css('visibility', 'hidden');   
	    	$("#date").val(new Date);
	        $("#dateout").val("");
	        $("#timeout").val("");
	 	   $("#deldateout").val(""); 
	 	  $("#deltimeout").val("");
	 	 $("#nwevehgrid").jqxGrid('clear');
	 	  $("#nwevehgrid").jqxGrid('addrow', null, {});
          $("#nwevehgrid").jqxGrid('addrow', null, {});
          $("#nwevehgrid").jqxGrid('addrow', null, {});
          $("#nwevehgrid").jqxGrid('addrow', null, {});
          
          $("#nwevehgrid").jqxGrid('addrow', null, {});
	 	  getDeliveryDriverConfig(); 
	    	}
	      
	    $("#cleardata").hide();	
	   
}    

function menuContent(url) {
	   $.get(url).done(function (data) {
	 	 $('#windows2').jqxWindow('open');
		 $('#windows2').jqxWindow('setContent', data);
		 $('#windows2').jqxWindow('bringToFront');
		 
	 		  });
	 	
	} 
function replacement(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
    $('#windows2').jqxWindow('open');
    menuContent('vehReplaceGrid.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2')); 
	  } 
    
    else {
           $.messager.alert('Message','Select a Document....!','warning');
           return false;
          } 
}

function fine(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 $('#windows2').jqxWindow('open');
    menuContent('trafficFines.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2'));  
	  } 
    
    else {
           $.messager.alert('Message','Select a Document....!','warning');
           return false;
          } 
}

function account(){ 
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {

	 $('#windows2').jqxWindow('open');
    menuContent('accountsmainForm.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2'));
	  } 
    
    else {
           $.messager.alert('Message','Select a Document....!','warning');
           return false;
          } 
}

function closing(){
	 if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	      var url=document.URL;
	        var reurl=url.split("saveLeaseAgreement");
	        $("#docno").prop("disabled", false);                

	        var win= window.open(reurl[0]+"printLAGClosingSummary?docno="+document.getElementById("masterdoc_no").value,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
	      win.focus();
	     } 
	    
	     else {
	            $.messager.alert('Message','Select a Document....!','warning');
	            return false;
	           } 
	}

function funKmDetails(){
  	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 $('#windows2').jqxWindow('open');
     menuContent('kmdetails.jsp?docno='+document.getElementById("masterdoc_no").value+'&id=1', $('#windows2')); 
  	}
  	 else {
	      $.messager.alert('Message','Select a Document....!','warning');
	      return false;
	     }
}
function funFocus(){
	 document.getElementById("clientid").focus();  
	
}

function driverinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#driverinfowindow').jqxWindow('open');
     		$('#driverinfowindow').jqxWindow('setContent', data);
     
     	}); 
     	}
     	
function funaddidriverview(){
	    
	   if (document.getElementById('additional_driver').checked) {
		   $("#adidrvcharges").prop("disabled", false);
		   document.getElementById('adidrvcharges').value="";
		   document.getElementById('add_drchk').value=1;
		   
		 /*   $("#jqxgrid2").jqxGrid({ disabled: true});
		  */
	   }	else
		   
		   {   
		   $("#adidrvcharges").prop("disabled", true);
		
		   document.getElementById('adidrvcharges').value="";
		   document.getElementById('add_drchk').value=0;
		   } 
     }

function funShaffurdisable(){
	  
    if (document.getElementById('ladrivercheck').checked) {
	   $("#ladriverlist").prop("disabled", false);
		   /* $("#divDrivGrid").load("driverGrid.jsp"); */
		   
		     $("#jqxgrid2").jqxGrid('clear');
			$("#jqxgrid2").jqxGrid('addrow', null, {});
		   $("#jqxgrid2").jqxGrid('addrow', null, {});
		   
		   $("#jqxgrid2").jqxGrid({ disabled: true});
		   document.getElementById("errormsg").innerText="";	
		
   }
   else
	   {
	   $("#ladriverlist").prop("disabled", true);
	   $("#jqxgrid2").jqxGrid({ disabled: false});
	   document.getElementById('ladriverlist').value="";
	   document.getElementById('del_chaufferid').value="";
	   
	   }
	     
}



function getchauffeur(event){
			
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#chauffeurinfowindow').jqxWindow('open');
    
       // $('#accountWindow').jqxWindow('focus');
     chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));  	 }
    	 else{
    		 }
    	 }
function chauffeurSearchContent(url) {
       //alert(url);
    $.get(url).done(function (data) {
	 //alert(data);
     $('#chauffeurinfowindow').jqxWindow('setContent', data);

	   }); 
    }
    
    
function getdeldrv(event){
	
	 var x= event.keyCode;
	 if(x==114){
	  $('#deldrvwindow').jqxWindow('open');

  // $('#accountWindow').jqxWindow('focus');
drvdelSearchContent('Searchdeldriver.jsp?', $('#deldrvwindow'));  	 }
	 else{
		 }
	 }
function drvdelSearchContent(url) {
  //alert(url);
$.get(url).done(function (data) {
//alert(data);
$('#deldrvwindow').jqxWindow('setContent', data);

  }); 
}

    
    
function getvehinfo(eventval){
     	 var x= event.keyCode;
     	 if(x==114){
     	  $('#vehinfowindow').jqxWindow('open');
     
        // $('#accountWindow').jqxWindow('focus');
        
        if(eventval==1)
        {
     vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow')); 
        }
        else{
        	
        	
        	 vehinfoSearchContent('vehinfotemp.jsp?', $('#vehinfowindow')); 	
        }
        
        
        
        
        }
     	 else{
     		 }
     	 }
     	 
function vehinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 //alert(data);
     		$('#vehinfowindow').jqxWindow('setContent', data);
     
     	}); 
     	}
/* 
function fundeliverydisable(){
	 
	   if (document.getElementById('chkdelivery').checked) {
		   
		  
		   $("#delkmout").attr("disabled", false);
		   $("#cmbdelfuelout").attr("disabled", false);
		   $('#deldateout').jqxDateTimeInput({ disabled: false});
		   $('#deltimeout').jqxDateTimeInput({ disabled: false});
		   $('#deltimeout').attr("disabled", false);
		   $('#delkmout').attr("disabled", false);
		   $('#cmbdelfuelout').attr("disabled", false);
		   
		 
	   }	else
		   
		   {   
		  
		   $("#delkmout").attr("disabled", true);
		   $("#cmbdelfuelout").attr("disabled", true);
		   $('#deldateout').jqxDateTimeInput({ disabled: true});
		   $('#deltimeout').jqxDateTimeInput({ disabled: true});
		   $('#deltimeout').attr("disabled", true);
		   $('#delkmout').attr("disabled", true);
		   $('#cmbdelfuelout').attr("disabled", true);
		      
		   
		   } 
         } */
		 
		 function getDeliveryDriverConfig(){
          	var x = new XMLHttpRequest();
          	x.onreadystatechange = function() {
          		if (x.readyState == 4 && x.status == 200) {
          			var items = x.responseText.trim().split("::");
          			//$('#deliverydriverconfig').val(items[0].trim());
          			$('#invruleoverride').val(items[1].trim());
          			//if($('#deliverydriverconfig').val()=="0"){
          				//$('#rarenral_Agent').val(items[3].trim());
              			//$('#tariffrenral_Agentid').val(items[2].trim());
          			//}
          			
          		} else {
          			}
          		}
          		x.open("GET", "getDeliveryDriverConfig.jsp", true);
          		x.send();
           }
function funNotify(){	
        		var maindate = $('#date').jqxDateTimeInput('getDate');
				   var validdate=funDateInPeriod(maindate);
				   if(validdate==0){
				   return 0; 
				   }
				   
				if($('#totalmasterqty').val()==$('#totalagmtqty').val() && $('#cmbmasterreftype').val()!="DIR"){
   		        	document.getElementById("errormsg").innerText="";
   		        	document.getElementById("errormsg").innerText="Agreement Limit for Master Lease "+$('#masterrefno').val()+" Exceeded";
   		        	return 0;
   		        }
		var valid2=document.getElementById("clientid").value;
		
	
		
		if(valid2=="")
			{
			document.getElementById("errormsg").innerText=" Select Client";
			document.getElementById("clientid").focus();  
			return 0;
			}
		if($("#invruleoverride").val()!="1"){
	    	var checkinvoice ="Monthly";/* document.getElementById("rentaltype").value; */
			var invoicevalue=document.getElementById("invoice").value;
			if(document.getElementById("configmethod").value>0) // in client search set this value 
			{
		    	if(checkinvoice=="Monthly")
				{ 
					if(document.getElementById("advchkval").value!=document.getElementById("advance_chk").value)
					{
						document.getElementById("errormsg").innerText="Please check the client invoice rule";
						return 0;
					}
			        if(document.getElementById("invval").value!=document.getElementById("invoice").value)
				    {
				    	document.getElementById("errormsg").innerText="Please check the client invoice rule";
					    return 0;
				   	}
			    }
		   	}
		   	if(checkinvoice!="Monthly")
			{
		    	if(invoicevalue=="1")
			    {
			    	if(document.getElementById("configmethod").value>0)// in client search set this value 
					{	
			        	$('#advance_chk').attr('disabled', false);
			       	    $('#invoice').attr('disabled', false);
					}
			    }
			    else
			    {
			    	document.getElementById("errormsg").innerText="";
			    }
			}
	    }
		var validdesc=document.getElementById("description").value;
		
		
		if(validdesc!="")
			{
		
		 var nmaxs = validdesc.length;
    		
    		
          if(nmaxs>99)
       	   {
       	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
		document.getElementById("description").focus(); 
       	   
		return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		   }
		
			}
		
		/* if(pfleet=="")
		{
		document.getElementById("errormsg").innerText=" Select Fleet";
		return 0;
		}
		else{
			 document.getElementById("errormsg").innerText="";
		} */
		 if (document.getElementById('additional_driver').checked) {
			   
			   var addcharge=document.getElementById("adidrvcharges").value;
				
				if( addcharge=="")
					{
					document.getElementById("errormsg").innerText=" Enter Additional Driver Charge";
					document.getElementById("adidrvcharges").focus();  
					return 0;
					}
				else{
					 document.getElementById("errormsg").innerText="";
				}
		   }
		
        if(document.getElementById('ladrivercheck').checked==false)
  	  {
  	  
		var rows = $("#jqxgrid2").jqxGrid('getrows');
	    var aa=0;
	    for(var i=0;i<rows.length;i++){
	 
		   if(parseInt(rows[i].dr_id1)>0)
			   {
			   aa=1;
			   break;
			   }
		   else{
			   
			   aa=0;
		       } 

	 
	   
	                         }
	   
	   
	   
	   if(parseInt(aa)==0)
		   {
		   
			document.getElementById("errormsg").innerText=" Select Driver";
		   
		   return 0;
		   
		   }
	   else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
	   
  	  
  	  }
    
        
        if ((document.getElementById('ladrivercheck').checked)) {
			   
			   var drvname=document.getElementById("ladriverlist").value;
				
				if(drvname=="")
					{
					document.getElementById("errormsg").innerText=" Select Driver";
					document.getElementById("ladriverlist").focus();  
					return 0;
					}
				else{
					 document.getElementById("errormsg").innerText="";
				}
		   }
		
	
        var excessinsur=document.getElementById("excessinsur").value;
        
		
		if(excessinsur=="")
			{
			
			document.getElementById("excessinsur").value=0;  
			
			}
	
	
	
	// driver grid
	var rows = $("#jqxgrid2").jqxGrid('getrows');
   $('#drivergridlength').val(rows.length);
  //alert($('#gridlength').val());
  for(var i=0;i<rows.length;i++){
  // var myvar = rows[i].tarif; 
   newTextBox = $(document.createElement("input"))
      .attr("type", "dil")
      .attr("id", "drvtest"+i)
      .attr("name", "drvtest"+i)
      .attr("hidden", "true");
   
  newTextBox.val(rows[i].dr_id1+" :: ");

  newTextBox.appendTo('form');
	
  
  }
	  // tariff grid
				
			 var rows = $("#rateGrid").jqxGrid('getrows');
			    $('#tariffgridlength').val(rows.length);
			    for(var i=0;i<rows.length;i++){
					  
					var rowlgt= rows.length-1; 
					 
					 if(i==rowlgt)
						 {
						
						 var rateval=rows[i].rate;
							
						
						if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN")
							{
							
							document.getElementById("errormsg").innerText="Tariff Is Not Entered";  
					    	return 0;
							}
						 }
				    }
			   //alert($('#gridlength').val());
			   for(var i=0;i<rows.length;i++){
			   // var myvar = rows[i].tarif; 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "test"+i)
			       .attr("name", "test"+i)
			       .attr("hidden", "true");
			   						    
			   newTextBox.val(rows[i].rate+" :: "+rows[i].cdw+" :: "
					   +rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "
					   +rows[i].exkmrte+" :: "+rows[i].chaufchg+" :: "+rows[i].chaufexchg+" :: "+rows[i].status+" :: ");
              
			  // alert("tariff grid"+newTextBox.val);
			   
			   newTextBox.appendTo('form'); 
				
			 
			   }				
         
  
  // payment  grid 
         /*       var rowval = $("#jqxgridpayment").jqxGrid('getrows');
			   var minaa;
			   for(var i=0;i<rowval.length;i++){
		     		 
			    	if(rowval[i].mode=="CARD"||rowval[i].mode=="CASH")
			    		{
			    		minaa=1;
			    		break;
			    	     }
			    	else{
			    		minaa=0;
			    	     }
			    	
			    if(minaa==0){
			    	
			    	 document.getElementById("errormsg").innerText="Payment Details Not Entered For Transaction";  
			    	  return 0;
			            } 
				
			   
			   }  
			    */
			   
				
			   var rows = $("#jqxgridpayment").jqxGrid('getrows');
			   
			   var cardnum="";
			   var cardtype="";
			
			   for(var i=0 ; i < rows.length ; i++){
			    	
			 
				
			    if(rows[i].mode=="CARD"||rows[i].mode=="CASH")
	    		{
			    
     	  
     	 	    if(rows[i].amount==""||rows[i].amount=="0.00"||typeof(rows[i].amount)=="undefined"||typeof(rows[i].amount)=="NaN")
	    		
				{
				document.getElementById("errormsg").innerText="Enter Amount In   "+rows[i].payment;  
		    	return 0;
				}
	    		} 
	     	     
				 if(rows[i].mode=="CARD")
					 {
			
					
					 cardtype=rows[i].card;
					 cardnum=rows[i].cardno;
			
			
					 if(!(cardtype=="MASTER"||cardtype=="VISA"))
						{
				
						document.getElementById("errormsg").innerText="Select Card Type In "+rows[i].payment;  
				    	return 0;
						}
					 else {
						 
					  }
					
				
					if(cardnum==""||typeof(cardnum)=="undefined"||typeof(cardnum)=="NaN")
						{
				
						document.getElementById("errormsg").innerText="Enter Card NO In  "+rows[i].payment;  
				    	return 0;
						}
					else
						{
						
						}
					
					var str = ""+cardnum;
					var n = str.length;
			
					if(n!=16)
					{
				
					document.getElementById("errormsg").innerText="Invalid Card Number In  "+rows[i].payment;  
			    	return 0;
					}
				else
					{
					
					}
					
					 }
					
			    }
			   

			    var rows = $("#jqxgridpayment").jqxGrid('getrows');
			    $('#paymentgridlength').val(rows.length);
			   //alert($('#gridlength').val());
			   for(var i=0 ; i < rows.length ; i++){
			   // var myvar = rows[i].tarif; 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "paytest"+i)
			       .attr("name", "paytest"+i)
			        .attr("hidden", "true");
			    newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "
						   +rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "
						   +rows[i].invno+" :: "+rows[i].status+" :: ");
			
			    //alert("payment grid"+newTextBox.val);
			   newTextBox.appendTo('form');
			  
			   
			    
			   }   
			   
				var rows = $("#nwevehgrid").jqxGrid('getrows');
				
				   $('#newvehdetalslenght').val(rows.length);
				  //alert($('#gridlength').val());
				  for(var i=0;i<rows.length;i++){
				  // var myvar = rows[i].tarif; 
				   newTextBox = $(document.createElement("input"))
				      .attr("type", "dil")
				      .attr("id", "vehtest"+i)
				      .attr("name", "vehtest"+i)
				      .attr("hidden", "true");
				 
				  newTextBox.val(rows[i].name+" :: "+rows[i].price+" :: ");
				
				  newTextBox.appendTo('form');
					
				  
				  }  
			   
			   
			   
			   
			   return 1;

		   
  }
  
function setValues() {
	  var maindoc=document.getElementById("masterdoc_no").value;
	  if(maindoc>0)
		  {
	 
     var indexVal1 = document.getElementById("masterdoc_no").value;
    
  	  
    $("#ratediv").load('rateGrid.jsp?rateGriddocno='+indexVal1);
	  
    $("#divDrivGrid").load("driverGrid.jsp?driverGriddocno="+indexVal1);
  
	 
    $("#paymentdiv").load("paymentdetailsgrid.jsp?paymentGriddocno="+indexVal1);
    $("#newvehdiv").load("newvehdetails.jsp?vehdivdoc="+indexVal1);
    

    
		  }
  		
	  
	   // main
  		if($('#hiddate').val()){
  			$("#date").jqxDateTimeInput('val', $('#hiddate').val());
  		}
		// tariff OUT date
  		if($('#hidoutdate').val()){
  			$("#dateout").jqxDateTimeInput('val', $('#hidoutdate').val());
  		}
		// tariff OUT time
	    		if($('#hidouttime').val()){
	    			
	    			$("#timeout").jqxDateTimeInput('val', $('#hidouttime').val());
	    		}
		
  	// delivery date
  		if($('#hiddeloutdate').val()){
  			$("#deldateout").jqxDateTimeInput('val', $('#hiddeloutdate').val());
  		}
      	    	        	
  	//deivery time
  	
	    		if($('#hiddelouttime').val()){
	    			$("#deltimeout").jqxDateTimeInput('val', $('#hiddelouttime').val());
	    		} 
      	
   
  	   if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		   
  		  }
  	   
  	 delvalueChange();
  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; 
  	
  	
  	 
	 if(document.getElementById("checkbranch").value=="WOB")
	  {
	  
	  $("#btnDelete").attr('disabled', true );
	  $("#btndelupdate").attr('disabled', true );
	  
	  $("#btnupdate").attr('disabled', true );
	  
	  
	   
	  
	  }

  	if($('#hidcmbmasterreftype').val()!=''){
  		$('#cmbmasterreftype').val($('#hidcmbmasterreftype').val());
  	}
  }
function fundescvalidate()
{
	var validdesc=document.getElementById("description").value;
	
	
	if(validdesc!="")
		{
	
	 var nmaxs = validdesc.length;
		
		
      if(nmaxs>99)
   	   {
   	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
	document.getElementById("description").focus(); 
   	   
	return 0;
		}
	else{
		 document.getElementById("errormsg").innerText="";
	   }
	
		}
	
}
function delvalueChange()
{

	  if(document.getElementById("delchkvalue").value==1)
		  {
		  document.getElementById("chkdelivery").checked = true;
		  document.getElementById("chkdelivery").value = 1;
		  document.getElementById("del_chaufferid").value = "";
		  document.getElementById("ladriverlist").value = "";
		  
		
		  }
	  
	
	  if(document.getElementById("add_drchk").value==1)
	  {
	  document.getElementById("additional_driver").checked = true;
	  document.getElementById("additional_driver").value = 1;
	  if ($("#mode").val() == "A") {     
	  $('#adidrvcharges').attr('disabled', false);
	  }
	  
	  }
	  if(document.getElementById("chaffchkvalue").value==1)
	  {
	  document.getElementById("ladrivercheck").checked = true;
	  document.getElementById("ladrivercheck").value = 1;
	   document.getElementById('deldrvname').value="";
	   document.getElementById('deldrvid').value="";
	
	  
	  if ($("#mode").val() == "A") {   
	  $('#ladriverlist').attr('disabled', false);
	  }
	  
	  }
	  if(document.getElementById("hidadvance_chk").value==1)
	  {
	  document.getElementById("advance_chk").checked = true;
	  document.getElementById("advance_chk").value = 1;
	  }

	  if($('#hidcmbtype').val()!="")
	  {
	  $('#cmbfuelout').val($('#hidcmbtype').val());
	  
	  }
	  if($('#hiddelcmbtype').val()!="")
	  {
	  $('#cmbdelfuelout').val($('#hiddelcmbtype').val());
	  }
	  if($('#hidper_value').val()!="")
	  {
	  $('#per_value').val($('#hidper_value').val());
	  }
	  if($('#hidper_name').val()!="")
	  {
	  $('#per_name').val($('#hidper_name').val());
	  }
	  if($('#hidinvoice').val()!="")
	  {
	  $('#invoice').val($('#hidinvoice').val());
	  }
	 // $('#rateGrid').jqxGrid({ disabled: true});
	  
}
function funSearchLoad(){
	changeContent('masterSearch.jsp', $('#window'));
}


function funchkvehStatus()
{
var masterdoc=document.getElementById("masterdoc_no").value;

var x=new XMLHttpRequest();


x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
{
	var items= x.responseText;
		 if(items>0)
		{
			 $.messager.alert('Message',' Already Edited ','warning');   
			
		
			return  0;
		}
		 else
			 {
			 $("#cleardata").show();	
			 $('#dateout').jqxDateTimeInput({ disabled: false});
			 $("#vehdetailsupdate input").prop("disabled", false);
			 
	
			 
			 $("#vehdetailsupdate select").prop("disabled", true);
			 $("#kmout").attr("readonly",true); 
			
			 
			 $('#dateout').jqxDateTimeInput({ disabled: false});
			  $("#dateout").val(new Date);
			   $("#timeout").val(new Date);
			
			  if($('#chaffchkvalue').val()=="1")
				  {
				
				  $("#chkdelivery").attr("disabled", true); 
				  }
		
			 
			 
			// $("#delcharges ").prop("disabled", true);
			 if (document.getElementById('chkdelivery').checked) {
				   $("#delcharges").prop("disabled", false);
				   $("#deldrvname").prop("disabled", false);
				   
				   
				   

			   }
			   else
				   {
				   $("#delcharges").prop("disabled", true);
				   $("#deldrvname").prop("disabled", true);
				 
				   document.getElementById('delcharges').value="";
				   document.getElementById('deldrvname').value="";
				   document.getElementById('deldrvid').value="";
				   
				   }
			 
			 
			 
		      document.getElementById("btnupdate").value="Update";
		      document.getElementById("mode").value='ADD';
		     return 0;
	
			 }
		
}
else
{
	   
}
}
x.open("GET", 'checkvehUpdate.jsp?masterdocno='+masterdoc, true);
x.send();
}  



function funupdate()
{
	
	if(document.getElementById("btnupdate").value=="Edit")
	{
		
		$('#docno').attr('disabled',false);
		if(($('#masterdoc_no').val()=="0") || ($('#masterdoc_no').val()==""))
			{
			 $.messager.alert('Message',' Search Details ','warning');   
			
			$('#docno').attr('disabled',true);
			return 0;
			
			}
		
		  funchkvehStatus();
		

		  return 0;
	
	}
	else
		{
	var fleet_no=0;
		 $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
				if (r==false){
					
					return 0;
				}
				else
					{
					
					if($('#tempfleet').val()=="" && $('#permanentfleet').val()=="")
					{
						 document.getElementById("errormsg").innerText=" Search Fleet";	 
	        			 return false;	
					}
					else
						{
					
						 document.getElementById("errormsg").innerText="";	 
						}

					var currenttime=new Date();
					 //alert($('#priormethod').val()+'///'+$('#priorvalue').val());
					 var priormethod=document.getElementById("priormethod").value;
					 var priorvalue=document.getElementById("priorvalue").value;
					 var priorhours=priorvalue/60;
					 //alert("inside method");
					 //alert(priormethod);
					 if(priormethod=="0"){
						 
					 }
					 else if(priormethod=="1"){
						 //alert("Inside Prior");
						 var priorintime=new Date($('#timeout').jqxDateTimeInput('getDate'));
						 var difference=currenttime-priorintime;
						 var minutediff=parseInt(difference/(1000*60));
						 //alert(minutediff+"//"+priorvalue);
						 if(minutediff>priorvalue){
							 //alert("inside");
							 document.getElementById("errormsg").innerText="";
							 document.getElementById("errormsg").innerText="Prior Opening time is "+priorhours+" hours";
							 return 0;
						 }
						 else{
							 
						 }
					 }
					if($('#permanentfleet').val()=="")
					{
					fleet_no=document.getElementById("tempfleet").value;
					}
				else if($('#tempfleet').val()=="")
					{
					fleet_no=document.getElementById("permanentfleet").value;
					}
				
					
					
					
				       if ((document.getElementById('chkdelivery').checked)) {
						   
	                
	                	   
	                	  var  deldrvname=document.getElementById("deldrvname").value;
	                	  if(deldrvname=="")
							{
							document.getElementById("errormsg").innerText=" Select Driver";
							document.getElementById("deldrvname").focus();  
							return 0;
							}
						
						else{
							 document.getElementById("errormsg").innerText="";
						}
							
	               	   var delcharge=document.getElementById("delcharges").value;
							if(delcharge=="")
								{
								document.getElementById("errormsg").innerText="Enter Delivery Charges ";
								document.getElementById("delcharges").focus();  
								return 0;
								}
							
							else{
								 document.getElementById("errormsg").innerText="";
							}
							
						
							
					   }
					
					
					
					 var dateout = $('#dateout').jqxDateTimeInput('getDate');
					   var validdate=funDateInPeriod(dateout);
					   if(validdate==0){
					   return 0; 
					   }
				
					 /* if(document.getElementById("kmout").value=="")
	        		 {
	        			 document.getElementById("errormsg").innerText=" Enter Out KM";	 
	        			 return false;
	        		 }
	        		 else
	        			 {
	        			 document.getElementById("errormsg").innerText="";
	        			 }
	        		 if($('#cmbfuelout').val()=="")
	        		 {
	        			 document.getElementById("errormsg").innerText=" Select Out Fuel";	 
	        			 return false;
	        		 } */
	        		 else
	        			 {
	        			 document.getElementById("errormsg").innerText="";
	        			 }
	        		 //  var valfleetno=document.getElementById("txtfleetno").value;
						var dateout=$('#dateout').val();
						var timeout=$('#timeout').val();
	        		 chkavailable(fleet_no,dateout,timeout);
	        		 
	        		 
/* 					funSetlabel();
					$('#frmLeaseAgreementForMaster input').attr('disabled', false );
					$('#frmLeaseAgreementForMaster textarea').attr('disabled', false );
					$('#frmLeaseAgreementForMaster select').attr('disabled', false);
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					 $('#rateGrid').jqxGrid({ disabled: false}); 
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					 $('#rateGrid').jqxGrid({ disabled: false}); 
					  $('#dateout').jqxDateTimeInput({ disabled: false});
					   
					  var rows = $("#jqxgridpayment").jqxGrid('getrows');
					    $('#paymentgridlength').val(rows.length);
					  
					   for(var i=0 ; i < rows.length ; i++){
					  
					    newTextBox = $(document.createElement("input"))
					       .attr("type", "dil")
					       .attr("id", "paytest"+i)
					       .attr("name", "paytest"+i)
					        .attr("hidden", "true");
					    newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "
								   +rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "
								   +rows[i].invno+" :: "+rows[i].status+" :: ");
					
					    
					   newTextBox.appendTo('form');
					  
					   
					    
					   }   
					  			   
		
					$('#frmLeaseAgreementForMaster').submit();
					 */
						
					}
				
			   });
		}
	
	
	       
	 
  }
  
  
function chkavailable(valfleet,dateout,timeout)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
	var chkfleet=items.trim();

			 if(chkfleet==1)
				 {
				 $.messager.alert('Message','Fleet Is Not Available ','warning');   
				 return 0;
				 }
			 else
				 {
				
				    funSetlabel();
					$('#frmLeaseAgreementForMaster input').attr('disabled', false );
					$('#frmLeaseAgreementForMaster textarea').attr('disabled', false );
					$('#frmLeaseAgreementForMaster select').attr('disabled', false);
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					$('#rateGrid').jqxGrid({ disabled: false}); 
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					$('#rateGrid').jqxGrid({ disabled: false}); 
					$('#dateout').jqxDateTimeInput({ disabled: false});
					   
					  var rows = $("#jqxgridpayment").jqxGrid('getrows');
					    $('#paymentgridlength').val(rows.length);
					  
					   for(var i=0 ; i < rows.length ; i++){
					  
					    newTextBox = $(document.createElement("input"))
					       .attr("type", "dil")
					       .attr("id", "paytest"+i)
					       .attr("name", "paytest"+i)
					        .attr("hidden", "true");
					    newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "
								   +rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "
								   +rows[i].invno+" :: "+rows[i].status+" :: ");
					
					    
					   newTextBox.appendTo('form');
					  
					   
					    
					   }   
					  			   
		
					$('#frmLeaseAgreementForMaster').submit();
				 }
	
			
			}
		
	}
		
x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout,true);

x.send();
		
}
 
  
function funchkDelStatus()
{
var masterdoc=document.getElementById("masterdoc_no").value;

var x=new XMLHttpRequest();


x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
{
	var items= x.responseText;
		 if(items>0)
		{
			
	 $.messager.alert('Message',' Already Edited ','warning');   
			return  0;
		}
		 else
			 {
			 $("#delupdatefd input").prop("disabled", false);
			 $("#delupdatefd select").prop("disabled", false);
			/*  $('#dateout').jqxDateTimeInput({ disabled: false}); */
			 $('#deldateout').jqxDateTimeInput({ disabled: false});
			  $("#deldateout").val(new Date);
			  $("#deltimeout").val(new Date);
		     document.getElementById("btndelupdate").value="Update";
		     document.getElementById("mode").value='DLY';
		     return 0;
	
			 }
		
}
else
{
	   
}
}
x.open("GET", 'checkdelUpdate.jsp?masterdocno='+masterdoc, true);
x.send();
}  

function fundelupdate()
{
	
	if(document.getElementById("btndelupdate").value=="Edit")
	{
		$('#delchkvalue').attr('disabled',false);
		if(($('#delchkvalue').val()==1))
			
			 {
   			  funchkDelStatus();
   
   			  }
   		  else
   			  {
   			
   		 $.messager.alert('Message','Delivery Update Need Not Be Entered ','warning');   
   				
			   return 0;
   		      }
		
	
	     return 0;
	}
	else
		{
	
		 $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
				if (r==false){
					
					return 0;
				}
				else
					{
					
					   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     // out date
					 
						  var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate')); //del date
						 
						  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  //out time
						  var agmttime1=new Date($('#deltimeout').jqxDateTimeInput('getDate')); // del time  

						  indate1.setHours(0,0,0,0);
						  agmtdate1.setHours(0,0,0,0);
						  
						  
						   if(indate1>agmtdate1){
						   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
						   return false;
						  }   
						
						   if(indate1.valueOf()==agmtdate1.valueOf()){
						 
						  var out=intime1.getHours();
						  var del=agmttime1.getHours();
						
						  if(out > del){
							   
						    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
						    return false;
						   }
						   if(out==del){
						    if(intime1.getMinutes()>agmttime1.getMinutes()){
						     document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
						     return false;
						    }
						   }
						  }
						  
						   document.getElementById("errormsg").innerText="";  
					
					
						 if(document.getElementById("delkmout").value=="")
		        		 {
		        			 document.getElementById("errormsg").innerText=" Enter Delivery KM";
		        			 document.getElementById("delkmout").focus();
		        			 return false;
		        		 }
		        		 else
		        			 {
		        			 document.getElementById("errormsg").innerText="";
		        			 }
		        		 if($('#cmbdelfuelout').val()=="")
		        		 {
		        			 document.getElementById("errormsg").innerText=" Select Delivery Fuel";	 
		        			 document.getElementById("cmbdelfuelout").focus();
		        			 return false;
		        		 }
		        		 else
		        			 {
		        			 document.getElementById("errormsg").innerText="";
		        			 }
       
		        		 $("#kmout").prop("disabled", false);
		        			var outkm=document.getElementById("kmout").value;
		        			// alert("out"+outkm);
		        		 	var delkm=document.getElementById("delkmout").value;
		        		   if((parseFloat(delkm)<parseFloat(outkm)))
		        			   
		        		 	
		        		 	{
		        			  
		        			   document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
		        			   $("#kmout").prop("disabled", true);
		        			   return 0;
		        		 	}
		        		   else
		        			   {
		        			   document.getElementById("errormsg").innerText="";  
		        			   $("#kmout").prop("disabled", true);
		        			   }
					
					
					funSetlabel();
					
					$('#frmLeaseAgreementForMaster input').attr('disabled', false );
					$('#frmLeaseAgreementForMaster textarea').attr('disabled', false );
					$('#frmLeaseAgreementForMaster select').attr('disabled', false);
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					 $('#rateGrid').jqxGrid({ disabled: false}); 
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
				    $('#rateGrid').jqxGrid({ disabled: false}); 
					$('#dateout').jqxDateTimeInput({ disabled: false});
					$('#deldateout').jqxDateTimeInput({ disabled: false}); 
				    $('#frmLeaseAgreementForMaster').submit();
					
						
					}
				
			   });
		}
	
	
	       
	 
  }

  
function  funchkKm()
{
	  $("#kmout").prop("disabled", false);
		var outkm=document.getElementById("kmout").value;
		// alert("out"+outkm);
	 	var delkm=document.getElementById("delkmout").value;
	   if((parseFloat(delkm)<parseFloat(outkm)))
		   
	 	
	 	{
		  
		   document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
		   document.getElementById("delkmout").focus();
		   $("#kmout").prop("disabled", true);
		   return 0;
	 	}
	   else
		   {
		   document.getElementById("errormsg").innerText="";  
		   $("#kmout").prop("disabled", true);
		   }
	  
}
  
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
     {
    	
    	document.getElementById("errormsg").innerText="Enter Numbers Only";  

        return false;
     }
    document.getElementById("errormsg").innerText="";  

    return true;
}

function fundelivarytick(){
	  
    if (document.getElementById('chkdelivery').checked) {
	   $("#delcharges").prop("disabled", false);
	   
	   $("#deldrvname").prop("disabled", false);

   }
   else
	   {
	   $("#delcharges").prop("disabled", true);
	   $("#deldrvname").prop("disabled", true);
	 
	   document.getElementById('delcharges').value="";
	   document.getElementById('deldrvname').value=""; 
	   document.getElementById('deldrvid').value="";
	   
	   
	   }
	     
} 


function funPrintBtn(){
	   if (($("#mode").val() != "A") && $("#masterdoc_no").val()!="") {
	  
	      
	   var url=document.URL;

    var reurl=url.split("saveLeaseAgreementForMaster");

    $("#docno").prop("disabled", false);                
    
//var win= window.open(reurl[0]+"printRA?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 
// var win= window.open(reurl[0]+"/epicraprint1.jsp","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    var win= window.open(reurl[0]+"Leasemainprint?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=LAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus(); 
	   } 
	  
	   else {
 	      $.messager.alert('Message','Select a Document....!','warning');
 	      return false;
 	     }
 	
	}  

 function funPrintdown(){ 
	   if (($("#mode").val() != "A") && $("#masterdoc_no").val()!="") {
	  
	      
	   var url=document.URL;
	   
	 

 var reurl=url.split("saveLeaseAgreement");

 $("#docno").prop("disabled", false);                
 



var win= window.open(reurl[0]+"LeasemasterPrint?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=LAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
win.focus(); 
	   } 
	  
	   else {
	      $.messager.alert('Message','Select a Document....!','warning');
	      return false;
	     }
	
	} 


function clearvehdata()
{
	if(document.getElementById("mode").value="ADD")
		{
	
	  document.getElementById("mode").value="view";
	  
	
	  document.getElementById("tempfleet").value="";
	  document.getElementById("permanentfleet").value="";
	  document.getElementById("delcharges").value="";
	  document.getElementById("fleetname").value="";
	  document.getElementById("kmout").value="";
	  
	  document.getElementById("cmbfuelout").value="";
	  
	  
	   document.getElementById('deldrvname').value=""; 
	   document.getElementById('deldrvid').value="";
	  
	  
	 $('#dateout').jqxDateTimeInput({ disabled: true});
	 $("#vehdetailsupdate input").prop("disabled", true);
	 $("#vehdetailsupdate select").prop("disabled", true);
	 $("#kmout").attr("readonly",true); 
	  $("#dateout").val('');
	   $("#timeout").val('');
	
	
	document.getElementById('chkdelivery').checked=false;
	 
	$("#btnupdate").prop("disabled", false);
	$("#leaseprintbtn").prop("disabled", false);
	 
      document.getElementById("btnupdate").value="Edit";
      
      $("#cleardata").hide();	
     return 0;
		}
	
	}

function checkBrandQty(fleetno,masterrefno){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				
		        var brand=items[0];
				var model=items[1];
				var mastervehqty=items[2];
				var agmtvehqty=items[3];
				//alert(brand+"::"+model+"::"+mastervehqty+"::"+agmtvehqty);
				if(parseInt(mastervehqty)==parseInt(agmtvehqty) && $('#cmbmasterreftype').val()!="DIR"){
					document.getElementById("errormsg").innerText="";
		        	document.getElementById("errormsg").innerText="Vehicle Limit for Master Lease "+$('#masterrefno').val()+" with brand "+brand+" and model "+model+" Exceeded";
		        	return false;
				}
			}
	}
	x.open("GET","checkBrandQty.jsp?fleetno="+fleetno+"&masterrefno="+masterrefno,true);
	x.send();	
}

</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLeaseAgreementForMaster" action="saveLeaseAgreementForMaster" method="post" autocomplete="off">
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<jsp:include page="../../../../header.jsp" /><br/>

<div class='hidden-scrollbar'>
  <table width="100%" >
    <tr>
       <td colspan="2">
       <table width="100%" >            
   <tr>
   <td width="85%">
   <fieldset>
   <table width="100%">            
   <tr>
   
    <td width="57" align="right">Date</td>
    <td ><div id='date' name='date' style="width:40%;" value='<s:property value="date"/>'></div>
                   <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="200" align="right">Master Ref Type</td>
    <td width="113" align="left"><select name="cmbmasterreftype" id="cmbmasterreftype"><option value="DIR">DIR</option><option value="MLA">MLA</option></select></td>
    <input type="hidden" name="hidcmbmasterreftype" id="hidcmbmasterreftype" value='<s:property value="hidcmbmasterreftype"/>'>
    <td width="108" align="right">Master Ref No</td>
    <td width="201" align="left"><input type="text" name="masterrefno" id="masterrefno" value='<s:property value="masterrefno"/>' readonly placeholder="Press F3 to Search" onkeydown="getMasterRefno(event);"></td>
    <input type="hidden" name="hidmasterrefno" id="hidmasterrefno" value='<s:property value="hidmasterrefno"/>'>
    <input type="hidden" name="masterrefnocldocno" id="masterrefnocldocno" value='<s:property value="masterrefnocldocno"/>'>
    <td width="61" align="right">Doc No</td>
    <td width="99"><input type="text" id="docno" name="docno"  readonly tabindex="-1" value='<s:property value="docno"/>'/></td>
    <tr>
  <td width="57" align="right"> Client</td>
  <td width="116"> <input type="text" id="clientid" name="clientid" readonly placeholder="Press F3 To Search" value='<s:property value="clientid"/>' onKeyDown="getclientinfo(event);" ondoubleclick="getclientinfo(event);"/></td>
     <td colspan="6" ><input type="text" id="clientname" readonly name="clientname" style="width:40%;" tabindex="-1" value='<s:property value="clientname"/>'/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <label>Salesman</label>
 <input type="text" id="salesman" name="salesman" readonly style="width:34%;" placeholder="Salesman Name" value='<s:property value="salesman"/>'/>
 
 <input type="hidden" id="le_salmanid" name="le_salmanid" style="width:25%;"  value='<s:property value="le_salmanid"/>'/>
 <input type="hidden" id="le_clcodeno" name="le_clcodeno" style="width:25%;"  value='<s:property value="le_clcodeno"/>'/>
 <input type="hidden" id="le_clacno" name="le_clacno" style="width:25%;"  value='<s:property value="le_clacno"/>'/>
 </td>
 </tr>
  <tr>
  <td align="right"></td><td colspan="7"><input type="text" id="cusaddress"  placeholder="Mobil NO-Address" readonly name="cusaddress" style="width:89.3%; resize: none; " value='<s:property value="cusaddress"/>'>

     </td>
  </tr>
  <tr>
          <td align="right">Description</td>
          <td colspan="10" align="left"><input type="text" name="description" id="description" placeholder="Description"  value='<s:property value="description"/>' style="width:89.1%;" onblur="fundescvalidate()"></td>
        </tr>   
 </table>
   </fieldset>
 </td>

 <td width="15%">
 <table width="100%" >
 <tr>
 
 <td align="center">
 <div id='jqxMenuMore' title="More" align="center" style='visibility: hidden;'>
        <ul>
         <li><a href="#trafficFines" onclick="fine();">Traffic Fines</a></li>
       	    <li><a href="#documents" onclick="replacement();">Replacement</a></li>
            <li><a href="#history" onclick="account();">Account Statement</a></li>   
            <li><a href="#close" onclick="closing();">Closing Summary</a></li>
            <li><a href="#kmdetails" onclick="funKmDetails();">KM Details</a></li>               
        </ul>
     </div> 
 </td>
 </tr>

<tr> <td align="center"><i><b><label id="leasestatus"  name="leasestatus"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"><s:property value="leasestatus"/></label></b></i></td></tr>

</table>
 </td>
 </tr>
 </table>
</td>
    </tr>
    <tr>
      <td colspan="2">  <fieldset>
<legend>Driver Details</legend>
<table  width="100%">
<tr>
<td width="11%">
<table id="chauffer" >
<tr><td>
<font size="1.5">Additional Driver</font>  
<input type="checkbox" id="additional_driver"  name="additional_driver" value="0" onchange="funaddidriverview()" onclick="$(this).attr('value', this.checked ? 1 : 0)"></td></tr><tr><td>
<font size="1.5">charge</font>&nbsp;&nbsp;&nbsp;<input type="text" id="adidrvcharges"  style="width:60%;text-align: right;" name="adidrvcharges"value='<s:property value="adidrvcharges"/>' onblur="funRoundAmt(this.value,this.id);"  onkeypress="javascript:return isNumber (event)"  >
</td></tr><tr>
<td>
<font size="1.5">Chauffeur</font>

<input type="checkbox"  id="ladrivercheck" style="width:50%;"  name="ladrivercheck" value="0" onchange="funShaffurdisable()"  onclick="$(this).attr('value', this.checked ? 1 : 0)"></td>
</tr>
<tr><td><input type="text" id="ladriverlist"  name="ladriverlist"  placeholder="Press F3 To Search" value='<s:property value="ladriverlist"/>' onKeyDown="getchauffeur(event);" onfocus="this.placeholder = ''"/>
 <input type="hidden" id="del_chaufferid" name="del_chaufferid"  value='<s:property value="del_chaufferid"/>'/>
    
<input type="hidden" id="client_driverid" name="client_driverid"  value='<s:property value="client_driverid"/>'/>
    <input type="hidden" id="client_driverdoc" name="client_driverdoc"  value='<s:property value="client_driverdoc"/>'/>
   
</td></tr>
</table>
</td>
<td width="89%">
  <!--  <div align="center" hidden="true" id="errodriver"></div><div align="center" hidden="true" id="errodriveryear"></div>  -->
<table width="100%" id="driverGrid">
<tr><td>
      <div id="divDrivGrid">
  <jsp:include page="driverGrid.jsp"></jsp:include></div>
</td>
  </tr>
</table>
</td>

</tr>
    </table>
      </fieldset></td>
    </tr>
    <tr>
      <td colspan="2"><fieldset>
        <legend>Rate Info</legend>
        <table width="100%"  >
        
<tr>
<td width="2%" align="right">Period</td>
<td width="4%">
    <select name="per_value" id="per_value"  value='<s:property value="per_value"/>'>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
    <option value=4>4</option>
    <option value=5>5</option>
    <option value=6>6</option>
    <option value=7>7</option>
    <option value=8>8</option>
    <option value=9>9</option>
    <option value=10>10</option>
    <option value=11>11</option>
    <option value=12>12</option>
	<option value=13>13</option>
    <option value=14>14</option>
    <option value=15>15</option>
    <option value=16>16</option>
    <option value=17>17</option>
    <option value=18>18</option>
    <option value=19>19</option>
    <option value=20>20</option>
    <option value=21>21</option>
    <option value=22>22</option>
    <option value=23>23</option>
    <option value=24>24</option>
    <option value=25>25</option>
    <option value=26>26</option>
    <option value=27>27</option>
    <option value=28>28</option>
    <option value=29>29</option>
    <option value=30>30</option>
    <option value=31>31</option>
    <option value=32>32</option>
    <option value=33>33</option>
    <option value=34>34</option>
    <option value=35>35</option>
    <option value=36>36</option>
    <option value=37>38</option>
    <option value=38>38</option>
    <option value=39>39</option>
    <option value=40>40</option>
    <option value="" selected>-Select-</option>      

</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<select name="per_name" id="per_name" value='<s:property value="per_name"/>'>
    <option value=1>Years</option>
    <option value=2>Months</option>
    <option value="" selected>-Select-</option>      

</select></td>
<td width="6%"><input type="checkbox" id="advance_chk"  name="advance_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" > &nbsp;Advance

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ins.Excess&nbsp;<input type="text" id="excessinsur"  name="excessinsur" style="text-align: right;"  value='<s:property value="excessinsur"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
</td>
<td width="20%">Invoice&nbsp;<select name="invoice" id="invoice" style="width:15%;"  value='<s:property value="invoice"/>'  >
  <option value="1">Month End</option>
  <option value="2">Period</option>
  <option value="3">Quarterly</option>
</select></td></tr>
                                                        
            <tr><td colspan="4"><div id="ratediv">
              <jsp:include page="rateGrid.jsp"></jsp:include>
            </div></td>
          </tr>
        </table>
        <br>
      </fieldset></td>
    </tr>
    <tr>
      <td colspan="2"><fieldset>
        <legend>Payment Info</legend>
             <table width="99%" id="payment">
             <tr>

                <td width="80%">

        
        
        <table width="100%">
          <tr>
            <td><div id="paymentdiv">
              <jsp:include page="paymentdetailsgrid.jsp"></jsp:include>
            </div>                                                           
            </td></tr></table>
          </td>
              <td width="20%">
				      <table width="100%"> 
						<tr>
				<td align="right">PO</td><td><input type="text" id="leasePo"  name="leasePo" value='<s:property value="leasePo"/>'></td>
				</tr><tr>
				<td align="right">Project</td><td><input type="text" id="leaseproject"  readonly="readonly" onkeydown="getproject(event);" placeholder="Press F3 To Search"  name="leaseproject" value='<s:property value="leaseproject"/>'>
				<input type="hidden" id="leaseprojectDoc"  name="leaseprojectDoc" value='<s:property value="leaseprojectDoc"/>'>
				
				</td>
				</tr>
				</table>
            
            </td>
          </tr>
        </table>
      </fieldset></td>
    </tr>
    <tr>
    </table>
   
    <table width="100%"  >
    <tr>
      <td width="40%">
        <table width="100%" >
          <tr>
          
          <td width="50%"> 
          <fieldset>
        <legend>Termination Clauses Info</legend>
          <table width="100%"  >
          <tr>
            <td width="50%" align="right"><input type="text" name="m1" id="m1"   value='<s:property value="m1"/>'  onkeypress="javascript:return isNumber (event)" style="width:35%;text-align: center;">
              &nbsp;to&nbsp;
              <input type="text" name="m2"  id="m2" value='<s:property value="m2"/>' style="width:35%;text-align: center;" onkeypress="javascript:return isNumber (event)" onblur="change1();"></td>
            <td width="50%" align="left"><input type="text" id="amt1" name="amt1"  value='<s:property value="amt1"/>' onkeypress="javascript:return isNumber (event)"/></td>
          </tr>
          <tr>
            <td align="right"><input type="text" name="m3" id="m3"   value='<s:property value="m3"/>' onkeypress="javascript:return isNumber (event)" readonly style="width:35%;text-align: center;  ">
              &nbsp;to&nbsp;
              <input type="text" name="m4" id="m4" value='<s:property value="m4"/>' onkeypress="javascript:return isNumber (event)"  style="width:35%;text-align: center;" onblur="change2();"></td>
            <td align="left"><input type="text" id="amt2" name="amt2" " value='<s:property value="amt2"/>' onkeypress="javascript:return isNumber (event)" /></td>
          </tr>
          <tr>
            <td align="right"><input type="text" name="m5" id="m5"  value='<s:property value="m5"/>' onkeypress="javascript:return isNumber (event)"  readonly="true" style="width:35%;text-align: center;">
              &nbsp;to&nbsp;
              <input type="text" name="m6" id="m6" value='<s:property value="m6"/>' onkeypress="javascript:return isNumber (event)" style="width:35%;text-align: center;"onblur="change3();"></td>
            <td align="left"><input type="text" id="amt3" name="amt3" value='<s:property value="amt3"/>' onkeypress="javascript:return isNumber (event)" /></td>
          </tr>
          <tr>
            <td align="right"><input type="text" name="m7" id="m7" value='<s:property value="m7"/>' onkeypress="javascript:return isNumber (event)"  readonly="true" style="width:35%;text-align: center;">
              &nbsp;to&nbsp;
              <input type="text"  value='<s:property value="m8"/>' name="m8" id="m8" onkeypress="javascript:return isNumber (event)"  style="width:35%;text-align: center;" onblur="change4();"></td>
            <td align="left"><input type="text" id="amt4" name="amt4"   value='<s:property value="amt4"/>' onkeypress="javascript:return isNumber (event)" /></td>
          </tr>
          <tr>
            <td align="right"><input type="text" name="m9" id="m9" value='<s:property value="m9"/>' onkeypress="javascript:return isNumber (event)" readonly style="width:35%;text-align: center;">
    &nbsp;to&nbsp;
              <input type="text" name="m10"  id="m10" value='<s:property value="m10"/>' onkeypress="javascript:return isNumber (event)"  style="width:35%;text-align: center;"></td>
            <td align="left"><input type="text" id="amt5" name="amt5"  value='<s:property value="amt5"/>' onkeypress="javascript:return isNumber (event)" /></td>
          </tr>
          
        </table>
        </fieldset>
     </td>
     <td width="50%">

        <fieldset>
        <legend>Other Income</legend>
     <div id="newvehdiv">
              <jsp:include page="newvehdetails.jsp"></jsp:include>
            </div>
     </fieldset>
     </td>
        </tr>
        </table>
        
        <br>
      </td>
      <td width="60%"><fieldset id="vehdetailsupdate">
      <legend>Vehicle Info</legend>
      <table width="100%" > 
        <tr>
          <td  align="left" colspan="8" >Temperory Fleet&nbsp;&nbsp;<!-- </td>&nbsp;
          <td colspan="2" align="left"> --><input type="text" readonly id="tempfleet" style="width:14%;" name="tempfleet" placeholder="Press F3 To Search" value='<s:property value="tempfleet"/>' onKeyDown="getvehinfo(2);">&nbsp;&nbsp;Permanent Fleet
   <!--        </td>
          <td colspan="2"> -->&nbsp;&nbsp;<input type="text" readonly id="permanentfleet" style="width:14%;" placeholder="Press F3 To Search"  name="permanentfleet" value='<s:property value="permanentfleet"/>' onKeyDown="getvehinfo(1);">
      <!--     
          </td>
          <td width="15%" align="center" colspan="3"> -->&nbsp;Delivery&nbsp;
           &nbsp; <input type="checkbox" id="chkdelivery" name="chkdelivery" value="0"  onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundelivarytick();">
           &nbsp; <input type="text" readonly id="deldrvname" placeholder="Press F3 To Search" style="width:16%;" name="deldrvname" value='<s:property value="deldrvname"/>' onKeyDown="getdeldrv(event);">
           <!--  </td>
          <td> -->&nbsp;Del.Charges&nbsp;<!--  </td><td> --><input type="text" id="delcharges" name="delcharges"   style="width:13%;text-align: right;"  value='<s:property value="delcharges" />' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event)" ></td>  </tr>
  
        <tr>
          <td align="right" width="8%">Fleet Details</td>
          <td colspan="5" align="left"><input type="text" readonly name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' style="width:99.4%;"></td>
          <td colspan="2">
       
          
          <input type="button" name="btnupdate" id="btnupdate" class="myButton" value="Edit"  onclick="funupdate()" > &nbsp;&nbsp;&nbsp;<input type="button"  name="leaseprintbtn" id="leaseprintbtn" class="myButton" value="Print" onclick="funPrintdown()" ></td>
          
           
        </tr>
        <tr>
          <td align="right">OUT     :&nbsp;&nbsp;  Date</td>
          <input type="hidden" name="hiddateout" id="hiddateout" value='<s:property value="hiddateout"/>'>
          <td width="16%" align="left"><div id="dateout" name="dateout" ></div></td>
          <td width="15%" align="right">Time</td>
          <input type="hidden" name="hidtimeout" id="hidtimeout" value='<s:property value="hidtimeout"/>'>
          <td width="11%" align="left"><div id="timeout" name="timeout"></div></td>
          <td width="8%" align="right">Km</td>
          <td align="left"><input type="text" name="kmout" id="kmout" value='<s:property value="kmout"/>' onkeypress="javascript:return isNumber (event)" ></td>
          <td align="left" colspan="4">&nbsp;&nbsp;&nbsp;Fuel&nbsp;&nbsp;<!-- </td>
          <td align="left" colspan="3"> --><select name="cmbfuelout" id="cmbfuelout">  
            <option value="" selected>-Select-</option>
             <option value=0.000 >Level 0/8</option>
             <option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
             <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
             </select> <input type="hidden" name="hidcmbfuelout" id="hidcmbfuelout" value='<s:property value="hidcmbfuelout"/>'>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <button type="button"  title="Reset"  class="icon" id="cleardata" onclick="clearvehdata()"  value='<s:property value="cleardata"/>'>
					 <img alt="Reset" src="<%=contextPath%>/icons/cancel_new.png"> 
					</button>
            </td>
          
        </tr>
      </table >
      </fieldset>
      <fieldset   id="delupdatefd">
        <legend>Delivery Details</legend>
      <table  width="100%">
        <tr>
          <td align="right" width="7%">Del Date</td>
          <input type="hidden" name="hiddeldateout" id="hiddeldateout" value='<s:property value="hiddeldateout"/>'>
          <td align="left"><div id="deldateout" name="deldateout"></div></td>
          <td align="right">Del Time</td>
          <input type="hidden" name="hiddeltimeout" id="hiddeltimeout" value='<s:property value="hiddeltimeout"/>'>
          <td align="left"  width="10%"><div id="deltimeout" name="deltimeout"></div></td>
          <td align="right">Del Km</td> 
          <td align="left"><input type="text" name="delkmout" id="delkmout" value='<s:property value="delkmout"/>' onblur="funchkKm();"  onkeypress="javascript:return isNumber (event);"></td>
          <td align="right">Del Fuel</td>
          <td align="left"><select name="cmbdelfuelout" id="cmbdelfuelout">
           <option value="" selected>-Select-</option>
            <option value=0.000 >Level 0/8</option>
             <option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
           <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
          </select></td>
           <td  align="center"><input type="button" name="btndelupdate" id="btndelupdate" class="myButton" value="Edit"  onclick="fundelupdate()">&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
      </table>
      </fieldset>
      </td>

    </tr>
  </table>
  
  
  
   <input type="hidden" name="checkbranch" id="checkbranch" value='<s:property value="checkbranch"/>'>
  
 <input type="hidden" name="masterdoc_no" id="masterdoc_no" value='<s:property value="masterdoc_no"/>'>
  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
  <input type="hidden" id="tariffgridlength" name="tariffgridlength"/>
    <input type="hidden" id="paymentgridlength" name="paymentgridlength"/> 
    
     <input type="hidden" id="drivergridlength" name="drivergridlength"/> 
    
    
<input type="hidden" id="newvehdetalslenght" name="newvehdetalslenght"/>
    
    
      <input type="hidden" name="deldrvid" id="deldrvid" value='<s:property value="deldrvid"/>'  />
    
    <input type="hidden" name="delchkvalue" id="delchkvalue" value='<s:property value="delchkvalue"/>'  />
     <input type="hidden" name="chaffchkvalue" id="chaffchkvalue" value='<s:property value="chaffchkvalue"/>'  />
     <input type="hidden" name="add_drchk" id="add_drchk" value='<s:property value="add_drchk"/>'  />
     <input type="hidden" name="hidper_value" id="hidper_value" value='<s:property value="hidper_value"/>'  />
     <input type="hidden" name="hidper_name" id="hidper_name" value='<s:property value="hidper_name"/>'  />
     <input type="hidden" name="hidadvance_chk" id="hidadvance_chk" value='<s:property value="hidadvance_chk"/>'  />
     <input type="hidden" name="hidinvoice" id="hidinvoice" value='<s:property value="hidinvoice"/>'  />
     <input type="hidden" name="hidoutdate" id="hidoutdate" value='<s:property value="hidoutdate"/>'  />
     <input type="hidden" name="hidouttime" id="hidouttime" value='<s:property value="hidouttime"/>'  />
     <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'  />
     <input type="hidden" name="hiddeloutdate" id="hiddeloutdate" value='<s:property value="hiddeloutdate"/>'  />
     <input type="hidden" name="hiddelouttime" id="hiddelouttime" value='<s:property value="hiddelouttime"/>'  />
     <input type="hidden" name="hiddelcmbtype" id="hiddelcmbtype" value='<s:property value="hiddelcmbtype"/>'  />
     <input type="hidden" id="vehlocation" name="vehlocation"  value='<s:property value="vehlocation"/>' />
	 <input type="hidden" name="priormethod" id="priormethod">
	 <input type="hidden" name="totalmasterqty" id="totalmasterqty">
	 <input type="hidden" name="totalagmtqty" id="totalagmtqty">
<input type="hidden" name="priorvalue" id="priorvalue">
<input type="hidden" name="invruleoverride" id="invruleoverride">
<input type="hidden" name="advchkval" id="advchkval" value='<s:property value="advchkval"/>'  /> 
       <input type="hidden" name="invval" id="invval" value='<s:property value="invval"/>' />
       <input type="hidden" id="configmethod" name="configmethod" value='<s:property value="configmethod"/>' />
</div>

</form>
 <div id="windows2">
   <div style="background-color: #E0ECF8;"></div>
</div>  

<div id="clientinfowindow">
   <div ></div>
   </div>
   <div id="driverinfowindow">
   <div ></div></div>
   <div id="vehinfowindow">
   <div ></div></div>
   <div id="chauffeurinfowindow">
   <div ></div>
</div>
  <div id="deldrvwindow">
   <div ></div>
</div>

  <div id="projectwindow">
   <div ></div>
</div>
 <div id="masterrefnowindow">
   <div ></div>
</div>
</div>

</body>
</html>