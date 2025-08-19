<%@page import="customerlogin.*" %>
<%ClsCustomerLoginDAO ctd=new ClsCustomerLoginDAO(); %>


<%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
 String acno = request.getParameter("acno")==null?"":request.getParameter("acno").trim();
 String rentalType = request.getParameter("rentaltype")==null?"":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"":request.getParameter("agmtno").trim();%>
 <script type="text/javascript">
 
 var trafficlistdata=[];
 var temp='<%=branchval%>';
 
 	if(temp!='NA'){ 
 		trafficlistdata='<%=ctd.invoicedGridLoading(branchval,fromDate, toDate, cldocno, rentalType, agmtNo,acno)%>';
 		
    }

        $(document).ready(function () { 	
     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [

							{name : 'rano', type: 'string'    },
							{name : 'dtypedesc', type: 'string'    },
							{name : 'desc1', type: 'string'    },
							{name : 'invno', type: 'string'    },
							{name : 'refname', type: 'string'    },
							{name : 'traffic_date', type: 'date'    },
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'ticket_no', type: 'string'    },
     						{name : 'amount', type: 'string'    }
     						
                 ],
                 localdata: trafficlistdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxInvoiced").jqxGrid(
            {
                width: '98%',
                height: 420,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
                	{ text: 'Reg No.', datafield: 'regno', width: '6%' },		
                	{ text: 'Ticket No.', datafield: 'ticket_no', width: '10%' },
					{ text: 'Traffic Date', datafield: 'traffic_date', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Location', datafield: 'location', width: '20%' },
					{ text: 'Description', datafield: 'desc1', width: '30%' },
					{ text: 'Amount', datafield: 'amount', width: '8%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
					{ text: 'RA No', datafield: 'rano', width: '10%' },
					{ text: 'Inv No', datafield: 'invno', width: '8%' },
							
							
							
							
														
	              ]
            });
            
            if(temp=='NA'){
                $("#jqxInvoiced").jqxGrid("addrow", null, {});
            }
            
            $('.page-loader button').hide();
        });
    </script>
    <div id="jqxInvoiced"></div>
