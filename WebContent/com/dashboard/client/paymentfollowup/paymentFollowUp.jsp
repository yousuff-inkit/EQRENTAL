<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script> 
<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#uptodate').jqxDateTimeInput({disabled: true});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtclientaccount').dblclick(function(){
			  accountsSearchContent('clientAccountDetailsSearch.jsp');
		 });
		 $('#txtcalculation').val(0);
	});
	
	function checkMultiCurrency() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var multicurrency = parseInt(items[0]);
				$("#hidmulticurrency").val(multicurrency);
			}
		}	
		x.open("GET", "checkMultiCurrency.jsp", true);
		x.send();
	}
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	function getSalesPerson() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesagentItems = items[0].split(",");
				var salesagentIdItems = items[1].split(",");
				var optionssalesagent = '<option value="">--Select--</option>';
				for (var i = 0; i < salesagentItems.length; i++) {
					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
							+ salesagentItems[i] + '</option>';
				}
				$("select#cmbsalesperson").html(optionssalesagent);
				if ($('#hidcmbsalesperson').val() != null) {
					$('#cmbsalesperson').val($('#hidcmbsalesperson').val());
				}
			} else {
			}
		}
		x.open("GET", "getSalesPerson.jsp", true);
		x.send();
	}
  
   function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var categoryItems = items[0].split(",");
				var categoryIdItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < categoryItems.length; i++) {
					optionscategory += '<option value="' + categoryIdItems[i] + '">'
							+ categoryItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionscategory);
				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
			} else {
			}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}
	
	function getClientAccount(event){
       var x= event.keyCode;
       if(x==114){
     	  accountsSearchContent('clientAccountDetailsSearch.jsp');
       }
       else{}
       }
	   
	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
		 $("#followUpDetailsGrid").jqxGrid('clear');
		 $("#followUpDetailsGrid").jqxGrid("addrow", null, {}); 
		 $("#followUpDetailsGrid").jqxGrid({ disabled: true});
	}
	
	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1;
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
		 }
	 }
/* 	function funCalculate(){
				
				var rows2=$('#paymentFollowUp').jqxGrid('getrows');
				var arr2=new Array();
				 for(var i=0;i<rows2.length;i++){
				     	arr2.push(		
				     			$('#paymentFollowUp').jqxGrid('getcellvalue',i,'cldocno')+" :: " //0
				    			 );
				 }	
				 alert(arr2);
				 paymentFollowUpGriGridReload(arr2);
	}
	 */
/* 	function paymentFollowUpGriGridReload(arr2){
		var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   		if (x.readyState==4 && x.status==200)
		   		 {
				      
		  
		   var items = x.responseText.trim();
		   
		   alert(items);
		   
			items = items.split('###');
			var cldocno = items[0];
			var salik = items[1];
			var traffic = items[2];
			var currentrate = items[3];
			 
			
 			var rows2=$('#paymentFollowUp').jqxGrid('getrows');
			 
			 for(var i=0;i<rows2.length;i++){  
			     	 
		 
				$('#paymentFollowUp').jqxGrid('setcellvalue', i, "current",currentrate[i]); 
				$('#paymentFollowUp').jqxGrid('setcellvalue', i, "salik",salik[i]); 
				$('#paymentFollowUp').jqxGrid('setcellvalue', i, "traffic",traffic[i]); 
				
				
			 
			
			 }
			
			
			
		   
		   
		   		 }
		   }
			 
		   
		   
		 x.open("GET","paymentGridReload.jsp?paymentfollowuparray="+arr2+"&check=1",true);
		 x.send();   

	} */
	  	function funCalculate(){
			$("#overlay, #PleaseWait").show();
			$('#txtcalculation').val(1);
			$('#paymentFollowUp').jqxGrid('showcolumn', 'current');
			$('#paymentFollowUp').jqxGrid('showcolumn', 'salik');
			$('#paymentFollowUp').jqxGrid('showcolumn', 'traffic');   
			paymentFollowUpGriGridReload();
			
		}
	function paymentFollowUpGriGridReload(){
		var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   		if (x.readyState==4 && x.status==200)
		   		 {
		   			var items = x.responseText.trim();
		   			var arrayitems=items.split(",");
		   			var rows=$('#paymentFollowUp').jqxGrid('getrows');
		   			/* for(var i=0;i<rows.length;i++){
		   				var temp=arrayitems[i].split("###");
		   				if(rows[i].cldocno==temp[0]){
		   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "current",temp[3]);
		   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "salik",temp[1]);
		   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "traffic",temp[2]);
		   				}
		   				if(i==rows.length-1){
		   					$("#overlay, #PleaseWait").hide();
		   				}
		   			} */
		   			for(var i=0;i<rows.length;i++){
		   				for(var j=0;j<arrayitems.length;j++){
		   					var temp=arrayitems[j].split("###");
			   				if(rows[i].cldocno==temp[0]){
			   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "current",temp[3]);
			   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "salik",temp[1]);
			   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "traffic",temp[2]);
			   				}
			   				if(i==rows.length-1){
			   					$("#overlay, #PleaseWait").hide();
			   				}	
		   				}
		   			}
		   			
		   		 }
		   		
		   }
		 x.open("GET","paymentGridReload.jsp",true);
		 x.send();   
	}
	
	function funreload(event){ 
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var clientaccount = $('#txtclientaccountdocno').val();
		 var chkfollowup = $('#hidchckfollowup').val();
		 var followupdate = $('#followupdate').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var amtrangefrm = $('#txtamtrangefrom').val();
		 var amtrangeto = $('#txtamtrangeto').val();
		 var clientstatus = $('#cmbclientstatus').val();
		 var configval = $("#hidconfigval").val();
		 $("#overlay, #PleaseWait").show();
		 if(parseInt(configval)==1){   
			 $("#ageingStatementDueDateDiv").load("ageingStatementDueDateGrid.jsp?clientaccount="+clientaccount+'&branchval='+branchval+'&uptodate='+uptodate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate+'&salesperson='+salesperson+'&category='+category+'&amtrangefrm='+amtrangefrm+'&amtrangeto='+amtrangeto+'&clientstatus='+clientstatus+'&check=1');
		 }else{
			 $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?clientaccount="+clientaccount+'&branchval='+branchval+'&uptodate='+uptodate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate+'&salesperson='+salesperson+'&category='+category+'&amtrangefrm='+amtrangefrm+'&amtrangeto='+amtrangeto+'&clientstatus='+clientstatus+'&check=1');
		 }
		}
	
	function funUpdate(event){
		var process = $('#cmbprocess').val();
		var processname = $("#cmbprocess option:selected").text().trim();
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var remarks = $('#txtremarks').val();
		var docno = $('#txtdocno').val();
		var accountno = $('#txtacountno').val();
		var cldocno = $('#txtcldocno').val();
		
		if(process==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }

		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(process,processname,date,branchid,docno,accountno,remarks,cldocno);	
		     	}
		});
	}
	
	function funOutStandingStatement(){
		 var accno = $('#txtacountno').val();
		 if(accno==''){
			 $.messager.alert('Message','Please Choose a Client.','warning');
			 return 0;
		 }
		
   	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("paymentFollowUp.jsp");
	        $("#txtacountno").prop("disabled", false);
	        var configval = $("#hidconfigval").val();
			if(parseInt(configval)==1){   
				 var win= window.open("printAgeingOutstandingStatementDueDate?atype=AR&acno="+document.getElementById("txtacountno").value+'&level1from='+0+'&level1to='+30+'&level2from='+31+'&level2to='+60+'&level3from='+61+'&level3to='+90+'&level4from='+91+'&level4to='+120+'&level5from='+121+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				 win.focus();    
			}else{
				 var reurl=url.split("paymentFollowUp.jsp");
				 var win= window.open(reurl[0]+"printOutstandingsStatement?atype=AR&acno="+document.getElementById("txtacountno").value+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			     win.focus(); 
			 }	
	       
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
	   }
	
	function funRAWiseBalance(){
		 var accno = $('#txtacountno').val();
		 
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client.','warning');
			 return 0;
		 }
		
  	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("paymentFollowUp.jsp");
	        $("#txtacountno").prop("disabled", false);
			
	        var win= window.open(reurl[0]+"printRAWiseBalance?atype=AR&acno="+document.getElementById("txtacountno").value+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
	   }
	
	function funSendingEmail() {  
	    var email = document.getElementById("txtclientaccountemail").value;
	    var res;var part1;var part2;var dotsplt;
	    if(email.indexOf("@")>=0) {
		    res = email.split('@');
		    part1=res[0];
		    part2=res[1];
		    dotsplt=part2.split('.');
	    }
	    
	   if ($("#txtacountno").val().trim()=="" || typeof($("#txtacountno").val().trim())=="undefined" || typeof($("#txtacountno").val().trim())=="NaN") {
		    $('#txtacountno').val('');
		    $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
	  } else  if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.indexOf("@")<0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.split('@').length!=2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.length==0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.split(" ").length>2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(part2.split(".").length<2) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(dotsplt[0].length==0 ) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else {
 		
		    $("#overlay, #PleaseWait").show();
		   
	 		$.ajaxFileUpload ({  
	    	    	
	    	    	  url: 'printOutstandingsStatement.action?acno='+document.getElementById("txtacountno").value+'&atype=AR&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("txtbranch").value+'&uptoDate='+$("#uptodate").val()+'&email='+$('#txtclientaccountemail').val()+'&print=0',  
	    	          secureuri:false,//false  
	    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
	    	          dataType: 'string',// json  
	    	          success: function (data, status) {  
	
	    	             if(status=='success'){
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Message','E-Mail Send Successfully');
	    	              }
	    	             if(status=='error'){
	    	            	 $("#overlay, #PleaseWait").hide();
	    	            	 $.messager.alert('Message','E-Mail Sending failed');
	    	             }
	    	             
	    	              $("#testImg").attr("src",data.message);
	    	              if(typeof(data.error) != 'undefined')  
	    	              {  
	    	                  if(data.error != '')  
	    	                  {  
	    	                      alert(data.error);  
	    	                  }else  
	    	                  {  
	    	                      alert(data.message);  
	    	                  }  
	    	              }  
	    	          },  
	    	           error: function (data, status, e)
	    	          {  
	    	              alert(e);  
	    	          }  
	    	      }) 
	    	     return false;
 		
		  } 
      }
	    
	function saveGridData(process,processname,date,branchid,docno,accountno,remarks,cldocno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				
				$('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtbranch').val('');
				$('#txtremarks').val('');
				$('#txtdocno').val('');
				$('#txtacountno').val('');
				$('#txtcldocno').val('');
				$('#cmbclientstatus').val('');
				$('#txtclientaccount').val('');
				$('#txtclientname').val('');
				$('#txtclientaccountdocno').val('');
				
				if (document.getElementById("txtclientaccount").value == "") {
			        $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); 
			    }
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
				disable();
				}
		}
			
	x.open("GET","saveData.jsp?process="+process+"&processname="+processname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&accountno="+accountno+"&remarks="+remarks+"&cldocno="+cldocno,true);
	x.send();
			
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(dataExcelExport, 'PaymentFollowUp', true);
		 } else {
			 $("#paymentFollowUp").jqxGrid('exportdata', 'xls', 'PaymentFollowUp');
		 }
	}
	
	function getRawiseConfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var method = x.responseText;
				if(method==0){
					document.getElementById("rawisebtndiv").style.display="none";
				}
			} else {
			}
		}
		x.open("GET", "getRawiseConfig.jsp", true);
		x.send();
	}
	function getSmsConfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var method = x.responseText;
				if(method==0){
					document.getElementById("smsdiv").style.display="none";
				}
			} else {
			}
		}
		x.open("GET", "getPfsmsConfig.jsp", true);
		x.send();
	}
	
	
	function funSendSms() {  
		var brhid=document.getElementById("txtbranch").value;
		var dtype="";
		var pdocno=document.getElementById("txtdocno").value;
		var mobno=document.getElementById("txtmobno").value;
		
			if($('#txtdocno').val()=="" || $('#txtdocno').val()=="Null"){
				$.messager.alert("warning","Please select a Document");
				return false;
			}  
		    
	 		    //alert("inside SMS");
			    $("#overlay, #PleaseWait").show();
			   
		 		$.ajaxFileUpload ({  
		    	    	
		    	    	  url:"sendPaymentSms?brhid="+brhid+"&docno="+pdocno+"&dtype="+dtype+"&mobno="+mobno,  
		    	          secureuri:false,//false  
		    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
		    	          dataType: 'string',// json  
		    	          success: function (data, status) {  
		
		    	             if(status=='success'){
								$("#overlay, #PleaseWait").hide();
								$.messager.alert('Message','SMS Send Successfully');
		    	              }
		    	             if(status=='error'){
		    	            	 $("#overlay, #PleaseWait").hide();
		    	            	 $.messager.alert('Message','SMS Sending failed');
		    	             }
		    	             
		    	          },  
		    	           error: function (data, status, e)
		    	          {  
		    	              alert(e);  
		    	          }  
		    	      }) 
		    	     return false;
	      }
	
	function getGridConfig() {  
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var method = x.responseText.trim(); 
				$("#hidconfigval").val(method);  
				if(method!=1){
					 $("#payementid").show();
					 $("#ageingdueid").hide();
				}else{
					 $("#payementid").hide();
					 $("#ageingdueid").show();  
				}
			} else {
			}
		}
		x.open("GET", "getGridConfig.jsp", true);    
		x.send();
	}
	
</script>
</head>
<body onload="getBranch();getProcess();disable();getSalesPerson();getCategory();followupcheck();getRawiseConfig();getSmsConfig();getGridConfig();checkMultiCurrency();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td align="right"><label class="branch">Up To</label></td> 
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
     <tr><td align="right"><label class="branch">Client</label></td>
	 <td align="left"><input type="text" id="txtclientaccount" name="txtclientaccount" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientaccount"/>' onkeydown="getClientAccount(event);"/></td></tr>
	 <tr><td colspan="2"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtclientname"/>'/>
	 <input type="hidden" id="txtclientaccountdocno" name="txtclientaccountdocno" style="width:100%;height:20px;" value='<s:property value="txtclientaccountdocno"/>'/>
	 <input type="hidden" id="txtclientaccountemail" name="txtclientaccountemail" value='<s:property value="txtclientaccountemail"/>'/></td></tr>
	 <tr><td colspan="2"><input type="checkbox" id="chckfollowup" name="chckfollowup" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                 <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/></td></tr>
     <tr><td align="right"><label class="branch">FollowUp</label></td>
     <td align="left"><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td></tr>
	 <tr><td align="right"><label class="branch">Sales Person</label></td>
	   <td><select id="cmbsalesperson" name="cmbsalesperson" style="width:100%;" value='<s:property value="cmbsalesperson"/>'>
       <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Category</label></td>
	 <td><select id="cmbcategory" name="cmbcategory" style="width:100%;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Amount Range</label></td>
	 <td align="left"><input type="text" id="txtamtrangefrom" name="txtamtrangefrom" style="width:40%;height:20px;text-align: right;" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangefrom"/>'/>&nbsp;-&nbsp;
	 <input type="text" id="txtamtrangeto" name="txtamtrangeto" style="width:40%;height:20px;text-align: right;" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangeto"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Client Status</label></td>
	 <td><select id="cmbclientstatus" name="cmbclientstatus" style="width:100%;" value='<s:property value="cmbclientstatus"/>'>
       <option value="">--Select--</option><option value="1">On Hire</option><option value="2">Off Hire</option><option value="3">On Hire Litigation</option><option value="4">Off Hire Litigation</option>
      <option value="5">On Hire Dispute</option><option value="6">Off Hire Dispute</option><option value="7">Bad Debts</option><option value="8">Frequent Defaulter</option></select></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess"  value='<s:property value="cmbprocess"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnIndividual" name="btnIndividual" onclick="funOutStandingStatement();">Outstanding Statement</button>
	 <div id="rawisebtndiv"><button class="myButton" type="button" id="btnRAWiseBalance" name="btnRAWiseBalance" onclick="funRAWiseBalance();">RA Wise Balance</button></div></td></tr>
	 <tr><td colspan="2" align="center"><div id="smsdiv"><button class="myButton" type="button" id="btnsms" name="btnsms" onclick="funSendSms(event);">Send SMS</button></div></td></tr>
	 <tr><td colspan="2"><input type="hidden" id="txtacountno" name="txtacountno" style="width:100%;height:20px;" value='<s:property value="txtacountno"/>'/>
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtmobno" name="txtmobno" style="width:100%;height:20px;" value='<s:property value="txtmobno"/>'/>
     <input type="hidden" id="txtcldocno" name="txtcldocno" style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'/> 
     <input type="hidden" id="txtcalculation" name="txtcalculation" style="width:100%;height:20px;" value='<s:property value="txtcalculation"/>'/>
     <input type="hidden" id="hidconfigval" name="hidconfigval"/>
       <input type="hidden" id="hidmulticurrency" name="hidmulticurrency" value='0'/></td></tr>
	 
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">  
		<tr id="payementid"><td><div id="paymentFollowUpDiv"><jsp:include page="paymentFollowUpGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr id="ageingdueid"><td><div id="ageingStatementDueDateDiv"><jsp:include page="ageingStatementDueDateGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
</div>

<div id="accountDetailsWindow">
	<div></div>
</div>
</div> 
</body>
</html>