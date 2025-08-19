<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#txtchqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountWindow').jqxWindow('close');
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		  $('#txtaccid').dblclick(function(){   
		      if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		  }
			  accountsSearchContent('accountSearch.jsp');
		  });
		  $('#txtaccidb').dblclick(function(){
			  bankSearchContent('accountsDetailsSearch.jsp');
			  });
		  
	});
	function getAccType(event){  
        var x= event.keyCode;
        if(x==114){
        	bankSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	function bankSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	function accountsSearchContent(url) {
	    $('#accountWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountWindow').jqxWindow('setContent', data);
		$('#accountWindow').jqxWindow('bringToFront');
	}); 
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
	
	function getAcc(event){
        var x= event.keyCode;
        if(x==114){
		  if($('#cmbtype').val()==''){
    		  $.messager.alert('Message','Please Choose Account Type.','warning');
    		  return 0;
    	  }
      	  accountsSearchContent('accountSearch.jsp');
        }
        else{
         }
        }
	    
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
	} 
	
	function funClearInfo(){         

   	    $('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#cmbtype').val('AR');$('#txtdocno').val('');
   	    $('#txtaccid').val('');$('#txtaccname').val('');$('#cmbsalesperson').val('');
		
		$("#insvndpayGridID").jqxGrid('clear');$("#insvndpayGridID").jqxGrid('addrow', null, {});
		
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		}
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var txtaccid = $('#txtaccid').val();
		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var check=1;
		 if(branchval=="" || branchval=="a"){   
			 $.messager.alert('Message','Please Choose a branch.','warning');  
			 return 0;
		 }
		 if(atype==''){   
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 if(txtaccid==''){   
			 $.messager.alert('Message','Please Choose Account.','warning');
			 return 0;
		 }
		 $("#overlay, #PleaseWait").show();
		 $("#insvndpayDiv").load("insurvendorpaymentGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&check='+check);
		}
		
		function funExportBtn(){  
	 	  	$("#insvndpayDiv").excelexportjs({           
				containerid: "insvndpayDiv",
				datatype: 'json',
				dataset: null,
				gridId: "insvndpayGridID",
				columns: getColumns("insvndpayGridID") ,    
				worksheetName:"VENDOR PAYMENT"  
				});          
	    }
		function funCreate(){ 
			var applyarray=new Array();  
			 var txtaccidb = $('#txtaccidb').val();
			 if(txtaccidb==0){   
				 $.messager.alert('Message','Please Choose Bank Account.','warning');
				 return 0;
				}
	        var rows = $("#insvndpayGridID").jqxGrid('getrows');  
			var selectedrows=$("#insvndpayGridID").jqxGrid('selectedrowindexes');   
			selectedrows = selectedrows.sort(function(a,b){return a - b});

			
			if(selectedrows.length==0){
			  $("#overlay, #PleaseWait").hide();
			  $.messager.alert('Warning','Please select documents.');  
			  return false;
			}
			
			$.messager.confirm('Message', 'Do you want to create BPV?', function(r){      
			 if(r==false)
			  {
			   return false; 
			  }
			 else
			 {
			  $("#overlay, #PleaseWait").show();

				var i=0;
				var j=0;
				var cmnval=0.0;
				var temptrn="";
				var apply
				for (i = 0; i < selectedrows.length; i++) {
					
				if(i==0){
					var cmnv= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "vndbl");
					cmnval+=cmnv;
					 apply= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "vndbl");
					 var id=1;
					 if(apply<0){                                
						 id=-1;
					 }else{
						 id=1;
					 } 
					var tranid= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "tranid");
					temptrn=tranid;
					if(apply<0){
						applyarray.push(apply*id+"::"+0+" :: "+1+" :: "+tranid+" :: "+0);
					}
					}
				else{
					var cmnv= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "vndbl");   
					cmnval+=cmnv;
					 apply= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "vndbl");
					 var id=1;
					 if(apply<0){                                
						 id=-1;
					 }else{
						 id=1;
					 } 
					var tranid= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "tranid");
					temptrn=temptrn+","+tranid;
					if(apply<0){
						applyarray.push(apply*id+"::"+0+" :: "+1+" :: "+tranid+" :: "+0);
					}
					} 
				temptrn1=temptrn+",";  
				j++;   
				
				}
				$('#txtranid').val(temptrn1);
				$('#cmntot').val(cmnval);  
				if(cmnval>0){
					$("#overlay, #PleaseWait").hide();
					 $.messager.alert('Message','Bank Payment cannot be processed','warning');
					 return 0;
				}
				for(i = 0; i < selectedrows.length; i++) {
					 var apply= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "vndbl");
				if(apply>0){
					//alert("insidereturn"+apply);
					applyarray=new Array();
					break;
				}
			 }
				savedata($('#cmntot').val(),$('#txtranid').val(),applyarray);             	
			}
			});  
			}
	  
	  function savedata(cmntot,tranid,applyarray){  
	         var branchval = document.getElementById("cmbbranch").value;
		     var desc=$('#txtdesc').val();	   
		     var gridarray=new Array();             
			 var bacno=$('#txtdocnob').val();	
			 var apacno=$('#txtdocno').val();
			 var pdcacno=$('#txtpdcacno').val();    
			 var txtchqdate=$('#txtchqdate').jqxDateTimeInput('getDate'); 
			 var curdate=new Date();
			 var pdc=0;
			 if(txtchqdate>curdate){  
			   pdc=1;
			 }
			 var id=1;
			 if(cmntot<0){   
				 id=-1;
			 }else{
				 id=1;
			 }   
			 gridarray.push(bacno+"::"+1+" :: "+(1.0)+" :: "+false+" :: "+cmntot*-1*id+" :: "+desc+" :: "+cmntot*-1*id+" :: "+0+" :: "+0+" :: "+0+" :: "+pdc+" :: "+pdcacno);  
			 gridarray.push(apacno+"::"+1+" :: "+(1.0)+" :: "+true+" :: "+cmntot*1*id+" :: "+desc+" :: "+cmntot*1*id+" :: "+0+" :: "+0+" :: "+0+" :: "+pdc+" :: "+pdcacno);
		 	 $('#txtchqname').val(encodeURIComponent($('#txtchqname').val()));
		 	
		 	 var mainarray=new Array();
			 var selectedrows=$("#insvndpayGridID").jqxGrid('selectedrowindexes');  
			 for (i = 0; i < selectedrows.length; i++) {
					 var date= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "date");
					 var transtype= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "transtype");
					 var transno= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "transno");
					 var vndamt= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "vndamt");
					 var vndrvd= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "vndrvd");
					 var vndbl= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "vndbl");
					 var client= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "client");
					 var description= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "description");
					 var netsales= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "netsales");  
					 var netpur= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "netpur");           
					 var profit= $('#insvndpayGridID').jqxGrid('getcellvalue', selectedrows[i], "profit");   
					 mainarray.push(date+"::"+transtype+"::"+transno+"::"+vndamt+"::"+vndrvd+"::"+vndbl+"::"+client+"::"+description+"::"+netsales+"::"+netpur+"::"+profit); 
              }     
		 	
			 var x=new XMLHttpRequest();     
			 x.onreadystatechange=function(){  
			 if (x.readyState==4 && x.status==200)      
			  {
			   var items=x.responseText;
			    if(parseInt(items)>0)        
			     {
			      $.messager.alert('Message',  'BPV'+'-'+items+" "+'Successfully Created.'  );   
			      $('#cmntot').val("");    
			      $('#txtdesc').val(""); 
			      $('#txtchqname').val(""); 
			      $('#txtchqno').val(""); 
			      $('#txtaccidb').val(""); 
			      $('#txtaccnameb').val("");       
			      funreload();           
			}
			else
			{
			$.messager.alert('Message', ' Not Created ');     
			}   
			} 
			}     
			x.open("GET","saveData.jsp?cmntot="+cmntot+"&branchid="+branchval+"&tranid="+tranid+"&desc="+desc+"&chqno="+$('#txtchqno').val()+"&chqdate="+$('#txtchqdate').val()+"&chqname="+$('#txtchqname').val()+"&acno="+$('#txtdocnob').val()+"&gridarray="+gridarray+"&applyarray="+applyarray+"&mainarray="+encodeURIComponent(mainarray),true);  
			x.send();                
			}  
	function getAccounts(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  			    $('#txtpdcacno').val(items);
	  		}
	  		}
	  		x.open("GET", "getAccounts.jsp", true);
	  		x.send();
	 }                             
		
</script>
</head>
<body onload="getBranch();getSalesPerson();getAccounts();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
    <option value="" >--Select--</option><option value="AP">AP</option></select></td></tr>
 
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Sales Person</label></td>
	<td><select id="cmbsalesperson" name="cmbsalesperson" style="width:100%;" value='<s:property value="cmbsalesperson"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/></td></tr>
		 <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">    
	 <fieldset>
	  <legend>BPV Creation</legend>    
	 <table width="100%">
    <tr><td align="right"><label class="branch">Bank</label></td>
	<td align="left"><input type="text" id="txtaccidb" name="txtaccidb" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccidb"/>' onkeydown="getAccType(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccnameb" name="txtaccnameb" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccnameb"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocnob" name="txtdocnob" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtdocnob"/>'/>
    <input type="hidden" id="txtatypeb" name="txtatypeb" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtatypeb"/>'/>
    <input type="hidden" id="txtcuridb" name="txtcuridb" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcuridb"/>'/>
    <input type="hidden" id="txtrateb" name="txtrateb" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtrateb"/>'/>
    <input type="hidden" id="txtcurtypeb" name="txtcurtypeb" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcurtypeb"/>'/></td></tr> 
      
   <tr><td align="right"><label class="branch">Cheque No.</label></td>      
    <td><input type="text" id="txtchqno" name="txtchqno" style="width:100%;height:20px;" value='<s:property value="txtchqno"/>'/></td>
   </tr>    
   <tr>   
	 <td align="right"><label class="branch">Cheque Date</label></td>  
     <td align="left"><div id="txtchqdate" name="txtchqdate" value='<s:property value="txtchqdate"/>'></div></td></tr> 
   <tr><td align="right"><label class="branch">Cheque Name</label></td>      
    <td><input type="text" id="txtchqname" name="txtchqname" style="width:100%;height:20px;" value='<s:property value="txtchqname"/>'/></td>
   </tr>
    <tr><td align="right"><label class="branch">Remarks</label></td>      
    <td><input type="text" id="txtdesc" name="txtdesc" style="width:100%;height:20px;" value='<s:property value="txtdesc"/>'/></td>
   </tr> 
   <tr>
 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btncrtclint" name="btncrtclint" onclick="funCreate();">Create BPV</button></td></tr> 
  </table>       
     </fieldset>   
</td></tr>     
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtacountno" name="txtacountno" style="width:100%;height:20px;" value='<s:property value="txtacountno"/>'/>
	<input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
	<input type="hidden" id="txtranid" name="txtranid" style="width:100%;height:20px;" value='<s:property value="txtranid"/>'/>
	<input type="hidden" id="cmntot" name="cmntot" style="width:100%;height:20px;" value='<s:property value="cmntot"/>'/>
	<input type="hidden" id="txtpdcacno" name="txtpdcacno" value='<s:property value="txtpdcacno"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">                             
		<tr>
			 <td><div id="insvndpayDiv"><jsp:include page="insurvendorpaymentGrid.jsp"></jsp:include></div>
			  </td>    
		</tr>
	</table>
</tr>
</table>
</div>

<div id="accountWindow">
	<div></div><div></div>
</div>
<div id="accountDetailsWindow">           
	<div></div><div></div>
</div>
</div> 
</body>
</html>