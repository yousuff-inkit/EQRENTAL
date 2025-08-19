<%@page import="com.finance.transactions.pettycash.ClsPettyCashDAO"%>
<% ClsPettyCashDAO DAO= new ClsPettyCashDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
   
        var data1= '<%=DAO.pettyCashGridSearch(type1, accountno, accountname, currency, date,check) %>';
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
     						{name : 'type', type: 'string'  }
                        ],
                		 localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxPettyCashSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
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
							{ text: 'Rate', datafield: 'c_rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '20%' },
							{ text: 'Currency Type', datafield: 'type', hidden: true, width: '20%' },
						]
            });
            
            
            $('#jqxPettyCashSearch').on('rowdoubleclick', function (event) {
	              var rowindex1 =$('#rowindex').val();
	              var rowindex2 = event.args.rowindex;
	              $('#jqxPettyCash').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxPettyCashSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	              $('#jqxPettyCash').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxPettyCashSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	              $('#jqxPettyCash').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxPettyCashSearch').jqxGrid('getcellvalue', rowindex2, "description"));
	              $("#jqxPettyCash").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxPettyCashSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
	              $("#jqxPettyCash").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxPettyCashSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
	              $("#jqxPettyCash").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxPettyCashSearch").jqxGrid('getcellvalue', rowindex2, "type"));
	              $("#jqxPettyCash").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxPettyCashSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
	              $("#jqxPettyCash").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxPettyCashSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
				  
				    var rows = $('#jqxPettyCash').jqxGrid('getrows');
	                var rowlength= rows.length;
	                var rowindex2 = rowlength - 1;
	          	    var docno=$("#jqxPettyCash").jqxGrid('getcellvalue', rowindex2, "docno");
	          	    if(typeof(docno) != "undefined" && docno != ""){
	          	    	$("#jqxPettyCash").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
	          	    }
	          	  document.getElementById("errormsg").innerText="";
	              $('#pettyCashGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxPettyCashSearch"></div>
 