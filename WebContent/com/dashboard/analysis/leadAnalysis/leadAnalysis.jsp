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
	
		 
		  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $("body").prepend('<div id="overlaysub" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWaitsub' style='display: none;position:absolute; z-index: 1;top:290px;left:115px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#filterSearchwindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#filterSearchwindow').jqxWindow('close');
		
		  var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); 
	});

	function funExportBtn(){
		/*  if (document.getElementById('rsumm').checked) {
			 
			 JSONToCSVCon(excelsummarydata,'Service Invoice Details(Summary)',true);
			  
			 }
			 
			 if (document.getElementById('rdet').checked) {
				 
				 JSONToCSVCon(exceldetaildata,'Service Invoice Details(Detail)',true);
				 
				 } */
		
		 }
	
	
	function funreload(event){

		}
	
	function setprodSearch(){
		var grpval=$('#grpby').val().trim();
		var value=$('#filterby').val().trim();
		if(grpval=="")
			{
			 $.messager.alert('Message','Select Group By ','warning');
			 return 0;
			}
		else{
			getfilterVal(value,grpval);
		}

	}
	

	     function getfilterVal(value,grpval){
	    	 branchid=document.getElementById("cmbbranch").value; 
			 frmdate=$('#fromdate').jqxDateTimeInput('val');
			 todate=$('#todate').jqxDateTimeInput('val');
				 
		 $('#filterSearchwindow').jqxWindow('open');
			 		// changeContent('contractMastersearch.jsp');  
			 		 SalesmanSearchContent('filterDetailsSearch.jsp?val='+value+"&grpval="+grpval+"&todate="+todate+"&fromdate="+frmdate+"&branchval="+branchid, $('#filterSearchwindow'));
			    	
			 	 }
			    	 
			function SalesmanSearchContent(url) {
				 $.get(url).done(function (data) {
				$('#filterSearchwindow').jqxWindow('setContent', data);
			           	}); 
			 	}
	
	
	function funClearData(){
		
		 document.getElementById("grpby").value="";
		 document.getElementById("filterby").value="";
		 document.getElementById("cmbbranch").value="a";
		 
		 $("#jqxLeadCount").jqxGrid('clear'); 
		 $("#jqxleaddataGrid").jqxGrid('clear');
		 
	}
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>

	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' ></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	 <tr >
	  <td align="right"><label class="branch" id="lblgrpby">Group By</label></td>
	  <td  align="left"><select name="grpby" id="grpby" style="width:52%;">
<option value="">--Select--</option>
    <option value="salm">SALESMAN</option>
    <option value="status">STATUS</option>
    <option value="type">TYPE</option>
    </select>
    </td>
    </tr>  
	  <tr >
	  <td align="right" width="25%"><label class="branch">Filter By</label></td>
	  <td  align="left"><select name="filterby" id="filterby" style="width:52%;">
<option value="">--Select--</option>
   <option value="salm">SALESMAN</option>
    <option value="status">STATUS</option>
    <option value="type">TYPE</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setprodSearch();">+</button>
    <!-- &nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button> --></td>
	  </tr> 
	  <tr>
	<td colspan="2" ><div id="Countgrid"><jsp:include page="Countgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
	<!-- <tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="18"  readonly></textarea></td>
	  </tr> -->
	  <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
    </td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="leadDiv"><jsp:include page="leadAnalysisGrid.jsp"></jsp:include></div></td>
		</tr>
		    
	</table>
</tr>
</table>

   <div id="filterSearchwindow">
   <div ></div>
   </div>
</div>
</div>
</body>
</html>