<%@ page import="com.dashboard.android.veh_booking.ClsVehicleBookDAO" %>
<% ClsVehicleBookDAO cvbd=new ClsVehicleBookDAO(); %>

<%
 	/* String docno=request.getParameter("doc");
 	System.out.println("ddd"+docno); */
 %>

       <script type="text/javascript">
  
			 var vehname='<%=cvbd.vehdetails()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            //{name : 'doc_no', type: 'string'  },
                            {name : 'fleetname', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: vehname,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#vehiclesearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                             // { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Vehicle Name', datafield: 'fleetname', width: '100%' },
                           
						
						
	             
						]
            });
            
          $('#vehiclesearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                /* var sdoc=$('#vehiclesearch').jqxGrid('getcellvalue', rowindex2, "doc"); */
               // alert(sdoc);
               // document.getElementById("sdocno").value=$('#vehiclesearch').jqxGrid('getcellvalue', rowindex2, "doc");
                document.getElementById("name").value=$('#vehiclesearch').jqxGrid('getcellvalue', rowindex2, "fleetname");
  
                
                
              $('#vehiclewindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="vehiclesearch"></div>