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
        }

        /* Misc */
        #listdiv, #listdiv1, #detaildiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 15px;
        }
        
        #detaildiv {
            margin-bottom: 0;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

             $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
             $('#accountSearchwindow').jqxWindow('close');
             
             $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
              
             $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
             $('#locationwindow').jqxWindow('close');  
             
             $("#invdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});  
             
             $('#account').dblclick(function(){
                  $('#accountSearchwindow').jqxWindow('open');
                  accountSearchContent('accountsDetailsSearch.jsp?');
             });   
             
             $('#txtlocation').dblclick(function(){
                  $('#locationwindow').jqxWindow('open');
                  locationsearchContent('searchlocation.jsp?brhid='+document.getElementById("brhid").value); 
             }); 
        });

        function getloc(event){
             var x= event.keyCode;
             if(x==114){
              $('#locationwindow').jqxWindow('open');
              locationsearchContent('searchlocation.jsp?brhid='+document.getElementById("brhid").value);    }
        }  
        
        function funExportBtn(){
            JSONToCSVCon(datasex,'Purchase Order Followup Mater', true);
            JSONToCSVCon(datas11ex,'Purchase Order Followup Details', true);
         }

        function locationsearchContent(url) {
             $.get(url).done(function (data) {
             $('#locationwindow').jqxWindow('setContent', data);
            }); 
        }

        function getaccountdetails(event){
             var x= event.keyCode;
             if(x==114){
              $('#accountSearchwindow').jqxWindow('open');
             accountSearchContent('accountsDetailsSearch.jsp?');    }
         }  
            
        function accountSearchContent(url) {
             $.get(url).done(function (data) {
             $('#accountSearchwindow').jqxWindow('setContent', data);
            }); 
        }
        
        function funreload(event)
        {
             var barchval = document.getElementById("cmbbranch").value;
             var fromdate="";
             var todate="";
             var statusselect="";
             var acno=$("#acno").val();
             
             $("#ordersubgrid").jqxGrid('clear');
             $("#duedetailsgrid").jqxGrid('clear');
             $("#overlay, #PleaseWait").show();
             $("#listdiv").load("ordermainGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno);
        }

        function  funcleardata()
        {
            document.getElementById("acno").value="";
            document.getElementById("account").value="";
            document.getElementById("accname").value="";
            document.getElementById("statusselect").value="All";
            
             if (document.getElementById("account").value == "") {
                  $('#account').attr('placeholder', 'Press F3 TO Search'); 
             }
        }
        
        function getinfo() {
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
                    $("select#cmbinfo").html(optionsbranch);
                }
            }
            x.open("GET","getinfo.jsp", true);
            x.send(); 
        }
        
        function getstatus() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var itemss = x.responseText;
                    itemss = itemss.split('####');
                    
                    var srno1  = itemss[0].split(",");
                    var process1 = itemss[1].split(",");
                    var optionsbranch1= '<option value="" selected>-- Select -- </option>';
                    for (var i = 0; i < process1.length; i++) {
                        optionsbranch1 += '<option value="' + srno1[i].trim() + '">'
                                + process1[i] + '</option>';
                    }
                    $("select#status").html(optionsbranch1);
                }
            }
            x.open("GET","getstatus.jsp", true);
            x.send();
        }

        function funupdate()
        {
            var listss = new Array();
             if(document.getElementById("cmbinfo").value=="")
             {
                 $.messager.alert('Message','Select Process ','warning');   
                 return 0;
             }
            
             if(document.getElementById("cmbinfo").value=="1")
                 {
             if($('#remarks').val()=="")
             {
                 $.messager.alert('Message','Enter Remarks ','warning');   
                 return 0;
             }
             var remarkss = document.getElementById("remarks").value;
             var nmax = remarkss.length;
              if(nmax>99)
               {
              $.messager.alert('Message',' Remarks cannot contain more than 200 characters ','warning');   
                    return false; 
               } 
                 }
            
             else if(document.getElementById("cmbinfo").value=="2")
                 {
                 if($('#status').val()=="")
                 {
                     $.messager.alert('Message','Select Status ','warning');   
                     return 0;
                 }
                 }
            
             else if(document.getElementById("cmbinfo").value=="3")
                 {
                 if($('#txtlocation').val()=="")
                 {
                     $.messager.alert('Message','Select Location ','warning');   
                     return 0;
                 }
                
                 if($('#invno').val()=="")
                 {
                     $.messager.alert('Message','Enter Inv No ','warning');   
                     return 0;
                 }
                
                    var selectedrows=$("#ordersubgrid").jqxGrid('selectedrowindexes');
                    
                     if(selectedrows.length=="0" ||selectedrows.length==0)
                     {
                         $.messager.alert('Message','Select Product','warning');   
                         return 0;
                     }
                    
                    selectedrows = selectedrows.sort(function(a,b){return a - b});  
                          for(var i=0 ; i < selectedrows.length ; i++){
                             listss.push($("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'psrno')); 
                                  }
                 }
              
              var docno = document.getElementById("masterdocno").value;
             var branchids = document.getElementById("brhid").value;
             var remarks = document.getElementById("remarks").value;
             var cmbinfo = document.getElementById("cmbinfo").value;
               var refrowno=0;
             var folldate =$('#date').val();
            
            var cmbval = document.getElementById("cmbinfo");
            var cmbText = cmbval.options[cmbval.selectedIndex].text;
            
             var statuschg = document.getElementById("status").value;
             var invdate = document.getElementById("invdate").value;
             var invno = document.getElementById("invno").value;
             var txtlocationid = document.getElementById("txtlocationid").value;
            
            $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                if(r==false) {
                    return false; 
                } else {
                     savegriddata(docno,branchids,remarks,cmbinfo,folldate,cmbText,refrowno,statuschg,invdate,invno,txtlocationid,listss); 
                }
             });
        }
        
        function savegriddata(docno,branchids,remarks,cmbinfo,folldate,cmbText,refrowno,statuschg,invdate,invno,txtlocationid,listss)
        {
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                    var items=x.responseText;
                    if(parseInt(items)>0) {
                        if(document.getElementById("cmbinfo").value=="3" || document.getElementById("cmbinfo").value==3)  {
                          $.messager.alert('Message', ' Successfully Created PIV NO : '+items);
                        } else {
                          $.messager.alert('Message', ' Successfully Updated');
                        }
                        
                         funreload(event);
                         disitems(0);
                    } else {
                         $.messager.alert('Message', ' Not Updated '); 
                    }
                }
            }
                
        x.open("GET","savedata.jsp?docno="+docno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&cmbText="+cmbText+"&refrowno="+refrowno+"&statuschg="+statuschg+"&invdate="+invdate+"&invno="+invno+"&txtlocationid="+txtlocationid+"&listss="+listss,true);
        x.send();
        }

        function disitems(val)
        {
             if(val=="1") {
                 $('#cmbinfo').attr("disabled",false);
                 $('#status').attr("disabled",true);
                 $('#remarks').attr("disabled",false);
                 $('#remarks').attr("readonly",false);
                 $('#Update').attr("disabled",false);
               
                 document.getElementById("remarks").value="";
                 document.getElementById("status").value="";
                
                 $('#date').val(new Date());
                 $('#date').jqxDateTimeInput({ disabled: false});
                 document.getElementById("status").value="";
                 document.getElementById("txtlocation").value="";
                 document.getElementById("txtlocationid").value="";
                 document.getElementById("invno").value="";
                 $('#invdate').val(new Date());
                 $('#invdate').jqxDateTimeInput({ disabled: true});
                 $('#txtlocation').attr("disabled",true);
                 $('#invno').attr("disabled",true);
                    
             } else if(val=="2") {
                $('#cmbinfo').attr("disabled",false);
                $('#status').attr("disabled",false);
                $('#remarks').attr("readonly",true);
                $('#remarks').attr("disabled",true);
                $('#Update').attr("disabled",false);
                
                document.getElementById("remarks").value="";
                document.getElementById("status").value="";
        
                $('#date').val(new Date());
                $('#date').jqxDateTimeInput({ disabled: true});
                document.getElementById("status").value="1";
                document.getElementById("txtlocation").value="";
                document.getElementById("txtlocationid").value="";
                document.getElementById("invno").value="";
                $('#invdate').val(new Date());
                $('#invdate').jqxDateTimeInput({ disabled: true});
                $('#txtlocation').attr("disabled",true);
                $('#invno').attr("disabled",true);
                
             } else if(val=="3") {
                $('#cmbinfo').attr("disabled",false);
                $('#status').attr("disabled",true);
                $('#remarks').attr("readonly",true);
                $('#Update').attr("disabled",false);
                $('#remarks').attr("disabled",true);
                document.getElementById("remarks").value="";
                document.getElementById("status").value="";
                $('#date').val(new Date());
                $('#date').jqxDateTimeInput({ disabled: true});
                document.getElementById("status").value="";
                document.getElementById("txtlocation").value="";
                document.getElementById("txtlocationid").value="";
                document.getElementById("invno").value="";
                $('#invdate').val(new Date());
                $('#invdate').jqxDateTimeInput({ disabled: false});
                 $('#txtlocation').attr("disabled",false);
                 $('#invno').attr("disabled",false);
            
             } else {
                document.getElementById("txtlocation").value=""; 
                document.getElementById("txtlocationid").value="";
                document.getElementById("invno").value="";
                $('#invdate').val(new Date());
                $('#invdate').jqxDateTimeInput({ disabled: true});
                $('#txtlocation').attr("disabled",true);
                $('#invno').attr("disabled",true);
                document.getElementById("cmbinfo").value="";
                document.getElementById("remarks").value="";
                document.getElementById("status").value="";
                document.getElementById("masterdocno").value="";
                $('#date').val(new Date());
                $('#date').jqxDateTimeInput({ disabled: true});
                $('#cmbinfo').attr("disabled",true);
                $('#status').attr("disabled",true);
                $('#remarks').attr("readonly",true);
               $('#Update').attr("disabled",true);
             }
        }
        </script>
    </head>
    
    <body onload="getBranch();getinfo();getstatus();disitems(0);">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Search Filters Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Account</td>
                                    <td>
                                        <input type="text" name="account" id="account" value='<s:property value="account"/>' readonly="readonly" placeholder="Press F3 To Search" onKeyDown="getaccountdetails(event);" >
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell"></td>
                                    <td>
                                        <input type="text" id="accname" name="accname" value='<s:property value="accname"/>' readonly="readonly">
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="action-buttons">
                                <button type="button" class="btn-submit btn-clear" name="clear" id="clear" onclick="funcleardata()">Clear</button>
                            </div>
                        </div>

                        <!-- Update Details Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Process</td>
                                    <td>
                                        <select name="cmbinfo" id="cmbinfo" value='<s:property value="cmbinfo"/>' onchange="disitems(this.value);" > </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Date</td>
                                    <td><div id='date' name='date' value='<s:property value="date"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Remarks</td>
                                    <td><input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Status</td>
                                    <td><select name="status" id="status" value='<s:property value="status"/>'></select></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Location</td>
                                    <td>
                                        <input type="text" id="txtlocation" name="txtlocation" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onkeydown="getloc(event);"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Inv Date</td>
                                    <td><div id='invdate' name='invdate' value='<s:property value="invdate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Inv No</td>
                                    <td><input type="text" id="invno" name="invno" value='<s:property value="invno"/>'/></td>
                                </tr>
                            </table>

                            <div class="action-buttons">
                                <button type="button" name="Update" id="Update" class="btn-submit" onclick="funupdate()">Update</button>
                            </div>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" id="statusselect" name="statusselect" value="All">
                            <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/>
                            <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                            <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
                            <input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>
                            <div id='paychaaaaa'></div>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="listdiv">
                            <jsp:include page="ordermainGrid.jsp"></jsp:include>
                        </div>
                        <div id="listdiv1">
                            <jsp:include page="ordersubGrid.jsp"></jsp:include>
                        </div>
                        <div id="detaildiv">
                            <jsp:include page="detailgrid.jsp"></jsp:include>
                        </div>
                    </div>
                </div>

            </div>

            <!-- POPUPS -->
            <div id="locationwindow"><div></div></div>
            <div id="accountSearchwindow"><div></div></div>
            
        </div>
    </body>
</html>