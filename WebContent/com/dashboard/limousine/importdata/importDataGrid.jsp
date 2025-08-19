<%@page import="com.dashboard.limousine.importdata.*" %>
<%ClsLimoImportDataDAO importdao=new ClsLimoImportDataDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String type=request.getParameter("type")==null?"":request.getParameter("type");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
var id='<%=id%>';
var importeddata=[];
if(id=="1"){
	importeddata='<%=importdao.getImportedGridData(docno,id,type,cldocno,fromdate,todate,branch)%>';
}
$(document).ready(function () { 
        var source =
           {
           datatype: "json",
           datafields: [

						{name : 'pickupdate',type:'string'},
                       	{name : 'pickuptime',type:'string'},
                       	{name : 'guestdetails',type:'string'},
                       	{name : 'pickupaddress',type:'string'},
                       	{name : 'pax',type:'string'},
                       	{name : 'dropoffaddress',type:'string'},
                       	{name : 'vehdetails',type:'string'},
                       	{name : 'otherdetails',type:'string'},
                       	{name : 'rdocno',type:'string'},
                       	{name : 'srno',type:'string'},
                       	{name : 'rowno',type:'string'},
                       	{name : 'remarks',type:'string'},
                       	{name : 'refno',type:'string'},
                       	{name : 'pax',type:'string'},
     				   ],
					localdata:importeddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };

       
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#importDataGrid").jqxGrid(
            {
               width: '100%',
               height: 515,
               source: dataAdapter,
               columnsresize: true,
               editable:false,
               selectionmode: 'checkbox',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            
                 },
            
               
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Pickup date',datafield:'pickupdate',width:'7%'},
							{ text: 'Pickup time',datafield:'pickuptime',width:'6%'},
							{ text: 'Other Details',datafield:'otherdetails',width:'16%'},
							{ text: 'Vehicle Details',datafield:'vehdetails',width:'16%'},
							{ text: 'PAX',datafield:'pax',width:'6%'},
							{ text: 'Remarks',datafield:'remarks',width:'16%'},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'12%'},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'12%'},
							{ text: 'Guest Details',datafield:'guestdetails',width:'20%'},
							{ text: 'Ref No',datafield:'refno',width:'10%'},
							{ text: 'Doc No',datafield:'rdocno',width:'5%'},
							{ text: 'Row No',datafield:'rowno',width:'5%',hidden:true},
							{ text: 'Sr No',datafield:'srno',width:'5%',hidden:true},
         	              ]
           
            });
            
            $("#importDataGrid").on("celldoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = args.visibleindex;
            		    // right click.
            		    var rightClick = args.rightclick; 
            		    // original event.
            		    var ev = args.originalEvent;
            		    // column index.
            		    var columnIndex = args.columnindex;
            		    // column data field.
            		    var dataField = args.datafield;
            		    // cell value
            		    var value = args.value;
            		    
            		    $('#docno').val($("#importDataGrid").jqxGrid('getcellvalue',rowBoundIndex,'rdocno'));
            		    //if(dataField=="pickuplocation" || dataField=="dropofflocation"){
            		    //	$('#locationwindow').jqxWindow('open');
		  				//	$('#locationwindow').jqxWindow('focus');
		 				//	locationSearchContent('locationSearchGrid.jsp?id=1&rowindex='+rowBoundIndex+'&datafield='+dataField);
            		    //}
            		
            		});
            		
            $('#importDataGrid').on('rowselect', function (event) 
			{
		    	// event arguments.
		    	var args = event.args;
		    	// row's bound index.
		   		var rowBoundIndex = args.rowindex;
		    	// row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
		    	var rowData = args.row;
				var selectedrow=$('#selectedrow').val();
				if(selectedrow==''){
					selectedrow=$('#importDataGrid').jqxGrid('getcellvalue',rowBoundIndex,'rdocno');
					$('#selectedrow').val(selectedrow);
				}
				else{
					if(selectedrow!=$('#importDataGrid').jqxGrid('getcellvalue',rowBoundIndex,'rdocno')){
						$.messager.alert('Warning','Please make selected jobs are of same booking');
						$('#importDataGrid').jqxGrid('unselectrow', rowBoundIndex);
						return false;
					}
				}
				
			});
			$('#importDataGrid').on('rowunselect', function (event) 
			{
		    	// event arguments.
		    	var args = event.args;
		    	// row's bound index.
		   		var rowBoundIndex = args.rowindex;
		    	// row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
		    	var rowData = args.row;
				var selectedrows=$('#importDataGrid').jqxGrid('getselectedrowindexes');
				if(selectedrows.length==0){
					$('#selectedrow').val('');
				}
			});
			
            });
</script>
<div id="importDataGrid"></div>
<input type="hidden" name="selectedrow" id="selectedrow">