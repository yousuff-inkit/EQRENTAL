<%@ page import="com.dashboard.audit.newdb.NewDb" %>
<% NewDb DAO=new NewDb(); %>
<% String check=request.getParameter("check")==null?"":request.getParameter("check").trim();%>
       <script type="text/javascript">
  
	    var formdata='<%=DAO.getForm(check)%>'; 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'menu', type: 'string'  },
                            {name : 'tables', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: formdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#formSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'tables', datafield: 'tables', width: '20%',hidden:true},
                              { text: 'Form', datafield: 'menu', width: '100%' },
						]
            });
            
          $('#formSearchGrid').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtformname").value=$('#formSearchGrid').jqxGrid('getcellvalue', rowindex2, "menu");
                var tab=$('#formSearchGrid').jqxGrid('getcellvalue', rowindex2, "tables").split(",");
                tab.forEach(myFunction);
                
               

                
               $('#formSearch').jqxWindow('close'); 
            }); 
        });
		 function myFunction(value) {
         	// $('#reqtablelistGrid').addrow(value); //,"sr_no":""
         	 $("#reqtablelistGrid").jqxGrid('addrow', null, {"tablename": value});
         }
    </script>
    <div id="formSearchGrid"></div>