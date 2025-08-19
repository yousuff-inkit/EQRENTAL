<%@page import="com.equipment.equippurchasedirect.ClsEquipPurchaseDirectDAO" %>
<%ClsEquipPurchaseDirectDAO vpd=new ClsEquipPurchaseDirectDAO(); %>

 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String masterdate = request.getParameter("masterdate")==null?"0":request.getParameter("masterdate");
 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

<script type="text/javascript">
 var tax;       
        

   var data2= '<%=vpd.accountsDetailsFrom(masterdate,accountno,accountname,currency,check) %>'; 

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'curid', type: 'int'  },
     						{name : 'currency', type: 'string'  },
     						{name : 'rate', type: 'number'  },
     						{name : 'tax', type: 'String'  },
     						{name : 'actype', type: 'String'  }
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsSearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '55%' },
							{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%'},
							{ text: 'Currency', datafield: 'currency', width: '15%' },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%'  },
							{ text: 'tax', hidden: false, datafield: 'tax', width: '0%'},
							{ text: 'actype', hidden: false, datafield: 'actype', width: '0%'},
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("headacccode").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("accid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("vehpuraccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
        	    document.getElementById("errormsg").innerText="";
        		document.getElementById("epocmbcurr").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid");
            	funRoundRate($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"epocurrate");
        	   
            	if(($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "tax")=="0") || 
       	    		($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "actype")=="3")){
        	    				$('#txttaxpercentage').val("0");
        	    }
        	    else{
        	    	tax();
        	    }
                
            /* 	document.getElementById("vendorcurr").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	funRoundRate($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"vendorrate"); */
            	

              $('#accountSearchwindow').jqxWindow('close');  
              
            });
           
        });
        
    </script>
    <div id="jqxAccountsSearch"></div>
 