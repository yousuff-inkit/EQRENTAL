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
<style type="text/css">
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    box-sizing: border-box;
}
.sidebar-filters {
    flex: 0 0 330px;
    width: 330px;
    height: 100%;
    background: #fff;
    overflow-y: auto;
    box-sizing: border-box;
}
.sidebar-scroll-content {
    padding: 10px;
    box-sizing: border-box;
}
.filter-card {
    background: #fff;
}
.filter-table .label-cell {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    text-align: right;
    width: 31%;
}
.filter-table td {
    padding: 3px 0;
}
.filter-table input[type="text"],
.filter-table select {
    height: 24px !important;
    padding: 2px 8px;
    border-radius: 4px;
    font-size: 12px;
    width: 84% !important;
    box-sizing: border-box;
}
.btn-submit, .myButton {
    height: 30px !important;
    padding: 0 12px;
    border-radius: 4px;
    font-size: 13px;
    line-height: 30px;
    background: #2563eb !important;
    color: #fff !important;
    border: none;
    cursor: pointer;
}
.btn-submit:hover, .myButton:hover {
    background: #1d4ed8;
}
.chart-card {
    width: 100%;
    box-sizing: border-box;
    margin-top: 20px;
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
    overflow: auto;
    box-sizing: border-box;
}
.hidden-fields {
    display: none;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
 
	
	
	// $('#vehiclewindow1').jqxWindow({ autoOpen: false,width: '80%', height: '80%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 240, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	  $('#movementwindow').jqxWindow({ autoOpen: false,width: '77%', height: '74%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Movement Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); 
 
});

function funreload(event)  
{     
	document.getElementById("fleetno").value="";
	document.getElementById("brach").value="";
	document.getElementById("grp").value="";
	 document.getElementById("docno").value="";
	 document.getElementById("rentaltype").value="";
	 document.getElementById("typeingrid").value="";
	
	 disitems();
		 var barchval = document.getElementById("cmbbranch").value;
     
	 $("#fleetdiv").load("vehlistshowgrid.jsp?brchval="+barchval);
	 
	
	}
	
 	
function disitems()
{
	 $('#btnvehicle').attr("disabled",true);
	 $('#btnmove').attr("disabled",true);
	 $('#btnupdate').attr("disabled",true);
	 $('#rentaltype').attr("disabled",true);
	 $('#fleetno').attr("disabled",true);
	 
	  
}
	
 function getVehicleMov(){
	  var fleetno=document.getElementById("fleetno").value;
	  var vals=0;
	  var ready="ready";
	  $('#movementwindow').jqxWindow('setContent', '');
	  $('#movementwindow').jqxWindow('open');  
	  movementSearchContent("<%=contextPath%>/com/dashboard/equipment/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+vals+"&todate="+vals+"&ready="+ready);
	 }
 
 function movementSearchContent(url) {
	 //$('#vehiclewindow').jqxWindow('open'); 
	 $('#movementwindow').jqxWindow('focus'); 
	 $.get(url).done(function (data) {
	$('#movementwindow').jqxWindow('setContent', data);
	}); 
	 
 }
 function changeClientAttachContent(url) {
		$.get(url).done(function (data) {
			    $('#windowattach').jqxWindow('open');
				$('#windowattach').jqxWindow('setContent',data);
				$('#windowattach').jqxWindow('bringToFront');
	}); 
	}
 function funClientAttach(){
	
	 
		if ($("#docno").val()!="") {
			  $("#windowattach").jqxWindow('setTitle',"EEM - "+document.getElementById("docno").value);
			changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=EEM&docno="+document.getElementById("docno").value);		
		} else {
			$.messager.alert('Message','Select Fleet....!','warning');
			return;
		}
	}

	
 function funsamechk()
 {
	 
	 if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value)
	 {
		 $.messager.alert('Message','Rent Type Is Same','warning');   
		 document.getElementById("rentaltype").focus();
					 
		 return 0;
	 }
	 
 }
 
 
 
		  function funupdate()
		  
			{

			  
			  if(document.getElementById("rentaltype").value=="")
				 {
					 $.messager.alert('Message','Select Rent Type ','warning');   
								 
					 return 0;
				 }
				
			  if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value)
				 {
					 $.messager.alert('Message','Rent Type Is Same','warning');   
					 document.getElementById("rentaltype").focus();
								 
					 return 0;
				 }
			  var fleetno=document.getElementById("fleetno").value;
			  
			  var renttype=document.getElementById("rentaltype").value;
			  
			  savegriddata(fleetno,renttype);
			 
			}	
				
	
		
			function savegriddata(fleetno,renttype)
			{
				
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					
						var items=x.responseText;
						 document.getElementById("rentaltype").value="";
						 document.getElementById("fleetno").value="";
						 document.getElementById("brach").value="";
						 document.getElementById("grp").value="";
						 document.getElementById("docno").value="";
						 document.getElementById("typeingrid").value="";
						  
			              $.messager.alert('Message', '  Record Successfully Updated ', function(r){
					 		   
					     });
						 funreload(event); 
						 
						 disitems();
						 
						
						}
					
				}
					
			x.open("GET","saverenttype.jsp?fleet="+fleetno+"&renttype="+renttype,true);

			x.send();
					
			}
			
			
			function funExportBtn(){
				
				$("#movementwindow").excelexportjs({     
		       		containerid: "movementwindow", 
		       		datatype: 'json', 
		       		dataset: null, 
		       		gridId: "jqxFleetGrid",            
		       		columns: getColumns("jqxFleetGrid") , 
		       		worksheetName:"Rent Status"    
		       		}); 
				   
				   
				   
				   
					 /*if(parseInt(window.parent.chkexportdata.value)=="1")
					 {
					 JSONToCSVCon(sssss, 'Rent Status', true);
					 }
				 else
					 {
					   $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Rent Status');
					 }*/
					   
					
				   
				 }			
			
			
			
			
			
</script>
</head>
  
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="master-container">
	<div class="sidebar-filters">
		<div class="sidebar-scroll-content">
			<div class="filter-card">
				<table class="filter-table" width="100%">
					<tr><td class="label-cell">Fleet</td><td><input type="text" name="fleetno" id="fleetno" readonly="readonly" value='<s:property value="fleetno"/>' ></td></tr>
					<tr>
					  <td class="label-cell">RentType</td>
					  <td><select name="rentaltype" id="rentaltype" value='<s:property value="rentaltype"/>' onchange="funsamechk()">
					    <option value="" selected>--Select--</option>
					    <option value="R" selected>Rental</option>
					    <option value="L">Lease</option>
					    <option value="LM">Limousine</option>
					    <option value="A">All</option>
					    </select></td>
					</tr>
					<tr>
					  <td colspan="2" align="center"><input type="button" name="btnupdate" id="btnupdate" value="Update" class="btn-submit" onclick="funupdate();"></td>
					</tr>
					<tr>
					  <td colspan="2" align="center">
					    <input type="button" name="btnvehicle" id="btnvehicle" value="Attach" class="myButton" onclick="funClientAttach();">
					    <input type="button" name="btnmove" id="btnmove" value="Movement" class="myButton" onClick="getVehicleMov();">
					  </td>
					</tr>
				</table>
				<div class="chart-card">
					<div id='pieChart1' style="width: 100%; align:right; height: 170px;"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="main-content-wrapper">
		<div class="top-toolbar-container">
			<jsp:include page="../../heading.jsp"></jsp:include>
		</div>
		<div class="scrollable-grid-area">
			<div id="fleetdiv"><jsp:include page="vehlistshowgrid.jsp"></jsp:include></div>
		</div>
	</div>
</div>
<div class="hidden-fields">
	<input type="hidden" name="brach" id="brach" readonly="readonly" value='<s:property value="brach"/>' >
	<input type="hidden" name="grp" id="grp" readonly="readonly" value='<s:property value="grp"/>' >
	<input type="hidden" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>' >
	<input type="hidden" name="typeingrid" id="typeingrid" readonly="readonly" value='<s:property value="typeingrid"/>' >
</div>
<label hidden="true" id="trncodeval"></label>
 <label  hidden="true" id="statusval"></label>

<div id="movementwindow">
<div></div>
</div> 

</div>


</body>
</html>
