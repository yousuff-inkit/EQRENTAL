<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
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
 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#fleet').dblclick(function(){
		 fleetSearchContent("fleetSearchMaster.jsp");
		});
	 $('#fleetToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Fleet Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#fleetToWindow').jqxWindow('close');
	 
	 $('#client').dblclick(function(){
		 clientSearchContent("clientSearch.jsp?id=1");
		});
	 $('#clientToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientToWindow').jqxWindow('close');
	 
});


	function funreload(event)
	{
		
	    /* ar fromdate=$('#fromdate').jqxDateTimeInput('val');
	    var clientid=document.getElementById("cldocnos").value; */
	  //  alert(jcno+"  "+techid);
	     var cldocno=$('#cldocno').val();
		 var uptodate=$('#uptodate').jqxDateTimeInput('val');
		 
	    $("#overlay, #PleaseWait").show(); 
	   	$("#detaildiv").load("reserveVehicleGrid.jsp?id=1&cldocno="+cldocno+"&uptodate="+uptodate);
		      	
	}
	
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function getFleetDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	    	fleetSearchContent("fleetSearchMaster.jsp");
	    }
	    else{
	     }
	    }
	
	function fleetSearchContent(url) {
		
		if($('#masterrefno').val()==""){
			$.messager.alert('Warning','Please select an agrement');
			return false;
		}
	 	$('#fleetToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#fleetToWindow').jqxWindow('setContent', data);
		});
	}
	
	function getClientDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent("clientSearch.jsp?id=1");
	    }
	    else{
	     }
	    }
	
	function clientSearchContent(url) {
		
	 	$('#clientToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#clientToWindow').jqxWindow('setContent', data);
		});
	}
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#uptodate').jqxDateTimeInput('setDate',new Date());
	    
	    /* $('#summaryGrid').jqxGrid('clear');
	    $('#techReportGrid').jqxGrid('clear'); */
		
	}
	
	
	function funExportBtn(){
		//alert("inside Export");
		JSONToCSVConvertor(data1, 'Productivity List', true);
		 }
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	   // alert("arrData");
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	function funFleetUpdate(){
		if($('#masterrfno').val()=="" || $('#detailrefno').val()==""){
			$.messager.alert('Warning','Please select an agreement');
			return false;
		}
		if($('#fleetid').val()=="" ){
			$.messager.alert('Warning','Please select a fleet');
			return false;
		}
		 var masterrefno=$('#masterrfno').val();
		 var detailrefno=$('#detailrefno').val();
		 var balqty=$('#hidbalqty').val();
		 var fleets=$('#fleetid').val();
		 var xx=fleets.split(',').length;
		 
		 if(balqty<xx){
			 $.messager.alert('Warning','Selected number of vehicles is greater than balance quantity');
			 return false;
		 }
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			var sts = x.responseText;
			if(sts==1){
				$.messager.alert('Message','Not Updated');
			}
			if(sts==0){
				$.messager.alert('Message','Updated Succesfully');
				funreload(event);
			}
		  }
		}
			
	x.open("GET","fleetUpdate.jsp?masterrefno="+masterrefno+"&detailrefno="+detailrefno+"&fleets="+fleets,true);
	x.send();
	}
	
	/* setValues(); */
	</script>
	
</head>
<body onload="getBranch();">
<form id="frmWorkJobExecution" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
		<jsp:include page="../../heading.jsp"></jsp:include>
		
			<tr>
			   <td width="32%" align="right"><label class="branch">Up To Date</label></td><td width="68%"><div id="uptodate"></div></td>
		   </tr>
		   <tr>
				<td style="width:32%;" align="right"><label class="branch">Client</label></td>
				<td  style="width:68%;"><input type="text" name="client" id="client" readonly placeholder="Press F3 to Search" onkeydown="getClientDetails(event)"></td>
		   </tr>
			<tr>
				<td style="width:32%;" align="right"><label class="branch">Fleet</label></td>
				<td  style="width:68%;"><input type="text" name="fleet" id="fleet" readonly placeholder="Press F3 to Search" onkeydown="getFleetDetails(event)"></td>
		   </tr>
		    <tr >
			<td colspan="2" style="border-top:2px solid #DCDDDE;">
			<div style="text-align:center;">
			<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
			<input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButtons" onclick="funFleetUpdate();">
			</div>
		    </td>
			</tr>
			
			
		<tr >
			<td colspan="2" height="300">
			<!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
			</td> 
		</tr>
		
		<tr colspan="2"><td>&nbsp;</td></tr>		
	</table>
			
</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="detaildiv"><jsp:include page="reserveVehicleGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
			  <input type="hidden" name="fleetid" id="fleetid" value='<s:property value="fleetid"/>'>
			  <input type="hidden" name="masterrefno" id="masterrefno" value='<s:property value="masterrefno"/>'>
			  <input type="hidden" name="detailrefno" id="detailrefno" value='<s:property value="detailrefno"/>'>
			  <input type="hidden" name="hidbalqty" id="hidbalqty" value='<s:property value="hidbalqty"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>

</div>
</form>
<div id="fleetToWindow">
	<div></div>
	</div>
<div id="clientToWindow">
	<div></div>
	</div>	
</body>
</html>