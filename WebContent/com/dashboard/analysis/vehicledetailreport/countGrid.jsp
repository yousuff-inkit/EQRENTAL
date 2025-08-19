 <%@page import="com.dashboard.analysis.vehicledetailreport.*"%>
 <%ClsVehicleDetailReportDAO reportdao=new ClsVehicleDetailReportDAO();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%> 
<script type="text/javascript">
var countdata;
var id='<%=id%>';
var branch='<%=branch%>';
var fromdate='<%=fromdate%>';
var todate='<%=todate%>';
if(id=="1"){
	countdata='<%=reportdao.getVehicleCountData(branch,fromdate,todate,id)%>';
}
else{
	countdata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'desc1', type: 'string'  },
					{name : 'value', type: 'string'  },
					{name : 'status', type:'string'}
					
						
						],
				    localdata: countdata,
        
        
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
    
    
    $("#countGrid").jqxGrid(
    {
        width: '100%',
        height: 170,
        source: dataAdapter,
        rowsheight:20,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Description', datafield: 'desc1', width: '50%' },
						{ text: 'Value', datafield: 'value', width: '50%'},
						{ text: 'Status',datafield:'status',width:'10%',hidden:true}
						
					
					]
    
    });

    $('#countGrid').on('rowdoubleclick', function (event) 
    		{ 
    	$("#overlay, #PleaseWait").hide();
    	var rowindex=event.args.rowindex;
    	$('#masterdiv').load('masterGrid.jsp?status='+$('#countGrid').jqxGrid('getcellvalue',rowindex,'status')+'&id=1&fromdate='+fromdate+'&todate='+todate+'&branch='+branch);
    });
});

	
	
</script>
<div id="countGrid"></div>