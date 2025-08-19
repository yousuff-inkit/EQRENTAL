<%@page import="com.limousine.jobassignmentmultiple.*" %>
<%ClsJobAssignMultipleDAO limodao=new ClsJobAssignMultipleDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
 <script type="text/javascript">
var id='<%=request.getParameter("id")==null?"":request.getParameter("id")%>';
var vendordata=[];
if(id=="1"){
	vendordata='<%=limodao.getVendorData(id)%>';
}

        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'refname', type: 'string'},
     						{name : 'cldocno', type: 'int'}
     											
                 ],               
               localdata:vendordata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
            			loadComplete: function () {
                    		 $("#loadingImage").css("display", "none"); 
                		},
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#vendorSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true,
                filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
                handlekeyboardnavigation: function (event) {
                 
                },
                
                columns: [
                           	{ text:'Doc No',datafield:'cldocno',width:'20%'},	
							{ text: 'Name', datafield: 'refname', width: '80%' }
												
	              		]
            });
       		$('#vendorSearchGrid').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	$('#vendor').val($('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex, "refname"));
            	$('#hidvendor').val($('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex, "cldocno"));
                $('#vendorwindow').jqxWindow('close');
            });
        });
    </script>
    <div id="vendorSearchGrid"></div>
 
