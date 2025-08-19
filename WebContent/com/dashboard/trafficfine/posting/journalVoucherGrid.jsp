<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtjournalvouchersdocno2")==null?"0":request.getParameter("txtjournalvouchersdocno2"); %>

<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
            
            var temp='<%=docNo%>';
            
           <%--   if(temp>0){     
            	 data1='<%=com.finance.transactions.journalvouchers.ClsJournalVouchersDAO.journalVoucherGridReloading(session, docNo)%>';      
             } 
                       --%>          
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'docno', type: 'int' },
     						{name : 'type', type: 'string' }, 
     						{name : 'accounts', type: 'string'   },
     						{name : 'accountname1', type: 'string'  },
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   },
     						{name : 'baseamount', type: 'number' },
     						{name : 'description', type: 'string' },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'rate', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'id', type: 'int'  }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#postingJV").jqxGrid(
            {
                width: '98%',
                height: 145,
                source: dataAdapter,
                //source: dataAdapter,
                selectionmode: 'singlerow',
                //filtermode:'excel',
                //filterable: true,
                //sortable: true,
                editable:false,
                showaggregates: true,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No',  datafield: 'docno',  width: '5%' ,hidden:true}, // hidden: true,
                            { text: 'Type', datafield: 'type', width: '7%' },
							{ text: 'Account', datafield: 'accounts', editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '25%' },	
							{ text: 'Debit', datafield: 'debit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#postingJV').jqxGrid('getcellvalue', row, "credit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Credit', datafield: 'credit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#postingJV').jqxGrid('getcellvalue', row, "debit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Base Amount', datafield: 'baseamount', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '32%' },
							{ text: 'Currency Id',  datafield: 'currencyid', editable: false, width: '10%',hidden:true },
							{ text: 'Curr Type',  datafield: 'currencytype', editable: false, width: '4%',hidden:true },
							{ text: 'Rate',  datafield: 'rate', editable: false, width: '10%',hidden:true },
							{ text: 'SR No',  datafield: 'sr_no', editable: false, width: '10%' ,hidden:true},
							{ text: 'Id',  datafield: 'id', editable: false, width: '10%',hidden:true },
							
						]
            });
            
         	  var debit1="",debit2="",credit1="",credit2="";
           	  $("#postingJV").on('cellvaluechanged', function (event){
           		 var datafield = event.args.datafield;
         		 if(datafield=="debit"){	  
		         	  var debit=$('#postingJV').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
		         	  debit2=debit.sum;
		         	  debit1=debit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		         	 if(!(isNaN(debit1))){
		        		  funRoundAmt(debit1,"txtdrtotal");
		        	  }else if(isNaN(credit1)){
		        		  funRoundAmt(0.00,"txtdrtotal");
		        	  }
         		 }
         	 
         	  if(datafield=="credit"){
         	     var credit=$('#postingJV').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
         	     credit2=credit.sum;
         	     credit1=credit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	         	if(!(isNaN(credit1))){
	              	funRoundAmt(credit1,"txtcrtotal");
	         	  }else if(isNaN(credit1)){
	             	 funRoundAmt(0.00,"txtcrtotal");
	         	  }
         	    }
           	  });
        	
        });

</script>

<div id="postingJV"></div>
