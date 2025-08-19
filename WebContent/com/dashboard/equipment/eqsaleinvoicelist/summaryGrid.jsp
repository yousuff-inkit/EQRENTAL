<%@page import="com.dashboard.equipment.eqsaleinvoicelist.ClsEqSaleInvoiceListDAO"%>
<%ClsEqSaleInvoiceListDAO DAO= new ClsEqSaleInvoiceListDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
//     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
   %>
     <% String contextPath=request.getContextPath();%>
<script type="text/javascript">
      var data2;
      var summaryexceldata;
      var temp='<%=check%>';
     <%--  var temp1='<%=type%>'; --%>
    //  alert(temp);   
	  	if(temp!='0'){ 
	  		   data2='<%=DAO.summary(branchval, fromDate, toDate,check)%>';
	  		 <%-- summaryexceldata='<%=DAO.summaryexcel(branchval, fromDate, toDate)%>'; --%>
	  	}
	  	var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	if(value=="undefined" || typeof(value)=="undefined"){
         		value=0;
         	}
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
    	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no' , type: 'int' },
							{name : 'date' , type: 'date' },
							{name : 'client' , type:'string'},
							{name : 'desc' , type:'string'},
							{name : 'type' , type:'string'},
							{name : 'total' , type:'number'},
							{name : 'currency' , type:'string'},
							{name : 'currate' , type:'string'},
							{name : 'brhid' , type:'string'},

					      ],
                          localdata: data2,
               
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
            $("#summary").jqxGrid(
            {
                width: '98%',
                height: 550,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: false,
                selectionmode: 'singlerow',
                editable: false,
                enabletooltips:true,
                showfilterrow:true,
            	showaggregates:true,
                showstatusbar:true,

                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no',  width: '6%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '7%' },
							{ text: 'Branch',  datafield: 'brhid',   width: '10%'  },
							{ text: 'Client',  datafield: 'client' },
							{ text: 'Description',  datafield: 'desc',  width: '27%' },
							{ text: 'Type',  datafield: 'type',   width: '7%'  },
							{ text: 'Currency',  datafield: 'currency',   width: '7%'  },
							{ text: 'Rate',  datafield: 'currate',   width: '7%'  },

							{ text: 'Total', datafield:'total', width:'8%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							
						 ]
            });
            
            if(temp=='NA'){
                $("#summary").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
           

        });

</script>
<div id="summary"></div>
