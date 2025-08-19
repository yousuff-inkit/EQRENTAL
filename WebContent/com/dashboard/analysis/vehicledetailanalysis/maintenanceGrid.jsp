<%@page import="com.dashboard.analysis.vehicledetailanalysis.*" %>
<%ClsVehicleDetailAnalysisDAO floordao=new ClsVehicleDetailAnalysisDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>

<script type="text/javascript">
var id='<%=id%>';
var maintenancedata=[];
if(id=="1"){
	maintenancedata='<%=floordao.getMaintenanceData(id,fleetno,fromdate,todate)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'date' , type: 'date'},
                      	{name : 'type',type:'string'},
 						{name : 'garage', type: 'string'},
 						{name : 'spares', type: 'number'},
 						{name : 'labour', type:'number'},
 						{name : 'total',type:'number'},
                      	
             ],
             localdata: maintenancedata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#maintenanceGrid").jqxGrid(
                {
                	width: '100%',
                    height: 150,
                    source: dataAdapter,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '6%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Date',datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Type',datafield: 'type', width: '10%'},
    					{ text: 'Garage',datafield: 'garage'},
    					{ text: 'Spares',datafield: 'spares', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
    					{ text: 'Labour',datafield: 'labour', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
    					{ text: 'Total',datafield: 'total', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
    	              ]
                });

				$('#maintenanceGrid').on('rowdoubleclick', function (event) 
				{ 
				    var args = event.args;
				    // row's bound index.
				    var boundIndex = args.rowindex;
				    // row's visible index.
				    var visibleIndex = args.visibleindex;
				    // right click.
				    var rightclick = args.rightclick; 
				    // original event.
				    var ev = args.originalEvent;
				    
				});
	});
</script>
<div id="maintenanceGrid"></div>