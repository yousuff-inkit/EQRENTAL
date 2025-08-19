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
</style>

 <%
 
 String masterdoc_no=request.getParameter("masterdoc_no");
 String checkval=request.getParameter("checkval");
 String branchvals=request.getParameter("branchvals");
 




 %>
<script type="text/javascript">
	$(document).ready(function() {

  		 $('#btnvaluechange').hide();
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 refChange();
		// getCurrencyIds();
		 chkfoc();
		 chkbatch();
		/* /*  $("#btnEdit").attr('disabled', true ); */ 
		 document.getElementById("checkhidegrid").value="0";
		 $('#userwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		 $('#userwindow').jqxWindow('close');  
		 $('#customerDetailsWindow').jqxWindow({width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#customerDetailsWindow').jqxWindow('close'); 
		 $('#sidesearchwndow').jqxWindow({  width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 300, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close');
	     
	     $('#accountsearchwindow').jqxWindow({
	 		width : '50%',
	 		height : '58%',
	 		maxHeight : '70%',
	 		maxWidth : '50%',
	 		title : 'Account Search',
	 		position : {
	 			x : 600,
	 			y : 87
	 		},
	 		theme : 'energyblue',
	 		showCloseButton : true,
	 		keyboardCloseKey : 27
	 	});
	 	$('#accountsearchwindow').jqxWindow('close');
	     
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
			$('#searchwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
				x : 420,
				y : 87
			}, keyboardCloseKey: 27});
		     $('#searchwndow').jqxWindow('close');  
			 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
			   $('#refnosearchwindow').jqxWindow('close'); 
			
		 //getCurrencyIds();
		 
		 $('#date').on('change', function (event) {
			  
			    var maindate = $('#date').jqxDateTimeInput('getDate');
			  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
			    funDateInPeriodchk(maindate);
			  	 }
			   });

		 $('#txtclient').dblclick(function(){
			   
		    	if($('#mode').val()!= "view")
		    		{
			  	  CustomerSearchContent('clientINgridsearch.jsp');
		    		}
		  });
		 $('#user_namess').dblclick(function(){
			 
			 	if($('#mode').val()!= "view")
					{
			 		 
				usersearchcontent('searchuser.jsp?'); 
					}
				
			     });
		 $('#txtsalesperson').dblclick(function(){
			   
		    	if($('#mode').val()!= "view")
		    		{
		    		salespersonSearchContent('salesPersonSearch.jsp');
		    		}
		  });
		 
		 $('#rrefno').dblclick(function(){
			   
		    	if($('#mode').val()== "A")
		    		{
		    		
		    		var checkval='<%=checkval%>';
					 if(checkval=="open")
						 {
						 return 0;
						 }

		    		  var clientid=document.getElementById("clientid").value;
		  			
		  			if(clientid>0){
		  				
		  				document.getElementById("errormsg").innerText="";
		  				
		  			}
		  			else{
		  				document.getElementById("errormsg").innerText="Select a client";
		  				
		  				return 0;
		  			}
		  			
		    		
		    		$('#refnosearchwindow').jqxWindow('open');
		    		refsearchContent('refnosearch.jsp');
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
			  
			//	 $("#btnEdit").attr('disabled', true );
				
				
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();
	
	
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
	
	 function funReadOnly(){
		    $('#psearch').attr('disabled', true );
			$('#frmQuotation input').attr('readonly', true );
			$('#frmQuotation select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$("#jqxQuotation").jqxGrid({ disabled: true});
			$("#jqxTerms").jqxGrid({ disabled: true});
			$("#jqxserviceGrid").jqxGrid({ disabled: true});
			 
			$('#btnvaluechange').hide();
			 $('#chkdiscount').attr('disabled', true);	 
			 $('#btnCalculate').attr('disabled', true);
			

		     $('#user_namess').attr('disabled', true);
		
			 $('#dscper').attr('disabled', true);
			 $('#process').attr('disabled', true);
			 $('#changeuser').attr('disabled', true);
			 
			 $('#process1').attr('disabled', true);
			 
			var masterdoc_no='<%=masterdoc_no%>';
			
			var checkval='<%=checkval%>';
			 if(checkval=="open")
				 {
				/*  $("#btnCreate").click(); */
				 /* $( "#btnCreate" ).trigger( "click" ); */
				 
				// enqmasterdocno rrefno txtclient txtclientdet clientid
				 
				 funCreateBtn();
				 
				 }
			
			
			
	 }
	 
	 function funRemoveReadOnly(){
		 chkbatch();
		 document.getElementById("editdata").value="";
			if ($("#mode").val() == "A") {
		 gridLoad();
			}
			 chkmultiqty();
			gettaxaccount(1);	
			getround();
			getCurrencyIds();
			$('#frmQuotation input').attr('readonly', false );
			$('#frmQuotation select').attr('disabled', false);
			
			
			
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
			
			$('#txtclient').attr('readonly', true );
			$('#rrefno').attr('readonly', true );
			$('#txtsalesperson').attr('readonly', true );
			$('#txtproductamt').attr('readonly', true );
			$('#txtdiscount').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			$('#orderValue').attr('readonly', true );
			$('#orderValuefinal').attr('readonly', true );
			
			
			 $('#user_namess').attr('readonly', true );
			 $('#user_namess').attr('disabled', true);
			 $('#pass_wordss').attr('disabled', true);
			 $('#dscper').attr('disabled', true);
			 $('#process').attr('disabled', true);
			 $('#changeuser').attr('disabled', true);
			
			
			
			
			
			  $('#descPercentage').attr('disabled', true);
				 $('#txtdiscount').attr('disabled', true);
			
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxQuotation").jqxGrid({ disabled: false});   
			$("#jqxTerms").jqxGrid({ disabled: false});
			$("#jqxserviceGrid").jqxGrid('disabled', false);
			/* if ($("#mode").val() == "E") {
   			    $("#jqxQuotation").jqxGrid('addrow', null, {});
   			    $("#jqxserviceGrid").jqxGrid('addrow', null, {});
			   $('#descPercentage').attr('disabled', false);
	  				 $('#txtdiscount').attr('disabled', false);
			
			}
			 */
			
		  	if ($("#mode").val() == "E") {
				 
		  		$("#jqxQuotation").jqxGrid({ disabled: true});
				$("#jqxserviceGrid").jqxGrid({ disabled: true});
				
				$('#cmbvatype').attr('readonly', true);
				 $('#cmbvatype').attr('disabled', true);
			    
				$("#jqxTerms").jqxGrid({ disabled: true});
				 
				   $('#btnCalculate').attr('disabled', true);
				
				   $('#btnvaluechange').show();
					funckclientcat();
				   
			}  
		  
			 var masterdoc_no='<%=masterdoc_no%>';
				 
				var checkval='<%=checkval%>';
				 if(checkval=="open")
					 {	
					 
					
					 
		  	 
			 var x=new XMLHttpRequest();
		        x.onreadystatechange=function(){
		        if (x.readyState==4 && x.status==200) 	 
		         {
		           var items= x.responseText.trim();
		           var item = items.split('##');
/* 					var clientid  = item[0];
					var doc_no = item[1];
					var voc_no = item[2];
					var clientname = item[3];
					var address = item[4];
		      */
		    
		      $('#rrefno').attr('disabled', false);	
		      $('#rrefno').attr('readonly', true );
		  	document.getElementById("cmbreftype").value="CEQ";
		  	 var branchvals='<%=branchvals%>';
			 
			 document.getElementById("brchName").value=branchvals;	 
	        
					
					// enqmasterdocno rrefno txtclient txtclientdet clientid
					
					
					  document.getElementById("clientid").value=item[0];
					  document.getElementById("enqmasterdocno").value=item[1];
					  document.getElementById("rrefno").value=item[2];
					  document.getElementById("txtclient").value=item[3];
					  document.getElementById("txtclientdet").value=item[4];
					
					
					  		$("#mode").val("A");
							$("#txtproductamt").val("0.0");
							$("#txtdiscount").val("0.0");
							$("#txtnettotal").val("0.0");
							$("#nettotal").val("0.0");
							$("#descPercentage").val("0.0");
							$("#prodsearchtype").val("0");
							$("#orderValue").val("0.0");
							$("#orderValuefinal").val("0.0");
							$("#roundOf").val("0.0");
							$('#rrefno').attr('disabled', false);
							//getCurrencyIds();
							$('#date').val(new Date());
							$("#jqxTerms").jqxGrid({ disabled: false});
							$("#jqxserviceGrid").jqxGrid({ disabled: false});
							$("#jqxserviceGrid").jqxGrid('clear'); 
							$("#jqxserviceGrid").jqxGrid('addrow', null, {});
							 $('#chkdiscount').attr('disabled', false);	
			 
			       	
			    		
			    		
			       		  $("#quotationDiv").load("quotationGrid.jsp?enqdocs="+masterdoc_no);	
 
		           
		            }
		        }
		        x.open("GET","getenqdata.jsp?masterdoc_no="+masterdoc_no,true);
		      x.send();
		      
		           
					 }
				 else
					 {
			
			
						if ($("#mode").val() == "A") {
							
							$("#txtproductamt").val("0.0");
							$("#txtdiscount").val("0.0");
							$("#txtnettotal").val("0.0");
							$("#nettotal").val("0.0");
							$("#descPercentage").val("0.0");
							$("#prodsearchtype").val("0");
							$("#orderValue").val("0.0");
							$("#orderValuefinal").val("0.0");
							$("#roundOf").val("0.0");
							$('#rrefno').attr('disabled', true);
							//getCurrencyIds();
							$('#date').val(new Date());
							$("#jqxTerms").jqxGrid({ disabled: false});
							$("#jqxQuotation").jqxGrid('clear'); 
							$("#jqxQuotation").jqxGrid('addrow', null, {});
							$("#jqxserviceGrid").jqxGrid({ disabled: false});
							$("#jqxserviceGrid").jqxGrid('clear'); 
							$("#jqxserviceGrid").jqxGrid('addrow', null, {});
							 $('#chkdiscount').attr('disabled', false);	 
							 
							 
							 $("#hidegrids").jqxGrid('clear'); 
							 
							 
							 
							 
						}
					 }
				 if($('#cmbreftype').val()!="DIR")
	      		 {  $('#psearch').attr('disabled', false );
	      		 
	      		  $('#rrefno').attr('disabled', false);
	      		 }
		     	 else
		     		 {
		     		 reloads();
		     		 $('#psearch').attr('disabled', false );
		     		 }
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('qotMastersearch.jsp'); 
	}
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#date').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmQuotation').validate({
	                rules: {
	                txtfromaccid:"required",
	                txtfromamount:{"required":true,number:true}
	                },
	                 messages: {
	                 txtfromaccid:" *",
	                 txtfromamount:{required:" *",number:"Invalid"}
	                 }
	        });});
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
			   var validdate=funDateInPeriodchk(maindate);
			   if(validdate==0){
			   return 0; 
			   }

		  if($('#txtclient').val()=="")
			  {
			  document.getElementById("errormsg").innerText="Search Customer";  
			   document.getElementById("txtclient").focus();
			     
			      return 0;
			  
			  }
		  
		  
		  var rows = $("#jqxQuotation").jqxGrid('getrows');
		  var termrows = $("#jqxTerms").jqxGrid('getrows');
		  
		  
		  $('#termsgridlength').val(termrows.length);
		   $('#gridlength').val(rows.length);
		   
		  for(var i=0 ; i < rows.length ; i++){ 
		   newTextBox = $(document.createElement("input"))
		      .attr("type", "dil")
		      .attr("id", "prodg"+i)
		      .attr("name", "prodg"+i)
		      .attr("hidden", "true");
		   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::");
		   
		  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"
				  +rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"
				  +rows[i].outqty+"::"+rows[i].oldqty+"::"+rows[i].unitprice1+"::"+rows[i].disper1+"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].allowdiscount+"::"+rows[i].taxdocno+"::"+"0000"+"::");
		  newTextBox.appendTo('form');
		  }
		  
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
		  $('#descPercentage').attr('disabled', false);
			 $('#txtdiscount').attr('disabled', false);
			 
			 
		
	    	return 1;
			
		} 
	  
	  
	  function setValues(){
		 // alert($('#hidcmbcurr').val());
			/* if($('#hidcmbcurr').val()!=""){
				 if($('#hidcmbcurr').val()=="1"){
					 $('#cmbcurr').val("AFN");
					  }
				 if($('#hidcmbcurr').val()=="2"){
					 $('#cmbcurr').val("USD");
					  }
				 if($('#hidcmbcurr').val()=="3"){
					 $('#cmbcurr').val("RUP");
					  }
				  } */
		  document.getElementById("formdetail").value="Sales Quotation";
	   		document.getElementById("formdetailcode").value="SQT";  
		  if($('#hiddate').val()){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  }

		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
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
			
			
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		// funSetlabel();
		  combochange();
		  var masterdoc_no=$('#masterdoc_no').val().trim();
		  var enqmasterdocno=$('#enqmasterdocno').val().trim();
		  var dtype=$('#formdetailcode').val().trim();
		  var refdtype=$('#cmbreftype').val();
		  if(masterdoc_no>0){
			  funchkforedit();
			  $("#quotationDiv").load("quotationGrid.jsp?qotdoc="+masterdoc_no+"&refdtype="+refdtype+"&enqdoc="+enqmasterdocno+"&cond=2");
			  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+masterdoc_no);
			  $("#servicegrid").load("servicegrid.jsp?rdoc="+masterdoc_no);
			  
			  var txtproductamt=document.getElementById("txtproductamt").value; 
	          var txtdiscount=document.getElementById("txtdiscount").value; 
	          var txtnettotal=document.getElementById("txtnettotal").value;
	          var orderValue=document.getElementById("orderValue").value;
			  var roundOf=document.getElementById("roundOf").value;
			  var descPercentage=document.getElementById("descPercentage").value;
			  
			  funRoundAmt(txtproductamt,"txtproductamt");
			  funRoundAmt(txtdiscount,"txtdiscount");
			  funRoundAmt(orderValue,"orderValue");
			  funRoundAmt(orderValue,"orderValuefinal");
			  funRoundAmt(txtnettotal,"txtnettotal");
			  funRoundAmt(roundOf,"roundOf");
			  funRoundAmt(descPercentage,"descPercentage");
			  
			  
			  
			    
		  }
		  
		  
			var checkval='<%=checkval%>';
			
			var branchvals='<%=branchvals%>';
			 
	 		/* if(checkval=="open")
				 {	
				 
			 
				 document.getElementById("brchName").value="";
				 
				 document.getElementById("brchName").value=branchvals;
			 
				 }  */

				  gettaxaccount(1);
				funSetlabel();
			
		}
	 
	  function getCustomer(event){
          var x= event.keyCode;
          	if(x==114){
        	  <%-- CustomerSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp"); --%>
          	}
          }
	  
	  function getCurrencyIds(){
		  var dates=document.getElementById("date").value;
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
		   x.open("GET","getCurrencyId.jsp?date="+dates,true);
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
		  var reftype=$('#cmbreftype').val();
		  if(reftype=='DIR'){
			  
			  $('#rrefno').attr('disabled', true);
		  }
		  else{
			  
			  $('#rrefno').attr('disabled', false);
			  $('#psearch').attr('disabled', false);
			 
		  }
		  
	  }
	  
	  function gridLoad(){
		  var dtype=document.getElementById("formdetailcode").value;
		  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
		 
	  }
	  
	 
	  
	  
	  function getrefno(event)
	  {
		 	if($('#mode').val()== "A")
    		{ 
				  var clientid=document.getElementById("clientid").value;
					
					if(clientid>0){
						
						document.getElementById("errormsg").innerText="";
						
					}
					else{
						document.getElementById("errormsg").innerText="Select a client";
						
						return 0;
					}
					
				  
				  
			  	 var x= event.keyCode;
			  	 if(x==114){
			  	  $('#refnosearchwindow').jqxWindow('open');
			  	
			  	  refsearchContent('refnosearch.jsp');  }
			  	 else{
			  		 }
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
				  if($('#hidcmbreftype').val()!="")
				  {
				  
				  
				  $('#cmbreftype').val($('#hidcmbreftype').val());
				  }
				   if($('#hidcmbbilltype').val()!="")
					  {
					  
					  
					  $('#cmbbilltype').val($('#hidcmbbilltype').val());   
					  
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
	  		
	  		
	  		$('#jqxQuotation').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
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
	  		
	  		
	  	/* 	
	  		alert("descvalue"+descvalue);
	  		
	  		alert("netval"+netval);
	  		 */
	  		funRoundAmt(descvalue,"txtdiscount");
	  		funRoundAmt(netval,"txtnettotal");
	  		var aa;
	  	 if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
	  	   	            	   {
	  	   	               
	  	   	               aa=parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
	  	   	            	   }
	  	   	               else
	  	   	            	   {
	  	   	            	    aa=document.getElementById("txtnettotal").value;
	  	   	            	   }
	  	        
	  	                
	  	            	funRoundAmt(aa,"orderValue");
	  	            	funRoundAmt(aa,"orderValuefinal");
	  		
	  		 var rows = $('#jqxQuotation').jqxGrid('getrows');
	  	      var rowlength= rows.length;
	  	  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
	  	  	
	  	 
	  	   
	  			    for(var i=0;i<rowlength;i++)
	  						  {
	  		 
	  			    	var totamt=rows[i].total;
	  			     
	  			    	var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
	  			     
	  			    	var nettot=parseFloat(totamt)-parseFloat(discounts);
	  			    	
	  		  
	  			    	$('#jqxQuotation').jqxGrid('setcellvalue',i, "dis" ,discounts);
	  			    	$('#jqxQuotation').jqxGrid('setcellvalue',i, "netotal" ,nettot);
	  					 
	  				  
	  						  }
	  		 
	  		 
	  		
	  	 
	  		
	  		
	  		
	  		
	  		}
	  		
	  		
	  		
	  		
	  	function funvalcalcu()
	  		{
	  		
	  		
	  		document.getElementById('prddiscount').value="";
	  		$('#jqxQuotation').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
	  		var  productTotal=document.getElementById('txtproductamt').value;
	  		var  descountVal=document.getElementById('txtdiscount').value;
	  	 
	  		var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
	  		var netval=parseFloat(productTotal)-parseFloat(descountVal);
	  		
	  	 
	  		funRoundAmt(descper,"descPercentage");
	  		funRoundAmt(netval,"txtnettotal");
	  		
	  		funcalcu();
	  		}
	  		
	  		
/* 	  		
	  	 function roundval()
	  	{
	  			var  netTotaldown=document.getElementById('txtnettotal').value;
	  		    var roundOf=document.getElementById('roundOf').value;
	  	 
	  			 
	  			var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
	  			funRoundAmt(netval,"txtnettotal"); 
	  			
	  			var aa;
	  		  	 if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
	  		  	   	            	   {

	  		  	   	               aa=parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
	  		  	   	            	   }
	  		  	   	               else
	  		  	   	            	   {
	  		  	   	            	    aa=document.getElementById("txtnettotal").value;
	  		  	   	            	   }
	  			
	  			
	  			funRoundAmt(aa,"orderValue");
	  	} */
	  	 
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
	  				 
	  				  $('#descPercentage').attr('disabled', false);
	  				 $('#txtdiscount').attr('disabled', false);
	  				 $('#btnCalculate').attr('disabled', false);
	  				  
	  		   }
	  		  
	  		   
	  				}
	  			
	  			
	  		      
	  	      });
	  		   }
	  		   else
	  		   {
	  		   document.getElementById('descPercentage').value="";
	  		   document.getElementById('txtdiscount').value="";
	  		   var summaryData3= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	  	  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
	  		   $('#descPercentage').attr('disabled', true);
	  			 $('#txtdiscount').attr('disabled', true);
	  				$('#jqxQuotation').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
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
          
            
            $('#jqxQuotation').jqxGrid('showcolumn', 'foc');
         
            
            
             }
               else
           {
           
                $('#jqxQuotation').jqxGrid('hidecolumn', 'foc');
           
           }
           
            if(parseInt(kg)>0)
           {
         
           
           $('#jqxQuotation').jqxGrid('showcolumn', 'kgprice');
           $('#jqxQuotation').jqxGrid('showcolumn', 'totwtkg');
        
           
           
            }
              else
          {
          
               $('#jqxQuotation').jqxGrid('hidecolumn', 'kgprice');
               $('#jqxQuotation').jqxGrid('hidecolumn', 'totwtkg');
          
          } 
           
           
           
            }}
        x.open("GET","checkfoc.jsp",true);
      x.send();
      
           
             
         
        }
	  	
	  	
	  	function accountSearchContent(url) {
	  		$('#accountsearchwindow').jqxWindow('open');
	  		$.get(url).done(function(data) {
	  			$('#accountsearchwindow').jqxWindow('setContent', data);
	  			$('#accountsearchwindow').jqxWindow('bringToFront');
	  		});
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
	 	 
	 				  $('#process').attr('disabled', false);
	 		 
	 			 
	 					$("#jqxTerms").jqxGrid({ disabled: false});
	 					 
	 	    		$("#jqxQuotation").jqxGrid({ disabled: false});
	 	    		
	 	    		$("#jqxserviceGrid").jqxGrid({ disabled: false});
	 	    		
	 	      
	 	    	    $("#jqxQuotation").jqxGrid('addrow', null, {});
	 	    	    
	 	     
	 	    	    $("#jqxserviceGrid").jqxGrid('addrow', null, {});
	 	    	    

	 	    	    $("#jqxTerms").jqxGrid('addrow', null, {});
	 	    	    
	 	    		

	 	       }
	 	      });
	 	   }
	
		   function funPrintBtn(){
		 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		 	  
		 	   var url=document.URL;

		        var reurl=url.split("saveQuotationOld");
		        
		        $("#docno").prop("disabled", false);                
		        
		 
		var win= window.open(reurl[0]+"printSalesQuotAction?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		 //alert("hi");   
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
			 
				$("#jqxQuotation").jqxGrid({ disabled: true});
			 
			 if(parseInt(document.getElementById("checkhidegrid").value)==1)
				 {
			 var rows  = $("#jqxQuotation").jqxGrid('getrows');
			 var rows1 = $("#hidegrids").jqxGrid('getrows');
			 
			 for(var i=0 ; i < rows.length ; i++){ 
				 
				 for(var j=0 ; j<rows1.length ; j++){
					 
					 if(parseInt(rows1[j].doc_no)==parseInt(rows[i].prodoc))
						 {
						 
					     $('#jqxQuotation').jqxGrid('setcellvalue', i, "allowdiscount",rows1[j].allowdiscount);
						 
						 break;
						 }
					 
				 }
				 
				 
			 }
	           
				 }
			 var rows = $("#jqxQuotation").jqxGrid('getrows');
			 
			 for(var i=0 ; i < rows.length ; i++){ 
				  
				 
		   if(parseInt(rows[i].prodoc)>0)
				 {  
			  
					
			         var dscper=document.getElementById("dscper").value;
			     	      
			     	 var allowdiscount=rows[i].allowdiscount;
			     	
			     	 var discallowper=0;
				       
	 
					      	if(dscper!="" || dscper!=null)
					      		{
					      		 discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
					      		 
					      		 if(discallowper>0)
					      			 {
					      		 
					            $('#jqxQuotation').jqxGrid('setcellvalue', i, "discper",discallowper.toFixed(2));
					      			 }
							  
					      		}
				
			    }  
			  
		    }
			 
			 $("#overlay, #PleaseWait").hide();
				$("#jqxQuotation").jqxGrid({ disabled: false});
		 } 
		 
		 
		function funreloadhidegrid()
		{
			
			 var prodsearchtype=$("#prodsearchtype").val();
	    	 var refmasterdocno=$("#rrefno").val();;
	    	 var reftype=$("#cmbreftype").val(); 
			 var cmbprice="";
			 var cmbreftype=document.getElementById("cmbreftype").value;
			 var clientcaid=document.getElementById("clientcaid").value; 
			 var clientid=document.getElementById("clientid").value;
			 var dates=document.getElementById("date").value;
			 $("#hidegrid").load("hidegrid.jsp?prodsearchtype="+prodsearchtype+"&enqmasterdocno="+refmasterdocno+"&reftype="+reftype+"&cmbprice="+cmbprice+"&clientid="+clientid+"&cmbreftype="+cmbreftype+"&clientcaid="+clientcaid+"&dates="+dates);
	 	
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
					
 
					
					
					}
				}
				
				
			 
				
				
				
			
			funRoundAmt4(tax1val,"taxontax1"); 
			funRoundAmt4(tax2val,"taxontax2");
			funRoundAmt4(tax3val,"taxontax3");
			funRoundAmt4(finaltax,"taxtotal");
			
		 
			
			
			 	
			
		}
		
		function reloads()
		{
 	 var prodsearchtype=0;
	 var refmasterdocno="";
	 

	 
	 var reftype=$("#cmbreftype").val();
		 
		 
		var clientid=document.getElementById("clientid").value;
		 
		  
  		
		
		var cmbprice="";
		var cmbreftype=document.getElementById("cmbreftype").value;
		 var clientcaid=document.getElementById("clientcaid").value; 
		 var dates=document.getElementById("date").value;
		 //alert("date===="+dates);
		 
		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
		 
		
		 
 
		 
		 $("#part").load('part.jsp?prodsearchtype?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&reftype='+reftype+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
  	
		
		 $("#pnames").load('name.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&reftype='+reftype+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
	 
		}
		
		function funRoundAmt4(value,id){
			  var res=parseFloat(value).toFixed(4);
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
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
		function gettaxaccounts()
		{
			 $("#jqxQuotation").jqxGrid('clear');
			    $("#jqxQuotation").jqxGrid('addrow', null, {});
			gettaxaccount(1);
		}
		
		function prosrch(){
			var prodsearchtype=$("#prodsearchtype").val();
			 var enqmasterdocno=$("#enqmasterdocno").val();
	   		 var clientcaid=document.getElementById("clientcaid").value; 
	   		 var dates=document.getElementById("date").value;
	   		 var cmbbilltype=document.getElementById("cmbbilltype").value;
	   		var clientid=document.getElementById("clientid").value;
	   		
	   		if(clientid==""){
	   	  $.messager.alert('Message','Select a Customer');
	      return false;
	   		}
	   		//var prddata=document.getElementById("prddata2").value;
	   		//alert(prddata);
	   			 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+enqmasterdocno+'&reftypes='+document.getElementById("cmbreftype").value+'&mode='+document.getElementById("mode").value+'&clientcaid='+clientcaid+'&dates='+dates+'&cmbbilltype='+cmbbilltype+'&clientid='+clientid+'&id=1'+'&hidalterid=1');
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
				var type=document.getElementById("cmbvatype").value.trim();
				//alert("type===="+type);
				if(type=="export"){
					document.getElementById("taxpers").value=0;
					 var rows = $("#jqxQuotation").jqxGrid('getrows');   
					 var chk=rows.length-1;
					 //alert("chk===="+chk);
					 if(parseFloat(chk)>0){
		        	  for(var i=0;i<rows.length-1;i++){
		        	   		$('#jqxQuotation').jqxGrid('setcellvalue', i, "taxper",0); 
		           		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxperamt",0);
		           		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "qty",0);
		           		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "unitprice",0);
		           		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "netotal",0);
		           		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "dis",0);
		           		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "discper",0);
		           		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxamount",0);
		        	  }
					 }
				}
				if(type=="exclusive"){
					var tsk=document.getElementById("taxpers").value;
					 var rows = $("#jqxQuotation").jqxGrid('getrows');   
					 var chk=rows.length-1;
					// alert("chk===="+chk);
					 if(parseFloat(chk)>0){
		       	  for(var i=0;i<rows.length-1;i++){
		       	   		
		       		       if(parseFloat(tsk)>0){
		           		       $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxper",5);
		          	   		}else{
		          	   		$('#jqxQuotation').jqxGrid('setcellvalue', i, "taxper",0);
		          	   		}
		          		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxperamt",0);
		          		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "qty",0);
		          		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "unitprice",0);
		          		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "netotal",0);
		          		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "dis",0);
		          		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "discper",0);
		          		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxamount",0);
		       	  }
					 }
				}
				if(type=="inclusive"){
					var tsk=document.getElementById("taxpers").value;
					 var rows = $("#jqxQuotation").jqxGrid('getrows');   
					 var chk=rows.length-1;
					 //alert("chk===="+chk);
					 if(parseFloat(chk)>0){
		      	  for(var i=0;i<rows.length-1;i++){
		      	   		
		      		 if(parseFloat(tsk)>0){
	           		       $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxper",5);
	          	   		}else{
	          	   		$('#jqxQuotation').jqxGrid('setcellvalue', i, "taxper",0);
	          	   		}
		         		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxperamt",0);
		         		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "qty",0);
		         		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "unitprice",0);
		         		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "netotal",0);
		         		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "dis",0);
		         		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "discper",0);
		         		   $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxamount",0);
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
				//alert("allw=="+allw);
				if(parseFloat(allw)>0 && parseFloat(frmdis)>0){
					if(parseFloat(frmdis)<parseFloat(allw)){
						
					}
					else{
						document.getElementById("dispers").value=allw;
						//document.getElementById("errormsg").innerText="Maximum Allowed Discount Is "+allw.toFixed(2);
					}
				}
				var type=document.getElementById("cmbvatype").value;
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
			
			function calculatedatas(val)
			 {
				
				document.getElementById("errormsg").innerText="";
				
				 
				
		 
				var quantity=document.getElementById("quantity").value;
	 
				
			 
				var focs=0;
				
				var uprice=document.getElementById("uprice").value;
				var taxpers=document.getElementById("taxpers").value;
				var totalstock=document.getElementById("totalstock").value;
				
				
				var disper=document.getElementById("dispers").value;
				var discount=document.getElementById("dict").value;
				
				if(val=="dispers"){discount=0; }
				 if(val=="dict"){disper=0; }
				
				var totamt=0;
				var taxamounts=0;
				var taxamountstotal=0;
				
				if(quantity=="" || quantity==null || quantity==0 ||typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
				{
					quantity=0;
				}
				
				if(focs=="" || focs==null || focs==0 ||typeof(focs)=="undefined"|| typeof(focs)=="NaN")
				{
					focs=0;
					
					
				}
				if(totalstock=="" || totalstock==null || totalstock==0 ||typeof(totalstock)=="undefined"|| typeof(totalstock)=="NaN")
				{
					totalstock=0;
				}
				
				
				if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN")
				{
					disper=0;
				}
				
				
				if(discount=="" || discount==null || discount==0 || typeof(discount)=="undefined"|| typeof(discount)=="NaN")
				{
					discount=0;
				}
				
				
				
				
				
				 
				/* if(parseFloat(totalstock)<((parseFloat(quantity))))
					{
					 document.getElementById("errormsg").innerText="Quantity  should not be greater than available stock quantity : "+totalstock;
				 
					
					 return 0;
					
					} */
				
				
				
				
				if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN")
				{
					uprice=0;
				}
				 
					 
				if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN")
				{
					taxpers=0;
				}
				
				
				
				var netamount=0; 
				 if(parseFloat(quantity)>0 && parseFloat(uprice)>0)
					 {
					 
					 totamt=parseFloat(quantity)*parseFloat(uprice);
					/*  taxamountstotal=parseFloat(totamt)+parseFloat(taxamounts); */
					 
					 
					 
					 }
				 
					if(parseFloat(disper)>0 || parseFloat(discount)>0)
						
					{
					
					if(parseFloat(disper)>0)
						{
							discount=(parseFloat(totamt)*parseFloat(disper))/100;
						
						}
					
					else if(parseFloat(discount)>0)
						{
						
						disper=(100/parseFloat(totamt))*parseFloat(discount);
						
						}
					 
					netamount=parseFloat(totamt)-parseFloat(discount);
					
					}
				else
					{
					disper=0;
					discount=0;
					netamount=totamt;
					
					
					
					}
				
			 
				 
				 
				 if(parseFloat(taxpers))
				 {
					 
					 taxamounts=parseFloat(netamount)*(parseFloat(taxpers)/100);
					 taxamountstotal=parseFloat(netamount)+parseFloat(taxamounts);
				 }
				 else
					 {
					 taxamountstotal=netamount;
					 }
				 
				 document.getElementById("totamt").value=(totamt).toFixed(2);
				 document.getElementById("amounts").value=(totamt).toFixed(2);
				 document.getElementById("dispers").value=parseFloat(disper).toFixed(2);
				 document.getElementById("dict").value=parseFloat(discount).toFixed(2);
				 document.getElementById("amounts").value=(netamount).toFixed(2);
				 document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
				 document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
				
				 
		 
				//	document.getElementById("jqxInput1").focus();
				 
					 
			 
			 }
			
			 function setgrid()
			 {
				
				 var qty=document.getElementById("hidqty").value; 
				 //alert("qty===="+qty);
					/* if(qty=="" || qty==null || qty=="0.00" || qty==0 ||typeof(qty)=="undefined"|| typeof(qty)=="NaN"){
						$.messager.alert('Message','Product Not Available');
						return 0;
					} */
				 
				 var temppsrno=document.getElementById("temppsrno").value; 
				 var unit=document.getElementById("unit").value; 
				 
				 
		 
	    	  
			var rows1 = $("#jqxQuotation").jqxGrid('getrows');
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
	        var upr=document.getElementById("uprice").value;
			
			var sprice=document.getElementById("hidsellprice").value;
			/* if(parseFloat(upr)>0 && parseFloat(sprice)>0){
			if(parseFloat(upr)<parseFloat(sprice)){
				//document.getElementById("errormsg").innerText="Enter Unit Price Greater Than Last Selling Price ";
				 $.messager.alert('Message','Enter Unit Price Greater Than Last Selling Price ');
				document.getElementById("uprice").focus();
				 return 0;
			}
			}	 */ 
		   if(parseInt(aa)==1)
			   {
			   
				document.getElementById("errormsg").innerText="You have already select this product";
			 document.getElementById("stockmsg").innerText="";  

					 
			     document.getElementById("jqxInput1").focus();
				 
			   return 0;
			   
			   
			   
			   }
		   else
			   {
			   document.getElementById("errormsg").innerText="";
			   }
		    
				
				
				
				 var rows = $('#jqxQuotation').jqxGrid('getrows');
				  
			 	 
			     var rowlength= rows.length;
			     
			
			    
			    var quantity=document.getElementById("quantity").value;
			    var focs=0;
			    var totalstock=document.getElementById("totalstock").value;
			    
				if(quantity=="" || quantity==null || quantity=="0.00" || quantity==0 ||typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
				{
					quantity=0;
				}
				
				if(focs=="" || focs==null || focs=="0.00" || focs==0 ||typeof(focs)=="undefined"|| typeof(focs)=="NaN")
				{
					focs=0;
					
					
				}
				if(totalstock=="" || totalstock==null || totalstock==0 ||typeof(totalstock)=="undefined"|| typeof(totalstock)=="NaN")
				{
					totalstock=0;
				}
				
				 var aoq= document.getElementById("allowdiscount").value;
			    
				
				 
				/* if(parseFloat(totalstock)<((parseFloat(quantity))))
					{
					 document.getElementById("errormsg").innerText="Quantity   should not be greater than available stock quantity : "+totalstock;
					  
					
					 return 0;
					
					} */
				
				
			    if(parseFloat(document.getElementById("uprice").value)>0)
		    	{
		    	
		    	}
		    else
		    	{
		    	document.getElementById("errormsg").innerText="unit price is required";
		    	document.getElementById("uprice").focus();
		   	     return 0;
		    	}
		     
				
			     $('#datas3').val(1);
			     var rowg=$('#rowindexg').val();
			     //alert("rowg1=========="+rowg);
			      if(document.getElementById("rowindexg").value!="" && !(document.getElementById("rowindexg").value==null) && !(document.getElementById("rowindexg").value=="undefiend")){
			    	  document.getElementById("hidload").value=1; 
			    	  $('#jqxQuotation').jqxGrid('setcellvalue',  rowg, "proid", document.getElementById("jqxInput").value);
					     $('#jqxQuotation').jqxGrid('setcellvalue',  rowg, "proname", document.getElementById("jqxInput1").value);
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "allowdiscount",aoq);
					     
					     
					     
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "brandname", document.getElementById("brand").value);
					    // $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "collectqty", document.getElementById("collqty").value);
					   
					   //  $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "foc", document.getElementById("focs").value);
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "unitprice", document.getElementById("uprice").value);  
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "total", document.getElementById("totamt").value);
					     
					     
					     
					     
					     //$('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "netotal", document.getElementById("amounts").value);
					     var discount=document.getElementById("dispers").value;
					    // alert("discount======"+discount);
					     if(discount>0) 
					     {
					    	// alert("discount1111======"+discount);
						     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "discper", document.getElementById("dispers").value);  
						     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "dis", document.getElementById("dict").value);
						    // $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "netotal", document.getElementById("amounts").value);	 
						 }
						else {  	
							//alert("in else");
							$('#jqxQuotation').jqxGrid('setcellvalue',   rowg,"discper", 0);  
								     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg,"dis", 0);
								     //$('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "netotal", document.getElementById("amounts").value);
						    	 
						 }
					     //alert("in calc");
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "netotal", document.getElementById("amounts").value);
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "taxper", document.getElementById("taxpers").value);
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "taxperamt", document.getElementById("taxamounts").value);
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "taxamount", document.getElementById("taxamountstotal").value);
					     

					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "unitdocno", document.getElementById("unit").value);
					     if(document.getElementById("unit").value>0)
					     {
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "unit", $("#unit option:selected").text());
					     }
					     
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "psrno", document.getElementById("temppsrno").value);
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "prodoc", document.getElementById("temppsrno").value);
					     
					     
					     
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "specid", document.getElementById("tempspecid").value);
					     
					     
					     $('#jqxQuotation').jqxGrid('setcellvalue',  rowg, "productid" ,document.getElementById("jqxInput").value);
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "productname", document.getElementById("jqxInput1").value);
					     
					     $('#jqxQuotation').jqxGrid('setcellvalue',   rowg, "qty", document.getElementById("quantity").value);
					     document.getElementById("rowindexg").value="";
					     document.getElementById("hidload").value=0; 
			      }
			      else{
			    	  document.getElementById("hidload").value=1; 
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "allowdiscount",aoq);
			     
			     
			     
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
			    // $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "collectqty", document.getElementById("collqty").value);
			   
			   //  $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "unitprice", document.getElementById("uprice").value);  
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "total", document.getElementById("totamt").value);
			     
			     
			     
			     
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("amounts").value);
			     var discount=document.getElementById("dispers").value;
			    // alert("discount======"+discount);
			     if(discount>0) 
			     {
			    	// alert("discount1111======"+discount);
				     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "discper", document.getElementById("dispers").value);  
				     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "dis", document.getElementById("dict").value);
				    // $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("amounts").value);	 
				 }
				else {  	
					//alert("in else");
					$('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1,"discper", 0);  
						     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1,"dis", 0);
						     //$('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("amounts").value);
				    	 
				 }
			     //alert("in calc");
			     //$('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("amounts").value);
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "taxper", document.getElementById("taxpers").value);
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", document.getElementById("taxamounts").value);
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "taxamount", document.getElementById("taxamountstotal").value);
			     

			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
			     if(document.getElementById("unit").value>0)
			     {
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
			     }
			     
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
			     
			     
			     
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
			     
			     
			     $('#jqxQuotation').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
			     
			     $('#jqxQuotation').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
			     $("#jqxQuotation").jqxGrid('addrow', null, {});
			     document.getElementById("hidload").value=0; 
			      }
			   
			     
			 
					  
				
					  
					  
					   document.getElementById("jqxInput").value ="";
					   document.getElementById("jqxInput1").value="";
					   document.getElementById("brand").value=""; 
			       //    document.getElementById("collqty").value ="";
					   document.getElementById("quantity").value ="";
					   document.getElementById("unit").value ="";
					         
					   //   document.getElementById("focs").value="";
					     
					      document.getElementById("uprice").value="";
					      document.getElementById("totamt").value="";
					      document.getElementById("amounts").value="";
					    
					      document.getElementById("taxpers").value="";
					      document.getElementById("taxamounts").value="";
					      document.getElementById("taxamountstotal").value="";
					     
					      
					      document.getElementById("dispers").value="";
						     
						      document.getElementById("dict").value="";
					  
					      
					       document.getElementById("temppsrno").value="";
					       document.getElementById("tempspecid").value="";
					       
					       //document.getElementById("stockmsg").innerText="";
					     // document.getElementById("cleardata").checked=false;
					     
					     
					     
					     var summaryData1= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
	      		var summaryData= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
		        		var summaryData2= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	  			
	     document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
	    document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
	    document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
	    document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');
	    document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
	    
	    var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
		funRoundAmt(orderValue,"orderValue");
		funRoundAmt(orderValue,"orderValuefinal");
		
		
		if(document.getElementById("mode").value=="view" )
			{
			
			}
		else
			{

		funRoundAmt(0,"roundOf");
			}
		
		
		
		funRoundAmt(orderValue,"orderValue");
		funRoundAmt(orderValue,"orderValuefinal");
	    
	 	var summaryData10= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
	  
		var aa1=summaryData10.sum.replace(/,/g,'');
		   	
		/*   
		 var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value);
		  */
		 funRoundAmt4(aa1,"st");
		 funRoundAmt4(aa1,"taxtotal");
					     
					       
					       $('#datas3').val(0);  
					   
				 
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
		
		    function getRatevalue(angel)
			   {
		    
			   var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    {
			      var items= x.responseText;
			      
			      
			    /*      $('#currate').val(items) ; */
			         funRoundRate(items,"currate"); 
			        }
			          else
			      {
			      }
			       }
			   x.open("GET","getRateTo.jsp?curr="+angel,true);
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
<body onload="setValues();getAlternativeConfig(); getCurrencyIds()">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmQuotation" action="saveQuotationOld" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />
<jsp:include page="calculation.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include> 
<div  class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<%-- <table width="100%">
  <tr>
  
    <td width="3%" height="42" align="right">Date</td>
    <td width="13%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="14%"><input type="text" id="txtrefno" name="txtrefno" style="width:60%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="8%" align="right">Sales Person</td>
    <td width="24%"><input type="text" id="txtsalesperson" name="txtsalesperson" readonly style="width:50%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
    <td width="8%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table> --%>
<table width="100%">
  <tr>
  
    <td width="3%" height="42" align="right">Date</td>
    <td width="13%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="14%"><input type="text" id="txtrefno" name="txtrefno" style="width:60%;" value='<s:property value="txtrefno"/>'/></td>
   <%--  <td width="8%" align="right">Sales Person</td>
    <td width="24%"><input type="text" id="txtsalesperson" name="txtsalesperson" readonly style="width:50%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td> --%>
    <td width="8%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno" style="width:25%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset>
<table width="100%" >
  <tr>
    <td width="9%" align="right">Customer</td>
    <td width="15%"><input type="text" id="txtclient" name="txtclient" readonly style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/></td>
    <td><input type="text" id="txtclientdet" name="txtclientdet" style="width:53%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/></td>
  </tr>
  <tr>
   <td   align="right">Currency</td>
   <%--   <td  ><input type="text" name="cmbcurr" id="cmbcurr"  value='<s:property value="cmbcurr"/>'>
     <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/></td> --%>
    <td  ><select name="cmbcurr" id="cmbcurr" style="width:73%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select><input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/></td>
    <td width="20%" align="right">Rate
   <input type="text" name="currate" id="currate"  value='<s:property value="currate"/>'></td>
      <td  ><label id="billname">Bill Type</label>&nbsp;<select id="cmbbilltype" name="cmbbilltype"  style="width:13%;" value='<s:property value="cmbbilltype"/>' onchange="gettaxaccounts()">
      <option value="1">ST</option>
      <option value="2">CST</option>
      
      </select>
      <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
    
    
    
    </td>
  </tr>
  <tr>
    <td align="right">Ref. Type</td> 
    <td><select id="cmbreftype" name="cmbreftype" style="width:71%;" onchange="refChange();"  value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
       <option value="CEQ">CEQ</option>
       <!-- <option value="RFQ">RFQ</option> --></select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <%-- <td width="14%"><input type="text" id="txtreftype" name="txtreftype" style="width:85%;" value='<s:property value="txtreftype"/>'/></td> --%>
    <td colspan="2"><div id="se">Ref No
      <input type="text" id="rrefno" name="rrefno" style="width:10%;" readonly placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/>
      <label id="vatype">Vat Type</label><select id="cmbvatype" name="cmbvatype" style="width:13%;" onchange="vatChange();" value='<s:property value="cmbvatype"/>'>
       <option value="inclusive">Inclusive</option>
       <option value="exclusive">Exclusive</option>
       <option value="export">Export</option>
       </select>
      <input type="hidden" id="hidcmbvatype" name="hidcmbvatype" value='<s:property value="hidcmbvatype"/>'/></div></td>
    </tr>
    <tr>
    <td align="right">Del Terms</td>
    <td colspan="2"><input type="text" id="delterms" name="delterms" style="width:61%;" value='<s:property value="delterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="2"><input type="text" id="txtpaymentterms" name="txtpaymentterms" style="width:61%;" value='<s:property value="txtpaymentterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" id="txtdescription" name="txtdescription" style="width:61%;" value='<s:property value="txtdescription"/>'/>
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
    </td>
  </tr>
</table>
</fieldset>

<table width="96%"   > 
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
 
   <td align="center">   <input type="text"      id="uprice"      onkeypress="javascript:return isNumber1 (event);"  onchange="vatSwitch();"  style="text-align: right;"   style="text-align: right;"></td>
 
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

 
 
 


  <td align="center">   <input type="text" id="dispers"  onkeypress="javascript:return isNumber1 (event);"  onchange="vatSwitch();"  style="text-align: right;"  ></td>
<td align="center">   <input type="text" id="dict"  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"   onchange="vatSwitch();"    style="text-align: right;"  ></td>
 <td align="center">   <input type="text" id="amounts" tabindex="-1"     style="text-align: right;" ></td>

 

 <td align="center"> <input type="text" id="taxpers"  tabindex="-1"      style="text-align: right;" ></td>  
 
 <td align="center"> 
 <input type="text" id="taxamounts"   tabindex="-1"   onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>
  <td align="center"> 
 <input type="text" id="taxamountstotal" tabindex="-1"    onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" onblur="funRoundAmt(this.value,this.id);"></td>  
  <td align="center">
     <input type="hidden" id="cleardata">
 &nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
 <td align="center"><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn1"  class="btn" onclick="detailstock()" value="SD" ></td>
 <td align="center"><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn2"  class="btn" onclick="alterprosrch()" value="Alternative Items" ></td>
 </tr>  
   
   </table> 
   </fieldset> 

<fieldset><legend>Product Details</legend>
<div id="quotationDiv"><center><jsp:include page="quotationGrid.jsp"></jsp:include></center></div>   
</fieldset>
 
<div id="hidegrid"   hidden="true"  ><center><jsp:include page="hidegrid.jsp"></jsp:include></center></div>

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
<fieldset><legend>Terms and Conditions</legend>
<table width="100%">
  <tr><td>
    <div id="termsDiv"><jsp:include page="termsGrid.jsp"></jsp:include></div><br/>
  </td></tr>
</table>
</fieldset>
 <%-- <fieldset>
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
<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="txtnettotal" readonly="readonly" id="txtnettotal" value='<s:property value="txtnettotal"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>
</fieldset> --%>



 
<input type="hidden" id="clientcaid" name="clientcaid"  value='<s:property value="clientcaid"/>'/>
<input type="hidden" id="clientcatname" name="clientcatname"  value='<s:property value="clientcatname"/>'/>
<input type="hidden" id="clientpricegroup" name="clientpricegroup"  value='<s:property value="clientpricegroup"/>'/>

<input type="hidden" id="salesmancatid" name="salesmancatid"  value='<s:property value="salesmancatid"/>'/>          <!--    not use -->
<input type="hidden" id="salesmanusgper" name="salesmanusgper"  value='<s:property value="salesmanusgper"/>'/>    <!--    not use -->

 <input type="hidden" id="checkhidegrid" name="checkhidegrid"  value='<s:property value="checkhidegrid"/>'/>


 
 <input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>'/>
 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>          
<input type="hidden" id="enqmasterdocno" name="enqmasterdocno"  value='<s:property value="enqmasterdocno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>'/>
<input type="hidden" id="termsgridlength" name="termsgridlength"  value='<s:property value="termsgridlength"/>'/>
<input type="hidden" id="servgridlen" name="servgridlen"  value='<s:property value="servgridlen"/>'/>
<input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>
 <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
 <input type="hidden" id="rowindexg" name="rowindexg"  value='<s:property value="rowindexg"/>'/>
<input type="hidden" id="hidload" name="hidload"  value='<s:property value="hidload"/>'/>
 <input type="hidden" id="hidsellprice" name="hidsellprice"  value='<s:property value="hidsellprice"/>'/>
 <input type="hidden" id="hidpsrno" name="hidpsrno"  value='<s:property value="hidpsrno"/>'/>
 <label ><span id="stockmsg" style="position:absolute;z-index:1000;right:210px;top:15px;color:#003300;font-weight:bold;font-size: 14px;font-family: Times New Roman, Times, serif;"></span><span id="salelbl" style="position:absolute;z-index:1000;right:50px;top:15px;color:#FF335E;font-weight:bold;font-size: 14px;font-family: Times New Roman, Times, serif;"></span>  </label>
 <input type="hidden" id="totalstock" name="totalstock"  value='<s:property value="totalstock"/>'/>
 <input type="hidden" id="hidqty" name="hidqty"  value='<s:property value="hidqty"/>'/>
  <input type="hidden" id="allowdiscount" name="allowdiscount"  value='<s:property value="allowdiscount"/>'/>
   <input type="hidden" id="pmgt" name="pmgt"  value='<s:property value="pmgt"/>'/>
  <input type="hidden" id="temppsrno" > 
  <input type="hidden" id="tempspecid" >  
 <input type="hidden" id="typeoftaken"> <!-- valuebased -->
 <input type="hidden" id="tax1per"> <!-- first tax % -->
 <input type="hidden" id="tax2per"><!--  sec tax % -->
 <input type="hidden" id="tax3per"><!--  tird tax % -->

</div>
<div id="salespersonwindow">
			<div></div>
			<div></div>
		</div>
</form>
	
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
<div id="accountsearchwindow">
			<div></div>
		</div>	
</div>

  <div id="userwindow">
	   <div ></div>
	</div>
</div>
</body>
</html>
