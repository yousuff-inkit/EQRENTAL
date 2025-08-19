<%@page import="com.dashboard.analysis.budgetvariancenew.ClsBudgetVarianceDAO"%>
<% ClsBudgetVarianceDAO DAO= new ClsBudgetVarianceDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();%> 
<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFFFFF;
        }
</style>

 <script type="text/javascript">
 var data11,dataExcelExport11;   
 var temp='<%=branchval%>';
 if(temp!='NA'){
	   data11='<%=DAO.budgetVarianceSumGridLoading(branchval, fromDate, toDate, type, accdocno)%>';
	   dataExcelExport11='<%=DAO.budgetVariancSumExcelExport(branchval, fromDate, toDate, type, accdocno)%>'; 
 }    
	else{   
		data11;
	}
    $(document).ready(function () { 	
        
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'String'  },
                            {name : 'months', type: 'String'  },
							{name : 'actincome', type: 'number'  },
     						{name : 'inc', type: 'number' },
     						{name : 'varincome', type: 'number'  },
     						{name : 'exp', type: 'number' },
     						{name : 'actexpense', type: 'number' },
     						{name : 'varexp', type: 'number' },
     						{name : 'bporfit', type: 'number' },
     						{name : 'profit', type: 'number' },
     						{name : 'vprofit', type: 'number' }
                 ],
                 localdata: data11,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var cellclassname = function (row, column, value, data) {
           
                	if(data.rowcolor=="1"){
                    	return "orangeClass";
                    }
           
                  };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#budgetVarianceSummaryID").jqxGrid(
            {
                width: '99%',
                height: 480,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize:true,
                filterable:true,
                showfilterrow:true,  
                //pagermode: 'default',
                sortable: true,
                //Add row method      
                columns: [ 
					{ text: 'Doc No', datafield: 'doc_no', width: '8%',cellclassname:cellclassname,hidden:true },
					{ text: 'Month', datafield: 'months', width: '10%',cellclassname:cellclassname },
					{ text: 'Budget Income', datafield: 'inc', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right' },
					{ text: 'Income', datafield: 'actincome', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right'},
					{ text: 'Variance Income', datafield: 'varincome', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right'},
					{ text: 'Budget Expenditure', datafield: 'exp', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right'},
					{ text: 'Expenditure', datafield: 'actexpense', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right' },
					{ text: 'Variance Expenditure', datafield: 'varexp', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right' },
					{ text: 'Budget Profit', datafield: 'bporfit', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right'},
					{ text: 'Profit', datafield: 'profit', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right' },
					{ text: 'Variance Profit', datafield: 'vprofit', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right' },
					]                   
            });  
                 $("#overlay, #PleaseWait").hide();
               });                       
                
    </script>
<div id="budgetVarianceSummaryID"></div>
