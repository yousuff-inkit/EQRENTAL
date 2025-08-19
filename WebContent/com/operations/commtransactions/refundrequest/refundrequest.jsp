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
	 //$('#btnCreate').attr('disabled', true);      
	 $('#btnEdit').attr('disabled', true);
	 $('#btnDelete').attr('disabled', true);
	 $('#ticketshow').hide();
	 $('#hotelshow').hide();
	 $('#tourshow').show();     
   	 $("#travelDate").jqxDateTimeInput({ width: '100px', height: '15px', formatString:"dd.MM.yyyy"});    
     $('#refnosearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Refno Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#refnosearch').jqxWindow('close');
     $('#refno').dblclick(function(){
	  	   $('#refnosearch').jqxWindow('open');
	       refnoSearchContent('refnoMainSearch.jsp?', $('#refnosearch'));   
       });
	});
  function funReadOnly(){     
		$('#frmrefundrequest input').prop('readonly', true );
		$('#frmrefundrequest textarea').attr('readonly', true );
		$('#frmrefundrequest select').attr('disabled', true);
		$('#travelDate').jqxDateTimeInput({ disabled: true});
		if($('#cmbreftype').val()=="T"){ 
			  $("#tourGrid").jqxGrid({ disabled: true});
		}else if($('#cmbreftype').val()=="A"){
			  $("#jqxTicketGrid").jqxGrid({ disabled: true});
		}else if($('#cmbreftype').val()=="V"){     
			  $("#jqxHotelGrid").jqxGrid({ disabled: true});      
		}
	}
  function funRemoveReadOnly(){  
		$('#frmrefundrequest input').attr('readonly', false );
		$('#frmrefundrequest textarea').attr('readonly', false );       
		$('#frmrefundrequest select').attr('disabled', false);     
		$('#travelDate').jqxDateTimeInput({ disabled: false});
		if($('#cmbreftype').val()=="T"){ 
			 $("#tourGrid").jqxGrid({ disabled: false}); 
		}else if($('#cmbreftype').val()=="A"){
			 $("#jqxTicketGrid").jqxGrid({ disabled: false});
		}else if($('#cmbreftype').val()=="V"){     
			 $("#jqxHotelGrid").jqxGrid({ disabled: false});          
		}
		$('#refno').attr('readonly', true);
		$('#docno').attr('readonly', true);
		$('#txtclientname').attr('readonly', true);
		if ($("#mode").val() == "A") {
			 $('#travelDate').val(new Date());
			 $("#tourGrid").jqxGrid('clear');
			 $("#jqxTicketGrid").jqxGrid('clear');
			 $("#jqxHotelGrid").jqxGrid('clear'); 
             gridchange();  
		   }
	}
	 function getclinfo(event){   
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#refnosearch').jqxWindow('open');   
    	  refnoSearchContent('refnoMainSearch.jsp?', $('#refnosearch'));    
    	 }
	 } 	 
     function refnoSearchContent(url) {   
	               $.get(url).done(function (data) {
		           $('#refnosearch').jqxWindow('setContent', data);
          	}); 
	  } 
	function funNotify(){	
		 $('#travelDate').jqxDateTimeInput({ disabled: false});  
		 var tourlength=0,ticketlenth=0,hotellength=0;
		 var j=0,k=0,l=0,id=0; 
		 
		 if($('#cmbreftype').val()=="T"){            
		     var rows1 = $("#tourGrid").jqxGrid('getrows');    
			 for(var i=0 ; i < rows1.length ; i++){
			       var chk=rows1[i].chk;
			       if(chk){          
					   newTextBox = $(document.createElement("input"))  
					       .attr("type", "dil")
					       .attr("id", "tour"+j)
					       .attr("name", "tour"+j)   
					       .attr("hidden", "true"); 
					   newTextBox.val(rows1[i].rowno+"::"+rows1[i].adultnew+" :: "+rows1[i].childnew+" :: "+rows1[i].totalnew+" :: ");    
					   newTextBox.appendTo('form');  
					   tourlength=tourlength+1;
					   j++;
					   id++;
				   }           
			   }
			 $('#tourgridlenght').val(tourlength);  
		 }
		 if($('#cmbreftype').val()=="A"){
			 var rows2 = $("#jqxTicketGrid").jqxGrid('getrows');    
			 for(var i=0 ; i < rows2.length ; i++){ 
			       var chk=rows2[i].chk;
			       if(chk){   
					   newTextBox = $(document.createElement("input"))
					       .attr("type", "dil")
					       .attr("id", "ticket"+k)
					       .attr("name", "ticket"+k)   
					       .attr("hidden", "true"); 
					   newTextBox.val(rows2[i].rowno+" :: ");    
					   newTextBox.appendTo('form');    
					   ticketlenth=ticketlenth+1; 
					   k++;
					   id++;
				   }          
			   }
			 $('#ticketgridlenght').val(ticketlenth); 
		 }
		 
		 if($('#cmbreftype').val()=="V"){   
			 var rows3 = $("#jqxHotelGrid").jqxGrid('getrows');           
			 for(var i=0 ; i < rows3.length ; i++){
			       var chk=rows3[i].chk;
			       if(chk){    
					   newTextBox = $(document.createElement("input"))
					       .attr("type", "dil")
					       .attr("id", "hotel"+l)
					       .attr("name", "hotel"+l)   
					       .attr("hidden", "true"); 
					   newTextBox.val(rows3[i].rowno+" :: ");    
					   newTextBox.appendTo('form');  
					   hotellength=hotellength+1; 
					   l++; 
					   id++;    
				   }           
			   }
			 $('#hotelgridlenght').val(hotellength);
		 }
		 if(id==0){
		        $.messager.alert('Message',' Please select a document.. ');
		        return 0;    
		 }               
		 return 1;     
	} 
  function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	}
  function setValues(){  
		  document.getElementById("formdetail").value="Refund Request";
	   	  document.getElementById("formdetailcode").value="RFR";    
		  if($('#hidtravelDate').val()){
			$("#travelDate").jqxDateTimeInput('val', $('#hidtravelDate').val());       
		  }
		  if($('#hidreftype').val()!=""){  
				$("#cmbreftype").val($('#hidreftype').val());       
		  }
  	     var docVal1 = document.getElementById("masterdoc_no").value;
      	 if(docVal1>0){  
			    var serdocno = document.getElementById("refdocno").value;      
			    $('#jqxTicketGrid').jqxGrid('clear');
			    $('#jqxHotelGrid').jqxGrid('clear');  
			    $('#tourGrid').jqxGrid('clear'); 
			 if($('#cmbreftype').val()=="T"){     
			             $('#ticketshow').hide();
						 $('#hotelshow').hide();
						 $('#tourshow').show();
						 $("#tourdiv").load("tourDetails.jsp?rdocno="+serdocno+"&check="+1+"&refund="+1+"&rrdocno="+docVal1);
			    }else if($('#cmbreftype').val()=="A"){
			    		 $('#ticketshow').show(); 
						 $('#hotelshow').hide();
						 $('#tourshow').hide();
						 $("#ticketdiv").load("ticketGrid.jsp?rdocno="+serdocno+"&id="+1+"&refund="+1+"&rrdocno="+docVal1);
			    }else if($('#cmbreftype').val()=="V"){     
			             $('#ticketshow').hide();
						 $('#hotelshow').show();      
						 $('#tourshow').hide();
						 $("#hoteldiv").load("hotelGrid.jsp?rdocno="+serdocno+"&id="+1+"&refund="+1+"&rrdocno="+docVal1);           
			    }else{}     
      		}
      	 if($('#msg').val()!=""){  
 		   	$.messager.alert('Message',$('#msg').val());
 		    }
      	    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
	  }
    function funReset(){
		//$('#frmrefundrequest')[0].reset();     
	}
    function funChkButton() {  
		//frmrefundrequest.submit();
	}
	function funFocus(){
	  $('#travelDate').jqxDateTimeInput('focus'); 
	}  
	
	function gridchange(){
	    $('#refno').val('');
	    $('#refdocno').val('');
	    $('#txtclientname').val('');
	    $('#txtremarks').val('');
	    $('#jqxTicketGrid').jqxGrid('clear');
	    $('#jqxHotelGrid').jqxGrid('clear');  
	    $('#tourGrid').jqxGrid('clear'); 
	    if($('#cmbreftype').val()=="T"){
	             $('#ticketshow').hide();
				 $('#hotelshow').hide();
				 $('#tourshow').show();
	    }else if($('#cmbreftype').val()=="A"){
	    		 $('#ticketshow').show(); 
				 $('#hotelshow').hide();
				 $('#tourshow').hide();
	    }else if($('#cmbreftype').val()=="V"){  
	             $('#ticketshow').hide();
				 $('#hotelshow').show();      
				 $('#tourshow').hide();
	    }else{}
	} 
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">        
<form id="frmrefundrequest" action="saveRefundRequest" autocomplete="OFF" >                     
<jsp:include page="../../../../header.jsp"></jsp:include><br/>    
<fieldset>  
<table width="100%">                                   
  <tr>
    <td width="5%" align="right">Date</td>                                                                          
    <td width="30%"><div id='travelDate' name='travelDate' value='<s:property value="travelDate"/>'></div>
                     <input type="hidden" id="hidtravelDate" name="hidtravelDate" value='<s:property value="hidtravelDate"/>'/></td>  
    <td align="right" width="4%">Ref Type</td>      
    <td width="15%"><select id="cmbreftype" name="cmbreftype" style="width:75%;" onchange="gridchange();" value='<s:property value="cmbreftype"/>'>  
            <option value="T">Travel Desk</option>     
            <option value="A">Air Ticket</option>
            <option value="V">Voucher</option></select>       
            <input type="hidden" id="hidreftype" name="hidreftype" tabindex="-1" value='<s:property value="hidreftype"/>' /></td>         
    <td width="5%" align="right">Ref No</td>                    
    <td  width="20%"><input type="text" id="refno" name="refno" readonly style="width: 50%;"   placeholder="Press F3 To Search" value='<s:property value="refno"/>'  onKeyDown="getclinfo(event);" />
                     <input type="hidden" id="refdocno" name="refdocno" value='<s:property value="refdocno"/>'/></td>                    
    <td width="33%" align="right">Doc No&nbsp;<input type="text" id="docno" name="docno" readonly tabindex="-1" value='<s:property value="docno"/>' /></td>
  </tr>    
  <tr>
    <td width="5%" align="right">Client</td>         
  		 <td colspan="3"><input type="text" id="txtclientname" name="txtclientname" readonly style="width: 91.9%;" value='<s:property value="txtclientname"/>' ></td>                   
    <td align="right" width="5%">Remarks</td>           
    <td colspan="5"><input type="text" id="txtremarks" name="txtremarks" style="width:99%;" value='<s:property value="txtremarks"/>'></td>               
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
  
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />    
<input type="hidden" id="serdocno" name="serdocno" value='<s:property value="serdocno"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="tourgridlenght" name="tourgridlenght" />
<input type="hidden" id="ticketgridlenght" name="ticketgridlenght" />
<input type="hidden" id="hotelgridlenght" name="hotelgridlenght" />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
<div id="refnosearch">    
   <div ></div>
</div>
</div>
</body>
</html>