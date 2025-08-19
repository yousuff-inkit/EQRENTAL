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
var Data2;
var maintenanceexceldata;

if(id=='1'){
	  Data2='<%=DAO.getMaitenanceData(fromdate, todate, vehdocno, cldocno, id)%>';
	  maintenanceexceldata='<%=DAO.getMaitenanceExcelData(fromdate, todate, vehdocno, cldocno, id)%>';
}
else{
Data2=[];
maintenanceexceldata=[];
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
                  		{name : 'maintenances',type:'string'},
                  		{name : 'descriptions',type:'string'},
                  		{name : 'fleet_no',type:'string'},
						{name : 'reg_no',type:'string'},
						{name : 'indatetime',type:'string'},
						{name : 'outdatetime',type:'string'},
                  		{name : 'inkm',type:'number'},
                  		],
				    localdata: Data2,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#maintenanceGrid").on("bindingcomplete", function (event) {
    	$("#overlaym, #PleaseWaitm").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#maintenanceGrid").jqxGrid(
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
       				{ text: 'Doc No',datafield:'gatedocno',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'5%'},
					{ text: 'Asset id',datafield:'reg_no',width:'5%'},
       				{ text: 'In KM',datafield:'inkm',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'IN (Date/Time)',datafield:'indatetime',width:'10%'},
       				{ text: 'OUT (Date/Time)',datafield:'outdatetime',width:'10%'},
       				{ text: 'Maintenance',datafield:'maintenances'},
       				{ text: 'Description', datafield:'descriptions'}, 
					]
    });

});
	
</script>
<div id="maintenanceGrid"></div>