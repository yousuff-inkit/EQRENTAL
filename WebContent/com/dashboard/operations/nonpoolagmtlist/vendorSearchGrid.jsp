<%@ page import="com.dashboard.operations.nonpoolagmtlist.*" %>
<% ClsNonPoolAgmtListDAO cad=new ClsNonPoolAgmtListDAO(); 
	String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var vendordata=[];
if(id=="1"){
	vendordata='<%=cad.getVendorData(id)%>';
}
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'refname', type: 'string'  },
                            {name : 'cldocno', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: vendordata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#vendorSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'cldocno', width: '20%',hidden:true},
                              { text: 'Name', datafield: 'refname', width: '100%' },
                           
						
						
	             
						]
            });
            
          $('#vendorSearchGrid').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("clientname").value=$('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex2, "refname");
                document.getElementById("cldocno").value=$('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex2, "cldocno");
  
                
                
              $('#clientwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="vendorSearchGrid"></div>