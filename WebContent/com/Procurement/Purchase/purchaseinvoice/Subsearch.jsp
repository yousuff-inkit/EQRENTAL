<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>
<% ClspurchaseinvoiceDAO purchaseDAO = new ClspurchaseinvoiceDAO();  
	String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
	String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 	String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");
 	String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 	String descriptions = request.getParameter("descriptions")==null?"0":request.getParameter("descriptions");
 	String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
    String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
%>
<script type="text/javascript">


var nipurordermain= '<%=purchaseDAO.mainsearch(session,docnoss,accountss,accnamess,datess,aa,descriptions,refnoss) %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            
                            {name : 'voc_no', type: 'int'   },
                         
                            {name : 'date', type: 'date'   },
     						{name : 'netamount', type: 'number'   },
     						{name : 'type', type: 'string'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'rate', type: 'string'   },
     						{name : 'delterm', type: 'string'   },
     						{name : 'payterm', type: 'string'   },
                        	{name : 'deldate', type: 'date'   },
     						{name : 'desc1', type: 'string'   },
     						{name : 'acno', type: 'string'   },
     						{name : 'curid', type: 'string'   },
     						{name : 'nettot', type: 'string'   },
							{name : 'cldocno', type: 'string'   }


                        ],
                		localdata: nipurordermain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Account', datafield: 'account', width: '8%' },
								{ text: 'Account Name', datafield: 'description', width: '30%' },
								{ text: 'Amount', datafield: 'netamount', width: '14%',cellsformat: 'd2', cellsalign: 'right', align:'right' },
								 { text: 'type', datafield: 'type', width: '5%',hidden:true },
								 { text: 'refno', datafield: 'refno', width: '5%',hidden:true },
									{ text: 'rate', datafield: 'rate', width: '2%' ,hidden:true},
									{ text: 'delterm', datafield: 'delterm', width: '8%',hidden:true },
									 { text: 'payterm',  datafield: 'payterm', width: '5%' ,hidden:true},
										{ text: 'deldate', datafield: 'deldate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
										{ text: 'Description', datafield: 'desc1', width: '32%' },
										 { text: 'acno', datafield: 'acno', width: '2%' ,hidden:true},
										 { text: 'curid', datafield: 'curid', width: '2%',hidden:true },
											{ text: 'Nettot', datafield: 'nettot', width: '14%',cellsformat: 'd2', cellsalign: 'right', align:'right' },
										{ text: 'client', datafield: 'cldocno', width: '30%',hidden:true },


						]
            });
            
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
           	 $('#masterdate').jqxDateTimeInput({ disabled: false});
        	 $('#deliverydate').jqxDateTimeInput({ disabled: false});
        	 
        	 
        	 $('#invdate').jqxDateTimeInput({ disabled: false});
        	 
        	 
        	 
        	  $('#cmbcurr').attr('disabled', false);
        	 $('#acctype').attr('disabled', false);
        	 document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
        	         	 document.getElementById("hidcldocno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "cldocno");


              $('#window').jqxWindow('close');  
         	 $('#masterdate').jqxDateTimeInput({ disabled: false});
        	 $('#deliverydate').jqxDateTimeInput({ disabled: false});
        	 $('#invdate').jqxDateTimeInput({ disabled: false});
        	 
        	  $('#cmbcurr').attr('disabled', false);
        	 $('#acctype').attr('disabled', false);
        	 funSetlabel();
            document.getElementById("purchaseInv").submit();
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>