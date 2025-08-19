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
<script type="text/javascript">

$(document).ready(function () {     
	$('#branchlabel').hide();
	$('#branchdiv').hide();     
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#invdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#date").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
    $('#accounttypeSearchwindow').jqxWindow('close');
    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, keyboardCloseKey: 27});
    $('#costtpesearchwndow').jqxWindow('close');   
    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, keyboardCloseKey: 27});
    $('#costcodesearchwndow').jqxWindow('close');  
}); 
function CashSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#accounttypeSearchwindow').jqxWindow('open');
		$('#accounttypeSearchwindow').jqxWindow('setContent', data);

	}); 
	}
function costcodeSearchContent(url) {  
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#costcodesearchwndow').jqxWindow('open');
		$('#costcodesearchwndow').jqxWindow('setContent', data);

	}); 
	}  
	function costSearchContent(url) {
		 //alert(url);
			 $.get(url).done(function (data) {
				 
				 $('#costtpesearchwndow').jqxWindow('open');
			$('#costtpesearchwndow').jqxWindow('setContent', data);
	
		}); 
		} 
function funreload(event){
	  $("#nidiv").load("nipurchasegrid.jsp?id=1");                 
}
function funExportBtn(){                           
	    //JSONToCSVCon(data3excel, $('#refname').val()+' - '+$('#cmbtaxtype').val(), true);
	 }
function funcreate(){
	if($('#docno').val()==""){            
		$.messager.alert('warning','Please select a document');    
		return false;
	}
	var invno=$('#txtinvno').val();  
	if(invno==""){               
		$.messager.alert('warning','Please enter Inv No');      
		return false;
	}
	var accname=$('#accname').val();
	var accno=$('#accno').val();    
	var acctype=$('#acctype').val();    
	var invdate=$('#invdate').jqxDateTimeInput('val'); 
	var date=$('#date').jqxDateTimeInput('val');     
	var netamt=$('#netamt').val();  
	var desc=$('#txtdesc').val();                        
	var gridarray=new Array();      
	var rows = $("#nidescdetailsGrid").jqxGrid('getrows'); 
    var taxper=0.0;
    var bill="0";          
	for(var i=0 ; i < rows.length ; i++){     
		   var chks=rows[i].description;    
	 	   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){  
	 	   taxper=rows[i].taxper;   
	 	   if(taxper>0){
	 		  bill="1";         
	 	   }
		   gridarray.push(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "+rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].rowno+"::");
	 	   }      
	 	} 
   $.messager.confirm('Message', 'Do you want to create NI Purchase?', function(r){        
		     	if(r==false)
		     	  {   
		     		return false; 
		     	  }  
		     	else {
		    	     saveData(accname,accno,acctype,invdate,date,invno,netamt,desc,gridarray,bill);      
		     	}  
		 });      
}     
function saveData(accname,accno,acctype,invdate,date,invno,netamt,desc,gridarray,bill){     
	//alert("acgroup=="+acgroup);
	var x=new XMLHttpRequest();  
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items=x.responseText.split("###");          
	   if(parseInt(items[0])>0)                       
		{  
		   $.messager.alert('Message', 'CPU - '+items[1]+' Successfully Created ');
		    $('#accname').val('');
			$('#accno').val('');    
			$('#acctype').val('');    
			$('#txtinvno').val('');                   
			$('#netamt').val('');  
			$('#txtdesc').val('');     
			$('#nidescdetailsGrid').jqxGrid('clear');
			$('#jqxnipurchasegrid').jqxGrid('clear');         
		}
		else
		{       
			 $.messager.alert('Warning', 'Not Created');  
		}
	}   
	}        
	x.open("GET","savedata.jsp?puraccname="+accname+"&bill="+bill+"&accdoc="+accno+"&acctype="+acctype+"&invdate="+invdate+"&date="+date+"&gridarray="+encodeURIComponent(gridarray)+"&netamt="+netamt+"&desc="+desc+"&invno="+invno+"&docno="+$('#docno').val()+"&brhid="+$('#hidbrhid').val(),true);                                
	x.send();
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
	<table width="100%" > 
	<jsp:include page="../../heading.jsp"></jsp:include>
	    <tr><td colspan="2">&nbsp;</td></tr>
	    <tr><td colspan="2">&nbsp;</td></tr> 
	    <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr>   
	 <td align="right" width="25%"><label class="branch">Date</label></td>
	  <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div>      
      </td></tr>     
     <tr>   
	 <td align="right" width="25%"><label class="branch">Inv No</label></td>
	  <td align="left"><input type="text" id="txtinvno" name="txtinvno"  value='<s:property value="txtinvno"/>' style="width:85%;height:20px;">   
      </td></tr> 
       <tr>   
	 <td align="right" width="25%"><label class="branch">Inv Date</label></td>
	  <td align="left"><div id="invdate" name="invdate" value='<s:property value="invdate"/>'></div>      
      </td></tr>    
       <tr>   
	 <td align="right" width="25%"><label class="branch">Description</label></td>
	  <td align="left"><input type="text" id="txtdesc" name="txtdesc"  value='<s:property value="txtdesc"/>' style="width:85%;height:20px;">   
      </td></tr>       
     <tr>  
 	  <td colspan="2"><center><button name="btnupdate" id="btnupdate" onclick="funcreate();" class="myButton" style="width:65%;height:24px;">Create NI Purchase</button></center></td>  
     </tr> 	
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
			<td colspan="2"><div id="nidiv"><jsp:include page="nipurchasegrid.jsp"></jsp:include></div></td>    
		</tr>     
		<tr>
		<td colspan="2"><div id="descdiv"><jsp:include page="descgridDetails.jsp"></jsp:include></div> <br></td> 
		</tr>
		<tr>    
		</tr>    
	</table>  
</tr>   
</table>
<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'/>
<input type="hidden" id="accname" name="accname" value='<s:property value="accname"/>'/>
<input type="hidden" id="accno" name="accno" value='<s:property value="accno"/>'/>
<input type="hidden" id="acctype" name="acctype" value='<s:property value="acctype"/>'/> 
<input type="hidden" id="netamt" name="netamt" value='<s:property value="netamt"/>'/>
<input type="hidden" id="hidbrhid" name="hidbrhid" value='<s:property value="hidbrhid"/>'/>                     
 <div id="accounttypeSearchwindow">
	   <div></div>
	</div>
	<div id="costtpesearchwndow">
	   <div></div>
	</div>
	 <div id="costcodesearchwndow">
	   <div></div>
	</div> 
</div>
</div>
</body>
