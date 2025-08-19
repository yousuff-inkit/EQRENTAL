<%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>         
<%  ClsTravelDAO DAO=new ClsTravelDAO(); %>
<%  
     String rdocno = request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").trim();
     String check = request.getParameter("check")=="" || request.getParameter("check")==null?"0":request.getParameter("check").trim();
%>
<style>
.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {
    background-color: orange;
    background-image: none
}
</style>  
<script type="text/javascript">   
        var data2;  
	  	data2='<%=DAO.subgriddata(rdocno,check)%>';      
        $(document).ready(function () {
        	var source =
            {
                datatype: "json",
                datafields: [
		                      {name : 'rowno', type: 'string'  },    
							  {name : 'name', type: 'string'  },
							  {name : 'total', type: 'number'  },  
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
            $("#jqxpricedet").jqxGrid(
            {
                width: '100%',
                height: 140,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,                                     
                selectionmode: 'singlerow', 
                editable: false,
                localization: {thousandsSeparator: ""},                  
                
                columns: [       
                  		{ text: 'rowno', datafield: 'rowno',hidden:true},    
                  		{ text: 'Name', datafield: 'name'},
						{ text: 'Total', datafield: 'total', width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' },
					 ]                                             
            });
            $("#overlay, #PleaseWait").hide();
            //$("#jqxpricedet").jqxGrid('addrow', null, {}); 
        });  

</script>
<div id="jqxpricedet"></div>