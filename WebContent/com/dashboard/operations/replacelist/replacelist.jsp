<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
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
        
        <style type="text/css">
        /* ===== MASTER LAYOUT (Modern Flexbox) ===== */
        html, body, #mainBG {
            height: 100%;
            margin: 0;
            overflow: hidden;
            background-color: #f4f7f9;
        }

        .master-container {
            display: flex;
            width: 100%;
            height: 100vh;
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
        }

        /* ===== LEFT SIDEBAR ===== */
        .sidebar-filters {
            width: 280px; 
            flex: 0 0 280px; 
            background: #fff;
            border-right: 1px solid #e1e8ed;
            display: flex;
            flex-direction: column;
            height: 100%;
            box-shadow: 2px 0 8px rgba(0,0,0,.05);
            z-index: 10;
        }

        .sidebar-scroll-content {
            flex: 1;
            overflow-y: auto;
            padding: 15px 15px 25px; 
        }

        /* Cards */
        .filter-card {
            background: #f8fafc;
            border: 1px solid #e3e8ee;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 12px;
        }

        /* Tables */
        .filter-table {
            width: 100%;
            border-spacing: 0 10px;
        }

        .filter-table .label-cell {
            text-align: right;
            padding-right: 10px;
            font-size: 12px;
            color: #4e5e71;
            font-weight: 600;
            width: 90px;
        }

        /* ===== UNIFORM 24px INPUTS & SELECTS ===== */
        input[type="text"], select, textarea,
        .filter-table input[type="text"],
        .filter-table select {
            width: 100%;
            height: 24px;             
            padding: 2px 8px;         
            border: 1px solid #ccd6e0;
            border-radius: 4px;       
            font-size: 12px;          
            background-color: #ffffff;
            box-sizing: border-box;
            color: #333;
            outline: none;
        }

        /* Readonly / disabled look */
        input[readonly],
        input:disabled,
        .filter-table input[readonly],
        .filter-table input:disabled {
            background-color: #f3f6f9 !important;
            color: #555;
            border-color: #e1e8ed;
            cursor: pointer;
        }

        input::placeholder {
            color: #9aa4b2;
            opacity: 1;
        }

        /* ===== BUTTONS ===== */
        .btn-submit {
            width: 100%;
            height: 30px;            
            padding: 0 12px;         
            background: #2563eb;
            color: #fff;
            border: none;
            border-radius: 4px;      
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            line-height: 30px;       
            transition: background 0.2s;
            text-align: center;
        }

        .btn-submit:hover {
            background: #1d4ed8;
        }

        .btn-clear {
            background: #64748b !important;
        }
        
        .btn-clear:hover {
            background: #475569 !important;
        }

        .btn-submit:disabled {
            background: #9ca3af !important;
            cursor: not-allowed;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center;
        }

        /* ===== RIGHT CONTENT AREA ===== */
        .main-content-area {
            flex: 1; 
            display: flex;
            flex-direction: column;
            background: #ffffff;
            height: 100%;
            overflow: hidden;
        }

        .top-toolbar-container {
            width: 100%;
            padding: 10px 15px;
            background: #ffffff;
            border-bottom: 1px solid #e1e8ed;
            box-sizing: border-box;
        }

        .grid-content-container {
            flex: 1;
            padding: 15px;
            overflow: auto; 
            box-sizing: border-box;
            background: #fff;
        }

        /* Misc */
        #replacediv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            height: 100%;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
             
             $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#agmtnowindow').jqxWindow('close');
             
             // Uniform 24px date inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             
             var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
             var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
             $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
             
             funGetAgmtBranch();
             funGetReplaceReason();
            
             $('#agmtno').dblclick(function(){
                 if(document.getElementById("cmbagmttype").value==""){
                     $.messager.alert('warning','Please Select Agreement Type');
                     document.getElementById("cmbagmttype").focus();
                     return false;
                 }
                 if(document.getElementById("cmbagmtbranch").value==""){
                     $.messager.alert('warning','Please Select Agreement Branch');
                     document.getElementById("cmbagmtbranch").focus();
                     return false;
                 }
                 $('#agmtnowindow').jqxWindow('open');
                 $('#agmtnowindow').jqxWindow('focus');
                 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("cmbagmttype").value+'&branch='+document.getElementById("cmbagmtbranch").value, $('#agmtnowindow'));
             }); 
        });

        function getAgmtno(event){
            var x= event.keyCode;
            if(x==114){
                if(document.getElementById("cmbagmttype").value==""){
                     $.messager.alert('warning','Please Select Agreement Type');
                     document.getElementById("cmbagmttype").focus();
                     return false;
                 }
                 if(document.getElementById("cmbagmtbranch").value==""){
                     $.messager.alert('warning','Please Select Agreement Branch');
                     document.getElementById("cmbagmtbranch").focus();
                     return false;
                 }
                 $('#agmtnowindow').jqxWindow('open');
                 $('#agmtnowindow').jqxWindow('focus');
                 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("cmbagmttype").value+'&branch='+document.getElementById("cmbagmtbranch").value, $('#agmtnowindow'));
            }
        }

        function agmtSearchContent(url) {
              $.get(url).done(function (data) {
                  $('#agmtnowindow').jqxWindow('setContent', data);
              }); 
        }

        function funGetAgmtBranch(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('###');
                    var branchIdItems  = items[0].split(",");
                    var branchItems = items[1].split(",");
                    var optionsbranch = '<option value="">--Select--</option>';
                    for (var i = 0; i < branchItems.length; i++) {
                        optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
                                + branchItems[i] + '</option>';
                    }
                    $("select#cmbagmtbranch").html(optionsbranch);
                }
            }
            x.open("GET","getAgmtBranch.jsp", true);
            x.send();
        }

        function funGetReplaceReason(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('###');
                    
                    var replaceIdItems  = items[0].split(",");
                    var replaceItems = items[1].split(",");
                    var optionsbranch = '<option value="">--Select--</option>';
                    for (var i = 0; i < replaceItems.length;i++){
                        optionsbranch += '<option value="' + replaceIdItems[i].trim() + '">'
                                + replaceItems[i] + '</option>';
                    }
                    $("select#cmbreplacereason").html(optionsbranch);
                }
            }
            x.open("GET","getReplaceReason.jsp", true);
            x.send();
        }

        function funreload(event)
        {
             if(document.getElementById("cmbrentaltype").value!=""){
                if(document.getElementById("cmbagmttype").value==""){
                    $.messager.alert('warning','Please Select Agreement Type');
                    return false;
                }
            } 
             if(document.getElementById("cmbagmtstatus").value!=""){
                 if(document.getElementById("cmbagmttype").value==""){
                     $.messager.alert('warning','Please Select Agreement Type');
                     return false;
                 }
             }
            
             var fromdate=$('#fromdate').jqxDateTimeInput('val');
             var todate=$('#todate').jqxDateTimeInput('val');
             var repstatus=document.getElementById("cmbreplacestatus").value;
             var repreason=document.getElementById("cmbreplacereason").value;
             var reptype=document.getElementById("cmbreplacetype").value;
             var agmttype=document.getElementById("cmbagmttype").value;
             var agmtbranch=document.getElementById("cmbagmtbranch").value;
             var agmtno=document.getElementById("agmtno").value;
             var rentaltype=document.getElementById("cmbrentaltype").value;
             var agmtstatus=document.getElementById("cmbagmtstatus").value;
             
             $("#overlay, #PleaseWait").show();
             $("#replacediv").load("replaceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&repstatus="+repstatus+"&repreason="+repreason+"&reptype="+reptype+"&agmttype="+agmttype+"&agmtbranch="+agmtbranch+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtstatus="+agmtstatus+"&id=1");
        }
            
        function setValues(){
             if($('#msg').val()!=""){
                 $.messager.alert('Message',$('#msg').val());
              }
        }
            
        function funExportBtn(){
            $("#replaceGrid").excelexportjs({
                containerid: "replaceGrid",
                datatype: 'json',
                dataset: null,
                gridId: "replaceGrid",
                columns: getColumns("replaceGrid"),
                worksheetName: "Replacement List"
            });
         }
            
        function funClearData(){
            $('input[type=text],[type=hidden]').val('');
            $('select').find('option').prop("selected", false);
            $('#fromdate').jqxDateTimeInput('setDate',new Date());
            $('#todate').jqxDateTimeInput('setDate',new Date());
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
        }
        
        function funPrintData(){
            var rows=$('#replaceGrid').jqxGrid('getrows');
            if(rows.length==0){
                $.messager.alert('warning','Please Select any valid documents');
                return false;
            } else {
                var fromdate=$('#fromdate').jqxDateTimeInput('val');
                var todate=$('#todate').jqxDateTimeInput('val');
                var repstatus=document.getElementById("cmbreplacestatus").value;
                var repreason=document.getElementById("cmbreplacereason").value;
                var reptype=document.getElementById("cmbreplacetype").value;
                var agmttype=document.getElementById("cmbagmttype").value;
                var agmtbranch=document.getElementById("cmbagmtbranch").value;
                var agmtno=document.getElementById("agmtno").value;
                var rentaltype=document.getElementById("cmbrentaltype").value;
                var agmtstatus=document.getElementById("cmbagmtstatus").value;
                 
                var url=document.URL;
                var reurl=url.split("replacelist.jsp");
                var win= window.open(reurl[0]+"repListPrintAction?fromdate="+fromdate+"&todate="+todate+"&repstatus="+repstatus+"&repreason="+repreason+"&reptype="+reptype+"&agmttype="+agmttype+"&agmtbranch="+agmtbranch+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtstatus="+agmtstatus,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                win.focus();
            }
        }
        </script>
    </head>
    
    <body onload="setValues();">
        <form id="frmReplaceList" method="post" style="height: 100%;">
            <div id="mainBG" class="homeContent"> 

                <div class="master-container">

                    <!-- ================= LEFT SIDEBAR ================= -->
                    <div class="sidebar-filters">
                        
                        <div class="sidebar-scroll-content">
                            
                            <!-- Search Filters Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">From Date</td>
                                        <td><div id="fromdate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To Date</td>
                                        <td><div id="todate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Replace Status</td>
                                        <td>
                                            <select id="cmbreplacestatus" name="cmbreplacestatus">
                                                <option value="">--Select--</option>
                                                <option value="0">Open</option>
                                                <option value="1">Closed</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Replace Reason</td>
                                        <td>
                                            <select id="cmbreplacereason" name="cmbreplacereason">
                                                <option value="">--Select--</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Replace Type</td>
                                        <td>
                                            <select id="cmbreplacetype" name="cmbreplacetype">
                                                <option value="">--Select--</option>
                                                <option value="atbranch">At Branch</option>
                                                <option value="collection">Collection</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Agmt Type</td>
                                        <td>
                                            <select name="cmbagmttype" id="cmbagmttype">
                                                <option value="">--Select--</option>
                                                <option value="RAG">Rental</option>
                                                <option value="LAG">Lease</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Agmt Branch</td>
                                        <td>
                                            <select name="cmbagmtbranch" id="cmbagmtbranch">
                                                <option value="">--Select--</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Agmt No</td>
                                        <td>
                                            <input type="text" name="agmtno" id="agmtno" placeholder="Press F3 to Search" onkeydown="getAgmtno(event);" readonly="readonly">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Rental Type</td>
                                        <td>
                                            <select name="cmbrentaltype" id="cmbrentaltype">
                                                <option value="">--Select--</option>
                                                <option value="daily">Daily</option>
                                                <option value="weekly">Weekly</option>
                                                <option value="monthly">Monthly</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Agmt Status</td>
                                        <td>
                                            <select name="cmbagmtstatus" id="cmbagmtstatus">
                                                <option value="">--Select--</option>
                                                <option value="0">Open</option>
                                                <option value="1">Close</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                
                                <div class="action-buttons">
                                    <button type="button" name="btnclear" id="btnclear" class="btn-submit btn-clear" onclick="funClearData();">Clear</button>
                                    <button type="button" name="btnrepprint" id="btnrepprint" class="btn-submit" onclick="funPrintData();">Print</button>
                                </div>
                            </div>

                            <!-- Hidden Data -->
                            <div style="display:none;">
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                                <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="replacediv">
                                <jsp:include page="replaceGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="clientsearchwindow"><div></div></div>
            <div id="agmtnowindow"><div></div></div>
            
        </form>
    </body>
</html>