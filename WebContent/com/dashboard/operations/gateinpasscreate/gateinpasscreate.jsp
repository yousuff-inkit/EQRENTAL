
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
 String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
.myButtons {
  display: inline-block;
  margin-right:4px;
  margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
  touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $("#fromdate").jqxDateTimeInput({ width: '112px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '112px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   
	  
	   
	   
	   
	   $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('searchClient.jsp', $('#clientwindow')); 
	       });
	 
	
});


function getclinfo(event){
	 var x= event.keyCode;
	if(x==114){
 		$('#clientwindow').jqxWindow('open');
		clientSearchContent('searchClient.jsp', $('#clientwindow'));    
	}
	else{}
}

function clientSearchContent(url) {
 	$.get(url).done(function (data) {
	$('#clientwindow').jqxWindow('open');
	$('#clientwindow').jqxWindow('setContent', data);
}); 
} 


function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	if(fromdates>todates){
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   return false;
	} 
	else{
	        var fromdate= $("#fromdate").val();
			var todate= $("#todate").val(); 
			var cldocno=$("#cldocno").val();
			var branch=$("#cmbbranch").val();
			
			$("#gateinpassgriddiv").load("gateinpassGrid.jsp?from="+fromdate+"&to="+todate+"&cldocno="+cldocno+"&branch="+branch+'&check=1');

       }
}




function funcleardata()
  {
	  
  	document.getElementById("clientname").value="";
  	document.getElementById("cldocno").value="";
  	
  	 if (document.getElementById("clientname").value == "") {
  	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
  	    }
  }
  	
  	
  	
  	function funCreate(){
  			var cregtrno=document.getElementById("hidtrno").value;
  	  		var regno=document.getElementById("hidregno").value;
  	  		var cldocno=document.getElementById("hidcldocno").value;
  	  		var brch=document.getElementById("hidbrhid").value;
  	  		var client=document.getElementById("hidclient").value;
  	  		var trno=document.getElementById("hidtrno").value;
  	  		var fleetno=document.getElementById("hidfleetno").value;
	  		var vehicle=document.getElementById("hidvehicle").value;
	  		var agmtexist=document.getElementById("hidagmtexist").value;
	  		var srvckm=document.getElementById("hidsrvckm").value;
	  		var lastsrvckm=document.getElementById("hidlastsrvckm").value;
  	  		var vehicle1=" Reg No :"+regno+" Fleet Name : "+vehicle+"";
	  		
  	  		var url=document.URL;
			var reurl=url.split("com/");
  	  		
  	  	if(trno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return 0;
		 }
  	  	else{
  	  		var path1="com/workshop/gateinpass/gateinpass.jsp";
  	  		var name="Gate In-Pass";
  	  		var url=document.URL;
  	  		var reurl=url.split("com");

		  window.parent.formName.value="Gate In-Pass";
		  window.parent.formCode.value="GIP";
		  window.parent.branchid.value=brch;
		  var detName="Gate In-Pass";
		  var mode="A";
	   
	  
	  	  var path= path1+"?mod="+mode+"&brhid="+brch+"&cregtrno="+cregtrno+"&client="+client.replace("/\s/g","%20").replace('#','%23').replace('&','%26')
	  			  +"&cldocno="+cldocno+"&regno="+regno+"&fleetno="+fleetno+"&vehicle1="+vehicle1+"&agmtexist="+agmtexist+"&srvckm="+srvckm+"&lastsrvckm="+lastsrvckm;
	   	  top.addTab( detName,reurl[0]+""+path);
  	  		
		 }
  	  		
  	}
  	
  	
	function funExportBtn(){
		JSONToCSVConvertor(pcexceldata, 'PARTS COSTING', true);
	}
	
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table  width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>

	<tr width="100%">
	  <td align="right" width="40%" ><label class="branch">From Date</label></td>
	  <td align="left" width="60%"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
        </td></tr>
      <tr width="100%">
	  <td align="right" width="45%" ><label class="branch">To Date</label></td>
	  <td align="left" width="55%"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
        </td></tr>
      
      
   <tr><td colspan="2">&nbsp;</td></tr>
   <tr><td align="right"><label class="branch">Client</label></td>
   <td align="left">
   	<input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="clientname"/>'>
   	<input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >
   </td></tr>                 
		
	
	
  <tr><td colspan="2" align="left">
	<input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()" style="margin-left:37%;">
  </td></tr>
  <tr>
	   <td colspan="2" align="center">
	  	 <input type="button" class="myButton" name="btnCreate" id="btnCreate" value="Gate In Pass Create" style="margin-left:10%;" onclick="funCreate();">
	   </td>
  </tr>

  
  

	</table>
	
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	
	</fieldset>
	
	<input type="hidden" name="hidcldocno" id="hidcldocno" value='<s:property value="hidcldocno"/>' >
	<input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>' >
	<input type="hidden" name="hidregno" id="hidregno" value='<s:property value="hidregno"/>' >
	<input type="hidden" name="hidtrno" id="hidtrno" value='<s:property value="hidtrno"/>'>
	<input type="hidden" name="hidbrhid" id="hidbrhid" value='<s:property value="hidbrhid"/>'>
	<input type="hidden" name="hidfleetno" id="hidfleetno" value='<s:property value="hidfleetno"/>'>
	<input type="hidden" name="hidvehicle" id="hidvehicle" value='<s:property value="hidvehicle"/>'>
	<input type="hidden" name="hidagmtexist" id="hidagmtexist" value='<s:property value="hidagmtexist"/>'>
	<input type="hidden" name="hidsrvckm" id="hidsrvckm" value='<s:property value="hidsrvckm"/>'>
	<input type="hidden" name="hidlastsrvckm" id="hidlastsrvckm" value='<s:property value="hidlastsrvckm"/>'>
</td>
<td width="80%"><div  >
	<table width="100%" id="grid1">
		<tr><td >
		<div  id="gateinpassgriddiv"><jsp:include page="gateinpassGrid.jsp"></jsp:include></div>  
	    </td></tr>
	</table>
</div></td>
</tr>
</table>

</div>

<div id="clientwindow">
   <div></div>
</div>



</body>
</html>
