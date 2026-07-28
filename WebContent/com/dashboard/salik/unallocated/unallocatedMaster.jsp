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
    /* ---- Master UI layout skeleton (checklist Bugs 1-3) ---- */
    .master-container {
        display: flex;
        height: 100%;
        width: 100%;
        box-sizing: border-box;
    }
    .sidebar-filters {
        flex: 0 0 330px;
        width: 330px;
        height: 100%;
        background: #ECF8E0;
        box-sizing: border-box;
        overflow-y: auto;
    }
    .sidebar-scroll-content {
        padding: 12px;
        box-sizing: border-box;
    }
    .filter-card {
        background: #ffffff;
        border: 1px solid #e1e8ed;
        border-radius: 6px;
        padding: 12px;
        margin-bottom: 12px;
        box-sizing: border-box;
    }
    .filter-table {
        width: 100%;
        border-collapse: collapse;
    }
    .filter-table td {
        padding: 4px 6px;
        box-sizing: border-box;
    }
    .label-cell {
        font-size: 12px;
        font-weight: 600;
        color: #4e5e71;
        text-align: right;
        white-space: nowrap;
    }
    .filter-table input[type="text"],
    .filter-table select {
        width: 100%;
        height: 24px;
        padding: 2px 8px;
        border-radius: 4px;
        font-size: 12px;
        box-sizing: border-box;
    }
    .main-content-wrapper {
        flex: 1 1 auto;
        height: 100%;
        display: flex;
        flex-direction: column;
        box-sizing: border-box;
        min-width: 0;
    }
    .top-toolbar-container {
        width: 100%;
        padding: 10px 15px;
        background: #ffffff;
        border-bottom: 1px solid #e1e8ed;
        box-sizing: border-box;
        flex-shrink: 0;
    }
    .scrollable-grid-area {
        flex: 1 1 auto;
        overflow-y: auto;
        box-sizing: border-box;
        padding: 10px 15px;
    }
    .button-row {
        text-align: center;
        padding: 4px 6px;
    }
    .btn-submit,
    .myButton {
        height: 30px;
        padding: 0 12px;
        border-radius: 4px;
        font-size: 13px;
        line-height: 30px;
        background: #2563eb;
        color: #fff;
        border: none;
        cursor: pointer;
    }
    .btn-submit:hover,
    .myButton:hover {
        background: #1d4ed8;
    }
    .hidden-fields {
        display: none;
    }
</style>
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
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

<div class="master-container">

    <!-- Sidebar filters (Bug 2: no <table> wrapper, flex: 0 0 330px) -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Reg No</td>
                        <td align="left">
                            <input type="text" id="regno" name="regno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="regno"/>' onkeydown="getregno(event);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Tag No</td>
                        <td align="left">
                            <input type="text" id="tagno" name="tagno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="tagno"/>' onkeydown="gettagno(event);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td align="left"><div id='uptodate' name='uptodate' value='<s:property value="uptodate"/>'></div></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="button-row">
                            <input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="ALLOCATE" onclick="funallocate()">&nbsp;
                            <input type="button" class="myButton" name="clear" id="clear" value="Clear" onclick="funcleardata()">
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <fieldset>
                    <legend>Manual Allocate</legend>
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Salik Tag</td>
                            <td align="left"><input type="text" id="saliktag" name="saliktag" readonly="readonly" value='<s:property value="saliktag"/>'></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Fleet No</td>
                            <td align="left"><input type="text" id="fleet_no" name="fleet_no" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getfleet(event);" value='<s:property value="fleet_no"/>'></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Type</td>
                            <td align="left">
                                <select id="trftype" onchange="cleardatas()">
                                    <option value="RAG">Rental</option>
                                    <option value="LAG">Lease</option>
                                    <option value="STF">Staff</option>
                                    <option value="DRV">Driver</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Branch</td>
                            <td align="left">
                                <select id="cmballocatebranch" name="cmballocatebranch" value='<s:property value="cmballocatebranch"/>'>
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Convict</td>
                            <td align="left"><input type="text" id="typesearch" name="typesearch" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="gettypessearch(event)" onclick="this.placeholder='' " value='<s:property value="typesearch"/>'></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="button-row">
                                <input type="Button" name="allocates" id="allocates" class="myButton" value="Manual" onclick="funoneallocate()">
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>

        </div>

        <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;"><div hidden="true" id="hidediv"><img alt="Search User" src="<%=contextPath%>/icons/31load.gif"> </div></div>
    </div>

    <!-- Main content: heading.jsp moved to top toolbar (Bug 1) -->
    <div class="main-content-wrapper">
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
        <div class="scrollable-grid-area">
            <form action="">
                <div id="allodiv"><jsp:include page="allocatelistGrid.jsp"></jsp:include></div>
            </form>
        </div>
    </div>

</div>

<!-- Hidden fields pulled out of layout flow (Bug 6) -->
<div class="hidden-fields">
    <input type="hidden" id="gridlength" name="gridlength">
    <input type="hidden" id="rentaldoc" name="rentaldoc">
    <input type="hidden" id="leasedoc" name="leasedoc">
    <input type="hidden" id="drdoc" name="drdoc">
    <input type="hidden" id="staffdoc" name="staffdoc">
</div>

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
