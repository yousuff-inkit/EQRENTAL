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
 .hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>
<script type="text/javascript">

$(document).ready(function () {  
	$('#branchlabel').hide();
	$('#branchdiv').hide();     
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#roomsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Room Type Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	$('#roomsearchwndow').jqxWindow('close');
	$('#inssearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Instruction Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	$('#inssearchwndow').jqxWindow('close');        
	$('#hotelsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Hotel Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	$('#hotelsearchwndow').jqxWindow('close'); 
	$('#categorysearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Price Category Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	$('#categorysearchwndow').jqxWindow('close'); 
	$('#nationsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Nation Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	$('#nationsearchwndow').jqxWindow('close');     
  	//$('#btnupdate').attr('disabled', true);
	 $( "#hotel" ).dblclick(function() {   
			hotelSearchContent('hotelSearch.jsp');  
		});
}); 
 
function hotelSearchContent(url) {
	 $.get(url).done(function (data) {
	 $('#hotelsearchwndow').jqxWindow('open');        
	 $('#hotelsearchwndow').jqxWindow('setContent', data);  
}); 
}
function getHotel(event){     
	var x= event.keyCode;
    if(x==114){
    	hotelSearchContent('hotelSearch.jsp');   
      }
}
function roomSearchContent(url) {
	 $.get(url).done(function (data) {
	$('#roomsearchwndow').jqxWindow('open');  
	$('#roomsearchwndow').jqxWindow('setContent', data);

}); 
}
function insSearchContent(url) {       
	 $.get(url).done(function (data) {
	$('#inssearchwndow').jqxWindow('open');  
	$('#inssearchwndow').jqxWindow('setContent', data);

}); 
}
function catSearchContent(url) {
	 $.get(url).done(function (data) {
	$('#categorysearchwndow').jqxWindow('open');  
	$('#categorysearchwndow').jqxWindow('setContent', data);

}); 
}
function nationSearchContent(url) {   
	 $.get(url).done(function (data) {
	$('#nationsearchwndow').jqxWindow('open');  
	$('#nationsearchwndow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	  $("#pricediv").load("hotelofferGrid.jsp?hotel="+$('#hidhotel').val()+"&id=1");  
	  /* $("#countdiv").load("countgrid.jsp?docno="+$('#hidhotel').val()+"&id=1"); */    
}      	
function funload()
{
	  $("#roomdiv").load("roomgrid.jsp?docno="+$('#docno').val()+"&id=1");    
} 
function funExportBtn(){
	var htl=$('#hotel').val();
	if(htl==""){
	htl='HOTEL OFFER';	
	}
	    JSONToCSVCon(Exceldata, htl, true);
	 }
  
function funUpdate(){ 
	var hotel=document.getElementById("hidhotel").value;  
	var vndid=document.getElementById("vendorid").value;
	  
	//alert("docno==="+docno);                    
	var gridarray=new Array();      
	var rows = $("#jqxpricegrid").jqxGrid('getrows'); 
	var temp=0;
	   for(var i=0 ; i < rows.length ; i++){ 
	 	   var chks=rows[i].roomid;             
		   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
			   gridarray.push(rows[i].roomid+" :: "+ rows[i].code +" :: "+rows[i].name+" :: "+rows[i].desc1+" :: "+rows[i].fdate+" ::"+rows[i].tdate+" :: "+rows[i].type+" :: "+rows[i].per+" :: "+rows[i].amount+" :: "+rows[i].docno+" :: ");   
		    temp++;    
		   }
		}
	
    if(temp!=0 && (docno=="" || docno=="0")){    
				$.messager.alert('warning','Please select a document');    
				return false;
			}	  
	if(temp==0){       
			$.messager.alert('warning','Please enter data..!!!');          
			return false; 
	 }	   
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {    
			items = x.responseText;
			if(items.trim()>0){         
				$.messager.alert('warning','Successfully Updated');
				funload();  
			 	/* $('#btnupdate').attr('disabled', true); */      
			}
			else{
				$.messager.alert('warning','Not Updated');
			}
			
		} else {
		}        
	}
	x.open("GET", "updateData.jsp?gridarray="+gridarray+"&hotelid="+hotel+"&vendorid="+vndid, true);                     
	x.send();
}
function funSave(rowindex1){
	var hotel=document.getElementById("hidhotel").value;          
	var vendor=document.getElementById("vendorid").value;
	if(hotel==""){   
		$.messager.alert('warning','Please select hotel name');       
		return false;
	}  
     var docno=$('#jqxpricegrid').jqxGrid('getcellvalue', rowindex1, "docno");  
     var fdate=$('#jqxpricegrid').jqxGrid('getcelltext', rowindex1, "fdate"); 
     var tdate=$('#jqxpricegrid').jqxGrid('getcelltext', rowindex1, "tdate");
     var pcatid=$('#jqxpricegrid').jqxGrid('getcellvalue', rowindex1, "pcatid");
     var remarks=$('#jqxpricegrid').jqxGrid('getcellvalue', rowindex1, "remarks");
     var type=$('#jqxpricegrid').jqxGrid('getcellvalue', rowindex1, "type");
     var release=$('#jqxpricegrid').jqxGrid('getcellvalue', rowindex1, "releaseno");  
     var pcat=$('#jqxpricegrid').jqxGrid('getcellvalue', rowindex1, "pcat");           
     var nation=$('#jqxpricegrid').jqxGrid('getcellvalue', rowindex1, "nation");  
     var nationid=$('#jqxpricegrid').jqxGrid('getcellvalue', rowindex1, "nationid");  
     //alert(nationid+"=="+pcatid+"=="+tdate+"=="+pcatid+"=="+remarks+"=="+release);         
	var x = new XMLHttpRequest();  
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {             
			items = x.responseText;  
			if(items.trim()>0){  
				$.messager.alert('message','Successfully Saved');        
				funreload();              
			}
			else{  
				$.messager.alert('warning','Not Saved');     
			}
			
		} else {                                                             
		}
	}
	x.open("GET", "saveData.jsp?hotel="+hotel+"&type="+type+"&vendor="+vendor+"&docno="+docno+"&remarks="+remarks+"&pcatid="+encodeURIComponent(pcatid)+"&fdate="+fdate+"&tdate="+tdate+"&release="+release+"&pcat="+encodeURIComponent(pcat)+"&nation="+encodeURIComponent(nation)+"&nationid="+encodeURIComponent(nationid), true);
	x.send();
}  
function  funClearData(){  
	 $('#hotel').val('');$('#hidhotel').val('');$('#vendor').val('');$('#vendorid').val('');
	
	 $('#jqxpricegrid').jqxGrid('clear'); 
	   
}
</script>
</head>
<body >
<div id="mainBG" class="homeContent" data-type="background">                              
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>   
<td width="20%" >
    <fieldset style="background: #ECF8E0;">       
	<table width="100%"> 
	<jsp:include page="../../heading.jsp"></jsp:include>  
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
   <td align="right" width="30%"><label class="branch">Hotel Name</label></td>   
   <td><input type="text" name="hotel" id="hotel" readonly  style="width:100%" placeholder="Press F3 to Search" class="filters" onkeydown="getHotel(event);">
   <input type="hidden" name="hidhotel" id="hidhotel"  readonly  class="filters"></td>    
    </tr>
     <tr>  
   <td align="right" width="20%"><label class="branch">Vendor</label></td>  
   <td><input type="text" name="vendor" id="vendor" style="width:100%" readonly class="filters">
     <input type="hidden" name="vendorid" id="vendorid" readonly  class="filters"></td>       
   </tr>                               
	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>   
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>  
 	  <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>   
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	
	 <tr>
 	  <td colspan="2"><center><button type="button" name="btnupdate" id="btnupdate" onclick="funUpdate();" class="myButton">Update</button></center></td>
     </tr> 
     <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td></tr>           
      <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>   
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	  <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>   
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	 
  </table>
   </fieldset>      
</td>  
<td width="80%">  
	<table width="100%">     
		<tr>
			  <td colspan="2"><div id="pricediv"><jsp:include page="hotelofferGrid.jsp"></jsp:include></div> <br></td> 
		</tr>    
		
	</table>   
</tr>
</table>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>   
<div id="roomsearchwndow">
   <div ></div>
</div> 
<div id="inssearchwndow">
   <div ></div>
</div>
<div id="hotelsearchwndow">      
   <div ></div>
</div>
<div id="nationsearchwndow">      
   <div ></div>
</div>    
<div id="categorysearchwndow">      
   <div ></div>
</div>     
</div>  
</div>
</body>
