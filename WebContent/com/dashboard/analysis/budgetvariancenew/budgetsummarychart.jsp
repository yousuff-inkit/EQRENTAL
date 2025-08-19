<%@page import="com.dashboard.analysis.budgetvariancenew.ClsBudgetVarianceDAO"%>
<% ClsBudgetVarianceDAO DAO= new ClsBudgetVarianceDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();%> 
<script type="text/javascript">

       var data3;
	   data3='<%=DAO.budgetVarianceSumGridLoading(branchval, fromDate, toDate, type, accdocno)%>';
            
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
	                localdata: data3
	            };
	            
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	            	        async: false,
	            	        autoBind: true,
	                		loadError: function (xhr, status, error) {
		                    alert(error);    
		                    }
				            
			            } );
	            
	            // prepare jqxChart settings
	            var settings = {
	                title: "Budget Variance Summary",
	                description: "",
	                showLegend: true,
	                enableAnimations: true,
	                padding: { left: 5, top: 5, right: 5, bottom: 5 },
	                titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
	                source: dataAdapter,
	                xAxis:
	                    {
	                        dataField: 'months',
	                        //textRotationAngle: -75,
	                        gridLines: { visible: false },
	                        showGridLines: false,
	                        valuesOnTicks: false,
	                       
	                    },
	                colorScheme: 'scheme04',
	                columnSeriesOverlap: false,
	                seriesGroups:
	                    [
	                        {
	                            type: 'column',
	                            valueAxis:
	                            {
	                                visible: true,
	                                description: '',
	                                unitInterval: 50000,  
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
	            $('#readyToRent').jqxChart(settings);
	        });
         </script>
	<div id='readyToRent' style="width:100%; height:500px;">  
	</div>