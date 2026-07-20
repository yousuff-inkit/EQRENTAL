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

        /* Fieldsets & Radios */
        fieldset {
            border: 1px solid #ccd6e0;
            border-radius: 6px;
            padding: 10px;
            margin-bottom: 12px;
            background: #fff;
        }

        legend {
            font-size: 11px;
            font-weight: bold;
            color: #4e5e71;
            padding: 0 5px;
            text-transform: uppercase;
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
            position: relative;
        }

        /* Misc */
        #allodiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             
             $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
             $("#cmbbranch").attr('hidden',true);
             $("#hidediv").hide();
             
             $('#commenwindow1').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
             $('#commenwindow1').jqxWindow('close');
         
             $('#commenwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
             $('#commenwindow').jqxWindow('close');
           
             $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
             $('#fleetwindow').jqxWindow('close');
             
             $('#typesearch').dblclick(function(){
                  if(document.getElementById("trftype").value=="RAG") {
                      $('#commenwindow1').jqxWindow('open');
                      raSearchContent('ramasterSearch.jsp'); 
                  }
                  else if(document.getElementById("trftype").value=="LAG") {
                      $('#commenwindow1').jqxWindow('open');
                      raSearchContent('lamasterSearch.jsp'); 
                  }
                  else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF") {
                      $('#commenwindow').jqxWindow('open');
                      SearchContent('searchdrvandstaff.jsp?values='+document.getElementById("trftype").value); 
                  }
             });
            
             $('#fleet_no').dblclick(function(){
                  $('#fleetwindow').jqxWindow('open');
                  fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
             });
        });

        function getfleet(event){
             var x= event.keyCode;
             if(x==114){
              $('#fleetwindow').jqxWindow('open');
              fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
        } 
        
        function fleetSearchContent(url) {
                 $.get(url).done(function (data) {
                 $('#fleetwindow').jqxWindow('open');
                 $('#fleetwindow').jqxWindow('setContent', data);
            }); 
        } 

        function gettypessearch(event){
             var x= event.keyCode;
             if(x==114){
                  if(document.getElementById("trftype").value=="RAG") {
                      $('#commenwindow1').jqxWindow('open');
                      raSearchContent('ramasterSearch.jsp'); 
                  }
                  else if(document.getElementById("trftype").value=="LAG") {
                      $('#commenwindow1').jqxWindow('open');
                      raSearchContent('lamasterSearch.jsp'); 
                  }
                  else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF") {
                      $('#commenwindow').jqxWindow('open');
                      SearchContent('searchdrvandstaff.jsp?values='+document.getElementById("trftype").value); 
                  }
             }
        } 
            
        function SearchContent(url) {
                 $.get(url).done(function (data) {
                 $('#commenwindow').jqxWindow('open');
                 $('#commenwindow').jqxWindow('setContent', data);
            }); 
        } 
        
        function raSearchContent(url) {
                 $.get(url).done(function (data) {
                 $('#commenwindow1').jqxWindow('open');
                 $('#commenwindow1').jqxWindow('setContent', data);
            }); 
        } 

        function funExportBtn(){
             $("#trafficGrid").jqxGrid('exportdata', 'xls', 'Traffic Fine-Unallocated');
        }

        function funreload(event)
        {     
            dis();
            var val ="2";
            var uptodate=$("#uptodate").val();
            $("#overlay, #PleaseWait").show();
            $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
        }
            
        function hiddenbrh(){
            $("#branchlabel").attr('hidden',true);
            $("#branchdiv").attr('hidden',true);
            $('#gridlength').val(""); 
            getsubBranch();
        }
            
        function funallocate()
        {
            $.messager.confirm('Message', 'Do you want to Allocate?', function(r){
                if(r==false) {
                    return false; 
                } else {
                    $("#hidediv").show();
                    var saveval="10";
                    ajaxcall(saveval);
                }
            });
        }
            
        function ajaxcall(saveval){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200) {
                     var items= x.responseText;
                     var itemval=items.trim();
                    
                    if(parseInt(itemval)=="10") {
                        $.messager.alert('Message', 'Allocation Not Processed');
                        funreload(event);
                        $("#hidediv").hide();
                    }
                    else if(parseInt(itemval)=="11") {
                       $.messager.alert('Message', '  Record Successfully Allocated ');
                       var val ="10";
                       var uptodate=$("#uptodate").val();
                       $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
                       $("#hidediv").hide();
                    }
                    else {
                      $.messager.alert('Message', '  Not Allocated ');
                       funreload(event);
                       $("#hidediv").hide();
                    }
                }
            }
            x.open("GET","savedata.jsp?saveval="+saveval+"&uptodate="+$('#uptodate').jqxDateTimeInput('val'));
            x.send();
        }
        
        function getsubBranch() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var optionsbranch ="" ;
                    var branchIdItems  = items[0].split(",");
                    var branchItems = items[1].split(",");
                
                    for (var i = 0; i < branchItems.length; i++) {
                        optionsbranch += '<option value="' + branchIdItems[i].trim() + '">' + branchItems[i] + '</option>';
                    }
                    $("select#branchsss").html(optionsbranch);
                }
            }
            x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
            x.send();
        }
            
        function funoneallocate()
        {
            if(document.getElementById("fleet_no").value=="") {
                 $.messager.alert('Message',' Search Fleet ','warning');      
                 return false;
            }
            if(document.getElementById("typesearch").value=="") {
                 $.messager.alert('Message','Convict Search  ','warning');      
                 return false;
            }
            
            $.messager.confirm('Message', 'Do you want to Allocate?', function(r){
                if(r==false) {
                    return false; 
                } else {
                    doprocess();
                }
             });
        }
            
        function doprocess()
        {
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200) {
                     var items= x.responseText;
                     var itemval=items.trim();
                    
                   if(parseInt(itemval)=="10") {
                       $.messager.alert('Message', '  Record Successfully Allocated ');
                       var val="2";
                       var uptodate=$("#uptodate").val();
                       $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
                       $("#hidediv").hide();
                       dis();
                       funreload(event);
                    }
                    else {
                      $.messager.alert('Message', '  Not Allocated ');
                       $("#hidediv").hide();
                    }
                }
            }
            x.open("GET","saveonedata.jsp?ticketno="+document.getElementById("ticketno").value+"&trftype="+document.getElementById("trftype").value
                    +"&branchsss="+document.getElementById("branchsss").value+"&rentaldoc="+document.getElementById("rentaldoc").value
                    +"&leasedoc="+document.getElementById("leasedoc").value+"&drdoc="+document.getElementById("drdoc").value
                    +"&staffdoc="+document.getElementById("staffdoc").value+"&fleet_no="+document.getElementById("fleet_no").value);
            x.send();   
        }
        
        function dis()
        {
            document.getElementById("ticketno").value="";
            document.getElementById("fleet_no").value="";
            document.getElementById("typesearch").value="";
                    
            document.getElementById("rentaldoc").value="";
            document.getElementById("leasedoc").value="";
            document.getElementById("drdoc").value="";
            document.getElementById("staffdoc").value="";
            
             $('#ticketno').attr("disabled",true);
             $('#fleet_no').attr("disabled",true);
             $('#trftype').attr("disabled",true);
             $('#branchsss').attr("disabled",true);
             $('#allocates').attr("disabled",true);
             $('#typesearch').attr("disabled",true);
        }
            
        function cleardatas()
        {
            document.getElementById("typesearch").value="";
            document.getElementById("rentaldoc").value="";
            document.getElementById("leasedoc").value="";
            document.getElementById("drdoc").value="";
            document.getElementById("staffdoc").value="";
        }
        </script>
    </head>
    
    <body onload="hiddenbrh();dis();">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    <div class="sidebar-scroll-content">
                        
                        <!-- Batch Allocation Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Up To</td>
                                    <td><div id='uptodate' name='uptodate' value='<s:property value="uptodate"/>'></div></td>
                                </tr>
                            </table>
                            <div class="action-buttons">
                                <button type="button" name="driverUpdate" id="driverUpdate" class="btn-submit" onclick="funallocate()">Allocate</button>
                            </div>
                        </div>

                        <!-- Manual Allocation Card -->
                        <div class="filter-card">
                            <fieldset>
                                <legend>Manual Allocate</legend>
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Ticket No</td>
                                        <td><input type="text" id="ticketno" readonly="readonly" name="ticketno" value='<s:property value="ticketno"/>'></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Fleet NO</td>
                                        <td><input type="text" id="fleet_no" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getfleet(event);" name="fleet_no" value='<s:property value="fleet_no"/>'></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Type</td>
                                        <td>
                                            <select id="trftype" onchange="cleardatas()"> 
                                                <option value="RAG">Rental</option>
                                                <option value="LAG">Lease</option>
                                                <option value="STF">Staff</option>
                                                <option value="DRV">Driver</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Branch</td>
                                        <td>
                                            <select id="branchsss" name="branchsss" value='<s:property value="branchsss"/>'>
                                                <option value="">--Select--</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Convict</td>
                                        <td><input type="text" id="typesearch" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="gettypessearch(event)" onclick="this.placeholder='' " name="typesearch" value='<s:property value="typesearch"/>'></td>
                                    </tr>
                                </table>
                                
                                <div class="action-buttons">
                                    <button type="button" name="allocates" id="allocates" class="btn-submit" onclick="funoneallocate()">Manual</button>
                                </div>
                            </fieldset>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" id="gridlength" name="gridlength">
                            <input type="hidden" id="rentaldoc" name="rentaldoc">
                            <input type="hidden" id="leasedoc" name="leasedoc">
                            <input type="hidden" id="drdoc" name="drdoc">
                            <input type="hidden" id="staffdoc" name="staffdoc">
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        
                        <!-- Internal Loader just for this grid area -->
                        <div id="hidediv" style="position:absolute; top: 10px; right: 10px; z-index: 100;">
                            <img alt="Loading" src="<%=contextPath%>/icons/31load.gif"> 
                        </div>
                        
                        <div id="allodiv">
                            <jsp:include page="allocatelistGrid.jsp"></jsp:include>
                        </div>
                        
                    </div>
                </div>

            </div>
        </div>

        <!-- POPUPS -->
        <div id="fleetwindow"><div></div></div>
        <div id="commenwindow1"><div></div></div>
        <div id="commenwindow"><div></div></div>

    </body>
</html>