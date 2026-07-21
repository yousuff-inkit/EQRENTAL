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
            display: flex;
            flex-direction: column;
        }

        /* Misc */
        #collectionClosureDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            flex: 1;
        }
        
        .net-amount-container {
            padding: 15px 0 0 0;
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }
        
        .net-amount-label {
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-right: 10px;
        }
        
        .net-amount-input {
            width: 120px !important;
            text-align: right;
            font-weight: bold;
            font-size: 14px !important;
            background-color: #f8fafc !important;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             // Uniform 24px date inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
             
             $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
             $('#clientwindow').jqxWindow('close');
               
             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
             
             $('#clientname').dblclick(function(){
                  $('#clientwindow').jqxWindow('open');
                  clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
             });
        });

        function getclinfo(event){
             var x= event.keyCode;
            if(x==114){
                $('#clientwindow').jqxWindow('open');
                clientSearchContent('clientsearch.jsp', $('#clientwindow'));    
            }
        } 

        function clientSearchContent(url) {
            $.get(url).done(function (data) {
                $('#clientwindow').jqxWindow('open');
                $('#clientwindow').jqxWindow('setContent', data);
            }); 
        }

        function funExportBtn(){
            JSONToCSVConvertor(dataExcelExport, 'CollectionClosure', true);
        } 
        
        function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
            var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
            var CSV = '';    
            
            CSV += ReportTitle + '\r\n\n';

            if (ShowLabel) {
                var row = "";
                for (var index in arrData[0]) {
                    row += index + ',';
                }
                row = row.slice(0, -1);
                CSV += row + '\r\n';
            }
            
            for (var i = 0; i < arrData.length; i++) {
                var row = "";
                for (var index in arrData[i]) {
                    row += '"' + arrData[i][index] + '",';
                }
                row.slice(0, row.length - 1);
                CSV += row + '\r\n';
            }

            if (CSV == '') {        
                alert("Invalid data");
                return;
            }   
            
            var fileName = "";
            fileName += ReportTitle.replace(/ /g,"_");   
            
            var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
            
            var link = document.createElement("a");    
            link.href = uri;
            link.style = "visibility:hidden";
            link.download = fileName + ".csv";
            
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function funreload(event){
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var cldocno = $('#cldocno').val();
             var cmbpayedas = $('#cmbpayedas').val();
             var cmbstat = $('#cmbstat').val();
            
             $("#overlay, #PleaseWait").show();      
            
             $("#collectionClosureDiv").load("collectionClosureGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&payas='+cmbpayedas+'&status='+cmbstat);
        }
        
        function funPrintCollectionClosure(){
            var url=document.URL;
            var reurl=url.split("collectionClosure.jsp");
            var win= window.open(reurl[0]+"printCollectionClosure?branch="+document.getElementById("cmbbranch").value+'&fromdate='+document.getElementById("fromdate").value+'&todate='+$("#todate").val()+'&netamount='+document.getElementById("txtnetamount").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();
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
                                    <td class="label-cell">Period</td>
                                    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Client</td>
                                    <td>
                                        <input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder=''" value='<s:property value="clientname"/>'>
                                        <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Paid As</td>
                                    <td>
                                        <select id="cmbpayedas" name="cmbpayedas" value='<s:property value="cmbpayedas"/>'>
                                            <option value="">--Select--</option> 
                                            <option value="1">On Account</option>
                                            <option value="2">Advance</option>
                                            <option value="3">Security</option>
                                        </select>
                                        <input type="hidden" id="hidcmbpayedas" name="hidcmbpayedas" value='<s:property value="hidcmbpayedas"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Status</td>
                                    <td>
                                        <select id="cmbstat" name="cmbstat" value='<s:property value="cmbstat"/>'>
                                            <option value="">--Select--</option>  
                                            <option value="1">Posted</option>
                                            <option value="2">Not Posted</option>    
                                        </select>
                                        <input type="hidden" id="hidcmbstat" name="hidcmbstat" readonly="readonly" value='<s:property value="hidcmbstat"/>'/>
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="action-buttons">
                                <button type="button" class="btn-submit" id="btnPrintCollectionClosure" name="btnPrintCollectionClosure" onclick="funPrintCollectionClosure(event);">Print</button>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="collectionClosureDiv">
                            <jsp:include page="collectionClosureGrid.jsp"></jsp:include>
                        </div>
                        
                        <div class="net-amount-container">
                            <span class="net-amount-label">Net Amount :</span>
                            <input type="text" class="filter-table input[type='text'] net-amount-input" id="txtnetamount" name="txtnetamount" readonly="readonly" value='<s:property value="txtnetamount"/>'/>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="clientwindow"><div></div></div>

        </div>
    </body>
</html>