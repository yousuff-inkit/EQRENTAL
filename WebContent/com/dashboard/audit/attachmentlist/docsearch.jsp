<%@page import="com.dashboard.audit.attachmentlist.ClsAttachmentListDAO" %>
<% ClsAttachmentListDAO card=new ClsAttachmentListDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
String type = request.getParameter("type")==null?"":request.getParameter("type");
 %> 


       <script type="text/javascript">
       var type='<%=type%>';
        var docdata='<%=card.docSearch(type)%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'dtype', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            //{name : 'branchname', type: 'string'  },
                            {name : 'brhid', type: 'string'  },
                            {name : 'status', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: docdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#docsearch").jqxGrid(
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
		                      { text: 'Doc Type', datafield: 'dtype', width: '40%',hidden:true},
                              { text: 'Doc No', datafield: 'doc_no', width: '100%' },
                            //  { text: 'BranchName', datafield: 'branchname', width: '40%' },
                              { text: 'brhid', datafield: 'brhid', width: '10%',hidden:true },
                              { text: 'status', datafield: 'status', width: '20%',hidden:true },
						]
            });
            
          $('#docsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                //document.getElementById("doctype").value=$('#docsearch').jqxGrid('getcellvalue', rowindex2, "dtype");
                document.getElementById("doc_no").value=$('#docsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("brhid").value=$('#docsearch').jqxGrid('getcellvalue', rowindex2, "brhid");
                $('#docwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="docsearch"></div>