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
        textarea[readonly],
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
        #staffAllocatedDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            height: 100%;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             // Uniform 24px date inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
             $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#employeeDetailsWindow').jqxWindow('close');
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
        });
        
        function clientSearchContent(url) {
            $('#clientDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#clientDetailsWindow').jqxWindow('setContent', data);
                $('#clientDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        
        function employeeSearchContent(url) {
            $('#employeeDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#employeeDetailsWindow').jqxWindow('setContent', data);
                $('#employeeDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        
        function getEmployee(event){
            var x= event.keyCode;
            if(x==114){
                var emptype = $('#emptype').val();
                
                if(emptype==''){
                     $.messager.alert('Message','Choose an Employee Type.','warning');
                     return 0;
                 }
                var branchval = document.getElementById("cmbbranch").value; 
                employeeSearchContent('employeeDetailsSearch.jsp?branchval='+branchval+'&emptype='+emptype);
            }
        }
        
        function funSearchdblclick(){
             var emptype = $('#emptype').val();
              
             if(emptype==''){
                 $.messager.alert('Message','Choose an Employee Type.','warning');
                 return 0;
             }
              
             $('#txtempname').dblclick(function(){
                 var branchval = document.getElementById("cmbbranch").value; 
                 employeeSearchContent('employeeDetailsSearch.jsp?branchval='+branchval+'&emptype='+emptype); 
             });
        }

        function  funClearData(){
             $('#emptype').val('');
             $('#txtempname').val('');
             $('#txtempid').val('');
             $('#fromdate').val(new Date());
             $('#todate').val(new Date());
            
             $('#fromdate').val(new Date());
             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
             
             if (document.getElementById("txtempname").value == "") {
                 $('#txtempname').attr('placeholder', 'Press F3 to Search'); 
             }
         }
        
        function funreload(event){
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var emptype = $('#emptype').val();
             var empname = $('#txtempid').val();
             
             $("#overlay, #PleaseWait").show();
            
             $("#staffAllocatedDiv").load("staffallocateddamageGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&emptype='+emptype+'&empname='+empname);
        }
        
        function funUpdate(event){
            var salikaccount = $('#txtsalikaccount').val();
            var expenseaccount = $('#txtexpenseaccount').val();
            var rano = $('#txtrano').val();
            var fleetno = $('#txtfleetno').val();
            var amount = $('#txtamount').val();
            var mainbranch = $('#txtmainbranch').val();
            var docno = $('#txtdocno').val();
            var srno = $('#txtsrno').val();
            var amountcount = $('#txtamountcount').val();
            var empid = $('#txtemployeeid').val();
            var accfines=$('#accfines').val();
            
            if(docno==''){
                 $.messager.alert('Message','Please Choose a Fleet.','warning');
                 return 0;
             }
            
            $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                if(r==false) {
                    return false; 
                } else{
                     saveGridData(salikaccount,expenseaccount,rano,fleetno,amount,mainbranch,docno,srno,amountcount,empid,accfines);   
                }
             });
        }
        
        function saveGridData(salikaccount,expenseaccount,rano,fleetno,amount,mainbranch,docno,srno,amountcount,empid,accfines){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                    var items=x.responseText.trim();
                    
                    var salikaccount = $('#txtsalikaccount').val('');
                    var expenseaccount = $('#txtexpenseaccount').val('');
                    var rano = $('#txtrano').val('');
                    var fleetno = $('#txtfleetno').val('');
                    var amount = $('#txtamount').val('');
                    var mainbranch = $('#txtmainbranch').val('');
                    var docno = $('#txtdocno').val('');
                    var srno = $('#txtsrno').val('');
                    var amountcount = $('#txtamountcount').val('');
                    var empid = $('#txtemployeeid').val('');
                    var vehinfo = $('#vehinfo').val('');
                    var date = $('#date').val('');
                    var accfines=$('#accfines').val('');
                    
                    $.messager.alert('Message', 'JV generated successfully, Doc No:'+items, function(r){});
                  funreload(event); 
              }
            }
                
            x.open("GET","saveData.jsp?salikaccount="+salikaccount+"&expenseaccount="+expenseaccount+"&rano="+rano+"&fleetno="+fleetno+"&amount="+amount+"&mainbranch="+mainbranch+"&docno="+docno+"&srno="+srno+"&amountcount="+amountcount+"&empid="+empid+"&accfines="+accfines,true);
            x.send();
        }
        
        function funExportBtn(){
             if(parseInt(window.parent.chkexportdata.value)=="1") {
                JSONToCSVCon(data1, 'Staff-Allocated-Damage', true);
             } else {
                 $("#jqxstaffalocateddamage").jqxGrid('exportdata', 'xls', 'Staff-Allocated-Damage');
             }
         }
        </script>
    </head>
    
    <body onload="getBranch();">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Search Filters Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">From</td>
                                    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Type</td>
                                    <td>
                                        <select id="emptype" name="emptype" value='<s:property value="emptype"/>'>
                                            <option value="">--Select--</option>
                                            <option value="STF">Staff</option>
                                            <option value="DRV">Driver</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Employee</td>
                                    <td>
                                        <input type="text" id="txtempname" name="txtempname" readonly="readonly" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getEmployee(event);" value='<s:property value="txtempname"/>'/>
                                        <input type="hidden" id="txtempid" name="txtempid" value='<s:property value="txtempid"/>'/>
                                    </td>
                                </tr>
                            </table>
                            
                            <div style="margin-top: 10px;">
                                <textarea id="vehinfo" name="vehinfo" readonly="readonly" rows="5"><s:property value="vehinfo" /></textarea>
                            </div>
                            
                            <div class="action-buttons">
                                <button type="button" class="btn-submit btn-clear" name="clear" id="clear" onclick="funClearData();">Clear</button>
                                <button type="button" class="btn-submit btn-save" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button>
                            </div>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" id="txtsalikaccount" name="txtsalikaccount" value='<s:property value="txtsalikaccount"/>'/>
                            <input type="hidden" id="txtexpenseaccount" name="txtexpenseaccount" value='<s:property value="txtexpenseaccount"/>'/>
                            <input type="hidden" id="txtrano" name="txtrano" value='<s:property value="txtrano"/>'/>
                            <input type="hidden" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>'/>
                            <input type="hidden" id="txtamount" name="txtamount" value='<s:property value="txtamount"/>'/>
                            <input type="hidden" id="txtamountcount" name="txtamountcount" value='<s:property value="txtamountcount"/>'/>
                            <input type="hidden" id="txtmainbranch" name="txtmainbranch" value='<s:property value="txtmainbranch"/>'/>
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            <input type="hidden" id="txtsrno" name="txtsrno" value='<s:property value="txtsrno"/>'/>
                            <input type="hidden" id="txtemployeeid" name="txtemployeeid" value='<s:property value="txtemployeeid"/>'/>
                            <input type="hidden" id="accfines" name="accfines" value='<s:property value="accfines"/>'/>
                            <input type="hidden" id="txtdate" name="txtdate" value='<s:property value="txtdate"/>'/>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="staffAllocatedDiv">
                            <jsp:include page="staffallocateddamageGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="employeeDetailsWindow"><div></div><div></div></div>

        </div>
    </body>
</html>