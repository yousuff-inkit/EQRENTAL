<%@ page import="com.dashboard.client.clientapproval.ClsClientApprovalDAO" %>
<% ClsClientApprovalDAO DAO=new ClsClientApprovalDAO();%>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
%>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.clientApprovalGridLoading(branchval, cldocno,check)%>'; 
	  		   var dataExcelExport='<%=DAO.clientApprovalExcelExport(branchval, cldocno,check)%>';
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'category', type: 'string' },
                    { name: 'cldocno', type: 'number' },
                    { name: 'refname', type: 'string' },
                    { name: 'per_mob', type: 'string' },
                    { name: 'sal_name', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'mail1', type: 'string' },
                    { name: 'invc_method', type: 'string' },
                    { name: 'del_charges', type: 'string' }
	            ],
                localdata: data,
               
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
            $("#clientApprovalGridID").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'checkbox',
                editable: false,
                
                columns: [
						  { text: 'Category', datafield: 'category', width: '13%' },
		                  { text: 'Name', datafield: 'refname', width: '20%' },
		                  { text: 'Client Code', datafield: 'cldocno', width: '10%' },
		                  { text: 'Mobile', datafield: 'per_mob', width: '10%' },
		                  { text: 'Salesman', datafield: 'sal_name', width: '10%' },
		                  { text: 'Address', datafield: 'address', width: '23%' },
		                  { text: 'Email Id', datafield: 'mail1', width: '13%' },
		                  { text: 'INV Method', datafield: 'invc_method', width: '6%' },
		                  { text: 'Del. Charges', datafield: 'del_charges', width: '5%' },
					 ]
            });
            
            
            $("#overlay, #PleaseWait").hide();
           

        });

</script>
<div id="clientApprovalGridID"></div>
