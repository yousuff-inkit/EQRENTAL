
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
	
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
	       
       });

function funExportBtn(){
	  
	 
	 if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(dats, 'Other Salik', true);
	  }
	 else
	  {
	                 
		 $("#salikGrid").jqxGrid('exportdata', 'xls', 'Other Salik');
	  }
	 
	
	 }

function funreload(event)
{     
 
	  var val ="1";
	  var uptodate=$("#uptodate").val();
	   $("#overlay, #PleaseWait").show();
	  $("#deldiv").load("listGrid.jsp?chval="+val+"&uptodate="+uptodate);
	
	
	}
	
	
	 
function hiddenbrh(){
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
}
function funDelete(){
	var salikarray=[];
	var selectedrows=$('#salikGrid').jqxGrid('selectedrowindexes');
	if(selectedrows.length<1){
		$.messager.alert('Warning', 'Please select a document', 'Warning');
		return false;
	}
	
	$.messager.confirm('Message', 'Do you want to Delete?', function(r){
       	if(r==false)
       	  {
       		return false; 
       	  }
      else{
    	  //savegriddatas(salikarray);
    	  var length=0;
    	  for(var i=0;i<selectedrows.length;i++){
    			salikarray.push($('#salikGrid').jqxGrid('getcellvalue',selectedrows[i],'trans'));
    			
    			/* newTextBox = $(document.createElement("input"))
    		    .attr("type", "dil")
    		    .attr("id", "test"+length)
    		    .attr("name", "test"+length)
    		    .attr("hidden", "true");
    			
    			newTextBox.val($('#salikGrid').jqxGrid('getcellvalue',selectedrows[i],'trans'));
    			newTextBox.appendTo('form');
    			length=length+1; */
    		}
    	  
    	     document.getElementById("salikarrays").value=salikarray;
    	     document.getElementById("gridlength").value=length;
			 document.getElementById("mode").value='D';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("deletetrafic").submit();
       	  }
	});
	
}

function setValues(){
	  
	  if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
		
		  var val ="1";
		  var uptodate=$("#uptodate").val();
		  $("#overlay, #PleaseWait").show();
		  $("#deldiv").load("listGrid.jsp?chval="+val+"&uptodate="+uptodate);
	  }
	}

</script>
</head>
<body onload="getBranch(); hiddenbrh(); setValues()">
<form id="deletetrafic" action="deleteOtherSalik"  method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
 
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->

  <tr><td colspan="2">&nbsp;</td></tr> 
   <tr><td colspan="2">&nbsp;</td></tr> 
   
    <tr><td width="20%" align="right"><label class="branch">Up To</label></td><td align="left"><div id='uptodate' name='uptodate' value='<s:property value="uptodate"/>'></div></td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     
    
   
     <tr><td colspan="2" align="center"><input type="button" id="btndelete" name="btndelete" value="Delete" class="myButton" onclick="funDelete()"></td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
    	
    	 <tr><td colspan="2"> <input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'></td></tr>
    	 <tr><td colspan="2"> <input type="hidden" name="salikarrays" id="salikarrays" style="width:100%;height:20px;" value='<s:property value="salikarrays"/>'></td></tr>
		 <tr><td colspan="2"> <input type="hidden" name="gridlength" id="gridlength" style="width:100%;height:20px;" value='<s:property value="gridlength"/>'></td></tr>    	
    	 <tr><td colspan="2"> <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'></td></tr> 
         <tr><td colspan="2"><input type="hidden" id="gridlength" name="gridlength"></td></tr> 
         <tr><td colspan="2"><input type="hidden" id="rentaldoc" name="rentaldoc"></td></tr> 
         <tr><td colspan="2"><input type="hidden" id="leasedoc" name="leasedoc"></td></tr> 
         <tr><td colspan="2"><input type="hidden" id="drdoc" name="drdoc"></td></tr> 
         <tr><td colspan="2"><input type="hidden" id="staffdoc" name="staffdoc"></td></tr> 
        

	</table>
	
 
 
	 
	
	  
	 <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;"><div hidden="true" id="hidediv"><img  alt="Search User" src="<%=contextPath%>/icons/31load.gif"> </div></div>
	</fieldset>
</td>


<td width="80%">
  
  <div id="deldiv"><jsp:include page="listGrid.jsp"></jsp:include></div></td>
 
		 
  
</tr>
</table>
</div>

 

</div>
</form> 
</body>
</html>