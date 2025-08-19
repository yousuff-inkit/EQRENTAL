<%@ page import="com.dashboard.android.checkinout.CheckInOutDAO" %>
<% CheckInOutDAO ciod=new CheckInOutDAO(); %>
       <script type="text/javascript">
  
	    var data='<%=ciod.regnoSearch()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'reg_no', type: 'string'  },
                            {name : 'fleet_no', type: 'string'  },
                            {name : 'pltid', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#regnosearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Reg No', datafield: 'reg_no', width: '35%'},
                              { text: 'Fleet', datafield: 'fleet_no', width: '35%' },
                              { text: 'Plate Code', datafield: 'pltid', width: '30%' },
						]
            });
            
          $('#regnosearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtregno").value=$('#regnosearch').jqxGrid('getcellvalue', rowindex2, "reg_no");
                 
               $('#regnoDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="regnosearch"></div>