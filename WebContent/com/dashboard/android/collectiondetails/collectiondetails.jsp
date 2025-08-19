
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<script type="text/javascript">

$(document).ready(function () {
	
	 
	 $("#fdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#tdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 

	 
});
 
 function funreload(event)
{
	
  	var fdateval = $("#fdate").val();
  	var tdateval = $("#tdate").val();
	  $("#fleetdiv").load("collectiondetailsGrid.jsp?fdate1="+fdateval+"&tdate1="+tdateval);
	  
	}

	
 function hiddenbrh(){
		
		$("#branchlabel").attr('hidden',true);
		$("#branchdiv").attr('hidden',true);
		
	}

 
 function funExportBtn(){
	    

	   JSONToCSVConvertor(collectionexcel, 'Collection Details', true);
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
</script>
</head>
<body onload="hiddenbrh();">
<form autocomplete="off" id="rentalform">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	 <tr><td colspan="2">&nbsp;</td></tr> 
		 <tr>
	<td colspan="2" ><table width="100%">
	 <tr>
	    <td width="17%" align="right"><label class="branch">From</label></td>
	    <td colspan="2"><div id="fdate" name="fdate" value='<s:property value="fdate"/>'></div></td>
	    </tr>
	 
	  <tr>
	    <td align="right"><label class="branch">To</label></td>
	    <td colspan="2"><div id="tdate" name="tdate" value='<s:property value="tdate"/>'></div></td>
	    </tr>
	 
	<tr><td>&nbsp;</td></tr>
	  <tr>
	    <td colspan="2" align="center"> &nbsp;</td></tr>
	      <tr><td>&nbsp; </td></tr>
	      <tr><td>&nbsp;</td></tr>
	      <tr><td>&nbsp; </td></tr>
	      <tr><td>&nbsp;</td></tr>
	      <tr><td>&nbsp; </td></tr>
	     
	     
	  </table>
	<br><br><br><br><br><br><br><br><br><br>
	
	
	<%-- <div id="Readygrid"   ><jsp:include page="vehDetailsgrid.jsp"></jsp:include>
	</div> --%></td>
	</tr> 
	<tr>

 
 


	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="collectiondetailsGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<div id="curdate" name="curdate" hidden="true"></div>
<div id="fromdate" name="fromdate" hidden="true"></div>
<input type="hidden" name="docno" id="docno">

</div>
</div>
</div>
<!-- <input type="hidden" name="hidcmbstatus" id="hidcmbstatus"> -->
<label id="trncodeval" hidden="true"></label>
<label id="statusval" hidden="true"></label>
</form>
</body>
</html>