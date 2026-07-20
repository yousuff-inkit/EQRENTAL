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
        <link href="https://fonts.googleapis.com/css?family=Oswald" rel="stylesheet">
        
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

        /* Timer Styles */
        .reload-wrapper {
            text-align: center;
            padding: 20px 0;
        }
        
        .reload-class {
            text-transform: uppercase;
            font-family: 'Oswald', sans-serif;
            color: #4e5e71;
        }
        
        .timer {
            font-family: 'Oswald', sans-serif;
            font-weight: bold;
            color: #000;
            font-size: 24px;
            animation: number 1s ease-in;
            animation-iteration-count: infinite;
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

        /* Bay Styles */
        @keyframes jackInTheBox {
            0% { opacity: 0; transform: scale(.1) rotate(30deg); transform-origin: center bottom }
            50% { transform: rotate(-10deg) }
            70% { transform: rotate(3deg) }
            100% { opacity: 1; transform: scale(1) }
        }

        @-webkit-keyframes number {
            0% { -webkit-transform: scale(0.5); opacity: 0; }
            25% { -webkit-transform: scale(0.5); opacity: 0; }
            50% { -webkit-transform: scale(1); opacity: 1; }
            75% { -webkit-transform: scale(0.5); opacity: 1; }
            100% { -webkit-transform: scale(0.2); opacity: 0; }
        }

        .asd {
            width: 100%;
            border-spacing: 15px 0;
        }

        .bay-heading {
            width: 180px;
            height: auto;
            border-radius: 5px;
            background: linear-gradient(to right, #ACB6E5, #74ebd5);
            text-align: center;
            padding: 15px 25px; 
            box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
            font-size: 13px; 
            color: #fff;
            margin-bottom: 15px;
        }

        .bay-data {
            width: 200px;
            padding: 15px 15px 15px 5px; 
            border-radius: 5px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
            font-size: 11px; 
            transition: all 0.5s ease-in;
            background-color: #fff;
            margin-bottom: 12px;
            animation-name: jackInTheBox;
            animation-duration: 1s;
        }

        .bay-data:hover {
            transform: scale(1.1); /* Reduced scale for better layout stability */
            z-index: 10;
            position: relative;
        }

        .bay-data.delay-class {
            background: linear-gradient(to right, #ff5858, #f857a6);
            color: #fff;
        }
        
        .bay-data.delay-class b {
            color: #fff;
        }

        .bay-data ul {
            list-style: none;
            padding-left: 10px;
            margin: 0;
        }

        .bay-data ul li {
            text-align: left;
            margin-bottom: 4px;
        }
        
        .bay-data ul li b {
            display: inline-block;
            width: 80px;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");    
             
             // Uniform 24px date inputs
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             
             var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
             var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
             $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
             
             getData();
        });

        function funreload(event)
        {
            $('.asd').html('');
            if($('#cmbbranch').val()=="" || $('#cmbbranch').val()=="a"){
                $.messager.alert("Warning","Please select a branch");
                return false;
            }
            getData();
        }
        
        function getData(){
            $("#overlay, #PleaseWait").show(); 
            var fromdate=$('#fromdate').jqxDateTimeInput('val');
            var todate=$('#todate').jqxDateTimeInput('val');
            var branch=$('#cmbbranch').val();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if(items==""){
                        getInitData();
                    }
                    else{
                        var htmldata='';
                        var oldbay='';
                        htmldata+='<tr>';
                        for(var i=0;i<items.split(",").length;i++){
                            var temp=items.split(",")[i].split("::");
                            if(oldbay!=temp[0]){
                                if(i>0){
                                    htmldata+='</td>';
                                }
                                htmldata+='<td style="vertical-align:top" >';
                                htmldata+='<div class="bay-heading"><b>'+temp[0]+'</b></div>';
                                
                                var delayClass = temp[6]=='1' ? ' delay-class' : '';
                                htmldata+='<div class="bay-data'+delayClass+'"><ul><li><b>Fleet No</b>&nbsp;'+temp[1]+'</li><li><b>Asset id</b>&nbsp;'+temp[8]+'</li><li><b>Fleet Name</b>&nbsp;'+temp[7]+'</li><li><b>In Date</b>&nbsp;'+temp[2]+'</li><li><b>In Time</b>&nbsp;'+temp[3]+'</li><li><b>Est Date</b>&nbsp;'+temp[9]+'</li><li><b>Est Time</b>&nbsp;'+temp[4]+'</li><li><b>Used Time</b>&nbsp;'+temp[5]+'</li></ul></div>';
                            }
                            else{
                                var delayClass = temp[6]=='1' ? ' delay-class' : '';
                                htmldata+='<div class="bay-data'+delayClass+'"><ul><li><b>Fleet No</b>&nbsp;'+temp[1]+'</li><li><b>Asset id</b>&nbsp;'+temp[8]+'</li><li><b>Fleet Name</b>&nbsp;'+temp[7]+'</li><li><b>In Date</b>&nbsp;'+temp[2]+'</li><li><b>In Time</b>&nbsp;'+temp[3]+'</li><li><b>Est Date</b>&nbsp;'+temp[9]+'</li><li><b>Est Time</b>&nbsp;'+temp[4]+'</li><li><b>Used Time</b>&nbsp;'+temp[5]+'</li></ul></div>';
                            }
                            oldbay=temp[0];
                        }
                        htmldata+='</tr>';
                    
                        $('.asd').append(htmldata);     
                    }
                
                    $("#overlay, #PleaseWait").hide(); 
                    clearInterval(interval);
                    timer=60;
                    $('.timer').text(timer);
                    interval = setInterval(function() {funreload()},60000);
                }
            }
            x.open("GET", "getBayData.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+branch, true);
            x.send();
        }
         
        function getInitData(){
            var branch=$('#cmbbranch').val();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    var htmldata='';
                    htmldata+='<tr>';
                    for(var i=0;i<items.split(",").length;i++){
                        var temp=items.split(",")[i];
                        if(i>0){
                            htmldata+='</td>';
                        }
                        htmldata+='<td style="vertical-align:top;overflow:auto;" >';
                        htmldata+='<div class="bay-heading"><b>'+temp+'</b></div>';
                        if(i==(items.split(",").length-1)){
                            htmldata+='</td>';
                        }
                    }
                    htmldata+='</tr>';
                
                    $('.asd').append(htmldata);
                }
            }
            x.open("GET", "getBayInitData.jsp?branch="+branch, true);
            x.send();
         }
          
        function setValues(){
        }
          
        var interval = setInterval(function() {funreload()},60000);
        var timer = 60;

        var interval2 = setInterval(function() {
            timer--;
            $('.timer').text(timer);
            if (timer === 0) timer = 60;
        }, 1000); 
        </script>
    </head>
    
    <body onload="getBranch();setValues();">
        <form id="frmBayReport" action="" method="post" style="height: 100%;">
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

                            <!-- Timer Display -->
                            <div class="filter-card">
                                <div class="reload-wrapper">
                                    <span class="reload-class">Reloading in</span>
                                    <div class="timer">60</div>
                                    <span class="reload-class" style="font-size:10px;">seconds</span>
                                </div>
                            </div>

                            <!-- Hidden Data -->
                            <div style="display:none;">
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (BAY GRID) ================= -->
                    <div class="main-content-area">
                        
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <table class="asd">
                                <!-- Bay data injected here -->
                            </table>
                        </div>

                    </div>

                </div>
            </div>
            
        </form>
    </body>
</html>