 <%@page import="com.dashboard.analysis.contractAnalysisPivot.ClsContractAnalysisDAO" %>   
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpSession" %>
<%
ClsContractAnalysisDAO sd=new ClsContractAnalysisDAO();
%>  
 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();
 %>
 <script type="text/javascript">
         var data;   
		 data= '<%= sd.loadGridData(session,fromdate,todate)%>';         
	     $(document).ready(function () { 
	    	 var rendererstring1=function (aggregates){  
	             	var value=aggregates['sum'];
	             	if(typeof(value) == "undefined"){
	             		value=0.00;
	             	}
	             	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
	             }
            // create a data source and data adapter
            var source =
            {
                localdata: data,  
                datatype: "json",
                datafields:
                [
					 {name : 'client', type: 'String' },
					 {name : 'vendor', type: 'String' },
					 {name : 'instype', type: 'String' },
					 {name : 'sertype',type: 'String' },
					 {name : 'salname',type: 'string' },
					 {name : 'telesales',type: 'string' },
					 {name : 'premium', type: 'number' },
					 {name : 'commvalue',type: 'number' },   
					 {name : 'marginval',type: 'number' },
					 {name : 'category',type: 'string' },
					 {name : 'year',type: 'string' },
                ]
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            dataAdapter.dataBind();
            // create a pivot data source from the dataAdapter
            var pivotDataSource = new $.jqx.pivot(
                dataAdapter,
                {
                    customAggregationFunctions: {
                        'var': function (values) {
                            if (values.length <= 1)
                                return 0;
                            // sample's mean
                            var mean = 0;
                            for (var i = 0; i < values.length; i++)
                                mean += values[i];
                            mean /= values.length;
                            // calc squared sum
                            var ssum = 0;
                            for (var i = 0; i < values.length; i++)
                                ssum += Math.pow(values[i] - mean, 2)
                            // calc the variance
                            var variance = ssum / values.length;
                            return variance;
                        }
                    },
                    pivotValuesOnRows: false,
                    fields: [
                         { dataField: 'year', text: 'Year/Month'},
                         { dataField: 'category', text: 'Client Category'},
                         { dataField: 'client', text: 'Client'},
                         { dataField: 'vendor', text: 'Vendor' },
                         { dataField: 'instype', text: 'Insurance type'},
                         { dataField: 'sertype', text: 'Service Type'},
                         { dataField: 'salname', text: 'Salesman'},
                         { dataField: 'telesales', text: 'Telesales' },
                         { dataField: 'premium', text: 'Premium' },
                         { dataField: 'commvalue', text: 'Commission' },  
                         { dataField: 'marginval', text: 'Margin' }     
                    ],
                    rows: [
							{ dataField: 'vendor', text: 'Vendor'}, //width:400   
						
                    ],
                    columns: [
                            
                              { dataField: 'sertype', text: 'Service Type' },
                          
                              ],
                    values: [
                             { dataField: 'premium', text: 'Premium','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
                             { dataField: 'marginval', text: 'Margin' ,'function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle',cellsClassNameSelected: 'myItemStyleSelected'}     
                      ]         
                });
            var localization = { 'var': 'Variance' };        
            // create a pivot grid
            $('#jqxleaddataGrid').jqxPivotGrid(
            {
                localization: localization,
                source: pivotDataSource,
                treeStyleRows: true,
                autoResize: false,   
                multipleSelectionEnabled: true,
            });
            var pivotGridInstance = $('#jqxleaddataGrid').jqxPivotGrid('getInstance');
            // create a pivot grid
            $('#divPivotGridDesigner').jqxPivotDesigner(
            {
                type: 'pivotGrid',
                target: pivotGridInstance
            });
      	  $("#overlay, #PleaseWait").hide();
        });
    </script>
       <div id="jqxleaddataGrid"></div>