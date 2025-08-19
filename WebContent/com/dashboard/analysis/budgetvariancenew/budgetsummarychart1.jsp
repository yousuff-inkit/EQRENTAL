<%@page import="com.dashboard.analysis.budgetvariancenew.ClsBudgetVarianceDAO"%>
<% ClsBudgetVarianceDAO DAO= new ClsBudgetVarianceDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();%> 
<script type="text/javascript">
   
var temp='<%=branchval%>';
var data2;
if(temp!='NA'){
	   data2='<%=DAO.budgetVarianceSumGridLoading(branchval, fromDate, toDate, type, accdocno)%>';
   }    
	else{         
		data2;   
	}
    $(document).ready(function () {
            // prepare chart data as an array            
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'months'},
							{name : 'actincome'},
     						{name : 'inc'},
     						{name : 'varincome' },
     						{name : 'exp'},
     						{name : 'actexpense'},
     						{name : 'varexp' },
     						{name : 'bporfit'},
     						{name : 'profit'},
     						{name : 'vprofit'}
                ],
                localdata: data2,
            };
            var dataAdapter = new $.jqx.dataAdapter(source, { async: false, autoBind: true, loadError: function (xhr, status, error) { alert('Error loading "' + source.url + '" : ' + error); } });
            // prepare jqxChart settings
            var settings = {
            	title: "Budget Variance Summary",
                showLegend: true,
                enableAnimations: true,
                padding: { left: 5, top: 5, right: 5, bottom: 5 },
                titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
                source: dataAdapter,
                xAxis:
                    {
                        dataField: 'months',
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
                            },
                            series: [
                                     { dataField: 'inc', displayText: 'B.inc'},
                                     { dataField: 'actincome', displayText: 'Income'},
                                     { dataField: 'varincome', displayText: 'V.Inc'},   
                                     { dataField: 'exp', displayText: 'B.Exp'},
                                     { dataField: 'actexpense', displayText: 'Expenditure'},
                                     { dataField: 'varexp', displayText: 'V.Exp'},
                                     { dataField: 'bporfit', displayText: 'B.Profit'},
                                     { dataField: 'profit', displayText: 'Profit'},
                                     { dataField: 'vprofit', displayText: 'V.Profit'}
                                ]
                        }
                    ]
            };
            // setup the chart
            $('#chartContainer').jqxChart(settings);
        });
    </script>
	<div id='chartContainer' style="width:850px; height:500px;">
	</div>