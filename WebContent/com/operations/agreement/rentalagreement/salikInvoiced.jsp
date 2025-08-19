<%
	String docno= request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
	String id= request.getParameter("id")==null?"0":request.getParameter("id").trim();
	ClsRentalAgreementDAO viewDAO= new ClsRentalAgreementDAO();
%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>

<script type="text/javascript">
        
        $(document).ready(function () { 	
        	var salikinvdata = '<%=viewDAO.getInvoicedSalik(docno,id)%>';
            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'inv_no' , type: 'string' },
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'trans', type: 'string'    },
     						{name : 'salik_date', type: 'date'    },
     						{name : 'salik_time', type: 'string'    },
     						{name : 'amount', type: 'number'    }
     						
                 ],
                 localdata: salikinvdata,
                
                
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

            
            
            $("#salikInvoicedGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
            
                columns: [
                			{ text: '<fmt:message key="global.srno"/>',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
						    		return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}   
							},
							{ text: '<fmt:message key="global.invno"/>', datafield: 'inv_no', width: '7%' },
							{ text: '<fmt:message key="global.regno"/>', datafield: 'regno', width: '11%' },
							{ text: '<fmt:message key="global.fleetno"/>', datafield: 'fleetno', width: '9%' },
							{ text: '<fmt:message key="global.finesource"/>', datafield: 'source', width: '22%' },
							{ text: '<fmt:message key="global.transactionno"/>', datafield: 'trans', width: '15%' },
							{ text: '<fmt:message key="global.date"/>', datafield: 'salik_date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: '<fmt:message key="global.time"/>', datafield: 'salik_time', width: '7%' },
							{ text: '<fmt:message key="global.amount"/>', datafield: 'amount', width: '15%',cellsformat:'d2' ,cellsalign:'right',align:'right'},
														
	              ]
            });
        });
    </script>
    <div id="salikInvoicedGrid"></div>