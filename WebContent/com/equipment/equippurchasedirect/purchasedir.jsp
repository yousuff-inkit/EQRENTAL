<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@page import="java.util.*" %>
 <%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.equipment.equippurchasedirect.ClsEquipPurchaseDirectDAO" %>
 <% 
 	String contextPath=request.getContextPath();
 ClsEquipPurchaseDirectDAO pdao=new ClsEquipPurchaseDirectDAO();
 	int method=pdao.getTaxMethod();
 %>
<!DOCTYPE html>
<html>
<%-- <% String contextPath=request.getContextPath();%> --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
.amtclass{ 
text-align:right;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		 // $("#imagedivv").hide(); 
		 var meth='<%=method%>'
		 if(meth==0){
			 document.getElementById("txttaxamount").style.display="none";
			 document.getElementById("lbltax").style.display="none";
		 }
		 $("#vehpurorderDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#vehpurinvDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
	     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#accountSearchwindow').jqxWindow('close');
		 $('#fleetwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' ,title: 'Fleet Search' , position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	     $('#fleetwindow').jqxWindow('close');
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	     $('#refnosearchwindow').jqxWindow('close');  		     
			  
		 $('#accid').dblclick(function(){
			      if($('#mode').val()!="view") {
				  	    $('#accountSearchwindow').jqxWindow('open');
				  	    accountSearchContent('accountsDetailsSearch.jsp?');
				   }
		  }); 
		  $('#refno').dblclick(function(){
		  	    $('#refnosearchwindow').jqxWindow('open');
		  	    refsearchContent('vehreqRefnoSearch.jsp?');   
	      });

		  $('#vehpurorderDate').on('change', function (event) {
	         var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	 if ($("#mode").val() != "view"  ) {   
	         	funDateInPeriod(maindate);
	    	 }
	      });  
	 //   $("#imagedivv").hide(); 
	});
	function getrefDetails(event){
	 	  var x= event.keyCode;
	 	  if(x==114){
		 	  $('#refnosearchwindow').jqxWindow('open');
		 	  refsearchContent('vehreqRefnoSearch.jsp?');    
	 	  }else{
	 	  }
     }  
	 function refsearchContent(url) {
	          $.get(url).done(function (data) {
	          $('#refnosearchwindow').jqxWindow('setContent', data);
		});	
	 }          
	 function commenSearchContent(url) {
				 	 //alert(url);
				 		 $.get(url).done(function (data) {
				 			 
				 			 $('#accountSearchwindow').jqxWindow('open');
				 		$('#accountSearchwindow').jqxWindow('setContent', data);
				 
				 	}); 
	   } 	
			 //   getfinacc(event)
			function  getfinacc(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 commenSearchContent('finaccountSearch.jsp?');
		          }
	 		   
	 	 else{
	 		 }
	 	 }     
			   
 
	function fleetSearchContent(url) {
	 	 //alert(url);
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#fleetwindow').jqxWindow('open');
	 		$('#fleetwindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 
	
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		   if($('#mode').val()!="view")
		          {
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 accountSearchContent('accountsDetailsSearch.jsp?'); 
		          }
	 		   }
	 	 else{
	 		 }
	 	 }  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
	
	 function funReadOnly(){
			$('#frmpurchasedir input').attr('readonly', true );
			$('#frmpurchasedir select').attr('disabled', true);
			$('#vehpurorderDate').jqxDateTimeInput({disabled: true});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: true});
			$('#epocmbcurr').attr('disabled', true);  
			$('#refno').attr('disabled', true);  
			//$("#vehpurchasedirgrid").jqxGrid({ disabled: true});
	 }
	 function funRemoveReadOnly(){
			$('#frmpurchasedir input').attr('readonly', false );
			$('#frmpurchasedir select').attr('disabled', false);
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$('#accid').attr('readonly', true);
			$('#refno').attr('disabled', true);
			$('#refno').attr('readonly', true);  
			$('#txttaxamount').attr('readonly', true);  
			$('#txtnetotal').attr('readonly', true);  
			if ($("#mode").val() == "A") {
				tax();
				$('#vehpurorderDate').val(new Date());
				$('#vehpurinvDate').val(new Date());
			    $("#vehpurchasedirgrid").jqxGrid('clear');
			    $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
			   }
			  $('#epocurrate').attr('readonly', true);
			  $('#epocmbcurr').attr('disabled', false);  
			
		  	if ($("#mode").val() == "E") {     
		  		tax();
			   if($('#reftype').val()=="EPO") {
				  $('#refno').attr('disabled', false);
			      $('#refno').attr('readonly', true);
			  }
			   $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
			}  
			
			if($('#mode').val()=='D') {
			$('#frmpurchasedir input').attr('readonly',false);  
			$('#frmpurchasedir select').attr('disabled',false); 
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
			funchkfordel(document.getElementById("masterdoc_no").value);	
			funReadOnly();
			exit();
	       }
			var date = $('#vehpurorderDate').val();  
			getEPOCurrencyId(date);
			
			//$("#vehpurchasedirgrid").jqxGrid({ disabled: false});
	 }
	 
	 
	 
	 function funchkfordel(masterdoc_no)
	 {


	 	var x = new XMLHttpRequest();
	 	x.onreadystatechange = function() {
	 		if (x.readyState == 4 && x.status == 200) {
	 			var items = x.responseText.trim();	
	 		//	alert(items);
	 			if(parseInt(items)>0)
	 				{
	 				$.messager.alert('Message',' Transaction Already Exists','warning');  
	             return 0;
	 	
	 				
	 				}
	 			else
	 				{
	 			
	 				
	 				$('#frmpurchasedir input').attr('readonly',false);  
	 				$('#frmpurchasedir select').attr('disabled',false); 
	 				$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
	 				$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
	 				$('#frmpurchasedir').submit(); 
	 				}
	 		  
	 			
	 			
	 			
	 		} else {
	 			
	 		}
	 	}
	 	x.open("GET", "deletechk.jsp?srno="+document.getElementById("masterdoc_no").value, true);
	 	x.send();
	 	
	 	}
	 	

 
	 
	 
	 
	 function funSearchLoad(){
		changeContent('mastersearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
	    }
	 function getTaxPer(date, accid){
		   
	     var x = new XMLHttpRequest();
	     x.onreadystatechange = function() {
	       if (x.readyState == 4 && x.status == 200) {
	        var items = x.responseText.trim();
	       	$('#txttaxpercentage').val(items);
	       }
   		 }
	      x.open("GET", "getTaxper.jsp?date="+date+"&accid="+accid, true);
	      x.send();
	  }
	 function tax(){
			var date=$('#vehpurorderDate').val();
			var accid=$('#accid').val();
			getTaxPer(date, accid);
		}
	

	 function getBill(){ 
			
			
			
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		     
		      items=items.split('####');
		           var pgid=items[0].split(",");
		           var pgcode=items[1].split(",");
		         
		       //alert(pgname);
		           var optionspg = '';
		         
		            for ( var i = 0; i < pgcode.length; i++) {
		            	
		            	optionspg += '<option value="' + pgid[i] + '">' + pgcode[i] + '</option>';
		           }
		            $("select#cmbbilltype").html(optionspg);
		            
		            if($('#hidcmbbilltype').val()!=""){
					  $('#cmbbilltype').val($('#hidcmbbilltype').val());   
					}
		     
		    }
		       }
		   x.open("GET","getBillType.jsp",true);
			x.send();
		        
		      
		        }
	   
	  function funNotify(){
		  
		  var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
			if( document.getElementById("reftype").value=="EPO") { 
		           var refno= document.getElementById('masterrefno').value; 
				 if(refno=="")
				 {
					 document.getElementById("errormsg").innerText=" Select Ref NO";	
					 document.getElementById('refno').focus();
					 return 0;
				 } else {
					 document.getElementById("errormsg").innerText="";
				 }
				}
	 
		//   fleet_no chaseno enginno prch_cost addicost price  brdid modid clrid
	 		
		var purid= document.getElementById("accid").value;

		if(purid=="")
			{
			 document.getElementById("errormsg").innerText=" Select An Account";
			 
			 document.getElementById("accid").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		
		
		var invno= document.getElementById("invno").value;

		if(invno=="")
			{
			 document.getElementById("errormsg").innerText=" Enter Invoice No";
			 
			 document.getElementById("invno").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		
		var cmbbilltype= $("#cmbbilltype").val();
		if(cmbbilltype=="")
		{
		 document.getElementById("errormsg").innerText=" Select Billtype";
		 
		 document.getElementById("cmbbilltype").focus();
		 return 0;
		   }
	else
		   {
		   document.getElementById("errormsg").innerText="";
		   } 
	
 
		  var rows = $("#vehpurchasedirgrid").jqxGrid('getrows');
		    $('#vehpurchasegridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   
		   var fleet_sel=0;
		   var tax_total=0;
		  var net_total=0;
		  	
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 

		    	newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
           .attr("id", "vehpurchasetest"+i)
		       .attr("name", "vehpurchasetest"+i) 
		           .attr("hidden", "true"); 
		    
		   		newTextBox.val(rows[i].fleet_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].clrid+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].prch_cost+" :: "+rows[i].addicost+" :: "
				   +rows[i].price+" :: "+rows[i].taxperc+" :: "+rows[i].taxamt+" :: "+rows[i].nettotal+" :: ");

		  		 newTextBox.appendTo('form');
		  		 
		  		 
		  	
		    if(rows[i].fleet_no!="" && rows[i].fleet_no!=null && rows[i].fleet_no!="null" && rows[i].fleet_no!="undefined"){
		  		fleet_sel=1;
		  		
		  		tax_total+= $.isNumeric(rows[i].taxamt)?rows[i].taxamt:0;
		  		net_total+= $.isNumeric(rows[i].nettotal)?rows[i].nettotal:0;
		    }
		  		
		   }   
		   
		  		$("#txttaxamount").val(tax_total);
		  		$("#txtnetotal").val(net_total);
		  		
		    
		   
		   if(fleet_sel==0)
			{
			 document.getElementById("errormsg").innerText=" Select atleast one fleet";
			 
			 document.getElementById("invno").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		   
		   
				 /* Applying Invoice Grid Updating Ends*/
				 
	    		return 1;
		} 
	  
    
	  
	  $(function(){
	        $('#frmpurchasedir').validate({
	        	 rules: { 
	        		 vehdesc:{maxlength:200},
	        		 
	        	 },
		                 messages: {
		                	 
		                	 vehdesc: {maxlength:"  Max 250 chars"}
		              
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
	
	
  function setValues()
  {
	  
	   if($('#hidvehpurorderDate').val()){
			 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
		  }
	   if($('#hidcmbbilltype').val()!=""){
			  $('#cmbbilltype').val($('#hidcmbbilltype').val());   
			}
	   if($('#hidreftype').val()!=""){
			 $("#reftype").val($('#hidreftype').val());
		  }
	  
	   $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
		  var date = $('#vehpurorderDate').val();
		  getEPOCurrencyId(date)
		  $('#vehpurorderDate').jqxDateTimeInput({disabled: true});

	  if($('#hidvehpurinvDate').val()){
			 $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
		  }
	  
		var indexVa5 = document.getElementById("masterdoc_no").value;
		
        if(parseInt(indexVa5)>0){
       	
  	 
        $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);  
        }
        if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        document.getElementById("formdetailcode").value=$('#formdetailcode').val();
//alert($('#formdetailcode').val());
  }
	
 
	 function funPrintBtn(){
	  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  	  
	  	   var url=document.URL;
	  	 
	         var reurl=url.split("saveeqPurchaseDir");
	         
	         $("#docno").prop("disabled", false);                
	         
	   
	 var win= window.open(reurl[0]+"printeqPurchaseDir?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	      
	 win.focus(); 
	  	   } 
	  	  
	  	   else {
	 	    	      $.messager.alert('Message','Select a Document....!','warning');
	 	    	      return false;
	 	    	     }
	 	    	
	  	} 
	 function getEPOCurrencyId(date){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
			        var currateItems=items[2];
			        var curtypeItems=items[3];
			        var multiItems=items[4];
			        var optionscurr = '';
					if(curcodeItems.indexOf(",")>=0){
			        var currencyid=curidItems.split(",");
			        	var currencycode=curcodeItems.split(",");
			        	var currencyrate=currateItems.split(",");
			        	var currencytype=curtypeItems.split(",");
			        	multiItems.split(",");
			       
			       for ( var i = 0; i < currencycode.length; i++) {
			    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
			        }
					 $("select#epocmbcurr").html(optionscurr);
				         if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
				       		 $('#epocmbcurr').val($('#hidcmbcurr').val()) ;
				       		 getEPORatevalue($('#hidcmbcurr').val(),$('#vehpurorderDate').val());
				         } 
						 if($('#mode').val()=="A"){
					    	funRoundRate(currencyrate[0],"epocurrate");
					     }
					}else{
			    	optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
					    	   
						    	   $("select#epocmbcurr").html(optionscurr);
						    	   if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
						    	   		$('#epocmbcurr').val($('#hidcmbcurr').val()) ;
						    	   		getEPORatevalue($('#hidcmbcurr').val(),$('#vehpurorderDate').val());
						    	   } 
								    
								     if($('#mode').val()=="A"){
								    	funRoundRate(currateItems,"epocurrate");
								     }
					       
				       }
				}
		     }
		      x.open("GET", <%=contextPath+"/"%>+"getCurrencyId.jsp?date="+date,true); 
		     x.send();
		   }
		function getEPORatevalue(a,date){
			  var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					 	var items= x.responseText;
					 	items = items.split('####');
							var ratesItems  = items[0].split(",");
							var typesItems = items[1].split(",");
							funRoundRate(ratesItems,"epocurrate");  
					    }
				       else
					  {}
			     }
			      x.open("GET", <%=contextPath+"/"%>+"getRateTo.jsp?currs="+a+"&date="+date,true);
			     x.send();
			    
			   } 
		function funrefdisslno(){
			   if($('#reftype').val()=="EPO"){
				   $('#refno').attr('disabled', false);  
			   }else{
				   $('#refno').val("");
				   $('#refno').attr('disabled', true);
			   }
		    }  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();getBill();">
<div id="mainBG" class="homeContent" data-type="background" >
<jsp:include page="../../../header.jsp"></jsp:include><br><br>

<div  class='hidden-scrollbar'>

<form id="frmpurchasedir" action="saveeqPurchaseDir" method="post" autocomplete="off">

<fieldset>
<table width="100%" >  
<tr> 
    <td width="5%"  align="right">Date</td>  
    <td width="5%"><div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>' onblur="tax()" onchange="tax()"></div>
    <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/></td>
     <td width="30%" align="right">
       <label id="billname">Bill Type</label> &nbsp;<select id="cmbbilltype" name="cmbbilltype"   style="width:20%;" value='<s:property value="cmbbilltype"/>'>
     <!--  <option value="1">ST</option>
      <option value="2">RCM</option> -->
      
      </select>
      <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
    
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type</td>
    <td width="5%"><select id="reftype" name="reftype" style="width:92%;" value='<s:property value="reftype"/>' onchange="funrefdisslno()">
      <option value="DIR">DIR </option>
       <option value="EPO">EPO</option></select>
       <input type="hidden" id="hidreftype" name="hidreftype" value='<s:property value="hidreftype"/>'/>     
     </td>
    <td width="10%"><input type="text" id="refno" name="refno" style="width:96%;" placeholder="Press F3 to Search" value='<s:property value="refno"/>'  onkeydown="getrefDetails(event)"/></td>
    <td align="right"  width="5%">Inv No</td> 
    <!-- onkeypress="javascript:return isNumber (event)" -->  
    <td width="5%">  <input type="text" id="invno" name="invno" style="width:99%;"   value='<s:property value="invno"/>'/></td>
    <td width="5%" align="right">Doc No</td>    
    <td width="5%"><input type="text" id="docno" name="docno" style="width:97%;" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"/>
    </td>
  </tr>
  <tr>
    <td width="5%" align="right">Vendor</td>  
    <td width="5%"><input type="text" id="accid" name="accid" style="width:95%;" placeholder="Press F3 to Search" value='<s:property value="accid"/>'  onkeydown="getaccountdetails(event)"/></td>
    <td width="18%"><input type="text" id="vehpuraccname" name="vehpuraccname" style="width:65%;" value='<s:property value="vehpuraccname"/>'/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Purchase Date </td>
    <td width="5%"><div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
    <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
    </td>
    <td align="right" width="5%">Curr</td>  
    <td width="5%" align="left"><select name="epocmbcurr" id="epocmbcurr" style="width:92%;"  value='<s:property value="epocmbcurr"/>' onchange="getEPORatevalue(this.value,$('#vehpurorderDate').val());">     
    </select>    
    <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/></td>  
    <td width="5%" align="right">Rate <input type="text" class="amtclass" name="epocurrate" id="epocurrate" value='<s:property value="epocurrate"/>'  onblur="funRoundAmt(this.value,this.id);" tabindex="-1"></td>  
  </tr>
  <tr>
     <td align="right"  width="5%">Description</td>
     <td width="40%" colspan="8"><input type="text" id="vehdesc" name="vehdesc" style="width:99%;" value='<s:property value="vehdesc"/>'/></td>
  </tr>
</table>
</fieldset>
<br>
<fieldset>

<div id="vehpuchase"><jsp:include page="vehpurchaseDetails.jsp"></jsp:include></div> 
</fieldset>

 
<br><br>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  


 

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="formdetailcode" name="formdetailcode"  value='<s:property value="formdetailcode"/>'/>

<input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>
<input type="hidden" id="headacccode" name="headacccode"  value='<s:property value="headacccode"/>'/>
<input type="hidden" id="txttaxpercentage" name="txttaxpercentage"  value='<s:property value="txttaxpercentage"/>'/>
<input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght"  value='<s:property value="vehpurchasegridlenght"/>'/>

 <div hidden>
   		<table width="100%" border="0">
		  <tr>
		    <td width="34%">&nbsp;</td>
		    <td width="15%" align="right"><label id="lbltax">Tax Amount</label></td>
		    <td width="17%"><input type="text" name="txttaxamount" class="amtclass" onblur="funRoundAmt(this.value,this.id)" id="txttaxamount" value='<s:property value="txttaxamount"/>' ></td>
		    <td width="12%" align="right">Net Total</td>
		    <td width="22%"><input type="text" name="txtnetotal" class="amtclass" id="txtnetotal" onblur="funRoundAmt(this.value,this.id)" value='<s:property value="txtnetotal"/>'></td>   
		  </tr>
		</table>
   </div>
 	<%-- <input type="text" name="taxmeth" id="taxmeth" value='<s:property value="taxmeth"/>'> --%>
 </form>
	<div id="accountSearchwindow">
   <div ></div>
</div>
   
   
   
<div id="fleetwindow"><div></div>
</div>
 <div id="refnosearchwindow">
   <div ></div>
</div>
</div>
</div>
 
</body>
</html>
