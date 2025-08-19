<%@page import="com.dashboard.analysis.vehicleassetregister.ClsVehicleAssetRegister" %>
<%ClsVehicleAssetRegister cva=new ClsVehicleAssetRegister(); %>

<script type="text/javascript">
  
	   var fleetdata='<%=cva.fleetdetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'reg_no', type: 'string'  },
                            {name : 'fleet_no', type: 'string'  },
                            {name : 'flname', type: 'string'  }
                           ],
                            localdata: fleetdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#fleetsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
							  { text: 'Reg No', datafield: 'reg_no', width: '20%'},
                              { text: 'Fleet', datafield: 'fleet_no', width: '20%'},
                              { text: 'Name', datafield: 'flname', width: '60%' },
						]
            });
            
          $('#fleetsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtfleet").value=$('#fleetsearch').jqxGrid('getcellvalue', rowindex2, "fleet_no");
           
              $('#fleetDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="fleetsearch"></div>