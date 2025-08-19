<%@page import="com.dashboard.analysis.pdcoutstanding.ClsPdcOutstanding"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsPdcOutstanding DAO= new ClsPdcOutstanding(); %>
<% String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
   String reporttype = request.getParameter("reporttype")==null?"0":request.getParameter("reporttype");
   String code = request.getParameter("code")==null?"0":request.getParameter("code");
   String accType = request.getParameter("acctype")==null?"0":request.getParameter("acctype");
   String accId = request.getParameter("accno")==null?"0":request.getParameter("accno");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<script type="text/javascript">
		var data;  
        $(document).ready(function () { 
        	 var temp='<%=branch%>';
             
     	  	 if(temp!='NA'){   
            	  data='<%=DAO.pdcOutStandingGridLoading(branch, reporttype, upToDate, code, accType, accId, check)%>';     
             } 
            
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	if(typeof(value) == "undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
                }
         	
         	var rendererstring1=function (aggregates){
                 var value1=aggregates['sum1'];
                 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
                }
         	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'branchname', type: 'string' },
							{name : 'dtype', type: 'string'  },
							{name : 'doc_no', type: 'int'  },
							{name : 'bankacno', type: 'int'  },
     						{name : 'bank', type: 'string' }, 
     						{name : 'bankname', type: 'string' },
     						{name : 'atype', type: 'string'   },
     						{name : 'acno', type: 'int'  },
     						{name : 'account', type: 'int'  },
     						{name : 'accountname', type: 'string'   },
     						{name : 'chqno', type: 'int'   },
     						{name : 'chqdt', type: 'date' },
     						{name : 'amount', type: 'number'   },
     						{name : 'brhid', type: 'int'  },
                        ],
                          localdata: data,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#pdcOutStandingGridID").jqxGrid(
            {
            	 width: '98%',
                 height: 520,
                 source: dataAdapter,
                 rowsheight:25,
                 statusbarheight:25,
                 filtermode:'excel',
                 filterable: true,
                 sortable: true,
                 selectionmode: 'singlerow',
                 showaggregates: true,
              	 showstatusbar:true,
                 editable: false,
                 columnsresize: true,

                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Branch',  datafield: 'branchname',  width: '10%' },
							{ text: 'Dtype', datafield: 'dtype', width: '5%' },
							{ text: 'Doc No', datafield: 'doc_no', width: '7%' },
							{ text: 'Bank Doc No', hidden: true, datafield: 'bankacno', width: '10%' },	
							{ text: 'Bank No.',  datafield: 'bank',  width: '5%' },
							{ text: 'Bank Name',  datafield: 'bankname',  width: '13%' },
							{ text: 'A/C Type', datafield: 'atype', width: '5%' },	
							{ text: 'A/C No', hidden: true, datafield: 'acno', width: '10%' },	
							{ text: 'A/C No', datafield: 'account', width: '5%' },
							{ text: 'Account Name', datafield: 'accountname', width: '18%' },
							{ text: 'Cheque No', datafield: 'chqno', width: '9%' },
							{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy' , width: '8%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Amount', datafield: 'amount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Branch Id',  hidden: true, datafield: 'brhid', width: '10%' },
						]
            });
            
            if(temp=='NA'){ 
         	   $("#pdcOutStandingGridID").jqxGrid('addrow', null, {});
          	  }
             
             $("#overlay, #PleaseWait").hide();
             
        });
 </script>
 <div id="pdcOutStandingGridID"></div>
    