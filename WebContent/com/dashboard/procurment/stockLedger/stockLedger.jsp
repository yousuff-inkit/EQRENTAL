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

        input[type="radio"], input[type="checkbox"] {
            margin: 0 4px 0 0;
            cursor: pointer;
            width: 14px;
            height: 14px;
            vertical-align: middle;
        }

        .branch {
            font-size: 12px;
            font-weight: 600;
            color: #4e5e71;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
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

        .btn-small {
            width: 24px;
            height: 24px;
            padding: 0;
            line-height: 24px;
            font-size: 14px;
            margin: 0 2px;
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
        #stockLedgerDiv, #stockLedgerDetDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            height: 100%;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $('#stockLedgerDiv').show();
             $('#stockLedgerDetDiv').hide();
             $('#summs').show();
             $('#detial').hide();
             document.getElementById('rsumm').checked=true;
             
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             
             var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
             var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
             var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
             $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); 
            
             $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#ptypewindow').jqxWindow('close');
             $('#brandwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#brandwindow').jqxWindow('close');
             $('#modelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#modelwindow').jqxWindow('close');
             $('#submodelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#submodelwindow').jqxWindow('close');
             $('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#productwindow').jqxWindow('close');
             $('#pcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#pcategorywindow').jqxWindow('close');
             $('#pdeptwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#pdeptwindow').jqxWindow('close');
             $('#psubcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#psubcategorywindow').jqxWindow('close');
             $('#productwindow1').jqxWindow({ width: '50%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
             $('#productwindow1').jqxWindow('close');   
             
             $('#productDetailsWindow').jqxWindow({width: '70%', height: '65%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#productDetailsWindow').jqxWindow('close');
            
             $('#name').dblclick(function(){
                 var aa="STL";
                 productSearchContent1("<%=contextPath%>/com/productsearch/productSearch.jsp?frm="+aa,'productDetailsWindow');
             });
        });

        function productSearchContent1(url,id) {
            $('#'+id).jqxWindow('open');
            $('#'+id).jqxWindow('focus');
            $.get(url).done(function (data) {
                $('#'+id).jqxWindow('setContent', data);
            }); 
        }

        function getname(event) {
             var x= event.keyCode;
             if(x==114){
                 var aa="STL";
                 productSearchContent1("<%=contextPath%>/com/productsearch/productSearch.jsp?frm="+aa,'productDetailsWindow');
             }
        }

        function funExportBtn(){
            if (document.getElementById('rsumm').checked) {
                 $("#stockLedgerDiv").excelexportjs({
                        containerid: "stockLedgerDiv",   
                        datatype: 'json',
                        dataset: null,
                        gridId: "partSearchgrid",
                        columns: getColumns("partSearchgrid") ,   
                        worksheetName:"Stock Ledger Summary"  
                    });   
            }
            if (document.getElementById('rdet').checked) {
                 $("#stockLedgerDetDiv").excelexportjs({
                        containerid: "stockLedgerDetDiv",   
                        datatype: 'json',
                        dataset: null,
                        gridId: "jqxStockDetailGrid",
                        columns: getColumns("jqxStockDetailGrid") ,   
                        worksheetName:"Stock Ledger Detail"  
                    });   
            }
         }
        
        function funreload(event){
             var prodvalue=$('#prodsearchby').val().trim();
             var branchid=document.getElementById("cmbbranch").value;
             var hidbrand=document.getElementById("hidbrandid").value;
             var hidtype=document.getElementById("hidtypeid").value;
             var hidproduct=document.getElementById("hidproductid").value;
             var hidcat=document.getElementById("hidcatid").value;
             var hidsubcat=document.getElementById("hidsubcatid").value;
             var hidept=document.getElementById("hideptid").value;
             var frmdate=$('#fromdate').jqxDateTimeInput('val');
             var todate=$('#todate').jqxDateTimeInput('val');
             
             if (!(document.getElementById('rsumm').checked || document.getElementById('rdet').checked)) {
                 $.messager.alert('Message','Select Summary /Detail','warning');
                 return false;
             }
        
             if (document.getElementById('rsumm').checked) {
                 $('#stockLedgerDiv').show();   
                 $('#summs').show();
                 
                 $("#overlay, #PleaseWait").show();
                 var load="yes";
                 $("#stockLedgerDiv").load("stockLedgerGridSummary.jsp?todate="+todate+"&frmdate="+frmdate+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&load="+load+"&type=1");
             }
            
             if (document.getElementById('rdet').checked) {
                 if(document.getElementById("psrno").value=="") {
                     $.messager.alert('Message','Select Product','warning');
                     return false;
                 }
                
                 $('#detial').show();
                 $('#stockLedgerDetDiv').show();        
                 $("#overlay, #PleaseWait").show();
                 var load="yes";
                 $("#stockLedgerDetDiv").load("stockLedgerGridDetail.jsp?todate="+todate+"&frmdate="+frmdate+"&hidproduct="+document.getElementById("psrno").value+"&branchid="+branchid+"&load="+load+"&type=2");
             }
        }
        
        function getPtype(){
             $('#ptypewindow').jqxWindow('open');
             $('#ptypewindow').jqxWindow('focus');
             typeSearchContent('typeSearch.jsp', $('#ptypewindow'));
        }

        function getPbrand(t){
             $('#brandwindow').jqxWindow('open');
             $('#brandwindow').jqxWindow('focus');
             brandSearchContent('brandSearch.jsp?id='+t, $('#brandwindow'));
        }

        function getPcategory(){
             $('#pcategorywindow').jqxWindow('open');
             $('#pcategorywindow').jqxWindow('focus');
             categorySearchContent('catSearch.jsp', $('#pcategorywindow'));
        }

        function getDept(){
             $('#pdeptwindow').jqxWindow('open');
             $('#pdeptwindow').jqxWindow('focus');
             deptSearchContent('deptSearch.jsp', $('#pdeptwindow'));
        }

        function getPsubcategory(){
            var catid=$('#hidcatid').val().trim();
            $('#psubcategorywindow').jqxWindow('open');
            $('#psubcategorywindow').jqxWindow('focus');
            subcategorySearchContent('subcatSearch.jsp?catid='+catid, $('#psubcategorywindow'));
        }

        function getProduct(){
            var brandid=$('#hidbrandid').val().trim();
            var catid=$('#hidcatid').val().trim();
            var subcatid=$('#hidsubcatid').val().trim();
            productSearchContent1('productSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid, 'productwindow');
        }

        function typeSearchContent(url) {
            $.get(url).done(function (data) {
                $('#ptypewindow').jqxWindow('setContent', data);
            }); 
        }
        
        function brandSearchContent(url) {
            $.get(url).done(function (data) {
                $('#brandwindow').jqxWindow('setContent', data);
            }); 
        }

        function modelSearchContent(url) {
            $.get(url).done(function (data) {
                $('#modelwindow').jqxWindow('setContent', data);
            }); 
        }

        function subModelSearchContent(url) {
            $.get(url).done(function (data) {
                $('#submodelwindow').jqxWindow('setContent', data);
            }); 
        }

        function categorySearchContent(url) {
            $.get(url).done(function (data) {
                $('#pcategorywindow').jqxWindow('setContent', data);
            }); 
        }

        function deptSearchContent(url) {
            $.get(url).done(function (data) {
                $('#pdeptwindow').jqxWindow('setContent', data);
            }); 
        }

        function subcategorySearchContent(url) {
            $.get(url).done(function (data) {
                $('#psubcategorywindow').jqxWindow('setContent', data);
            }); 
        }

        function setprodSearch(){
            var value=$('#prodsearchby').val().trim();

            if(value=="ptype"){ getPtype(); }
            else if(value=="pbrand"){ getPbrand(2); }
            else if(value=="pdept"){ getDept(); }
            else if(value=="product"){ getProduct(); }
            else if(value=="pcategory"){ getPcategory(); }
            else if(value=="psubcategory"){ getPsubcategory(); }
        }
        
        function fundisable(){
            if (document.getElementById('rsumm').checked) {
                 $('#stockLedgerDiv').show();
                 $('#stockLedgerDetDiv').hide();
                 $('#summs').show();
                 $('#detial').hide();
            } else if (document.getElementById('rdet').checked) {
                 $('#stockLedgerDiv').hide();
                 $('#stockLedgerDetDiv').show();
                 $('#summs').hide();
                 $('#detial').show();
            }
        }
        
        function funClearData(){
             document.getElementById("cmbbranch").value="a";
             document.getElementById("hidbrandid").value="";
             document.getElementById("hidtypeid").value="";
             document.getElementById("hidproductid").value="";
             document.getElementById("hidcatid").value="";
             document.getElementById("hidsubcatid").value=""; 
             document.getElementById("hidbrand").value="";
             document.getElementById("hidtype").value="";
             document.getElementById("hidproduct").value="";
             document.getElementById("hidcat").value="";
             document.getElementById("hidsubcat").value="";
             document.getElementById("prodsearchby").value="";
             document.getElementById("searchdetails").value="";
             document.getElementById("hideptid").value="";
             document.getElementById("hidept").value="";
             document.getElementById("searchdetails1").value="";
             document.getElementById("name").value="";
             document.getElementById("psrno").value="";
        }
        
        function setRemove(){
            var prodvalue=$('#prodsearchby').val().trim();
            
            if(prodvalue=="ptype"){
                 document.getElementById("hidtypeid").value="";
                 document.getElementById("hidtype").value="";
            } else if(prodvalue=="pbrand"){
                document.getElementById("hidbrandid").value="";
                document.getElementById("hidproduct").value="";
            } else if(prodvalue=="product"){
                document.getElementById("hidproductid").value="";
                document.getElementById("hidbrand").value="";
            } else if(prodvalue=="pcategory"){
                 document.getElementById("hidcatid").value="";
                 document.getElementById("hidcat").value="";
            } else if(prodvalue=="psubcategory"){
                document.getElementById("hidsubcatid").value="";
                document.getElementById("hidsubcat").value="";
            } else if(prodvalue=="pdept"){
                document.getElementById("hideptid").value="";
                document.getElementById("hidept").value="";
            }
            
            document.getElementById("searchdetails").value="";
            
            if(document.getElementById("hidbrand").value!=""){ document.getElementById("searchdetails").value+="\n"+document.getElementById("hidbrand").value; }
            if(document.getElementById("hidtype").value!=""){ document.getElementById("searchdetails").value+="\n"+document.getElementById("hidtype").value; }
            if(document.getElementById("hidcat").value!=""){ document.getElementById("searchdetails").value+="\n"+document.getElementById("hidcat").value; }
            if(document.getElementById("hidsubcat").value!=""){ document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsubcat").value; }
            if(document.getElementById("hidproduct").value!=""){ document.getElementById("searchdetails").value+="\n"+document.getElementById("hidproduct").value; }
            if(document.getElementById("hidept").value!=""){ document.getElementById("searchdetails").value+="\n"+document.getElementById("hidept").value; }
        }

        function funprintbtn(){
            var url=document.URL;
            var reurl=url.split("stockLedger.jsp");
            todate=$('#todate').jqxDateTimeInput('val');
            var win= window.open(reurl[0]+"printStockledger?&fromdate="+document.getElementById("fromdate").value+"&todate="+todate,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
                        
                        <!-- Report Type Settings -->
                        <div class="filter-card">
                            <fieldset>
                                <legend>Report Type</legend>
                                <div style="display: flex; justify-content: space-around; padding: 5px 0;">
                                    <label for="rsumm" class="branch">
                                        <input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"> Summary
                                    </label>
                                    <label for="rdet" class="branch">
                                        <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"> Detail
                                    </label>
                                </div>
                            </fieldset>
                        </div>

                        <!-- Date Range Card -->
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
                            </table>
                        </div>

                        <!-- Dynamic Search Area -->
                        <div id="detial" class="filter-card" style="display:none;">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Product</td>
                                    <td>
                                        <input type="text" id="name" name="name" readonly="readonly" placeholder="Press F3 for Search" value='<s:property value="name"/>' onKeyDown="getname(event);">
                                    </td>
                                </tr>
                            </table>
                            <div style="margin-top: 10px;">
                                <textarea id="searchdetails1" name="searchdetails1" readonly="readonly" rows="8"></textarea>
                            </div>
                        </div>

                        <div id="summs" class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Product</td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 2px;">
                                            <select name="prodsearchby" id="prodsearchby" style="flex: 1;">
                                                <option value="">--Select--</option>
                                                <option value="ptype">TYPE</option>
                                                <option value="pbrand">BRAND</option>
                                                <option value="pdept">DEPARTMENT</option>
                                                <option value="pcategory">CATEGORY</option>
                                                <option value="psubcategory">SUB CATEGORY</option>
                                                <option value="product">PRODUCT</option>
                                            </select>
                                            <button type="button" name="btnadditem" id="additem" class="btn-submit btn-small" onClick="setprodSearch();">+</button>
                                            <button type="button" name="btnremoveitem" id="btnremoveitem" class="btn-submit btn-clear btn-small" onclick="setRemove();">-</button>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div style="margin-top: 10px;">
                                <textarea id="searchdetails" name="searchdetails" readonly="readonly" rows="8"></textarea>
                            </div>
                        </div>
                        
                        <div class="action-buttons">
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit btn-clear" onclick="funClearData();">Clear</button>
                            <button type="button" name="btnmismatch" id="btnmismatch" class="btn-submit" onclick="funprintbtn();">Mismatch</button>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" name="hidbrandid" id="hidbrandid">
                            <input type="hidden" name="hidtypeid" id="hidtypeid">
                            <input type="hidden" name="hideptid" id="hideptid">
                            <input type="hidden" name="hidcatid" id="hidcatid">
                            <input type="hidden" name="hidsubcatid" id="hidsubcatid">
                            <input type="hidden" name="hidproductid" id="hidproductid">
                            <input type="hidden" name="hidbrand" id="hidbrand">
                            <input type="hidden" name="hidept" id="hidept">
                            <input type="hidden" name="hidtype" id="hidtype">
                            <input type="hidden" name="hidcat" id="hidcat">
                            <input type="hidden" name="hidsubcat" id="hidsubcat">
                            <input type="hidden" name="hidproduct" id="hidproduct">
                            <input type="hidden" name="psrno" id="psrno">
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="stockLedgerDiv">
                            <jsp:include page="stockLedgerGridSummary.jsp"></jsp:include>
                        </div>
                        <div id="stockLedgerDetDiv" style="display:none;">
                            <jsp:include page="stockLedgerGridDetail.jsp"></jsp:include> 
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="ptypewindow"><div></div></div>
            <div id="brandwindow"><div></div></div>
            <div id="modelwindow"><div></div></div>
            <div id="submodelwindow"><div></div></div>
            <div id="productwindow"><div></div></div>
            <div id="pcategorywindow"><div></div></div>
            <div id="pdeptwindow"><div></div></div>
            <div id="psubcategorywindow"><div></div></div>
            <div id="productwindow1"><div></div></div>
            <div id="productDetailsWindow"><div></div></div>

        </div>
    </body>
</html>