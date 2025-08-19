 <%@page import="com.dashboard.analysis.vehicletransaction.*" %>   
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpSession" %>
<%
ClsVehicleTransactionDAO sd=new ClsVehicleTransactionDAO();
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
	             	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + rate + '</div>';
	             }
            // create a data source and data adapter
            var source =
            {
                localdata: data,  
                datatype: "json",
                datafields:
                [

					{name : 'voc_no', type: 'number' },
					 {name : 'name', type: 'String' },
					 {name : 'type', type: 'String' },
					 
					 {name : 'fleetno', type: 'number' },
					 {name : 'regno',type: 'number' },
					 {name : 'brand',type: 'string' },
					 {name : 'model',type: 'string' },
					 {name : 'branchout', type: 'string' },
					 {name : 'dateout', type: 'String' },
					 {name : 'timeout',type: 'string' },   
					 {name : 'kmout',type: 'string' },
					 {name : 'fuelout',type: 'string' },
					 {name : 'branchin',type: 'number' },
					 {name : 'datein',type: 'date' },
					 {name : 'timein',type: 'number' },
					 {name : 'kmin',type: 'number' },
					 {name : 'fuelin',type: 'number' },
					 {name : 'rate',type: 'number' },
					 
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

						{ dataField: 'voc_no', text: 'Doc No'},
                         { dataField: 'name', text: 'Name'},
                         { dataField: 'type', text: 'Type'},
                         { dataField: 'fleetno', text: 'Fleet No'},
                         { dataField: 'regno', text: 'Reg No' },
                         { dataField: 'brand', text: 'brand'},
                         { dataField: 'model', text: 'model'},
                         { dataField: 'branchout', text: 'Branch out'},
                         { dataField: 'dateout', text: 'Date out'},
                         { dataField: 'timeout', text: 'Time Out' },
                         { dataField: 'kmout', text: 'KM Out' },
                         { dataField: 'fuelout', text: 'Fuel Out' },	 
                         { dataField: 'branchin', text: 'Branch In' },
                         { dataField: 'datein', text:'Date In' },
                         { dataField: 'timein', text: 'Time In' },
                         { dataField: 'kmin', text: 'KM In' },
                         { dataField: 'fuelin', text: 'Fuel In' },
                         { dataField: 'rate', text: 'Rate' },
                             
                    ],
                    rows: [
							   
							{ dataField: 'type', text: 'Type' },
							{ dataField: 'dateout', text: 'Date Out' },
                    ],
                    columns: [
                            
							/* { dataField: 'voc_no', text: 'Doc No'}, //width:400
							{ dataField: 'name', text: 'Name'},
							{ dataField: 'type', text: 'Type'},
							{ dataField: 'fleetno', text: 'Fleet No'},
							{ dataField: 'regno', text: 'Reg No'},
							{ dataField: 'brand', text: 'Brand'},
							{ dataField: 'model', text: 'Model'},
							{ dataField: 'branchout', text: 'Branch Out'},
							{ dataField: 'dateout', text: 'Date Out'},
							{ dataField: 'timeout', text: 'Time Out'},
							{ dataField: 'kmout', text: 'KM Out'},
							{ dataField: 'fuelout', text: 'Fuel Out'},
							{ dataField: 'branchin', text: 'Branch In'},
							{ dataField: 'datein', text: 'Date In'},
							{ dataField: 'kmin', text: 'KM In'},
							{ dataField: 'fuelin', text: 'Fuel In'},
							{ dataField: 'rate', text: 'Rate'},
                           */
							{ dataField: 'branchout', text: 'Branch Out'},
                              ],
                      values: [
                             
                             { dataField: 'voc_no', text: 'Val' ,'function': 'count', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle',cellsClassNameSelected: 'myItemStyleSelected'}     
                      ]         
                });
            var localization = { 'var': 'Variance' };        
            // create a pivot grid
            $('#jqxvehdataGrid').jqxPivotGrid(
            {
                localization: localization,
                source: pivotDataSource,
                treeStyleRows: true,
                autoResize: false,   
                multipleSelectionEnabled: true,
            });
            var pivotGridInstance = $('#jqxvehdataGrid').jqxPivotGrid('getInstance');
            // create a pivot grid
            $('#divPivotGridDesigners').jqxPivotDesigner(
            {
                type: 'pivotGrid',
                target: pivotGridInstance
            });
      	  $("#overlay, #PleaseWait").hide();
        });
    </script>
       <div id="jqxvehdataGrid"></div>