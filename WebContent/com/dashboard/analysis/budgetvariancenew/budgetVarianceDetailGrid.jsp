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
         .violetClass
        {
           background-color:#F8C4AA;  
        }
         .greyClass
        {
           background-color:#CAB6FD;
        }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){
	  		   data='<%=DAO.budgetVarianceGridLoading(branchval, fromDate, toDate, type, accdocno)%>';
			   var dataExcelExport='<%=DAO.budgetVarianceExcelExport(branchval, fromDate, toDate, type, accdocno)%>';
	  	}
	  	
  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum']/2;  
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	     
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'acno' , type: 'int' },   
							{name : 'account' , type:'string'},
							{name : 'accountname' , type:'string'},
							{name : 'budgetamount' , type:'number'},
							{name : 'actualamount' , type:'number'},
							{name : 'varianceamount',type:'number'},
							{name : 'gr_type' , type:'string'},
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	    
        	var cellclassname = function (row, column, value, data) {
        	   if (data.gr_type=='5' && data.accountname!='INCOME') {
        			 return "redClass";
                } else if (data.gr_type=='4' && data.accountname!='EXPENSE') {
                    return "yellowClass";  
                }   else  if (data.gr_type=='5' && data.accountname=='INCOME') {     
                    return "greyClass";       
                } else if (data.gr_type=='4' && data.accountname=='EXPENSE') {
                	 return "violetClass";   
                } 
                else{
                	return "whiteClass";    
                };   
            };
              
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#budgetVarianceDetailGridID").jqxGrid(
            {
                width: '98%',     
                height: 480,
                source: dataAdapter,
                filterable:true,
                showfilterrow:true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Acno', datafield: 'acno', cellclassname: cellclassname, width: '6%', hidden: true },
							{ text: 'Account',  datafield: 'account',  cellclassname: cellclassname, width: '10%' },
							{ text: 'Account Name',  datafield: 'accountname', cellclassname: cellclassname, width: '45%' },
							{ text: 'Forecast',  datafield: 'budgetamount', cellclassname: cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right', width: '15%',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Actual',  datafield: 'actualamount', cellclassname: cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right', width: '15%',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Variance',  datafield: 'varianceamount', cellclassname: cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right', width: '15%',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Grtype',  datafield: 'gr_type',  cellclassname: cellclassname, width: '10%', hidden: true },
							]      
            });
            
            if(temp=='NA'){
                $("#budgetVarianceDetailGridID").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
           /*  var budgetamount1="";var actualamount1="";var netamount="";
            var budgetamount=$('#budgetVarianceDetailGridID').jqxGrid('getcolumnaggregateddata', 'budgetamount', ['sum'], true);
            budgetamount1=budgetamount.sum;
            var actualamount=$('#budgetVarianceDetailGridID').jqxGrid('getcolumnaggregateddata', 'actualamount', ['sum'], true);
            actualamount1=actualamount.sum;
            if(!isNaN(budgetamount1 || actualamount1)){
            	netamount= parseFloat(budgetamount1) - parseFloat(actualamount1);
      		    funRoundAmt(netamount,"txtnetvarianceamount");
      		  }
      		else{
      			funRoundAmt(0.00,"txtnetvarianceamount");
		    }  */
        });

</script>
<div id="budgetVarianceDetailGridID"></div>
