<%@ page import="com.dashboard.limousine.importdata.*" %>
<%ClsLimoImportDataDAO importdao=new ClsLimoImportDataDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String rowindex=request.getParameter("rowindex")==null?"0":request.getParameter("rowindex");
String datafield=request.getParameter("datafield")==null?"0":request.getParameter("datafield");
%>
<script type="text/javascript">
	var id='<%=id%>';
	var locationdata=[];
	if(id=="1"){
		locationdata='<%=importdao.getLocations(id)%>';
	}
	$(document).ready(function () { 	
    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'  },
                            {name : 'location', type: 'string'  }
                        ],
                		
                       
                       localdata: locationdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#locationSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 338,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columns: [
							
							 
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '10%',cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  },
                              
                            { text: 'Location #', datafield: 'doc_no', width: '10%',hidden:true },
                            { text: 'Location Name', datafield: 'location', width: '90%'}
							   
						]
            });
            
          $('#locationSearchGrid').on('rowdoubleclick', function (event) {
            	
                var rowBoundIndex= event.args.rowindex;
                var gridrowindex='<%=rowindex%>';
                var griddatafield='<%=datafield%>';
                $('#importDataGrid').jqxGrid('setcellvalue',gridrowindex,griddatafield,$('#locationSearchGrid').jqxGrid('getcellvalue',rowBoundIndex, "location"));
              	$('#locationwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="locationSearchGrid"></div>
 