<%@page import="com.limousine.jobassignmentmultiplebus.*" %>
<%ClsJobAssignMultipleBusDAO limodao=new ClsJobAssignMultipleBusDAO();
String brandid=request.getParameter("brandid")==null?"":request.getParameter("brandid");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var  data='<%=request.getParameter("datafield")==null?"":request.getParameter("datafield")%>';
var gridname='<%=request.getParameter("gridname")==null?"":request.getParameter("gridname")%>';
var gridrowindex='<%=request.getParameter("gridrowindex")==null?"":request.getParameter("gridrowindex")%>';
var id='<%=request.getParameter("id")==null?"":request.getParameter("id")%>';
var modeldata=[];
if(id=="1"){
	modeldata='<%=limodao.getModelData(brandid,id)%>';	
}
        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'model', type: 'string'},
     						{name : 'doc_no', type: 'int'}
     											
                 ],               
               localdata:modeldata,
                
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

            
            
            $("#modelSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                showfilterrow: true,
                filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                  /*   var cell = $('#invAcSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invAcSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                },
                
  
                
                columns: [
                           	{ text:'Doc No',datafield:'doc_no',width:'20%'},	
							{ text: 'Model', datafield: 'model', width: '80%' }
												
	              		]
            });
       $('#modelSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	
                	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "model", $('#modelSearch').jqxGrid('getcellvalue', rowindex, "model"));
                	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "modelid", $('#modelSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));	
            	
                $('#modelwindow').jqxWindow('close');
                });
            
        });
    </script>
    <div id="modelSearch"></div>