<%@page import="com.limousine.limovendortarifmgmt.*" %>
<%ClsLimoVendorTarifDAO tarifdao=new ClsLimoVendorTarifDAO(); %>
 <script type="text/javascript">
var  data='<%=request.getParameter("datafield")==null?"":request.getParameter("datafield")%>';
 var acdata= '<%=tarifdao.getLocations()%>';
        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'location', type: 'string'},
     						{name : 'doc_no', type: 'int'}
     											
                 ],               
               localdata:acdata,
                
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

            
            
            $("#locationSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
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
							{ text: 'Location', datafield: 'location', width: '80%' }
												
	              		]
            });
       $('#locationSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	var transferrowindex=document.getElementById("transferrowindex").value;
            	if(data=="pickuploc"){
            		$("#gridTarifTransfer").jqxGrid('setcellvalue', transferrowindex, "pickuploc", $('#locationSearch').jqxGrid('getcellvalue', rowindex, "location"));
                    $("#gridTarifTransfer").jqxGrid('setcellvalue', transferrowindex, "pickuplocid", $('#locationSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));	
                    $("#gridTarifTransfer").jqxGrid("addrow", null, {});
            	}
            	else if(data=="dropoffloc"){
            		$("#gridTarifTransfer").jqxGrid('setcellvalue', transferrowindex, "dropoffloc", $('#locationSearch').jqxGrid('getcellvalue', rowindex, "location"));
                    $("#gridTarifTransfer").jqxGrid('setcellvalue', transferrowindex, "dropofflocid", $('#locationSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));	
            	}
                
            	
                $('#locationwindow').jqxWindow('close');
                });
            
        });
    </script>
    <div id="locationSearch"></div>
 
