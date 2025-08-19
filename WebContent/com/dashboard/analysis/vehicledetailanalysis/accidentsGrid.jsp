<%@page import="com.dashboard.analysis.vehicledetailanalysis.*" %>
<%ClsVehicleDetailAnalysisDAO floordao=new ClsVehicleDetailAnalysisDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>

<script type="text/javascript">
var id='<%=id%>';
var accdata=[];
if(id=="1"){
	accdata='<%=floordao.getAccData(id,fleetno,fromdate,todate)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'accdate' , type: 'date'},
                      	{name : 'prcs',type:'string'},
 						{name : 'collectdate', type: 'date'},
 						{name : 'place', type: 'string'},
 						{name : 'fine', type:'number'},
 						{name : 'claim',type:'string'}
                      	
             ],
             localdata: accdata,
            
            
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



        $("#accidentsGrid").jqxGrid(
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
    					{ text: 'Date',datafield: 'accdate', width: '10%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Police',datafield: 'prcs'},
    					{ text: 'Coll.Date',datafield: 'collectdate', width: '10%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Place',datafield: 'place', width: '13%'},
    					{ text: 'Fine',datafield: 'fine', width: '10%',cellsformat:'d2',align:'right',cellsalign:'right'},
    					{ text: 'Claim',datafield: 'claim', width: '9%'},
    	              ]
                });

				$('#accidentsGrid').on('rowdoubleclick', function (event) 
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
<div id="accidentsGrid"></div>