<!DOCTYPE html>
<%
	String contextPath = request.getContextPath();
%>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <title>GatewayERP(i)</title>
    <jsp:include page="temp.jsp"></jsp:include>

    <style>
        table th {
            background-color: #F5CBA7;
            border-collapse: collapse;
        }
        
        #table1 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table1 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table1 tr td:nth-child(2),
        #table1 tr td:nth-child(3),
        tr td:nth-child(4),
        #table1 tr td:nth-child(5) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table1 tr th:nth-child(2),
        #table1 tr th:nth-child(3),
        tr th:nth-child(4),
        #table1 tr th:nth-child(5) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table2 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table2 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table2 tr td:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table2 tr th:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table3 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table3 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table3 tr td:nth-child(2),
        #table3 tr td:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table3 tr th:nth-child(2),
        #table3 tr th:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table4 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table4 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table4 tr td:nth-child(2),
        #table4 tr td:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table4 tr th:nth-child(2),
        #table4 tr th:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table5 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table5 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table5 tr td:nth-child(2),
        #table5 tr td:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table5 tr th:nth-child(2),
        #table5 tr th:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table6 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table6 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table6 tr td:nth-child(2),
        #table6 tr td:nth-child(3),
        #table6 tr td:nth-child(4),
        #table6 tr td:nth-child(5) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table6 tr th:nth-child(2),
        #table6 tr th:nth-child(3),
        #table6 tr th:nth-child(4),
        #table6 tr th:nth-child(5) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table7 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table7 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table7 tr td:nth-child(2),
        #table7 tr td:nth-child(3),
        #table7 tr td:nth-child(4),
        #table7 tr td:nth-child(5) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table7 tr th:nth-child(2),
        #table7 tr th:nth-child(3),
        #table7 tr th:nth-child(4),
        #table7 tr th:nth-child(5) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table8 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table8 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table8 tr td:nth-child(2),
        #table8 tr td:nth-child(3),
        #table8 tr td:nth-child(4),
        #table8 tr td:nth-child(5) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table8 tr th:nth-child(2),
        #table8 tr th:nth-child(3),
        #table8 tr th:nth-child(4),
        #table8 tr th:nth-child(5) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table9 tr td:nth-child(1) {
            padding-left: 5px;
        }
        
        #table9 tr th:nth-child(1) {
            padding-left: 5px;
        }
        
        #table9 tr td:nth-child(2),
        #table9 tr td:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        #table9 tr th:nth-child(2),
        #table9 tr th:nth-child(3) {
            text-align: right;
            padding-right: 5px;
        }
        
        .redClass {
            color: #FF0000;
        }
    </style>
    <style type="text/css">
        .chart-inner-text {
            fill: #00BAFF;
            color: #00BAFF;
            font-size: 30px;
            font-family: Verdana;
        }
        
        #psearch {
            background: #FAEBD7;
        }
        
        .button3:hover {
            background-color: #3e8e41
        }
        
        .button3:active {
            background-color: #3e8e41;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
        
        .button {
            background-color: #3498db;
            border: thin;
            color: white;
            padding: 7px 20px;
            text-align: justify;
            text-decoration: none;
            display: inline-block;
            font-size: 12px;
            margin: 4px 2px;
            border-radius: 28px;
            cursor: pointer;
            -webkit-transition-duration: 0.4s;
            /* Safari */
            transition-duration: 0.4s;
        }
        
        .button2:hover {
            box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0 rgba(0, 0, 0, 0.19);
            background-color: graytext;
        }
        
        .textbox {
            border: 0;
            height: 25px;
            width: 20%;
            border-radius: 5px;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
            -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
            -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
            -webkit-background-clip: padding-box;
            outline: 0;
        }
    </style>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

    <!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->

    <!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->

    <script type="text/javascript">
        var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        var colorArray = ['rgb(255, 99, 132)', 'rgb(255, 159, 64)', 'rgb(255, 205, 86)', 'rgb(75, 192, 192)', 'rgb(54, 162, 235)', 'rgb(153, 102, 255)', 'rgb(201, 203, 207)',
            'rgb(255, 15, 0)', 'rgb(255, 102, 0)', 'rgb(255, 158, 1)', 'rgb(252, 210, 2)', 'rgb(248, 255, 1)', 'rgb(176, 222, 9)', 'rgb(4, 210, 21)', 'rgb(13, 142, 207)',
            'rgb(13, 82, 209)', 'rgb(42, 12, 208)', 'rgb(138, 12, 207)', 'rgb(205, 13, 116)', 'rgb(117, 77, 235)', 'rgb(221, 221, 221)', 'rgb(153, 153, 153)', 'rgb(51, 51, 51)'
        ];
        window.chartColors = {
            red: 'rgb(255, 99, 132)',
            orange: 'rgb(255, 159, 64)',
            yellow: 'rgb(255, 205, 86)',
            green: 'rgb(75, 192, 192)',
            blue: 'rgb(54, 162, 235)',
            purple: 'rgb(153, 102, 255)',
            grey: 'rgb(201, 203, 207)',
            color1: 'rgb(255, 15, 0)',
            color2: 'rgb(255, 102, 0)',
            color3: 'rgb(255, 158, 1)',
            color4: 'rgb(252, 210, 2)',
            color5: 'rgb(248, 255, 1)',
            color6: 'rgb(176, 222, 9)',
            color7: 'rgb(4, 210, 21)',
            color8: 'rgb(13, 142, 207)',
            color9: 'rgb(13, 82, 209)',
            color10: 'rgb(42, 12, 208)',
            color11: 'rgb(138, 12, 207)',
            color12: 'rgb(205, 13, 116)',
            color13: 'rgb(117, 77, 235)',
            color14: 'rgb(221, 221, 221)',
            color15: 'rgb(153, 153, 153)',
            color16: 'rgb(51, 51, 51)'
        };
        var barChartData = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                label: 'Tour',
                backgroundColor: window.chartColors.red,
                borderColor: window.chartColors.red,
                data: [5, 10, 15, 20, 30],
                fill: false
            }, {
                label: 'Ticket',
                backgroundColor: window.chartColors.blue,
                borderColor: window.chartColors.blue,
                data: [5, 8, 2, 16, 22],
                fill: false
            }, {
                label: 'Hotel',
                backgroundColor: window.chartColors.green,
                borderColor: window.chartColors.green,
                data: [3, 15, 2, 25, 12],
                fill: false
            }, {
                label: 'Visa',
                backgroundColor: window.chartColors.purple,
                borderColor: window.chartColors.purple,
                data: [5, 8, 2, 16, 22],
                fill: false
            }, {
                label: 'Other',
                backgroundColor: window.chartColors.grey,
                borderColor: window.chartColors.grey,
                data: [3, 15, 2, 25, 12],
                fill: false
            }]

        };
        var chartcountmonthwiseconfig = {
            type: 'line',
            data: {
                labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                datasets: [{
                    label: 'Tour',
                    backgroundColor: window.chartColors.red,
                    borderColor: window.chartColors.red,
                    data: [5, 10, 15, 20, 30],
                    fill: false,
                }, {
                    label: 'Hotel',
                    backgroundColor: window.chartColors.blue,
                    borderColor: window.chartColors.blue,
                    data: [5, 8, 2, 16, 22],
                    fill: false,
                }, {
                    label: 'Ticket Voucher',
                    backgroundColor: window.chartColors.yellow,
                    borderColor: window.chartColors.yellow,
                    data: [3, 15, 2, 25, 12],
                    fill: false,
                }, ]
            },
            options: {
                responsive: true,
                title: {
                    display: false,
                    text: 'Chart.js Line Chart'
                },
                tooltips: {
                    mode: 'index',
                    intersect: false,
                },
                hover: {
                    mode: 'nearest',
                    intersect: true
                },
                scales: {
                    xAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Month'
                        }
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Value'
                        }
                    }]
                }
            }
        };

        var charttourmonthwiseconfig = {
            type: 'line',
            data: {
                labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                datasets: []
            },
            options: {
                responsive: true,
                title: {
                    display: false,
                    text: 'Chart.js Line Chart'
                },
                tooltips: {
                    mode: 'index',
                    intersect: false,
                },
                hover: {
                    mode: 'nearest',
                    intersect: true
                },
                scales: {
                    xAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Month'
                        }
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Value'
                        }
                    }]
                }
            }
        };
        window.onload = function() {};
        $(document).ready(function() {
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        });
        $(window).ready(function() {
            var chartcountmonthwisectx = document.getElementById('chartcountmonthwise').getContext('2d');
            window.chartcountmonthwise = new Chart(chartcountmonthwisectx, chartcountmonthwiseconfig);
            var charttourmonthwisectx = document.getElementById('charttourmonthwise').getContext('2d');
            window.charttourmonthwise = new Chart(charttourmonthwisectx, charttourmonthwiseconfig);
            var barchartctx = document.getElementById('chartvaluemonthwise').getContext('2d');
            window.chartvaluemonthwise = new Chart(barchartctx, {
                type: 'line',
                data: barChartData,
                options: {
                    title: {
                        display: false,
                        text: 'Invoice Analytics - Stacked'
                    },
                    tooltips: {
                        mode: 'index',
                        intersect: false
                    },
                    responsive: true,
                    maintainAspectRatio: true,
                    scales: {
                        xAxes: [{
                            stacked: true,
                        }],
                        yAxes: [{
                            stacked: true
                        }]
                    }
                }
            });
            getInitData();
            getTourInitData();
        });

        function getTourInitData() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    var chartdata = JSON.parse(items.trim());
                    console.log(chartdata);
                    window.charttourmonthwise.data.labels = chartdata.labels;
                    $(chartdata.locdata).each(function(index, value) {
                        console.log("value check:" + value);
                        window.charttourmonthwise.data.datasets.push({
                            label: value.label,
                            backgroundColor: colorArray[index],
                            borderColor: colorArray[index],
                            data: value.data,
                            fill: false
                        });
                    });
                    window.charttourmonthwise.options.title.text = chartdata.charttourtitle;
                    window.charttourmonthwise.update();
                    $('.page-loader').hide();
                }
            }
            x.open("GET", "getTourInitData.jsp", true);
            x.send();
        }

        function getPaytype() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');

                    var pay = items[0].split("#");
                    var cash = items[1].split("#");
                    var card = items[2].split("#");
                    var chpdc = items[3].split("#");
                    var chcdc = items[4].split("#");

                    var optionsbranch = '';
                    for (var i = 0; i < pay.length; i++) {
                        optionsbranch += '<tr class="primary"><td>' + pay[i].trim() + '</td>' +
                            '<td>' + cash[i].trim() + '</td>' +
                            '<td>' + card[i].trim() + '</td>' +
                            '<td>' + chpdc[i].trim() + '</td>' +
                            '<td>' + chcdc[i].trim() + '</td></tr>';
                        //alert(optionsbranch);
                    }
                    $("#table1").append($.parseHTML(optionsbranch));

                } else {}
            }
            x.open("GET", "getPaytype.jsp", true);
            x.send();
        }

        function getBank() {

            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    //alert(items);
                    items = items.split('####');

                    var den = items[0].split(",,");
                    var descr = items[1].split(",,");
                    var amt = items[2].split(",,");

                    var optionsbranch1 = '';
                    //alert(den.length);
                    for (var i = 0; i < den.length; i++) {
                        optionsbranch1 += '<tr><td>' + den[i].trim() + '</td>' +
                            '<td>' + descr[i].trim() + '</td>' +
                            '<td>' + amt[i].trim() + '</td></tr>';
                        //alert(optionsbranch2);
                    }
                    $("#table2").append(optionsbranch1);

                } else {}
            }
            x.open("GET", "getBank.jsp", true);
            x.send();
        }

        function getPdcsummary() {

            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    //alert(items);
                    items = items.split('####');

                    var type = items[0].split("#");
                    var received = items[1].split("#");
                    var paid = items[2].split("#");

                    var optionsbranch2 = '';
                    for (var i = 0; i < type.length; i++) {
                        optionsbranch2 += '<tr><td>' + type[i].trim() + '</td>' +
                            '<td>' + received[i].trim() + '</td>' +
                            '<td>' + paid[i].trim() + '</td></tr>';
                        //alert(optionsbranch2);
                    }
                    $("#table3").append(optionsbranch2);

                } else {}
            }
            x.open("GET", "getPdcsummary.jsp", true);
            x.send();
        }

        function getOwncategory() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    //alert(items);
                    items = items.split('####');

                    var cat = items[0].split("#");
                    var outstanding = items[1].split("#");
                    var advance = items[2].split("#");
                    var overdue = items[3].split("#");

                    var optionsbranch2 = '';
                    for (var i = 0; i < cat.length; i++) {
                        optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>' +
                            '<td>' + outstanding[i].trim() + '</td>' +
                            '<td>' + advance[i].trim() + '</td>' +
                            '<td>' + overdue[i].trim() + '</td></tr>';
                        //alert(optionsbranch2);
                    }
                    $("#table4").append(optionsbranch2);

                } else {}
            }
            x.open("GET", "getOwncategory.jsp", true);
            x.send();
        }

        function getPayablecategory() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    //alert(items);
                    items = items.split('####');

                    var cat = items[0].split("#");
                    var outstanding = items[1].split("#");
                    var advance = items[2].split("#");
                    var overdue = items[3].split("#");

                    var optionsbranch2 = '';
                    for (var i = 0; i < cat.length; i++) {
                        optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>' +
                            '<td>' + outstanding[i].trim() + '</td>' +
                            '<td>' + advance[i].trim() + '</td>' +
                            '<td>' + overdue[i].trim() + '</td></tr>';
                        //alert(optionsbranch2);
                    }
                    $("#table5").append(optionsbranch2);

                } else {}
            }
            x.open("GET", "getPayablecategory.jsp", true);
            x.send();
        }

        function getTourpending() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('####');

                    var cat = items[0].split("#");
                    var purcount = items[1].split("#");
                    var purvalue = items[2].split("#");
                    var invcount = items[3].split("#");
                    var invvalue = items[4].split("#");
                    var optionsbranch2 = '';
                    for (var i = 0; i < cat.length; i++) {
                        optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>' +
                            '<td>' + purcount[i].trim() + '</td>' +
                            '<td>' + purvalue[i].trim() + '</td>' +
                            '<td>' + invcount[i].trim() + '</td>' +
                            '<td>' + invvalue[i].trim() + '</td></tr>';
                        //alert(optionsbranch2);
                    }
                    $("#table6").append(optionsbranch2);

                } else {}
            }
            x.open("GET", "getTourpending.jsp", true);
            x.send();
        }

        function getTicketpending() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('####');

                    var cat = items[0].split("#");
                    var purcount = items[1].split("#");
                    var purvalue = items[2].split("#");
                    var invcount = items[3].split("#");
                    var invvalue = items[4].split("#");
                    var optionsbranch2 = '';
                    for (var i = 0; i < cat.length; i++) {
                        optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>' +
                            '<td>' + purcount[i].trim() + '</td>' +
                            '<td>' + purvalue[i].trim() + '</td>' +
                            '<td>' + invcount[i].trim() + '</td>' +
                            '<td>' + invvalue[i].trim() + '</td></tr>';
                        //alert(optionsbranch2);
                    }
                    $("#table7").append(optionsbranch2);

                } else {}
            }
            x.open("GET", "getTicketpending.jsp", true);
            x.send();
        }

        function getVoucherpending() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('####');

                    var cat = items[0].split("#");
                    var purcount = items[1].split("#");
                    var purvalue = items[2].split("#");
                    var invcount = items[3].split("#");
                    var invvalue = items[4].split("#");
                    var optionsbranch2 = '';
                    for (var i = 0; i < cat.length; i++) {
                        optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>' +
                            '<td>' + purcount[i].trim() + '</td>' +
                            '<td>' + purvalue[i].trim() + '</td>' +
                            '<td>' + invcount[i].trim() + '</td>' +
                            '<td>' + invvalue[i].trim() + '</td></tr>';
                        //alert(optionsbranch2);
                    }
                    $("#table8").append(optionsbranch2);

                } else {}
            }
            x.open("GET", "getVoucherpending.jsp", true);
            x.send();
        }

        function getTourStock() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('####');

                    var cat = items[0].split("#");
                    var purcount = items[1].split("#");
                    var purvalue = items[2].split("#");
                    var optionsbranch2 = '';
                    for (var i = 0; i < cat.length; i++) {
                        optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>' +
                            '<td>' + purcount[i].trim() + '</td>' +
                            '<td>' + purvalue[i].trim() + '</td></tr>';
                        //alert(optionsbranch2);
                    }
                    $("#table9").append(optionsbranch2);
                    if(cat==""){  
                      $('#hidestock').hide();
                    }else{
                      $('#hidestock').show();
                    }
                } else {}
            }
            x.open("GET", "getTourStock.jsp", true);
            x.send();  
        }

        function getInitData() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    var countchartdata = JSON.parse(items.split("::")[0].trim());
                    console.log(countchartdata.labels);
                    window.chartcountmonthwise.data.labels = countchartdata.labels;
                    window.chartcountmonthwise.data.datasets[0].data = countchartdata.charttourcount;
                    window.chartcountmonthwise.data.datasets[1].data = countchartdata.charthotelcount;
                    window.chartcountmonthwise.data.datasets[2].data = countchartdata.chartticketcount;
                    window.chartcountmonthwise.options.title.text = countchartdata.chartcounttitle;
                    window.chartcountmonthwise.update();
                    window.chartvaluemonthwise.data.labels = countchartdata.labels;
                    window.chartvaluemonthwise.data.datasets[0].data = countchartdata.charttourvalue;
                    window.chartvaluemonthwise.data.datasets[1].data = countchartdata.chartticketvalue;
                    window.chartvaluemonthwise.data.datasets[2].data = countchartdata.charthotelvalue;
                    window.chartvaluemonthwise.data.datasets[3].data = countchartdata.chartvisavalue;
                    window.chartvaluemonthwise.data.datasets[4].data = countchartdata.chartothervalue;
                    window.chartvaluemonthwise.options.title.text = countchartdata.chartvaluetitle;
                    window.chartvaluemonthwise.update();
                    $('.page-loader').hide();
                }
            }
            x.open("GET", "getClientInitData.jsp", true);
            x.send();
        }
    </script>

    <style>
        .hidden-scrollbar {
            overflow: scroll;
            height: 640px;
        }
        /* width */
        
        ::-webkit-scrollbar {
            width: 10px;
        }
        /* Track */
        
        ::-webkit-scrollbar-track {
            box-shadow: inset 0 0 5px grey;
            border-radius: 10px;
        }
        /* Handle */
        
        ::-webkit-scrollbar-thumb {
            background: #7163e8;
            border-radius: 10px;
        }
        /* Handle on hover */
        
        ::-webkit-scrollbar-thumb:hover {
            background: #5d4cef;
        }
        /* SCROLL */
        
        footer .glyphicon {
            font-size: 20px;
            margin-bottom: 20px;
            color: #f4511e;
        }
        
        .slideanim {
            visibility: hidden;
        }
        
        .slide {
            animation-name: slide;
            -webkit-animation-name: slide;
            animation-duration: 1s;
            -webkit-animation-duration: 1s;
            visibility: visible;
        }
        
        @ keyframes slide {
            0% {
                opacity: 0;
                transform: translateY(70%);
            }
            100% {
                opacity: 1;
                transform: translateY (0%);
            }
        }
        
        @ -webkit-keyframes slide {
            0% {
                opacity: 0;
                -webkit-transform: translateY(70%);
            }
            100% {
                opacity: 1;
                -webkit-transform: translateY (0%);
            }
        }
        /* body{
  background: #215A6D;
  font: 12pt Georgia;
  color: #f2f2f2;
  margin: 0;
  padding: 0;
}

a{
  color: #f2f2f2;
  text-decoration: none;
}

#footer{
  margin-bottom: -150px;
  clear: both;
}

.tomottoWrap{
  position: relative;
  background: #3CA2A2;
}

#tomotto{
  text-align: center;
  width: 960px;
  letter-spacing: 2px;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
  line-height: 36px;
  margin: auto;
}

.lookWrap{
  position: relative; 
  background-color: #215A6D;
  float: left;
  width: 100%;
}

#look{
  margin: auto;
  width: 700px;
}

.section{
  overflow: hidden;
  float: left;
  display: inline;
  width: 160px;
  margin: 0 15px 15px 0;
  font: 10pt verdana;
  line-height: 1.6em;
}

.section h3{
  font-weight: normal;
  font: 12pt Georgia;
  text-transform: uppercase;
  color: #f2f2f2;
}

.section a{
  display: block;
}

.legality{
  margin: auto;
  width: 700px;
  text-align: center;
  clear: both;
  font: 10pt verdana;
  line-height: 2em;
  padding: 40px 0 0 0;
} */
        /* REMOVE THIS, USE YOUR OWN  */
        
        .dummy_page {
            height: 200px;
            width: 100%;
            background-color: #f0f0f0;
            text-align: center;
            box-sizing: border-box;
            padding: 60px 0px;
        }
        /* STYLES SPECIFIC TO FOOTER  */
        
        .footer {
            width: 105%;
            position: relative;
            height: auto;
            background-color: #000000;
            /* #070617; */
        }
        
        .footer .col {
            width: 190px;
            height: auto;
            float: left;
            box-sizing: border-box;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            padding: 0px 20px 20px 20px;
        }
        
        .footer .col h1 {
            margin: 0;
            padding: 0;
            font-family: inherit;
            font-size: 12px;
            line-height: 17px;
            padding: 20px 0px 5px 0px;
            color: rgba(255, 255, 255, 0.2);
            font-weight: normal;
            text-transform: uppercase;
            letter-spacing: 0.250em;
        }
        
        .footer .col ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        
        .footer .col ul li {
            color: #999999;
            font-size: 14px;
            font-family: inherit;
            font-weight: bold;
            padding: 0px 0px 0px 0px;
            cursor: pointer;
            transition: .2s;
            -webkit-transition: .2s;
            -moz-transition: .2s;
        }
        
        .social ul li {
            display: inline-block;
            padding-right: 5px !important;
        }
        
        .footer .col ul li:hover {
            color: #ffffff;
            transition: .1s;
            -webkit-transition: .1s;
            -moz-transition: .1s;
        }
        
        .clearfix {
            clear: both;
            color: #ffffff;
            transition: .1s;
            -webkit-transition: .1s;
            -moz-transition: .1s;
        }
        
        @media only screen and (min-width: 1280px) {
            .contain {
                width: 1200px;
                margin: 0 auto;
            }
        }
        
        @media only screen and (max-width: 1139px) {
            .contain .social {
                width: 1000px;
                display: block;
            }
            .social h1 {
                margin: 0px;
            }
        }
        
        @media only screen and (max-width: 950px) {
            .footer .col {
                width: 33%;
            }
            .footer .col h1 {
                font-size: 14px;
            }
            .footer .col ul li {
                font-size: 13px;
            }
        }
        
        @media only screen and (max-width: 500px) {
            .footer .col {
                width: 50%;
            }
            .footer .col h1 {
                font-size: 14px;
            }
            .footer .col ul li {
                font-size: 13px;
            }
        }
        
        @media only screen and (max-width: 340px) {
            .footer .col {
                width: 100%;
            }
        }
        /* 
\\\\\\\ */
        
        body {
            position: relative;
            overflow-x: hidden;
        }
        
        body,
        html {
            height: 100%;
        }
        
        .nav .open>a,
        .nav .open>a:hover,
        .nav .open>a:focus {
            background-color: transparent;
        }
        /*-------------------------------*/
        /*           Wrappers            */
        /*-------------------------------*/
        
        #wrapper {
            padding-left: 0;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }
        
        #wrapper.toggled {
            padding-left: 220px;
        }
        
        #sidebar-wrapper {
            z-index: 1000;
            left: 220px;
            width: 0;
            height: 100%;
            margin-left: -220px;
            overflow-y: auto;
            overflow-x: hidden;
            background: #1a1a1a;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }
        
        #sidebar-wrapper::-webkit-scrollbar {
            display: none;
        }
        
        #wrapper.toggled #sidebar-wrapper {
            width: 220px;
        }
        
        #page-content-wrapper {
            width: 100%;
            padding-top: 0px;
        }
        
        #wrapper.toggled #page-content-wrapper {
            position: absolute;
            margin-right: -220px;
        }
        /*-------------------------------*/
        /*     Sidebar nav styles        */
        /*-------------------------------*/
        
        .sidebar-nav {
            position: absolute;
            top: 0;
            width: 220px;
            margin: 0;
            padding: 0;
            list-style: none;
        }
        
        .sidebar-nav li {
            position: relative;
            line-height: 20px;
            display: inline-block;
            width: 100%;
        }
        
        .sidebar-nav li:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            z-index: -1;
            height: 100%;
            width: 3px;
            background-color: #1c1c1c;
            -webkit-transition: width .2s ease-in;
            -moz-transition: width .2s ease-in;
            -ms-transition: width .2s ease-in;
            transition: width .2s ease-in;
        }
        
        .sidebar-nav li:first-child a {
            color: #fff;
            background-color: #1a1a1a;
        }
        
        .sidebar-nav li:nth-child(2):before {
            background-color: #ec1b5a;
        }
        
        .sidebar-nav li:nth-child(3):before {
            background-color: #79aefe;
        }
        
        .sidebar-nav li:nth-child(4):before {
            background-color: #314190;
        }
        
        .sidebar-nav li:nth-child(5):before {
            background-color: #279636;
        }
        
        .sidebar-nav li:nth-child(6):before {
            background-color: #7d5d81;
        }
        
        .sidebar-nav li:nth-child(7):before {
            background-color: #ead24c;
        }
        
        .sidebar-nav li:nth-child(8):before {
            background-color: #2d2366;
        }
        
        .sidebar-nav li:nth-child(9):before {
            background-color: #35acdf;
        }
        
        .sidebar-nav li:hover:before,
        .sidebar-nav li.open:hover:before {
            width: 100%;
            -webkit-transition: width .2s ease-in;
            -moz-transition: width .2s ease-in;
            -ms-transition: width .2s ease-in;
            transition: width .2s ease-in;
        }
        
        .sidebar-nav li a {
            display: block;
            color: #ddd;
            text-decoration: none;
            padding: 10px 15px 10px 30px;
        }
        
        .sidebar-nav li a:hover,
        .sidebar-nav li a:active,
        .sidebar-nav li a:focus,
        .sidebar-nav li.open a:hover,
        .sidebar-nav li.open a:active,
        .sidebar-nav li.open a:focus {
            color: #fff;
            text-decoration: none;
            background-color: transparent;
        }
        
        .sidebar-nav>.sidebar-brand {
            height: 65px;
            font-size: 20px;
            line-height: 44px;
        }
        
        .sidebar-nav .dropdown-menu {
            position: relative;
            width: 100%;
            padding: 0;
            margin: 0;
            border-radius: 0;
            border: none;
            background-color: #222;
            box-shadow: none;
        }
        /*-------------------------------*/
        /*       Hamburger-Cross         */
        /*-------------------------------*/
        
        .hamburger {
            position: fixed;
            top: 20px;
            z-index: 999;
            display: block;
            width: 32px;
            height: 32px;
            margin-left: 15px;
            background: transparent;
            border: none;
        }
        
        .hamburger:hover,
        .hamburger:focus,
        .hamburger:active {
            outline: none;
        }
        
        .hamburger.is-closed:before {
            content: '';
            display: block;
            width: 100px;
            font-size: 14px;
            color: #fff;
            line-height: 32px;
            text-align: center;
            opacity: 0;
            -webkit-transform: translate3d(0, 0, 0);
            -webkit-transition: all .35s ease-in-out;
        }
        
        .hamburger.is-closed:hover:before {
            opacity: 1;
            display: block;
            -webkit-transform: translate3d(-100px, 0, 0);
            -webkit-transition: all .35s ease-in-out;
        }
        
        .hamburger.is-closed .hamb-top,
        .hamburger.is-closed .hamb-middle,
        .hamburger.is-closed .hamb-bottom,
        .hamburger.is-open .hamb-top,
        .hamburger.is-open .hamb-middle,
        .hamburger.is-open .hamb-bottom {
            position: absolute;
            left: 0;
            height: 4px;
            width: 100%;
        }
        
        .hamburger.is-closed .hamb-top,
        .hamburger.is-closed .hamb-middle,
        .hamburger.is-closed .hamb-bottom {
            background-color: #1a1a1a;
        }
        
        .hamburger.is-closed .hamb-top {
            top: 5px;
            -webkit-transition: all .35s ease-in-out;
        }
        
        .hamburger.is-closed .hamb-middle {
            top: 50%;
            margin-top: -2px;
        }
        
        .hamburger.is-closed .hamb-bottom {
            bottom: 5px;
            -webkit-transition: all .35s ease-in-out;
        }
        
        .hamburger.is-closed:hover .hamb-top {
            top: 0;
            -webkit-transition: all .35s ease-in-out;
        }
        
        .hamburger.is-closed:hover .hamb-bottom {
            bottom: 0;
            -webkit-transition: all .35s ease-in-out;
        }
        
        .hamburger.is-open .hamb-top,
        .hamburger.is-open .hamb-middle,
        .hamburger.is-open .hamb-bottom {
            background-color: #1a1a1a;
        }
        
        .hamburger.is-open .hamb-top,
        .hamburger.is-open .hamb-bottom {
            top: 50%;
            margin-top: -2px;
        }
        
        .hamburger.is-open .hamb-top {
            -webkit-transform: rotate(45deg);
            -webkit-transition: -webkit-transform .2s cubic-bezier(.73, 1, .28, .08);
        }
        
        .hamburger.is-open .hamb-middle {
            display: none;
        }
        
        .hamburger.is-open .hamb-bottom {
            -webkit-transform: rotate(-45deg);
            -webkit-transition: -webkit-transform .2s cubic-bezier(.73, 1, .28, .08);
        }
        
        .hamburger.is-open:before {
            content: '';
            display: block;
            width: 100px;
            font-size: 14px;
            color: #fff;
            line-height: 32px;
            text-align: center;
            opacity: 0;
            -webkit-transform: translate3d(0, 0, 0);
            -webkit-transition: all .35s ease-in-out;
        }
        
        .hamburger.is-open:hover:before {
            opacity: 1;
            display: block;
            -webkit-transform: translate3d(-100px, 0, 0);
            -webkit-transition: all .35s ease-in-out;
        }
        /*-------------------------------*/
        /*            Overlay            */
        /*-------------------------------*/
        
        .overlay {
            position: fixed;
            display: none;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(250, 250, 250, .8);
            z-index: 1;
        }
        
        #myCarousel {
            background: rgba(0, 0, 0, 0.9);
        }
        
        .mainimg {
            /*     opacity: 0.4; */
            filter: alpha(opacity=50);
            /* For IE8 and earlier */
        }
        
        .mainmenus {
            -webkit-transition: all .35s ease-in-out;
        }
        
        @import "compass/css3";
        @import url(https://fonts.googleapis.com/css?family=Roboto);
        body {
            font-family: 'Roboto', sans-serif;
        }
        
        .headingcontainer {
            width: 900px;
            margin: 0 auto;
        }
        /* HEADING 1 */
        
        .heading1 h3 {
            margin: 0 auto;
            text-align: center;
        }
        
        .heading1 h3 {
            color: #5c5c5c;
            width: 75%;
            font-size: 2rem;
            letter-spacing: .2em;
            text-transform: uppercase;
            font-weight: 400;
            line-height: 0.5em;
            position: relative;
            padding: 1em 0 1em;
            border-bottom: 5px solid #ccc;
        }
        /* HEADING 2*/
        
        .heading2 h3 {
            text-transform: uppercase;
            font-size: 2em;
            /* text-shadow: 1px 5px 0 rgba(0,0,0,0.2); */
            color: #B40101;
            /* 	border-bottom: 1px dotted #333;
	padding-bottom: 0.5em; */
            text-align: center;
            margin-bottom: 0.5em;
            letter-spacing: 1px;
        }
        
        .labelcs {
            font-size: 1em;
            color: #B40101;
            margin-bottom: 0.5em;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        /* HEADING 3*/
        
        .heading3 h3 {
            overflow: hidden;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 2em;
            color: #B40101;
        }
        
        .heading3 h3:before,
        .heading3 h3:after {
            content: '';
            display: inline-block;
            height: 1px;
            position: relative;
            top: -2px;
            vertical-align: middle;
        }
        
        .heading3 h3:before {
            background-color: #B40101;
            left: -.5em;
            margin-left: -100%;
            width: 100%;
        }
        
        .heading3 h3:after {
            background-color: #B40101;
            left: .5em;
            margin-right: -100%;
            width: 100%;
        }
        /* HEADING 4 */
        
        .heading4 h3 {
            margin-top: 50px;
            display: -webkit-flex;
            display: flex;
            width: 100%;
            font-size: 2em;
            letter-spacing: 2px;
            font-weight: 100;
        }
        
        .heading4 h3:after {
            -webkit-flex: 3;
            -flex: 3;
            display: inline-block;
            content: "";
            height: 1px;
            background: #999;
            margin: auto 0 auto 20px;
        }
        /* icons/logogatetrans.png */
        
        hr.style-eight {
            overflow: visible;
            /* For IE */
            padding: 0;
            border: none;
            border-top: medium double #91a0ea;
            color: #91a0ea;
            text-align: center;
        }
        
        hr.style-eight:after {
            /* § */
            content: "gatewayerp.com";
            display: inline-block;
            position: relative;
            top: -0.7em;
            font-size: 1em;
            padding: 0 0.25em;
            background: white;
        }
        
        @media only screen and (max-width: 600px) {
            .heading2 h3 {
                font-size: 1.5em;
            }
        }
    </style>

</head>

<body onload="getPaytype();getPdcsummary();getBank();getOwncategory();getPayablecategory();getTourpending();getTicketpending();getVoucherpending();getTourStock();" id="myPage" data-spy="scroll" data-target=".navbar" data-offset="50" style="background: #fff;">
    <nav class="navbar navbar-default navbar-fixed-top" style="background-color: #fff;">
        <div class="container-fluid" id="div1">
            <a class="navbar-brand hidden-xs" href="#">
                <img src="icons/gw.png" width="345px" height="auto">
            </a>
            <a class="navbar-brand visible-xs" href="#">
                <img src="icons/gw.png" width="100%" height="auto" style="margin-bottom:5px;">
            </a>

            <ul class="nav navbar-nav navbar-right">
                <li class="hidden-xs">
                    <img class="pull-right" src="icons/travellogo.png" width="auto" height="80px" style="background-color: #87b321;">
                </li>
                <li class="visible-xs">
                    <img class="" src="icons/travellogo.png" width="100%" height="auto" style="background-color: #87b321;">
                </li>
            </ul>
        </div>
    </nav>
    <div class="container-fluid">
        <div class="content" style="margin-top:80px;">
        	<div class="visible-xs" style="margin-top:300px;"></div>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Collections</h3>
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table1" align="center">
                <tr class="primary">
                    <th width="30%">&nbsp;</th>
                    <th width="10%">Cash</th>
                    <th width="10%">Card</th>
                    <th width="15%">Cheque PDC</th>
                    <th width="15%">Cheque CDC</th>
                </tr>
            </table>
            <!-- <div class="row" align="center" >
		  				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><br>
		  				</div>
		  			</div> -->
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Cash & Bank
								Summary</h3>
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table2" align="center">
                <tr>
                    <th>&nbsp;</th>
                    <th>&nbsp;</th>
                    <th>&nbsp;</th>
                </tr>

            </table>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <br>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <br>
            </div>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">PDC Summary</h3>
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table3" align="center">
                <tr>
                    <th width="35%">&nbsp;</th>
                    <th align="right">Received</th>
                    <th align="right">Paid</th>
                </tr>

            </table>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <br>
                </div>
            </div>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Receivable</h3>
                    </div>
                </div>

            </div>
            <table class="table table-bordered  table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table4" align="center">
                <tr>
                    <th width="35%">&nbsp;</th>
                    <th>Outstanding</th>
                    <th>Advance</th>
                    <th>Overdue</th>
                </tr>

            </table>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <br>
                </div>
            </div>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Payable</h3>
                    </div>
                </div>
            </div>
            <table class="table table-bordered  table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table5" align="center">
                <tr>
                    <th width="35%">&nbsp;</th>
                    <th>Outstanding</th>
                    <th>Advance</th>
                    <th>Overdue</th>
                </tr>
            </table>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <br>
                </div>
            </div>
            <div class="row m-t-10">
                <div class="col-xs-12 col-sm-12 col-md-offset-3 col-md-6 col-lg-6">
                    <div class="panel panel-default boxshadow1 animated zoomIn">
                        <div class="panel-heading">
                            <strong>Travel Analytics - Monthwise</strong>
                        </div>
                        <div class="panel-body" style="border:none;">
                            <canvas id="chartcountmonthwise"></canvas>
                        </div>
                    </div>
                </div>
             </div>
             <div class="row m-t-10">  
                <div class="col-xs-12 col-sm-12 col-md-offset-3 col-md-6 col-lg-6">
                    <div class="panel panel-default boxshadow1 animated zoomIn">
                        <div class="panel-heading">
                            <strong>Invoice Analytics - Monthwise</strong>
                        </div>
                        <div class="panel-body" style="border:none;">
                            <canvas id="chartvaluemonthwise"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row m-t-10">
                <div class="col-xs-12 col-sm-12 col-md-offset-3 col-md-6 col-lg-6">
                    <div class="panel panel-default boxshadow1 animated zoomIn">
                        <div class="panel-heading">
                            <strong>Tour Bookings - Location</strong>
                        </div>
                        <div class="panel-body" style="border:none;">
                            <canvas id="charttourmonthwise"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading3 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Notes for management</h3>
                    </div>
                </div>
            </div>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Tours - pending</h3>
                    </div>
                </div>
            </div>

            <table class="table table-bordered table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table6" align="center">
                <tr class="primary">
                    <th width="30%">&nbsp;</th>
                    <th width="10%">Purchase Count</th>
                    <th width="10%">Purchase Value</th>
                    <th width="10%">Invoice Count</th>
                    <th width="10%">Invoice Value</th>
                </tr>
            </table>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Ticket voucher - pending</h3>
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table7" align="center">
                <tr class="primary">
                    <th width="30%">&nbsp;</th>
                    <th width="10%">Purchase Count</th>
                    <th width="10%">Purchase Value</th>
                    <th width="10%">Invoice Count</th>
                    <th width="10%">Invoice Value</th>
                </tr>
            </table>
            <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Voucher - pending</h3>
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table8" align="center">
                <tr class="primary">
                    <th width="30%">&nbsp;</th>
                    <th width="10%">Purchase Count</th>
                    <th width="10%">Purchase Value</th>
                    <th width="10%">Invoice Count</th>
                    <th width="10%">Invoice Value</th>
                </tr>
            </table>
          <div id="hidestock">  
           <div class="row" align="center">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="heading2 animated slideInUp">
                        <h3 style="font-family: Times New Roman;">Tours Stock</h3>
                    </div>
                </div>
            </div> 
            <table class="table table-bordered table-responsive" style="font-family: Times New Roman; margin-bottom: 13px;" width="80%" id="table9" align="center">
                <tr class="primary">
                    <th width="30%">&nbsp;</th>
                    <th width="10%"></th>
                    <th width="10%"></th>
                </tr>
            </table>
         </div>
        </div>
    </div>
    <input type="hidden" id="hidbrandgarage" name="hidbrandgarage" value='<s:property value="hidbrandgarage"/>' />
</body>

</html>