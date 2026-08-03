<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
 <% String contextPath=request.getContextPath();%>

<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

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

#frmgin input[type="text"],
#frmgin select,
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

#frmgin input[type="text"]:focus,
#frmgin select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmgin input[readonly],
#frmgin input:disabled,
#frmgin select:disabled,
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
    flex-shrink: 0; /* Keep labels from squishing */
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

.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

#psearch {
   
    border-color: #e0d0be;
}
#psearch .middle-panel-title {
   
    color: #856404;
    border-left-color: #856404;
}
.ff { display: none; }
</style>

<script type="text/javascript">


$(document).ready(function () {  
    
	   /* Date */ 	
	    
	   		 $('#btnvaluechange').hide();
	   
	   	  
       $("#masterdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
     
       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	     $('#searchwndow').jqxWindow('close');  
	       $('#sidesearchwndow').jqxWindow({ width: '55%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close');   
	     
	     
	     
	     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		   $('#searchwindow').jqxWindow('close'); 
	 
		   
		   
		   $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
		     $('#importwindow').jqxWindow('close');   
		     
		     
		     $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		     $('#locationwindow').jqxWindow('close');  
			   

		 
		   
		   $('#itemdocno').dblclick(function(){

				  if($("#mode").val() == "A" || $("#mode").val() == "E")
					  {
			 
				//itemtype,itemdocno,itemname
				  
		  	    $('#searchwindow').jqxWindow('open');
		  	
				if(document.getElementById("itemtype").value=="1")
					{
					refsearchContent('costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
					}
				
				
				
	    		else if(document.getElementById("itemtype").value=="6")
				{
				 refsearchContent('fleetGrid.jsp?'); 	
				}
			
		  	  	  	  
		  	
	    		else
				{
				 refsearchContent('costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
				} 
					  }
			  }); 
			  
			   $('#txtlocation').dblclick(function(){
				   
					  if($("#mode").val() == "A" || $("#mode").val() == "E")
						  {
					   
				  	    $('#locationwindow').jqxWindow('open');
				  	
				  	  locationsearchContent('searchlocation.jsp?'); 
						  }
					  
			  	  
		          
	                     }); 
		   

				 $('#masterdate').on('change', function (event) {
					  
					    var maindate = $('#masterdate').jqxDateTimeInput('getDate');
					  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
					    funDateInPeriodchk(maindate);
					  	 }
					   });




 
  
});


 

	  
	  
	  function getitem(event){
	      	 var x= event.keyCode;
	      	 if(x==114){

	      		  $('#searchwindow').jqxWindow('open');
	      			
	      		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
				{
				refsearchContent('costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
				}
	      		
	    		else if(document.getElementById("itemtype").value=="6")
				{
				 refsearchContent('fleetGrid.jsp?'); 	
				}
			
	      		
			else
				{
				 refsearchContent('costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
				}
			

	      		 
	      		  
	      	 
	      	 }
	      	 else{
	      		 }
	      	 }  
	      	  function refsearchContent(url) {
	           //alert(url);
	              $.get(url).done(function (data) {
	      //alert(data);
	            $('#searchwindow').jqxWindow('setContent', data);

	      	}); 
	        	}
	  
	  
      function productSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#sidesearchwndow').jqxWindow('open');
     		$('#sidesearchwndow').jqxWindow('setContent', data);
     
     	}); 
     	} 

      function getloc(event){
      	 var x= event.keyCode;
      	 if(x==114){
      	  $('#locationwindow').jqxWindow('open');
      	
      	  locationsearchContent('searchlocation.jsp?');   }
      	 else{
      		 }
      	 }  
      	  function locationsearchContent(url) {
           //alert(url);
              $.get(url).done(function (data) {
      //alert(data);
            $('#locationwindow').jqxWindow('setContent', data);

      	}); 
        	}


function funReset(){
	//$('#frmgin')[0].reset(); 
}
function funReadOnly(){
	$('#frmgin input').attr('readonly', true );
	$('#frmgin select').attr('disabled', true );
	 $('#masterdate').jqxDateTimeInput({ disabled: true});
	 
		$("#serviecGrid").jqxGrid({ disabled: true});
		
		 $('#psearch').attr('disabled', true );
		 $('#setbtn').attr('disabled', true ); 
 
 $('#btnvaluechange').hide();
 
	
}
function funRemoveReadOnly(){
	reloads();    
	 chkmultiqty();
	 chkproductconfig();
	 document.getElementById("editdata").value="";
	$('#frmgin input').attr('readonly', false );
/* 	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true); */
	$('#frmgin select').attr('disabled', false );
    
		 $('#btnvaluechange').hide();
		 
		 $('#txtlocation').attr('readonly', true);
		 
		 $('#itemdocno').attr('readonly', true);
		 $('#itemname').attr('readonly', true);
		 
		 $('#clientname').attr('readonly', true);
			$('#psearch').attr('disabled', false );
			   $('#setbtn').attr('disabled', false ); 
		 $('#site').attr('readonly', true);
		 
		 
		// itemname  clientname site
		 
		 
	  
	 $('#masterdate').jqxDateTimeInput({ disabled: false});
	 
 
	 
	$('#docno').attr('readonly', true);
	 
	 $("#serviecGrid").jqxGrid({ disabled: false});

 
	 
	if ($("#mode").val() == "A") {
		  //$('#chkdiscount').attr('disabled', false);
		$('#masterdate').val(new Date());
	 
			 $("#serviecGrid").jqxGrid('clear');
			    $("#serviecGrid").jqxGrid('addrow', null, {});
				 $('#itemname').attr('readonly', true);
				 
				 $('#clientname').attr('readonly', true);
				 
				 $('#site').attr('readonly', true);
				 
		   
	   }
	
  	if ($("#mode").val() == "E") {
		 $('#btnvaluechange').show();
		$("#serviecGrid").jqxGrid({ disabled: true});
	}  
}
function funcheckaccinvendor()
{
	if(document.getElementById("puraccid").value=="")
		{
		 document.getElementById("errormsg").innerText="Search Vendor";  
		 document.getElementById("puraccid").focus();
	       
	        return 0;
		}
	
}


function funFocus(){
	 
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}
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
	   


	var maindate = $('#masterdate').jqxDateTimeInput('getDate');
	   var validdate=funDateInPeriodchk(maindate);
	   if(validdate==0){
	   return 0; 
	   }

	if(document.getElementById("txtlocation").value=="")
	{

	 document.getElementById("errormsg").innerText="Search Location";  
	 document.getElementById("txtlocation").focus();
	   
	    return 0;
	}
		 
	else
		{
		  document.getElementById("errormsg").innerText="";
		}
		   
	  if(parseInt(document.getElementById("multimethod").value)==1)
		{	
		  chkstock();
		}
	  else
		  {
	 save();
		  }
	  
	  
	}


function chkstock()
{

		var rows = $("#serviecGrid").jqxGrid('getrows');
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
		 var location=document.getElementById("txtlocationid").value;
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
		 	 x.open("GET","validateqty.jsp?list="+list+"&branch="+branch+"&mode="+mode+"&location="+location+"&date="+document.getElementById("masterdate").value,true);
				x.send();
			        
		 }


function save(){	
 
  

 
 

 
var rows = $("#serviecGrid").jqxGrid('getrows');
   $('#serviecGridlength').val(rows.length);
  //alert($('#gridlength').val());
  for(var i=0 ; i < rows.length ; i++){
	  
	 
	 var chkqty=rows[i].qty;
			  // var myvar = rows[i].tarif; 
				   newTextBox = $(document.createElement("input"))  
				      .attr("type", "dil")
				      .attr("id", "sertest"+i)
				      .attr("name", "sertest"+i)
				      .attr("hidden", "true");         
				  
				  /* newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
						   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: ");
				 */ /* discount  disper */    /* 	 cost_price   savecost_price */
			if(parseInt(chkqty)>0){	 
				 newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
						   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"+rows[i].cost_price+" ::"+rows[i].savecost_price);
				
			}	 
				// alert(newTextBox.val());
				  newTextBox.appendTo('form');
				  
		   
 
   
  }   
	  
	    
	    	   
	    		$("#serviecGrid").jqxGrid({ disabled: false});
			 
			 
	    		$("#frmgin").submit();
			 
			   
	   
	
	return 1;
} 

function calculatedata(val)
{

}

function funwarningopen(){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	     
		 		  document.getElementById("editdata").value="Editvalue";
				 
	    		$("#serviecGrid").jqxGrid({ disabled: false});
	    		  $("#serviecGrid").jqxGrid('addrow', null, {});
	    		  $('#psearch').attr('disabled', false );
	    		    $('#setbtn').attr('disabled', false );  
	    		  /*   if($('#reftypeval').val()!="DIR")
		  	  		  {  
		  	  		
		  	  		 
		  	    			$('#psearch').attr('disabled', true );
		  	    		    $('#setbtn').attr('disabled', true );  
		  	    			
		  	  		  }
		  	    		else
		  	    			{  
		  	    			$('#psearch').attr('disabled', false );
		  	    		    $('#setbtn').attr('disabled', false );  
		  	    			
		  	    			} */
	       }
	      });
	   }

function funChkButton() {
	

}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}
function getCurrencyIds(){
	   
	      
	        }
	   
	   function getRatevalue(angel)
	   {
	   
	      
	        }
	   
	   
	   function combochange()
	   {
		   
 
		   
		   
		   
		   
		   
			
	   }

	   function setValues() {
			if($('#hidmasterdate').val()){
				$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
			}
			
			 
			
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{     
				//alert("");
				//funchkforedit();
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   

	     	  		  
		 	
		 	var locationid=document.getElementById("txtlocationid").value;
	     	  		 
	     	  		 $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&locationid="+locationid+"&date="+document.getElementById("masterdate").value);
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    		combochange();
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
				//  getCurrencyId();
				
		} 
	   function funPrintBtn(){
	 	  
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;
 
	        var reurl=url.split("saveActiongins");
	        
	        $("#docno").prop("disabled", false);                
	        var dtype=$('#formdetailcode').val();
	  
	/* var win= window.open(reurl[0]+"printGrn?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus(); */ 
	         var win= window.open(reurl[0]+"PRINTgin?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     
	    	win.focus(); 
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#frmgin').validate({
                rules: { 
              
                	delterms:{maxlength:200},
                	purdesc:{maxlength:200},
                	payterms:{maxlength:200},
                	/* refno:{required:true}, */
                	puraccid:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 200 chars"},
                	 purdesc: {maxlength:"  Max 200 chars"},
                	 payterms: {maxlength:"  Max 200 chars"},
               /*  	 refno: {required:" * required"}, */
                	 puraccid: {required:" *"}
                 }
        });});
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
 
 
 function funrefdisslno()
 {
	 
	 
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
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
			x.send();
		
		
		}
	 
	function removemsg()
	{
		 document.getElementById("errormsg").innerText="";
		
	}
	
	 function gettype(){ 
		 
			
			   var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    {
			      items= x.responseText;
			       
			      items=items.split('####');
			           var docno=items[0].split(",");
			           var type=items[1].split(",");
			        
			           var optionstype = '';
 
			
			           for ( var i = 0; i < type.length; i++) {
			        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
				        }
			          
			            $("select#type").html(optionstype); 	
			            
			        
			            if($('#hidetype').val()!="")
						  {
						  
						  
						  $('#type').val($('#hidetype').val());   
						  
						  }
					 
			  
			    }
			       }
			   x.open("GET","gettype.jsp?",true);
				x.send();
			        
			      
			        }
	 
	 function getitemtype(){ 
		 
			
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		       
		      items=items.split('####');
		           var docno=items[0].split(",");
		           var type=items[1].split(",");
		        
		           var optionstype = '';

		
		           for ( var i = 0; i < type.length; i++) {
		        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
			        }
		            
		            $("select#itemtype").html(optionstype); 	
		            
		        
		            if($('#hideitemtype').val()!="")
					  {
					  
					  
					  $('#itemtype').val($('#hideitemtype').val());   
					  
					  }
				 
		  
		    }
		       }
		   x.open("GET","getitem.jsp?",true);
			x.send();
		        
		      
		        }
	 
	 
	 function cleardata()
	 {
		 document.getElementById("itemdocno").value="";
		 document.getElementById("itemname").value="";
		 document.getElementById("clientname").value="";
	 
		 document.getElementById("cldocno").value="";
		 document.getElementById("siteid").value="";
		 document.getElementById("site").value="";
		 
	 
	 }
		function setgrid()
		 {
			
			   
			 
			 var temppsrno=document.getElementById("temppsrno").value; 
			 var unit=document.getElementById("unit").value; 
			 
			 
	 
       	  
   		var rows1 = $("#serviecGrid").jqxGrid('getrows');
 	    var aa=0;
 	    for(var i=0;i<rows1.length;i++){
 	 
 	    	
 	    	 
 		   if(parseInt(rows1[i].prodoc)==parseInt(temppsrno))
 			   {
 		  
				 if((parseInt(document.getElementById("multimethod").value)==1))
				{	
					   
   			   if(parseInt(rows1[i].unitdocno)==parseInt(unit))
   			   {
   				   
   				   aa=1;
       			   break;
   			   }
				}
				 else
					 {
 			   
 			   aa=1;
 			   break;
					 }
 			   }
 		   else{
 			   
 			   aa=0;
 		       } 
 	    }
			 
 	   if(parseInt(aa)==1)
		   {
		   
			document.getElementById("errormsg").innerText="You have already select this product";
			  

				 
		     document.getElementById("jqxInput1").focus();
			 
		   return 0;
		   
		   
		   
		   }
	   else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
	    
			
			
			
			 var rows = $('#serviecGrid').jqxGrid('getrows');
			  
		 	 
		     var rowlength= rows.length;
			 

		     
		  /*    if(document.getElementById("multi").checked)
			 {
		    	
		    	 
		    	 
		    	 
		    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
				  
				 
				  if(document.getElementById("colbatch").value=="")
					  {
					  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
		        		 
		        		return 0;
					  }
				  
				  
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
				     
		    	 
		    	 
		     }
		     else
		    	 {
		    	 
		    	 
		    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
				 
			 
				 if(parseInt(document.getElementById("expchk").value)==1)
					 {
					 
					  var  exp_date=document.getElementById("expdate").value;
					 
					 
					   if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
		      	 	   {
							 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
			        		 
				        		return 0;
		      	 	   }
		     		   
					 
			 
					 
					 
					 
					   $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
					 }else
						 {
						 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
						 }
				 
				 
				
				 
		    	 
		    	 } */
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
		    // $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
		    
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
		     if(document.getElementById("unit").value>0)
		     {
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
		     }
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
		     $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
		   /*  


		     
		     if(document.getElementById("multi").checked)
			 {
		    	
		    	 
		    	 
		    	 
		    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
				  
				 
				  if(document.getElementById("colbatch").value=="")
					  {
					  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
		        		 
		        		return 0;
					  }
				  
				  
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
				     
		    	 
		    	 
		     }
		     else
		    	 {
		    	 
		    	 
		    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
				 
			 
				 if(parseInt(document.getElementById("expchk").value)==1)
					 {
					 
					  var  exp_date=document.getElementById("expdate").value;
					 
					 
					   if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
		      	 	   {
							 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
			        		 
				        		return 0;
		      	 	   }
		     		   
					 
			 
					 
					 
					 
					   $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
					 }else
						 {
						 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
						 }
				 
				 
				
				 
		    	 
		    	 }
				  
				  */ 
				   document.getElementById("jqxInput").value ="";
				   document.getElementById("jqxInput1").value="";
				   document.getElementById("brand").value=""; 
		           document.getElementById("collqty").value ="";
				   document.getElementById("quantity").value ="";
				   document.getElementById("unit").value ="";
				  /*  document.getElementById("focs").value="";
			  	   document.getElementById("batch").value="";
				   document.getElementById("colbatch").value=""; */
				    document.getElementById("temppsrno").value="";
				     document.getElementById("tempspecid").value="";
				     
				      
				     /*  
				      
				      document.getElementById("multi").checked=false;
					 	 document.getElementById("batch").value="";
						 document.getElementById("colbatch").value="";
						 
						 
						  $('#batch').attr('readonly', false);
						 $('#expdate').jqxDateTimeInput({ disabled: false});
						 $('#expdate').val(null);
						  */
				      								
			 		 $("#serviecGrid").jqxGrid('addrow', null, {});
		    		 document.getElementById("jqxInput1").focus();
		 
		 }
		 function getunit(val){ 
			 
				
			   var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    {
			      items= x.responseText;
			       
			      items=items.split('####');
			           var docno=items[0].split(",");
			           var type=items[1].split(",");
			        
			           var optionstype;

			
			           for ( var i = 0; i < type.length; i++) {
			        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
				        }
			            
			            $("select#unit").html(optionstype); 	
			            
			            
			         
			  
			    }
			       }
			   x.open("GET","getunit.jsp?psrno="+val,true);
				x.send();
		}
		 function reloads()
			{  
		    var locid =document.getElementById("txtlocationid").value;      
	        var date =$('#masterdate').val();    
	        var id=1;
	 		 $("#part").load('part.jsp?locid='+locid+"&date="+date+"&id="+id);
	 		 $("#pnames").load('name.jsp?locid='+locid+"&date="+date+"&id="+id);  
			}   
	 
</script>  
</head>
<body onLoad="setValues();chkcostcode();getitemtype();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmgin" action="saveActiongins" method="post" autocomplete="off">  
<jsp:include page="../../../../header.jsp" />  
<jsp:include page="multiqty.jsp"></jsp:include><br/> 

<div class='modern-ui hidden-scrollbar'>
    
    <!-- General Info -->
    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
            <div style="width: 125px; flex-shrink:0;">
                <div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
                <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'>
            </div>
            
            <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Type</label>
            <select id="type" name="type" style="width:100px; flex-shrink:0;">
                <option></option>
            </select>
            
            <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Location</label>
            <div class="input-search-container" style="width: 150px; flex-shrink:0;">
                <input type="text" id="txtlocation" name="txtlocation" placeholder="Press F3" value='<s:property value="txtlocation"/>' onkeydown="getloc(event);"/>
                <svg class="magnifier-icon" onclick="if($('#mode').val()!='view') { $('#locationwindow').jqxWindow('open'); locationsearchContent('searchlocation.jsp?'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/>
            
            <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: auto;">Ref No</label>
            <input type="text" name="refno" id="refno" value='<s:property value="refno"/>' style="width:100px; flex-shrink:0;">
            
            <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Doc No</label>
            <input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly style="width:100px; flex-shrink:0;">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Group</label>
            <select id="itemtype" name="itemtype" style="width:125px; flex-shrink:0;" onchange="cleardata()">
                <option></option>   
            </select>  
            
            <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Job No</label>
            <div class="input-search-container" style="width: 150px; flex-shrink:0;">
                <input type="text" id="itemdocno" name="itemdocno" placeholder="Press F3" value='<s:property value="itemdocno"/>' onkeydown="getitem(event);">
                <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E') { $('#searchwindow').jqxWindow('open'); if($('#itemtype').val()=='1') { refsearchContent('costCodeSearchGrid.jsp?docno='+$('#itemtype').val()); } else if($('#itemtype').val()=='6') { refsearchContent('fleetGrid.jsp?'); } else { refsearchContent('costunitsearch.jsp?docno='+$('#itemtype').val()); } }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input type="text" id="itemname" name="itemname" style="flex:1; min-width:0; margin-left: 8px;" value='<s:property value="itemname"/>' onkeydown="getitem(event);" readonly tabindex="-1">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Client</label>    
            <input type="text" id="clientname" name="clientname" style="flex:1; min-width:0;" value='<s:property value="clientname"/>' />
            <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'/>
            
            <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left:15px;">Site</label>
            <input type="text" name="site" id="site" style="flex:1; min-width:0;" value='<s:property value="site"/>' >
            <input type="hidden" name="siteid" id="siteid" value='<s:property value="siteid"/>' >
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Description</label>
            <input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="flex:1; min-width:0;">
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left:15px; flex-shrink:0;">Value Change</button>
        </div>
        
        <input type="text" name="gridtext" id="gridtext" style="width:0%;height:0%; opacity:0;" class="textbox" value='<s:property value="gridtext"/>' />   
        <input type="text" name="gridtext1" id="gridtext1" style="width:0%;height:0%; opacity:0;" class="textbox" value='<s:property value="gridtext1"/>' />  
    </div>
    
    <!-- Item Details -->
    <div class="middle-panel" id="psearch">
        <span class="middle-panel-title">Item Details</span>
        <div class="field-row" style="align-items:flex-end; margin-bottom:0;">
            <div style="flex:1; min-width:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#856404; margin-left:2px;">Product ID</label>
                <div id="part"><jsp:include page="part.jsp"></jsp:include></div>
            </div>
            
            <div style="flex:2; min-width:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#856404; margin-left:2px;">Product Name</label>
                <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div>
            </div>
            
            <div style="flex:1; min-width:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#856404; margin-left:2px;">Brand</label>
                <input type="text" id="brand" style="width:100%;" />
                <input type="hidden" id="collqty" />
            </div>
            
            <div style="width:100px; flex-shrink:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#856404; margin-left:2px;">Unit</label>
                <select id="unit" style="width:100%;"></select>      
            </div>
            
            <div style="width:80px; flex-shrink:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#856404; margin-left:2px;">Qty</label>
                <input type="hidden" id="loads" class="myButtons" value="Load Data" onclick="loaddatass()">  
                <input type="text" id="quantity" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="text-align: left; width:100%;" onchange="calculatedata(this.id);">
            </div>
            
            <div style="flex-shrink:0; display:flex; gap:8px; align-items:center; margin-bottom:1px;">
                <input type="hidden" id="cleardata">
                <input type="button" id="setbtn" class="btn" onclick="setgrid()" value="ADD" style="margin-left:8px;">
            </div>
            
            <!-- .ff hidden elements preserved -->
            <div class="ff" style="display:none;">
                <input type="text" id="focs" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);">
                <input type="hidden" id="multi" onchange="chkmultis()">
                <input type="hidden" id="batch" onkeydown="getbatch(event)">
                <div id="expdate" name="expdate" value='<s:property value="expdate"/>'></div> 
            </div>
        </div>
    </div>
    
    <!-- Details Grid -->
    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="sevdesc" class="grid-container">
            <jsp:include page="serviecgrid.jsp"></jsp:include>
        </div>
    </div>
    
    <!-- Hidden Inputs Block (Retained Summary inputs from Original) -->
    <div style="display:none;">
        <input type="hidden" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'>
        <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>' onkeypress="javascript:return isNumber (event);">
        <input type="hidden" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);">
        <input type="hidden" id="roundmethod">
        <input type="hidden" id="roundvals">
        
        <input type="hidden" id="costtr_no" name="costtr_no" value='<s:property value="costtr_no"/>'/> 
        <input type="hidden" id="hideitemtype" name="hideitemtype" value='<s:property value="hideitemtype"/>'/> 
        <input type="hidden" id="hidetype" name="hidetype" value='<s:property value="hidetype"/>'/>
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="refmasterdoc_no" name="refmasterdoc_no" value='<s:property value="refmasterdoc_no"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
        <input type="hidden" id="rowval" name="rowval" value='<s:property value="rowval"/>'/> 
        <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>  
        <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>  
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="acctypegrid" name="acctypegrid" value='<s:property value="acctypegrid"/>'/>
        <input type="hidden" id="serviecGridlength" name="serviecGridlength" value='<s:property value="serviecGridlength"/>'/>  
        <input type="hidden" id="hidelocation" name="hidelocation" value='<s:property value="hidelocation"/>'/>
        <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
        <input type="hidden" id="productchk" name="productchk" value='<s:property value="productchk"/>'/>
        <input type="hidden" id="temppsrno" >  
        <input type="hidden" id="tempspecid" > 
        <input type="hidden" id="tempunitdocno" > 
    </div>

</div>
</form>

<div id="searchwindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="sidesearchwndow"><div></div></div>
<div id="importwindow"><div></div></div>
<div id="searchwndow"><div></div></div>
<div id="locationwindow"><div></div></div>

</div>
</body>
</html>