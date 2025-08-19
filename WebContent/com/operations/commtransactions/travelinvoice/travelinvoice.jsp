<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
 $(document).ready(function () {  
	 $('#btnApproval').hide();               
	 $('#btnCreate').attr('disabled', true);      
	 $('#btnEdit').attr('disabled', true);
	// $('#btnDelete').attr('disabled', true);
	 $('#ticketshow').hide();
	 $('#hotelshow').hide();
	 $('#tourshow').show();     
   	 $("#travelDate").jqxDateTimeInput({ width: '100px', height: '15px', formatString:"dd.MM.yyyy"});    
     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientsearch1').jqxWindow('close');
     $('#cmbclient').dblclick(function(){
	  	   $('#clientsearch1').jqxWindow('open');
	       clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
       });
	});
  function funReadOnly(){
		$('#frmTravelInvoice input').prop('readonly', true );
		$('#frmTravelInvoice textarea').attr('readonly', true );
		$('#frmTravelInvoice select').attr('disabled', true);
		$('#travelDate').jqxDateTimeInput({ disabled: true});
	    $("#tourGrid").jqxGrid({ disabled: true});
	    $("#jqxJournalVoucher").jqxGrid({ disabled: true});
	}
  function funRemoveReadOnly(){    
		$('#frmTravelInvoice input').attr('readonly', false );
		$('#frmTravelInvoice textarea').attr('readonly', false );
		$('#frmTravelInvoice select').attr('disabled', false);
		$('#travelDate').jqxDateTimeInput({ disabled: false});
		$("#tourGrid").jqxGrid({ disabled: false}); 
		$("#jqxJournalVoucher").jqxGrid({ disabled: false});  
		$('#docno').attr('readonly', true);
		$('#txtclientname').attr('readonly', true);
		$('#cmbclient').attr('readonly', true);      
		if ($("#mode").val() == "A") {
			 $('#travelDate').val(new Date());
		     $("#tourGrid").jqxGrid('clear');
		     $("#tourGrid").jqxGrid('addrow', null, {});
		     $("#jqxJournalVoucher").jqxGrid('clear');
		     $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
		   }
	}
	 function getclinfo(event){
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#clientsearch1').jqxWindow('open');
    	  clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    
    	 }
	 } 	 
     function clientSearchContent(url) {
	                 $.get(url).done(function (data) {
		           $('#clientsearch1').jqxWindow('setContent', data);
          	}); 
	  } 
	function funNotify(){	
		$('#travelDate').jqxDateTimeInput({ disabled: false});
		var valid2=document.getElementById("txtclientname").value;
		if(valid2=="")
			{
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
			} 
		 else{
			 document.getElementById("errormsg").innerText="";
		 }
		/*  var rows = $("#tourGrid").jqxGrid('getrows');    
		 $('#tourgridlenght').val(rows.length);
		   for(var i=0 ; i < rows.length ; i++){
		
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].renttype+" :: "+rows[i].hidfromdate+" :: "+rows[i].hidtodate+" :: "+rows[i].unit+" :: ");
		   newTextBox.appendTo('form');  
		   }  */  
		return 1;
	} 
  function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	}
  function setValues(){ 
          if($('#docno').val()=="0"){
              $('#docno').val('');
          }   
		  document.getElementById("formdetail").value="Travel Invoice";
	   	  document.getElementById("formdetailcode").value="TINV";    
		  if($('#hidtravelDate').val()){
			$("#travelDate").jqxDateTimeInput('val', $('#hidtravelDate').val());       
		  }
		  if($('#hidreftype').val()!=""){  
				$("#cmbreftype").val($('#hidreftype').val());       
		  }
		  if($('#hidtype').val()!=""){     
				$("#txttype").val($('#hidtype').val());          
		  }
  	     var docVal1 = document.getElementById("masterdoc_no").value;
      	 if(docVal1>0){
			 var indexVal2 = document.getElementById("masterdoc_no").value;
			 var serdocno = document.getElementById("serdocno").value;   
	         if($('#txttype').val()=="tour"){
	             $('#ticketshow').hide();
				 $('#hotelshow').hide();
				 $('#tourshow').show();
				 $("#tourdiv").load("tourDetails.jsp?rdocno="+serdocno+"&check="+1);    
	           }else if($('#txttype').val()=="ticket"){
	             $('#ticketshow').show();
				 $('#hotelshow').hide();
				 $('#tourshow').hide();
				 $("#ticketdiv").load("ticketGrid.jsp?rdocno="+serdocno+"&id="+1);  
	           }else if($('#txttype').val()=="hotel"){   
	             $('#ticketshow').hide();
				 $('#hotelshow').show();      
				 $('#tourshow').hide();
				 $("#hoteldiv").load("hotelGrid.jsp?rdocno="+serdocno+"&id="+1);     
	           }else{  
	            
	           }
	         $("#accdiv").load("accountingDetails.jsp?docNo="+indexVal2+"&check="+1);     
      		}
      	 if($('#msg').val()!=""){
 		   	$.messager.alert('Message',$('#msg').val());
 		    }
      	    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
	  }
  function funReset(){
		//$('#frmTravelInvoice')[0].reset(); 
	}
  function funChkButton() {  
		//frmTravelInvoice.submit();
	}
	function funFocus(){
	$('#travelDate').jqxDateTimeInput('focus'); 
	}   
	
	 function funPrintBtn() {
		if (($("#mode").val() == "view") && $("#docno").val()!="") {           
			 var url=document.URL;  
	         var reurl=url.split("travelinvoice.jsp");      
	         var win= window.open(reurl[0]+"printtravelinvoice?docno="+$('#masterdoc_no').val()+"&branch="+document.getElementById("brchName").value+"&type="+document.getElementById("txttype").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	         win.focus();
		}else{
				$.messager.alert('Message','Select a Document....!','warning');     
				return;
			}  
	 }  
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">        
<form id="frmTravelInvoice" action="saveTravelInvoice" autocomplete="OFF" >

<jsp:include page="../../../../header.jsp"></jsp:include><br/>  

<fieldset>  
<table width="100%">                        
  <tr>
    <td width="11%" align="right">Date</td>                                                      
    <td width="20%"><div id='travelDate' name='travelDate' value='<s:property value="travelDate"/>'></div>
                     <input type="hidden" id="hidtravelDate" name="hidtravelDate" value='<s:property value="hidtravelDate"/>'/></td>
     <td align="right" width="4%">Ref Type</td>      
     <td width="20%"><select id="cmbreftype" name="cmbreftype" style="width: 50%;"  value='<s:property value="cmbreftype"/>'>
            <!-- <option value="">--Select--</option>    -->
            <option value="SER">Service Request</option>
            <option value="VOC">Voucher</option></select>     
            <input type="hidden" id="hidreftype" name="hidreftype" tabindex="-1" value='<s:property value="hidreftype"/>' /></td>  
    <td width="4%" align="right">Ref No</td>  
    <td  width="20%"><input type="text" id="refno" name="refno" style="width: 50%;"  value='<s:property value="refno"/>' /></td>
    <td width="33%">Doc No&nbsp;<input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' /></td>
  </tr>  
  <tr>
    <td align="right">Client</td>       
    <td colspan="3"><input type="text" id="cmbclient" name="cmbclient" style="width: 20%;" placeholder="Press F3 To Search" value='<s:property value="cmbclient"/>' onKeyDown="getclinfo(event);" >
  		<input type="text" id="txtclientname" name="txtclientname" style="width: 60%;" value='<s:property value="txtclientname"/>' ></td>
     <td align="right" width="4%">Type</td>       
     <td width="20%"><select id="txttype" name="txttype" style="width: 51%;"  value='<s:property value="txttype"/>'>
           <!--  <option value="">--Select--</option>    -->  
            <option value="tour">Tour</option>
            <option value="ticket">Ticket</option>
            <option value="hotel">H/V/O</option></select>               
 <input type="hidden" id="hidtype" name="hidtype" tabindex="-1" value='<s:property value="hidtype"/>' /></td>                         
  </tr>
  <tr>
    <td align="right" width="10.8%">Remarks</td>           
    <td colspan="5"><input type="text" id="txtremarks" name="txtremarks" style="width:85.7%;" value='<s:property value="txtremarks"/>'></td>
  </tr>  
 </table>   
</fieldset>                             
<br/>
<div id="tourshow">  
	<fieldset>
		<legend>Tour Details</legend>      
		<div id="tourdiv"><jsp:include page="tourDetails.jsp"></jsp:include></div>
	</fieldset>  
</div>
<div id="ticketshow">
	<fieldset>
		<legend>Ticket Details</legend>   
		<div id="ticketdiv"><jsp:include page="ticketGrid.jsp"></jsp:include></div>   
	</fieldset>  
</div>
<div id="hotelshow">
	<fieldset>
		<legend>Hotel Details</legend>   
		<div id="hoteldiv"><jsp:include page="hotelGrid.jsp"></jsp:include></div>        
	</fieldset>  
</div>
<fieldset>
<legend>Accounting Details</legend>    
<div id="accdiv"><jsp:include page="accountingDetails.jsp"></jsp:include></div>     
</fieldset>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />    
<input type="hidden" id="serdocno" name="serdocno" value='<s:property value="serdocno"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="tourgridlenght" name="tourgridlenght" />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
<div id="clientsearch1">    
   <div ></div>
</div>
</div>
</body>
</html>