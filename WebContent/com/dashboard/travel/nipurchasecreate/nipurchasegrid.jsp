<%@ page import="com.dashboard.travel.nipurchasecreate.ClsNiPurchaseCreateDAO" %>  
<%ClsNiPurchaseCreateDAO DAO=new ClsNiPurchaseCreateDAO(); %>        
 <%
   String id = request.getParameter("id")==null?"0":request.getParameter("id");
 %>
 <script type="text/javascript">
 var data,dataexcel; 
	  data='<%=DAO.nipurchasedata(id)%>';              
	  $(document).ready(function () {             
            var num = 0;   
            var source = 
            {
                datatype: "json",    
                datafields: [
                 				{name : 'brhid', type: 'String'  },     
	                            {name : 'doc_no', type: 'String'  },
	                  			{name : 'voc_no', type: 'String'  },
	      						{name : 'date', type: 'date'},
	      						{name : 'type', type: 'String'  },
	      						{name : 'acno', type: 'String'  },
	      						{name : 'delterm', type: 'String'  },
	      						{name : 'payterm', type: 'String'  },
	      						{name : 'deldate', type: 'date'  },
	      						{name : 'desc1', type: 'String'  },
	 							{name : 'accname', type: 'String'  },
	 							{name : 'netamt', type: 'number'  },
                          	],
                          	localdata: data,  
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#jqxnipurchasegrid").jqxGrid(
            { 
            	width: '100%',
                height: 260,  
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                sortable:true,
                selectionmode: 'singlerow',
                enabletooltips: true,
                pagermode: 'default',
                editable:false,
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                            
                            { text: 'Doc no', datafield: 'voc_no', width: '5%'},      
							{ text: 'brhid', datafield: 'brhid', width: '4%',hidden:true },
							{ text: 'Doc no', datafield: 'doc_no', width: '4%',hidden:true },
							{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},                   
							{ text: 'Acc.No', datafield: 'acno', width: '5%'}, 
							{ text: 'Vendor', datafield: 'accname'},     
							{ text: 'Del Term', datafield: 'delterm', width: '15%' ,hidden:true },    
							{ text: 'Del Date', datafield: 'deldate', width: '6%' ,hidden:true ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Pay Term', datafield: 'payterm', width: '15%',hidden:true  },
							{ text: 'Description', datafield: 'desc1', width: '25%' }, 
							{ text: 'Net Amount', datafield: 'netamt', width: '7%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right' },                          
							{ text: 'Acc.Type', datafield: 'type', width: '5%',hidden:true},       
					]       
            });   
            $('#jqxnipurchasegrid').on('rowdoubleclick', function (event) {     
  		        var datafield = event.args.datafield;      
  		        var rowindextemp = event.args.rowindex;       
  		        var docno=$('#jqxnipurchasegrid').jqxGrid('getcellvalue',rowindextemp, "doc_no");
  		        document.getElementById("hidbrhid").value=$('#jqxnipurchasegrid').jqxGrid('getcellvalue',rowindextemp, "brhid");     
  		        document.getElementById("docno").value=$('#jqxnipurchasegrid').jqxGrid('getcellvalue',rowindextemp, "doc_no");
              	document.getElementById("accname").value=$('#jqxnipurchasegrid').jqxGrid('getcellvalue',rowindextemp, "accname");
              	document.getElementById("accno").value=$('#jqxnipurchasegrid').jqxGrid('getcellvalue',rowindextemp, "acno");
              	document.getElementById("acctype").value=$('#jqxnipurchasegrid').jqxGrid('getcellvalue',rowindextemp, "acctype");
              	document.getElementById("netamt").value=$('#jqxnipurchasegrid').jqxGrid('getcellvalue',rowindextemp, "netamt");
                $("#descdiv").load("descgridDetails.jsp?nipurdoc="+docno+"&id=1");     
            }); 
        });      
    </script>
    <div id="jqxnipurchasegrid"></div>         