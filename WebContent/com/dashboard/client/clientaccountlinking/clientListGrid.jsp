<%@ page import="com.dashboard.client.clientaccountlinking.ClsClientDAO" %>
<%
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
ClsClientDAO ccd=new ClsClientDAO();   
%>
 <script type="text/javascript">
var temp='<%=check%>';
 
 var data1;
 	if(temp=="load") {
	 	data1 = '<%=ccd.clientListGridLoading(check)%>';
     	var dataExcelExport='<%=ccd.clientListExcelExport(check)%>';
	}
 
 $(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             { name: 'limoacno', type: 'string' },
                             { name: 'category', type: 'string' },
                             { name: 'cldocno', type: 'number' },
                             { name: 'refname', type: 'string' },
                             { name: 'per_mob', type: 'string' },
                             { name: 'sal_name', type: 'string' },
                             { name: 'address', type: 'string' },
                             { name: 'mail1', type: 'string' },
                             { name: 'invc_method', type: 'string' },
                             { name: 'del_charges', type: 'string' },
                             { name: 'trnnumber', type: 'string' },
                             { name: 'account', type: 'number' },
                             { name: 'acc_group', type: 'string' },
                             { name: 'credit', type: 'number' },
                             { name: 'period', type: 'number' },
                             { name: 'period2', type: 'number' },
                             { name: 'taxcat', type: 'string' }
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxclGrid").jqxGrid(   
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                filterable: true,
                sortable: true,
                showaggregates:true,
                showfilterrow:true,   
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},   
                
                columns: [
						{ text: 'Client Code',  datafield: 'cldocno', width: '10%' },
						{ text: 'Account No', datafield: 'account', width: '10%' },
						{ text: 'Limo Account No', datafield: 'limoacno', width: '8%' },
						{ text: 'Account Group', datafield: 'acc_group', width: '10%' },
						{ text: 'Name',  datafield: 'refname', width: '20%' },
						{ text: 'Category', datafield: 'category', width: '13%' },
						{ text: 'Tax Category',  datafield: 'taxcat', width: '13%' },
						{ text: 'TRN No',  datafield: 'trnnumber', width: '6%' },
						{ text: 'Address',  datafield: 'address', width: '23%' },
						{ text: 'Mobile',  datafield: 'per_mob', width: '10%' },
						{ text: 'Salesman', datafield: 'sal_name', width: '10%' },
						{ text: 'Email Id', datafield: 'mail1', width: '13%' },
						{ text: 'INV Method', datafield: 'invc_method', width: '6%' },
						{ text: 'Del. Charges',  datafield: 'del_charges', width: '5%' },
						{ text: 'Credit Limit',  datafield: 'credit', width: '13%'},
						{ text: 'Credit Period', datafield: 'period', width: '6%' },
						{ text: 'Max Days',  datafield: 'period2', width: '5%' },
			       ]
			      });
			            $("#overlay, #PleaseWait").hide();
			            $('#jqxclGrid').on('rowdoubleclick', function (event) {    
			                var rowindex1 = event.args.rowindex;
			                document.getElementById("txtcldocno").value = $('#jqxclGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
			                document.getElementById("etext").innerText = $('#jqxclGrid').jqxGrid('getcellvalue', rowindex1, "refname");
			           
			            }); 
        });
    </script>
    <div id="jqxclGrid"></div>