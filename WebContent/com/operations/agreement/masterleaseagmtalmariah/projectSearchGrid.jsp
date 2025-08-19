<%@ page import="com.operations.agreement.masterleaseagmtalmariah.*" %>
<%ClsMasterLeaseAgmtAlmariahDAO masterdao=new ClsMasterLeaseAgmtAlmariahDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';

var projectdata;

if(id=="1"){
	projectdata='<%=masterdao.getProjectData(id)%>';
}
	$(document).ready(function () { 
		
    	var source = 
       	{
        	datatype: "json",
           	datafields: [
 						
				{name : 'doc_no', type: 'number'  },
				{name : 'date',type:'date'},
				{name : 'project', type: 'String'  },
          ],
          localdata: projectdata,
           
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
            
            $("#projectSearchGrid").jqxGrid(
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
					{ text: 'Project', datafield: 'project', width: '80%' }
				]
            });
            
            $("#projectSearchGrid").on("rowdoubleclick", function (event)
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
            		    
            		    $('#projectno').val($('#projectSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'project'));
            		    $('#hidprojectno').val($('#projectSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no'));
            			$('#searchwindow').jqxWindow('close');
            		});
    
});
</script>
<div id="projectSearchGrid"></div>
