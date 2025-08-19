<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
	<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
</head>

<body onload="getBranch();setValues();">
    <form id="frmLimoImportData" method="post" action="saveLimoImportData">
        <div id="mainBG" class="homeContent" data-type="background">
            <div class='hidden-scrollbar'>
                <table width="100%">
                    <tr>
                        <td width="20%">
                            <fieldset style="background: #ECF8E0;">
                                <table width="100%">
                                    <jsp:include page="../../heading.jsp"></jsp:include>

                                    <tr>
                                        <td width="41%" align="right">
                                            <label class="branch">From Date</label>
                                        </td>
                                        <td colspan="2">
                                            <div id="fromdate" name="fromdate"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <label class="branch">To Date</label>
                                        </td>
                                        <td>
                                            <div id="todate" name="todate"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                        	<label class="branch">Client</label>
                                        </td>
                                        <td>
                                            <input type="text" name="clientname" id="clientname" onkeydown="getClient(event);" placeholder="Press F3 to search" readonly style="height:18px;">
                                            <input type="hidden" name="cldocno" id="cldocno">
                                        </td>

                                    </tr>

                                    <tr>
                                        <td align="center" colspan="2">
                                            <input type="file" id="file" name="file" style="margin-bottom:10px;" />
                                            <button type="button" name="btndownload" id="btndownload" class="myButton" onclick="return upload();">Download</button>
                                            <button type="button" name="btncreatebook" id="btncreatebook" class="myButton" onclick="funCreateBooking();">Create Booking</button>
                                            <!-- <button type="button" name="btnimportpdf" id="btnimportpdf" class="myButton" onclick="funimportPDF();">Import PDF</button> -->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td width="80%">
                            <table width="100%">
                                <tr>
                                    <td rowspan="2">
                                        <div id="importdatadiv">
                                            <jsp:include page="importDataGrid.jsp"></jsp:include>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                    </tr>
                </table>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
                <input type="hidden" name="gridarray" id="gridarray" value='<s:property value="gridarray"/>'>
                <input type="hidden" name="limobookvocno" id="limobookvocno" value='<s:property value="limobookvocno"/>'>
            </div>
            <div id="clientwindow">
                <div></div>
            </div>
            <div id="locationwindow">
                <div></div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");
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
                var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
                var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth() - 1));
                $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
                $('#clientwindow').jqxWindow({
                    width: '70%',
                    height: '58%',
                    maxHeight: '62%',
                    maxWidth: '50%',
                    title: 'Client Search',
                    position: {
                        x: 250,
                        y: 60
                    },
                    keyboardCloseKey: 27
                });
                $('#clientwindow').jqxWindow('close');
                $('#locationwindow').jqxWindow({
                    width: '70%',
                    height: '58%',
                    maxHeight: '62%',
                    maxWidth: '50%',
                    title: 'Client Search',
                    position: {
                        x: 250,
                        y: 60
                    },
                    keyboardCloseKey: 27
                });
                $('#locationwindow').jqxWindow('close');

                $('#clientname').dblclick(function() {
                    $('#clientwindow').jqxWindow('open');
                    $('#clientwindow').jqxWindow('focus');
                    clientSearchContent('clientSearchGrid.jsp?id=1');
                });
            });
			
			function setValues(){
				if($('#msg').val()!=''){
					if($('#limobookvocno').val()=='0')
					{
						$.messager.alert('warning','Not Saved');	
					}
					else{
						$.messager.alert('Message','Limousine Booking successfully generated #'+$('#limobookvocno').val());
					}
				}
			}
            function funCreateBooking() {
                var selectedrows = $('#importDataGrid').jqxGrid('getselectedrowindexes');
                if (selectedrows.length == 0) {
                    $.messager.alert('Warning', 'Please select a valid document');
                    return false;
                }
                var docno = $('#docno').val();
                if (selectedrows.length > 0) {
                    if ($('#docno').val() == '') {
                        $('#docno').val($('#importDataGrid').jqxGrid('getcellvalue', selectedrows[0], 'rdocno'));
                        docno = $('#docno').val();
                    }
                }
                if (docno == '') {
                    $.messager.alert('Warning', 'Please select a valid document');
                    return false;
                }
                
                $.messager.confirm('Confirm', 'Do you want to Generate Booking?', function(r){
 					if(r){
                		var gridarray = new Array();
		                for (var i = 0; i < selectedrows.length; i++) {
		                    var guestdetails = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'guestdetails');
		                    var pax = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'pax');
		                    var pickupdate = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'pickupdate');
		                    var pickuptime = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'pickuptime');
		                    var pickupaddress = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'pickupaddress');
		                    var dropoffaddress = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'dropoffaddress');
		                    var vehicledetails = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'vehdetails');
		                    var otherdetails=$('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'otherdetails');
		                    var remarks=$('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'remarks');
		                    var refno=$('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'refno');
		                    gridarray.push(guestdetails.replace(/,/g, ' ')+" :: "+pax.replace(/,/g, '')+" :: "+pickupdate.replace(/,/g, '')+" :: "+pickuptime.replace(/,/g, '')+" :: "+pickupaddress.replace(/,/g, ' ')+" :: "+dropoffaddress.replace(/,/g, ' ')+" :: "+vehicledetails.replace(/,/g, ' ')+" :: "+otherdetails.replace(/,/g, ' ')+" :: "+remarks.replace(/,/g, ' ')+" :: "+refno.replace(/,/g, ''));
		                }
		                console.log(gridarray);
		                document.getElementById("gridarray").value=gridarray;
		                document.getElementById("mode").value="A";
		                $("#overlay, #PleaseWait").show();
	    	    		document.getElementById("frmLimoImportData").submit();
                	}
    		 	});
                
				/*
                var gridarray = new Array();
                for (var i = 0; i < selectedrows.length; i++) {
                    var guestdetails = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'guestdetails');
                    var pax = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'pax');
                    var pickupdate = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'pickupdate');
                    var pickuptime = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'pickuptime');
                    var pickupaddress = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'pickupaddress');
                    var dropoffaddress = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'dropoffaddress');
                    var vehicledetails = $('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'vehdetails');
                    var otherdetails=$('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'otherdetails');
                    var remarks=$('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'remarks');
                    var refno=$('#importDataGrid').jqxGrid('getcellvalue', selectedrows[i], 'refno');
                    gridarray.push(encodeURIComponent(guestdetails)+" :: "+encodeURIComponent(pax)+" :: "+encodeURIComponent(pickupdate)+" :: "+encodeURIComponent(pickuptime)+" :: "+encodeURIComponent(pickupaddress)+" :: "+encodeURIComponent(dropoffaddress)+" :: "+encodeURIComponent(vehicledetails)+" :: "+encodeURIComponent(otherdetails)+" :: "+encodeURIComponent(remarks)+" :: "+encodeURIComponent(refno));
                }

                $('#overlay,#PleaseWait').show();
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        $('#overlay,#PleaseWait').hide();
                        if (items.split("::")[0] == "0") {
                            var bookno = items.split("::")[1];
                            $.messager.alert('Message', 'Limousine Booking Created Successfully #' + bookno);
                            $('#docno,#selectedrow,#clientname,#cldocno').val('');
                            funreload("");
                        } else {
                            $.messager.alert('Warning', 'Not Saved');
                        }
                    }
                }
                console.log("createLimoBooking.jsp?docno=" + docno + "&gridarray=" + gridarray);
                x.open("POST", "createLimoBooking.jsp?docno=" + docno + "&gridarray=" + gridarray, true);
                x.send();
            */
            }

            function funCheckLocation(pickuplocation, dropofflocation) {
                pickuplocation = encodeURIComponent(pickuplocation.trim());
                dropofflocation = encodeURIComponent(dropofflocation.trim());
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (parseInt(items.split("::")[0]) <= 0) {
                            $.messager.alert('Warning', 'Pickup Location is mandatory');
                            return false;
                        } else if (parseInt(items.split("::")[1]) <= 0) {
                            $.messager.alert('Warning', 'Dropoff Location is mandatory');
                            return false;
                        }
                    }
                }
                x.open("GET", "checkLocation.jsp?pickuplocation=" + pickuplocation + "&dropofflocation=" + dropofflocation, true);
                x.send();
            }

            function funreload(event) {
                var cldocno = $('#cldocno').val();
                var fromdate = $('#fromdate').jqxDateTimeInput('val');
                var todate = $('#todate').jqxDateTimeInput('val');
                var branch = $('#cmbbranch').val();
                $('#importdatadiv').load('importDataGrid.jsp?cldocno=' + cldocno + '&fromdate=' + fromdate + '&todate=' + todate + '&branch=' + branch + '&type=1&id=1');
            }

            function getClient(event) {
                var x = event.keyCode;
                if (x == 114) {
                    clientSearchContent('clientSearchGrid.jsp?id=1');
                } else {}
            }

            function clientSearchContent(url) {
                $.get(url).done(function(data) {
                    $('#clientwindow').jqxWindow('setContent', data);
                });
            }

            function locationSearchContent(url) {
                $.get(url).done(function(data) {
                    $('#locationwindow').jqxWindow('setContent', data);
                });
            }

            function upload() {
                if (document.getElementById("file").files.length == 0) {
                    $.messager.alert('Warning', 'No File is Selected');
                    return false;
                }
                if (document.getElementById("cldocno").value == "") {
                    $.messager.alert('Warning', 'Client is mandatory');
                    return false;
                }
                var cldocno = $('#cldocno').val();
                $('#overlay,#PleaseWait').show();
                getAttachDocumentNo(cldocno);
            }

            function getAttachDocumentNo(cldocno) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items > 0) {
                            var path = document.getElementById("file").value;
                            var fsize = $('#file')[0].files[0].size;
                            var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
                            if ((extn == 'xls') || (extn == 'csv') || (extn == 'xlsx')) {
                                ajaxFileUpload(items);
                            } else {
                                $.messager.show({
                                    title: 'Message',
                                    msg: 'File of xlsx Format is not Supported.',
                                    showType: 'show',
                                    style: {
                                        left: '',
                                        right: 27,
                                        top: document.body.scrollTop + document.documentElement.scrollTop,
                                        bottom: ''
                                    }
                                });
                                return;
                            }
                        }
                    }
                }
                x.open("GET", "getAttachDocumentNo.jsp?cldocno=" + cldocno, true);
                x.send();
            }

            function ajaxFileUpload(docNo) {
                if (window.File && window.FileReader && window.FileList && window.Blob) {
                    var fsize = $('#file')[0].files[0].size;
                    if (fsize > 1048576) {
                        $.messager.show({
                            title: 'Message',
                            msg: fsize + ' bytes too big ! Maximum Size 1 MB.',
                            showType: 'show',
                            style: {
                                left: '',
                                right: 27,
                                top: document.body.scrollTop + document.documentElement.scrollTop,
                                bottom: ''
                            }
                        });
                        $('#overlay,#PleaseWait').hide();
                        return;
                    }
                } else {
                    $.messager.show({
                        title: 'Message',
                        msg: 'Please upgrade your browser, because your current browser lacks some new features we need!',
                        showType: 'show',
                        style: {
                            left: '',
                            right: 27,
                            top: document.body.scrollTop + document.documentElement.scrollTop,
                            bottom: ''
                        }
                    });
                    $('#overlay,#PleaseWait').hide();
                    return;
                }

                $.ajaxFileUpload({
                    url: 'fileAttachAction.action?formCode=BLID&doc_no=' + docNo + '&descpt=Excel Import',
                    secureuri: false,
                    fileElementId: 'file',
                    dataType: 'json',
                    success: function(data, status) {
                        if (status == 'success') {
                            saveExcelDataData(docNo);
                            /*$.messager.show({
                                title: 'Message',
                                msg: 'Successfully Uploaded',
                                showType: 'show',
                                style: {
                                    left: '',
                                    right: 27,
                                    top: document.body.scrollTop + document.documentElement.scrollTop,
                                    bottom: ''
                                }
                            });*/
                            $('#overlay,#PleaseWait').hide();
                        }
                        if (typeof(data.error) != 'undefined') {
                            if (data.error != '') {
                                $.messager.show({
                                    title: 'Message',
                                    msg: data.error,
                                    showType: 'show',
                                    style: {
                                        left: '',
                                        right: 27,
                                        top: document.body.scrollTop + document.documentElement.scrollTop,
                                        bottom: ''
                                    }
                                });
                                $('#overlay,#PleaseWait').hide();
                            } else {
                                $.messager.show({
                                    title: 'Message',
                                    msg: data.message,
                                    showType: 'show',
                                    style: {
                                        left: '',
                                        right: 27,
                                        top: document.body.scrollTop + document.documentElement.scrollTop,
                                        bottom: ''
                                    }
                                });
                                $('#overlay,#PleaseWait').hide();
                            }
                        }
                    },
                    error: function(data, status, e) {
                        $.messager.alert('Message', e);
                    }
                });
                return false;
            }

            function saveExcelDataData(docNo) {
            	var cldocno=$('#cldocno').val();
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items == 1) {
                            $("#importdatadiv").load("importDataGrid.jsp?docno=" + docNo + "&id=1&type=2");
                            $.messager.alert('Message', ' Successfully Imported.', function(r) {});
                            $('#docno').val(docNo);
                            //funreload("");
                        }
                        else{
                        	$.messager.alert('Message', 'Not Imported, please make sure Client No and Ref No are unique', function(r) {});
                        }
                    }
                }
                x.open("GET", "saveData.jsp?docNo="+docNo+"&cldocno="+cldocno, true);
                x.send();
            }

            function funimportPDF() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {

                    }
                }
                x.open("GET", "importPdf.jsp?asd=ad", true);
                x.send();
            }
        </script>
    </form>
</body>

</html>