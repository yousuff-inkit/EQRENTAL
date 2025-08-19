<%@page import="com.dashboard.limousine.parkingfee.*" %>
<%ClsLimoParkingFeeDAO dao=new ClsLimoParkingFeeDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String location=request.getParameter("location")==null?"":request.getParameter("location");
%>
<script type="text/javascript">
var id='<%=id%>';
var data=[];
var exceldata;
if(id=="1"){
	data='<%=dao.getParkingFeeData(cldocno,location,branch,id)%>';
	exceldata='<%=dao.getParkingFeeDataExcel(cldocno,location,branch,id)%>';
}
$(document).ready(function () { 
        var source =
           {
           datatype: "json",
           datafields: [

						{name : 'cldocno',type:'number'},
                       	{name : 'refname',type:'string'},
                       	{name : 'location',type:'string'},
                       	{name : 'locationdocno',type:'number'},
                       	{name : 'amount',type:'number'},
     				   ],
					localdata:data,
                
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

            $("#parkingFeeGrid").jqxGrid(
            {
               width: '100%',
               height: 515,
               source: dataAdapter,
               columnsresize: true,
               editable:false,
               selectionmode: 'singlerow',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            
                 },
            
               
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '5%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Client #',datafield:'cldocno',width:'10%'},
							{ text: 'Client Name',datafield:'refname',width:'42%'},
							{ text: 'Airport',datafield:'location',width:'34%'},
							{ text: 'Location Doc No',datafield:'locationdocno',width:'16%',hidden:true},
							{ text: 'Amount',datafield:'amount',width:'9%',cellsalign:'right',align:'right',cellsformat:'d2'},
         	              ]
           
            });
            
            $("#parkingFeeGrid").on("rowdoubleclick", function (event)
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
            		    $('#cmbclient').val($("#parkingFeeGrid").jqxGrid('getcellvalue',rowBoundIndex,'cldocno')).trigger('change');
            		    $('#cmblocation').val($("#parkingFeeGrid").jqxGrid('getcellvalue',rowBoundIndex,'locationdocno')).trigger('change');
            		    $('#amount').val($("#parkingFeeGrid").jqxGrid('getcellvalue',rowBoundIndex,'amount'));
            		});
	
            });
</script>
<div id="parkingFeeGrid"></div>