<%@page import="com.dashboard.analysis.vehicledetailanalysis.*" %>
<%ClsVehicleDetailAnalysisDAO floordao=new ClsVehicleDetailAnalysisDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var id='<%=id%>';
var incomedata=[];
if(id=="1"){
	incomedata='<%=floordao.getIncomeData(id,fleetno,fromdate,todate)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'date' , type: 'date'},
                      	{name : 'account',type:'string'},
 						{name : 'acname', type: 'string'},
 						{name : 'amount', type: 'number'}
                      	
             ],
             localdata: incomedata,
            
            
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



        $("#incomeGrid").jqxGrid(
                {
                	width: '100%',
                    height: 250,
                    source: dataAdapter,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Date',datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Ac No',datafield: 'account', width: '10%'},
    					{ text: 'Ac Name',datafield: 'acname'},
    					{ text: 'Amount',datafield: 'amount',width:'10%',cellsformat:'d2',cellsalign:'right',align:'right'}
    	              ]
                });

				$('#incomeGrid').on('rowdoubleclick', function (event) 
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
<div id="incomeGrid"></div>