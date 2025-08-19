<%@page import="com.dashboard.audit.reviewtrialbalance.ClsReviewTrialBalance" %>
<% ClsReviewTrialBalance DAO=new ClsReviewTrialBalance();%>
<% String trno = request.getParameter("trno")==null?"NA":request.getParameter("trno").trim();
   String check = request.getParameter("check")==null?"NA":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data2;
      var temp1='<%=trno%>';
      
	  	if(parseInt(temp1)>0){ 
	  		 data2='<%=DAO.reviewTrialBalanceSubGridLoading(trno,check)%>';  
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
                    { name: 'account', type: 'string' },
                    { name: 'description', type: 'string' },
                    { name: 'debit', type: 'number' },
                    { name: 'credit', type: 'number' },
                    { name: 'reason', type: 'string' }
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
            
            $("#reviewTrialBalanceSubGridId").jqxGrid(
            {
                width: '98%',
                height: 145,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                columns: [
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '7%' },
						{ text: 'Type', datafield: 'transtype', width: '8%' },
						{ text: 'Doc No', datafield: 'transno', width: '8%' },
	                    { text: 'Branch', datafield: 'branchname', width: '15%' },
	                    { text: 'Account', datafield: 'account', width: '7%' },
	                    { text: 'Description', datafield: 'description', width: '20%' },
	                    { text: 'Debit', datafield: 'debit', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
	                    { text: 'Credit', datafield: 'credit', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
	                    { text: 'Reason', datafield: 'reason', width: '15%' }
					 ]
            });
            
            if(temp=='NA'){
                $("#reviewTrialBalanceSubGridId").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();

        });

</script>
<div id="reviewTrialBalanceSubGridId"></div>
