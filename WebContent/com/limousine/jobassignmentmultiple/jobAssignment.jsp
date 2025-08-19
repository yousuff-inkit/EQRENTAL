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

            $("#uptodate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
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

			$('#vendorwindow').jqxWindow({
                width: '60%',
                height: '55%',
                maxHeight: '55%',
                maxWidth: '60%',
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
            $("#fleetno").dblclick(function() {
                $('#fleetwindow').jqxWindow('open');
                $('#fleetwindow').jqxWindow('focus');
                fleetSearchContent('fleetMasterSearch.jsp?gridrowindex=' + document.getElementById("gridrowindex").value, $('#fleetwindow'));
            });
            $("#vendor").dblclick(function() {
                $('#vendorwindow').jqxWindow('open');
                $('#vendorwindow').jqxWindow('focus');
                vendorSearchContent('vendorSearchGrid.jsp?id=1', $('#vendorwindow'));
            });
            getBrch();
            funSetProcess();
            //$('#btndetailsave').hide();
        });

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

		function getVendor(event) {

            var x = event.keyCode;
            if (x == 114) {
                $('#vendorwindow').jqxWindow('open');
                $('#vendorwindow').jqxWindow('focus');
                vendorSearchContent('vendorSearchGrid.jsp?id=1', $('#vendorwindow'));
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

		function vendorSearchContent(url) {
            $.get(url).done(function(data) {
                $('#vendorwindow').jqxWindow('setContent', data);
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
            $('#frmLimoJobAssignMultiple input').attr('readonly', false);
            //$('#docno').attr('readonly', true);
            $('#uptodate').jqxDateTimeInput({
                disabled: false
            });
            $('#frmLimoJobAssignMultiple select').attr('disabled', false);
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
            $('#uptodate').jqxDateTimeInput('setDate', new Date());
            //$('#bookCounterGrid').jqxGrid('clear');
            $('#bookDetailGrid').jqxGrid('clear');
            $("#cmbtransferbranch option:eq(0)").prop("selected", true);
            $("#cmbprocess option:eq(0)").prop("selected", true);
            $('#docno,#detaildocno,#bookdocno,#vocno,#type,#gridlength,#cldocno,#guestno,#jobname,#driver,#hiddriver,#fleetno,#vendor').val('');

        }

        function funFocus() {
            // document.getElementById("client").focus();   		
        }

        function funNotify() {
            return 0;
        }

        function funLoadData() {
            //$('#bookcounterdiv').load('bookCounterGrid.jsp?uptodate=' + $('#uptodate').jqxDateTimeInput('val') + '&id=1&branch=' + document.getElementById("brchName").value);
            $('#bookdetaildiv').load('bookDetailGrid.jsp?id=1&branch='+document.getElementById("brchName").value);
            //$('#frmLimoJobAssignMultiple input').attr('readonly', true);
            //$('#frmLimoJobAssignMultiple select').attr('disabled', true);
            $('#bookDetailGrid').jqxGrid('clear');
            $('#frmLimoJobAssignMultiple input').attr('readonly', false);
            $('#frmLimoJobAssignMultiple select').attr('disabled', false);
            //$('#btndetailsave').hide();
        }

        function funDetailSave() {
            var selectedrows = $('#bookDetailGrid').jqxGrid('getselectedrowindexes');
            if (selectedrows.length == 0) {
                $.messager.alert('Warning', 'Please select any valid jobs');
                return false;
            }
            $('#gridlength').val(selectedrows.length);
            for (var i = 0; i < selectedrows.length; i++) {
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
            document.getElementById("frmLimoJobAssignMultiple").submit();
        }

        function funSetProcess() {
            var value = document.getElementById("cmbprocess").value;
            if (value == "1") {
                $('#driver').attr('disabled', true);
                $('#fleetno').attr('disabled', true);
                $('#cmbtransferbranch').attr('disabled', false);
            } else if (value == "2") {
                $('#driver').attr('disabled', false);
                $('#fleetno').attr('disabled', false);
                $('#cmbtransferbranch').attr('disabled', true);
            } else {
                $('#driver').attr('disabled', true);
                $('#fleetno').attr('disabled', true);
                $('#cmbtransferbranch').attr('disabled', true);
            }
        }
    </script>

</head>

<body onLoad="setValues();">

    <br/>
    <div id="mainBG" class="homeContent" data-type="background">
        <form id="frmLimoJobAssignMultiple" action="saveJobAssignmentMultiple" method="post" autocomplete="off">
            <jsp:include page="../../../header.jsp" />
            <br>
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
                                    <td width="43%" align="right">Upto Date</td>
                                    <td width="57%">
                                        <div id="uptodate" name="uptodate"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <%-- <div id="bookcounterdiv">
                                            <jsp:include page="bookCounterGrid.jsp"></jsp:include>
                                        </div> --%>
                                    </td>
                                </tr>
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
                                        <input type="text" name="driver" id="driver" value='<s:property value="driver"/>' readonly placeholder="Press F3 to Search" onkeydown="getDriver(event);">
                                    </td>
                                </tr>
                                <input type="hidden" name="hiddriver" id="hiddriver" value='<s:property value="hiddriver"/>'>
                                <tr>
                                    <td align="right">Fleet</td>
                                    <td>
                                        <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' readonly placeholder="Press F3 to Search" onkeydown="getFleet(event);">
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
                                        <input type="text" name="vendor" id="vendor" value='<s:property value="vendor"/>' readonly placeholder="Press F3 to Search" onkeydown="getVendor(event);">
                                    </td>
                                    <input type="hidden" name="hidvendor" id="hidvendor" value='<s:property value="hidvendor"/>'>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <button type="button" name="btndetailsave" id="btndetailsave" onclick="funDetailSave();" class="myButton">Save</button>
                                    </td>
                                </tr>
                                <tr><td colspan="2"><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>
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
            <div id="vendorwindow">
                <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
            </div>
        </form>
    </div>
</body>

</html>