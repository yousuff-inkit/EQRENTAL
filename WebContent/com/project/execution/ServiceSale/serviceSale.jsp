	<%@ taglib prefix="s" uri="/struts-tags" %>
	<!DOCTYPE html>
	<html>
	<head>
	<title>GatewayERP(i)</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	 <jsp:include page="../../../../includes.jsp"></jsp:include>
	
	<style>
	form label.error {
	color:red;
	  font-weight:bold;
	
	}
	</style>
	<script type="text/javascript">
	
	$(document).ready(function () {
		$("#cmbcurr").css("pointer-events","none");
	    getAccountTypeEntity();
		   /* Date */ 	
	    $("#nipurchasedate").jqxDateTimeInput({  width: '109px', height: '20px', formatString:"dd.MM.yyyy"});
	    $("#deliverydate").jqxDateTimeInput({  width: '109px', height: '20px', formatString:"dd.MM.yyyy"});
	    
	    $("#invDate").jqxDateTimeInput({  width: '109px', height: '20px', formatString:"dd.MM.yyyy"});
	    $('#nipurchasedate').on('change', function (event) {
	    	  
		    var maindate = $('#nipurchasedate').jqxDateTimeInput('getDate');
		  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
		    funDateInPeriod(maindate);
		  	 }
		   });
	    
	    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '75%',  maxHeight: '74%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
	    $('#accountSearchwindow').jqxWindow('close');
		$('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	    $('#accounttypeSearchwindow').jqxWindow('close');
	    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, keyboardCloseKey: 27});
	    $('#costtpesearchwndow').jqxWindow('close');   
	    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, keyboardCloseKey: 27});
	    $('#costcodesearchwndow').jqxWindow('close');  
	    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Ref No Search' ,position: { x: 450, y: 40 }, keyboardCloseKey: 27});
	    $('#refnosearchwindow').jqxWindow('close');  
	    $('#nipurchslnosearch').jqxWindow({ width: '50%', height: '59%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 200, y: 60}, keyboardCloseKey: 27});
	    $('#nipurchslnosearch').jqxWindow('close');
	    $('#printWindow').jqxWindow({width: '30%', height: '19%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#printWindow').jqxWindow('close');
	    getCurrencyIds($("#nipurchasedate").val());
	     
		  	 $('#nipuraccid').dblclick(function(){
		  		if($('#mode').val()!= "view")
	    		{
			  	    $('#accountSearchwindow').jqxWindow('open');
			 
			
			  	  accountSearchContent('accountDetailsFromSearch.jsp?type='+$('#cmbtype').val());
	    		} 
	  });   
	});
				function getAccountTypeEntity(){
				    var x = new XMLHttpRequest();
				    x.onreadystatechange = function() {
				     if (x.readyState == 4 && x.status == 200) {
				          var items = x.responseText.trim();
				          if(items==1){
				          	$("#typetd1").show();
				          	$("#typetd2").show();
				          }
				          else{
				        	  $("#typetd1").hide();
				        	  $("#typetd2").hide();
				          }
				     }
				    }
				    x.open("GET", "getAccountTypeEntity.jsp", true);
				    x.send();
				}
	
				function getNonTaxableEntity(){
				    var x = new XMLHttpRequest();
				    x.onreadystatechange = function() {
				     if (x.readyState == 4 && x.status == 200) {
				          var items = x.responseText.trim();
				          $('#txtnontaxableentity').val(items);
				          if(parseInt($('#txtnontaxableentity').val().trim())==1){
				        	  getTaxper($("#nipurchasedate").jqxDateTimeInput('val'));
				          }
				     }
				    }
				    x.open("GET", "getNonTaxableEntity.jsp", true);
				    x.send();
				}
				
				
				function getTaxper(date){
					var x = new XMLHttpRequest();
				    x.onreadystatechange = function(){
					    if (x.readyState == 4 && x.status == 200) {
						    var items = x.responseText.trim();
						    $('#taxperc').val(items);
					    }
				    }
				   x.open("GET", "getTaxper.jsp?date="+date, true);
				   x.send();
				}
					 function costcodeSearchContent(url) {
							 $.get(url).done(function (data) {
								 $('#costcodesearchwndow').jqxWindow('open');
								 $('#costcodesearchwndow').jqxWindow('setContent', data);
							 }); 
					 }  
	
						function costSearchContent(url) {
								 $.get(url).done(function (data) {
									 $('#costtpesearchwndow').jqxWindow('open');
									 $('#costtpesearchwndow').jqxWindow('setContent', data);
								 }); 
						} 
							
						function CashSearchContent(url) {
							 //alert(url);
								 $.get(url).done(function (data) {
									 $('#accounttypeSearchwindow').jqxWindow('open');
									 $('#accounttypeSearchwindow').jqxWindow('setContent', data);
								 }); 
						} 
						function getaccountdetails(event){
							var x= event.keyCode;
						 	if($('#mode').val()!= "view")
				    		{
						 		if(x==114){
						 			$('#accountSearchwindow').jqxWindow('open');
						 			accountSearchContent('accountDetailsFromSearch.jsp?type='+$('#cmbtype').val());  
							 	 }
							 	 else{
							 	 }
				    		} 
						}  
						function accountSearchContent(url) {
							$.get(url).done(function (data) {
								$('#accountSearchwindow').jqxWindow('setContent', data);
							}); 
						}
						function nipurhsaeslnocontent(url) {
							$.get(url).done(function (data) {
								$('#nipurchslnosearch').jqxWindow('open');
								$('#nipurchslnosearch').jqxWindow('setContent', data);
							}); 
						} 
		  

						function funFocus(){
							$('#nipurchasedate').jqxDateTimeInput('focus');  		
						}
			
	function funNotify(){	
				var maindate = $('#nipurchasedate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(maindate);
				if(validdate==0){
						return 0; 
				}  
				console.log(1);
				var val1=0;     
				var rows = $('#nidescdetailsGrid').jqxGrid('getrows');     
				for(var i=0;i<rows.length;i++){
					var netchk=rows[i].nettotal;  
					var accchk=rows[i].account;   
					if(typeof(netchk) != "undefined" && typeof(netchk) != "NaN" && netchk != "0.00" && netchk != "" && netchk != null) {        
						if(typeof(accchk) == "undefined" || typeof(accchk) == "NaN" || accchk == "" || accchk == null) {            
							val1=1;      
						}      
					}
				}
				if(val1==1){
					document.getElementById("errormsg").innerText=" Select an Account";
					return 0; 
				}else{
					document.getElementById("errormsg").innerText="";     
				}
							/* var length=rows.length;        
							if(typeof (rows[length-1].nettotal) != "undefined" && rows[length-1].nettotal != "undefined" && rows[length-1].nettotal != null){                         
								console.log("1=="+rows[length-1].nettotal);       
								for(var i=length-1;i>=0;i--){    
									console.log(rows[i].netottal+"===account=="+rows[i].account+"====");         
									if(((rows[i].netottal!="") || (rows[i].nettotal!="0.00") || (typeof(rows[i].netottal)!="undefined")) && rows[i].account==""){  
										document.getElementById("errormsg").innerText=" Select an Account";
										return 0;    
										i=0;
									}
									else{
										document.getElementById("errormsg").innerText="";
									}
								}
							}
							else{
								for(var i=length-2;i>=0;i--){
									console.log("2=="+rows[i].nettotal);    
									if(((rows[i].nettotal!="") || (rows[i].nettotal!="0.00") || (rows[i].netottal!="undefined")) && rows[i].account==""){   
										document.getElementById("errormsg").innerText=" Select an Account";	
										return 0;
										i=0;
									}
									else{
										document.getElementById("errormsg").innerText="";
									}
								}
							} */    
							console.log(2);
							var refno= document.getElementById('refno').value;
							if(refno=="")
							{
								document.getElementById("errormsg").innerText=" Enter Ref NO";	
								document.getElementById('refno').focus();
								return 0;
							}
							else
							{
								document.getElementById("errormsg").innerText="";
							}
							var purid= document.getElementById("nipuraccid").value;
							if(purid=="")
							{
								 document.getElementById("errormsg").innerText=" Select An Account";
								 document.getElementById("nipuraccid").focus();
								 return 0;
							}
							else
							{
								document.getElementById("errormsg").innerText="";
							}
							console.log(3);
							var invno= document.getElementById("invno").value;
							if(invno=="")
							{
								 document.getElementById("errormsg").innerText=" Enter PO NO";
								 document.getElementById("invno").focus();
								 return 0;
							}
							else
							{
								   document.getElementById("errormsg").innerText="";
							} 
							 var refval= document.getElementById("nettotal").value;
							 if(refval=="")
							 {
								 document.getElementById("errormsg").innerText="Net Total Empty";
								 return 0;
							 }
							else
							{
								   document.getElementById("errormsg").innerText="";
							}
							 var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
							 $('#nidescdetailslenght').val(rows.length);
							 for(var i=0 ; i < rows.length ; i++){
								 newTextBox = $(document.createElement("input"))
								 .attr("type", "dil")
								 .attr("id", "desctest"+i)
								 .attr("name", "desctest"+i)
								 .attr("hidden", "true"); 
								 var aa=0;
								 newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
										 +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "
										 +rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].nuprice+" :: "
										 +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+aa+" :: ");
								 newTextBox.appendTo('form');
							 }   
							 var x =new XMLHttpRequest();
							 x.onreadystatechange=function()
							 {
								 if(x.readyState==4 && x.status==200)	
								 {
									 var items=x.responseText;
									 var chk=items.trim();
									 
									 			chk=0;
									 if(parseInt(chk)==1)
									 {
										 document.getElementById("errormsg").innerText="";
										 document.getElementById("frmNipurchase").submit();
									 }
									 else
									 {
										 document.getElementById("errormsg").innerText="";
										 document.getElementById("frmNipurchase").submit();
									 }
								 }
							 }
							 x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
							 x.send();	
						} 
	
			/* function funchkinv()
			{
			var x =new XMLHttpRequest();
			
			x.onreadystatechange=function()
			{
			if(x.readyState==4 && x.status==200)	
			
			{
				var items=x.responseText;
				
				
				
				var chk=items.trim();
				
				
			 
				
			if(parseInt(chk)==1)
				{
				
				document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
				document.getElementById("invno").focus();
				
				return 0;
				
				}
			else
				{
				 document.getElementById("errormsg").innerText="";
				 
				 
				 
				 return 1;
				}
				
				
			
			}
			}
			
			x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
	
			x.send();
			
			}
 */			
			function funChkButton() {
				
				//frmEnquiry.submit();
			}
	
			function funSearchLoad(){
				 changeContent('nipurchaseMastersearch.jsp'); 
			}
	
				function funReset(){
					//$('#frmNipurchase')[0].reset(); 
				}
				function funReadOnly(){
					$('#frmNipurchase input').attr('readonly', true );
					$('#frmNipurchase select').attr('disabled', true );
					$('#nipurchasedate').jqxDateTimeInput({ disabled: true});
					$('#deliverydate').jqxDateTimeInput({ disabled: true});
					$('#invDate').jqxDateTimeInput({ disabled: true});
					$('#interstate').attr('disabled', true);
					$('#cmbcurr').attr('disabled', true);
					$('#acctype').attr('disabled', true);
					$('#refslno').attr('disabled', true);
			        $("#nidescdetailsGrid").jqxGrid({ disabled: true});
					combochange();
					funinterstate();
				}
				   
				function funRemoveReadOnly(){         
					funinterstate();
					fungetterms();
					getNonTaxableEntity();
					$('#frmNipurchase input').attr('readonly', false );
					$('#frmNipurchase select').attr('disabled', false );
					$('#nipurchasedate').jqxDateTimeInput({ disabled: false});
					$('#deliverydate').jqxDateTimeInput({ disabled: false});
					$('#invDate').jqxDateTimeInput({ disabled: false});
					$('#interstate').attr('disabled', false);
					$('#cmbcurr').attr('disabled', false);
					$('#cmbcurr').attr('readonly', true);
					$('#acctype').attr('disabled', false);;
					$('#docno').attr('readonly', true);
					$('#currate').attr('readonly', true);
					$('#nipuraccid').attr('readonly', true);
					$('#puraccname').attr('readonly', true);
					$('#refslno').attr('disabled', true);
			        $('#refslno').attr('readonly', true);
				    $("#nidescdetailsGrid").jqxGrid({ disabled: false});
				    //getCurrencyIds($("#nipurchasedate").val());
						
					if ($("#mode").val() == "A") {  
						$('#nipurchasedate').val(new Date());
					    $('#deliverydate').val(new Date());
						getCurrencyIds($("#nipurchasedate").val());
					    $("#nidescdetailsGrid").jqxGrid('clear');
					    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
					}
					if ($("#mode").val() == "E") {
						if(document.getElementById("interstate").checked==true){
					    document.getElementById("interstate").value='1';
					}
					else{
						document.getElementById("interstate").value='0';
					}
					if ($('#reftypeval').val()=="NPO"){    
					    $('#refno').attr('disabled', false);
					    $('#refslno').attr('disabled', false);
					    $('#refno').attr('readonly', true);
					    $('#refslno').attr('readonly', true);
					}        
							
				  }
				}
					        
			function getCurrencyIds(a){  
					        	   var x=new XMLHttpRequest();
					        	   x.onreadystatechange=function(){
					        	   if (x.readyState==4 && x.status==200)
					        	    {
					        	      items= x.responseText;
					        	      items=items.split('####');
					        	           var curidItems=items[0];
					        	           var curcodeItems=items[1];
					        	           var currateItems=items[2];
					        	           var multiItems=items[3];
					        	           var optionscurr = '';
					        	           
					        	        if(curcodeItems.indexOf(",")>=0){
					        	            var currencyid=curidItems.split(",");
					        	            var currencycode=curcodeItems.split(",");
					        	            multiItems.split(",");
					        	          
					        	          for ( var i = 0; i < currencycode.length; i++) {
					        	           optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
					        	           }
					        	         
					        	            $("select#cmbcurr").html(optionscurr);
					        	            
					        	            if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
					        	             $('#cmbcurr').val($('#hidcmbcurr').val()) ;
					        	            } 
					        	        	
								        	if(document.getElementById("masterdoc_no").value=="")  
								        		{
								        		 
								        	
					        	            funRoundRate(currateItems,"currate");
								        		}
									         $('#currate').attr('readonly', true);
					        	          
					        	       }
					        	   
					        	          else{
					        	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
					        	           
					        	          $("select#cmbcurr").html(optionscurr);
					        	           
					        	             if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
					        	              $('#cmbcurr').val($('#hidcmbcurr').val()) ;
					        	             } 
					        	         	if(document.getElementById("masterdoc_no").value=="")
							        		{
							        		  
					        	          funRoundRate(currateItems,"currate");
							        		}
									        
								          $('#currate').attr('readonly', true);
								          
					        	          }
					        	    }
					        	       }
					        	        x.open("GET", "getCurrencyId.jsp?date="+a,true);
					        	       x.send();
					        	      
					        	     }				        
					   function getRatevalue(angel)
					   {
					    	
				        	if(document.getElementById("masterdoc_no").value>0)
				        		{
				        		return 0;
				        		}
				        	 
					   var x=new XMLHttpRequest();
					   x.onreadystatechange=function(){
					   if (x.readyState==4 && x.status==200)
					    {
					      var items= x.responseText;
					   /*       $('#currate').val(items) ; */
					         
					         funRoundRate(items,"currate");  
					         
					        }
					          else
					      {
					      }
					       }
					   x.open("GET","getRateTo.jsp?curr="+a,true);
						x.send();
					        
					      
					        }
					   function funrefdisslno()
					   {
						   
							 $("#nidescdetailsGrid").jqxGrid('clear');
							    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
							 
						   
						   if($('#nireftype').val()=="NPO") 
							  {
							   $('#refno').attr('disabled', false);
							   $('#refslno').attr('disabled', false);
							 
							 
							  } 
						   else
							   {
							   $('#refno').val(" ");
							   $('#refslno').val(" ");
							   $('#refno').attr('disabled', true);
							   $('#refslno').attr('disabled', true);
							   
							   }
					   }
					   function combochange()
					   {
						   if($('#cmbcurrval').val()!="")
							  {
							  
							  
							  $('#cmbcurr').val($('#cmbcurrval').val());
							  }
						   if($('#acctypeval').val()!="")
							  {
							  
							  
							  $('#acctype').val($('#acctypeval').val());
							  }
						   if($('#reftypeval').val()!="")
							  {
							  
							  
							  $('#nireftype').val($('#reftypeval').val());
							  
							  if($('#reftypeval').val()=="NPO")
								  {
								
								  $('#refno').attr('disabled', false);
								   $('#refslno').attr('disabled', false);
							  $('#refno').attr('readonly', true);
							   $('#refslno').attr('readonly', true);
								  }
							  }
						   
						   
					   }
					   function fungetterms()
						{
							
						   var x=new XMLHttpRequest();
							x.onreadystatechange=function(){
								if (x.readyState==4 && x.status==200)
									{
							       var items= x.responseText.trim();
							       //alert("items"+items);
							       if(parseInt(items)>0){
							    	   
							    	   
							    	   $('#termsval').val(1);
							    		 
							       }
									else{
										 
										  $('#termsval').val(0);
											 
									}
									}
								else{
									
								}
								}
						x.open("GET","terms.jsp?",true);
	
						x.send();
								
						}
					   
					   
					   
					   function funinterstate()
						{
							
						   var x=new XMLHttpRequest();
							x.onreadystatechange=function(){
								if (x.readyState==4 && x.status==200)
									{
							       var items= x.responseText.trim();
							       //alert("items"+items);
							       if(parseInt(items)>0){
							    	   $('#interdiv').hide();
										// $('#interstate').attr('disabled', false);
										
							       }
									else{
										$('#interdiv').hide();
										
									}
									}
								else{
									
								}
								}
						x.open("GET","interstate.jsp?",true);
	
						x.send();
								
						}
					   
					   function funbnkdetls()
						{
							
						   var x=new XMLHttpRequest();
							x.onreadystatechange=function(){
								if (x.readyState==4 && x.status==200)
									{
							       var items= x.responseText.trim();
							       //alert("items"+items);
							       if(parseInt(items)>0){
							    	   document.getElementById("hidbnk").value=1;
										
							       }
									else{
										 document.getElementById("hidbnk").value=0;
										
									}
									}
								else{
									
								}
								}
						x.open("GET","shwbnkdetls.jsp?",true);
	
						x.send();
								
						}
					   function setValues() {
						  /*  if(document.getElementById("interstate").checked=true){
							   $('#interstate').val()=='1';
						   }
						   else{
							   $('#interstate').val()=='0';
						   } */
						   funinterstate();
						 
						   $('#nipurchasedate').jqxDateTimeInput({disabled: false});
						    var date = $('#nipurchasedate').val();
						    getCurrencyIds(date);  
						    $('#nipurchasedate').jqxDateTimeInput({disabled: true});
						   
						   if($('#hidnipurchasedate').val()){
								$("#nipurchasedate").jqxDateTimeInput('val', $('#hidnipurchasedate').val());
							}
							
							if($('#hiddeliverydate').val()){
								$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
							}
							
							
							
							
							if($('#hidinvDate').val()){
								
								$("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
							}
	                       var interstate=document.getElementById("hidinterstate").value;
							
							if(interstate>0){
								document.getElementById("interstate").checked=true;
							}
							else{
								document.getElementById("interstate").checked=false;
							}
							
							
						 	var dis=document.getElementById("masterdoc_no").value;
							if(dis>0)
								{     
								funchkforedit();
						 	 var indexval1 = document.getElementById("masterdoc_no").value;   
								
					     	  		 
					     	  	
					     	  		 $("#nipurdetails").load("descgridDetails.jsp?nipurdoc="+indexval1);
					     	  		
								 } 
				
							 if($('#msg').val()!=""){
								   $.messager.alert('Message',$('#msg').val());
								  } 
							 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
							       combochange();
						}
					   $(function(){
					        $('#frmNipurchase').validate({
					                rules: { 
					              
					               	delterms:{maxlength:200},
					                	purdesc:{maxlength:200},
					                	payterms:{maxlength:200}
					                   
					                 },
					                 messages: {
					                	 delterms: {maxlength:"  Max 200 chars"},
					                	 purdesc: {maxlength:"  Max 200 chars"},
					                	 payterms: {maxlength:"  Max 200 chars"}
					                	
					                 }
					        });});
					   /*function diserror(){
						   document.getElementById("errormsg").innerText="";
					   } */
	function funPrintBtn(){
	   var dtype=$('#formdetailcode').val();
		var brhid=$("#brchName").val();
		
		var bnk=$("#hidbnk").val();
		//alert("===bnk===="+bnk);
		var url=document.URL;
		var reurl;
		if ($("#masterdoc_no").val()==""){
			$.messager.alert('Message','Select a Document....!','warning');
			return false;
		}
		if( url.indexOf('savesrvsale') >= 0){
			reurl=url.split("savesrvsale");
		}else {
			reurl=url.split("serviceSale.jsp");
		}
		if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="" && $("#hidbnk").val()==1) {
			PrintContent('printVoucherWindow.jsp');
			win.focus();
		} 
		else {
			var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header=1&bankdocno=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			win.focus();
			
		}
	}
   function PrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
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
					   		   
	</script>
	</head>
	<body onload="setValues();funinterstate();funbnkdetls();" >
	
	
	<div id="mainBG" class="homeContent" data-type="background">
	<form id="frmNipurchase" action="savesrvsale" method="post" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<fieldset>  
	<table width="100%">
	  <tr>
	    <td width="4%" align="right">Date</td> 
	    <td width="4%" align="left">
	    	<div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
	    	<input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
	    </td>
		<td align="right" width="5%" >&nbsp;</td>
	    <td align="left" width="10%" >&nbsp;</td>
	    <td align="right" width="10%" >Ref No</td>   
	    <td align="left" width="15%" > &nbsp;
	    	<input type="text" name="refno" id="refno" style="width:80%;" value='<s:property value="refno"/>' > 
	   	</td>
	    <td width="10%" align="left">  
	    	<input type="hidden" name="refslno" id="refslno"  value='<s:property value="refslno"/>' > 
	   	</td>
	    <td width="8%" align="left"> &nbsp;</td>
	    <td width="10%">&nbsp;</td>
	  	<td width="20%" align="left" colspan="2"> &nbsp;</td> 
	     
	    <td width="13%" align="right">Doc No</td>      
	    <td width="13%"><input type="text" name="docno" id="docno" tabindex="-1" style="width:100%;" value='<s:property value="docno"/>' readonly="readonly"></td>
	  </tr>
	 
	  <tr>
	   <td width="3.1%" align="right" id="typetd1" hidden="hidden">Type</td>
	    <td width="4%" align="left" id="typetd2" hidden="hidden">
	    	<select name="cmbtype" id="cmbtype" style="width:68%;"  value='<s:property value="cmbtype"/>'>
	    	<option value="AR" >AR</option>
	    	<option value="AP" >AP</option>
	    	<option value="GL" >GL</option>
	    	</select>
	    </td> 
	    
	    <td width="3.1%" align="right">Client</td>
	    <td colspan="5" width="13%" align="left"> 
	      <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
	 
	    <input type="text" name="nipuraccid" id="nipuraccid" value='<s:property value="nipuraccid"/>' placeholder="Press F3 To Search"  style="width:20%;" onKeyDown="getaccountdetails(event);" >  
	      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:75.5%;"></td>
	     
	    <td align="right" width="1.6%">Curr</td>        
	    <td width="6%" align="left"><select name="cmbcurr" id="cmbcurr" style="width:100%;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
	      <option value="-1" >--Select--</option>
	    </select>  <input type="hidden" id="hidcmbcurr" name="hidcmbcurr"  value='<s:property value="hidcmbcurr"/>'/>    </td>   
	
	    <td width="8%" align="right">Rate &nbsp; <input type="text" style="width:50%;"   name="currate" id="currate"  value='<s:property value="currate"/>'></td>
	 
	    <td  align="right" width="4%"> PO NO</td>
	    <td  align="left" width="1%"> <input type="text" id="invno" name="invno"  value='<s:property value="invno"/>'></td>
	<td  align="right" width="10%"> PO Date</td>
	<td  align="left" width="14%"> <div id="invDate" name="invDate"  value='<s:property value="invDate"/>'></div>
	<input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
	
	<!--  <td width="3.1%" align="right">  &nbsp;</td> <td width="3.1%" align="right">  &nbsp;</td> -->
	<!--  <td width="13%">&nbsp;</td> -->
	  </tr>
	 
	  <tr>
	 
	    <td align="right" width="4%" >Del Date</td>
	    <td align="left" width="6%" ><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
	    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'></td>
	 <td>&nbsp;<div id="interdiv" hidden="true"><input type="checkbox" name="interstate" id="interstate" value="interstate"  value='<s:property value="interstate"/>' onclick="$(this).attr('value', this.checked ? 1 : 0);" >Interstate</div></td>
	    <td align="right" width="5%" >Del Terms</td>
	    <td colspan="8" align="left" width="73%" ><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:90%;"></td>
	 
	     
	  </tr> 
	  <tr>
	  <td align="right"  width="4.7%">Pay Terms</td>
	    <td colspan="10"  width="94%" align="left"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:99.4%;"></td>
	    </tr>
	    <tr>
	    <td align="right"  width="4.7%">Description</td>
	    <td colspan="10"  width="94%" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:99.4%;"></td></tr>
	    
	</table>
	
	    
	 
	 </fieldset>
	 <br>
	 <fieldset>
	 
	    <div id="nipurdetails" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>
	     
	
	</fieldset>
	<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
	
	<input type="hidden" id="termsval" name="termsval"  value='<s:property value="termsval"/>'/>
	 
	
	<input type="hidden" id="ordermasterdoc_no" name="ordermasterdoc_no"  value='<s:property value="ordermasterdoc_no"/>'/>
	     <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
	     <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
	     <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
	     <input type="hidden" id="rowval" name="rowval"  value='<s:property value="rowval"/>'/>   <!-- for refno  slno set grid -->
	     <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>  
	     <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
	     <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
	     <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
	     <input type="hidden" id="reftypeval" name="reftypeval"  value='<s:property value="reftypeval"/>'/>  
	         
	     <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
	     <input type="hidden" id="acctypegrid" name="acctypegrid"  value='<s:property value="acctypegrid"/>'/>
	     <input type="hidden" id="nidescdetailslenght" name="nidescdetailslenght"  value='<s:property value="nidescdetailslenght"/>'/>  
	     <input type="hidden" id="costgropename" name="costgropename"  value='<s:property value="costgropename"/>'/>
	     <input type="hidden" id="tarannumber" name="tarannumber"  value='<s:property value="tarannumber"/>'/>
	     <input type="hidden" id="hidinterstate" name="hidinterstate"  value='<s:property value="hidinterstate"/>'/>
	     <input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity"  value='<s:property value="txtnontaxableentity"/>'/>
	     <input type="hidden" id="taxpers" name="taxpers"  value='<s:property value="taxpers"/>'/>
	     <input type="hidden" id="taxperc" name="taxperc"  value='<s:property value="taxperc"/>'/>
	     <input type="hidden" id="hidbnk" name="hidbnk"  value='<s:property value="hidbnk"/>'/>
	          
	</form>
	  <div id="accountSearchwindow">
		   <div></div>
		</div>
		 <div id="accounttypeSearchwindow">
		   <div></div>
		</div>
		<div id="costtpesearchwndow">
		   <div></div>
		</div>
		 <div id="costcodesearchwndow">
		   <div></div>
		</div> 
			 <div id="refnosearchwindow">
		   <div></div>
		</div> 
			 <div id="nipurchslnosearch">
		   <div></div>
		</div> 
		<div id="printWindow"><div></div></div>
	</div>
	</body>
	</html>