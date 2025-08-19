
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
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	
    
    
});

function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}


function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	  var rtatype = document.getElementById("cmbchoose").value;
	  
	 	 
	   if(rtatype==''){
		   
		   $.messager.alert('Message','Please Select RTA Type  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	
	   $("#overlay, #PleaseWait").show();
	  $("#rtaupdiv").load("rtaupdateGrid.jsp?barchval="+barchval+"&type="+rtatype);
	}
	
	}
	
	/*function funConfirm(){
	
	var confrim= document.getElementById("maindoc").value;
	var rtatype = document.getElementById("cmbchoose").value;
	//alert(confrim);
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
				    		        	  
				    	     		       
			       	if(r==false)
			       	  {
			       		return false; 
			       	  }
			       	else{
					   savedata();
					}
     });
	
	
	}
	
	
	function savedata(){
	
	 var x=new XMLHttpRequest();
			        	x.onreadystatechange=function(){
			        	if (x.readyState==4 && x.status==200)
			        		{
			        		
			             			
			        			var items=x.responseText;
			        			
			        			if(items>0){
			        			 $.messager.alert('Message', '  Record successfully Confirmed ', function(r){
			    				     
			    			     });
			    			     }else{
			    			     
			    			      $.messager.alert('Message', '  Record Not Confirmed ', function(r){
			    				     
			    			     });
			    			     
			    			     
			    			     }
			        			 funreload(event); 
			        			 
			        			 
			        			
			        			}
			        		
			        	}
			        		
			        x.open("GET","saveconfirm.jsp?con="+$("#maindoc").val()+"&type="+$("#cmbchoose").val(),true);
			        
			        x.send();
	
	
	
	
	
	}*/
	
function funExportBtn(){
	 //  $("#rtaupdategrid").jqxGrid('exportdata', 'xls', 'RAG-RRTA Update');
	   
	   var rtatype = document.getElementById("cmbchoose").value;
	//alert(rtatype);
	
	if(rtatype=='rental'){
	
	JSONToCSVCon(exceldata, 'RAG-RRTA Update', true);
	
	}
	
	if(rtatype=='lease'){
	
	JSONToCSVCon(exceldata, 'LAG-LRTA Update', true);
	
	}
	
	
	  /* if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(datasssss, 'RAG-RRTA Update', true);
	    }
	   else
	    {
	    $("#rtaupdategrid").jqxGrid('exportdata', 'xls', 'RAG-RRTA Update');
	    }*/
	   
	   
	   
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
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
		
		<tr>
	  <td align="right"><label class="branch">RentalType</label></td>
      <td><select id="cmbchoose" name="cmbchoose" style="width:60%;"  value='<s:property value="cmbchoose"/>'>
      <option value="">--Select--</option><option value="rental">RENTAL</option><option value="lease">LEASE</option></select>&nbsp;&nbsp;
      
      </td>
    </tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	  <!-- <tr>
                          <td colspan="2"><center><input type="button" name="btncnfrm" id="btncnfrm" class="myButton" value="Confirm" onclick="funConfirm();"></center></td>
                          </tr> -->
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
	 <tr><td colspan="2">&nbsp;</td></tr>
  </table>

	 
	 
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="rtaupdiv"><jsp:include page="rtaupdateGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="maindoc" id="maindoc"  value='<s:property value="maindoc"/>'> 
		</tr>
	</table>
</tr>
</table>
</div>
</div>
</body>
