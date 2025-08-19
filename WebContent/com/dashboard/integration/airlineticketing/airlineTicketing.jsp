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
        $(document).ready(function() {

            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            $("#branchlabel").attr('hidden', true);
            $("#branchdiv").attr('hidden', true);
        });

        function funreload(event) {
            $("#overlay, #PleaseWait").show();
            $('#airlineticketingdiv').load('airlineTicketingGrid.jsp?id=1');

        }

        function funExportBtn() {
            $("#airlineticketingdiv").excelexportjs({
                containerid: "airlineticketingdiv",
                datatype: 'json',
                dataset: null,
                gridId: "airlineTicketingGrid",
                columns: getColumns("airlineTicketingGrid"),
                worksheetName: "Airline Downloaded Data"
            });
        }

        function funimport() {

            $("#overlay, #PleaseWait").show();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if (parseInt(items) > 0) {
                        $("#overlay, #PleaseWait").hide();
                        $.messager.alert('Message', ' Data Imported ', 'warning');
                        $('#airlineticketingdiv').load('airlineTicketingGrid.jsp?docno=' + items + '&id=1');
                        return 0;
                    } else {
                        $("#overlay, #PleaseWait").hide();
                        $.messager.alert('Message', 'Not Imported ', 'warning');
                    }
                }
            }
            x.open("GET", "importdata.jsp", true);
            x.send();

        }
    </script>
</head>

<body>
    <div id="mainBG" class="homeContent" data-type="background">
        <div class='hidden-scrollbar'>
            <table width="100%">
                <tr>
                    <td width="20%">
                        <fieldset style="background: #ECF8E0;">
                            <table width="100%">
                                <jsp:include page="../../heading.jsp"></jsp:include>
                                <tr>
                                    <td colspan="2" align="center">
                                        <input type="Button" name="import" id="import" class="myButton" value="Import Data" onclick="funimport();" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>

                    </td>
                    <td width="80%">
                        <table width="100%">
                            <tr>
                                <td>
                                    <div id="airlineticketingdiv">
                                        <jsp:include page="airlineTicketingGrid.jsp"></jsp:include>
                                    </div>
                                </td>
                            </tr>
                        </table>
                   </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>