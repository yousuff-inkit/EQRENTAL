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
.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}
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
<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		   
	});
	 
	function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 freqeuncy=$('#cmbchoose').val();      
		 //alert("fromdate="+fromdate+"todate="+todate);
		 $("#overlay, #PleaseWait").show();
				$("#cashflowDiv").load("cashflowGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&freqeuncy="+freqeuncy+"&check="+1);
		}      
  
	function funExportBtn(){
		JSONToCSVCon(exceldata, 'CashFlow Analysis', true);   
	}     
	  
	function confirmload(){
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
		$.messager.confirm('Confirm','Do you want to load data?', function(r){
			    if (r){ 
			    	$("#overlay, #PleaseWait").show();   
			    	var x=new XMLHttpRequest();
					x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
						{  
							var items=x.responseText.trim();  
							if(items>0){
								$("#overlay, #PleaseWait").hide();	
								$.messager.alert('Message','Successfully loaded','warning');
							}  
						}			     
					}       
						
				x.open("GET","cashflowload.jsp?fromdate="+fromdate+"&todate="+todate,true);  
				x.send();
			    }
			    else{
			    	$("#overlay, #PleaseWait").hide();   
			    }
			  });
	}
      
	 function checkmonths(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				if(items>0){
	  					$.messager.alert('Message',' Month difference not more than 11..! ','warning');
	  					 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	  				     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()+11));
	  				     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	  				     $('#todate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	  				}
	  		}    
	  		}
	  		x.open("GET", "getMonthDifference.jsp?fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val(), true);
	  		x.send();
	 }     
</script>      
</head>
<body onload="getBranch();">       
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmBudgetVariance" action="saveBudgetVariance" method="post" autocomplete="off">
<div class='hidden-scrollbar'>
<table width="100%" >  
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td colspan="2">&nbsp;</td></tr>	

	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate"  onchange="checkmonths();" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate"  onchange="checkmonths();" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	  <tr>
      <td align="right"><label class="branch">Type</label></td>
      <td><select id="cmbchoose" name="cmbchoose" style="width:60%;"  value='<s:property value="cmbchoose"/>'>
      <option value="">------select------</option> <option value="1">Monthly</option></select>&nbsp;&nbsp;
      <input type="hidden" id="txtnoofdays" name="txtnoofdays" style="width:50%;height:20px;" value='<s:property value="txtnoofdays"/>'/>
      </td>
    </tr> 
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr> <td colspan="2" align="center"><input type="button" id="btnview" name="btnview" class="myButton" value="Load Data" style="width:50%;" onclick="confirmload();" />
	</td></tr>      
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
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">    
	<table width="100%">     
		<tr>
	        <td><div id="cashflowDiv"><jsp:include page="cashflowGrid.jsp"></jsp:include></div></td> 
		</tr>  
	</table>      
</td>       
</tr>
</table>      
</div>
</form>
</div> 
</body>
</html>