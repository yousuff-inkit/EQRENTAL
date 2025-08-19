<%@page import="com.dashboard.audit.reviewtrialbalance.ClsReviewTrialBalance" %>
<% ClsReviewTrialBalance DAO=new ClsReviewTrialBalance();%>
<% String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
   String check = request.getParameter("check")==null?"NA":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		 data1='<%=DAO.reviewTrialBalanceGridLoading(branchval,check)%>';  
	  	}
	  	
        $(document).ready(function () {
        	
         	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'date', type: 'date' },
					{ name: 'transtype', type: 'string' },
					{ name: 'transno', type: 'string' },
                    { name: 'branchname', type: 'string' },
                    { name: 'description', type: 'string' },
                    { name: 'debit', type: 'number' },
                    { name: 'credit', type: 'number' },
                    { name: 'tr_no', type: 'int' }
	            ],
                localdata: data1,
               
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
            
            $("#reviewTrialBalanceGridId").jqxGrid(
            {
            	width: '98%',
    	        height: 360,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                columns: [
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Type', datafield: 'transtype', width: '6%' },
						{ text: 'Doc No', datafield: 'transno', width: '10%' },
	                    { text: 'Branch', datafield: 'branchname', width: '15%' },
	                    { text: 'Description', datafield: 'description', width: '39%' },
	                    { text: 'Debit', datafield: 'debit', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
	                    { text: 'Credit', datafield: 'credit', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
	                    { text: 'Tr No', datafield: 'tr_no', width: '10%',hidden: true },
					 ]
            });
            
            if(temp=='NA'){
                $("#reviewTrialBalanceGridId").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#reviewTrialBalanceGridId').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                $("#overlay, #PleaseWait").show();
                $("#reviewTrialBalanceSubGridId").jqxGrid({ disabled: false});
                $("#reviewTrialBalanceSubDiv").load("reviewTrialBalanceSubGrid.jsp?check=1&trno="+$('#reviewTrialBalanceGridId').jqxGrid('getcellvalue', rowindex1, "tr_no"));
                
            });  

        });

</script>
<div id="reviewTrialBalanceGridId"></div>
