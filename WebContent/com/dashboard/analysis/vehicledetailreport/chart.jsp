<!DOCTYPE HTML>
<html lang="en">
<head>
    <title id='Description'>JavaScript Chart with horizontal layout, range and color bands</title>
    <meta name="description" content="This is an example of JavaScript Chart Horizontal Layout, Range Columns and Color Bands." />
    <link rel="stylesheet" href="../../jqwidgets/styles/jqx.base.css" type="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
    <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
    <script type="text/javascript">
        $(document).ready(function () {
            // prepare chart data as an array            
            var source =
            {
                datatype: "csv",
                datafields: [
                    { name: 'Country' },
                    { name: 'GDP' },
                    { name: 'DebtPercent' },
                    { name: 'Debt' }
                ],
                url: '../sampledata/gdp_dept_2010.txt'
            };
            var dataAdapter = new $.jqx.dataAdapter(source, { async: false, autoBind: true, loadError: function (xhr, status, error) { alert('Error loading "' + source.url + '" : ' + error); } });
            // prepare jqxChart settings
            var settings = {
                title: "Economic comparison",
                description: "GDP and Debt in 2010",
                showLegend: true,
                enableAnimations: true,
                padding: { left: 5, top: 5, right: 5, bottom: 5 },
                titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
                source: dataAdapter,
                xAxis:
                    {
                        dataField: 'Country',
                        gridLines: { visible: true },
                        valuesOnTicks: false
                    },
                colorScheme: 'scheme01',
                columnSeriesOverlap: false,
                seriesGroups:
                    [
                        {
                            type: 'column',
                            valueAxis:
                            {
                                visible: true,
                                unitInterval: 5000,
                                title: { text: 'GDP & Debt per Capita($)<br>' }
                            },
                            series: [
                                    { dataField: 'GDP', displayText: 'GDP per Capita' },
                                    { dataField: 'Debt', displayText: 'Debt per Capita' }
                                ]
                        },
                        {
                            type: 'line',
                            valueAxis:
                            {
                                visible: true,
                                position: 'right',
                                unitInterval: 10,
                                title: { text: 'Debt (% of GDP)' },
                                gridLines: { visible: false },
                                labels: { horizontalAlignment: 'left' }
                            },
                            series: [
                                    { dataField: 'DebtPercent', displayText: 'Debt (% of GDP)' }
                                ]
                        }
                    ]
            };
            // setup the chart
            $('#chartContainer').jqxChart(settings);
        });
    </script>
</head>
<body class='default'>
	<div id='chartContainer' style="width:100%; height:500px;">
	</div>
         <div class="example-description">
        <br />
        <h2>Description</h2>
        <br />
         This is an example of JavaScript chart column series. The data of the chart is prepared as an array from a text file. The type of the series is column. The columnSeriesOverlap option is set to false.  You can see a second line series linked to the DebtPercent data field. You can also see how to enable the animation and how to set the title padding.
        </div>
</body>
</html>