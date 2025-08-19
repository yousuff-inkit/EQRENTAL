<%@page import="com.operations.commtransactions.travelinvoice.ClsTravelInvoiceDAO"%>
<% ClsTravelInvoiceDAO DAO= new ClsTravelInvoiceDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>  
<% String contextPath=request.getContextPath();%>  
<% String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<style type="text/css">
        .redClass
        {
            background-color: #FF4D4D/* #FFEBEB */;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
</style>

<script type="text/javascript">
		 var data1;  
		 var temp='<%=docNo%>';  
         if(temp>0){     
        	 data1='<%=DAO.journalVoucherGridReloading(session, docNo,check)%>';      
         }  
		 var rendererstring=function (aggregates){  
			 	var value=aggregates['sum'];
			 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
			 }
        $(document).ready(function () {   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'docno', type: 'int' },
     						{name : 'type', type: 'string' }, 
     						{name : 'accounts', type: 'string'   },
     						{name : 'accountname1', type: 'string'  },
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   },
     						{name : 'baseamount', type: 'number' },
     						{name : 'description', type: 'string' },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'rate', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'id', type: 'int'  },
     						{name : 'typevalid', type: 'number'  },
     						{name : 'accvalid', type: 'number'  },
     						{name : 'grtypevalid', type: 'number'  },
     						{name : 'costvalid', type: 'number'  }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var celltypeclassname = function (row, column, value, data) {
        		if (data.typevalid == '1') {
                    return "redClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellaccclassname = function (row, column, value, data) {
            	if (data.accvalid == '1') {
                    return "redClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellgrtypeclassname = function (row, column, value, data) {
            	if (data.grtypevalid == '1') {
                    return "redClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellcostclassname = function (row, column, value, data) {
            	if (data.costvalid == '1') {
                    return "redClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['GL', 'HR','AP','AR'];
            
            $("#jqxJournalVoucher").jqxGrid(
            {
                width: '99.5%',
                height: 200,
                source: dataAdapter,
                editable: false,  
                showaggregates: true,  
             	showstatusbar:true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No',  hidden: true, datafield: 'docno',  width: '5%' },
                            { text: 'Type', datafield: 'type', cellclassname: celltypeclassname, width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                               
							{ text: 'Account', datafield: 'accounts', cellclassname: cellaccclassname, editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '20%' },	
							{ text: 'Cost Type', datafield: 'costgroup', cellclassname: cellgrtypeclassname, width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%', hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', cellclassname: cellcostclassname, width: '5%',editable: false },
							{ text: 'Debit', datafield: 'debit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#jqxJournalVoucher').jqxGrid('getcellvalue', row, "credit")>0)
							         {
							              return false;
							         }}  
							},
							{ text: 'Credit', datafield: 'credit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#jqxJournalVoucher').jqxGrid('getcellvalue', row, "debit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Base Amount', datafield: 'baseamount', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '25%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Rate',  hidden: true, datafield: 'rate', editable: false, width: '10%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No',  hidden: true, datafield: 'sr_no', editable: false, width: '10%' },
							{ text: 'Id',  hidden: true, datafield: 'id', editable: false, width: '10%' },
							{ text: 'Type Valid',  hidden: true, datafield: 'typevalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Acc Valid',  hidden: true, datafield: 'accvalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Gr-Type Valid',  hidden: true, datafield: 'grtypevalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Cost Vaild',  hidden: true, datafield: 'costvalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							
						]
            });
        });
</script>
<div id="jqxJournalVoucher"></div>