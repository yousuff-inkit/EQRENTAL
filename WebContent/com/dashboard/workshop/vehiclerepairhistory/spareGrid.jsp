<%@page import="com.dashboard.workshop.vehiclerepairhistory.*" %>
<% ClsVehicleRepairHistoryDAO DAO=new ClsVehicleRepairHistoryDAO(); %> 
<%
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String vehdocno=request.getParameter("docno")==null?"":request.getParameter("docno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var Data1;
var spareexceldata;

if(id=='1'){
	  Data1=<%=DAO.getSpareData(fromdate,todate,vehdocno,cldocno,id)%>;	
	  spareexceldata=<%=DAO.getSpareExcelData(fromdate,todate,vehdocno,cldocno,id)%>;
}
else{
Data1=[];
spareexceldata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'branch',type:'string'},
                  		{name : 'gatedocno',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'partno',type:'string'},
                  		{name : 'productname',type:'string'},
                  		{name : 'unit',type:'string'},
                  		{name : 'qty',type:'number'},
                  		],
				    localdata: Data1,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#vehrepairGrid").on("bindingcomplete", function (event) {
    	$("#overlays, #PleaseWaits").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#vehrepairGrid").jqxGrid(
    {
        width: '98%',
        height: 230,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow:true,
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: true, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Branch',datafield:'branch',width:'10%'},
       				{ text: 'Doc No',datafield:'gatedocno',width:'10%'},
       				{ text: 'Date',datafield:'date',width:'10%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Part No',datafield:'partno',width:'15%'},
       				{ text: 'Product Name', datafield:'productname',width:'30%'},
       				{ text: 'Unit', datafield:'unit',width:'10%'},
       				{ text: 'Quantity', datafield:'qty',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2'},
					]
    });

});
	
</script>
<div id="vehrepairGrid"></div>