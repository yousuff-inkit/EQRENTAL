
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
	 $('#regnoDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Reg No. Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#regnoDetailsWindow').jqxWindow('close');
	  
	 $('#txtregno').dblclick(function(){
		  regnoSearchContent('regnoSearchGrid.jsp');
		});
	 
});






function regnoSearchContent(url) {
    $('#regnoDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#regnoDetailsWindow').jqxWindow('setContent', data);
	$('#regnoDetailsWindow').jqxWindow('bringToFront');
}); 
}


function getRegno(event){
    var x= event.keyCode;
    if(x==114){
    	regnoSearchContent('regnoSearchGrid.jsp');
    }
    else{}
    }	 

 
 function funreload(event)
{
			var barchval = document.getElementById("cmbbranch").value;
		var droptyp = document.getElementById("droptype").value;
		var regno = document.getElementById("txtregno").value;
 	var fdateval = $("#fdate").val();
  	var tdateval = $("#tdate").val();
	  $("#fleetdiv").load("checkin-outGrid.jsp?branchval="+barchval+"&fdate1="+fdateval+"&tdate1="+tdateval+"&regno="+regno+"&type="+droptyp);
	 $("#Readygrid").load("subgrid.jsp");
	 $("#detaildiv").load("followDetailgrid.jsp?rdoc="+null);
	 
		/*  $('#txtregno').val('');
		 if (document.getElementById("txtregno").value == "") {
		        $('#txtregno').attr('placeholder', 'Press F3 to Search'); 
		    }
	 	$('input[type=text],[type=hidden]').val(''); */
	  
	}

 function  funClearData(){
	 $('#txtregno').val('');$('#fdate').val(new Date());$('#tdate').val(new Date());
	
	  if (document.getElementById("txtregno").value == "") {
	        $('#txtregno').attr('placeholder', 'Press F3 to Search'); 
	    }
	 
 }
 
	
 function funExportBtn(){
	    

	   JSONToCSVConvertor(checkinoutexcel, 'Check In-Out List', true);
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
<body onload="getBranch();">
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
	    
	   <tr><td align="right"><label class="branch">Type</label></td>
     <td align="left"><select id="droptype" name="droptype"   value='<s:property value="droptype"/>'>
     <option  value="IN">IN</option><option value="OUT">OUT</option><option selected="selected" value="ALL">ALL</option>
     </select></td></tr>
     	    
	<tr><td align="right"><label class="branch">Reg No.</label></td>
	<td align="left"><input type="text" id="txtregno" name="txtregno" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getRegno(event);" value='<s:property value="txtregno"/>'/>
    </td></tr>
   
   <tr><td>&nbsp;</td></tr> 
    <tr><td colspan="2" align="center"><input type="button" class="myButton" name="clear" id="clear"  value="Clear" onclick="funClearData();">
</td></tr> 
  	<tr><td>&nbsp;</td></tr> 
  	   <tr>
	<td colspan="2" ><div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
  	      
	  </table>
	<br/>
</td>
	</tr> 
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="checkin-outGrid.jsp"></jsp:include></div></td>
		</tr>
		
		<tr>
		<td align="left" ><div id="detaildiv"><jsp:include page="followDetailgrid.jsp"></jsp:include></div></td></tr>
		
	</table>
	</td>
</tr>
</table>

<div id="regnoDetailsWindow">
	<div></div><div></div>
</div>
</div>
</div>
</form>
</body>
</html>