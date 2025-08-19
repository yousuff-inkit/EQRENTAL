<%@ page import="com.dashboard.limousine.importdata.*" %>
<%ClsLimoImportDataDAO importdao=new ClsLimoImportDataDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
	var id='<%=id%>';
	var clientdata=[];
	if(id=="1"){
		clientdata='<%=importdao.getClient(id)%>';
	}
	$(document).ready(function () { 	
    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'cldocno', type: 'number'  },
                            {name : 'refname', type: 'string'  }
                        ],
                		
                       
                       localdata: clientdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientSearchGrid").jqxGrid(
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
                              
                            { text: 'Client #', datafield: 'cldocno', width: '10%',hidden:true },
                            { text: 'Client Name', datafield: 'refname', width: '90%'}
							   
						]
            });
            
          $('#clientSearchGrid').on('rowdoubleclick', function (event) {
            	
                var rowBoundIndex= event.args.rowindex;
                document.getElementById("clientname").value= $('#clientSearchGrid').jqxGrid('getcellvalue',rowBoundIndex, "refname"); 
                document.getElementById("cldocno").value= $('#clientSearchGrid').jqxGrid('getcellvalue',rowBoundIndex, "cldocno"); 
              $('#clientwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="clientSearchGrid"></div>
 