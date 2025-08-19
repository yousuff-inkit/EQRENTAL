 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
	

$(document).ready(function () {
	//getbankname();
	document.getElementById("rdheader").checked=true;
});


 	function printlogo() {
 					
			//$("#docno").prop("disabled", false);                
			var dtype=$('#formdetailcode').val();
			var brhid=$("#brchName").val();
			 var accno = $('#txtacountno').val();
			 var level1from = $('#txtlevel1from').val();
			 var level1to = $('#txtlevel1to').val();
			 var level2from = $('#txtlevel2from').val();
			 var level2to = $('#txtlevel2to').val();
			 var level3from = $('#txtlevel3from').val();
			 var level3to = $('#txtlevel3to').val();
			 var level4from = $('#txtlevel4from').val();
			 var level4to = $('#txtlevel4to').val();
			 var level5from = $('#txtlevel5from').val();
			 var xlstat=$('#xlstat').val();

		  		
		  		if(xlstat==""){
		  			$.messager.alert('Message','Select XL status option...','warning');
		  		}
			
			if(accno==''){
				 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
				 return 0;
			 }
			var header=0;
	 		if(document.getElementById("rdheader").checked==true){
	 			header=1;
	 		} else if(document.getElementById("rdnoheader").checked==true){
	 			header=0;
	 		}
	 		  var url=document.URL;
		        var reurl=url.split("ageingStatement.jsp");
		        console.log("ac print");   
		        $("#txtacountno").prop("disabled", false);
		        var win= window.open(reurl[0]+"printAgeingOutstandingsStatement?&acno="+document.getElementById("txtacountno").value+'&header='+header+'&xlstat='+xlstat+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        win.focus();
				funGetOutstandingTable(); 
			//var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header="+header+"&bankdocno="+bankdocno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			
		 
		
 		$('#printWindow').jqxWindow('close');
 	}

 	function funxlshowcheck(){
 		if(document.getElementById("rdbnxlshow").checked){
 				$('#xlstat').val("0");
 			}
 			if(document.getElementById("rdbnxlhide").checked){
 				$('#xlstat').val("1");
 			}
 	}

</script>

<body>
<div id=searchprint>
<br/>
<table width="100%">

  <tr>
    <td>&nbsp;</td>
    <td colspan="3" align="center"><input type="radio" id="rdheader" name="rdo" value="rdheader" checked="checked">With Header
    <input type="radio" id="rdnoheader" name="rdo" value="rdnoheader" >Without Header</td>
  </tr>
  
   <tr>
<td>&nbsp; <input type="hidden" id="xlstat" name="xlstat" value="0" /></td>
    <td colspan="3" align="center width="100%"><input type="radio" id="rdbnxlshow" name="rdbnxl" onchange="funxlshowcheck();" value="Show xl" checked="checked">&nbsp;<label id="lblwithoutxl">Print</label>
    <input type="radio" id="rdbnxlhide" name="rdbnxl" onchange="funxlshowcheck();" value="Hide xl" ><label id="lblwithxl">With Excel</label>
    							 </td>
    
    </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td width="87%" align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="Print"  onclick="printlogo();"></td>
    <td width="76%">&nbsp;</td>
  </tr>
 

</table>
&nbsp;
  </div>
</body>
</html>