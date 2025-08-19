 <%@page import="com.dashboard.travel.hotelvouchercreate.ClsHotelVoucherCreateDAO"%>
 <%  ClsHotelVoucherCreateDAO DAO=new ClsHotelVoucherCreateDAO(); %>
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchAccount() %>';      
		$(document).ready(function () { 	     
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'acno', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },   
                             {name : 'account', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: vdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxaccountSearch").jqxGrid(   
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columns: [
                           { text: 'Account', datafield: 'acno', width: '20%' },
                           { text: 'Account Name', datafield: 'account', width: '80%' },               
                           { text: 'doc_no', datafield: 'doc_no', width: '7%',hidden:true },
						] 
            });
            $('#jqxaccountSearch').on('rowdoubleclick', function (event) {               
                var rowindex2 = event.args.rowindex;  
                document.getElementById("payacno").value=$('#jqxaccountSearch').jqxGrid('getcellvalue', rowindex2, "acno");
                document.getElementById("paybackacc").value=$('#jqxaccountSearch').jqxGrid('getcellvalue', rowindex2, "account");
				document.getElementById("acc_docno").value=$('#jqxaccountSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
              	$('#accountsearchwndow').jqxWindow('close');      
            });    
        });
    </script>
    <div id="jqxaccountSearch"></div>