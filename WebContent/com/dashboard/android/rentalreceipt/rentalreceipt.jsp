
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

	 

 function updateStatus(){
	 var barchval = document.getElementById("cmbbranch").value;
	if(barchval=='a'){
		$.messager.alert('Message',"Please Select a branch");
	}
	else{
	 $.messager.confirm('Message', 'Do you want to Generate?', function(r){
	        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 	
	   
  	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		 if (x.readyState == 4 && x.status == 200) {
			var itm = x.responseText;
			var items=itm.split("::");
			var val1=items[1].trim();
			if(items[0].trim()=="1"){
					   $.messager.alert('Message',"Rental Receipt '"+val1+"'  Successfully Generated");
						
					   funreload(this);
					   $("#detailsgrid").jqxGrid('clear');
					  
			}
				else{
					$.messager.alert('Message',"Not Generated");
					funreload(this);
					$("#detailsgrid").jqxGrid('clear');	
				}

		} else {
		}
	}
	x.open("GET", "updateStatus.jsp?date1="+document.getElementById("date1").value+"&doc="+document.getElementById("doc").value+"&brno="+document.getElementById("brno").value+"&type="+document.getElementById("type").value+"&ctype="+document.getElementById("ctype").value+"&chkno="+document.getElementById("chkno").value+"&chkdate="+document.getElementById("chkdate").value+"&amount="+document.getElementById("amount").value+"&desc="+document.getElementById("desc").value+"&cldocno="+document.getElementById("cldocno").value+"&txtacno="+document.getElementById("txtacno").value+"&txtdoc="+document.getElementById("txtdoc").value, true);
	x.send();
	
	      	}
	 });
	}
 } 
 
 function funreload(event)
{
	 document.getElementById("btnUpdate").disabled=true;
	
 	$('input[type=text],[type=hidden]').val('');
		var barchval = document.getElementById("cmbbranch").value;
  	
  	var fdateval = $("#fdate").val();
  	var tdateval = $("#tdate").val();
	  $("#fleetdiv").load("rentalreceiptGrid.jsp?branchval="+barchval+"&fdate1="+fdateval+"&tdate1="+tdateval);
	  
	}

	
 function funExportBtn(){
	    
	 $("#fleetdiv").excelexportjs({
		 containerid: "fleetdiv", 
		 datatype: 'json', 
		 dataset: null, 
		 gridId: "rentalreceiptGrid", 
		 columns: getColumns("rentalreceiptGrid") , 
		 worksheetName:"Rental Receipt List"
		 });
	  // JSONToCSVConvertor(rentalexcel, 'Rental Receipt List', true);
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
	 
	<tr><td>&nbsp;</td></tr>
	  <tr>
	    <td colspan="2" align="center">
	  
	   <input type="button" name="btnUpdate" id="btnUpdate" value="Generate" class="myButton" onClick="updateStatus();"></td>
	    
	    </td>
	      </tr>
	      
	     
	      
	      <tr><td>
	       <input type="hidden" id="doc" name="doc"/>
	      <input type="hidden" id="date1" name="date1"/>
	      <input type="hidden" id="cname" name="cname"/>
	      <input type="hidden" id="type" name="type"/>
	      <input type="hidden" id="chkno" name="chkno"/>
	      <input type="hidden" id="chkdate" name="chkdate"/>
	      <input type="hidden" id="amount" name="amount"/>
	      <input type="hidden" id="ctype" name="ctype"/>
	      
	      <input type="hidden" id="desc" name="desc"/>
	     <input type="hidden" id="brno" name="brno"/>
	      <input type="hidden" id="cldocno" name="cldocno"/>
	      <input type="hidden" id="txtdoc" name="txtdoc"/>
	      <input type="hidden" id="txtacno" name="txtacno"/>
	      </td></tr>
	      <tr><td>&nbsp;</td></tr>
	     <tr>
  <td colspan="2" ><textarea id="recdetails" name="recdetails" style="resize:none;width:100%;" rows="5" readonly></textarea></td>
  </tr>   
	 
	  </table>
	<br><br><br><br><br><br><br><br><br><br>
	
</td>
	</tr> 
	<tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="rentalreceiptGrid.jsp"></jsp:include></div></td>
		</tr>
		
		<tr>
		<td align="left" ><div id="detaildiv"><jsp:include page="followDetailgrid.jsp"></jsp:include></div></td></tr>
		
	</table>
</tr>
</table>
<input type="hidden" name="docno" id="docno">
<!-- <div id="vehiclewindow">
<div></div>
</div> -->
</div>
</div>
<!-- <input type="hidden" name="hidcmbstatus" id="hidcmbstatus"> -->
<label id="trncodeval" hidden="true"></label>
<label id="statusval" hidden="true"></label>
</form>
</body>
</html>