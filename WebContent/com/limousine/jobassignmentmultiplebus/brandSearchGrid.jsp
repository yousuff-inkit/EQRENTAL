<%@page import="com.limousine.jobassignmentmultiplebus.*" %>
<%ClsJobAssignMultipleBusDAO limodao=new ClsJobAssignMultipleBusDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
 <script type="text/javascript">
var data='<%=request.getParameter("datafield")==null?"":request.getParameter("datafield")%>';
var gridname='<%=request.getParameter("gridname")==null?"":request.getParameter("gridname")%>';
var gridrowindex='<%=request.getParameter("gridrowindex")==null?"":request.getParameter("gridrowindex")%>';
var id='<%=request.getParameter("id")==null?"":request.getParameter("id")%>';
var branddata=[];
if(id=="1"){
	branddata='<%=limodao.getBrandData(id)%>';
}

        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'brand', type: 'string'},
     						{name : 'doc_no', type: 'int'}
     											
                 ],               
               localdata:branddata,
                
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

            
            
            $("#brandSearch").jqxGrid(
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
							{ text: 'Brand', datafield: 'brand', width: '80%' }
												
	              		]
            });
       $('#brandSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	
                	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "brand", $('#brandSearch').jqxGrid('getcellvalue', rowindex, "brand"));
                	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "brandid", $('#brandSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));	
            	
                $('#brandwindow').jqxWindow('close');
                });
            
        });
    </script>
    <div id="brandSearch"></div>
 
