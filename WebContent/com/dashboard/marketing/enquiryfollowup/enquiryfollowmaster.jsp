
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

	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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

function funExportBtn(){
	   $("#enqfollowgrid").jqxGrid('exportdata', 'xls', 'Enquiry Follow Up');
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
	   $("#overlay, #PleaseWait").hide();
	   $("#duedetailsgrid").jqxGrid('clear');
	 $("#enqfollowdiv").load("enquiryfollowGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);

		   }
	
	}
	
function getinfo() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}
function funupdate()
{
	
	
	 if(document.getElementById("cmbinfo").value=="")
	 {
		 $.messager.alert('Message','Select Process ','warning');   
					 
		 return 0;
	 }
	
	 if($('#remarks').val()=="")
	 {
		 $.messager.alert('Message','Enter Remarks ','warning');   
		 return 0;
	 }
	
	 var remarkss = document.getElementById("remarks").value;
	 var nmax = remarkss.length;
		
		
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
   	
			return false; 
   	   
   	 
   	 
   	   } 
      
      var rdocno = document.getElementById("rdocno").value;
 	 var branchids = document.getElementById("branchids").value;
 	 var remarks = document.getElementById("remarks").value;
 	 var cmbinfo = document.getElementById("cmbinfo").value;
 	 var clname=document.getElementById("clname").value;
 	 var type=document.getElementById("type").value;
 	 var folldate =  $('#date').val();

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,type);	
	     	}
		     });
	
	
	
}
function savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,type)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 
			 document.getElementById("rdocno").value="";
			 document.getElementById("branchids").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			 document.getElementById("clname").value="";
			 document.getElementById("type").value=""; 
			 
			  $('#date').val(new Date());
			  
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
		 		 
		 		 
			     
		     });
			 funreload(event); 
			 $("#duedetailsgrid").jqxGrid('clear');
			disitems();
			 
			
			}
	}
		
x.open("GET","enqsavedata.jsp?rdocno="+rdocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&clname="+clname+"&type="+type,true);

x.send();
		
}

function disitems()
{
	
	 $('#date').jqxDateTimeInput({ disabled: true});
	
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	

	
}


function funchangeinfo()
{
	
	 $('#date').jqxDateTimeInput( 'focus');
		
	
	}
</script>
</head>
<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
		  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                   
	<%--  <tr>
	 <td colspan="2">
	 <table width="100%">
	 <tr>
	<td  align="right"><label class="branch" >From Date</label></td><td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
           
	</tr> 
	
	 <tr>
	<td align="right"><label class="branch">To Date</label></td><td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
    </tr>
     </table>
	</td> 
	 </tr> --%>
	  <tr><td colspan="2">&nbsp;</td></tr>   
	<tr> <td  align="right"><label class="branch">Process</label></td><td align="left">
 <select name="cmbinfo" id="cmbinfo" style="width:70%;" name="cmbinfo"  value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()" >
       

</select></td></tr>
	<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   </td></tr>

	 <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 


<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='cpppp' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table> 
	
<input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
<input type="hidden" name="rdocno" id="rdocno" style="height:20px;width:70%;" value='<s:property value="rdocno"/>' >
<input type="hidden" name="clname" id="clname" style="height:20px;width:70%;" value='<s:property value="clname"/>' >
<input type="hidden" name="type" id="type" style="height:20px;width:70%;" value='<s:property value="type"/>' >
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="enqfollowdiv"><jsp:include page="enquiryfollowGrid.jsp"></jsp:include></div></td>
		</tr>
		

		
		<tr>
		<td   ><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>

	</table>
</tr>
</table>

</div>
</div>
</body>
</html>