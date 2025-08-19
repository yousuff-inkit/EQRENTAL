<%@page import="com.finance.transactions.taxdbtnote.ClsTaxDebitNoteDAO"%>
<% ClsTaxDebitNoteDAO DAO= new ClsTaxDebitNoteDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
String cdate = request.getParameter("creditdate")==null?"0":request.getParameter("creditdate").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check"); 
String txtcmtype = request.getParameter("txtcmtype")==null?"0":request.getParameter("txtcmtype"); 
%>  

<script type="text/javascript">
   
        var data1= '<%=DAO.debitNoteGridSearch(type1, accountno, accountname, currency, date, check,cdate,txtcmtype  ) %>';
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'curr', type: 'string'  },  
     						{name : 'curid', type: 'int'  },
     						{name : 'gr_type', type: 'int'  },
     						{name : 'c_rate', type: 'number'  },
     						{name : 'tax', type: 'number' },
     						{name : 'taxaccnt', type: 'string' },
     						{name : 'type', type: 'string'  }
                        ],
                		 localdata: data1, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDebitNoteSearch").jqxGrid(
            {
            	width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '40%' },
							{ text: 'Currency', datafield: 'curr', width: '20%' },
							{ text: 'Currency ID', datafield: 'curid',  hidden:true, width: '20%' },
							{ text: 'Group Type', datafield: 'gr_type', hidden: true, width: '10%' },
							{ text: 'Tax', datafield: 'tax', width: '10%' },
							{ text: 'Tax Account', datafield: 'taxaccnt', width: '10%' },
							{ text: 'Rate', datafield: 'c_rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '20%' },
							{ text: 'Currency Type', datafield: 'type', hidden: true, width: '20%' },
						]
            });
            
            $('#jqxDebitNoteSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                var rowindex3 = event.args.rowindex;
                
                $('#jqxDebitNote').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxDebitNoteSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#jqxDebitNote').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxDebitNoteSearch').jqxGrid('getcellvalue', rowindex2, "account"));
                $('#jqxDebitNote').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxDebitNoteSearch').jqxGrid('getcellvalue', rowindex2, "description"));
                $("#jqxDebitNote").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxDebitNoteSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
                $("#jqxDebitNote").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxDebitNoteSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
                $("#jqxDebitNote").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxDebitNoteSearch").jqxGrid('getcellvalue', rowindex2, "type"));
                $("#jqxDebitNote").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxDebitNoteSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
                $("#jqxDebitNote").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxDebitNoteSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
                $("#jqxDebitNote").jqxGrid('setcellvalue', rowindex1, "tax" ,$("#jqxDebitNoteSearch").jqxGrid('getcellvalue', rowindex2, "tax"));
				
                var rows = $('#jqxDebitNote').jqxGrid('getrows');
                var rowlength= rows.length;
                var rowindex2 = rowlength - 1;
                document.getElementById("taxaccount").value=$("#jqxDebitNoteSearch").jqxGrid('getcellvalue', rowindex3, "taxaccnt");
          	    var docno=$("#jqxDebitNote").jqxGrid('getcellvalue', rowindex2, "docno");
          	    if(typeof(docno) != "undefined" && docno != ""){
          		  $("#jqxDebitNote").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","sr_no":"","currencytype": "","tax": "","taxamount": "","nettotal": ""});
          	    }
				
				$('#debitNoteGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxDebitNoteSearch"></div>
 