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

</style>
<script type="text/javascript">
var selectedBox = null;

$(document).ready(function() {
    getCurrency();
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

    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

    var year = window.parent.txtaccountperiodfrom.value;
    var newDate = year.split('-');
    year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
    $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));

    /* document.getElementById("hidchckgroup").value=1;
 		 document.getElementById("chckgroup").checked = true; */

    $(".chcklevels").click(function() {
        selectedBox = this.id;

        $(".chcklevels").each(function() {
            if (this.id == selectedBox) {
                this.checked = true;
                if (this.id != "chcklevel4") {
                    $('#btnprint').attr("disabled", true);
                } else {
                    $('#btnprint').attr("disabled", false);
                }
            } else {
                this.checked = false;
            };
        });
    });

    document.getElementById("hidchcklevel4").value = 1;
    document.getElementById("chcklevel4").checked = true;
    $('#btnprint').attr("disabled", true);
    getProfitAndLossPrintConfig()
});

function getProfitAndLossPrintConfig() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;

            if (parseInt(items) == 1) {
                $("#btnprint").show();
            } else {
                $("#btnprint").hide();
            }
        }
    }
    x.open("GET", "getProfitAndLossPrintConfig.jsp", true);
    x.send();
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        $.messager.alert('Message', ' Enter Numbers Only ', 'warning');
        return false;
    }
    return true;
}

function analysischeck() {
    if (document.getElementById("chckanalysis").checked) {
        document.getElementById("hidchckanalysis").value = 1;
        $('#txtnoofdays').val("0");
        $('#txtfrequency').val("0");
    } else {
        document.getElementById("hidchckanalysis").value = 0;
    }
    hidedata();
}

function checklevel1() {
    if (document.getElementById("chcklevel1").checked) {
        document.getElementById("hidchcklevel1").value = 1;
        document.getElementById("hidchcklevel2").value = 0;
        document.getElementById("hidchcklevel3").value = 0;
        document.getElementById("hidchcklevel4").value = 0;
    } else {
        document.getElementById("hidchcklevel1").value = 0;
    }
}

function checklevel2() {
    if (document.getElementById("chcklevel2").checked) {
        document.getElementById("hidchcklevel2").value = 1;
        document.getElementById("hidchcklevel1").value = 0;
        document.getElementById("hidchcklevel3").value = 0;
        document.getElementById("hidchcklevel4").value = 0;
    } else {
        document.getElementById("hidchcklevel2").value = 0;
    }
}

function checklevel3() {
    if (document.getElementById("chcklevel3").checked) {
        document.getElementById("hidchcklevel3").value = 1;
        document.getElementById("hidchcklevel1").value = 0;
        document.getElementById("hidchcklevel2").value = 0;
        document.getElementById("hidchcklevel4").value = 0;
    } else {
        document.getElementById("hidchcklevel3").value = 0;
    }
}

function checklevel4() {
    if (document.getElementById("chcklevel4").checked) {
        document.getElementById("hidchcklevel4").value = 1;
        document.getElementById("hidchcklevel1").value = 0;
        document.getElementById("hidchcklevel2").value = 0;
        document.getElementById("hidchcklevel3").value = 0;
    } else {
        document.getElementById("hidchcklevel4").value = 0;
    }
}

function hidedata() {
    var analysis = $('#hidchckanalysis').val();

    if (parseInt(analysis) == 1) {
        $("#analysisDiv").prop("hidden", false);
        $("#viewDiv").attr("hidden", true);
    } else {
        $("#analysisDiv").prop("hidden", true);
        $("#viewDiv").attr("hidden", false);
    }
}

function funreload(event) {
    var branchval = document.getElementById("cmbbranch").value;
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    var level1 = $('#hidchcklevel1').val();
    var level2 = $('#hidchcklevel2').val();
    var level3 = $('#hidchcklevel3').val();
    var level4 = $('#hidchcklevel4').val();
    var check = 1;
    var rate = $('#txtrate').val();   
    $("#overlay, #PleaseWait").show();
    $('#btnprint').attr("disabled", true);
    var d = new Date();
    var entrydate = d.getTime();
    $("#entrydate").val(entrydate);
    d.setDate(d.getDate() - 1);
    var onedaylessdt = d.getTime();
    $("#profitLossDiv").load("profitLossGrid.jsp?branchval=" + branchval+ '&entrydate=' + entrydate + '&fromdate=' + fromdate + '&todate=' + todate + '&level1=' + level1 + '&level2=' + level2 + '&level3=' + level3 + '&level4=' + level4 + '&check=' + check+ '&rate=' + rate  +'&onedaylessdt=' + onedaylessdt);
    
}

function funExportBtn() {
    if (parseInt(window.parent.chkexportdata.value) == "1") {
        JSONToCSVCon(dataExcelExport, 'ProfitAndLoss', true);
    } else {
        $("#profitLossGrid").jqxTreeGrid('exportData', 'xls');
    }
}

function funPrint() {
    var branchval = document.getElementById("cmbbranch").value;
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    var entrydate = $('#entrydate').val();   
    var url = document.URL;
    var reurl = url.split("com/");   
    var path = "v2profitlosslist.action?branchval=" + branchval + '&fromdate=' + fromdate + '&todate=' + todate + '&entrydate=' + entrydate;
    var win = window.open(reurl[0] + path, "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}

function getCurrency() {
    var x = new XMLHttpRequest();
    var items, currIdItems, mcloseItems, currCodeItems;
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            currIdItems = items[0].split(",");
            currCodeItems = items[1].split(",");

            var optionscurr = '';
            for (var i = 0; i < currCodeItems.length; i++) {
                optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
            }
            $("select#currencyid").html(optionscurr);
            window.parent.monthclosed.value = mcloseItems;
            getRates();
        } else {}

        if ($('#hidcurid').val()) {
            $("#currencyid").val($('#hidcurid').val());
        }
    }
    x.open("GET", "getCurrency.jsp", true);
    x.send();
}

function getRates() {
    var curid = $("#currencyid").val();
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            $("#txtrate").val(items);
        } else {}
    }
    x.open("GET", "getRate.jsp?curid=" + curid, true);
    x.send();
}
</script>
</head>
<body onload="getBranch();">
   <div id="mainBG" class="homeContent" data-type="background">
      <div class='hidden-scrollbar'>
         <table width="100%" >
            <tr>
               <td width="20%" >
                  <fieldset style="background: #ECF8E0;">
                     <table width="100%"  >
                        <jsp:include page="../../heading.jsp"></jsp:include>
                        <tr>
                           <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                           <td colspan="2">
                              <table width="100%">
                                 <tr>
                                    <td align="right"><label class="branch">Period</label></td>
                                    <td align="left">
                                       <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                                    </td>
                                 </tr>
                              </table>
                        </tr>
                        <tr>
                           <td colspan="2">
                              <div id="viewDiv">
                                 <table width="100%">
                                    <tr>
                                       <td colspan="2">
                                          <table width="100%">
                                             <tr>
                                                <td width="17%" align="right"><label class="branch">To</label></td>
                                                <td width="83%" align="left">
                                                   <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                                </td>
                                             </tr>
                                          </table>
                                       </td>
                                    </tr>
                                     <tr>
                                       <td width="17%" align="right"><label class="branch">Currency</label></td>
                                       <td width="83%" align="left">  
                                          <select id="currencyid" name="currencyid" onchange="getRates();" value='<s:property value="currencyid"/>'>
                                             <option value="">--Select--</option>
                                          </select>
                                          <input type="hidden" id="hidcurid" name="hidcurid"> 
                                       </td>
                                    </tr>
                                    <tr>
                                       <td width="17%" align="right"><label class="branch">Rate</label></td>
                                       <td width="83%" align="left"><input type="text" id="txtrate" name="txtrate" style="width:70%;height:20px"></td>
                                    </tr>
                                    <tr>
                                       <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                       <td colspan="2">
                                          <fieldset>
                                             <legend><b><label class="branch">Levels</label></b></legend>
                                             <table width="100%">
                                                <tr>
                                                   <td colspan="2">
                                                      <input type="checkbox" id="chcklevel1" name="chcklevel1" class="chcklevels" value="" onchange="checklevel1();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Level 1</label>
                                                      <input type="hidden" id="hidchcklevel1" name="hidchcklevel1" value='<s:property value="hidchcklevel1"/>'/>
                                                   </td>
                                                </tr>
                                                <tr>
                                                   <td colspan="2"><input type="checkbox" id="chcklevel2" name="chcklevel2" class="chcklevels" value="" onchange="checklevel2();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Level 2</label>
                                                      <input type="hidden" id="hidchcklevel2" name="hidchcklevel2" value='<s:property value="hidchcklevel2"/>'/>
                                                   </td>
                                                </tr>
                                                <tr>
                                                   <td colspan="2"><input type="checkbox" id="chcklevel3" name="chcklevel3" class="chcklevels" value="" onchange="checklevel3();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Level 3</label>
                                                      <input type="hidden" id="hidchcklevel3" name="hidchcklevel3" value='<s:property value="hidchcklevel3"/>'/>
                                                   </td>
                                                </tr>
                                                <tr>
                                                   <td colspan="2"><input type="checkbox" id="chcklevel4" name="chcklevel4" class="chcklevels" value="" onchange="checklevel4();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Level 4</label>
                                                      <input type="hidden" id="hidchcklevel4" name="hidchcklevel4" value='<s:property value="hidchcklevel4"/>'/>
                                                   </td>
                                                </tr>
                                             </table>
                                          </fieldset>
                                       </td>
                                    </tr>
                                    <tr>
                                       <td colspan="2" align="center">&nbsp;<button type="button" class="myButton" id="btnprint" onclick="funPrint();">Print</button></td>
                                    </tr>
                                    <tr>
                                       <td colspan="2">&nbsp;</td>
                                    </tr>
                                 </table>
                              </div>
                           </td>
                        </tr>
                        <tr>
                           <td colspan="2">
                              <div id="analysisDiv" hidden="true">
                                 <table width="100%">
                                    <tr>
                                       <td colspan="2">
                                          <select id="cmbchoose" name="cmbchoose" style="width:30%;" value='<s:property value="cmbchoose"/>'>
                                             <option value="1">Days</option>
                                             <option value="2">Monthly</option>
                                             <option value="3">Quarterly</option>
                                             <option value="4">Yearly</option>
                                          </select>
                                          &nbsp;&nbsp;
                                          <input type="text" id="txtnoofdays" name="txtnoofdays" style="width:50%;height:20px;" value='<s:property value="txtnoofdays"/>'/>
                                       </td>
                                    </tr>
                                    <tr>
                                       <td width="10%" align="right"><label class="branch">Frequency</label></td>
                                       <td width="90%" align="left"><input type="text" id="txtfrequency" name="txtfrequency" style="width:82%;height:20px;" value='<s:property value="txtfrequency"/>'/></td>
                                    </tr>
                                    <tr>
                                       <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                       <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                       <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                       <td colspan="2">&nbsp;</td>
                                    </tr>
                                 </table>
                              </div>
                           </td>
                        </tr>
                        <tr>
                           <td colspan="2"><input type="hidden" id="entrydate" name="entrydate"/></td>
                        </tr>
                        <tr>
                           <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                           <td colspan="2">&nbsp;</td>
                        </tr>
                     </table>
                  </fieldset>
               </td>
               <td width="80%">
                  <table width="100%">
                     <tr>
                        <td>
                           <div id="profitLossDiv">
                              <jsp:include page="profitLossGrid.jsp"></jsp:include>
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