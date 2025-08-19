 <%@page import="com.dashboard.analysis.vehicledetailreport.*"%>
 <%ClsVehicleDetailReportDAO reportdao=new ClsVehicleDetailReportDAO();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String monthdate=request.getParameter("monthdate")==null?"":request.getParameter("monthdate");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String status=request.getParameter("status")==null?"":request.getParameter("status");
%> 
<script type="text/javascript">
var detaildata;
var fromdate='<%=fromdate%>';
var todate='<%=todate%>';
var id='<%=id%>';
if(id=="1"){
	detaildata='<%=reportdao.getVehicleDetailData(branch,fromdate,todate,id,status,monthdate)%>';
}
else{
	detaildata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'fleet_no', type: 'number'  },
					{name : 'reg_no', type: 'number'  },
					{name : 'flname', type:'number'},
					{name : 'purchasedate',type:'date'},
					{name : 'saledate',type:'date'},
					{name : 'chassisno',type:'string'},
					{name : 'fsdate',type:'date'}
						
						],
				    localdata: detaildata,
        
        
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
    
    
    $("#detailGrid").jqxGrid(
    {
        width: '100%',
        height: 250,
        source: dataAdapter,
        //rowsheight:20,
       // showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlecell',
        pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,datafield: '',
					    columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
					    cellsrenderer: function (row, column, value) {
					    	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					  	}
					},
					{ text: 'Fleet No', datafield: 'fleet_no', width: '8%' },
					{ text: 'Fleet Name', datafield: 'flname', width: '41%' },
					{ text: 'Reg No', datafield: 'reg_no', width: '8%'},
					{ text: 'Purchase Date', datafield: 'purchasedate', width: '8%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Sold Date', datafield: 'saledate', width: '8%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Sale Status Date', datafield: 'fsdate', width: '8%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Chassis No', datafield: 'chassisno', width: '15%'}
						
					
					]
    
    });

    $('#detailGrid').on('celldoubleclick', function (event) 
    		{ 
    	$("#overlay, #PleaseWait").hide();
    	var rowindex=event.args.rowindex;
    	var datafield=event.args.datafield;
    	
    });
});

	
	
</script>
<div id="detailGrid"></div>