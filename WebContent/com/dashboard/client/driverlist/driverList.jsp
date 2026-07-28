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

<style type="text/css">
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
        display: flex;
        align-items: center;
        justify-content: space-between;
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

    /* .icon1 kept - distinct icon-button style, actively used, not a master-button variant */
    .icon1 {
        width: 2.5em;
        height: 2em;
        border: none;
        background-color: #ECF8E0;
    }
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 
		 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close');
		 
		 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#nationalityWindow').jqxWindow('close');
 		 
    	 $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#stateWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#txtclientname').dblclick(function(){
			  clientSearchContent('clientDetailsSearch.jsp');
		 });
	     
	     document.getElementById("rddriverlist").checked=true;
	     $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true );
	     document.getElementById("mode").value="A";
	     //$('#txtadddriver').val(1);
	});
	
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function nationalitySearchContent(url) {
	 	$('#nationalityWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#nationalityWindow').jqxWindow('setContent', data);
		$('#nationalityWindow').jqxWindow('bringToFront');
	}); 
	}
  
  function stateSearchContent(url) {
	 	$('#stateWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#stateWindow').jqxWindow('setContent', data);
		$('#stateWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getIDPDetails(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			    $('#idpdetailsallowed').val(items);
		}
		}
		x.open("GET", "getIDPDetailsAllowed.jsp", true);
		x.send();
    }
	
	function getVisaNoAlreadyExists(visano,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					$.messager.alert('Message','ID# Already Exists.','warning');
  					 return 0;
  				 }
  			   
  		}
	}
	x.open("GET", "getVisaNoAlreadyExists.jsp?visano="+visano+"&docno="+docno+"&mode="+mode, true);
	x.send();
	}
  
  function getPassportNoAlreadyExists(passportno,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					$.messager.alert('Message','Passport# Already Exists.','warning');
  					 return 0;
  				 }
  			   
  		}
	}
	x.open("GET", "getPassportNoAlreadyExists.jsp?passportno="+passportno+"&docno="+docno+"&mode="+mode, true);
	x.send();
	}
	
	function getClient(event){
	      var x= event.keyCode;
	      if(x==114){
	    	  clientSearchContent('clientDetailsSearch.jsp');
	      } else{}
	}
	
	function funreload(event) {
		
		var branchval = document.getElementById("cmbbranch").value;
		var cldocno = $('#txtcldocno').val();
		 
		if(document.getElementById("rddriverlist").checked==true) {
			$("#overlay, #PleaseWait").show();
		 	$("#driverListDiv").load("driverListGrid.jsp?branchval="+branchval+"&cldocno="+cldocno+'&check=1');
		} else if(document.getElementById("rdadditionaldriver").checked==true) {
			 if(cldocno==''){
				 $.messager.alert('Message','Choose a Client and Add Driver.','warning');
				 return 0;
			 }
			 
			 var row = $("#addDriverGridID").jqxGrid('getrows');
			 if(row.length>=1){
				if(typeof(row[0].name) == "undefined" || typeof(row[0].name) == "NaN" || row[0].name.trim()==""){
					 $.messager.alert('Message','Please Enter Driver Informations and Add.','warning');
					 return 0;
				 }
			 }
				
		} else if(document.getElementById("rddeletedriver").checked==true) {
			if(cldocno==''){
				 $.messager.alert('Message','Choose a Client and Remove Driver.','warning');
				 return 0;
			 }
			$("#overlay, #PleaseWait").show();$('#btndelete').attr('disabled', false );
		 	$("#deleteDriverDiv").load("deleteDriverGrid.jsp?branchval="+branchval+"&cldocno="+cldocno+'&check=1');
		}
		
	}
	
	function funAdd(event){
		var cldocno = $('#txtcldocno').val();
		var branch = $('#cmbbranch').val();
		
		if(branch=='a'){
			 branch='1';
		 }
		
		if(cldocno==''){
			 $.messager.alert('Message','Client is Mandatory.','warning');
			 return 0;
		 }
		
		var row = $("#addDriverGridID").jqxGrid('getrows');
		if(row.length>=1){
			if(typeof(row[0].name) == "undefined" || typeof(row[0].name) == "NaN" || row[0].name.trim()==""){
				 $.messager.alert('Message','Please Enter Driver Informations and Add.','warning');
				 return 0;
			 }
		}
		
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		var rows = $("#addDriverGridID").jqxGrid('getrows');	
		     		var gridlength = rows.length-2;
				    for (var i = 0; i < rows.length; i++) {
				    	var chk=rows[i].name;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk.trim()!=""){
				    		saveGridData(cldocno,rows[i].name,rows[i].hiddob,rows[i].nation1,rows[i].mobno,rows[i].passport_no,rows[i].hidpassexp,rows[i].dlno,rows[i].hidissdate,rows[i].issfrm,rows[i].hidled,rows[i].ltype,rows[i].visano,rows[i].hidvisaexp,rows[i].dr_id,rows[i].hcdlno,rows[i].hidhcissdate,rows[i].hidhcled,branch,i,gridlength);
						}
				    }
		     	}
		 });
	}
	
	function funDelete(event){
		var cldocno = $('#txtcldocno').val();
		var branch = $('#cmbbranch').val();
		
		if(branch=='a'){
			 branch='1';
		 }
		
		if(cldocno==''){
			 $.messager.alert('Message','Client is Mandatory.','warning');
			 return 0;
		 }
		
		var selectedrows=$("#deleteDriverGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Drivers to be Removed.');
			return false;
		}
		
		    $.messager.confirm('Message', 'Do you want to remove?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else {
		     		
		     		var rows = $("#deleteDriverGridID").jqxGrid('getrows');
		     		var i=0;var j=0;var k=0;var tempdrid="";
		    	    for (i = 0; i < rows.length; i++) {
		    				if(selectedrows[j]==i){
		    					if(k==0){
		    						tempdrid=rows[i].dr_id;
		    						k=1;
		    					} else{
		    						tempdrid=tempdrid+","+rows[i].dr_id;
		    					}
		    				j++; 
		    			  }
		                }
		    	    $('#txtselecteddrivers').val(tempdrid);
		    	    
		    	    removeGridData(cldocno,$('#txtselecteddrivers').val(),branch);
		     	}
		 });
	}
	
	function saveGridData(cldocno,drivername,dob,nation,mobno,passportno,passexp,dlno,issdate,issfrm,led,ltype,visano,visaexp,drid,hcdlno,hcissdate,hcled,branch,i,gridlength) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				
				var cldocno = $('#txtcldocno').val('');
				var clientname = $('#txtclientname').val(''); 
				
				 if(items==gridlength){
					$.messager.alert('Message', '  Record Successfully Inserted ', function(r){
			  		});
				 }

				 $('#cmbbranch').val('a');document.getElementById("rddriverlist").checked=true;
				 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');
				 $("#deleteDriverGridID").jqxGrid('clear');$('#txtselecteddrivers').val('');
				 $("#driverListDiv").prop("hidden", false);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", true);
				 
				 if (document.getElementById("txtclientname").value == "") {
				        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
				 }
		   }
		}
			
	x.open("GET","saveData.jsp?cldocno="+cldocno+"&drivername="+drivername+"&dob="+dob+"&nation="+nation+"&mobno="+mobno+"&passportno="+passportno+"&passexp="+passexp+"&dlno="+dlno+"&issdate="+issdate+"&issfrm="+issfrm+"&led="+led+"&ltype="+ltype+"&visano="+visano+"&visaexp="+visaexp+"&drid="+drid+"&hcdlno="+hcdlno+"&hcissdate="+hcissdate+"&hcled="+hcled+"&branch="+branch+"&index="+i,true);
	x.send();
	}
	
	function removeGridData(cldocno,selecteddrivers,branch) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				
				var cldocno = $('#txtcldocno').val('');
				var clientname = $('#txtclientname').val(''); 
				
				 if(items.trim()=='1'){
					$.messager.alert('Message', '  Driver is in an Agreement. ', function(r){
			  		});
				 } else {
					 $.messager.alert('Message', '  Record Successfully Removed ', function(r){
				  	 }); 
				 }

				 $('#cmbbranch').val('a');document.getElementById("rddriverlist").checked=true;
				 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');
				 $("#deleteDriverGridID").jqxGrid('clear');$('#txtselecteddrivers').val(''); 
				 $("#driverListDiv").prop("hidden", false);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", true);
				 
				 if (document.getElementById("txtclientname").value == "") {
				        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
				 }
		   }
		}
			
	x.open("GET","removeData.jsp?cldocno="+cldocno+"&selecteddrivers="+selecteddrivers+"&branch="+branch,true);
	x.send();
	}
	
	function  funClearData() {
		$('#cmbbranch').val('a');$('#txtselecteddrivers').val('');
		$('#txtcldocno').val('');$('#txtclientname').val('');
		document.getElementById("rddriverlist").checked=true;
		$('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true );
		$("#driverListDiv").prop("hidden", false);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", true);
		$("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear');
		
		if (document.getElementById("txtclientname").value == "") {
	        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
	    }
	 }
	 
	function radioClick() {
		if(document.getElementById("rddriverlist").checked==true){
			 $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true);
			 $('#txtcldocno').val('');$('#txtclientname').val('');
			 $("#driverListDiv").prop("hidden", false);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", true);
			 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear'); 
			 if (document.getElementById("txtclientname").value == "") {
			        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
			 }
		} else if(document.getElementById("rdadditionaldriver").checked==true){
			 $('#btnadd').attr('disabled', false );$('#btndelete').attr('disabled', true );
			 $('#txtcldocno').val('');$('#txtclientname').val('');
			 $("#driverListDiv").prop("hidden", true);$("#addDriverDiv").prop("hidden", false);$("#deleteDriverDiv").prop("hidden", true);
			 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear'); 
			 $("#addDriverGridID").jqxGrid('addrow', null, {});
			 if (document.getElementById("txtclientname").value == "") {
			        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
			 }
		} else if(document.getElementById("rddeletedriver").checked==true){
			 $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true );
			 $('#txtcldocno').val('');$('#txtclientname').val('');
			 $("#driverListDiv").prop("hidden", true);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", false);
			 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear');
			 if (document.getElementById("txtclientname").value == "") {
			        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
			 }
		}
	}
	
	 function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'DriverList', true);
		 } else {
			 $("#driverListGridID").jqxGrid('exportdata', 'xls', 'DriverList');
		 }
	}
	
</script>
</head>
<body onload="getBranch();getIDPDetails();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- Sidebar filters (Bug 2: no <table> wrapper, flex: 0 0 330px) -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
                    <table width="100%">
                        <tr>
                            <td width="48%" align="center"><input type="radio" id="rddriverlist" name="rdo" onchange="radioClick();" value="rddriverlist"><label for="rddriverlist" class="branch">Driver List</label></td>
                            <td width="52%" align="center"><input type="radio" id="rddeletedriver" name="rdo" onchange="radioClick();" value="rddeletedriver"><label for="rddeletedriver" class="branch">Delete Driver</label></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><input type="radio" id="rdadditionaldriver" name="rdo" onchange="radioClick();" value="rdadditionaldriver"><label for="rdadditionaldriver" class="branch">Add Additional Driver</label></td>
                        </tr>
                    </table>
                </fieldset>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Client Name</td>
                        <td align="left">
                            <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="button-row">
                            <input type="button" class="myButton" name="clear" id="clear" value="Clear" onclick="funClearData();">
                            <span>
                                <button type="button" class="icon1" id="btnadd" title="Add Additional Driver" onclick="funAdd(event);">
                                    <img alt="Add Additional Driver" src="<%=contextPath%>/icons/driverAdd.png">
                                </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <button type="button" class="icon1" id="btndelete" title="Delete Driver" onclick="funDelete(event);">
                                    <img alt="Delete Driver" src="<%=contextPath%>/icons/driverDelete.png">
                                </button>
                            </span>
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
            <div id="driverListDiv"><jsp:include page="driverListGrid.jsp"></jsp:include></div>
            <div id="addDriverDiv" hidden="true"><jsp:include page="addDriverGrid.jsp"></jsp:include></div>
            <div id="deleteDriverDiv" hidden="true"><jsp:include page="deleteDriverGrid.jsp"></jsp:include></div>
        </div>
    </div>

</div>

<!-- Hidden fields pulled out of layout flow (Bug 6) -->
<div class="hidden-fields">
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="txtselecteddrivers" id="txtselecteddrivers" value='<s:property value="txtselecteddrivers"/>'>
    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
    <input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed">
</div>

</div>

<div id="clientDetailsWindow">
	<div></div>
</div>
<div id="nationalityWindow">
   <div></div>
</div>
<div id="stateWindow">
   <div></div>
</div>
</div> 
</body>
</html>
