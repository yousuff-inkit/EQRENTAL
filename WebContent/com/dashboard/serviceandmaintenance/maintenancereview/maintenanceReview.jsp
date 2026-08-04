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

.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}

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
    background: #fff;
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
.filter-table select,
.filter-table textarea {
    width: 100%;
    height: 24px;
    padding: 2px 8px;
    border-radius: 4px;
    font-size: 12px;
    box-sizing: border-box;
}
.filter-table textarea {
    height: 195px;
    resize: none;
    font: 10px Tahoma;
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
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
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
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $('#vehicleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vehicle Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#vehicleDetailsWindow').jqxWindow('close');
		 
		 $('#inspectionWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Inspection Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#txtvehicle').dblclick(function(){
			  vehicleSearchContent('vehicleDetailsGrid.jsp');
			});
	});
	
	function vehicleSearchContent(url) {
	    $('#vehicleDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vehicleDetailsWindow').jqxWindow('setContent', data);
		$('#vehicleDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function inspectionSearchContent(url) {
		 $('#inspectionWindow').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#inspectionWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function getVehicle(event){
        var x= event.keyCode;
        if(x==114){
        	vehicleSearchContent('vehicleDetailsGrid.jsp');
        }
        else{
         }
        }
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var type = $('#cmbtype').val();
		 var fleetno = $('#txtfleetno').val();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(type==''){
			 $.messager.alert('Message','Please Choose a Review Type.','warning');
			 return 0;
		 }

		 $("#overlay, #PleaseWait").show();
		 
		 if(type==1){
			 $("#serviceHistoryDiv").prop("hidden", true);
	       	 $("#accidentHistoryDiv").prop("hidden", false);
		     $("#accidentHistoryDiv").load("accidentHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
		 }
		 else{  
			 $("#accidentHistoryDiv").prop("hidden", true); 
	       	 $("#serviceHistoryDiv").prop("hidden", false);
		     $("#serviceHistoryDiv").load("serviceHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
		 }
		}
	
	function funClearInfo(){

  	     $('#cmbbranch').val('a');
  	     $('#fromdate').val(new Date());
  	 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 $("#cmbtype").val('');$("#txtvehicle").val('');$("#txtfleetno").val('');$("#txtvehdocno").val('');
		 
		 $("#accidentHistory").jqxGrid('clear');$("#serviceHistory").jqxGrid('clear');		
		 
		 if (document.getElementById("txtvehicle").value == "") {
		        $('#txtvehicle').attr('placeholder', 'Press F3 to Search'); 
		  }
		 document.getElementById("vehinfo").value="";     
		}
	
	function funMaintenancePrint(){
		var fleetno = $('#txtfleetno').val();
		 
		if(fleetno==''){
			 $.messager.alert('Message','Please Choose a Fleet.','warning');
			 return 0;
		 }
		
 	    if ($("#txtfleetno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("maintenanceReview.jsp");
	        
	        $("#txtfleetno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printMaintenanceReview?&fleetno="+document.getElementById("txtfleetno").value+'&branch='+document.getElementById("cmbbranch").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Fleet is Mandatory.','warning');
			return;
		}
	   }
	   
	   function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		 if(temp1=='1'){
		  	JSONToCSVCon(data2, 'AccidentHistory', true);
		 }
		 
		 if(temp1=='2'){
		    JSONToCSVCon(data1, 'ServiceHistory', true);
		 }
			
		 } else {
			 if(temp1=='1'){
	    			$("#accidentHistory").jqxGrid('exportdata', 'xls', 'AccidentHistory');
        	}
			if(temp1=='2'){
	    			$("#serviceHistory").jqxGrid('exportdata', 'xls', 'ServiceHistory');
        	}
		 }
	 }
	function funSearchdblclick(){   
		
	}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- Sidebar filters (Bug 2: no <table> wrapper, flex: 0 0 330px) -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Period</td>
                        <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Review</td>
                        <td align="left">
                            <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Accident History</option>
                                <option value="2">Service History</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Vehicle</td>
                        <td align="left">
                            <input type="text" id="txtvehicle" name="txtvehicle" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtvehicle"/>' ondblclick="funSearchdblclick();" onkeydown="getVehicle(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <textarea id="vehinfo" name="vehinfo" readonly="readonly"><s:property value="vehinfo"></s:property></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="button-row">
                            <input type="button" class="myButton" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                            <button class="myButton" type="button" id="btnMaintenancePrint" name="btnMaintenancePrint" onclick="funMaintenancePrint();">Print</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Main content: heading.jsp moved to top toolbar (Bug 1) -->
    <div class="main-content-wrapper">
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
        <div class="scrollable-grid-area">
            <div id="accidentHistoryDiv"><jsp:include page="accidentHistoryGrid.jsp"></jsp:include></div>
            <div id="serviceHistoryDiv" hidden="true"><jsp:include page="serviceHistoryGrid.jsp"></jsp:include></div>
        </div>
    </div>

</div>

</div>

<!-- Hidden fields pulled out of layout flow (Bug 6) -->
<div style="display:none;">
    <input type="hidden" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>'>
    <input type="hidden" id="txtvehdocno" name="txtvehdocno" value='<s:property value="txtvehdocno"/>'/>
</div>

<div id="vehicleDetailsWindow">
	<div></div><div></div>
</div>
<div id="inspectionWindow">
<div></div>
</div>
</div> 
</body>
</html>
