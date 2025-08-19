<% String contextPath=request.getContextPath();%>
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
<style>
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

     
      

</style>
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    /* Partial Pie Chart Starts*/
	$("#cmbbranch").attr('hidden',true);
    
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
	  $("#hidediv").hide();
	  
		 $('#regwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Reg No Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
		 $('#regwindow').jqxWindow('close');
		 $('#tagwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Tag No Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
		 $('#tagwindow').jqxWindow('close');
		 $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   	 $('#fleetwindow').jqxWindow('close');
	   	 $('#commonwindow1').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
	   	 $('#commonwindow1').jqxWindow('close');
	  	 $('#commonwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  	 $('#commonwindow').jqxWindow('close');
   
		 $('#regno').dblclick(function(){
		 	$('#regwindow').jqxWindow('open');
		 	ragnoContent('regnosearch.jsp?', $('#regwindow')); 
	     });
		 
		 $('#tagno').dblclick(function(){
		 	$('#tagwindow').jqxWindow('open');
		    tagnoContent('tagnosearch.jsp?', $('#tagwindow')); 
	    });
	    $('#fleet_no').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	        fleetSearchContent('fleetsearch.jsp?id=1', $('#fleetwindow')); 
       	});
       	
       	$('#typesearch').dblclick(function(){
		  	if(document.getElementById("trftype").value=="RAG"){
   				$('#commonwindow1').jqxWindow('open');
     			raSearchContent('ramasterSearch.jsp'); 
   			}
  	  		else if(document.getElementById("trftype").value=="LAG"){
	  			$('#commonwindow1').jqxWindow('open');
	     		raSearchContent('lamasterSearch.jsp'); 
	   		}
  			else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF"){
	  			$('#commonwindow').jqxWindow('open');
	     		SearchContent('searchdrvandstaff.jsp?id=1&values='+document.getElementById("trftype").value); 
	   		}
       });
   
});
function SearchContent(url) {
	$.get(url).done(function (data) {
		$('#commonwindow').jqxWindow('open');
		$('#commonwindow').jqxWindow('setContent', data);
	}); 
} 
function raSearchContent(url) {
	$.get(url).done(function (data) {
		$('#commonwindow1').jqxWindow('open');
		$('#commonwindow1').jqxWindow('setContent', data);
	}); 
} 
function getfleet(event){
	var x= event.keyCode;
	if(x==114){
		$('#fleetwindow').jqxWindow('open');
		fleetSearchContent('fleetsearch.jsp?id=1', $('#fleetwindow'));
	} 
	else{
	}
} 
function fleetSearchContent(url) {
	$.get(url).done(function (data) {
		$('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);
	}); 
}
function ragnoContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#regwindow').jqxWindow('open');
		$('#regwindow').jqxWindow('setContent', data);

	}); 
	} 

function getregno(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#regwindow').jqxWindow('open');


	  ragnoContent('regnosearch.jsp?', $('#regwindow'));     }
	 else{
		 }
	 }

function tagnoContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#tagwindow').jqxWindow('open');
		$('#tagwindow').jqxWindow('setContent', data);

	}); 
	} 

function gettagno(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#tagwindow').jqxWindow('open');


	  tagnoContent('tagnosearch.jsp?', $('#tagwindow'));      }
	 else{
		 }
	 }

function funExportBtn(){
	
	JSONToCSVCon(exceldatas, 'Salik Unallocated', true);
	  
	 }



function funreload(event)
{     
	
	
	  var val ="2";
	  var uptodate=$("#uptodate").val();
	  
	  var regno=$("#regno").val();
	  var tagno=$("#tagno").val();
	   $("#overlay, #PleaseWait").show();
	  $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate+'&regno='+regno+'&tagno='+tagno);
	
	
	}
	
	
	function hiddenbrh(){
		
		$("#branchlabel").attr('hidden',true);
		$("#branchdiv").attr('hidden',true);
		$('#gridlength').val(""); 
	}
	
	
	function funallocate()
	{
	

	    $.messager.confirm('Message', 'Do you want to Allocate?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	  
	     		$("#hidediv").show();
		/*    for(var i=0 ; i < rows.length ; i++){ */
		var saveval="10";

			 /*   ajaxcall(rows[i].fleet_no,rows[i].rdocno,rows[i].trancode,rows[i].trans,rows[i].tagno,saveval); */
			 
			   var regno=document.getElementById('regno').value;
			   var tagno=document.getElementById('tagno').value;
	
			   ajaxcall(saveval,regno,tagno);
	
		/*    }    */
	     	}
	    });
	}
	
/* 	function ajaxcall(fleet_no,rdocno,trancode,trans,tagno,saveval){ */
	
		function ajaxcall(saveval,regno,tagno){
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 var items= x.responseText;
				 	var itemval=items.trim();
				
				
				    if(parseInt(itemval)=="10")
				    	{
				    	$.messager.alert('Message', 'Allocation Not Processed');
					   funreload(event);
					    
					     $("#hidediv").hide();
				    	}
				    else if(parseInt(itemval)=="11")
				    	{
				    	
				    	   $.messager.alert('Message', '  Record Successfully Allocated ');
				    	      var val ="10";
							  var uptodate=$("#uptodate").val();
							  var regno=$("#regno").val();
							  var tagno=$("#tagno").val();
							  $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate+'&regno='+regno+'&tagno='+tagno);
					       $("#hidediv").hide();
		
				    	}
				    else
				    	{
				    	
				    	  $.messager.alert('Message', '  Not Allocated ');
					       funreload(event);
					       $("#hidediv").hide();
				    	
				    	}
				    
				    
				}
			else
				{
				
				}
		}
		x.open("GET","savedata.jsp?saveval="+saveval+'&regno='+regno+'&tagno='+tagno+"&uptodate="+$('#uptodate').jqxDateTimeInput('val'));
	//	x.open("GET","savedata.jsp?fleet_no="+fleet_no+"&rdocno="+rdocno+"&trancode="+trancode+"&trans="+trans+"&tagno="+tagno+"&saveval="+saveval,true);
		x.send();
	}
		function  funcleardata()
		{
			
			document.getElementById("regno").value="";
			document.getElementById("tagno").value="";
			
			 if (document.getElementById("regno").value == "") {
					
				 
			        $('#regno').attr('placeholder', 'Press F3 TO Search'); 
			    }
			 if (document.getElementById("tagno").value == "") {
					
				 
			        $('#tagno').attr('placeholder', 'Press F3 TO Search'); 
			    }
		}
		
		function getAllocateBranch() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim().split('####');
					var optionsbranch = "" ;
					var branchid  = items[0].split(",");
					var branchname = items[1].split(",");
					for (var i = 0; i < branchname.length; i++) {
						optionsbranch += '<option value="' + branchid[i].trim() + '">'
								+ branchname[i] + '</option>';
					}
					$("select#cmballocatebranch").html(optionsbranch);
				}
				else {
				}
			}
			x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
			x.send();
		}
		
		function gettypessearch(event){
	 		var x= event.keyCode;
	 		if(x==114){
   	  			if(document.getElementById("trftype").value=="RAG"){
	   				$('#commonwindow1').jqxWindow('open');
      				raSearchContent('ramasterSearch.jsp'); 
	   			}
   	  			else if(document.getElementById("trftype").value=="LAG"){
   		  			$('#commonwindow1').jqxWindow('open');
   		     		raSearchContent('lamasterSearch.jsp'); 
		   		}
   	  			else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF"){
   		  			$('#commonwindow').jqxWindow('open');
   		     		SearchContent('searchdrvandstaff.jsp?id=1&values='+document.getElementById("trftype").value); 
		   		}
	 		}
	 		else{
		 	}
	 	}
	 	
	 	function cleardatas()
	{
		document.getElementById("typesearch").value="";
		document.getElementById("rentaldoc").value="";
		document.getElementById("leasedoc").value="";
		document.getElementById("drdoc").value="";
		document.getElementById("staffdoc").value="";
	
	}
	
	
	
	function funoneallocate(){
		if(document.getElementById("fleet_no").value==""){
			$.messager.alert('Message',' Search Fleet ','warning');    
	        return false;
		}
		if(document.getElementById("typesearch").value==""){
			$.messager.alert('Message','Convict Search  ','warning');    
	        return false;
		}
		$.messager.confirm('Message', 'Do you want to Allocate?', function(r){
	    	if(r==false){
		        return false; 
		    }
		    else{
		    	doprocess();
		    }
     	});
	}
		
	function doprocess()
	{
		var salikarray=new Array();
		var selectedrows=$('#salikgrid').jqxGrid('selectedrowindexes');
		for(var i=0;i<selectedrows.length;i++){
			salikarray.push($('#salikgrid').jqxGrid('getcellvalue',selectedrows[i],'trans'));
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 var items= x.responseText;
				 var itemval=items.trim();
				 if(parseInt(itemval)=="10")
				 {
				   	$.messager.alert('Message', '  Record Successfully Allocated ');
				    var val="2";
					var uptodate=$("#uptodate").val();
					$("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
					$("#hidediv").hide();
					dis();
					funreload(event);
				 }
				 else
				 {
				 	$.messager.alert('Message', '  Not Allocated ');
					// funreload(event);
					$("#hidediv").hide();
				 }
			}
			else{
			}                                                                // trftype branchsss   rentaldoc leasedoc drdoc staffdoc
		}
		x.open("GET","saveonedata.jsp?salikarray="+salikarray+"&trftype="+document.getElementById("trftype").value
				+"&cmballocatebranch="+document.getElementById("cmballocatebranch").value+"&rentaldoc="+document.getElementById("rentaldoc").value
				+"&leasedoc="+document.getElementById("leasedoc").value+"&drdoc="+document.getElementById("drdoc").value
				+"&staffdoc="+document.getElementById("staffdoc").value+"&fleet_no="+document.getElementById("fleet_no").value);
	
		x.send();	
		
	}
	
	function dis()
		{
	
		
			
			document.getElementById("saliktag").value="";
			document.getElementById("fleet_no").value="";
			document.getElementById("typesearch").value="";
			 
		 
			 		
			document.getElementById("rentaldoc").value="";
			document.getElementById("leasedoc").value="";
			document.getElementById("drdoc").value="";
			document.getElementById("staffdoc").value="";
			
			
			 $('#ticketno').attr("disabled",true);
			 
			 $('#fleet_no').attr("disabled",true);
			 $('#trftype').attr("disabled",true);
			 $('#cmballocatebranch').attr("disabled",true);
			 $('#allocates').attr("disabled",true);
			 $('#typesearch').attr("disabled",true);
			 

			
			
		//	ticketno fleet_no trftype branchsss typesearch allocates  rentaldoc leasedoc drdoc staffdoc
		
		}
</script>
</head>
<body onload="hiddenbrh();getAllocateBranch();dis();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

	  <tr><td colspan="2">&nbsp;</td></tr> 


    <tr><td align="right"><label class="branch">Reg No</label></td>
	 <td align="left"><input type="text" id="regno" style="height:20px;width:70%;" name="regno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="regno"/>' onkeydown="getregno(event);" > </td></tr>
   <tr><td align="right"><label class="branch">Tag No</label></td>
	 <td align="left"><input type="text" id="tagno" style="height:20px;width:70%;" name="tagno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="tagno"/>' onkeydown="gettagno(event);" > </td></tr>
   
    <tr><td width="20%" align="right"><label class="branch">Up To</label></td><td align="left"><div id='uptodate' name='uptodate' value='<s:property value="uptodate"/>'></div></td></tr> 
     <!-- <tr><td colspan="2">&nbsp;</td></tr> 
      <tr><td colspan="2">&nbsp;</td></tr> 
      
       <tr><td colspan="2">&nbsp;</td></tr> 
        <tr><td colspan="2">&nbsp;</td></tr>  -->
        
   <tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="ALLOCATE" onclick="funallocate()">&nbsp;<input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td> </tr>     
	<tr><td colspan="2">
		<fieldset>
			<legend>Manual Allocate</legend>
			<table width="100%" >
            	<tr>
            		<td width="24%" align="right"><label class="branch">Salik Tag</label></td>
            		<td align="left"><input type="text" id="saliktag"  readonly="readonly"   style="height:20px;"  name="saliktag" value='<s:property value="saliktag"/>'></td>
            	</tr>
             	<tr>
             		<td width="20%" align="right"><label class="branch">Fleet No</label></td>
             		<td align="left"><input type="text" id="fleet_no" placeholder="Press F3 TO Search"  readonly="readonly" onkeydown="getfleet(event);"  style="height:20px;"  name="fleet_no" value='<s:property value="fleet_no"/>'></td>
             	</tr>
             	<tr>
             		<td width="20%" align="right"><label class="branch">Type</label></td>
             		<td align="left">
             			<select id="trftype" style="height:20px;width:86%; " onchange="cleardatas()" > 
             				<option value="RAG">Rental</option>
             				<option value="LAG">Lease</option>
             				<option value="STF">Staff</option>
             				<option value="DRV">Driver</option>
             			</select>
             		</td>
             	</tr>
    			<tr>
    				<td width="20%" align="right"><label class="branch">Branch</label></td>
    				<td align="left"> 
          				<select id="cmballocatebranch" style="height:20px;width:86%; " name="cmballocatebranch"   value='<s:property value="cmballocatebranch"/>'>
      						<option value="">--Select--</option>
      					</select>
      				</td>
      			</tr>
      			<tr>
      				<td width="20%" align="right"><label class="branch">Convict</label></td>
      				<td align="left"><input type="text" id="typesearch"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="gettypessearch(event)" onclick="this.placeholder='' "  style="height:20px;"  name="typesearch" value='<s:property value="typesearch"/>'></td>
      			</tr>
              	<tr><td colspan="2">&nbsp;</td></tr> 
                <tr><td  align="center" colspan="2"><input type="Button" name="allocates" id="allocates" class="myButton" value="Manual" onclick="funoneallocate()"></td></tr>  

          <tr><td colspan="2"><input type="hidden" id="gridlength" name="gridlength"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="rentaldoc" name="rentaldoc"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="leasedoc" name="leasedoc"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="drdoc" name="drdoc"></td></tr> 
         <tr><td colspan="2"><input type="hidden" id="staffdoc" name="staffdoc"></td></tr> 

	</table>
	
	    
	</fieldset>
	</td></tr>
<!--          <tr><td colspan="2">&nbsp;</td></tr> 
         

          <tr><td colspan="2">&nbsp;</td></tr> 
           <tr><td colspan="2">&nbsp;</td></tr> 
            
              <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
      <tr><td colspan="2">&nbsp;</td></tr> 
           
       <tr><td colspan="2">&nbsp;</td></tr> 
          <tr><td colspan="2">&nbsp;</td></tr>  -->
        <tr><td colspan="2"><input type="hidden" id="gridlength" name="gridlength"></td></tr> 
 

	</table>
	<div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;"><div hidden="true" id="hidediv"><img  alt="Search User" src="<%=contextPath%>/icons/31load.gif"> </div></div>
	</fieldset>
</td>
<td width="80%">
<form action="">
	<table width="100%">
		<tr>
 <td><div id="allodiv"><jsp:include page="allocatelistGrid.jsp"></jsp:include></div></td>
 
		</tr>
	</table>
	</form>
	</td>
</tr>
</table>
</div>
<div id="regwindow"><div></div>
</div>
<div id="tagwindow"><div></div>
</div>
<div id="fleetwindow"><div></div>
</div>
<div id="commonwindow"><div></div>
</div>
<div id="commonwindow1"><div></div>
</div>
</div>
</body>
</html>