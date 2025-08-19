<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>

    <style>
        form label.error {
            color: red;
            font-weight: bold;
        }
        
        .hidden-scrollbar {
            overflow: auto;
            height: 500px;
        }
    </style>

    <jsp:include page="../../../includes.jsp"></jsp:include>

    <script type="text/javascript">
        $(document).ready(function() {
            /*$.ajax({
  				url: "getVendor.jsp",
  				context: document.body
			}).done(function() {
  				var htmldata=''
			});*/
            $("#uptodate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $("#fromdate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $("#todate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
            setDates();
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");
            $('.icon').attr('disabled', true);
            $('#btnGuideLine').attr('disabled', true);
            $('#driverwindow').jqxWindow({
                width: '60%',
                height: '55%',
                maxHeight: '55%',
                maxWidth: '60%',
                title: 'Driver Search',
                position: {
                    x: 250,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#driverwindow').jqxWindow('close');
            $('#fleetwindow').jqxWindow({
                width: '60%',
                height: '55%',
                maxHeight: '55%',
                maxWidth: '60%',
                title: 'Fleet Search',
                position: {
                    x: 250,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#fleetwindow').jqxWindow('close');
            $('#locationwindow').jqxWindow({
                width: '70%',
                height: '58%',
                maxHeight: '62%',
                maxWidth: '50%',
                title: 'Location Search',
                position: {
                    x: 250,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#locationwindow').jqxWindow('close');
            $('#brandwindow').jqxWindow({
                width: '30%',
                height: '55%',
                maxHeight: '55%',
                maxWidth: '30%',
                title: 'Brand Search',
                position: {
                    x: 250,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#brandwindow').jqxWindow('close');
            $('#modelwindow').jqxWindow({
                width: '30%',
                height: '55%',
                maxHeight: '55%',
                maxWidth: '30%',
                title: 'Model Search',
                position: {
                    x: 250,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#modelwindow').jqxWindow('close');
            $('#groupwindow').jqxWindow({
                width: '30%',
                height: '55%',
                maxHeight: '55%',
                maxWidth: '30%',
                title: 'Group Search',
                position: {
                    x: 250,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#groupwindow').jqxWindow('close');
            $('#tarifwindow').jqxWindow({
                width: '40%',
                height: '55%',
                maxHeight: '55%',
                maxWidth: '40%',
                title: 'Tarif Search',
                position: {
                    x: 250,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#tarifwindow').jqxWindow('close');
            $('#vendorwindow').jqxWindow({
                width: '40%',
                height: '55%',
                maxHeight: '55%',
                maxWidth: '40%',
                title: 'Vendor Search',
                position: {
                    x: 250,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#vendorwindow').jqxWindow('close');
            $("#driver").dblclick(function() {
                $('#driverwindow').jqxWindow('open');
                $('#driverwindow').jqxWindow('focus');
                driverSearchContent('driverMasterSearch.jsp', $('#driverwindow'));
            });
			$("#vendor").dblclick(function() {
                if (document.getElementById("gridrowindex").value == "") {
                    var selectedrows = $('#bookDetailGrid').jqxGrid('getselectedrowindexes');
                    if (selectedrows.length == 0) {
                        $.messager.alert('Warning', 'Please select any valid rows');
                        return false;
                    } else {
                        document.getElementById("gridrowindex").value = selectedrows[0];
                    }
                }
                $('#vendorwindow').jqxWindow('open');
                $('#vendorwindow').jqxWindow('focus');
                vendorSearchContent('vendorSearchGrid.jsp?id=1', $('#vendorwindow'));
            });
            $("#fleetno").dblclick(function() {
                if (document.getElementById("gridrowindex").value == "") {
                    var selectedrows = $('#bookDetailGrid').jqxGrid('getselectedrowindexes');
                    if (selectedrows.length == 0) {
                        $.messager.alert('Warning', 'Please select any valid rows');
                        return false;
                    } else {
                        document.getElementById("gridrowindex").value = selectedrows[0];
                    }
                }
                $('#fleetwindow').jqxWindow('open');
                $('#fleetwindow').jqxWindow('focus');
                fleetSearchContent('fleetMasterSearch.jsp?gridrowindex=' + document.getElementById("gridrowindex").value, $('#fleetwindow'));
            });
            $('#pickuplocation,#dropofflocation').dblclick(function(){
            	var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
	        	if(selectedrows.length==0){
	        		$.messager.alert('Warning','Please select any valid jobs');
	        		return false;
	        	}
            	$('#locationwindow').jqxWindow('open');
				$('#locationwindow').jqxWindow('focus');
				locationSearchContent('locationSearchGrid.jsp?id=1&locationtype='+$(this).attr("id"));
            });
            $('#group').dblclick(function(){
            	var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
	        	if(selectedrows.length==0){
	        		$.messager.alert('Warning','Please select any valid jobs');
	        		return false;
	        	}
            	$('#groupwindow').jqxWindow('open');
   				$('#groupwindow').jqxWindow('focus');
   				groupSearchContent('groupSearchGrid.jsp?id=1');
            });
            getBrch();
            funSetProcess();
            //$('#btndetailsave').hide();
        });

		function funGetLocation(event,id) {
			var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
        	if(selectedrows.length==0){
        		$.messager.alert('Warning','Please select any valid jobs');
        		return false;
        	}
            var x = event.keyCode;
            if (x == 114) {
                $('#locationwindow').jqxWindow('open');
				$('#locationwindow').jqxWindow('focus');
				locationSearchContent('locationSearchGrid.jsp?id=1&locationtype='+id);
            }
        }
        
        function funGetGroup(event) {
        	var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
        	if(selectedrows.length==0){
        		$.messager.alert('Warning','Please select any valid jobs');
        		return false;
        	}
            var x = event.keyCode;
            if (x == 114) {
                $('#groupwindow').jqxWindow('open');
   				$('#groupwindow').jqxWindow('focus');
   				groupSearchContent('groupSearchGrid.jsp?id=1');
            }
        }
        function funGetVendor(event) {
        	var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
        	if(selectedrows.length==0){
        		$.messager.alert('Warning','Please select any valid jobs');
        		return false;
        	}
            var x = event.keyCode;
            if (x == 114) {
                $('#vendorwindow').jqxWindow('open');
                $('#vendorwindow').jqxWindow('focus');
                vendorSearchContent('vendorSearchGrid.jsp?id=1', $('#vendorwindow'));
            }
        }
        function funUpdateDetail(){
			var pickuplocation=$('#pickuplocation').val();
        	var dropofflocation=$('#dropofflocation').val();
        	var group=$('#group').val();
        	if(pickuplocation=='' && dropofflocation=='' && group==''){
        		$.messager.alert('Warning','Please select any location or group');
        		document.getElementById("pickuplocation").focus();
        		return false;
        	}
        	var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
        	if(selectedrows.length==0){
        		$.messager.alert('Warning','Please select any valid jobs');
        		return false;
        	}
        	else{
        		$('#overlay,#PleaseWait').show();
	        	var gridarray=new Array();
	        	for(var i=0;i<selectedrows.length;i++){
	        		var bookdocno=$('#bookDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'bookdocno');
	        		var jobname=$('#bookDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'docname');
	        		var pickuplocid=$('#bookDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'pickuplocationid');
	        		var dropofflocid=$('#bookDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'dropofflocationid');
	        		var groupid=$('#bookDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'groupid');
	        		gridarray.push(bookdocno+" :: "+jobname+" :: "+pickuplocid+" :: "+dropofflocid+" :: "+groupid);
	        	}
	        	var x = new XMLHttpRequest();
            	x.onreadystatechange = function() {
	                if (x.readyState == 4 && x.status == 200) {
	                    items = x.responseText.trim();
	                    if(items=="0"){
	                    	$('#overlay,#PleaseWait').hide();
	                    	$.messager.alert("Message","Successfully Updated");
	                    	for(var i=0;i<selectedrows.length;i++){
	                    		$('#bookDetailGrid').jqxGrid('setcellvalue',selectedrows[i],'detailupdate',1);
	                    	}
	                    	$('#bookDetailGrid').jqxGrid('refresh');
	                    }else{
	                    	$('#overlay,#PleaseWait').hide();
	                    	$.messager.alert("Warning","Not Updated");
	                    }
	                } else {}
	            }
            	x.open("GET", "updateDetail.jsp?gridarray="+gridarray, true);
            	x.send();
        	}        	
        }
        
        function tarifSearchContent(url) {
            $.get(url).done(function(data) {
                $('#tarifwindow').jqxWindow('setContent', data);
            });
        }
		function vendorSearchContent(url) {
            $.get(url).done(function(data) {
                $('#vendorwindow').jqxWindow('setContent', data);
            });
        }
        function groupSearchContent(url) {
            $.get(url).done(function(data) {
                $('#groupwindow').jqxWindow('setContent', data);
            });
        }

        function brandSearchContent(url) {
            $.get(url).done(function(data) {
                $('#brandwindow').jqxWindow('setContent', data);
            });
        }

        function modelSearchContent(url) {
            $.get(url).done(function(data) {
                $('#modelwindow').jqxWindow('setContent', data);
            });
        }

        function locationSearchContent(url) {
            $.get(url).done(function(data) {
                $('#locationwindow').jqxWindow('setContent', data);
            });
        }

        function getBrch() {
            var x = new XMLHttpRequest();
            var items, brchItems, currItems;
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    items = x.responseText;
                    items = items.split('####');
                    brchIdItems = items[0].split(",");
                    brchItems = items[1].split(",");
                    var optionsbrch = '<option value="">--Select--</option>';
                    for (var i = 0; i < brchItems.length; i++) {
                        optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
                    }
                    $("select#cmbtransferbranch").html(optionsbrch);

                } else {}
            }
            x.open("GET", "../../controlcentre/masters/vehiclemaster/getBranch.jsp", true);
            x.send();
        }

        function getFleet(event) {
            var x = event.keyCode;
            if (x == 114) {
                $('#fleetwindow').jqxWindow('open');
                $('#fleetwindow').jqxWindow('focus');
                fleetSearchContent('fleetMasterSearch.jsp', $('#fleetwindow'));
            }
        }

        function getDriver(event) {

            var x = event.keyCode;
            if (x == 114) {
                $('#driverwindow').jqxWindow('open');
                $('#driverwindow').jqxWindow('focus');
                driverSearchContent('driverMasterSearch.jsp', $('#driverwindow'));
            }
        }

        function driverSearchContent(url) {
            $.get(url).done(function(data) {
                $('#driverwindow').jqxWindow('setContent', data);
            });
        }

        function fleetSearchContent(url) {
            $.get(url).done(function(data) {
                $('#fleetwindow').jqxWindow('setContent', data);
            });
        }

        function funSearchLoad() {
            //changeContent('mainSearch.jsp', $('#window'));
        }

        function funReadOnly() {
            $('#frmLimoJobAssignMultiple input').attr('readonly', true);
            $('#frmLimoJobAssignMultiple select').attr('disabled', true);
            $('#bookDetailGrid').jqxGrid('clear');
            //$('#bookCounterGrid').jqxGrid('clear');
            //$('#btndetailsave').hide();
        }

        function funRemoveReadOnly() {
            $('#frmLimoJobAssignMultipleBus input').attr('readonly', false);
            //$('#docno').attr('readonly', true);
            $('#uptodate').jqxDateTimeInput({
                disabled: false
            });
            $('#frmLimoJobAssignMultipleBus select').attr('disabled', false);
            $('#driver').attr('readonly', true);
            $('#fleetno').attr('readonly', true);
            //$('#client').attr('readonly', true);
            //$('#guest').attr('readonly', true);

        }

        function setValues() {
            document.getElementById("formdet").innerText = $('#formdetail').val() + " (" + $('#formdetailcode').val().trim() + ")";
            funSetlabel();
            if ($('#msg').val() != "") {
                $.messager.alert('Message', $('#msg').val());
            }
            funClearData();
        }

        function funClearData() {
            $('#uptodate,#fromdate,#todate').jqxDateTimeInput('setDate', new Date());
            //$('#bookCounterGrid').jqxGrid('clear');
            $('#bookDetailGrid').jqxGrid('clear');
            $("#cmbtransferbranch option:eq(0)").prop("selected", true);
            $("#cmbprocess option:eq(0)").prop("selected", true);
            $('#docno,#detaildocno,#bookdocno,#vocno,#type,#gridlength,#cldocno,#guestno,#jobname,#driver,#hiddriver,#fleetno,#vendor,#pickuplocation,#hidpickuplocation,#dropofflocation,#hiddropofflocation,#group,#hidgroup,#tarif,#hidtarif').val('');

        }

        function funFocus() {
            // document.getElementById("client").focus();   		
        }

        function funNotify() {
            return 0;
        }

        function funLoadData() {
            $('#bookDetailGrid').jqxGrid('clear');
            $('#overlay,#PleaseWait').show();
            var uptodate=$('#uptodate').jqxDateTimeInput('val');
            var chkuptodate=0;
            if(document.getElementById("chkuptodate").checked==true){
            	chkuptodate=1;
            }
            else{
            	chkuptodate=0;
            }
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            var branch=document.getElementById("brchName").value;
            $('#bookdetaildiv').load('bookDetailGrid.jsp?uptodate='+uptodate+'&id=1&branch='+branch+'&chkuptodate='+chkuptodate+'&fromdate='+fromdate+'&todate='+todate);
            $('#frmLimoJobAssignMultipleBus select').attr('disabled', false);
        }

        function funDetailSave() {
            var selectedrows = $('#bookDetailGrid').jqxGrid('getselectedrowindexes');
            if (selectedrows.length == 0) {
                $.messager.alert('Warning', 'Please select any valid jobs');
                return false;
            }
            $('#gridlength').val(selectedrows.length);
            for (var i = 0; i < selectedrows.length; i++) {
                var pickuplocation = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'pickuplocation');
                var dropofflocation = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'dropofflocation');
                var brand = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'brand');
                var model = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'model');
                var groupid = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'groupid');
                var gid = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'gid');
                var tarifdocno = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'tarifdocno');
                var detailupdate = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'detailupdate');
                if (pickuplocation == "" || pickuplocation == "undefined" || pickuplocation == null || typeof(pickuplocation) == "undefined") {
                    $.messager.alert("Warning", "Pick up location is mandatory");
                    return false;
                }
                if (dropofflocation == "" || dropofflocation == "undefined" || dropofflocation == null || typeof(dropofflocation) == "undefined") {
                    $.messager.alert("Warning", "Drop off location is mandatory");
                    return false;
                }
                if (groupid == "" || groupid == "undefined" || groupid == null || typeof(groupid) == "undefined") {
                    $.messager.alert("Warning", "Group is mandatory");
                    return false;
                }
                if (gid == "" || gid == "undefined" || gid == null || typeof(gid) == "undefined") {
                    $.messager.alert("Warning", "Group is mandatory,Make sure you click the Detail Update");
                    return false;
                }

                if (tarifdocno == "" || tarifdocno == "undefined" || tarifdocno == null || typeof(tarifdocno) == "undefined" || tarifdocno == "0") {
                    $.messager.alert("Warning", "Tarif is mandatory");
                    return false;
                }
                if (detailupdate == "" || detailupdate == "undefined" || detailupdate == null || typeof(detailupdate) == "undefined" || detailupdate == "0") {
                    $.messager.alert("Warning", "Please Update the details by clicking Update button in grid");
                    return false;
                }
                var type = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'type');
                var bookdocno = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'doc_no');
                var docname = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'docname');
                var detaildocno = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'detaildocno');
                var airportid = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'airportid');
                var greetdate = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'greetdate');
                var greettime = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'greettime');
                var greettime1 = '',
                    viptime1 = '',
                    boquetime1 = '';
                if (greettime != "" && greettime != null && greettime != "undefined" && typeof(greettime) != "undefined") {
                    var strgreettime = new Date(greettime);
                    greettime1 = (strgreettime.getHours() < 10 ? '0' + strgreettime.getHours() : strgreettime.getHours()) + ":" + (strgreettime.getMinutes() < 10 ? '0' : '') + strgreettime.getMinutes();
                }
                var greettarifdocno = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'greettarifdocno');
                var vipdate = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'vipdate');
                var viptime = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'viptime');
                if (viptime != "" && viptime != null && viptime != "undefined" && typeof(viptime) != "undefined") {
                    var strviptime = new Date(viptime);
                    viptime1 = (strviptime.getHours() < 10 ? '0' + strviptime.getHours() : strviptime.getHours()) + ":" + (strviptime.getMinutes() < 10 ? '0' : '') + strviptime.getMinutes();
                }
                var viptarifdocno = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'viptarifdocno');
                var boquedate = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'boquedate');
                var boquetime = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'boquetime');
                if (boquetime != "" && boquetime != null && boquetime != "undefined" && typeof(boquetime) != "undefined") {
                    var strboquetime = new Date(boquetime);
                    boquetime1 = (strboquetime.getHours() < 10 ? '0' + strboquetime.getHours() : strboquetime.getHours()) + ":" + (strboquetime.getMinutes() < 10 ? '0' : '') + strboquetime.getMinutes();
                }
                var boquetarifdocno = $('#bookDetailGrid').jqxGrid('getcellvalue', selectedrows[i], 'boquetarifdocno');

                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "grid" + i)
                    .attr("name", "grid" + i)
                    .attr("hidden", true);
                newTextBox.val(bookdocno + "::" + docname + "::" + detaildocno + "::" + type + "::" + airportid + "::" + greetdate + "::" + greettime1 + "::" + greettarifdocno + "::" + vipdate + "::" + viptime1 + "::" + viptarifdocno + "::" + boquedate + "::" + boquetime1 + "::" + boquetarifdocno);
                newTextBox.appendTo('form');
            }

            document.getElementById("mode").value = "A";
            $('#overlay,#PleaseWait').show();
            document.getElementById("frmLimoJobAssignMultipleBus").submit();
        }

        function funSetProcess() {
            var value = document.getElementById("cmbprocess").value;
            if (value == "1") {
                $('#driver').attr('disabled', true);
                $('#fleetno').attr('disabled', true);
                $('#cmbtransferbranch').attr('disabled', false);
                $('#vendor').attr('disabled', true);
            } else if (value == "2") {
                $('#driver').attr('disabled', false);
                $('#fleetno').attr('disabled', false);
                $('#cmbtransferbranch').attr('disabled', true);
                $('#vendor').attr('disabled', true);
            } else if(value=="3") {
                $('#driver').attr('disabled', true);
                $('#fleetno').attr('disabled', true);
                $('#cmbtransferbranch').attr('disabled', true);
            	$('#vendor').attr('disabled', false);
            }
        }
        
        function setDates(){
        	if(document.getElementById("chkuptodate").checked==true){
        		$('#fromdate,#todate').jqxDateTimeInput({disabled: true});
        		$('#uptodate').jqxDateTimeInput({disabled: false});
        	}
        	else{
        		$('#fromdate,#todate').jqxDateTimeInput({disabled: false});
        		$('#uptodate').jqxDateTimeInput({disabled: true});
        	}
        }
    </script>

</head>

<body onLoad="setValues();">

    <br/>
    <div id="mainBG" class="homeContent" data-type="background">
        <form id="frmLimoJobAssignMultipleBus" action="saveJobAssignmentMultipleBus" method="post" autocomplete="off">
            <jsp:include page="../../../header.jsp" />
            <div class='hidden-scrollbar'>
                <table width="100%">
                    <tr>
                        <td width="16%">
                            <table width="100%">
                                <tr>
                                    <td colspan="2">
                                        <div style="text-align:center;">
                                            <button type="button" id="btnload" class="myButton" onclick="funLoadData();">Load</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="43%" align="right"><input type="checkbox" name="chkuptodate" id="chkuptodate" onchange="setDates();">Upto Date</td>
                                    <td width="57%">
                                        <div id="uptodate" name="uptodate"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">From Date</td>
                                    <td>
                                        <div id="fromdate" name="fromdate"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="43%" align="right">To Date</td>
                                    <td width="57%">
                                        <div id="todate" name="todate"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <%-- <td colspan="2">
                                        <div id="bookcounterdiv">
                                            <jsp:include page="bookCounterGrid.jsp"></jsp:include>
                                        </div>
                                    </td> --%>
                                    <td colspan="2">
                                    	<fieldset style="border: 1px solid #CAC9C9;border-radius: 8px;">
                                    		<table style="width:100%;">
                                    			<tr>
                                    				<td align="right">Pick up location</td>
                                    				<td>
                                    					<input type="text" name="pickuplocation" id="pickuplocation" value='<s:property value="pickuplocation"/>' readonly placeholder="Press F3 to Search" onkeydown="funGetLocation(event,this.id);">
                                    					<input type="hidden" name="hidpickuplocation" id="hidpickuplocation" value='<s:property value="hidpickuplocation"/>' readonly>
                                    				</td>
                                    			</tr>
                                    			<tr>
				                                	<td align="right">Drop off location</td>
				                                    <td>
				                                    	<input type="text" name="dropofflocation" id="dropofflocation" value='<s:property value="dropofflocation"/>' readonly placeholder="Press F3 to Search" onkeydown="funGetLocation(event,this.id);">
				                                    	<input type="hidden" name="hiddropofflocation" id="hiddropofflocation" value='<s:property value="hiddropofflocation"/>' readonly>
				                                    </td>
				                                </tr>
				                                <tr>
				                                	<td align="right">Group</td>
				                                    <td>
				                                    	<input type="text" name="group" id="group" value='<s:property value="group"/>' readonly placeholder="Press F3 to Search" onkeydown="funGetGroup(event);">
				                                    	<input type="hidden" name="hidgroup" id="hidgroup" value='<s:property value="hidgroup"/>' readonly>
				                                    </td>
				                                </tr>
				                                <tr>
				                                	<td colspan="2" align="center"><button type="button" id="btnupdate" name="btnupdate" class="myButton" onclick="funUpdateDetail();">Update</button></td>
				                                </tr>
                                    		</table>	
                                    	</fieldset>
                                    </td>                                    
                                </tr>
                                <tr>
                                	<td colspan="2">
                                		<fieldset style="border: 1px solid #CAC9C9;border-radius: 8px;">
                                			<table style="width:100%;">
	                                			<tr>
				                                    <td align="right">Job</td>
				                                    <td>
				                                        <input type="text" name="jobname" id="jobname" value='<s:property value="jobname"/>'>
				                                    </td>
				                                </tr>
				                                <tr>
				                                    <td align="right">Process</td>
				                                    <td>
				                                        <select name="cmbprocess" id="cmbprocess" style="width:100%;" onchange="funSetProcess();">
				                                            <option value="">--Select--</option>
				                                            <option value="1">Branch Transfer</option>
				                                            <option value="2">Assignment</option>
				                                            <option value="3">External Vendors</option>
				                                        </select>
				                                    </td>
				                                </tr>
				                                <tr>
				                                    <td align="right">Driver</td>
				                                    <td>
				                                        <input type="text" name="driver" id="driver" value='<s:property value="driver"/>' readonly placeholder="Press F3 to Search">
				                                    </td>
				                                </tr>
				                                <input type="hidden" name="hiddriver" id="hiddriver" value='<s:property value="hiddriver"/>'>
				                                <tr>
				                                    <td align="right">Fleet</td>
				                                    <td>
				                                        <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' readonly placeholder="Press F3 to Search">
				                                    </td>
				                                </tr>
				                                <tr>
				                                    <td align="right">Transfer Branch</td>
				                                    <td>
				                                        <select name="cmbtransferbranch" id="cmbtransferbranch" style="width:100%;">
				                                            <option value="">--Select--</option>
				                                        </select>
				                                    </td>
				                                </tr>
				                                <tr>
				                                    <td align="right">Vendors</td>
				                                    <td>
				                                        <input type="text" name="vendor" id="vendor" value='<s:property value="vendor"/>' readonly placeholder="Press F3 to Search" onkeydown="funGetVendor(event);">
				                                        <input type="hidden" name="hidvendor" id="hidvendor" value='<s:property value="hidvendor"/>'>
				                                    </td>
				                                </tr>
				                                <tr>
				                                    <td colspan="2" align="center">
				                                        <button type="button" name="btndetailsave" id="btndetailsave" onclick="funDetailSave();" class="myButton">Save</button>
				                                    </td>
				                                </tr>
	                                		</table>
                                		</fieldset>
                                	</td>
                                </tr>
                                <tr><td colspan="2"><br><br><br><br><br></td></tr>
                            </table>
                        </td>
                        <td width="84%">
                            <div id="bookdetaildiv">
                                <jsp:include page="bookDetailGrid.jsp"></jsp:include>
                            </div>
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
                <input type="hidden" name="detaildocno" id="detaildocno" value='<s:property value="detaildocno"/>'>
                <input type="hidden" name="bookdocno" id="bookdocno" value='<s:property value="bookdocno"/>'>
                <input type="hidden" name="vocno" id="vocno" value='<s:property value="vocno"/>'>
                <input type="hidden" name="type" id="type" value='<s:property value="type"/>'>
                <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                <input type="hidden" name="guestno" id="guestno" value='<s:property value="guestno"/>'>
            </div>
            <div id="driverwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
            <div id="fleetwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
            <div id="locationwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
            <div id="modelwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
            <div id="brandwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
            <div id="tarifwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
            <div id="groupwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
			<div id="vendorwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
			
        </form>
    </div>
</body>

</html>