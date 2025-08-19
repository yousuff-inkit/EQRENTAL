
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
	
    $('#clinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#clinfowindow').jqxWindow('close');
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");



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
	   $('#clientname').dblclick(function(){
	  	    $('#clinfowindow').jqxWindow('open');
            $('#clinfowindow').jqxWindow('focus');
           clinfoSearchContent('clientinfo.jsp'); 
           });
});
function getclientinfo(event){
  	 var x= event.keyCode;
  	 if(x==114){
  	  $('#clinfowindow').jqxWindow('open');
  
     
  	 clinfoSearchContent('clientinfo.jsp');    }
  	 else{
  		 }
  	 }

   function clinfoSearchContent(url) {
 
  		 $.get(url).done(function (data) {
  		
  		$('#clinfowindow').jqxWindow('setContent', data);
  
  	}); 
  	}
function funExportBtn(){
	   $("#enqlistgrid").jqxGrid('exportdata', 'xls', 'Enquiry List');
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
	 var clientname=$("#clientname").val();
	   
	  $("#enqlistdiv").load("enquirylistGrid.jsp?branch="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&clientname="+clientname.replace(/ /g, "%20"));
	  $("#Readygrid").load("subgrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&clientname="+clientname.replace(/ /g, "%20"));
		
		   }
	}

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
<%-- 	 <table width="100%">
	 <tr>
	<td  align="right"><label class="branch" >From Date</label></td><td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
           
	</tr> 
	
	 <tr>
	<td align="right"><label class="branch">To Date</label></td><td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
    </tr>
     </table>
	</td> --%>      
	
	 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td align="right"> <label class="branch">Client</label></td> <td ><input type="text"  id="clientname" name="clientname" style="height:20px;width:90%;"  placeholder="F3 To Search Or Enter Name" value='<s:property value="clientname"/>' onKeyDown="getclientinfo(event);"> </td></tr> 
 

 <tr><td colspan="2">&nbsp;</td></tr> 
  <tr>
	 <td colspan="2" align="center" ><div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include>
	</div></td>
	
	<!-- <td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 280px;"></div></td> --> 
	</tr>
<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	
	
	 
	</table>
	</fieldset>
	<input type="hidden" id="cldocno" style="height:20px;width:70%;"  name="cldocno">
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="enqlistdiv"><jsp:include page="enquirylistGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clinfowindow">
   <div ></div>
</div> 
</div>
</body>
</html>