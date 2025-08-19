
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   $('#salesmanwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#salesmanwindow').jqxWindow('close');
	   $('#lpowindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'MRA NO Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#lpowindow').jqxWindow('close');
	   
	   
	   $('#catwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#catwindow').jqxWindow('close');
	   
	   
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	   
	
	   
	   $('#clientname').dblclick(function(){
	  	    $('#clientwindow').jqxWindow('open');
	   
	       clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
      });
	   
	   
	   $('#catname').dblclick(function(){
	  	    $('#catwindow').jqxWindow('open');
	   
	       catnameSearchContent('categorysearch.jsp?', $('#catwindow'));  
     });
	    
	   
	   
	   
	    $('#fleet').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
       });
	    $('#salesman').dblclick(function(){
	  	    $('#salesmanwindow').jqxWindow('open');
	   
	       salesmanSearchContent('salesmansearch.jsp?', $('#salesmanwindow')); 
       });
	   /*  $('#lpo').dblclick(function(){
	  	    $('#lpowindow').jqxWindow('open');
	   
	  	  lpoSearchContent('lposearch.jsp?', $('#lpowindow')); 
       }); */
	    
	   
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
});
function funExportBtn(){
	   //$("#detailsgrid").jqxGrid('exportdata', 'xls', 'Rental List');
	   
	   
		 JSONToCSVCon(dataildata, 'Lease PO Number', true);
	 }
	 
 
function getclcat(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#catwindow').jqxWindow('open');
	  catnameSearchContent('categorysearch.jsp?', $('#catwindow'));    }
	 else{
		 }
	 } 
	 
	 
function catnameSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#catwindow').jqxWindow('open');
		$('#catwindow').jqxWindow('setContent', data);

	}); 
	}  
function getsalesman(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#salesmanwindow').jqxWindow('open');


	salesmanSearchContent('salesmansearch.jsp?', $('#salesmanwindow'));    }
	 else{
		 }
	 } 
function salesmanSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#salesmanwindow').jqxWindow('open');
		$('#salesmanwindow').jqxWindow('setContent', data);

	}); 
	} 
/* function getlpo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#lpowindow').jqxWindow('open');


	  lpoSearchContent('lposearch.jsp?', $('#lpowindow'));    }
	 else{
		 }
	 } 
function lpoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#lpowindow').jqxWindow('open');
		$('#lpowindow').jqxWindow('setContent', data);

	}); 
	}  */
function getfleet(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');


	 fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
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
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientwindow').jqxWindow('open');


	 clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }
	 else{
		 }
	 } 
function clientSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 
function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val(); 
	   $("#overlay, #PleaseWait").show();
	   
	  $("#detlist").load("detailedGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&salesmandoc="+document.getElementById("salesmandoc").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+'&outchk='+$("#outchks").val()+'&inchk='+$("#inchks").val()+'&catid='+$("#catid").val());
	
		   }
	}
function getrentaltype() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			var rentaltype  = items.split(",");
			var optionsrental = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < rentaltype.length; i++) {
				optionsrental += '<option value="' + rentaltype[i].trim() + '">'
						+ rentaltype[i] + '</option>';
			}
			$("select#rentaltype").html(optionsrental);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getrentaltypes.jsp", true);
	x.send();
}




function  funcleardata()
{
	
	document.getElementById("catid").value="";
	document.getElementById("cldocno").value="";
	document.getElementById("salesmandoc").value="";
	
	

	
	
	document.getElementById("salesman").value="";
	document.getElementById("salesmandoc").value="";
	document.getElementById("fleet").value="";
	document.getElementById("clientname").value="";
	document.getElementById("rentaltype").value="";
	document.getElementById("status").value="";
	document.getElementById("catname").value="";
	//document.getElementById("salesman_txt").value="";
	document.getElementById("ra_no").value="";
	
	
	
	 if (document.getElementById("clientname").value == "") {
			
		 
	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	/* if (document.getElementById("salesman_txt").value == "") {
			
		 
	        $('#get_docno').attr('placeholder', ''); 
	    }
	    
	     if (document.getElementById("salesmann").value == "") {
			
		 
	        $('#salesmann').attr('placeholder', 'Press F3 TO Search'); 
	    }*/
	 if (document.getElementById("ra_no").value == "") {
			
		 
	        $('#ra_no').attr('placeholder', ''); 
	    }
	 if (document.getElementById("salesman").value == "") {
			
		 
	        $('#salesman').attr('placeholder', 'Press F3 TO Search'); 
	    }
	
	 if (document.getElementById("fleet").value == "") {
			
		 
	        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("catname").value == "") {
			
		 
	        $('#catname').attr('placeholder', 'Press F3 TO Search'); 
	    }
		$("#detailedGrid").jqxGrid('clear');
	}


</script>
<style>
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
<script>

function funupdate()
{
	
//alert(ra_no);	
	 if(document.getElementById("ra_no").value=="")
	 {
		 $.messager.alert('Message',' select salesman ra_no ','warning');   
					 
		 return 0;
	 }
	 if(document.getElementById("lpo").value=="")
	 {
		 $.messager.alert('Message','select LPO NO ','warning');   
					 
		 return 0;
	 }
	
	
      
     var ra_no = document.getElementById("ra_no").value;
     var lpo = document.getElementById("lpo").value;
     var oldlpo = document.getElementById("oldlpo").value;

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(ra_no,lpo,oldlpo);	
	     	}
		     });
	
	
	
}
function savegriddata(ra_no,lpo,oldlpo)
{
	
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
			var items=x.responseText;
			// alert(items);
			 document.getElementById("ra_no").value="";
			 document.getElementById("lpo").value="";
			 document.getElementById("oldlpo").value="";
			  
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
		 		 
		 		 
			     
		     });
			 funreload(event); 
			 $("#detailedGrid").jqxGrid('clear');
			disitems();
			 
			
			}
	}
		
x.open("GET","lposavedata.jsp?ra_no="+ra_no+"&lpo="+encodeURIComponent(lpo)+"&oldlpo="+encodeURIComponent(oldlpo), true);       

x.send();
document.getElementById("lpo").value="";
if (document.getElementById("lpo").value == "") {
	$('#lpo').attr('placeholder', 'Enter LPO No'); 
}
document.getElementById("ra_no").value="";


}

</script>
</head>
<body onload="getBranch();getrentaltype();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
     
	
	 <tr><td align="right"><label class="branch">Status</label></td><td align="left"><select id="status" name="status" style="height:20px;width:70%;" value='<s:property value="status"/>'>
    <option value="" selected>All</option>  
       <option value=0>Open</option>
    <option value=1>Close</option>  
	 </select></td></tr> 
 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="clientname"/>'></td></tr> 
 
 <tr><td align="right"><label class="branch">Category</label></td><td align="left"><input type="text" name="catname" id="catname" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getclcat(event);" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="catname"/>'></td></tr>
 
  <tr><td align="right"><label class="branch">Fleet</label></td><td align="left"><input type="text" name="fleet" id="fleet"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="getfleet(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="fleet"/>' ></td></tr> 
   <tr><td align="right"><label class="branch">Salesman</label></td><td align="left"><input type="text" name="salesman" id="salesman" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getsalesman(event)" onclick="this.placeholder='' " style="height:20px;width:70%;" value='<s:property value="salesman"/>' ></td></tr> 
     
      
      <tr><td align="right"><label class="branch">&nbsp;</label></td><td align="left">
       <select id="rentaltype" name="rentaltype" style="height:20px;width:70%;" value='<s:property value="rentaltype"/>' hidden="true">
      </select> </td></tr> 
	 <tr><td colspan="2"></td></tr>
	 <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
     <tr><td colspan="2">
	  <tr>
	<td colspan="2"><div><fieldset><legend >LPO NO change</legend> 
	<table width="100%" id="lpochange">
<tr><td align="right"><label class="branch">LPO NO</label></td><td align="left"><input type="text" name="lpo" id="lpo"   placeholder="Enter LPO No" style="height:20px;width:70%;" value='<s:property value="lpo"/>' ></td></tr>
<tr><input type="hidden" name="ra_no" id="ra_no"  style="height:20px;width:50%;" value='<s:property value="ra_no"/>'></tr> 
<tr><input type="hidden" name="oldlpo" id="oldlpo"  style="height:20px;width:50%;" value='<s:property value="oldlpo"/>'></tr> 

      
      <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="update" id="update"  value="Update" onclick="funupdate()"></td></tr>
     <tr><td colspan="2"></td></tr>                 
    </table>               
      </fieldset> 
	<tr>
	<td colspan="2">&nbsp;</div></td> 
	</tr>
	<!-- <tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 100px;"></div></td> 
	</tr> -->	
	</table>
	</fieldset>
		<input type="hidden" name="cldocno" id="cldocno"  style="height:20px;width:70%;" value='<s:property value="cldocno"/>'>
	        <input type="hidden" name="salesmandoc" id="salesmandoc"  style="height:20px;width:70%;" value='<s:property value="salesmandoc"/>'>
	         <input type="hidden" name="catid" id="catid"  style="height:20px;width:70%;" value='<s:property value="catid"/>'>	
</td>
<td width="80%">
	<table width="100%">
		<tr>
		   <td><div id="detlist"><jsp:include page="detailedGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>

<div id="catwindow">
   <div ></div>
</div>

<div id="clientwindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="salesmanwindow">
   <div ></div>
</div>
<div id="lpowindow">
   <div ></div>
</div>

</div>
</body>
</html>
	 