
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
	
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#driverwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Driver Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#driverwindow').jqxWindow('close');
	     
	     
	     
	 $('#driver').dblclick(function(){
	  	    $('#driverwindow').jqxWindow('open');
	   
	       driverSearchContent('driverSearch.jsp?', $('#driverwindow')); 
    });
	 
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




function driverSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#driverwindow').jqxWindow('open');
 		$('#driverwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 

function getDriverData(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#driverwindow').jqxWindow('open');


	  driverSearchContent('driverSearch.jsp?', $('#driverwindow'));     }
	 else{
		 }
	 }

function funreload(event)
{
	 var driver = document.getElementById("hiddriver").value;

	 if(driver=="")
		 {
		   $.messager.alert('Message','Search Driver  ','warning'); 
		   return 0;
		 }
	 else
		 {
		 
		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else{
		 
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	  $("#drvdiv").load("driverMovementGrid.jsp?driver="+driver+"&fromdate="+fromdate+"&todate="+todate+"&ready=1");
	  $("#drvsummdiv").load("driverSummaryGrid.jsp?driver="+driver+"&fromdate="+fromdate+"&todate="+todate);
		   }
		 }
	
	}
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	
}

function funPrintMov(){
	var driver = document.getElementById("hiddriver").value;

	 if(driver=="")
		 {
		   $.messager.alert('Message','Search Driver  ','warning'); 
		   return false;
		 }
	 else
		 {
    var url=document.URL;
    var reurl=url.split("driverMovement.jsp");
  
    var win= window.open(reurl[0]+"printDriverMov?driver="+document.getElementById("hiddriver").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
		 }
}

function funExportBtn(){
	var aa=$('#driver').val();
	JSONToCSVConvertor(exedata, 'Driver Movement \n\nDriver  :  '+aa, true);
	JSONToCSVConvertor(drvsummaryexcel, 'Driver Movement Summary :  '+aa, true);
	
}

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
	
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    
    var CSV = '';    
    
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

</script>
</head>
<body onload="hiddenbrh();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" rowspan="2" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 
	 	 <tr><td align="right"><label class="branch">Driver</label></td>
	 <td align="left"><input type="text" id="driver" style="height:20px;width:61%;" name="driver" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly value='<s:property value="driver"/>' onkeydown="getDriverData(event);" > </td></tr>
	 <input type="hidden" name="hiddriver" id="hiddriver" value='<s:property value="hiddriver"/>'/>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                <tr>    
      <td colspan="2"><textarea id="drvinfo" style="height:180px;width:200px;font: 10px Tahoma;resize:none" name="drvinfo"  readonly="readonly"  ><s:property value="drvinfo" ></s:property></textarea>  </td></tr>               
                    
    <tr><td colspan="2">&nbsp;</td></tr>               
  <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnPrint" name="btnPrint" onclick="funPrintMov(event);">Print</button></td></tr>                  
                 

<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height:125px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td height="274"><div id="drvdiv"><jsp:include page="driverMovementGrid.jsp"></jsp:include></div></td>
			 <!--<td></td>-->
		</tr>
	</table>
</tr>
<tr>
  <td><div id="drvsummdiv"><jsp:include page="driverSummaryGrid.jsp"></jsp:include></div></td>
</tr>
</table>

</div>
<div id="driverwindow"><div></div>
</div>
</div>
</body>
</html>