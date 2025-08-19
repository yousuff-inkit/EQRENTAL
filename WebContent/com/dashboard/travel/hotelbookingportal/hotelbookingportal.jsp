<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">     
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<link href="../../../../css/latextheme.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">
.icon {
	width: 2.5em;        
	height: 2em;
	border: none;
	background-color: #ECF8E0;
}
</style>
<script type="text/javascript">        
           
	$(document).ready(function () {            
		 $('#txtage1').hide(); $('#txtage2').hide(); $('#txtage3').hide(); $('#txtage4').hide(); $('#txtage5').hide(); $('#txtage6').hide();
		 $('#age1').hide(); $('#age2').hide(); $('#age3').hide(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();      
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 $('#txtroom').attr('readonly', true);
		 $('#jqxrtype').attr('readonly', true);	 
		 document.getElementById("rsumm").checked = true;
		 document.getElementById('txtclienttype').value="1";
		 $('#txtclient').attr('disabled', true);

		 //var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 //var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	     //$('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		 $('#todate').on('change', function (event) {  
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
			  // out date
			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
			 	 
			   if(fromdates>todates){
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				   $('#todate').jqxDateTimeInput('setDate', new Date(fromdates));    
			       return false;
			  }   
		 });
		 $('#fromdate').on('change', function (event) {  
				
			   var curdates=new Date();  
			 
			  // out date
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate')); //del date
			 	 
			   if(fromdates<curdates){
				   $.messager.alert('Message','From Date Less Than Current Date  ','warning');
				   var fromdates=new Date();   
				   $('#fromdate').jqxDateTimeInput('setDate', new Date(fromdates));    
			       return false;
			  }   
		 });
		 if($("#msg").val()=="Successfully Saved" || $("#msg").val()=="Not Saved") { 
			 $.messager.alert('Message',$('#msg').val());
		}
	}); 
	function roomSearchContent(url) {
		 $.get(url).done(function (data) {
		$('#roomsearchwndow').jqxWindow('open');  
		$('#roomsearchwndow').jqxWindow('setContent', data);

	}); 
	}
	function funSearch(){
		 var txtage1 = document.getElementById("txtage1").value;
		 var txtage2 = document.getElementById("txtage2").value;
		 var txtage3 = document.getElementById("txtage3").value;
		 var txtage4 = document.getElementById("txtage4").value;
		 var txtage5 = document.getElementById("txtage5").value;
		 var txtage6 = document.getElementById("txtage6").value;
	     var locid = document.getElementById("locid").value;
		 var nationid = document.getElementById("nationid").value; 
		 var hotelid = document.getElementById("hotelid").value;
		 var txtpax = document.getElementById("txtpax").value;
		 var txtchild = document.getElementById("txtchild").value;
		 var txtrtype = document.getElementById("roomid").value;     
		 var fromdate = $('#fromdate').val(); 
		 var todate = $('#todate').val(); 
		 document.getElementById('hidcalc').value="0";   
		 $("#overlay, #PleaseWait").show();            
		 $("#bookingDiv").load("hotelbookingGrid.jsp?hotelid="+$('#hotelid').val()+"&locid="+locid+"&nationid="+nationid+"&pax="+txtpax+"&child="+txtchild+"&rtype="+txtrtype+"&fromdate="+fromdate+"&todate="+todate+"&child1="+txtage1+"&child2="+txtage2+"&child3="+txtage3+"&child4="+txtage4+"&child5="+txtage5+"&child6="+txtage6+"&check="+1);  
 	}
	function funload(hotelid,roomid){ 
   	 document.getElementById('hidcalc').value="1";  
   	 var txtage1 = document.getElementById("txtage1").value;
		 var txtage2 = document.getElementById("txtage2").value;
		 var txtage3 = document.getElementById("txtage3").value;
		 var txtage4 = document.getElementById("txtage4").value;
		 var txtage5 = document.getElementById("txtage5").value;   
		 var txtage6 = document.getElementById("txtage6").value;       
   	 $("#overlay, #PleaseWait").show();           
		 $("#subDiv").load("subGrid.jsp?hotelid="+hotelid+"&roomid="+roomid+"&child1="+txtage1+"&child2="+txtage2+"&child3="+txtage3+"&child4="+txtage4+"&child5="+txtage5+"&child6="+txtage6+"&check="+1);  
   }
	function chkadvanceChange()
	{
		 var chkadvance=document.getElementById("chkadvance").value;
			 if(chkadvance==1){
				 $('#txtroom').attr('readonly', false);  
				 $('#jqxrtype').attr('readonly', false);	 
			 }
			 else{  
				 $('#txtroom').attr('readonly', true);   
				 $('#jqxrtype').attr('readonly', true);	 
			 }
	}
	 function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
		        return false;
		    return true;
		}
	function funchildcheck(){  
	 var child=$('#txtchild').val();        
	 if(child==0){               
		 $('#txtage1').val('');$('#txtage2').val('');$('#txtage3').val('');$('#txtage4').val('');$('#txtage5').val('');$('#txtage6').val('');
		 $('#txtage1').hide();$('#txtage2').hide();$('#txtage3').hide();$('#txtage4').hide();$('#txtage5').hide();$('#txtage6').hide();
		 $('#age1').hide(); $('#age2').hide(); $('#age3').hide(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
	 }else if(child==1){  
		 $('#txtage2').val('');$('#txtage3').val('');$('#txtage4').val('');$('#txtage5').val('');$('#txtage6').val('');
		 $('#txtage1').show();$('#txtage2').hide();$('#txtage3').hide();$('#txtage4').hide();$('#txtage5').hide();$('#txtage6').hide();
		 $('#age1').show(); $('#age2').hide(); $('#age3').hide(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
	 }else if(child==2){
		 $('#txtage3').val('');$('#txtage4').val('');$('#txtage5').val('');$('#txtage6').val('');
		 $('#txtage1').show();$('#txtage2').show();$('#txtage3').hide();$('#txtage4').hide();$('#txtage5').hide();$('#txtage6').hide();
		 $('#age1').show(); $('#age2').show(); $('#age3').hide(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
	 }else if(child==3){
		 $('#txtage4').val('');$('#txtage5').val('');$('#txtage6').val('');
		 $('#txtage1').show();$('#txtage2').show();$('#txtage3').show();$('#txtage4').hide();$('#txtage5').hide();$('#txtage6').hide();
		 $('#age1').show(); $('#age2').show(); $('#age3').show(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
	 }else if(child==4){
		 $('#txtage5').val('');$('#txtage6').val('');
		 $('#txtage1').show();$('#txtage2').show();$('#txtage3').show();$('#txtage4').show();$('#txtage5').hide();$('#txtage6').hide();
		 $('#age1').show(); $('#age2').show(); $('#age3').show(); $('#age4').show(); $('#age5').hide(); $('#age6').hide();    
	 }else if(child==5){
		 $('#txtage6').val('');
		 $('#txtage1').show();$('#txtage2').show();$('#txtage3').show();$('#txtage4').show();$('#txtage5').show();$('#txtage6').hide();
		 $('#age1').show(); $('#age2').show(); $('#age3').show(); $('#age4').show(); $('#age5').show(); $('#age6').hide();  
	 }else if(child>=6){                      
		 $('#txtage1').show();$('#txtage2').show();$('#txtage3').show();$('#txtage4').show();$('#txtage5').show();$('#txtage6').show();
		 $('#age1').show(); $('#age2').show(); $('#age3').show(); $('#age4').show(); $('#age5').show(); $('#age6').show();
	 }
	}
    function getLocation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {  
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				brchIdItems = items[0].split(",");
				brchItems = items[1].split(",");
				var optionsbrch;// = '<option value="">--Select--</option>';
				for (var i = 0; i < brchItems.length; i++) {
					optionsbrch += '<option value="' + brchIdItems[i] + '">'
							+ brchItems[i] + '</option>';
				}
				$("select#cmblocation").html(optionsbrch);
				
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","getLocation.jsp", true);   
		x.send();
	}
    function funCalc(){    
		var rows = $("#jqxhotelbook").jqxGrid('getrows');  

		var selectedrows=$("#jqxhotelbook").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Please select documents.');
				return false;
		  }
			$.messager.confirm('Message', 'Do you want to calculate?', function(r){
			if(r==false)
			{
				return false; 
			}
			else
			{
			var i=0,j=0;   
			var temprid="",tempdocno="";             
			for (i = 0; i < selectedrows.length; i++) {   
	
			if(i==0){      
				var bdocno= $('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "hotelid").split(' ');
				tempdocno=bdocno;   
			    var broomid= $('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "roomid").split(' ');
			    temprid=broomid;   
			}  
			else{  
				var bdocno= $('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "hotelid").split(' ');
				tempdocno=tempdocno+","+bdocno;  
				var broomid= $('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "roomid").split(' ');
				temprid=temprid+","+broomid;
			}
				temptrno1=tempdocno+","; 
				temptrno2=temprid+",";    
				j++; 
			}
			$('#bdocno').val(temptrno1);
			$('#broomid').val(temptrno2);
			funload($('#bdocno').val(),$('#broomid').val());
			}
			});
		} 
    
    function funcheck(){    
	     document.getElementById('client').value="";
	     document.getElementById('txtclient').value="";
	     document.getElementById('txtmob').value="";
	     document.getElementById('txtemail').value=""; 
	     document.getElementById('jqxClient').value=""; 
		 if (document.getElementById('rsumm').checked) {   
				$('#jqxClient').attr('disabled', false);
				$('#txtclient').attr('disabled', true);
				document.getElementById('txtclienttype').value="1";
        }   
		 else if (document.getElementById('rdet').checked) {    
				$('#jqxClient').attr('disabled', true);
				$('#txtclient').attr('disabled', false);
				document.getElementById('txtclienttype').value="2";
		 } 
  }    
	function funSave(){
		var chk=document.getElementById('hidcalc').value; 
		if(chk!="1"){  
			$.messager.alert('Warning','Please calculate before save.');
			return false;
	    }
		       $("#overlay, #PleaseWait").show();
			   var rows = $("#jqxpricedet").jqxGrid('getrows');
			   var rowindex=0;
			   for(var i=0;i<rows.length;i++){    
				  		newTextBox = $(document.createElement("input"))
					       .attr("type", "dil")
					       .attr("id", "test"+i)
					       .attr("name", "test"+i)      
					       .attr("hidden", "true");
				   newTextBox.val(rows[i].basic+"::"+rows[i].exbed+" :: "+rows[i].child+" :: "+rows[i].teenage+" :: "+rows[i].total+" :: "+rows[i].hotelid+" :: "+rows[i].roomid+" :: ");  
				   newTextBox.appendTo('form');                        
				   rowindex++;
				   $('#gridlength').val(rowindex);         
			   }
			   document.getElementById("mode").value="A";           
			   document.getElementById("frmhotelbooking").submit();     
	}
	function funClear(){
		   document.getElementById("locid").value=""; 
		   document.getElementById("nationid").value=""; 
		   document.getElementById("hotelid").value=""; 
		   document.getElementById("txtpax").value=""; 
		   document.getElementById("txtchild").value="0";   
		   document.getElementById("txtage1").value=""; 
		   document.getElementById("txtage2").value=""; 
		   document.getElementById("txtage3").value=""; 
		   document.getElementById("txtage4").value=""; 
		   document.getElementById("txtage5").value=""; 
		   document.getElementById("txtage6").value=""; 
		   document.getElementById("txtroom").value=""; 
		   document.getElementById("roomid").value=""; 
		   document.getElementById("jqxhotel").value=""; 
		   document.getElementById("jqxloc").value=""; 
		   document.getElementById("jqxnation").value=""; 
		   document.getElementById("jqxrtype").value=""; 
		   document.getElementById("txtclient").value=""; 
		   document.getElementById("txtemail").value=""; 
		   document.getElementById("txtmob").value=""; 
		   document.getElementById("jqxClient").value=""; 
			$('#jqxhotelbook').jqxGrid('clear');   
			$('#jqxpricedet').jqxGrid('clear');
			funchildcheck();
	}
</script>
</head>
<body onload="getLocation();">
<div id="mainBG" class="homeContent" data-type="background">                  
<form id="frmhotelbooking" action="saveHotelBooking" method="post" autocomplete="off">   
<div class='hidden-scrollbar'>
<table width="100%" style="background: #ECF8E0;">                                
	 <tr> 
	  <td align="right"><label class="branch" id="loclabel">Location</label></td>
	  <td align="left"><div id="branchdiv"><select id="cmblocation" name="cmblocation"  value='<s:property value="cmblocation"/>'></select></div>
      <input type="hidden" id="hidcmblocation" name="hidcmblocation" value='<s:property value="hidcmblocation"/>'/></td>
	  <td align="right" width="5%"><label class="branch">From</label></td>        
      <td align="left"  width="5%"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
 	  <td align="right"><label class="branch">To</label></td>  
      <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
      <td align="right"><label class="branch">Area</label></td>          
	  <td align="left"><div id="txtloc" onkeydown="return (event.keyCode!=13);"><jsp:include page="locationSearch.jsp"></jsp:include></div>
      <input type="hidden" name="locid" id="locid" readonly  class="filters"></td>
	  <td align="right"><label class="branch">Nationality</label></td>         
	  <td align="left"><div id="txtnation" onkeydown="return (event.keyCode!=13);"><jsp:include page="nationSearch.jsp"></jsp:include></div>
      <input type="hidden" name="nationid" id="nationid" readonly  class="filters"></td>
      <td align="right"><label class="branch">Hotel</label></td>         
	  <td align="left"><div id="txthotel" onkeydown="return (event.keyCode!=13);"><jsp:include page="hotelSearch.jsp"></jsp:include></div>  
      <input type="hidden" name="hotelid" id="hotelid" readonly  class="filters"></td>
     </tr>    
     <tr>   
      <td colspan="12">&nbsp;<label class="branch">No.Of Pax</label>
	  <input type="text" id="txtpax" name="txtpax" onkeypress="return isNumberKey(event)" style="width:7%;height:20px;text-align: right;" value='<s:property value="txtpax"/>'/>
      &nbsp;&nbsp;&nbsp;<label class="branch">Child</label>                     
	  <input type="text" id="txtchild" name="txtchild" onkeypress="return isNumberKey(event)" onchange="funchildcheck();" style="width:7%;height:20px;text-align: right;" value='<s:property value="txtchild"/>'/> 
	  &nbsp;&nbsp;&nbsp;<label id="age1" class="branch">Child1 Age</label>            
	  <input type="text" id="txtage1" name="txtage1" onkeypress="return isNumberKey(event)" style="width:7%;height:20px;text-align: right;" value='<s:property value="txtage1"/>'/>
      &nbsp;&nbsp;&nbsp;<label id="age2" class="branch">Child2 Age</label>           
	  <input type="text" id="txtage2" name="txtage2" onkeypress="return isNumberKey(event)" style="width:7%;height:20px;text-align: right;" value='<s:property value="txtage2"/>'/>
      &nbsp;&nbsp;&nbsp;<label id="age3" class="branch">Child3 Age</label>          
	  <input type="text" id="txtage3" name="txtage3" onkeypress="return isNumberKey(event)" style="width:7%;height:20px;text-align: right;" value='<s:property value="txtage3"/>'/>
      &nbsp;&nbsp;&nbsp;<label id="age4" class="branch">Child4 Age</label>           
	  <input type="text" id="txtage4" name="txtage4" onkeypress="return isNumberKey(event)" style="width:7%;height:20px;text-align: right;" value='<s:property value="txtage4"/>'/> 
      &nbsp;&nbsp;&nbsp;<label id="age5" class="branch">Child5 Age</label>            
	  <input type="text" id="txtage5" name="txtage5" onkeypress="return isNumberKey(event)" style="width:7%;height:20px;text-align: right;" value='<s:property value="txtage5"/>'/>
      &nbsp;&nbsp;&nbsp;<label id="age6" class="branch">Child6 Age</label>             
	  <input type="text" id="txtage6" name="txtage6" onkeypress="return isNumberKey(event)" style="width:7%;height:20px;text-align: right;" value='<s:property value="txtage6"/>'/></td>
     </tr>      
     <tr>  
       <td align="right"><input type="checkbox" name="chkadvance" id="chkadvance" value='<s:property value="chkadvance" />' onclick="$(this).attr('value', this.checked ? 1 : 0);"  onchange="chkadvanceChange();"></td> 
	   <td><label class="branch">Advance</label></td>  
	   <td align="right"><label class="branch">Room</label></td>    
	   <td align="left"><input type="text" id="txtroom" name="txtroom" style="width:100%;height:20px;" value='<s:property value="txtroom"/>'/></td>                  
       <td align="right"><label class="branch">Room Type</label></td>         
	   <td align="left"><div id="txtrtype" onkeydown="return (event.keyCode!=13);"><jsp:include page="roomTypeSearch.jsp"></jsp:include></div>
       <input type="hidden" name="roomid" id="roomid" readonly  class="filters"></td>
       <td align="right" colspan="6"><button type="button"  class="icon" name="btnclear" id="btnclear" title="Clear" onclick="funClear();"><img alt="clearDocument" src="<%=contextPath%>/icons/attachdelete.png"></button><button type="button"  class="icon" name="btnsearch" id="btnsearch" title="Search" onclick="funSearch();"><img alt="searchDocument" src="<%=contextPath%>/icons/search_new.png"></button></td> 
	  </tr>  
	</table>  
	<table width="100%" style="background: #ECF8E0;">
		<tr> 
	     <td><div id="bookingDiv"><jsp:include page="hotelbookingGrid.jsp"></jsp:include></div></td>
	   </tr>
	   <tr>
	     <td align="right"><button type="button" name="btncalc" id="btncalc" class="icon" onclick="funCalc();" title="Calculate"><img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png"></button></td>
	   	</tr>
	   	<tr> 
	     <td><div id="subDiv"><jsp:include page="subGrid.jsp"></jsp:include></div></td>
	   </tr>
	</table>          
    <table width="100%" style="background: #ECF8E0;">     
       <tr>             
		    <td align="left" width="9%"><input type="radio" id="rsumm" name="stkled" onchange="funcheck();" value="rsumm">  
		    <label class="branch">Existing Client</label></td> 
            <td align="right" width="9%"><label class="branch">Client</label></td>      
		    <td align="left"><div id="client" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearch.jsp"></jsp:include></div>
	        <input type="hidden" name="hidclient" id="hidclient">
	        <input type="hidden" name="hidname" id="hidname"></td>      
	   </tr> 
		<tr>    
		    <td align="left" width="9%"><input type="radio" id="rdet" name="stkled" onchange="funcheck();" value="rdet">          
		    <label class="branch">New Client</label></td> 	 
			<td align="right" width="9%"><label class="branch">Client</label></td>        
		    <td align="left"><input type="text" id="txtclient" name="txtclient"  placeholder="Enter Client"  style="width:73%;height:20px;"/></td> 
	   </tr> 
	   <tr>    
			<td>&nbsp;</td>    
		    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="branch">Mobile</label>
		    <input type="text" id="txtmob" name="txtmob"  placeholder="Enter Mobile" onkeypress="return isNumberKey(event)" style="width:30%;height:20px;"/>
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="branch">Email</label>
		    <input type="text" id="txtemail" name="txtemail"  placeholder="Enter Email"  style="width:30%;height:20px;"/></td>      
		</tr>    
      <tr>              
	        <td align="right" colspan="3"><button class="icon" type="button" name="btnsave" id="btnsave" onclick="funSave();" title="Save"><img alt="saveChanges" src="<%=contextPath%>/icons/save_new.png"></button></td>
	   </tr>
    </table>
     <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>             
     <input type="hidden" id="hidcalc" name="hidcalc" value='<s:property value="hidcalc"/>'/>           
     <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>    
     <input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>  
     <input type="hidden" id="bdocno" name="bdocno" value='<s:property value="bdocno"/>'/>
     <input type="hidden" id="broomid" name="broomid" value='<s:property value="broomid"/>'/>
     <input type="hidden" id="txtclienttype" name="txtclienttype" value='<s:property value="txtclienttype"/>'/>
</div>
</form>
</div> 
</body>
</html>