<%@page import="com.dashboard.analysis.vehicledetailanalysis.*" %>
<%ClsVehicleDetailAnalysisDAO floordao=new ClsVehicleDetailAnalysisDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>

<script type="text/javascript">
var id='<%=id%>';
var movdata=[];
if(id=="1"){
	movdata='<%=floordao.getMovData(id,fleetno,fromdate,todate)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'reftype' , type: 'string'},
                      	{name : 'refno',type:'string'},
 						{name : 'dateout', type: 'date'},
 						{name : 'timeout', type: 'string'},
 						{name : 'kmout', type:'number'},
 						{name : 'fuelout',type:'string'},
 						{name : 'datein', type: 'date'},
 						{name : 'timein', type: 'string'},
 						{name : 'kmin', type:'number'},
 						{name : 'fuelin',type:'string'},
                      	
             ],
             localdata: movdata,
            
            
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



        $("#movementGrid").jqxGrid(
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
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '7%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
						{ text: 'Ref Type',datafield: 'reftype', width: '8%'},
						{ text: 'Ref #',datafield: 'refno',width:'13%'},
    					{ text: 'Out Date',datafield: 'dateout', width: '10%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Out Time',datafield: 'timeout', width: '8%'},
    					{ text: 'Out Km',datafield: 'kmout', width: '8%'},
    					{ text: 'Out Fuel',datafield: 'fuelout', width: '10%'},
    					{ text: 'In Date',datafield: 'datein', width: '10%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'In Time',datafield: 'timein', width: '8%'},
    					{ text: 'In Km',datafield: 'kmin', width: '8%'},
    					{ text: 'In Fuel',datafield: 'fuelin', width: '10%'},
    	              ]
                });

				$('#movementGrid').on('rowdoubleclick', function (event) 
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
<div id="movementGrid"></div>