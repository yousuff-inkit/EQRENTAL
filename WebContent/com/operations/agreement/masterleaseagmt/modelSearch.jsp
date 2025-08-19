<%@ page import="com.operations.agreement.masterleaseagmt.ClsMasterLeaseAgmtDAO" %>
<%ClsMasterLeaseAgmtDAO masterdao=new ClsMasterLeaseAgmtDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
%>
<script type="text/javascript">
var id='<%=id%>';

var modeldata;

if(id=="1"){
	modeldata='<%=masterdao.getModelData(id,brandid)%>';
}
	$(document).ready(function () { 
		
    	var source = 
       	{
        	datatype: "json",
           	datafields: [
 						
				{name : 'doc_no', type: 'number'  },
				{name : 'date',type:'date'},
				{name : 'brand', type: 'String'  },
				{name : 'model',type:'string'}
          ],
          localdata: modeldata,
           
           pager: function (pagenum, pagesize, oldpagenum) {
              
           }
       };
            
      var dataAdapter = new $.jqx.dataAdapter(source,
		{
        	loadError: function (xhr, status, error) {
            	alert(error);    
            }
        }		
      );
            
            $("#modelSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Brand', datafield: 'brand', width: '30%' },
					{ text: 'Model', datafield: 'model', width: '50%' }
				]
            });
            
            $("#modelSearchGrid").on("rowdoubleclick", function (event)
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
            		    
            		    $('#masterLeaseGrid').jqxGrid('setcellvalue', $('#gridrowindex').val(), 'model', $('#modelSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'model'));
            		    $('#masterLeaseGrid').jqxGrid('setcellvalue', $('#gridrowindex').val(), 'modelid', $('#modelSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no'));
            			$('#searchwindow').jqxWindow('close');
            		});
    
});
</script>
<div id="modelSearchGrid"></div>
