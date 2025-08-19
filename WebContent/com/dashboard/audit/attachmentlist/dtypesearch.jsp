<%@page import="com.dashboard.audit.attachmentlist.ClsAttachmentListDAO" %>

<% ClsAttachmentListDAO card=new ClsAttachmentListDAO();%>
<%String type = request.getParameter("type")==null?"0":request.getParameter("type");%>



       <script type="text/javascript">
  var type='<%=type%>';
  //alert(type);
       var dtypedata='<%=card.dtypeSearch(type)%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'dtype', type: 'string'  },
                            {name : 'status', type: 'string'  }
                        ],
                		
                		//  url: url1,
                 localdata: dtypedata ,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#dtypesearch").jqxGrid(
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
							
			
                              { text: 'Doc Type', datafield: 'dtype', width: '100%' },
                              { text: 'status', datafield: 'status', width: '10%',hidden:true },
						
						]
            });
            
          $('#dtypesearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("doctype").value=$('#dtypesearch').jqxGrid('getcellvalue', rowindex2, "dtype");
           
              $('#dtypewindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="dtypesearch"></div>