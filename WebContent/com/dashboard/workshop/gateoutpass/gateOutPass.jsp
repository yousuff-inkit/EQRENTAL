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

        textarea {
            width: 100%;
            padding: 6px 8px;         
            border: 1px solid #ccd6e0;
            border-radius: 4px;       
            font-size: 12px;          
            background-color: #ffffff;
            box-sizing: border-box;
            color: #333;
            outline: none;
            resize: none;
            font-family: inherit;
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

        input[type="checkbox"] {
            margin: 0;
            cursor: pointer;
            width: 14px;
            height: 14px;
            vertical-align: middle;
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
        #gateoutpassdiv {
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
             
             $('#gatewindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Gate In Pass Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#gatewindow').jqxWindow('close');
            
             // Uniform 24px date/time inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#outdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:new Date()});
             $("#outtime").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"HH:mm", value:new Date(), showCalendarButton:false});
             
             var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
             var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
             $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
            
             $('#gateinpassdocno').dblclick(function(){
                  $('#gatewindow').jqxWindow('open');
                  $('#gatewindow').jqxWindow('focus');
                  searchContent('gateInPassSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')+'&branch='+$('#cmbbranch').val(), 'gatewindow');
             });
        });

        function getGateInPass(event){
            var x= event.keyCode;
            if(x==114){
                $('#gatewindow').jqxWindow('open');
                $('#gatewindow').jqxWindow('focus');
                searchContent('gateInPassSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')+'&branch='+$('#cmbbranch').val(), 'gatewindow');
            }
        }

        function searchContent(url,windowid) {
            $.get(url).done(function (data) {
                $('#'+windowid).jqxWindow('setContent', data);
            }); 
        }

        function funreload(event)
        {
            if($('#cmbbranch').val()=='a'){
                $.messager.alert('Warning','Please Select a specific branch');
                return false;
            }
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            var gatedocno=$('#gateinpassdocno').val();
            var branch=$('#cmbbranch').val();
            
            $("#overlay, #PleaseWait").show();
            $("#gateoutpassdiv").load("gateOutPassGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&gatedocno="+gatedocno+"&branch="+branch);
            setClientInvoice();
        }
            
        function setValues(){
             if($('#msg').val()!=""){
                    $.messager.alert('Message',$('#msg').val());
              }
        }
            
        function funExportBtn(){
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            JSONToCSVCon(gateexceldata, 'Gate Out Pass Report of '+fromdate+' to '+todate, true);
        }
            
        function funClearData(){
            $('input[type=text],[type=hidden]').val('');
            $('select').find('option').prop("selected", false);
            $('#fromdate').jqxDateTimeInput('setDate',new Date());
            $('#todate').jqxDateTimeInput('setDate',new Date());
            
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
            
            $('#gatedocno').val('');
            $('#gateinpassdocno,#remarks').val('');
        }
        
        function funNotify(){
            if($('#cmbbranch').val()=='a'){
                $.messager.alert('Warning','Please Select a specific branch');
                return false;
            }
            if($('#gatedocno').val()==''){
                $.messager.alert('Warning','Please Select Valid Document');
                return false;
            }
            if($('#outdate').jqxDateTimeInput('getDate')==null){
                $.messager.alert('Warning','Out Date is Mandatory');
                return false;
            }
            if($('#outtime').jqxDateTimeInput('getDate')==null){
                $.messager.alert('Warning','Out Time is Mandatory');
                return false;
            }
            $.messager.confirm('Confirm', 'Do you want to update changes?', function(r){
                if (r){
                    funSaveAJAX();
                }
            });
        }
        
        function funSaveAJAX(){
            var remarks=$('#remarks').val();
            remarks=remarks.trim();
            remarks=remarks.replace(/\n/g, " ");
            
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    items = x.responseText.trim();
                    if(parseInt(items)>0){
                        $.messager.alert('Message','Successfully Updated');
                        $.messager.confirm('Confirm', 'Do you want to print document?', function(r){
                            if (r){
                                funPrint();
                            } else {
                                funClearData();
                            }
                        });
                        
                        $("#gateoutpassdiv").load("gateOutPassGrid.jsp?fromdate="+$('#fromdate').jqxDateTimeInput('val')+"&todate="+$('#todate').jqxDateTimeInput('val')+"&id=1&branch="+$('#cmbbranch').val());   
                    } else{
                        $.messager.alert('Message','Not Updated');
                    }
                }
            }
            x.open("GET", "updateGateOutPass.jsp?gatedocno="+$('#gatedocno').val()+"&outdate="+$('#outdate').jqxDateTimeInput('val')+"&outtime="+$('#outtime').jqxDateTimeInput('val')+"&amount="+$('#amount').val()+"&clientinvoice="+$('#hidchkclientinvoice').val()+"&remarks="+remarks+"&branch="+$("#cmbbranch").val(), true);
            x.send();
        }
        
        function setClientInvoice(){
            if(document.getElementById("chkclientinvoice").checked==true){
                document.getElementById("hidchkclientinvoice").value="1";
            } else{
                document.getElementById("hidchkclientinvoice").value="0";
            }
        }
        
        function funPrint(){
              var dtype='BGOP';
              var url=document.URL;
              var reurl=url.split("gateoutpass");
              var brhid=<%= session.getAttribute("BRANCHID").toString()%>
              var win= window.open(reurl[0]+"gateoutpassprint?docno="+document.getElementById("gatedocno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
              win.focus();
          }
        </script>
    </head>
    
    <body onload="setValues();getBranch();">
        <form id="frmReplaceList" method="post" action="saveGateoutpass" style="height: 100%;">
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
                                        <td class="label-cell" style="line-height: 1.1;">Gate In Pass Doc No</td>
                                        <td>
                                            <input type="text" name="gateinpassdocno" id="gateinpassdocno" placeholder="Press F3 to Search" onkeydown="getGateInPass(event);">
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Operations Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Out Date</td>
                                        <td><div id="outdate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Out Time</td>
                                        <td><div id="outtime"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Amount</td>
                                        <td>
                                            <input type="text" name="amount" id="amount" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);">
                                        </td>
                                    </tr>
                                </table>
                                
                                <div style="margin-top: 10px;">
                                    <textarea id="remarks" name="remarks" placeholder="Remarks" style="height: 70px;"></textarea>
                                </div>
                                
                                <div style="display: flex; align-items: center; justify-content: center; gap: 8px; margin-top: 15px;">
                                    <input type="checkbox" name="chkclientinvoice" id="chkclientinvoice" onchange="setClientInvoice();">
                                    <label for="chkclientinvoice" class="label-cell" style="text-align: left; width: auto; padding: 0;">Client Invoice</label>
                                </div>

                                <div class="action-buttons">
                                    <button type="button" name="btnclear" id="btnclear" class="btn-submit btn-clear" onclick="funClearData();">Clear</button>
                                    <button type="button" name="btnsave" id="btnsave" class="btn-submit btn-save" onclick="funNotify();">Save</button>
                                </div>
                            </div>

                            <!-- Hidden Data -->
                            <div style="display:none;">
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                                <input type="hidden" name="gatedocno" id="gatedocno" value='<s:property value="gatedocno"/>'>
                                <input type="hidden" name="hidchkclientinvoice" id="hidchkclientinvoice" value='<s:property value="hidchkclientinvoice"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="gateoutpassdiv">
                                <jsp:include page="gateOutPassGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="gatewindow"><div></div></div>
            
        </form>
    </body>
</html>