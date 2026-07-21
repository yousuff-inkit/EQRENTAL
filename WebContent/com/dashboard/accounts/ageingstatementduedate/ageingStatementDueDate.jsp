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

        /* Level inputs style */
        .level-input {
            width: 40px !important;
            text-align: center;
        }
        
        .level-row {
            display: flex;
            align-items: center;
            gap: 5px;
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
            display: flex;
            flex-direction: column;
        }

        /* Misc */
        #ageingStatementDueDateDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            flex: 1;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             // Uniform 24px date inputs
             $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
             $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#accountDetailsWindow').jqxWindow('close');
            
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
             
             $('#txtaccid').dblclick(function(){
                  accountsSearchContent('accountsDetailsSearch.jsp');
             });
        });
        
        function accountsSearchContent(url) {
            $('#accountDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#accountDetailsWindow').jqxWindow('setContent', data);
                $('#accountDetailsWindow').jqxWindow('bringToFront');
            }); 
        }
        
        function getSalesPerson() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var salesagentItems = items[0].split(",");
                    var salesagentIdItems = items[1].split(",");
                    var optionssalesagent = '<option value="">--Select--</option>';
                    for (var i = 0; i < salesagentItems.length; i++) {
                        optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
                                + salesagentItems[i] + '</option>';
                    }
                    $("select#cmbsalesperson").html(optionssalesagent);
                    if ($('#hidcmbsalesperson').val() != null) {
                        $('#cmbsalesperson').val($('#hidcmbsalesperson').val());
                    }
                }
            }
            x.open("GET", "getSalesPerson.jsp", true);
            x.send();
        }
      
       function getCategory() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var categoryItems = items[0].split(",");
                    var categoryIdItems = items[1].split(",");
                    var optionscategory = '<option value="">--Select--</option>';
                    for (var i = 0; i < categoryItems.length; i++) {
                        optionscategory += '<option value="' + categoryIdItems[i] + '">'
                                + categoryItems[i] + '</option>';
                    }
                    $("select#cmbcategory").html(optionscategory);
                    if ($('#hidcmbcategory').val() != null) {
                        $('#cmbcategory').val($('#hidcmbcategory').val());
                    }
                }
            }
            x.open("GET", "getCategory.jsp?type="+$('#cmbtype').val(), true);
            x.send();
        }
        
        function changelevel1(){ 
           var level1to=$('#txtlevel1to').val();
           var level2to=$('#txtlevel2to').val();
           var level1from=$('#txtlevel1from').val();
           if(level2to!=""){
               if(parseInt(level1to)>parseInt(level2to) || parseInt(level1to)<parseInt(level1from)){
                     $.messager.alert('Message','Not a Valid Range.','warning');
                     $('#txtlevel1to').val('');
                     return 0;
                 }
           }
           
           if(level1to!=""){
               $('#txtlevel2from').val(parseInt(level1to)+1);
           } else{
               $('#txtlevel2from').val('');
           }
        }
        
        function changelevel2(){
             var level2to=$('#txtlevel2to').val();
             var level3to=$('#txtlevel3to').val();
             var level2from=$('#txtlevel2from').val();
             if(level3to!=""){
                 if(parseInt(level2to)>parseInt(level3to) || parseInt(level2to)<parseInt(level2from)){
                    $.messager.alert('Message','Not a Valid Range.','warning');
                    $('#txtlevel2to').val('');
                    return 0;
                 }
             }
            
            if(level2to!=""){
               $('#txtlevel3from').val(parseInt(level2to)+1);
           } else{
               $('#txtlevel3from').val('');
           } 
        }
        
        function changelevel3(){
            var level3to=$('#txtlevel3to').val();
            var level4to=$('#txtlevel4to').val();
            var level3from=$('#txtlevel3from').val();
            if(level4to!=""){
                 if(parseInt(level3to)>parseInt(level4to) || parseInt(level3to)<parseInt(level3from)){
                    $.messager.alert('Message','Not a Valid Range.','warning');
                    $('#txtlevel3to').val('');
                    return 0;
                 }
            }
            
            if(level3to!=""){
               $('#txtlevel4from').val(parseInt(level3to)+1);
           } else{
               $('#txtlevel4from').val('');
           } 
        }
        
        function changelevel4(){
            var level4to=$('#txtlevel4to').val();
            var level4from=$('#txtlevel4from').val();
            if(level4to!=""){
                 if(parseInt(level4to)<parseInt(level4from)){
                    $.messager.alert('Message','Not a Valid Range.','warning');
                    $('#txtlevel4to').val('');
                    return 0;
                 }
            }
            
            if(level4to!=""){
               $('#txtlevel5from').val(parseInt(level4to)+1);
           } else{
               $('#txtlevel5from').val('');
           } 
        }
        
        function getAccType(event){
            var x= event.keyCode;
            if(x==114){
              accountsSearchContent('accountsDetailsSearch.jsp');
            }
        }
        
        function funOutStandingStatement(){
             var accno = $('#txtacountno').val();
             var level1from = $('#txtlevel1from').val();
             var level1to = $('#txtlevel1to').val();
             var level2from = $('#txtlevel2from').val();
             var level2to = $('#txtlevel2to').val();
             var level3from = $('#txtlevel3from').val();
             var level3to = $('#txtlevel3to').val();
             var level4from = $('#txtlevel4from').val();
             var level4to = $('#txtlevel4to').val();
             var level5from = $('#txtlevel5from').val();
            
            if(accno==''){
                 $.messager.alert('Message','Please Choose a Client.','warning');
                 return 0;
             }
            
            if ($("#txtacountno").val()!="") {
                var url=document.URL;
                var reurl=url.split("ageingStatementDueDate.jsp");
                $("#txtacountno").prop("disabled", false);
                var win= window.open(reurl[0]+"printAgeingOutstandingStatementDueDate?atype="+document.getElementById("cmbtype").value+'&acno='+document.getElementById("txtacountno").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("txtbranch").value+'&uptoDate='+$("#uptodate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
             } else {
                $.messager.alert('Message','Account is Mandatory.','warning');
                return;
            }
        }
           
        function clearAccountInfo(){
            $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
        } 
        
        function funreload(event){
             var branchval = document.getElementById("cmbbranch").value;
             var uptodate = $('#uptodate').val();
             var atype = $('#cmbtype').val();
             var accdocno = $('#txtdocno').val();
             var salesperson = $('#cmbsalesperson').val();
             var category = $('#cmbcategory').val();
             var level1from = $('#txtlevel1from').val();
             var level1to = $('#txtlevel1to').val();
             var level2from = $('#txtlevel2from').val();
             var level2to = $('#txtlevel2to').val();
             var level3from = $('#txtlevel3from').val();
             var level3to = $('#txtlevel3to').val();
             var level4from = $('#txtlevel4from').val();
             var level4to = $('#txtlevel4to').val();
             var level5from = $('#txtlevel5from').val();
             var check=1;
            
             if(atype==''){
                 $.messager.alert('Message','Please Choose Account Type.','warning');
                 return 0;
             }
            
             if(level1from==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
             if(level1to==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
             if(level2from==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
             if(level2to==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
             if(level3from==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
             if(level3to==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
             if(level4from==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
             if(level4to==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
             if(level5from==''){$.messager.alert('Message','Level 5 is Mandatory.','warning');return 0;}
            
             $("#overlay, #PleaseWait").show();
            
             $("#ageingStatementDueDateDiv").load("ageingStatementDueDateGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to
                     +'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&check='+check);
        }
        
         function funExportBtn(){
             $("#ageingStatementDueDateDiv").excelexportjs({
                    containerid: "ageingStatementDueDateDiv", 
                    datatype: 'json', 
                    dataset: null, 
                    gridId: "ageingStatementDueDate", 
                    columns: getColumns("ageingStatementDueDate") ,   
                    worksheetName:"AgeingStatement(DueDate)"
                    }); 
         } 
        </script>
    </head>
    
    <body onload="getBranch();getSalesPerson();getCategory();">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Main Filters Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Up To</td>
                                    <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Type</td>
                                    <td>
                                        <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();getCategory();" value='<s:property value="cmbtype"/>'>
                                            <option value="">--Select--</option>
                                            <option value="AR" selected>AR</option>
                                            <option value="AP">AP</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Account</td>
                                    <td>
                                        <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell"></td>
                                    <td>
                                        <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                                        <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell" style="line-height: 1.1;">Sales Person</td>
                                    <td>
                                        <select id="cmbsalesperson" name="cmbsalesperson" value='<s:property value="cmbsalesperson"/>'>
                                            <option value="">--Select--</option>
                                        </select>
                                        <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Category</td>
                                    <td>
                                        <select id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>'>
                                            <option value="">--Select--</option>
                                        </select>
                                        <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <!-- Levels Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Level 1</td>
                                    <td>
                                        <div class="level-row">
                                            <input type="text" id="txtlevel1from" name="txtlevel1from" class="level-input" readonly="readonly" value='0'/>
                                            <span>-</span>
                                            <input type="text" id="txtlevel1to" name="txtlevel1to" class="level-input" onblur="changelevel1();" value='30'/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Level 2</td>
                                    <td>
                                        <div class="level-row">
                                            <input type="text" id="txtlevel2from" name="txtlevel2from" class="level-input" readonly="readonly" value='31'/>
                                            <span>-</span>
                                            <input type="text" id="txtlevel2to" name="txtlevel2to" class="level-input" onblur="changelevel2();" value='60'/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Level 3</td>
                                    <td>
                                        <div class="level-row">
                                            <input type="text" id="txtlevel3from" name="txtlevel3from" class="level-input" readonly="readonly" value='61'/>
                                            <span>-</span>
                                            <input type="text" id="txtlevel3to" name="txtlevel3to" class="level-input" onblur="changelevel3();" value='90'/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Level 4</td>
                                    <td>
                                        <div class="level-row">
                                            <input type="text" id="txtlevel4from" name="txtlevel4from" class="level-input" readonly="readonly" value='91'/>
                                            <span>-</span>
                                            <input type="text" id="txtlevel4to" name="txtlevel4to" class="level-input" onblur="changelevel4();" value='120'/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Level 5</td>
                                    <td>
                                        <div class="level-row">
                                            <input type="text" id="txtlevel5from" name="txtlevel5from" class="level-input" value='121'/>
                                            <span>&gt;=</span>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="action-buttons">
                                <button type="button" class="btn-submit" id="btnIndividual" name="btnIndividual" onclick="funOutStandingStatement();">Outstanding Statement</button>
                            </div>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" id="txtacountno" name="txtacountno" value='<s:property value="txtacountno"/>'/>
                            <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="ageingStatementDueDateDiv">
                            <jsp:include page="ageingStatementDueDateGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="accountDetailsWindow"><div></div><div></div></div>

        </div>
    </body>
</html>