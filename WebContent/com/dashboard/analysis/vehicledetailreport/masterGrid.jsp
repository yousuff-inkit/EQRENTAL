 <%@page import="com.dashboard.analysis.vehicledetailreport.*"%>
 <%ClsVehicleDetailReportDAO reportdao=new ClsVehicleDetailReportDAO();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String status=request.getParameter("status")==null?"":request.getParameter("status");
%> 
<script type="text/javascript">
var masterdata;
var masterexceldata;
var fromdate='<%=fromdate%>';
var todate='<%=todate%>';
var id='<%=id%>';
if(id=="1"){
	masterdata='<%=reportdao.getVehicleMasterData(branch,fromdate,todate,id,status)%>';
	masterexceldata='<%=reportdao.getVehicleMasterExcelData(branch,fromdate,todate,id,status)%>';
}
else{
	masterdata=[];
	masterexceldata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'monthname', type: 'string'  },
					{name : 'opening', type: 'number'  },
					{name : 'purchased', type:'number'},
					{name : 'sold',type:'number'},
					{name : 'total',type:'number'},
					{name : 'monthdate',type:'date'}
						
						],
				    localdata: masterdata,
        
        
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
    
    
    $("#masterGrid").jqxGrid(
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

						{ text: 'Month', datafield: 'monthname', width: '40%' },
						{ text: 'Opening', datafield: 'opening', width: '15%'},
						{ text: 'Purchased', datafield: 'purchased', width: '15%'},
						{ text: 'Sold', datafield: 'sold', width: '15%'},
						{ text: 'Total', datafield: 'total', width: '15%'},
						{ text: 'Month Date', datafield: 'monthdate', width: '15%',hidden:true,cellsformat:'dd.MM.yyyy'}
						
					
					]
    
    });

    $('#masterGrid').on('celldoubleclick', function (event) 
    		{ 
    	$("#overlay, #PleaseWait").hide();
    	var rowindex=event.args.rowindex;
    	var datafield=event.args.datafield;
    	if(datafield=="opening" || datafield=="purchased" || datafield=="sold" || datafield=="total"){
    		var monthdate=$('#masterGrid').jqxGrid('getcelltext',rowindex,'monthdate');
    		//alert('detailGrid.jsp?status='+datafield+'&fromdate='+fromdate+'&todate='+todate+'&monthdate='+monthdate+'&id=1');
    		$('#detaildiv').load('detailGrid.jsp?status='+datafield+'&fromdate='+fromdate+'&todate='+todate+'&monthdate='+monthdate+'&id=1');
    	}
    });
});

	
	
</script>
<div id="masterGrid"></div>