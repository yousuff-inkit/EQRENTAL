<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

       <script type="text/javascript">

        var saldata='<%=crad.getRentalAgentData()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'sal_name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: saldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agentsearch").jqxGrid(
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
		                      { text: 'DOC_NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Rental Agent', datafield: 'sal_name', width: '100%' },
                           
						
						]
            });
            
          $('#agentsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("rentalagent").value=$('#agentsearch').jqxGrid('getcellvalue', rowindex2, "sal_name");
                document.getElementById("hidrentalagent").value=$('#agentsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                 
              $('#rentalagentWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="agentsearch"></div>