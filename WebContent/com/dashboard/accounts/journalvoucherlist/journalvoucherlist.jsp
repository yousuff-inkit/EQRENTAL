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
        #jvlistDiv {
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
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));  
        });       
             
        function funreload(event){   
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var jvtype = $('#cmbprocess').val();      
             var check=1;
             var dtype=document.getElementById("cmbchoose").value;
             
             $("#overlay, #PleaseWait").show();
             $("#jvlistDiv").load("jvListGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check='+check+'&dtype='+dtype+'&jvtype='+jvtype);
        }       
        
        function funExportBtn(){
            JSONToCSVCon(dataExcelExport, 'Journal Voucher List', true);   
        }
        
        function funPrint(){
            var selectedrows=$("#jqxJournalVoucher").jqxGrid('selectedrowindexes');
            selectedrows = selectedrows.sort(function(a,b){return a - b});
            if(selectedrows.length>100){
                $.messager.alert('Message','Selected documents not more than 100...!!!','warning'); 
            } else {
                var i=0;var temptrno="0",tempdocno="0";
                var j=0;
                for (i = 0; i < selectedrows.length; i++) {
                    var srvdetmdocno= $('#jqxJournalVoucher').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
                    tempdocno=tempdocno+","+srvdetmdocno;
                    var srvdetmtrno= $('#jqxJournalVoucher').jqxGrid('getcellvalue', selectedrows[i], "tr_no");
                    temptrno=temptrno+","+srvdetmtrno;
                }  
                $('#srvdetmdocno').val(tempdocno); 
                $('#srvdetmtrno').val(temptrno);
                
                var url=document.URL;
                var reurl=url.split("journalvoucherlist.jsp");
                var win= window.open(reurl[0]+"printjournalvoucherlist?docno="+$('#srvdetmdocno').val()+"&trno="+$('#srvdetmtrno').val()+"&branch="+document.getElementById("cmbbranch").value+"&dtype="+document.getElementById("cmbchoose").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
            }         
        }                          
        
        function getJVType() {     
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                       
                    var srno  = items[0].split(",");
                    var process = items[1].split(",");
                    var optionsbranch = '<option value="" selected>-- Select -- </option>';
                    for (var i = 0; i < process.length; i++) {
                        optionsbranch += '<option value="' + srno[i].trim() + '">'
                                + process[i] + '</option>';
                    }
                    $("select#cmbprocess").html(optionsbranch);
                    
                }
            }
            x.open("GET","getjvtypes.jsp", true);
            x.send();
        }  
        </script>                               
    </head>
    
    <body onload="getBranch();getJVType();">
        <form id="frmJVList" action="saveJVList" method="post" style="height: 100%;">   
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
                                        <td>
                                            <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                                            <input type="hidden" id="hidfromdate" name="hidfromdate" readonly="readonly" value='<s:property value="hidfromdate"/>'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To</td>
                                        <td>
                                            <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                            <input type="hidden" id="hidtodate" name="hidtodate" readonly="readonly" value='<s:property value="hidtodate"/>'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Type</td>
                                        <td>
                                            <select id="cmbchoose" name="cmbchoose" value='<s:property value="cmbchoose"/>'>
                                                <option value="JVT">JVT</option>
                                                <option value="IJV">IJV</option>
                                            </select>
                                            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">JV Type</td>
                                        <td>
                                            <select name="cmbprocess" id="cmbprocess" value='<s:property value="cmbprocess"/>'></select> 
                                            <input type="hidden" id="hidcmbprocess" name="hidcmbprocess" value='<s:property value="hidcmbprocess"/>'/>
                                        </td>   
                                    </tr>
                                </table>
                                
                                <div class="action-buttons">
                                    <button type="button" name="btnprint" id="btnprint" class="btn-submit" onclick="funPrint();">Print</button>
                                </div>
                            </div>

                            <!-- Hidden Data -->
                            <div style="display:none;">
                                <input type="hidden" id="srvdetmtrno" name="srvdetmtrno" value='<s:property value="srvdetmtrno"/>'/>
                                <input type="hidden" id="srvdetmdocno" name="srvdetmdocno" value='<s:property value="srvdetmdocno"/>'/>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="jvlistDiv">
                                <jsp:include page="jvListGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </form> 
    </body>
</html>