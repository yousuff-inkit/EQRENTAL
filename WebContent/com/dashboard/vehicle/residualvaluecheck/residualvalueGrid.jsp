<%@page import="com.dashboard.vehicle.residualvaluecheck.*" %>
<% ClsResidualValueDAO defleetdao=new ClsResidualValueDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
%>
<style type="text/css">
    .orangeClass
    {
        background-color: #FDEBD0;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greenClass
    {
        background-color: #D1F2EB;
    }
     .greyClass
    {
        background-color: #EAEDED;
    }         
       .blueClass
    {
        background-color: #E8DAEF;
    }   
    
          .redClass
    {
        background-color: #ffcccc;
    }   
    
    
    
            
</style>
<script type="text/javascript">
var id='<%=id%>';
var defleetdata;
if(id=="1"){
	defleetdata='<%=defleetdao.getDeFleetData(id,fromdate,todate,branch,fleetno)%>'; 
	defleetexceldata='<%=defleetdao.getDeFleetExcelData(id,fromdate,todate,branch,fleetno)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'fleet_no', type: 'number'},
						{name : 'flname',type:'string'},
						{name : 'regno', type: 'number'},
						{name : 'purval',type:'string'},
						{name : 'resval', type: 'number'},
						{name : 'lano',type:'number'},
						{name : 'client',type:'string'},
						{name : 'outdate',type:'date'},
						{name : 'date',type:'date'},
						{name : 'enddate',type:'date'},
						{name : 'leaseapp',type:'number'},
						{name : 'leaseappres',type:'number'},
						{name : 'leaseappno',type:'String'},
						

						],
				    localdata: defleetdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#deFleetListGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#deFleetListGrid").jqxGrid(
    {
        width: '99%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columnsresize:true,
       sortable:true,
        columns: [  
					 { text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					 }   },	
					 { text: 'FleetNo',datafield:'fleet_no',width:'4%'},
                  	 { text: 'Fleet Name', datafield: 'flname', width: '15%'},
				     { text: 'Reg No', datafield:'regno', width: '4%'},
				    { text: 'LA NO',datafield:'lano',width:'7%'},
				     { text: 'Client',datafield:'client',width:'9%'},
				     { text: 'LA Out Date',datafield:'outdate',width:'7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'LA Start Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'LA End Date',datafield:'enddate',width:'7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Purch Value',datafield:'purval',cellsformat: 'd2',cellsalign:'right',align:'right',width:'6%'},
				     { text: 'Residual Value',datafield:'resval',cellsformat: 'd2',cellsalign:'right',align:'right',width:'7%'},
				     
				     { text: 'Applicat. No',datafield:'leaseappno',width:'7%'},
				     { text: 'Applicat. Purch Value',datafield:'leaseapp',cellsformat: "d2",cellsalign:'right',align:'right',width:'8%'},
				     { text: 'Applicat. Residual Value',datafield:'leaseappres',cellsformat: 'd2',cellsalign:'right',align:'right',width:'8%'}
					]
   
    });

   $('#deFleetListGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	$('#purcost').val($('#deFleetListGrid').jqxGrid('getcellvalue',rowindex,'purval'));
    	$('#resval').val($('#deFleetListGrid').jqxGrid('getcellvalue',rowindex,'resval'));
    	$('#fleetno').val($('#deFleetListGrid').jqxGrid('getcellvalue',rowindex,'fleet_no'));
    	funupadtecheck()
    });  
});
    
</script>
<div id="deFleetListGrid"></div>
