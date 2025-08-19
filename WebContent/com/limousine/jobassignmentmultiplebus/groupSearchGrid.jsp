<%@page import="com.limousine.jobassignmentmultiplebus.*" %>
<%ClsJobAssignMultipleBusDAO limodao=new ClsJobAssignMultipleBusDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
 <script type="text/javascript">
var id='<%=request.getParameter("id")==null?"":request.getParameter("id")%>';
var groupdata=[];
if(id=="1"){
	groupdata='<%=limodao.getGroupData(id)%>';
}

        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'groupname', type: 'string'},
     						{name : 'doc_no', type: 'int'}
     											
                 ],               
               localdata:groupdata,
                
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

            
            
            $("#groupSearch").jqxGrid(
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
                           	{ text:'Doc No',datafield:'doc_no',width:'20%'},	
							{ text: 'Group', datafield: 'groupname', width: '80%' }
												
	              		]
            });
       		$('#groupSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	$('#group').val($('#groupSearch').jqxGrid('getcellvalue', rowindex, "groupname"));
            	$('#hidgroup').val($('#groupSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));
            	var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
           		for(var i=0;i<selectedrows.length;i++){
           			$('#bookDetailGrid').jqxGrid('setcellvalue',selectedrows[i],'groupname',$('#group').val());
           			$('#bookDetailGrid').jqxGrid('setcellvalue',selectedrows[i],'groupid',$('#hidgroup').val());
           		}
                $('#groupwindow').jqxWindow('close');
            });
        });
    </script>
    <div id="groupSearch"></div>
 
