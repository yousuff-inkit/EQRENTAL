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
            background-color: #ffffff !important;
            color: #333;
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

        .btn-save {
            background: #10b981 !important; /* Emerald green */
        }
        
        .btn-save:hover {
            background: #059669 !important;
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
        #gateinvoicediv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
             
             $('#clientwindow').jqxWindow({ width: '55%', height: '55%',  maxHeight: '55%' ,maxWidth: '55%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#clientwindow').jqxWindow('close');
            
             // Uniform 24px date inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             
             var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
             var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
             $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
             
             $('#client').dblclick(function(){
                 $('#clientwindow').jqxWindow('open');
                 $('#clientwindow').jqxWindow('focus');
                 searchContent('clientMasterSearch.jsp?id=1', 'clientwindow');
             });
        });

        function getClient(event){
            var x= event.keyCode;
            if(x==114){
                $('#clientwindow').jqxWindow('open');
                $('#clientwindow').jqxWindow('focus');
                searchContent('clientMasterSearch.jsp?id=1', 'clientwindow');
            }
        }

        function searchContent(url,windowid) {
            $.get(url).done(function (data) {
                $('#'+windowid).jqxWindow('setContent', data);
            }); 
        }
        
        function funreload(event)
        {
            if($('#cmbbranch').val()=='' || $('#cmbbranch').val()=='a'){
                $.messager.alert('Warning','Branch is Mandatory');
                return false;
            }
            
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            var client=$('#hidclient').val();
            var branch=$('#cmbbranch').val();
            
            $("#overlay, #PleaseWait").show();
            $("#gateinvoicediv").load("gateInvoiceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&client="+client+"&cmbbranch="+branch);
        }
            
        function setValues(){
             if($('#msg').val()!=""){
                  $.messager.alert('Message',$('#msg').val());
              }
        }
            
        function funExportBtn(){
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            JSONToCSVCon(gateexceldata, 'Gate Invoice List for '+fromdate+' to '+todate, true);
        }
            
        function funClearData(){
            $('input[type=text],[type=hidden]').val('');
            $('select').find('option').prop("selected", false);
            $('#fromdate').jqxDateTimeInput('setDate',new Date());
            $('#todate').jqxDateTimeInput('setDate',new Date());
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
            $('#client,#hidclient').val('');
        }
        
        function funNotify(){
            if($('#hidclient').val()==''){
                $.messager.alert('Warning','Please Select Client');
                return false;
            }
            
            var rows=$('#gateInvoiceGrid').jqxGrid('getselectedrowindexes');
            if(rows.length==0){
                $.messager.alert('Warning','Please Select Valid Documents');
                return false;
            } else {
                var gatedocno='';
                var invamount=0.0;
                for(var i=0;i<rows.length;i++){
                    if(i==0){
                        gatedocno=$('#gateInvoiceGrid').jqxGrid('getcellvalue',rows[i],'doc_no');
                    } else{
                        gatedocno+=','+$('#gateInvoiceGrid').jqxGrid('getcellvalue',rows[i],'doc_no');
                    }
                    invamount+=$('#gateInvoiceGrid').jqxGrid('getcellvalue',rows[i],'invamount');
                }
                $('#hidgatedocno').val(gatedocno);
                $('#invamount').val(invamount);
            }
            
            $.messager.confirm('Confirm', 'Do you want to Invoice?', function(r){
                if (r){
                    $('#mode').val('A');
                    document.getElementById("frmGateInvoice").submit();
                }
            });
        }
        
        function funSaveAJAX(gatedocno){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    items = x.responseText.trim();
                    if(parseInt(items)>0){
                        $.messager.alert('Message','Successfully Generated');
                        funClearData();
                    } else{
                        $.messager.alert('Message','Not Generated');
                    }
                }
            }
            x.open("GET", "invoiceAJAX.jsp?client="+$('#hidclient').val()+"&gatedocno="+$('#hidgatedocno').val()+"&amount="+$('#invamount').val()+'&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val'), true);
            x.send();
        }
        </script>
    </head>
    
    <body onload="getBranch();setValues();">
        <form id="frmGateInvoice" action="saveGateInvoice" method="post" style="height: 100%;">
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
                                        <td><div id="fromdate" name="fromdate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To Date</td>
                                        <td><div id="todate" name="todate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Client</td>
                                        <td>
                                            <input type="text" name="client" id="client" placeholder="Press F3 to Search" onkeydown="getClient(event);">
                                        </td>
                                    </tr>
                                </table>
                                
                                <div class="action-buttons">
                                    <button type="button" name="btnclear" id="btnclear" class="btn-submit btn-clear" onclick="funClearData();">Clear</button>
                                    <button type="button" name="btnsave" id="btnsave" class="btn-submit btn-save" onclick="funNotify();">Save</button>
                                </div>
                            </div>

                            <!-- Hidden Data -->
                            <div style="display:none;">
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                                <input type="hidden" name="hidgatedocno" id="hidgatedocno" value='<s:property value="hidgatedocno"/>'>
                                <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
                                <input type="hidden" name="invamount" id="invamount" value='<s:property value="invamount"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="gateinvoicediv">
                                <jsp:include page="gateInvoiceGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="clientwindow"><div></div></div>
            
        </form>
    </body>
</html>