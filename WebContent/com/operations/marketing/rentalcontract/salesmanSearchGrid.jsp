
<%@page import="com.operations.marketing.rentalcontract.*" %>
<%
String id= request.getParameter("id")==null?"0":request.getParameter("id").trim();
ClsRentalContractDAO viewDAO= new ClsRentalContractDAO();
%>
<script type="text/javascript">
    
 var saldata=[];
 var id='<%=id%>';
 if(id=="1"){
 	saldata='<%=viewDAO.getSalesmanData(id)%>';	
 }
  
       // alert(data);
        $(document).ready(function () { 	
        	
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
                            {name : 'doc_no', type: 'string'  },
     						{name : 'salesman', type: 'string'    },
     						{name : 'mobile', type: 'string'    },
     						{name : 'mail', type: 'string'    }
     					     						
                 ],               
                localdata: saldata,
             
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#salesmanSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
          
                altRows: true,
                showfilterrow: true,
                filterable: true,
               // sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
            /*     handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxgrid2').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'NAME' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxgrid2").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                 */
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                           
                          
               		
                          
                          
							{ text: 'Doc no', datafield: 'doc_no', width: '10%' },
							{ text: 'Name', datafield: 'salesman', width: '60%' },
							{ text: 'Mobile', datafield: 'mobile', width: '15%' },
							{ text: 'Mail', datafield: 'mail', width: '15%'}
						
	              ]
            });
            $('#salesmanSearchGrid').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex=event.args.rowindex;
				$('#salesman').val($('#salesmanSearchGrid').jqxGrid('getcellvalue',rowindex,'salesman'));
				$('#hidsalesman').val($('#salesmanSearchGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
				$('#salwindow').jqxWindow('close');
            });
          
       	  
         
        });
    </script>
    <div id="salesmanSearchGrid"></div>
