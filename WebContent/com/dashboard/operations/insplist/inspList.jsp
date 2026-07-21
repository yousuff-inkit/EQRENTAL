<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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
            width: 80px;
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
        #inspdiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            height: 100%;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
            document.getElementById("branchlabel").style.display="none";
            document.getElementById("branchdiv").style.display="none";
            
            $("#btnExcel").click(function() {
                $("#inspListGrid").jqxGrid('exportdata', 'xls', 'sold Vehicles List');
            });
            
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
            $('#docwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Document Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#docwindow').jqxWindow('close');
            
            $('#clientwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#clientwindow').jqxWindow('close');
            
            // Uniform 24px date inputs
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
            
            $('#refvocno').dblclick(function(){
                var reftype=document.getElementById("cmbreftype").value;
                if(document.getElementById("cmbreftype").value==''){
                     $.messager.alert('warning','Ref Doc Type is Mandatory');
                     return false;
                 }
                if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
                    if(document.getElementById("cmbagmtbranch").value==""){
                        $.messager.alert('warning','Agreement Branch is Mandatory');
                        return false;
                    }
                }
                $('#docwindow').jqxWindow('open');
                docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val(), $('#docwindow'));
            });

            $('#client').dblclick(function(){
                $('#clientwindow').jqxWindow('open');
                clientSearchContent('clientMasterSearch.jsp');
            });

            getAgmtBranch();
        });

        function docSearchContent(url) {
            $.get(url).done(function (data) {
                $('#docwindow').jqxWindow('setContent', data);
            }); 
        }
        
        function clientSearchContent(url) {
            $.get(url).done(function (data) {
                $('#clientwindow').jqxWindow('setContent', data);
            }); 
        }
        
        function funreload(event)
        {
            var branch=document.getElementById("cmbbranch").value;
            var client=document.getElementById("hidclient").value;
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var reftype=$('#cmbreftype').val();
            var agmtbranch=$('#cmbagmtbranch').val();
            var refdocno=$('#refdocno').val();
            var type=$('#cmbtype').val();
            var invoicetype=$('#cmbinvtype').val();
            var todate=$('#todate').jqxDateTimeInput('val');
            
            $("#overlay, #PleaseWait").show();
            $("#inspdiv").load("inspListGrid.jsp?branch="+branch+"&client="+client+"&fromdate="+fromdate+"&todate="+todate+"&reftype="+reftype+"&agmtbranch="+agmtbranch+"&refdocno="+refdocno+"&type="+type+"&invoicetype="+invoicetype+"&id=1");
        }
            
        function getAgmtBranch(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('***');
                    var locItems = items[0].split(",");
                    var locIdItems = items[1].split(",");
                    var optionsloc = '<option value="">--Select--</option>';
                    for (var i = 0; i < locItems.length; i++) {
                        optionsloc += '<option value="' + locIdItems[i] + '">'
                                + locItems[i] + '</option>';
                    }
                    $("select#cmbagmtbranch").html(optionsloc);
                    
                }
            }
            x.open("GET", "getBranch.jsp", true);
            x.send();
        }

        function setValues(){
             if($('#msg').val()!=""){
                 $.messager.alert('Message',$('#msg').val());
              }
        }
        
        function funExportBtn(){
             if(parseInt(window.parent.chkexportdata.value)=="1") {
                 JSONToCSVCon(insplistdata, 'Inspection List', true);
               } 
        }
            
        function funClearData(){
            $('input[type=text],[type=hidden]').val('');
            $('#fromdate').jqxDateTimeInput('setDate',new Date());
            $('#todate').jqxDateTimeInput('setDate',new Date());
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
        }
        
        function getDoc(event){
            var x= event.keyCode;
            if(x==114){
                if(event.target.id == 'refvocno') {
                    var reftype=document.getElementById("cmbreftype").value;
                    if(document.getElementById("cmbreftype").value==''){
                         $.messager.alert('warning','Ref Doc Type is Mandatory');
                         return false;
                     }
                    if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
                        if(document.getElementById("cmbagmtbranch").value==""){
                            $.messager.alert('warning','Agreement Branch is Mandatory');
                            return false;
                        }
                    }
                    $('#docwindow').jqxWindow('open');
                    docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val(), $('#docwindow'));
                } else if(event.target.id == 'client') {
                    $('#clientwindow').jqxWindow('open');
                    clientSearchContent('clientMasterSearch.jsp');
                }
            }
        }
        </script>
    </head>
    
    <body onload="setValues();getBranch();">
        <form id="frmSoldList" method="post" style="height: 100%;">
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
                                        <td class="label-cell">Ref Type</td>
                                        <td>
                                            <select name="cmbreftype" id="cmbreftype">
                                                <option value="">--Select--</option>
                                                <option value="RAG">Rental</option>
                                                <option value="LAG">Lease</option>
                                                <option value="RPL">Replacement</option>
                                                <option value="NRM">Non Revenue Movement</option>
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
                                        <td class="label-cell">Ref Doc</td>
                                        <td>
                                            <input type="text" name="refvocno" id="refvocno" placeholder="Press F3 to Search" readonly="readonly" onKeyDown="getDoc(event);">
                                            <input type="hidden" name="refdocno" id="refdocno" readonly="readonly">  
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Client</td>
                                        <td>
                                            <input type="text" name="client" id="client" placeholder="Press F3 to Search" readonly="readonly" onKeyDown="getDoc(event);">
                                            <input type="hidden" name="hidclient" id="hidclient">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Type</td>
                                        <td>
                                            <select name="cmbtype" id="cmbtype">
                                                <option value="">--Select--</option>
                                                <option value="DMG">Damage</option>
                                                <option value="ACC">Accident</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell" style="line-height: 1.1;">Invoice Type</td>
                                        <td>
                                            <select name="cmbinvtype" id="cmbinvtype">
                                                <option value="">--Select--</option>
                                                <option value="1">Invoiced</option>
                                                <option value="0">Not Invoiced</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                
                                <div class="action-buttons">
                                    <button type="button" name="btnclear" id="btnclear" class="btn-submit btn-clear" onclick="funClearData();">Clear</button>
                                </div>
                            </div>

                            <!-- Hidden Data -->
                            <div style="display:none;">
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="inspdiv">
                                <jsp:include page="inspListGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="clientwindow"><div></div></div>
            <div id="docwindow"><div></div></div>
            
        </form>
    </body>
</html>