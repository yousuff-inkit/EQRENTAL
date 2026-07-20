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

        .btn-submit:disabled {
            background: #9ca3af !important;
            cursor: not-allowed;
        }
        
        .btn-save {
            background: #10b981 !important; /* Emerald green */
        }
        
        .btn-save:hover {
            background: #059669 !important;
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
            gap: 15px;
        }

        /* Layout for Grids */
        .top-grids-row {
            display: flex;
            gap: 15px;
            min-height: 250px;
        }
        
        .bottom-grids-row {
            display: flex;
            gap: 15px;
            flex: 1;
            min-height: 250px;
        }
        
        #gateinpassdiv, #maintenancediv {
            flex: 2;
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        
        #complaintsdiv, #partsdiv {
            flex: 1;
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
            
            $('#btnprint').attr('disabled',true);
            
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
            $('#technicianwindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Technician Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#technicianwindow').jqxWindow('close');
            
            $('#baywindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Bay Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#baywindow').jqxWindow('close');
            
            $('#partssearchwindow').jqxWindow({ width: '57%', height: '57%',  maxHeight: '57%' ,maxWidth: '57%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#partssearchwindow').jqxWindow('close');
            
            // Uniform 24px date inputs
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#estimateddate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#estimatedtime").jqxDateTimeInput({ width: '100%', height: '24px', formatString : "HH:mm", showCalendarButton:false, value:new Date() });
            
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
            
            getSrvcAdvisorConfig();
            
            $('#technician').dblclick(function(){
                 $('#technicianwindow').jqxWindow('open');
                 $('#technicianwindow').jqxWindow('focus');
                 searchContent('technicianSearchGrid.jsp?id=1', 'technicianwindow');
            });
            
            $('#bay').dblclick(function(){
                 $('#baywindow').jqxWindow('open');
                 $('#baywindow').jqxWindow('focus');
                 searchContent('baySearchGrid.jsp?id=1&branch='+$('#cmbbranch').val(), 'baywindow');
            });
        });

        function getSrvcAdvisorConfig(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    $('#srvcadvisorconfig').val(items);
                }
            }
            x.open("GET", "getSrvcAdvisorConfig.jsp", true);
            x.send();
        }

        function getTechnician(event){
            var x= event.keyCode;
            if(x==114){
                $('#technicianwindow').jqxWindow('open');
                $('#technicianwindow').jqxWindow('focus');
                searchContent('technicianSearchGrid.jsp?id=1', 'technicianwindow');
            }
        }

        function getBay(event){
            var x= event.keyCode;
            if(x==114){
                $('#baywindow').jqxWindow('open');
                $('#baywindow').jqxWindow('focus');
                searchContent('baySearchGrid.jsp?id=1&branch='+$('#cmbbranch').val(), 'baywindow');
            }
        }

        function searchContent(url,windowid) {
            $.get(url).done(function (data) {
                $('#'+windowid).jqxWindow('setContent', data);
            }); 
        }

        function funreload(event)
        {
            $("#overlay, #PleaseWait").show(); 
            var branch=$('#cmbbranch').val();
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            $('#gateinpassdiv').load('gateInPassGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&id=1&srvcadvisorconfig='+$('#srvcadvisorconfig').val());
        }
            
        function setValues(){
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
              }
        }
            
        function funExportBtn(){
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            JSONToCSVCon(gateexceldata, 'Service Advisor Data for '+fromdate+' to '+todate, true);
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
            
        function funNotify(){
            if(document.getElementById("gateinpassdocno").value==""){
                $.messager.alert('Warning','Please Select a valid Document');
                return false;
            }
            if(document.getElementById("technician").value==""){
                $.messager.alert('Warning','Please Select Technician');
                return false;
            }
            if(document.getElementById("bay").value==""){
                $.messager.alert('Warning','Please Select Bay');
                return false;
            }
            
            var partrows=$('#partsGrid').jqxGrid('getrows');
            for(var i=0;i<partrows.length;i++){
                var qty=parseInt($('#partsGrid').jqxGrid('getcellvalue',partrows[i],'qty'));
                var stock=parseInt($('#partsGrid').jqxGrid('getcellvalue',partrows[i],'balqty'));
                var issueqty=parseInt($('#partsGrid').jqxGrid('getcellvalue',partrows[i],'issueqty'));
                 if(issueqty>0){
                        $.messager.alert('Warning','Item issued cannot make changes');
                        return false;
                    }
            }
            
            var z=0;
            for(var i=0;i<partrows.length;i++){
                var partno=$('#partsGrid').jqxGrid('getcellvalue',i,'partno');
                if(partno!="undefined" && partno!="" && partno!=null){
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "partsgrid"+z)
                    .attr("name", "partsgrid"+z)
                    .attr("hidden","true");
                    z++;
                    newTextBox.val($('#partsGrid').jqxGrid('getcellvalue',i,'partdocno')+"::"+$('#partsGrid').jqxGrid('getcellvalue',i,'qty'));
                
                    newTextBox.appendTo('form');                
                }
            }
            
            var maintenancerows=$('#maintenanceGrid').jqxGrid('selectedrowindexes');
            for(var i=0;i<maintenancerows.length;i++){
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "maintenancegrid"+i)
                .attr("name", "maintenancegrid"+i)
                .attr("hidden","true");
                
                newTextBox.val($('#maintenanceGrid').jqxGrid('getcellvalue',maintenancerows[i],'maintenancedocno'));
                newTextBox.appendTo('form');
            }
            
            $('#maintenancegridlength').val(maintenancerows.length);
            $('#partsgridlength').val(partrows.length-1);
            $('#mode').val('A');
            document.getElementById("frmServiceAdvisor").submit();      
        }
        
        function funPrint(){
              var dtype='BWSA';
              var url=document.URL;
              var actionstatus=url.includes("saveServiceAdvisor");
              var reurl='';
              if(actionstatus==true){
                  reurl=url.split("saveServiceAdvisor");
              } else{
                  reurl=url.split("serviceAdvisor.jsp");
              }
                
                var gateindoc=$('#gateinpassdocno').val();   
                var regno=$('#regno').val();
                var fleetno=$('#fleetno').val();
                var fleetname=$('#fleetname').val();
                var indatetime=$('#indatetime').val();
                $('#btnprint').attr('disabled',true);
                var win= window.open(reurl[0]+"printserviceadvisordetails?dtype="+dtype+"&gateindoc="+gateindoc+"&regno="+regno+"&fleetno="+fleetno+"&fleetname="+fleetname+"&indatetime="+indatetime,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
          }
            
        function purchaseRequest(){
            var gipdocno=$("#gateinpassdocno").val();
            var desc="Asset id.: "+$('#regno').val()+" , Fleet Name : "+$('#fleetname').val();
            var purchaserequestarray=new Array();

            var partrows=$('#partsGrid').jqxGrid('getrows');
            for(var i=0;i<partrows.length;i++){
                var partdocno=$('#partsGrid').jqxGrid('getcellvalue',i,'partdocno');
                var prqty=$('#partsGrid').jqxGrid('getcellvalue',i,'prqty');
                var unitdocno=$('#partsGrid').jqxGrid('getcellvalue',i,'unitdocno');
                var specid=$('#partsGrid').jqxGrid('getcellvalue',i,'specid');
                if(partdocno!="undefined" && partdocno!="" && partdocno!=null && prqty!="undefined" && prqty!="" && prqty!=null && parseFloat(prqty)!=0){
                    purchaserequestarray.push(partdocno+"::"+partdocno+"::"+unitdocno+"::"+prqty+"::"+specid+"::");
                }
            }
            
            if(purchaserequestarray.length==0){
                $.messager.alert('Warning','Please Enter Valid Data');
                return false;
            }
            
            $.messager.confirm('Message', 'Do you want to create Purchase Request ?', function(r){        
                if(r){
                    var x=new XMLHttpRequest();
                    x.onreadystatechange=function(){
                        if (x.readyState==4 && x.status==200){
                            var items=x.responseText;
                            if(parseInt(items)!="0")  {   
                                $.messager.alert('Message', ' Purchase Request Saved '+items);
                            } else {
                                $.messager.alert('Message', '  Not Saved  ');
                            }
                        }
                    }
                    x.open("GET","createPurchaseRequest.jsp?purchaserequestarray="+purchaserequestarray+"&refno="+gipdocno+"&desc="+desc,true);          
                    x.send();
                }
            });   
        }
        </script>
    </head>
    
    <body onload="setValues();getBranch();">
        <form id="frmServiceAdvisor" method="post" action="saveServiceAdvisor" style="height: 100%;">
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
                                </table>
                            </div>

                            <!-- Assignment Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Technician</td>
                                        <td>
                                            <input type="text" name="technician" id="technician" value='<s:property value="technician"/>' readonly="readonly" onkeydown="getTechnician(event);" placeholder="Press F3 to Search">
                                            <input type="hidden" name="hidtechnician" id="hidtechnician" value='<s:property value="hidtechnician"/>'>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Bay</td>
                                        <td>
                                            <input type="text" name="bay" id="bay" value='<s:property value="bay"/>' readonly="readonly" onkeydown="getBay(event);" placeholder="Press F3 to Search">
                                            <input type="hidden" name="hidbay" id="hidbay" value='<s:property value="hidbay"/>'>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Estimated Date</td>
                                        <td><div id="estimateddate" name="estimateddate"></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Estimated Time</td>
                                        <td><div id="estimatedtime" name="estimatedtime"></div></td>
                                    </tr>
                                </table>
                                
                                <div class="action-buttons" style="flex-wrap: wrap;">
                                    <button type="button" name="btnclear" id="btnclear" class="btn-submit btn-clear" onclick="funClearData();" style="width: 45%;">Clear</button>
                                    <button type="button" name="btnsave" id="btnsave" class="btn-submit btn-save" onclick="funNotify();" style="width: 45%;">Save</button>
                                </div>
                            </div>
                            
                            <!-- Actions Card -->
                            <div class="filter-card">
                                <div style="display: flex; flex-direction: column; gap: 10px;">
                                    <button type="button" id="btnprint" name="btnprint" class="btn-submit" onclick="funPrint();">Print</button>
                                    <button type="button" id="btnprrequest" name="btnprrequest" class="btn-submit" onclick="purchaseRequest();">Purchase Request</button>
                                </div>
                            </div>

                            <!-- Hidden Data -->
                            <div style="display:none;">
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                                <input type="hidden" name="gateinpassdocno" id="gateinpassdocno" value='<s:property value="gateinpassdocno"/>'>    
                                <input type="hidden" name="processstatus" id="processstatus" value='<s:property value="processstatus"/>'>   
                                <input type="hidden" name="partsgridlength" id="partsgridlength" value='<s:property value="partsgridlength"/>'> 
                                <input type="hidden" name="maintenancegridlength" id="maintenancegridlength" value='<s:property value="maintenancegridlength"/>'>    
                                <input type="hidden" name="regno" id="regno" value='<s:property value="regno"/>'>
                                <input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
                                <input type="hidden" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>'>
                                <input type="hidden" name="indatetime" id="indatetime" value='<s:property value="indatetime"/>'>
                                <input type="hidden" name="srvcadvisorconfig" id="srvcadvisorconfig" value='<s:property value="srvcadvisorconfig"/>'>
                                <input type="hidden" name="hidsmdocno" id="hidsmdocno" value='<s:property value="hidsmdocno"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            
                            <div class="top-grids-row">
                                <div id="gateinpassdiv">
                                    <jsp:include page="gateInPassGrid.jsp"></jsp:include>
                                </div>
                                <div id="complaintsdiv">
                                    <jsp:include page="complaintsGrid.jsp"></jsp:include>
                                </div>
                            </div>
                            
                            <div class="bottom-grids-row">
                                <div id="partsdiv">
                                    <jsp:include page="partsGrid.jsp"></jsp:include>
                                </div>
                                <div id="maintenancediv">
                                    <jsp:include page="maintenanceGrid.jsp"></jsp:include>
                                </div>
                            </div>
                            
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="technicianwindow"><div></div></div>
            <div id="baywindow"><div></div></div>
            <div id="partssearchwindow"><div></div></div>
            
        </form>
    </body>
</html>