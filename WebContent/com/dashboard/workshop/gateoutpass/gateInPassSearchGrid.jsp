<%@page import="com.dashboard.workshop.gateoutpass.*" %>
<%ClsGateOutPassDAO servicedao=new ClsGateOutPassDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var gateinpasssearchdata;
if(id=='1'){
	gateinpasssearchdata='<%=servicedao.getGateInPassSearchData(id,fromdate,todate,branch)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	gateinpasssearchdata=[];
/* gateexceldata=[]; */
}
 
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'fleet_no',type:'number'},
                  		{name : 'reg_no',type:'number'},
                  		{name : 'drivername',type:'string'},
						{name : 'branchname',type:'string'}				
                  		],
				    localdata: gateinpasssearchdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#gateInPassSearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#gateInPassSearchGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Branch',datafield:'branchname',width:'15%'},
       				{ text: 'Doc No',datafield:'doc_no',width:'10%'},
       				{ text: 'Date',datafield:'date',width:'10%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'10%'},
       				{ text: 'Asset id',datafield:'reg_no',width:'10%'},
       				{ text: 'Driver',datafield:'drivername',width:'40%'}

					]
    });
    $('#gateInPassSearchGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  			var rowindex1=event.args.rowindex;
      			$('#gateinpassdocno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',rowindex1,'doc_no'));
      			$('#gatewindow').jqxWindow('close');
      		});	 
     
    });

	
	
</script>
<div id="gateInPassSearchGrid"></div>